Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78908ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2850520672
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="Ys20LAlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2850520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeJ1PtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 11:49:17 -0400
Received: from sonic301-20.consmr.mail.ir2.yahoo.com ([77.238.176.97]:40919
        "EHLO sonic301-20.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbeJ1PtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 11:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1540710330; bh=RmTdo1IFPqVCOrCtVRNEDiUiCmBMQ1i0jASg4+wV3eo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Ys20LAlR0r+NXABOrrKh3bB1hd4xXP6WViqBljweK17ifbBH8jgg7E05d+YUV6NuCggnukgLDnn8E4bV+2QGmczpdnQpxGKTaLVgLusbK64AvLXPcje3CleIe23V2X27y23udX2t88V8ma/G9NYb9tKpPfdFSseos8REU0JM3NThoKTxfEs01dYUJ6vIM1idW8GO7nwp58HhSedR+7PwomQPK8ua1u6/ILT4wPgK4oQRRdYTUDsC8rSj1KSMTcXws2I8Z3BrwcZ4SgsWKzFac6porCn459lakcPTEC12hZrN+74ptojgKV003BWbcoeM+Rpp7S003z81LYzhWQP04A==
X-YMail-OSG: fcdNk28VM1nyhkX1F2315fjS7._VRpM3ZFHA0EzZmQkU1sqtaFBqU6X_uAxr5AP
 nwwKcbOKevXm.OQvURceKRJ4U6DZY2gPoi4dKeGo.PkIgejcljjLwQ4DYeMK_G7WqlRT1jt8ia_H
 Ol5Gz4a3yc3ZvtV9.MOvzXJkpVF27sX.wMZ.ihioI0d0qyVfHqIJWJW259CL7BDWauiLTapusrFX
 euG7K4BL8VcHMGylgEdPTR6TTEaBxS4r1.W080WaLgi9St5KAcX035rOSNZ4qlu7LRZOOFf2HxyD
 e19j6vDD71I2aZ6cxigjrMGrR.oDgP_kfSYOJa4AIT0hj2W9wcDxliydfnnvZP45G2PlEtfuYy4y
 RvQJ5eo7wSBXO4tDeneUt57zv2Zi9efCSctWUKgi2B4Y_y.P0JFMpTp7.yaESCBvcdNDPuq9coaY
 cg2EszI0f6EIREu3L0wXP6NGEkNSROZzc0s3IPDA4P3Zi7kXb9Hr6KQqvTLcLAv8KdEyfhtFlbPD
 bHWBckluzd7C8fggH2wg8E42Ucq5kHM3pTNOeCw9SOCp7mXXoVy_fGbQvRrCWjMqtGXs7hl_vjry
 al5PIAEwJtlxDY00yaXRmlQaP4xrFBeC4X_KX.qkIAvehCi5rWzCsBIXrNK2qe12NvLQY1y9XoeR
 h2UQMHzVAEvOUpfoh1wg1uYeeV_wxeg3wYipdbeX5VksnV2WPX_ppW2M0dzwd47JdC5bhHmjz4zL
 WLWECbIkGxH_.i1ya3gC2EHSCHCa7ETlChp7g4aS0HBdAJPQoLTn76D_6MmCr3ChHsjl49t6Mbjt
 VxM2wK2HJleESRdifZAcziJoVtY_3tyPJklyp48JZc.fTBFHXygxVbvMmo3uaGawiuIbBMnXlQZ6
 KYshdPLkDNyPvBrqWn2ffCx9LyZQeW2u.IxPfCRv.h1B4ojKnEy6FCI58DuhbZroKWLzWEN84nPh
 yTQc63ZD.ajn4uOJ9jzkvYEHP2FbCXcEgYL_4j14fHeULwOs6ItSjQD5EcogoS76HJfzPb8S7DDj
 R6_wJR3w7nJ2JtomCYFbmTKqF.PILHDFB2lNZ29IiYRNt5giO7g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Sun, 28 Oct 2018 07:05:30 +0000
Received: from 115.192.33.5 (EHLO [192.168.199.211]) ([115.192.33.5])
          by smtp416.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7bd7991af1881c6c1fb88d3c9d71edb6;
          Sun, 28 Oct 2018 07:05:25 +0000 (UTC)
Subject: Re: [PATCH] mm: simplify get_next_ra_size
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1540707206-19649-1-git-send-email-hsiangkao@aol.com>
 <20181028062722.hfomc3davarmzojw@wfg-t540p.sh.intel.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <17e85309-e324-6c0f-6da2-2c4f0703a464@aol.com>
Date:   Sun, 28 Oct 2018 15:05:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181028062722.hfomc3davarmzojw@wfg-t540p.sh.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fengguang,

On 2018/10/28 14:27, Fengguang Wu wrote:
> Looks good to me, thanks!
> 
> Reviewed-by: Fengguang Wu <fengguang.wu@intel.com>

Thanks for taking time and the quickly review. :)

Best regards,
Gao Xiang

> 
> On Sun, Oct 28, 2018 at 02:13:26PM +0800, Gao Xiang wrote:
>> It's a trivial simplification for get_next_ra_size and
>> clear enough for humans to understand.
>>
>> It also fixes potential overflow if ra->size(< ra_pages) is too large.
>>
>> Cc: Fengguang Wu <fengguang.wu@intel.com>
>> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
>> --- 
