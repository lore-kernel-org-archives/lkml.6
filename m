Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE02C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F2120851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1ysleMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F2120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeLMCTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:19:32 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:44033 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeLMCTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:19:31 -0500
Received: by mail-pf1-f179.google.com with SMTP id u6so265155pfh.11;
        Wed, 12 Dec 2018 18:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iuKbwuI7ax9j8vklsGI+FwnpZkLXaH6aVKIbSsViT0I=;
        b=B1ysleMXW1qcISFGIfQd8iNHklE0+uyxogpdrsJMdbzUrQQu6D8lNKMVyna97lFBbZ
         H8R/r2IJJXnt3UzvI4rsY5DR6qoPGeCzFtl8Q/dPw3lMIBW9UQLSDdZs8/3cvXKj5vKo
         SvT4vdFD+HO3kq2YSfTIHaB1EdrpSQgGWgtFN91dinvhUTIckiI7VsdaAzhC75wnTuu4
         rQMDEdE+PNmjKXMuqYHtY7IIVBCvMjoqzS10aqxwUoJOQNmHoPLR6+4v5diAvaF+Frfm
         jAM4InXDtL+LmRrU1FejzXH48yQ7akQoBgoLKtQsFNSpc7cVmqsAjEXpL1p11KZdowyB
         jSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iuKbwuI7ax9j8vklsGI+FwnpZkLXaH6aVKIbSsViT0I=;
        b=rPQfzru586xvLVoLKBAegFmDkttvqTfuTct+awdR2io4BPN65y/rUWk6UmdkQ5ugAC
         E3PX4EtSWnKWG9SENFW1lavPNVf+ShyrcaeP8bQpoXhMfxUbDGoYMSOGqcEk6QuD5ES1
         pGl44cCzNa2/BCpCK1KFtHCqyUzI4GjnPz4JGjy5D3l1yGPwGQOyrEANXuOlmg7BKzzv
         g43Sc31yOhYnLbQ7mRhGZe2I8ij4B4E+0pHP5TfJ6MjRgPVX5ACVDPuekCCGMtT/tWKU
         uZ1R1XT2K+/dj+dQbL9Or9ClpCf8+AYhpo33EZ42ZfNt7jQkezZaY3y0VHO/ev7C0hdA
         jNHQ==
X-Gm-Message-State: AA+aEWYpRFuXiEySsFF1ytQfDzr/QcerrE1G4G0CYnmtWDKXV26tpnMQ
        XZghHrfBFZ2sZ6YL9VsxgXc=
X-Google-Smtp-Source: AFSGD/XGjEP8npxxbhZHwo83wjBzS7ltiuGTG7A5s7ajul2A3CjgQLqO0/UwrdpmH6yVEgdV8IcbVQ==
X-Received: by 2002:a63:ba4d:: with SMTP id l13mr891173pgu.194.1544667571017;
        Wed, 12 Dec 2018 18:19:31 -0800 (PST)
Received: from localhost ([110.70.59.213])
        by smtp.gmail.com with ESMTPSA id i1sm373292pgb.46.2018.12.12.18.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 18:19:30 -0800 (PST)
Date:   Thu, 13 Dec 2018 11:19:26 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jiri Slaby <jslaby@suse.cz>,
        kernel test robot <rong.a.chen@intel.com>, lkp@01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [LKP] [tty] c96cf923a9:
 WARNING:possible_circular_locking_dependency_detected
Message-ID: <20181213021926.GC4860@jagdpanzerIV>
References: <20181211091154.GL23332@shao2-debian>
 <b8a5b151-9eaa-b098-f24f-b17c1886f456@suse.cz>
 <2780774e-b397-dcc2-6950-cccb527d5014@arista.com>
 <20181212034252.GD431@jagdpanzerIV>
 <137479ad-d38e-7d26-dae4-a4e721d69928@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <137479ad-d38e-7d26-dae4-a4e721d69928@arista.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/12/18 14:54), Dmitry Safonov wrote:
> > In this particular case we probably can just move free_page()
> > out of uart_port lock scope. Note that free_page()->MM can printk()
> > on its own.
> > 
> > 
> > Something like this (not tested):
> 
> Looks good to me.
> Probably, it's worth to update comment about freeing just to make sure
> no one will "refactor"/"simplify" it some day.
> 
> Does it make sense to add this to your patch?

Makes perfect sense, thanks! I'll send a patch a bit later.

	-ss
