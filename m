Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665B8C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109222064D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqWgTPRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109222064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934019AbeGCQgm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:36:42 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44409 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932392AbeGCQgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:36:40 -0400
Received: by mail-pg0-f67.google.com with SMTP id r1-v6so1216956pgp.11;
        Tue, 03 Jul 2018 09:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gejCrzA35vOpXUvAyajavr7FlSUaBBvZcm1dGouDZIM=;
        b=jqWgTPRZIZ82JPY/zwXc1LrJcTyEXmSxw1EJYBrPu4T50IPHFaduP0EjhHZlGAkLbE
         sdcdw5o7Ujugf0OnbCBwJiDjIOC3hihChaGUB8pbuBI2j8lAbRAOsZVhiPHjr3/pVq0Z
         UuuPNTtydBl13izUg3m8HiCJJMnjKy2eNRLpfUuwOf2Z1NMDCyUi/NAb7BpxSJLS2cIS
         mV19VHnNU+aBT4h4I22CJ1QgzWJdN3mhhuQ0xlUWVAK17z8Ifvo9lLLcb1u41hEAE/m8
         6wpLFVixQx9DS05TepRVdJe95FzbejprbvgH4pVANlEu4tIzbamTH7QwP6leywFRvsEn
         p8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gejCrzA35vOpXUvAyajavr7FlSUaBBvZcm1dGouDZIM=;
        b=hfX3EfPPTMW0/YtaAV4Mut6s/kT8/r1nUKvresdZMExjQtrJzphS4JbN6UOuHZ0s68
         teEhWXb2eJywLgwhxiHikXwQU7UWp6uhP4k8aAv2950dYHMgQnSFsrKZ9ttDRabjt0gs
         AH9xcVKWpXui54wVpn2FEL2srz/gVTda7mMLLMGg5SwIEfp5LPkXTw0B0+6O1ZWCDH0f
         v6ABCcJrPmH063+Jp9JJTpAifB5u1qEj/7P5iICN6mOEBnSSOSvrIMI2brsVP9aeLLUv
         69+uAQZ22r7n2KYZ6XMT/s9sdj2mj7YkQY4wMM4M3nNI8MlINAVVJbrPWONYruzuZ8wW
         d6+g==
X-Gm-Message-State: APt69E0vooFaWf0royItaPrshdEiD+Xm1rFNppRQnGtckdKhvgCk+DE8
        ac4qYFNJAGl8DZ21rz2XZq0=
X-Google-Smtp-Source: ADUXVKLsbg0R2bfyr4yuNjWmBgfx4RkEBVujHOwKlxMkNAugTlORRJ87fqiuVe2p2j5BPwCNZqYMQQ==
X-Received: by 2002:a63:bc0a:: with SMTP id q10-v6mr26168506pge.70.1530635800030;
        Tue, 03 Jul 2018 09:36:40 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id 77-v6sm6644376pga.40.2018.07.03.09.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 09:36:39 -0700 (PDT)
Date:   Wed, 4 Jul 2018 01:36:36 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] console/fbcon: Add support for deferred console
 takeover
Message-ID: <20180703163636.GC391@tigerII.localdomain>
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-4-hdegoede@redhat.com>
 <20180703161327.GA391@tigerII.localdomain>
 <20180703121429.283faef0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703121429.283faef0@gandalf.local.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/03/18 12:14), Steven Rostedt wrote:
> > Can we please default this to 'n'?
> >
> 
> No explicit default means 'n'. You don't need to specify it.

Ah, OK. Thanks.

	-ss
