Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13947C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A8F21534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWA7g56+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A8F21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbeIUEAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:00:32 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35517 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeIUEAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:00:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id x20-v6so9767796lfg.2;
        Thu, 20 Sep 2018 15:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z770HlOYnuiuFaHvQ7YcAaglZJGe3WPohVkcbEsuZj8=;
        b=fWA7g56+dE/Q2Oe0epHkEsTiY9EMGcf+zL72gsAslRb1M5ee1o//C5htGdSeF34uNY
         OPCXA5ycGxDBB2cnWzG9+PKMN/fXA6/mGdRQ7gckZ8lWSENZMwke+FUB+OWNEAtUw8hd
         Ic4M2/GeJU33BQrYRvDgKNqqSa6vYisND7ClJ7RTx75LWIIE5w3sYAu8UHVH3nK/Ykdl
         kbPUPcMJqlSjdaVH8vqHPiE7MlFC20SXiNPmVINTKumpg27c769VKdHhFF20wAhw/iwu
         GsyQzNvLdjRj+hL27f7YygDVg2Ird6k6IPdj/QUkFyZk0PzVUAbHXwx/sHK0WWQhjKxr
         3E6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z770HlOYnuiuFaHvQ7YcAaglZJGe3WPohVkcbEsuZj8=;
        b=TS/TuXRruVKO4KQibkhhENQ8SLqdTXO8VJPHwP8k2vugti9ftobezCoSccqyyqgDTX
         GnyxBg9NI9jjLepYPaquJnR2NlaW78vjyh7ctMCwvWThlfclH7Z7yLL8Pg7dTtmCPwwZ
         A7rySEOTJyZtc6hCC8xIyVeQ0NuXK69+7gY82XWvQWR1XdUJT4swPoBMHToB8xkO/KnV
         hnUHmyK183IRKSgFb0XptOwENxhcMTBxgPMSw5d2LL+H9BGiV/pqDlJ2EjJ0nR/woUjM
         nbOg1vqaqarx+x2w2imkodvab8l82XHgp//Rc5rYFDhW+IDWBZT1tibGq6UPYSBsIcuG
         BWIA==
X-Gm-Message-State: APzg51AKrjTe28cfcox62F2yx2wzx2odq1HRdaqEc8ZB9hzgwBsSjXKr
        IBNXrfXqLfcrVxUO9w94SHw=
X-Google-Smtp-Source: ANB0VdYxLGc8hbaomQ1RDPzf2t2X33+yNziG9R5lPvmQn/O+DbTDP9r+c18HRG/eQ0w8UEuMZNRCJQ==
X-Received: by 2002:a19:f00a:: with SMTP id p10-v6mr10028357lfc.43.1537481690022;
        Thu, 20 Sep 2018 15:14:50 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id y16-v6sm4684450lje.30.2018.09.20.15.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 15:14:49 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id C7AE6460674; Fri, 21 Sep 2018 01:14:48 +0300 (MSK)
Date:   Fri, 21 Sep 2018 01:14:48 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC 02/20] timens: Add timens_offsets
Message-ID: <20180920221448.GE20786@uranus>
References: <20180919205037.9574-1-dima@arista.com>
 <20180919205037.9574-3-dima@arista.com>
 <20180920184510.GC20786@uranus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920184510.GC20786@uranus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 09:45:10PM +0300, Cyrill Gorcunov wrote:
> On Wed, Sep 19, 2018 at 09:50:19PM +0100, Dmitry Safonov wrote:
> > From: Andrei Vagin <avagin@openvz.org>
> > 
> > Introduce offsets for time namespace. They will contain adjustment
> > needed to convert clocks to/from host's.
> > 
> > Allocate one page for each time namespace that will be premapped into
> > userspace with vvar pages.
> 
> Is not it too much?! The whole page per each clone(new-time-ns) call.
> Moreover everytime it is get explicitly zeroifyed. Don't get me wrong,
> maybe I miss something obvious, but additional 4K per process, guys :)

After being talking to Andrew I think there is no better option though.
If syscalls would be free of course we could use them instead but this
vdso stuff, sigh. I thouhgh about modifying vdso code so it would carry
refs inside (or adding some section into elf loader kernel code), but
all this would simply mess the code. Thus this 4K per namespace seems
to be acceptable trade off.
