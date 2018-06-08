Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Ng2jDyd+Glu7IgAAmS7hNA
	; Fri, 08 Jun 2018 13:01:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 22BD1607E4; Fri,  8 Jun 2018 13:01:27 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/ncoeyY"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 99D71607A4;
	Fri,  8 Jun 2018 13:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99D71607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbeFHNBY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:01:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39201 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbeFHNBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:01:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id p11-v6so3572295wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uTSb9cByM8YYk/fN/4PH+wGvVztNDaXvvav89susguk=;
        b=b/ncoeyY1W7JWbJvFa07mM/eStfNaXlNVCNj0fryp6fl/KSGDKoxP+Le5F8jj1Zrol
         IR9qhRjvpfrcJP9wslttoGFz2PTrrmmtzKnKDx36TUOLH6v5XynirTfVunNiGg9ygZwV
         jwMQpPBQmkazTm15ilWVCLlKkkuf0AnRtfCawI+QqVX1pAQQIhjBH6eYVOMPwR+DJ1RZ
         r3lxnD6gSH9sXDDzOsFuJBU6OVq77FdOU1XRKh7zjBCANkLZtbHxaPWS36Log4MEOpi0
         s7/gYJHJy0YTRzS56ZMhNPCJOtIOc5Bbc52HrfI0kTKHXIvrKLf7TMwaWgoyryTwAGFW
         Lczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uTSb9cByM8YYk/fN/4PH+wGvVztNDaXvvav89susguk=;
        b=iyWmsq5UYmfy2cw1WWjg13nsuchsGKYLFZnlZz/Lbj4CdmIvlg5LAWVSbKhAPZI3fM
         9YdHNMq/Lqn6R/PtC679IgJzNhECk5c26uwty50ObP/sHRWDSUzChD/1hnjg5NVswTwH
         yzaWz9WFyK0oDTO2+6jD0rN45hNwgg0gJMXNbzr8+gQ40pBYr6PpYoKRndMKEtN3bPX1
         lcPGHARYN/p8mUdszhxE1gNJuTA4w89SrwggZO3HVYr08S0wuCEN9ltufB8tvh5ooWez
         U3koIPl09t5uF3ci8CBPWRHOXrpUnqiN6TDGr4+7gSPRMj9Owo/p/8VECTlysLKK1JiI
         00cw==
X-Gm-Message-State: APt69E3wD8fpKgxrzFmEMcszruxtOD2nDMbr+ZL590mfRd54j4kxMKoJ
        kPFDCzoBiTRR0p4kg1k0kXA=
X-Google-Smtp-Source: ADUXVKLRSdRjX4syc1Anx3PhNAUu9qpYIIPxoZyiVi07sUj1m0pNgXM0MTUECyZGN1hpt0vLRA+CjQ==
X-Received: by 2002:a1c:64d7:: with SMTP id y206-v6mr1504731wmb.43.1528462882003;
        Fri, 08 Jun 2018 06:01:22 -0700 (PDT)
Received: from linux-08lc (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id u108-v6sm77862841wrc.40.2018.06.08.06.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 06:01:20 -0700 (PDT)
Date: Fri, 8 Jun 2018 14:01:29 +0100
From: John Whitmore <arigead@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, kstewart@linuxfoundation.org,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        colin.king@canonical.com, tglx@linutronix.de
Subject: Re: [PATCH v6 8/8] staging: rtl8192e: remove unnecessary parentheses
 - Coding Style
Message-ID: <20180608130127.koojqozbasmef2gd@linux-08lc>
References: <20180606114003.22654-1-johnfwhitmore@gmail.com>
 <20180606114003.22654-9-johnfwhitmore@gmail.com>
 <20180608121851.o7m3iihg2ibbgmxh@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608121851.o7m3iihg2ibbgmxh@mwanda>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 03:18:51PM +0300, Dan Carpenter wrote:
> On Wed, Jun 06, 2018 at 12:40:03PM +0100, John Whitmore wrote:
> > @@ -1072,10 +1072,10 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
> >  	pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
> >  
> >  	// Initialize all of the parameters related to 11n
> > -	memset((void *)(&(pHTInfo->SelfHTCap)), 0, sizeof(pHTInfo->SelfHTCap));
> > -	memset((void *)(&(pHTInfo->SelfHTInfo)), 0, sizeof(pHTInfo->SelfHTInfo));
> > -	memset((void *)(&(pHTInfo->PeerHTCapBuf)), 0, sizeof(pHTInfo->PeerHTCapBuf));
> > -	memset((void *)(&(pHTInfo->PeerHTInfoBuf)), 0, sizeof(pHTInfo->PeerHTInfoBuf));
> > +	memset((void *)(&pHTInfo->SelfHTCap), 0, sizeof(pHTInfo->SelfHTCap));
> > +	memset((void *)(&pHTInfo->SelfHTInfo), 0, sizeof(pHTInfo->SelfHTInfo));
> > +	memset((void *)(&pHTInfo->PeerHTCapBuf), 0, sizeof(pHTInfo->PeerHTCapBuf));
> > +	memset((void *)(&pHTInfo->PeerHTInfoBuf), 0, sizeof(pHTInfo->PeerHTInfoBuf));
> 
> You should write these like so:
> 
> 	memset(&pHTInfo->PeerHTInfoBuf, 0, sizeof(pHTInfo->PeerHTInfoBuf));
> 
> The first 7 patches look fine, but can you resend this last one?
> 
> regards,
> dan carpenter
> 

I can certainly try. I've bumped it to v7 so here goes...

John
