Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85824ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 08:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030FB20881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 08:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKAhUjdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030FB20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeIOOR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 10:17:26 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:33665 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeIOORZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 10:17:25 -0400
Received: by mail-pl1-f179.google.com with SMTP id b97-v6so26338plb.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 01:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=VEHzPpsRRc8ZC2LZdoCpv+oE9t1b7YKq2VXXN0rUd64=;
        b=hKAhUjdV8QdtkbodwHt4vbAlx0IZqyFWnrlE/XkoMEpyOtgunvj9fYivQSJngKuR9s
         uWI/rUk8XgnoDbh7cMfFcIX8V32Fbj3hB9hv4nd+NLEHlWIBrzotibG5jf0+XIELfeFQ
         LKqoVTmPrpKU71j/HvYrGUqF6Xm2Ov9OyjZOJdn/9iYi49Qag5oNJ8otA+HOR4okQb47
         a2hzLtScUJFqvlLnjqhMbmEd6yPxLOXNjB/1/T3fAXJ//E03DHAhFuZ485rCI/icO8kd
         LDsYniwgyyqk1gg+g5Qjdo52BI2LR550679G2OOo4oX1P52ibJlU75JZOrmKPfD7Iisc
         8iGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=VEHzPpsRRc8ZC2LZdoCpv+oE9t1b7YKq2VXXN0rUd64=;
        b=cDrlzFU5UA+Les049fLwA+B3m0NHCjchHd0pPRtk3xHMQjPzgF9hJUJ/MvzJaxdrum
         6mKOGLi3JFQ4UyKDeOct3fqsvP0eArYkxBbBhDGKFmSlI2DGuubInsXNv4pMzZd0VaCd
         Eu0WZRAUNRY4/5Cjd5Sklvc6tw1UKA+d+T28GXdYv70m+b1ej+DuGdfGnPPijMxK5hk9
         342wTM88NXdTFw8nqGaCoBOCux2ef8JMPzUZ5/9shT/TUH6DBw4e1nVvgmM5Mz6CcPK8
         SCy3F1s7sRG5IBwcsolDp4XMbckNvaj3qlt5HbGMWkIt2ElgHyghyNZdbSTaq4A4eoPK
         gVAg==
X-Gm-Message-State: APzg51BcNaQ3Ez+1SWhgygjh60E1pkiaC+aLY2c6o+/wyTScNdP+yLkA
        uWzVt0hFZXtJrDdGb/SXryQkIozT
X-Google-Smtp-Source: ANB0VdbaVfVWTRtW4zsESwzK+lMikPi7ug5izkQVYpxjVJs2WMV22oBu+EGBHGoO1c3P8dsZD+hjhw==
X-Received: by 2002:a17:902:ac97:: with SMTP id h23-v6mr11677386plr.174.1537001951089;
        Sat, 15 Sep 2018 01:59:11 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.58? ([2402:f000:1:1501:200:5efe:a66f:473a])
        by smtp.gmail.com with ESMTPSA id d19-v6sm16954136pgi.50.2018.09.15.01.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 01:59:10 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] gpu: drm: amdgpu: Possible sleep-in-atomic-context bugs in
 amdgpu_uvd_ring_begin_use()
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <f09853dc-591c-05d3-9f56-63e4b338c585@gmail.com>
Date:   Sat, 15 Sep 2018 16:59:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.
The function call paths (from bottom to top) in Linux-4.17 are:

[FUNC] mutex_lock_nested
drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c, 1477:
     mutex_lock_nested in amdgpu_dpm_enable_uvd
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c, 1154:
     amdgpu_dpm_enable_uvd in amdgpu_uvd_ring_begin_use
drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c, 80:
     [FUNC_PTR]amdgpu_uvd_ring_begin_use in amdgpu_ring_alloc
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c, 199:
     amdgpu_ring_alloc in amdgpu_virt_kiq_wreg
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:
     amdgpu_virt_kiq_wreg in amdgpu_mm_wreg
drivers/gpu/drm/amd/amdgpu/vi.c, 207:
     amdgpu_mm_wreg in vi_gc_cac_rreg
drivers/gpu/drm/amd/amdgpu/vi.c, 206:
     _raw_spin_lock_irqsave in vi_gc_cac_rreg

[FUNC] mutex_lock_nested
drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c, 1477:
     mutex_lock_nested in amdgpu_dpm_enable_uvd
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c, 1154:
     amdgpu_dpm_enable_uvd in amdgpu_uvd_ring_begin_use
drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c, 80:
     [FUNC_PTR]amdgpu_uvd_ring_begin_use in amdgpu_ring_alloc
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c, 199:
     amdgpu_ring_alloc in amdgpu_virt_kiq_wreg
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:
     amdgpu_virt_kiq_wreg in amdgpu_mm_wreg
drivers/gpu/drm/amd/amdgpu/soc15.c, 106:
     amdgpu_mm_wreg in soc15_pcie_rreg
drivers/gpu/drm/amd/amdgpu/soc15.c, 105:
     _raw_spin_lock_irqsave in soc15_pcie_rreg

[FUNC] mutex_lock_nested
drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c, 1477:
     mutex_lock_nested in amdgpu_dpm_enable_uvd
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c, 1154:
     amdgpu_dpm_enable_uvd in amdgpu_uvd_ring_begin_use
drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c, 80:
     [FUNC_PTR]amdgpu_uvd_ring_begin_use in amdgpu_ring_alloc
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c, 199:
     amdgpu_ring_alloc in amdgpu_virt_kiq_wreg
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:
     amdgpu_virt_kiq_wreg in amdgpu_mm_wreg
drivers/gpu/drm/amd/amdgpu/cik.c, 139:
     amdgpu_mm_wreg in cik_uvd_ctx_wreg
drivers/gpu/drm/amd/amdgpu/cik.c, 138:
     _raw_spin_lock_irqsave in cik_uvd_ctx_wreg

[FUNC] mutex_lock_nested
drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c, 1477:
     mutex_lock_nested in amdgpu_dpm_enable_uvd
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c, 1154:
     amdgpu_dpm_enable_uvd in amdgpu_uvd_ring_begin_use
drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c, 80:
     [FUNC_PTR]amdgpu_uvd_ring_begin_use in amdgpu_ring_alloc
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c, 199:
     amdgpu_ring_alloc in amdgpu_virt_kiq_wreg
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:
     amdgpu_virt_kiq_wreg in amdgpu_mm_wreg
drivers/gpu/drm/amd/amdgpu/dce_v6_0.c, 126:
     amdgpu_mm_wreg in dce_v6_0_audio_endpt_rreg
drivers/gpu/drm/amd/amdgpu/dce_v6_0.c, 125:
     _raw_spin_lock_irqsave in dce_v6_0_audio_endpt_rreg

Note that [FUNC_PTR] means a function pointer call is used.

These bugs are found by my static analysis tool DSAC.


Best wishes,
Jia-Ju Bai
