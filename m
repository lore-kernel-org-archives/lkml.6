Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34A0C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC4920645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="fT895Gap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC4920645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeICJJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 05:09:41 -0400
Received: from sonic311-23.consmr.mail.gq1.yahoo.com ([98.137.65.204]:43696
        "EHLO sonic311-23.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbeICJJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 05:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1535950274; bh=y5ay5QDqYS6Cy9fEqWrIgvx1jNtpjVxexzJzNCvfPu4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=fT895GapMXeKmbO2/TCF31Esh57koVE2qFYBdYYOG84/s9Piw8X+GVqvPsVQMBy8cXCN3NIp8NrVWrfHcD02nnDIEnStBJWxfvaWKObInULZSedIrCwl/cmx1y4t/1NgUzXrqWmAN+n5iBfoc8VxVVUy8HfaaLTEij3wamkprg+OdCX6TVeHMt0kflTE0rIO6uh7HipOFikABuOrZprKng4UWAi/4XsjMehvklo/z8uSlnfq8FFtVHR4L73SG8bezP/QtXyN48rnQAld4ojPTCl5O6BES+8H/wcmA0iJZYO5Bt/qztwAaqqZi71TJ8aaTcso5jfFO4+xyf8Fsrk5Hg==
X-YMail-OSG: EvkQoSgVM1nd1623QGkspXWrDSbgpZ3J3BFWf.C5A9tkiwIMWghXuDDnYNF8gpI
 4qoEBjeFog3ETImzxOPl4Uatyx7TIqiec6bPr4JHXG5e_3C_WzCmF8PKDllU63jAs8BHT76Pf7cp
 TEaY2.QGC9Nbl.H225mcBMzCBidVXKnm4n7iaqVw8oU9fxoiaWtWWOUevv3_WcFDdDxb.6e_aRvd
 jprIY.c.FL2fwsI1Uc1GJi_Ku0cvlPQECf01N_buW_vjGKuBWDc8Yk6aZwbVPCFDbweg1x2egoqD
 htUT6XwuxIh7qHbuHCaZCy9ls7I09rlVDsuNKUOF7pP6LPtgUkaLGthWACk2ODdpzTNhJYstX2hm
 _oZLXWOYDK48K8tmmMh40Xfrl3fUVYiOZhDYPsWrR25FFJ9lFErbFlysjBchwWkrm3Q3FrG.mCj5
 tEymQd6hOD.jCF242KhhQy_CfjY4kimZt9Ke3gpF5TZqYaIlehXkr7XqsBa8x8VhJX1p5OADs8wX
 TwiUEd9jd7OKnsGZMm7.HN1snuS7tIiRGLAlovkmmiRNu9Phs4hmZ9XvLQNRNgbyH8cZ6Z2WAq9x
 VtXS7jQ9mvXMr8Hmgp7DgXocnfOGjH6KK55ZZT1WQLvHBO9oSy5M0BxiB8Jcp.utkf111gpf.nW7
 tsJa2Ad1L0fSQsx0oJpJm7d1_hZ6A4Y3_TTDP1vQmyw7Llmqj88NJT2IwQWZSb6RYJYJSIyjtZZr
 AOzNMG_CF6wp9LVHBgP.HOOlZrfFE1g85TjPSPKUYh4ULM5e.wiI9yK.bM8i7UMpleI32mHObM4S
 bIjk76CTaH1sXmL4L6VjjrRfzJRuZnv4mneQe4OkQWVsd.7T2h7.NHc0qBOeG.mguVjO64xy3PxF
 gHOn.OICMCJwBmNB.yeIf3fw48F2t8HaSny91xEaQ7HcSxi45ELNwsQNcgzfTzGpokjtwFOPJbkS
 M4rUtkJJDUmtPBOKT1bvD_RLiLUJB56YLrD3ihxTEAGL2EUkEaZ5r..x.fzTFg0OL7aMw9CAVZT0
 W9p0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Mon, 3 Sep 2018 04:51:14 +0000
Received: from 112.64.119.191 (EHLO [192.168.43.103]) ([112.64.119.191])
          by smtp426.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 15bc3baa96028b767be02eb220f0b030;
          Mon, 03 Sep 2018 04:51:10 +0000 (UTC)
Subject: Re: [PATCH 6/6] staging: erofs: fix 1 warning and 9 checks
To:     Chao Yu <yuchao0@huawei.com>,
        Pavel Zemlyanoy <zemlyanoy@ispras.ru>,
        Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ldv-project@linuxtesting.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <1535642042-5336-1-git-send-email-zemlyanoy@ispras.ru>
 <1535642042-5336-6-git-send-email-zemlyanoy@ispras.ru>
 <3c43c174-c805-32e2-ac8e-504604ef29ab@huawei.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <617a05b1-fc25-aa6e-c4d6-1aec06f72009@aol.com>
Date:   Mon, 3 Sep 2018 12:50:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3c43c174-c805-32e2-ac8e-504604ef29ab@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/3 9:49, Chao Yu wrote:
> On 2018/8/30 23:14, Pavel Zemlyanoy wrote:
>> This patch does not change the logic, it only
>> corrects the formatting and checkpatch checks by
>> braces {} should be used on all arms of this statement,
>> unbalanced braces around else statement and warning by
>> braces {} are not necessary for any arm of this statement.
>>
>> The patch fixes 9 checks of type:
>> "Check: braces {} should be used on all arms of this statement";
>> "Check: Unbalanced braces around else statement";
>>
>> and 1 warning of type:
>> "WARNING: braces {} are not necessary for any arm of this statement".
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
