Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A47FC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D252220779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="E2aH5PyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D252220779
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbeICIsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 04:48:54 -0400
Received: from sonic313-21.consmr.mail.gq1.yahoo.com ([98.137.65.84]:46033
        "EHLO sonic313-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbeICIsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 04:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1535949031; bh=km1GlQoA0mFWojYECQR75iMauuEfD/bTuBHm3XaRg5I=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=E2aH5PyIuHfM1B+rL2F2kuAuXrpvLRgjp9weX4Gm4VYHEO/dxSUXa36w0GjIF8EAxYf6VWz/FKGX5O+jg6lguCtM7LuriEvGfxKtOlfRFfNi2jTLlzUBRiI9eOOXJywAuqv3Mh9sAyth0AnKJMqc5c4KVrZxoR9RAai+lVOBXp6W5Av/p0gH1bQEH9xrKcz8+XfJ0tQQLuPdoIQLDWeBAsh13dEID5SxRVEveVspeak8k3cXOioE3MIteiE6C6pxjgs4/QhlkJ9Sc6g3Tk6K0H3kjjDzIlWmzPN66fI6UJ/IZfZeWByhmRZaYrrWmKQMFW9HgOJnEOCCK8wGr37OxA==
X-YMail-OSG: sV9jGqsVM1naMdQx.0XC41QIU0R_PBbvKj85j0.7gD87DzS8sWkn.FVuMIlnemY
 pJos7cgXVGVofjbicKkVS3gwcAitiHo9fOf8oRSz6hMOVbLMOErGj1Dxsp52S_0JIED1h1DGDpLu
 6t9xZ6XL6GcLGL4tH0TFB4_j6ExZzBrf6gl6hlV.8klreebRGTn2bxJWT7WDojpBMJl2ya5fOlwB
 Y0GSBRK28cOaYGa7.BbamGNRng7DLEoCvw_rlSYpk92FxLn3lLLg0F0jn32xfjlDAsrG96DQQrp1
 n8Trc4OJdAyNTAa2EJ2Tkyrk5xsLwu9ioDwgsIEKLFKbG2K.TUNlwTNPo0H4W_R7tlzCfGBuqwTg
 NF5vm8gc35ln5nFnLG5eYAw5LcoXjotXFr9Zhxd1EwL2l0ZS6U3nRveXg2C2eMfwzNK.s5ET0dsU
 H2ziUEClcm4gu9uGzv8GufmXAcynSOal9HvfC70yF83zfrs0.JYuTfhfc_FfXHuAuZPzIe7sR_BK
 j9Ze_PhwPs73TOUscGevaVyFf3U.RaigyZLk6aPBD_fFlCRemH_dY5XijbqJrk6t8TKuCJZBCwuJ
 jcSIj8DyXBCC4_wx.BKv8StDuJ7MsZF_jeRAbyHy1ATcsu2PZU8jPijbmIywT.naD3F_1sFKQZlj
 OSmpylwJKrQK7GBL8h9nzjdsu80zojv2uNsoxszkKUnLivj3rfOvsqkZ_eRyKquhSaRnGGhDhRcz
 s0CbMy_gfdX2fpLg3wnn7Wip4Wg1eyYrUosuCOJfJdNcUffvd0u3SIfPBuWLrjmIkh8D8zKlQsXi
 2r4GKG8tYOIqjg49ucvHGiudTGKsA9qSWHk7skKzahNJqQurtnESirijYZXaQSkJOnIUcILuA7xt
 4pIDGitAeVrOikUBLIw2sOzgmZbiCTgILCgb1XqVsf1nMrftMiIBfi755f1oSR5PgIhG08nryggL
 YxBSGK8OtxFSHITzIIzvirzDxve_Ffy3kvYkvFhI3WQkB7mQFGdJpS0CKzFHpY.yivdci
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Mon, 3 Sep 2018 04:30:31 +0000
Received: from 112.65.61.168 (EHLO [192.168.43.103]) ([112.65.61.168])
          by smtp404.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6103805d0f51e1750953ae7e81de5bd2;
          Mon, 03 Sep 2018 04:30:31 +0000 (UTC)
Subject: Re: [PATCH 1/6] staging: erofs: formatting fix in unzip_vle_lz4.c
To:     Pavel Zemlyanoy <zemlyanoy@ispras.ru>
Cc:     Chao Yu <yuchao0@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ldv-project@linuxtesting.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <1535642042-5336-1-git-send-email-zemlyanoy@ispras.ru>
 <2ab6d363-1be6-d616-dd66-e81eea6bd31d@huawei.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <e145aa67-f37f-4e02-0418-eb72c9bc7e15@aol.com>
Date:   Mon, 3 Sep 2018 12:30:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2ab6d363-1be6-d616-dd66-e81eea6bd31d@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/3 9:47, Chao Yu wrote:
> On 2018/8/30 23:13, Pavel Zemlyanoy wrote:
>>
>> This patch does not change the logic, it only
>> corrects the formatting and checkpatch warnings by
>> adding "int" to the unsigned type.
>>
>> The patch fixes 11 warnings of the type:
>> "WARNING: Prefer 'unsigned int' to bare use of 'unsigned'"
>>
>> Signed-off-by: Pavel Zemlyanoy <zemlyanoy@ispras.ru>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 

Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang

> Thanks,
> 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
> 
