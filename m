Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GUARANTEED_100_PERCENT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C435FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696C32082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaNLW3R1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696C32082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeJYPTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:19:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41573 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeJYPTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 11:19:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id a19-v6so3695606pfo.8;
        Wed, 24 Oct 2018 23:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mMryRUaVaiAa++Iu7e/9dL7uBfQZUysOLKyMn5oKodI=;
        b=jaNLW3R1JSUcTXcxp37rGha31ZJQWIA6s2Hx+OgTI8yLPueGq+DtZoHHPyI24NJ6vU
         02wXpjt5M6/NGQTLX0vIEgd3WWdzr3oNX/YtCFwcyTSCxffh9kvFTQaTMqJCThQtmFaw
         83uPfZx9wtHtIk87AOU+Y2slrSNHEjWo9Nl5188KGJIvFAnpXUDCE8etrKrlH0L0334Y
         45I3kDI4mpk28avxAIHFR1Z4mjqOEZZfL/y9vM/xa62nNJPRaZg3GcN21oytut5xWvmI
         zjDCXFdBPsBzL2Z8nvqB0XU/3fRNMGdGj7IO/8NT56i9jSJXvfCQ0AXOvqN6X9TO9wHY
         wT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mMryRUaVaiAa++Iu7e/9dL7uBfQZUysOLKyMn5oKodI=;
        b=Rmqc7TEotNRkagxfhlREr/Q5mTCbEihqx02BUJxJFsS3DOZiBduAPnI1oHUkS+COPW
         D0Bd4GFS0bAMZqsrb4nvd8kvC8IM0IGeSMq3VZ/tRnR7Q2lpkxqDDRwp9Hcf/Gd8mx9j
         RG9iUC2+cS73ALE9GyH2DW96vwOAdBuOq1XsbWqS9/yhmnDBmjSNmN73+qf05JX9pojf
         +X0pF6VAyeGkxpGxL09IZ3/B4/LESSqY9TNBUmRF2wrkr4kifjUNc4S2jckdfqTW4e3n
         GoXGw9gbwwe6Jo2lMchjtMfYad6gDTqIECGcN7kXeQFzTRg1sclLR5MmjvC5GfOlTezG
         MgmQ==
X-Gm-Message-State: AGRZ1gKTeEvOcdlTHTnABI2cdRkpY/0BlAkYf9SKnmXuRpeAP07TlB3s
        83PEptdkjwZO81GbMnCmpJQ=
X-Google-Smtp-Source: AJdET5dkEicWHmKS8IJfkyZhWp3recDfZ6cJTNaR5m5H0YxNv6caNVWbn2FN/9qoBor9UIweEknJww==
X-Received: by 2002:a63:3c19:: with SMTP id j25mr334771pga.286.1540450089892;
        Wed, 24 Oct 2018 23:48:09 -0700 (PDT)
Received: from localhost ([175.223.22.26])
        by smtp.gmail.com with ESMTPSA id v26-v6sm8543127pfg.43.2018.10.24.23.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 23:48:08 -0700 (PDT)
Date:   Thu, 25 Oct 2018 15:48:04 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH] s390/fault: use wake_up_klogd() in bust_spinlocks()
Message-ID: <20181025064804.GA20702@jagdpanzerIV>
References: <20181024043048.21248-1-sergey.senozhatsky@gmail.com>
 <20181024043425.GA8862@jagdpanzerIV>
 <20181025062800.GB4037@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025062800.GB4037@osiris>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/25/18 08:28), Heiko Carstens wrote:
[..]
> >  		int loglevel_save = console_loglevel;
> > -		console_unblank();
> > -		oops_in_progress = 0;
> > -		/*
> > -		 * OK, the message is on the console.  Now we call printk()
> > -		 * without oops_in_progress set so that printk will give klogd
> > -		 * a poke.  Hold onto your hats...
> > -		 */
> > +
> >  		console_loglevel = 15;
> > -		printk(" ");
> > +		console_unblank();
> >  		console_loglevel = loglevel_save;
> > +		oops_in_progress = 0;
> > +		wake_up_klogd();
> >  	}
> 
> With your patch this looks nearly like the common code variant. I did
> some code archaeology and this function is unchanged since ~17 years.
> When it was introduced it was close to identical to the x86 variant.
> All other architectures use the common code variant in the
> meantime. So if we change this I'd prefer that we switch s390 to the
> common code variant as well.

Right. I couldn't clearly understand what was so special that s390
bust_spinlock() was doing, but assumed that this `console_loglevel'
manipulation probably was somehow important to s390. Though this
console_loglevel adjustment is not 100% guaranteed to make any difference,
because of the way console_unblank() works: if it can't lock console_sem
and it sees oops_in_progress then it does nothing; it doesn't even print
logbuf messages to the consoles. If, however, console_sem is not locked,
then it does print pending logbuf messages, with temporarily verbose
console_loglevel. I concluded that this might be important to you in
one way or another.

> Right now I can't see a reason for not doing that, but I might be
> wrong of course. So, could you please provide a new version which just
> removes this variant and makes s390 use the generic one too.
> 
> We'll see if there is any fallout...

Will do! Sounds good.

	-ss
