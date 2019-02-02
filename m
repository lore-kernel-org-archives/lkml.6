Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8988AC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585F52082C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sqOcuzWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfBBR4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:56:06 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55060 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfBBR4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 12:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NvQ0Q3xWeVGPu1MpHRexndackdw83HWWfJwOzQ8/o4s=; b=sqOcuzWMD8o8YffDwbZeBifp1m
        N9cNo9SaFfd2CKe38pzc9+5aFN4tHJC07Kq5ahNI/+ykHsRDD0kukc4rXgRiuZyY0RuBGq5gFB7tK
        DW8BpzR3jc18GgaeXh8vbVhVOqfEHm3qeLfhfrxR35JUR0ErOGG61UarhOiYNZoejcQ1XoGN2lX4L
        ZcX8AwkCE1v/hRSr8eDIIgVt2cJWKpQWM/AxqSF32TS80m5x3hRRH5cUUrd6j6IGTiMY/r7W/vzag
        r45BRNGTjX8h4p5DAtmNCtRkX5ikrHTt1qHE2iR7bmC5u5TYZTkG0VEaOkDA85+HrbereD2l7EVtu
        zp4mN0Bw==;
Received: from [199.233.58.37] (helo=[10.83.93.157])
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpzWM-0001pP-19; Sat, 02 Feb 2019 17:56:02 +0000
Subject: Re: [PATCH] Move static keyword at beginning of declaration
To:     Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20190202130535.2761-1-malat@debian.org>
From:   Geoff Levand <geoff@infradead.org>
Message-ID: <2205d42d-1dc9-7d80-6c85-4162763ee9e9@infradead.org>
Date:   Sat, 2 Feb 2019 09:56:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190202130535.2761-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/19 5:05 AM, Mathieu Malaterre wrote:
> Move the static keyword around to remove the following warnings (W=1):
> 
>   arch/powerpc/platforms/ps3/os-area.c:212:1: error: 'static' is not at beginning of declaration [-Werror=old-style-declaration]
>   arch/powerpc/platforms/ps3/system-bus.c:45:1: error: 'static' is not at beginning of declaration [-Werror=old-style-declaration]
> 
> -struct saved_params {
> +static struct saved_params {
>  	unsigned int valid;
>  	s64 rtc_diff;
>  	unsigned int av_multi_out;
> -} static saved_params;
> +} saved_params;

Seems fine.

Acked-by: Geoff Levand <geoff@infradead.org>
