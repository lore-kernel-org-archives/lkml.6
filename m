Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714BBECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2B62089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUBWwasU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2B62089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeGOX3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:29:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35492 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeGOX3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:29:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id a3-v6so20842596wrt.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 16:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IZJ4uk9DNbF8pX1cq5sgDSnqdABkYAKdQYntbtXl+LQ=;
        b=ZUBWwasUv6VPKMgS88O3lr/3mCv7IPqSY0GI8A0f5KzczUzRaNQMjbtDi2/hws+eTQ
         8BK4Nti+zEruANcYBDILIxsFUdg2CPYjEmJXuANt9B2yScSWJ5ftD9aAcZm9dfAE0Kpj
         OrWERNbCOnXxP5QUSUZVjlmEeDv7ekddIyJHPsI4RpEnS1wTok8tDXzSFUaxVXTNVfzo
         Gp0cOLVs6sxTyaIOpLq4guIv6xl+cBAd8GOKyPk6ffoHmItG1ytwyNY4mAcDl8JI4ils
         I2tsGTW0FJnTaWtqJ5ewFCVZQF/oA6jCaYwJeX5QMwHyIV+KzufKtv2L9QQcbSHEWFYA
         N+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IZJ4uk9DNbF8pX1cq5sgDSnqdABkYAKdQYntbtXl+LQ=;
        b=UE0bsRyl52C20S0cw8TukM2zZcRiiq+inVNfUvw407aOXHJhbEstoSU1cFlMp8AWtq
         VpnXkUMJzacTqYX7Ygou5sSNwBS73o9sDOpTVOzr409ZvRyps5lY0NlpbixrCz1KG6kI
         dulEV8R+6RddPEjx/QTUGwxMmGR2jBBL0S4SrdU5x/SgG7K8djaicayo7hWDcDOdgGZq
         KKjaR9u89SR9X3pVt/vsyX6W0bPnKaelwBWkkznPSfZ9BJQgkZYz2IHr4wKIFlFUPrnt
         wqaSr5kq2Y2O8spTxu1NK/s+KQfK4uirUIQ39e3Mxi8qe19ECrLhlHrzAGXYWhz9d0Rz
         Dkgw==
X-Gm-Message-State: AOUpUlE09WP8JOmNBveDqqXs06Xp1IRiy2w5LuW/fRKHPJwdHPnm6Gy/
        IXTUmz75ciztj1wjlcxGpnM=
X-Google-Smtp-Source: AAOMgpfG7/2H7oA8WD8SD5o8YYzCX7nc2Y9uQGadCguUJ94yRjwJm+e2sdLdDjQhbRheXXZ+4yqr5w==
X-Received: by 2002:adf:9051:: with SMTP id h75-v6mr10759680wrh.65.1531695872681;
        Sun, 15 Jul 2018 16:04:32 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f6-v6sm18380957wrp.30.2018.07.15.16.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 16:04:32 -0700 (PDT)
Date:   Mon, 16 Jul 2018 01:04:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, luto@kernel.org,
        dave.hansen@intel.com, kernel-team@fb.com, efault@gmx.de,
        tglx@linutronix.de, songliubraving@fb.com, hpa@zytor.com
Subject: Re: [PATCH 7/7] x86,switch_mm: skip atomic operations for init_mm
Message-ID: <20180715230430.GD30102@gmail.com>
References: <20180710142833.26231-1-riel@surriel.com>
 <20180710142833.26231-8-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710142833.26231-8-riel@surriel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rik van Riel <riel@surriel.com> wrote:

> +		/*
> +		 * Stop remote flushes for the previous mm.
> +		 * Skip the idle task; we never send init_mm TLB flushing IPIs,
> +		 * but the bitmap manipulation can cause cache line contention.
> +		 */
> +		if (real_prev != &init_mm) {
> +			VM_WARN_ON_ONCE(!cpumask_test_cpu(cpu,
> +						mm_cpumask(real_prev)));
> +			cpumask_clear_cpu(cpu, mm_cpumask(real_prev));

BTW., could this optimization be (safely) extended to all (or most) !task->mm 
kernel threads?

In particular softirq and threaded irq handlers could benefit greatly I suspect in 
certain networking intense workloads that happen to active them.

Thanks,

	Ingo
