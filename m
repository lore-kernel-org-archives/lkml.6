Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE34C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B19624D34
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SobtF4Tq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B19624D34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933368AbeGCHfk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:35:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38361 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932823AbeGCHfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:35:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so1110719wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dA6RHHKiIV0t36YH01VHRgyE8rXKjiYTZd2n7bYUCeM=;
        b=SobtF4Tq2aO+GXLOqNQDogdAT4XNxy4aZo1bzHHRCWiWoUI+ncLRBGa3fGv722Uiym
         xE8ttPKqNgqynrBv35IemLLmXTxSPkmuMxnjpP4dr1cMj6jTVPzgyiZj1asd2OkSkaK2
         yrEExUXFkMzuz/15XoGbiOimwVQpwF5P5ZAr8/zcbV9hbJmz7mximgwdep/1hGSD0MpT
         K0DPIqZfPX0l6ZfWpGA8RUNLAZsrnY+yGhLFO51rmuWNrrW0VbZWkLJIQkHN1RSmlxbi
         kJwl2w0gRllJWVoSiHKAbRDRdsV2owS+i+W1I1S5bR6HXK7hYx4NYg5HKIv+PICFT+mG
         8E5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dA6RHHKiIV0t36YH01VHRgyE8rXKjiYTZd2n7bYUCeM=;
        b=luAhTYMk7dinNbsnHeJZXd8gr24AgldVQtPS5jm6H6jv2Z86R1u9abPUixmmYfUKuA
         RyPijby98apBPWj9UU236xKsH0rtOm/ZJDULigKOgLcno6L2ka5QvwwgWxsIL97+ugFd
         iIxwcJhSaGmrVzhPMUzmVzVZkU5L/nrPz2qdo6uUYDbxTP1OEjTU2NSxoDuqVwUFWp8w
         p701RnA21M5RB7xk+M6EOHCERCr/rlhS/iu1j6nIZA8TIbrvO2ZqUnlfjh87ZNb27RTl
         iLLfcGsWaVis5js34S+j9453UBSxxVoL4IKlTiwLFVZqZxNCWYQ4ElNyrHrruMFh1AnY
         4otQ==
X-Gm-Message-State: APt69E3TEb7Z9eLODe6RmhocFbT5gNPx5R2oF2VTxKIJROH+VfO5fYAP
        8L3j9jAthgis1oWU6w+UXtI=
X-Google-Smtp-Source: AAOMgpeDxPpJ3QV8DucqpK6kposS9oxBhBGNyfcXwlmlG+xlHiMyJFRPwhZ3gqfOEeLSOHyLcraKNg==
X-Received: by 2002:a1c:e541:: with SMTP id c62-v6mr7561850wmh.154.1530603336137;
        Tue, 03 Jul 2018 00:35:36 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y13-v6sm729959wrr.24.2018.07.03.00.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 00:35:35 -0700 (PDT)
Date:   Tue, 3 Jul 2018 09:35:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH 0/2] x86/build/vdso: a little more Makefile cleanups
Message-ID: <20180703073533.GA6573@gmail.com>
References: <1530582614-5173-1-git-send-email-yamada.masahiro@socionext.com>
 <2251685.NraJYuIFmt@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2251685.NraJYuIFmt@blindfold>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Richard Weinberger <richard@nod.at> wrote:

> Masahiro,
> 
> Am Dienstag, 3. Juli 2018, 03:50:12 CEST schrieb Masahiro Yamada:
> > 
> > At first, I sent the first patch to UML ML,
> > but they did not pick it up.
> > Instead, I was able to get Acked-by from Richard,
> > one of the UML maintainers.
> > 
> > https://patchwork.kernel.org/patch/10399787/
> > 
> > I am resending it to x86 ML.
> 
> Uhh, I thought you want to carry this via your tree?
> I don't mind picking up these patches.

I already picked them up, as one of them affects the x86 tree.

Is that OK?

Thanks,

	Ingo
