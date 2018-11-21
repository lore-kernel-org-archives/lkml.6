Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0D7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D5B20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="DGAhBCUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D5B20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbeKUX2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:28:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51668 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbeKUX2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:28:31 -0500
Received: from [10.38.211.137] (x59cc8b89.dyn.telefonica.de [89.204.139.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9C6C11EC0319;
        Wed, 21 Nov 2018 13:54:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542804854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=34oheDHoHhjXqt/7AbaPzcpdfwrHiXjUP/8BghXfeVM=;
        b=DGAhBCUwFSiwM0y4gvIUVsNo7krCy2GvVLEKj74+76fpFSUPQSY95XuQlmkAXA9CBwVUaa
        n70WiDjVn5ctEEwdrbEBGxQ73kbMnJgjxHds9l4M8YpRWCN51Titx20wUcA3gWhJyya9Tg
        LiwCOOzcLrsiQnCb/f0VLWUN9PwbdJg=
Date:   Wed, 21 Nov 2018 13:54:11 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMU5Q=5LkypghWA=23YwscaXSx5yBv7LyW1WHbY_J_hQwryNpA@mail.gmail.com>
References: <20181119160410.ne7oiq2gkwt6jiqg@linutronix.de> <20181120132531.6E80C206BB@mail.kernel.org> <20181120183443.GJ2527@zn.tnic> <CAMU5Q=72mNG4ikXKpLK3=SiDK3dRXtCw7wpHZ2i==awrtvRwdg@mail.gmail.com> <20181121105649.GB27797@zn.tnic> <CAMU5Q=5LkypghWA=23YwscaXSx5yBv7LyW1WHbY_J_hQwryNpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] x86/fpu: Disable BH while while loading FPU registers in __fpu__restore_sig()
To:     Victoria Anosova <v.s.anosova@gmail.com>
CC:     sashal@kernel.org, bigeasy@linutronix.de, x86@kernel.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
From:   Boris Petkov <bp@alien8.de>
Message-ID: <8232626D-EB0F-42CB-B4B9-B1A4AD6D891E@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 21, 2018 1:41:37 PM GMT+01:00, Victoria Anosova <v=2Es=2Eanosov=
a@gmail=2Ecom> wrote:
>For v4=2E9 your first fix (
>https://lists=2Eopenwall=2Enet/linux-kernel/2016/02/26/299) helped=2E

Can you please not top-post? Thx=2E

That old version is not quite right - see the commit message of the curren=
t fix=2E

HTH=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
