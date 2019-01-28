Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48496C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17EBF2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="o1/GRy4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfA1PFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:05:08 -0500
Received: from sonic312-21.consmr.mail.gq1.yahoo.com ([98.137.69.202]:39338
        "EHLO sonic312-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbfA1PFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1548687906; bh=nZUNF3cU75QWmp9Uw4woUYCRRu05eEtx6Z2y/lc0jzA=; h=From:Subject:To:Cc:References:Date:In-Reply-To:From:Subject; b=o1/GRy4/yjnTSoGsoTcv+noLnHJMpphFNfHhpT4GLZZ8zdClG0DDA0jrMRpDdza5va2Wk/LHfkzLjMymDtHl2pBUV7lNzRoyOQJV6kxlh4R6FY1QGLq1maAZ/qjKfr/8yeYwxGdWs765Vo8f/RWwBqHMhJlp9Jv8DC+3Tn1JOe7y9KTgu+rETeIX6OhXu2/t+18cEo03uMJaK0Od/qBPPMReFCClKNZor9R3JQ8Iv501U8W3XK0dBELdXHlt28ZBJQgVcRn4ptsHp9ke5bk5J8evskpyTEwrKYLq2u1v4GFCK2WUiHxeq5gGfnv2Lhr8mTYmoelm//pqvhMtLxbNpw==
X-YMail-OSG: IJKEsC4VM1kqfGWOFm3ku9a7.HqyKKeORHkw53eCn5c6p_b_QurHyDuSyojwVoy
 oaePkaG_Un63goP49I35MJAFExOTpEUlFnM9cScZeS_2h6m.jX2Y7Fag4tlK5_JIsB_DVHGzXbK_
 k763eqz1d7EbiNDyRoe8SFm8i89fvMk_TbhRv.udrCj8O3kGj1ygEsJPdgTVxY7gXdtduKjB5pFg
 uxU3SfObuRoITw4KonIvWoWuHFnzMIWFoiFHB6PimUMRvoVBSIGzQw4Ziih1V6zuxP6TcvSKyNsr
 eiUNAjB64SrIbSYJjR4FbOBhDOGtNY51_BrGe4X4ILE8oz7L6KJp3hc7yKLLQ08fmJ3_zgvmd02a
 o_DpM_U02lH3sjm6yntOw0dycUXj_1cUQ7y9BPmBH.jRdzsT9oN7ptYY22cnWMjbfWyHE33A0OxC
 MGOh8wiq82ELfoUHxg8scDWtIKcjQUC.Ya6SutETuyJUK4zPnQ9W7E06VUyAX9K8WffQKHHWHUPK
 3ym9t50_1pO4OaYR7ASV1ywewY7ncyqcmYBFcgM4z53VMT1.akoKDfEn4UxskIUyqarhJwm9a2ON
 VrKjXWkSxffjrxHyk6XIankROnEnRcWzpHApGQXrYLl5vOE.cDZGvkvG0.GUNniMCrr9v5Zrgk.S
 D6skL8cREgBHTdKaKc7KGQaMXRRRaSw8_Iu5BP384dtb9.p9rsu3xnctM44keniG_Cjd9n3zHptl
 cVvjVXWKnY5YUg_5JEOdHn7xfSnv1O05ZszwcwuCh96zGwjKd35NQXBGW3xtc9Dd9IEuHRXUPn2B
 OFc.yRcw1V1wICyaqejG.51.lc45KyDoSCiH7h0oIBWEInO31bRCe0YK3TR2sdczrZ0Plj9ndvkK
 mtNmGlv_XZOAguucehS8VObXg58yi_VrGGiMo6uWiLwQzUnkwDVGA47IuqZuWAFNuzrvl37cYUZn
 mYEDZxD2mgSLUXlKCjCuk2ex3yLqRdMYxIZmCyPAUmCa65MJcZkMwks7a_zQ4lEC7RtVnots9cdH
 5mCYnHoQBgp40X9ACX8JCD.q2DoAGvYTNZzoWj.mLKVjQiyFqBX73UC88ZOrGU4jgIw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Mon, 28 Jan 2019 15:05:06 +0000
Received: from 125.122.220.11 (EHLO [10.1.1.220]) ([125.122.220.11])
          by smtp414.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 691e274c8b474b426f4c730eecab875f;
          Mon, 28 Jan 2019 15:05:01 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH v2 2/2] staging: erofs: complete POSIX ACL support
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
References: <20190125161007.4447-1-gaoxiang25@huawei.com>
 <20190125161007.4447-2-gaoxiang25@huawei.com>
 <94daa491-40c8-4a09-a0b5-55a7e92dc3fc@huawei.com>
 <20190128133302.GI1795@kadam>
 <f1fd2c69-0c5b-c655-3712-48169e87fff8@huawei.com>
 <20190128142837.GJ1795@kadam>
Message-ID: <3a304a58-2ba3-b452-53ba-8286b1707795@aol.com>
Date:   Mon, 28 Jan 2019 23:04:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128142837.GJ1795@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/28 22:28, Dan Carpenter wrote:
> The point is, that people shouldn't recreate core code that already
> exists.  At least try it out and have an explanation why the other code
> doesn't work.
> 
> In other projects, the default is to keep code around once it has been
> written but in staging the default choice is to delete the code unless
> there is an explanation.

That is why I need Chao's idea about the future of EROFS fault injection.

As far as I know, the fault injection of f2fs also introduces after
the general fault injection, and the original reason is to test separated
partitions with different fault injection rate/type simultaneously, as follows:

commit 1ecc0c5c50ce8834f7e35b63be7480bf1aaa4155
Author: Chao Yu <yuchao0@huawei.com>
Date:   Fri Sep 23 21:30:09 2016 +0800

    f2fs: support configuring fault injection per superblock

    Previously, we only support global fault injection configuration, so that
    when we configure type/rate of fault injection through sysfs, mount
    option, it will influence all f2fs partition which is being used.

    It is not make sence, since it will be not convenient if developer want
    to test separated partitions with different fault injection rate/type
    simultaneously, also it's not possible to enable fault injection in one
    partition and disable fault injection in other one.

    >From now on, we move global configuration of fault injection in module
    into per-superblock, hence injection testing can be more flexible.

    Signed-off-by: Chao Yu <yuchao0@huawei.com>
    Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

For this patch, I could resend v4 to change erofs_kmalloc->kmalloc
if you like, it isn't an important stuff for this patch. However,
I'd like to get more ideas about the fault injection.

Thanks,
Gao Xiang

> 
> regards,
> dan carpenter
> 
