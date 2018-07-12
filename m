Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA6BC476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2EB20842
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="q1smtC3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2EB20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732525AbeGLRXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:23:36 -0400
Received: from vern.gendns.com ([206.190.152.46]:47130 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732389AbeGLRXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sRAf/V2sDdpc2vZksCGdjwoKQpi09JpI8LPaduKM+mM=; b=q1smtC3XT7jzr/UWEVRz6OAQmP
        3wbQLN7V129oQP052RV39uZ0ak7NC3L+TWDcG9oznPbbcWHoRh38as9+uUu6tu1EQtdk/UD5kKVXh
        YDB+uWNAbYvI+7ovAr04pryNeCp/Ee0CJFL/SHW/rl90U4gjZ2hazkIOUtXoNsBbTDHckJLmTexFC
        kFwPY3/HE2TVdU3Gv4E5iS2KfauQMk4+lv37GFp+0ef50dHNUDozMSt8+G6fH/q60TlrpGgRm1GL6
        3Nts9Vqtgrk2rj6FXM+1+u+zXHuLcSBM1F1cUS3N9YUbd1uTQZHY02q8067ATAf1GFa9EHR2ZEGsU
        BkcdtOzA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:36332 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fdf9P-00Gpf7-3D; Thu, 12 Jul 2018 13:13:07 -0400
Subject: Re: [PATCH] drm/tinydrm: add backlight dependency for ili9341
To:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        David Airlie <airlied@linux.ie>
Cc:     Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180709152106.990066-1-arnd@arndb.de>
From:   David Lechner <david@lechnology.com>
Message-ID: <4483a923-ada5-c26d-715f-e0f8080e393a@lechnology.com>
Date:   Thu, 12 Jul 2018 12:13:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709152106.990066-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 10:20 AM, Arnd Bergmann wrote:
> This tinydrm driver fails to link without the backlight support:
> 
> drivers/gpu/drm/tinydrm/ili9341.o: In function `ili9341_probe':
> ili9341.c:(.text+0x578): undefined reference to `devm_of_find_backlight'
> 
> Fixes: 3fa0e8f6f960 ("drm/tinydrm: new driver for ILI9341 display panels")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

applied to drm-misc-next.

thanks
