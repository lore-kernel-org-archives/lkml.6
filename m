Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03148C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE4D21748
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJ5qmgmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE4D21748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeHRSAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 14:00:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40454 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeHRSAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 14:00:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id z25-v6so117332pgu.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 07:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k3N2hZuX3kb2ZpOrsF/ZfcGwtydDC3DriHqwSTWYPd0=;
        b=XJ5qmgmzbTO0+YMBULn+4tfiG4SwbiP+gvrNDd3s2Bdc9qo0cP6Mu/2wVZIG16iLQj
         rlhRT+yhAN9kV7p+BcC/oxQ92C3adT4B0VLcKosJ4GXURnNW8TWfWPOAQ57cMJeEXyUV
         CGJ1PrS23QsQfbLSAGJprO/gpp2R0kY+RKaeHWT81V7ECRABfvNE3P4V4GLg9dAfF+9w
         6G7c8Kp3ODJvEsygD0odW0pPiGivaCjMEjB49SQdojWh41apFumiHebVi5QZi8oWbbWP
         z6aT7RIMvslPIWJfEbdsCm0NnPRC5UR54mkSvX7LTy1U5XBilPbiHOMerPwpWe19eTqf
         5g+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k3N2hZuX3kb2ZpOrsF/ZfcGwtydDC3DriHqwSTWYPd0=;
        b=HlWtv9ylUTFHYUZFoloeIj0kUvNRx5Y9cmP/GlHBr08G/jMlZACa2kUv62lguMyC7v
         bXhI1ZwJo+Z8Mss6XCt1QBShPJemuko2/+U+YdcA/dh09Bl7naCDnlaln5QT/aaCQNL6
         EMoDDk+PK+T8mdJy6OnYOnCdE0q+wBoPNXf/fy93LfZ9VgnZuDKMJMaFhQhkyTSc/u+t
         C1xyXIAOS57tVWlc761wjoQ6NbepJB30lhQ5OmTlOJkGX/W1/fsC22v1R9oWQTMzYFi6
         2pNSYo4V7or61y0BJSBv6NaC1Ct3qV3u7TYuoDPD7n+e1nvnR8bYWQVzJPJmtfYHzOd3
         W/uQ==
X-Gm-Message-State: AOUpUlHvuCDul63iKhYsk77jzdHyQK2efqHmcjfdDF9PQTMZa1+EcogW
        ioDc7NxHh9K4wMZx3uXdR2k=
X-Google-Smtp-Source: AA+uWPwpoBomH34AZjkKuAENbV+F8puWfhxkU8yv3Izjm3N0+delsLVIYHdErXHT8kicvF7K39u2Vg==
X-Received: by 2002:a63:fb57:: with SMTP id w23-v6mr36824292pgj.441.1534603971633;
        Sat, 18 Aug 2018 07:52:51 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id q26-v6sm5915562pff.9.2018.08.18.07.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 07:52:51 -0700 (PDT)
Date:   Sat, 18 Aug 2018 20:22:43 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, yamada.masahiro@socionext.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Coccinelle: remove pci_alloc_consistent semantic to
 dectect in zalloc-simple.cocci
Message-ID: <20180818145243.GA2150@himanshu-Vostro-3559>
References: <1534593700-3036-1-git-send-email-zhongjiang@huawei.com>
 <20180818125228.GA1000@himanshu-Vostro-3559>
 <5B782572.5000802@huawei.com>
 <alpine.DEB.2.21.1808181600470.2348@hadrien>
 <5B7828D2.5010506@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B7828D2.5010506@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 10:10:26PM +0800, zhong jiang wrote:
> On 2018/8/18 22:01, Julia Lawall wrote:
> >
> > On Sat, 18 Aug 2018, zhong jiang wrote:
> >
> >> On 2018/8/18 20:52, Himanshu Jha wrote:
> >>> On Sat, Aug 18, 2018 at 08:01:40PM +0800, zhong jiang wrote:
> >>>> Because pci_alloc_consistent has been deprecated. We prefer to use
> >>>> dam_alloc_coherent directly. Therefore, we should remove pci_alloc_consistent
> >>>   ^^^ typo "dma"
> >>>
> >>> Also, typo in the patch subject "dectect" -> "detect"
> >>  Thanks,  will fix it in v2.
> >>> Otherwise,
> >>>
> >>> Acked-by: Himanshu Jha <himanshujha199640@gmail.com>
> >>>
> >>> Thanks for cleaning up, we still have few more *_alloc/memset
> >>> in the mainline, especially in the scsi subsystem, even after
> >>> I cleaned up with two long patch series in the past.
> >>>
> >>    I post same patches like *_alloc/memset in the scsi subsystem. Unfortunately,
> >>    Maintainer maybe do not care about the change.  therefore,  None of my patches
> >>   are received and rarely feedback.
> > Maybe they will be picked up later.
>  Hope so.  It's been more than a month since I post the patches. Maybe I should give a kindly ping. :-)

Heh! The problem is Martin only when picks up patches if the driver
maintainer Acks them, and it happens very rarely until you have
a *real* bugfix.

But since these patches are simple, so Martin should pick it up
even if the patch doesn't receive any feedback.

If you ping, then certainly Martin will give you the same feedback.

Maybe you can make them happy by sending a syzbot bugfix ;)

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
