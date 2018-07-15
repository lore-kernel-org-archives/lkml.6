Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2954ECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9A52089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1r9mrtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9A52089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeGOXY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:24:26 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39353 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeGOXYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:24:25 -0400
Received: by mail-wm0-f67.google.com with SMTP id h20-v6so13864567wmb.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 15:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=seWobWwmNSrtEr959giBdHSFAAmopRzZNTJLicRJLU8=;
        b=K1r9mrtDmEuCfg4KNWmJMpP0tmaluU3QHhE7mJ7c0wfeObMoEAlCNnw6XWSjQD3nks
         0x39mkRAzRS9VAima3vp0kMSunszOtYT2EoCmKM92HDf2tlET/LBzotIvKgZ99LGv1gX
         6/WMIJb7Wkxc7iIcJCktRbVRcMD7md6sXy+uSDCyp9vGPakXkLpzerS/0dhl4Fci7NU7
         B6c2ujk22Il2BF4Hkyfv1k10PmFjk4kjqkq/o3EXAvyTQySt/dQc/wz5SBazFlHtaqVZ
         lwuM6elrAO6FNrbyvt8qTOyXHpYnDrOry6SM4XQ1mx4nAsHo6iKIzgufjOeYB68kUIMl
         s9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=seWobWwmNSrtEr959giBdHSFAAmopRzZNTJLicRJLU8=;
        b=WVA3QTJdG5T1i3G2V8VJKry2g/S+p8RSJ/9jTnVfBQIfoYXJcYwBXXjJ/0UBciHnCu
         aJrhDiJ11rTOpitVwhDSYC1Xyji9Wimn2RlGEHEroaVDyw89vh0nmLdiItwmC3PpeqWI
         Szt9s256myKPwWygbBdf9U/zIOQVuNHuMbrrz6QQOU4crp7i97OeWUQcpUsv49CWAx5Q
         HOVkElL/eP92aDzkzs26wGWl7uGdKspU8hMzURBAFTFa5dc7t/s+IE9P6J1MJa/82yrv
         FROLeqSXJlgB/24reRw2forkCgJUNyGoU8zna6rdFBoG1thP0pGe/TCKtw6+gZVBR9O5
         rFwg==
X-Gm-Message-State: AOUpUlHtceve12SzHDVWPXJBmnr6vfLSX296Jh5sjJa2MNzqgmDfAzFr
        ezJOJuM2fD07KL5t/tav+gg=
X-Google-Smtp-Source: AAOMgpd6eLF7YL2oKNyUOq7MeHlWGRAGxXdJTdTYrDuf2aN+AnkRs+foaZD7yXf58G1wstaZWxW8AA==
X-Received: by 2002:a1c:387:: with SMTP id 129-v6mr8382872wmd.53.1531695594687;
        Sun, 15 Jul 2018 15:59:54 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u73-v6sm5722953wmd.4.2018.07.15.15.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 15:59:54 -0700 (PDT)
Date:   Mon, 16 Jul 2018 00:59:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, luto@kernel.org,
        dave.hansen@intel.com, kernel-team@fb.com, efault@gmx.de,
        tglx@linutronix.de, songliubraving@fb.com, hpa@zytor.com
Subject: Re: [PATCH 1/7] mm: allocate mm_cpumask dynamically based on
 nr_cpu_ids
Message-ID: <20180715225951.GC30102@gmail.com>
References: <20180710142833.26231-1-riel@surriel.com>
 <20180710142833.26231-2-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710142833.26231-2-riel@surriel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rik van Riel <riel@surriel.com> wrote:

> The mm_struct always contains a cpumask bitmap, regardless of
> CONFIG_CPUMASK_OFFSTACK. That means the first step can be to
> simplify things, and simply have one bitmask at the end of the
> mm_struct for the mm_cpumask.
> 
> This does necessitate moving everything else in mm_struct into
> an anonymous sub-structure, which can be randomized when struct
> randomization is enabled.
> 
> The second step is to determine the correct size for the
> mm_struct slab object from the size of the mm_struct
> (excluding the cpu bitmap) and the size the cpumask.
> 
> For init_mm we can simply allocate the maximum size this
> kernel is compiled for, since we only have one init_mm
> in the system, anyway.
> 
> Pointer magic by Mike Galbraith, to evade -Wstringop-overflow
> getting confused by the dynamically sized array.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Mike Galbraith <efault@gmx.de>

Is this an Acked-by in disguise, or did this patch route via Mike?

Thanks,

	Ingo
