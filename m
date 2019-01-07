Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4490EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018132173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OL1J0tva";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SQnge1Sm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfAGLZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:25:12 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51054 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfAGLZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:25:11 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 293A86089D; Mon,  7 Jan 2019 11:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546860310;
        bh=O1WI1HdtMMlBvuBe/wrhfRSxx0dPpqkuT6GCXovcWn8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OL1J0tvajv5VAPAlTpYYiOMQMYlXRpP2KWnnm9o0Vr69741TxUjRUfA1H2zU6SpbA
         vJrhSiBA4/sSfJi5SFGu42Ed6e3HZtOz68XWLL/zmHiCKjRkQaNsqLnAhJdKUCQ+dU
         DobicS7WjVbo7jVLcNO3UR3OIJCEaGXQuDpt3kGs=
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EA24B6086A;
        Mon,  7 Jan 2019 11:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546860309;
        bh=O1WI1HdtMMlBvuBe/wrhfRSxx0dPpqkuT6GCXovcWn8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SQnge1SmINs3Vxz64bso7cXGn7BOltS6a8zZmoLj7MxUfzNGcxEzA6mLXojNNpLRF
         T/tUDq3GbhaBl8JthsuK/N/Iwf85njYsG3XE9AaLJL5SNFMRTtNFqORqShuEb/ctMc
         W32LrKSRJCzHwFY22/HSSa4CRP3v/Zblv93ETIwg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA24B6086A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f172.google.com with SMTP id d15so27846qkj.0;
        Mon, 07 Jan 2019 03:25:08 -0800 (PST)
X-Gm-Message-State: AJcUukejnf8bMuOiwG+T/DK+fV0RGli+x+u7eZvHE0hmLx4AOiE75EY8
        IOdbtbLp7HCUQXAyc243J7E83+BLYGKeM6oAY0g=
X-Google-Smtp-Source: ALg8bN40mCunMuXWF4xIuBvpXd9DUGHaUWCjRol5IdVjV7etZLo/VxP2vGmCGyXgx1JP6I1sOVn+EAlk+OjcV21iL2M=
X-Received: by 2002:a37:a5c9:: with SMTP id o192mr56905536qke.140.1546860308129;
 Mon, 07 Jan 2019 03:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20190107095433.11368-1-vivek.gautam@codeaurora.org> <201901071849.E4VZI7L7%fengguang.wu@intel.com>
In-Reply-To: <201901071849.E4VZI7L7%fengguang.wu@intel.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Mon, 7 Jan 2019 16:54:56 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGV6m_Bj=QBvt_wS2v-Bv=3vp15kUCuMZw3uyJGQD2ytg@mail.gmail.com>
Message-ID: <CAFp+6iGV6m_Bj=QBvt_wS2v-Bv=3vp15kUCuMZw3uyJGQD2ytg@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/prime: Use sg_dma_len() macro to get sg's length
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, sean@poorly.run,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 4:14 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Vivek,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.0-rc1 next-20190107]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Vivek-Gautam/drm-prime-Use-sg_dma_len-macro-to-get-sg-s-length/20190107-181350
> config: x86_64-randconfig-x013-201901 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All errors (new ones prefixed by >>):
>
>    drivers/gpu/drm/drm_prime.c: In function 'drm_prime_sg_to_page_addr_arrays':
> >> drivers/gpu/drm/drm_prime.c:948:9: error: implicit declaration of function 'sg_dma_length'; did you mean 'sg_dma_len'? [-Werror=implicit-function-declaration]
>       len = sg_dma_length(sg);
>             ^~~~~~~~~~~~~
>             sg_dma_len

Sorry, my fat finger :(
This should be as suggested - sg_dma_len().

Thanks
Vivek

>    cc1: some warnings being treated as errors
>
> vim +948 drivers/gpu/drm/drm_prime.c
>
>    926
>    927  /**
>    928   * drm_prime_sg_to_page_addr_arrays - convert an sg table into a page array
>    929   * @sgt: scatter-gather table to convert
>    930   * @pages: optional array of page pointers to store the page array in
>    931   * @addrs: optional array to store the dma bus address of each page
>    932   * @max_entries: size of both the passed-in arrays
>    933   *
>    934   * Exports an sg table into an array of pages and addresses. This is currently
>    935   * required by the TTM driver in order to do correct fault handling.
>    936   */
>    937  int drm_prime_sg_to_page_addr_arrays(struct sg_table *sgt, struct page **pages,
>    938                                       dma_addr_t *addrs, int max_entries)
>    939  {
>    940          unsigned count;
>    941          struct scatterlist *sg;
>    942          struct page *page;
>    943          u32 len, index;
>    944          dma_addr_t addr;
>    945
>    946          index = 0;
>    947          for_each_sg(sgt->sgl, sg, sgt->nents, count) {
>  > 948                  len = sg_dma_length(sg);
>    949                  page = sg_page(sg);
>    950                  addr = sg_dma_address(sg);
>    951
>    952                  while (len > 0) {
>    953                          if (WARN_ON(index >= max_entries))
>    954                                  return -1;
>    955                          if (pages)
>    956                                  pages[index] = page;
>    957                          if (addrs)
>    958                                  addrs[index] = addr;
>    959
>    960                          page++;
>    961                          addr += PAGE_SIZE;
>    962                          len -= PAGE_SIZE;
>    963                          index++;
>    964                  }
>    965          }
>    966          return 0;
>    967  }
>    968  EXPORT_SYMBOL(drm_prime_sg_to_page_addr_arrays);
>    969
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
