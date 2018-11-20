Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C53C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D517B20870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D517B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dei.uc.pt
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeKUBTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:19:21 -0500
Received: from smtp.dei.uc.pt ([193.137.203.234]:39276 "EHLO smtp2.dei.uc.pt"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbeKUBTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:19:20 -0500
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (user=sneves mech=PLAIN bits=0)
        by smtp2.dei.uc.pt (8.15.2/8.15.2) with ESMTPSA id wAKEmVMh008018
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 14:48:37 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.dei.uc.pt wAKEmVMh008018
Received: by mail-ed1-f47.google.com with SMTP id h50so2154197ede.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 06:48:37 -0800 (PST)
X-Gm-Message-State: AGRZ1gJeEvFJWy0eTYChC9fLA2KvdIaieIjYObaezjEi3PIelEfpbH0y
        tsNXJ85xa1GP7SDFsdaFvtosqcEW5AzFfHEoyQo=
X-Google-Smtp-Source: AJdET5cdBS0rEufv6yPEQu1vea6hk0SOmTG6+VY67+dKN0QolGUNr6q8tt6QRhChnA5Nu67jtq80dGJCKH3F+XbTvkY=
X-Received: by 2002:a17:906:1a49:: with SMTP id j9-v6mr2215461ejf.45.1542725311358;
 Tue, 20 Nov 2018 06:48:31 -0800 (PST)
MIME-Version: 1.0
References: <CAEX_ruH=9VHD-8YH2--4mYPq7LD2Ciya2ADeSO=c38s2KaQhUg@mail.gmail.com>
 <85b88fcc-4157-f01e-cfec-df0c31a14d2e@linux.intel.com>
In-Reply-To: <85b88fcc-4157-f01e-cfec-df0c31a14d2e@linux.intel.com>
From:   Samuel Neves <sneves@dei.uc.pt>
Date:   Tue, 20 Nov 2018 14:47:55 +0000
X-Gmail-Original-Message-ID: <CAEX_ruHFehkqopKPHSWRRE32vmDoyWYAr2cVJHLanVip_hVDVg@mail.gmail.com>
Message-ID: <CAEX_ruHFehkqopKPHSWRRE32vmDoyWYAr2cVJHLanVip_hVDVg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/fpu: track AVX-512 usage of tasks
To:     aubrey.li@linux.intel.com
Cc:     dave.hansen@intel.com, aubrey.li@intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        "H. Peter Anvin" <hpa@zytor.com>, ak@linux.intel.com,
        tim.c.chen@linux.intel.com,
        Arjan van de Ven <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-FCTUC-DEI-SIC-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-FCTUC-DEI-SIC-MailScanner-ID: wAKEmVMh008018
X-FCTUC-DEI-SIC-MailScanner: Found to be clean
X-FCTUC-DEI-SIC-MailScanner-SpamCheck: not spam, SpamAssassin (cached,
        score=-60.1, required 3.252, autolearn=not spam, ALL_TRUSTED -10.00,
        BAYES_00 -0.10, L_SMTP_AUTH -50.00)
X-FCTUC-DEI-SIC-MailScanner-From: sneves@dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 1:32 PM Li, Aubrey <aubrey.li@linux.intel.com> wrote:
> Thanks for your program, Samuel, it's very helpful. But I saw a different
> output on my side, May I have your glibc version?
>

This system is running glibc 2.27, and kernel 4.18.7. The Xeon Gold
5120 also happens to be one of the Skylake-SP models with a single
512-bit FMA unit, instead of 2.

Samuel.
