Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78562C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BDF205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t8TgO0OS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BDF205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbeGLEdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 00:33:40 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40236 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeGLEdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 00:33:39 -0400
Received: by mail-pf0-f193.google.com with SMTP id e13-v6so6415571pff.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 21:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L7ce5e8H2hDps7AIJdMSi/39d7gTuXThtfJH9Sk9dS8=;
        b=t8TgO0OSerK7UsSZiNCg6avmc+2qM7GBIviTJT6vIt/X4Yn+op64lbtB1zZRIR73qL
         PQ/I+sB6qsvKmeTn5G4Xb0BBEgIXaj51xKgBoPyq6Z3roegw0kqInkEkZV8xz3UUKjnG
         KzdW9ELSKlTHhtxW2wgIyHiki7mJ8+JLfztoamEaTp8pwAd8cnGZmjxBSoYWFd+6cTAF
         J7pcgNc0iMEJO9c8u7v1j4Tr7gsVPox1Quk+JT98RHhYEOMWqz69Rj6XDcfeQN9IMmvQ
         D92sFKZNVcSJMfkXPFVTDq8ct7oUao76UGPvs2BGXlv1Xlby9NO8OomEZ/w7q0myj09u
         7grA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L7ce5e8H2hDps7AIJdMSi/39d7gTuXThtfJH9Sk9dS8=;
        b=cHWsy+DUr1ruz7xv5tSQxAUr4Wl6mz5JM1v6vGofvxj+BUUHnloThHjB3CW1tgo+Dh
         8l1DbPPTPfMG1c9gJRclxmoKwEV7l5xjhj6RstCyADNjS9+aQZ3cnJpWZ6L0YM5bTUM7
         pbBWAXh58Kw9jXCL4irbbpX4t4rafxEcTFTZYibOnInweSUzMBd+Tyanf3yGDcGUS9oU
         /7NWMpYO5K0gDF1cwzzdkhsMSyPPKqJdys/CWxYlbhtylcUu3fMkzkRSViE7lNHZUfTy
         ajJMYiWhM5U82t2aYsEXEtZ96PFim/GDeyNvW48fesixtFzjdx8tWk0iHqW59PdUwppa
         3FgQ==
X-Gm-Message-State: AOUpUlHoGY292u7eLbtv6aqC1n+F8B3UxFrvCc5JmzBhOK5AVUMreDXQ
        zqS5BSO8H66Z76o3d6iA6Uo=
X-Google-Smtp-Source: AAOMgpeHvnAtFryCcMbc4/a4Pdd3/Ac5pMu1iVow4KAq1kBDiDQil54uBcgmKblMIujMsxBOIZldxw==
X-Received: by 2002:a63:5a5e:: with SMTP id k30-v6mr633453pgm.123.1531369557316;
        Wed, 11 Jul 2018 21:25:57 -0700 (PDT)
Received: from localhost ([175.223.26.85])
        by smtp.gmail.com with ESMTPSA id t186-v6sm5002841pgd.77.2018.07.11.21.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 21:25:55 -0700 (PDT)
Date:   Thu, 12 Jul 2018 13:25:52 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] console: Replace #if 1 with a bool to ignore
 WARN_CONSOLE_UNLOCKED()
Message-ID: <20180712042552.GB663@jagdpanzerIV>
References: <20180711151755.613eba3c@gandalf.local.home>
 <20180712015848.GA663@jagdpanzerIV>
 <20180711230912.2575fae1@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711230912.2575fae1@vmware.local.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/11/18 23:09), Steven Rostedt wrote:
> > On (07/11/18 15:17), Steven Rostedt wrote:
> > > +bool ignore_console_lock_warning __read_mostly;
> > > +EXPORT_SYMBOL(ignore_console_lock_warning);  
> > 
> > OK. So, to recap,
> > We made is_console_locked() EXPORT_SYMBOL recently [it's still in linux-next],
> > so people could use WARN_CONSOLE_UNLOCKED in more places; this made other
> > people unhappy, so now we add another EXPORT_SYMBOL to the picture, which will
> > disable those newly added WARN_CONSOLE_UNLOCKED and make other people happy
> > again.
> 
> Note, it only made people that added a module parameter that disables
> grabbing the console lock in the first place for debugging purposes
> only. The added WARN_CONSOLE_UNLOCKED() are good. Nobody complaining
> that they exist. They are complaining that it breaks one of their
> debugging work flows, and need to disable it when they are doing so.

True, but at the same time nobody complained that we didn't have those
extra WARN_CONSOLE_UNLOCKED()-s. Just saying. Over all I agree that there
is probably some value in those extra WARN-s.

> I could add a comment explaining why it exists. Something like:
> 
> /*
>  * Set this is you need to quiet WARN_CONSOLE_UNLOCKED() for debugging
>  * purposes.
>  */

s/is you/if you/

Suggested-by: One-of-those-commiters@YouKnowWhoYouAre.org ;)

	-ss
