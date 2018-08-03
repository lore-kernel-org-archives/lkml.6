Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC02DC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C8F2174C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C8F2174C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbeHCMYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:24:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10626 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732374AbeHCMYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:24:47 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 12ABAEE04B9EB;
        Fri,  3 Aug 2018 18:28:58 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Fri, 3 Aug 2018
 18:28:55 +0800
Message-ID: <5B642E65.6050509@huawei.com>
Date:   Fri, 3 Aug 2018 18:28:53 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <mingo@redhat.com>, <tglx@linutronix.de>, <bskeggs@redhat.com>,
        <airlied@linux.ie>, <robdclark@gmail.com>
CC:     <hpa@zytor.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: Re: [PATCH linux-next] driver/gpu: Fix mismatch in funciton argument
 type
References: <1532238088-11193-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1532238088-11193-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/22 13:41, zhong jiang wrote:
> Fix the following warning:
>
> drivers/gpu/drm/nouveau/dispnv50/wndw.c:570:1: error: symbol 'nv50_wndw_new_' redeclared with different type
> (originally declared at drivers/gpu/drm/nouveau/dispnv50/wndw.h:39) - incompatible argument 7 (different signedness)
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/wndw.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.h b/drivers/gpu/drm/nouveau/dispnv50/wndw.h
> index b0b6428..0770683 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/wndw.h
> +++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.h
> @@ -38,8 +38,8 @@ struct nv50_wndw {
>  
>  int nv50_wndw_new_(const struct nv50_wndw_func *, struct drm_device *,
>  		   enum drm_plane_type, const char *name, int index,
> -		   const u32 *format, enum nv50_disp_interlock_type,
> -		   u32 interlock_data, u32 heads, struct nv50_wndw **);
> +		   const u32 *format, u32 heads, enum nv50_disp_interlock_type,
> +		   u32 interlock_data, struct nv50_wndw **);
>  void nv50_wndw_init(struct nv50_wndw *);
>  void nv50_wndw_fini(struct nv50_wndw *);
>  void nv50_wndw_flush_set(struct nv50_wndw *, u32 *interlock,
ping ?

