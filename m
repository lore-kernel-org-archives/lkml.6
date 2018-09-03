Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7CFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB01A20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="HvU/2zXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB01A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbeICIuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 04:50:51 -0400
Received: from sonic307-10.consmr.mail.gq1.yahoo.com ([98.137.64.34]:41060
        "EHLO sonic307-10.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbeICIuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 04:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1535949148; bh=Cf6nfkbxC7mqh6qsh9D63QxZcJ9lGNhvUwvBT6Sg4HQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=HvU/2zXrVx/m8/jlqiw+mZ+unhF/x4uPN0mx8kpbAHxHuSLwizFfVR7gUJ91TwPosr0qfvOjG8SYI+Gehz0JhndRA0pdnr/969cAXtEBzbCnhEt5WyM8kYugMeu2TffvnNLlY7iRuw0GYXbdi4HV3eR6Pqq7vnv+JkHwUkAt2L6NyV1gMuBId14nwFj209Gxv3j0imY2XE8EyBcTFi8jUxeT4giu7nNgw4wEoo6zZJnDlC+Qd4Pu+D4GR5r8HH86puN8a4nnaMuNwdiduHfOgHLlfwySdRKP0gIdkXH+pKViVEs6PVsudH/b2pXcPlRS2GhoQO0kobRDYKlhwOV/Ew==
X-YMail-OSG: GXpHJZ4VM1kLm8YPYaYMthz4aFN0xlALWWVSz2cf1OjMetJb8EeDAd82BE0Ufuq
 VEdgtLWGciYM8x5tvcxHgqAYodf9yd_WOMsTf3CaWEAoZGZJl5m.y2CfnE2wd4TNrA9YD2c0DJK4
 oUjV7AphVa59Y7qGcnbXzMZFP3PQRE50WBjF8mzb_MUf18gzCe0.cPGIEbr6rg4a19864j8_Nr.b
 NXkO3MAL.2BVZPOiNwdDf4MUgRqS5AkGj80cWhZxf9U5_.Mmnl5fAAx0c7mSct0Gzryjhz5CSwG_
 t.lh36e2d54zssujgfPf5ACAEYaevek9MzyvkGICFCrQlmHUAdevNg5a4LHbcX96fYuSnWBLlYVx
 M2yJLYpPxtypiNJLLDCEwI.Fy6VvWR8RQjaxo9n9Ux1XwlFtGYWExa86WKw.rn9HJELqAEJn7qQd
 v5EHhTpn86w7snoS7BMZ..USij_zejndsl5ZRcuUuMzPc4r5V22jL2YePNAKlvcd7Rbzn9h1M5x4
 ToQ0syZ0CS0TvcxRN88Ien5pZgveUTmD67aw0tKU92UTcP_WnHDuRSP99nB32xfMoSI6NsZqQsCj
 IzDi98gMn79Ae4x9PCqhY0cdrLQUafTiHA1wWqhfMpQCXWau4b6adajh8lMM.35meuJD5tkZyjNF
 l8Me_Yovw8uqxENd82qpXnUc2IUzmDjBDRcOnR9Z74abVIhCJGFg20EUkrKaSUMhnKeSAUoVp9eh
 W.UBIxRoLp8QFSFsXY5JCNr9AIPo1D1BQUgmoPk8pTZoyGobO7NAa_b_JXUp7PfjuCq.ovBzhwjH
 8VkAGDLhWC66XmWeBhxFOOE_8ryEHAZRc3bRUcS3LdFPuGQ2Bp6jTbtGUyWn.zWPVyAiSKEgHw.Y
 hyo3gWwQ0_2xI1AUXd64xppp0xe1gTRFncx0F12d7AxDxpMt3n1Z2YFq1eXksGx.0ZnU_moXIkDb
 0x3OyXKVxjjAvqL2tzR8iOWlrGRGzvtvqDn6V..BC0X.kQ2gpf_efS1mePqLrOLmI4_FQ9v0XC9m
 zgnA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Mon, 3 Sep 2018 04:32:28 +0000
Received: from 112.65.61.168 (EHLO [192.168.43.103]) ([112.65.61.168])
          by smtp404.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 002bbf7d784060a33e47a35cc44eee31;
          Mon, 03 Sep 2018 04:32:25 +0000 (UTC)
Subject: Re: [PATCH 3/6] staging: erofs: formatting spaces around '-'
To:     Chao Yu <yuchao0@huawei.com>,
        Pavel Zemlyanoy <zemlyanoy@ispras.ru>,
        Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ldv-project@linuxtesting.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <1535642042-5336-1-git-send-email-zemlyanoy@ispras.ru>
 <1535642042-5336-3-git-send-email-zemlyanoy@ispras.ru>
 <c5c52715-fd7b-b669-bd0c-757b6ce967a5@huawei.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <44741920-4870-d102-d2d4-3bb86f248ebf@aol.com>
Date:   Mon, 3 Sep 2018 12:32:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c5c52715-fd7b-b669-bd0c-757b6ce967a5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/3 9:48, Chao Yu wrote:
> On 2018/8/30 23:13, Pavel Zemlyanoy wrote:
>> This patch does not change the logic, it only
>> corrects the formatting and checkpatch checks by
>> adding spaces around '-'.
>>
>> The patch fixes 4 checks of type:
>> "Check: spaces preferred around that '-'".
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
