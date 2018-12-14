Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E798BC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C035E206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="AfneyMFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbeLNNzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:55:18 -0500
Received: from sonic310-12.consmr.mail.ir2.yahoo.com ([77.238.177.33]:36523
        "EHLO sonic310-12.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729977AbeLNNzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1544795715; bh=MhPoqHYigalcZdTXSv8Ril2mdAJpVwAjyHc/4sg76uM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=AfneyMFvQ5AP0Ax+kQALdvx15bF5zJnKawgl+zmuqIElF4H2tyx9mQZvN43ahNwW7Ldj1+r46ln/BWe9n19rIxMOdug0lqMpE1/nOhHeYwwxa0Xa8ufDLRPf2DM0Xf3tjvWIoJGF1bfLuas42BIk8KtCNa5Zv1bSWVoXIpIqDfC4wBzT5N9z5dexdwq3fgZv4b2afGzzB8OXt0Vz8E3LSaHgHJ8wuua0beNuORUKq7+VxvVPrePrGBFXinzz8k288JfvrPAZUO0yCLvvw1O4lTYBwaB0pITphgp5vsuNuPgsFReP49XfwG6bkfoo9GLHYAOFKCUkZ4sqf006ieHrUg==
X-YMail-OSG: rLmJGfYVM1m1GSE02Q1jdz2wqH6_.i3FnRdNrenssd_Yzb3Jt9Pu_cEJmrHQJ5B
 T1iYiFpWZZ9eqotfsb0b5FmQVW6yW04SmaBDcLL2VmtaDIYneUlglet.Vb.Z1vhlVDLK_nVoHEgO
 iFsgrMH62rE6t5ML70CLYZeo4oUPAtC1tzHy7YDFcCbaFJ8W3VBCnvKCAk9mnWaYfsXq7vqCuMxn
 pqVc_HRq.ttb23lcXeU0J0CFlbEyRsjtH5EE0JX3E1VSLVP4G_TLyBTsbR6xaOqGmhQqkyZcn5UD
 b.pFcuCbU5g.48JG4HNzYaysEJqzUM6So2tE8cBmZX7aams_nRkWtqhSzY1piEHhIjKN0m97x6VN
 qLx2ePPWNQlhfhwk9ZYNY5dCL7Iko4c4aEisukLQE1yD4iBouyGzXOzUZ126HPRj2qMlwGXeI_C5
 RM7L0nle9gaynHBZYBZFhYabcHa3blBQf9wg8YM_qa5AH4EnxAGK7Fs88naK5oYzWNFzWvZ45cSN
 kENGKmWW5ZTRzD3Sb6SlraJ_mTzsCrxZNgE.Ws5qB7N7M3WKYfj9.ImCsop0e2mR18uET2M3Wqnp
 Q4CLUh5pwhvS28.Sbx5IqQkInTGMp6qyqj9rYyXaOUO2rNmcts9DNZkR_8UBjCPAJv0AwyCrS2Js
 FrChjrpsjcRLxjwMYHbpUoJonzakcJXvG7YPjLBOTlDbt.bKnq.vV8XMPm77.EDd1DKerXCDgb3T
 ZxeCDzeKMj16l.e5gCb7w3cMO8ZJZy0w6Y_8snwe15xEsXB15sHsogcECkUjGUNRMhNZE5wF8Dxe
 JZ.dG0EjEPZFIf3WqU1k.8j2xh75g1My4In9gJaPM4kM_TeB4b.Ex1a526qAI7sp2H4daVOBrjIW
 Zp9HVlpsRdFGA2S0DSzd5RulFFxGT94xMJbcqT3Rhp4LB_pU0pj530lEncp7.R2HfBlvPlnx7dNX
 OmwwCaNtf2AzcDWK1L1ud_5_1SR3DF2WMvSSxbbGj1N4MOYBYWkL2VrOSgGWBY7XrR0tQH0ViwtW
 Jr8tbwuFQyW9wwpCwCPtp3V_64jiZLshZWfmhn5.laGHG1hwjMi9BuQb89mtd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Fri, 14 Dec 2018 13:55:15 +0000
Received: from 125.120.80.114 (EHLO [10.1.1.220]) ([125.120.80.114])
          by smtp407.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 221acda4e404574648acb715c33f577b;
          Fri, 14 Dec 2018 13:55:12 +0000 (UTC)
Subject: Re: [PATCH] fix page_count in ->iomap_migrate_page()
To:     Richard Weinberger <richard@nod.at>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        zhangjun <openzhangj@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>, hch@lst.de,
        bfoster@redhat.com, Dave Chinner <david@fromorbit.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, n-horiguchi@ah.jp.nec.com,
        mgorman@techsingularity.net, aarcange@redhat.com,
        willy@infradead.org, linux@dominikbrodowski.net,
        linux-mm@kvack.org, Gao Xiang <gaoxiang25@huawei.com>
References: <1544766961-3492-1-git-send-email-openzhangj@gmail.com>
 <1618433.IpySj692Hd@blindfold> <2b19b3c4-2bc4-15fa-15cc-27a13e5c7af1@aol.com>
 <5520068.cAKZ7BqcUI@blindfold>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <d18a4e12-c062-0c6c-52e4-83d5e2a14da5@aol.com>
Date:   Fri, 14 Dec 2018 21:55:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <5520068.cAKZ7BqcUI@blindfold>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On 2018/12/14 21:35, Richard Weinberger wrote:
> Hmm, in case of UBIFS it seems easy. We can add a get/put_page() around setting/clearing
> the flag.
> I did that now and so far none of my tests exploded.

Yes, many existed codes are based on this restriction in order to be freeable race-free.
and that's it since PG_Private was once introduced at first by Andrew Morton in 2002
for many Linux versions....and it's not bad I think... :)

Thanks,
Gao Xiang
