Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A68C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67982081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpBO+TeG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67982081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbeKBCHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:07:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35931 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeKBCHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:07:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so1900393wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=57dnXABPcNFWr3aw4yDSFPDZMvwo8dfv9fBdKnyPYqI=;
        b=FpBO+TeG+hhWF1spEVcA7zlQhuIKYEdFBJJSnmvi/07WrieCLnaCrdCYDnLg5ejFfv
         GUo8FNR8MgFyT29qo/R2g+eQPC61cp7Eeq5+nW2ySk6bvWfPSnQMsO1M71frrqgBIcRJ
         BNRM74L0WIY4Hls34/QUYViJrWAqkvqlEq4mFkHpicB78GbHj18dqvV05RB83sw/wmln
         z5RRAUUfB09QeMQ74993GUTFZI63faLBuiwFpLOvLrGBA0ufRWEfOxwNCxMIjSLqRYhi
         u/BOC4s0uwBTCryAkgn2+VQEvFoA3Zy4mFakxHlrlZoJsS/qcpcWuk79YV5QDyO0HNhV
         9sjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=57dnXABPcNFWr3aw4yDSFPDZMvwo8dfv9fBdKnyPYqI=;
        b=R5LNkWml8DM/gCpF4E9X5dJi26EZFzuL61DfyqmThnaRrmWbIrR8cgnsqwTuFIPqPN
         wwb78y3ENhPBwml2vhBz66gQRLHDiMFdBYx3d3XFILjq8eSm8wxbZDFx4dAYNhivIrIj
         QWt5JseaCE4V4cwivHpEvAjgU/R13CtI660GEMRZsvWOcHLfgp+pzYzgYvG9pTjqTiq2
         itzcR0cpjhiqG3J3f0n/R1AjVElO/ka1fEDrhle3XVJLjdbssw85kd5IlbQkW60tOb0M
         sKDDv/QEicCey+vHIKvBH802hRTMmdhud9rfD/50wXbcY2zsh4FvTBnnmEh1u4Lrg1yf
         CRvA==
X-Gm-Message-State: AGRZ1gIdDeDoX20HGHbXj+SvJ+4vivYj1NCKLrMefuCIgmbnFz9ep07O
        nh/C22gQqH0xI8nMj02bGxijzanu
X-Google-Smtp-Source: AJdET5fupQa0s21BljZqwYX46eJoQxoT4zGuCtQ6BFNYt68MOrgvk832HpP2Yp7yWlmyREwSMVPB0g==
X-Received: by 2002:a1c:6:: with SMTP id 6-v6mr6104191wma.126.1541091829756;
        Thu, 01 Nov 2018 10:03:49 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:bc68:3d44:305d:951f? ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id n1-v6sm13507762wra.59.2018.11.01.10.03.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 10:03:49 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8188eu: fix small typo
To:     Yangtao Li <tiny.windzz@gmail.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20181101155037.23274-1-tiny.windzz@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <e2063a51-0f03-c818-1cc0-9207539398d9@gmail.com>
Date:   Thu, 1 Nov 2018 18:03:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181101155037.23274-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/18 4:50 PM, Yangtao Li wrote:
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>   drivers/staging/rtl8188eu/hal/odm_rtl8188e.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
> index d5001920f77c..5352b0e45cac 100644
> --- a/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
> +++ b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
> @@ -273,7 +273,7 @@ static void rtl88eu_dm_hw_ant_div(struct odm_dm_struct *dm_odm)
>   	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
>   		entry = dm_odm->pODM_StaInfo[i];
>   		if (IS_STA_VALID(entry)) {
> -			/* 2 Caculate RSSI per Antenna */
> +			/* 2 Calculate RSSI per Antenna */
>   			main_rssi = (dm_fat_tbl->MainAnt_Cnt[i] != 0) ?
>   				     (dm_fat_tbl->MainAnt_Sum[i]/dm_fat_tbl->MainAnt_Cnt[i]) : 0;
>   			aux_rssi = (dm_fat_tbl->AuxAnt_Cnt[i] != 0) ?
> 

Hi Yangtao,

this typo was already fixed in commit

0f912f9de117 staging: rtl8188eu: fix spelling mistake in comment

Seems you used an outdated staging tree.

Regards,
Michael
