Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1D4C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4543D20849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="DzSoyLSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4543D20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeLLOcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:32:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56704 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbeLLOck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:32:40 -0500
Received: from [10.144.244.162] (x59cc89a2.dyn.telefonica.de [89.204.137.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6E6341EC040F;
        Wed, 12 Dec 2018 15:32:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544625159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uuI22N3BNKV46UEv6xb5uS0YP/CPrva0bMtfcxZ1Pqc=;
        b=DzSoyLSl1BayGVHqeCUkW7uwEXXAB2ForKeQUS+k2aosM84jmnWQE24NJQY4csACaObCGH
        0yOnKWlHwzjsCb5p4Ny0wyYpGlklp7p6k53dd14whF+E/T09L1FH1lM+fe+sRXjK0t5My8
        XfbEA+HqZ+RK4WDC+t83vBSA2YYofm4=
Date:   Wed, 12 Dec 2018 15:32:37 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <be031a74-44d0-1fea-893a-bfdf3ba1655f@amd.com>
References: <20181211224615.5373.65736.stgit@tlendack-t1.amdoffice.net> <20181212000518.GX27375@zn.tnic> <alpine.DEB.2.21.1812111910520.22893@nanos.tec.linutronix.de> <20181212095938.GA6653@zn.tnic> <be031a74-44d0-1fea-893a-bfdf3ba1655f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] x86/speculation: Add support for STIBP always-on preferred mode
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>
From:   Boris Petkov <bp@alien8.de>
Message-ID: <8B17355F-0AE0-4E3A-BFF5-120AB739DB8C@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 12, 2018 3:04:35 PM GMT+01:00, "Lendacky, Thomas" <Thomas=2ELen=
dacky@amd=2Ecom> wrote:
>Not sure I completely follow=2E Are you saying to do what I did in my
>first patch or something different from that yet?

I'm saying that STIBP_ALWAYS_ON should be implemented the same way like IB=
RS_ENHANCED is and there's no need for a static bool=2E AFAICT=2E

Or am I missing something?=20

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
