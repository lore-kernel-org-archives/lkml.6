Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE41AC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FE720877
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="GgacKHQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FE720877
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeJMPUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 11:20:35 -0400
Received: from sonic316-10.consmr.mail.gq1.yahoo.com ([98.137.69.34]:34279
        "EHLO sonic316-10.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726033AbeJMPUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 11:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1539416667; bh=2Bmj2CFCs+74XMpqqKIXycQzS+UN/pA1qVbQ23+2JdM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=GgacKHQUH9mKujLvDq0gQpA3hYPLl0jfl4UnkOQs2PmLdFsWejd8SzSKQZlI7LeOk86o4zJ5y0E7LWR6SwFqSGANHWWma0idTCpcE+wrpLDXl1j+eNpRjJ45sbqCzn/7tQlBBxvmLiV//hV1TtYhGq5/9FkcsVAJlptjs2ghGsG5XZ1GgrUnJC8ArnL8Zp0lUwwrFsdXr1MWE9D5VXu3QxOj5FLci9cKDWNt64xHkake72hQYlKXIJH66okJZ0omNhhrjdgAog/IxCTaUUEtlBIil1/ewa6XyThNBdihtsdKnNfxyuF8tKwcbazpgq2Yf7Q5bUA5/osFlxVuwKcbcg==
X-YMail-OSG: HNYmv_wVM1m4iWaeVeCXnV3IzjYegIHBeAcA8CrXTwC2Zv.9.Sd6xmmAE1RAgv5
 mWQiVVrsnV_UVPZb7wuqYtYBYkIrQzJrsw1Bt26X8U.fzBHUWN2WpTZsqKD0h2QLe1ZovocdEyDF
 iyRitPRfPa201pXmrfbIvoa0fZ0dWqlE7h8SMWi6FgQdfeWbW_lkxn0yHofp3nxZKqgZNWr1fPwG
 zwaKfDYCoWKB1AupFtJmV.H_0tgOqNvrY5IxD.xlI1StJrbsbnR0E1TJ.6Mm6XtA6F21XJNjbrCS
 nJVQFXvwMvS5.G_cxjLiYsLMK0Zk7D5gl8fDmK53JkNd6DDfphv61TdwESu63nFIErbUneNGzb4T
 PuvRaGhooiez_gCEnGS90f5QvcJR5WvXCMx1idCOclO8dQyl7zLLOJAZdGaTJTviNTcZUtOmHYif
 D..izgnf0UGqeEQktDVNFnt6fqJ9rZ500BadB7ZmOQZEDlywGmkSRz4kFVD6n.IQPKzfIMkub3c1
 VJlABaZZKeBTHMu590eC9fPmpVT9jEGodjk6svXOqLP2WQz5lCvxbaqNK5RYiLxn4VWQD3aypHE_
 JiJPigbAPjlzgEn0Z3QTIVcCNT.ZPjyY73atK2XW67QMP6hBko6eI0PgD_rHhG_lo6ukwmak8xJy
 _A0jJF8ed5O.cKeO3t8MhesrvKz2BNwSwqlhH8aDLPPUF9yWRpkYZer6N1H5nSLEgIJfUIxqWE9K
 IcQSrMFfFpR6dHyKiaAoe4U7_hDz1WROW0NroyX6N37I2rVNioBNMJu6WG1npVquIWGfVX3a6P9K
 AOl12um8IgADv0oX436ziBBw8sv_zNuUySC_pCsX46ZdFuivRcAsCYAW38kJsvPkXC63Q83jfT5a
 sQiGeKWIY2sOak__4PkaD8QtrafONRSJkuFYyzVBA2jwRTPWFUkQI.Jjy3DeMAwbgMT0nfedPf_b
 NPzCFGyZB2m3V1eZEA9F9p101d46pT2_KNU73_ucc4znXh_8qB2NGWah4PlXk8yym8_k93w6EONK
 EA79k7oTOf4yL6U_LGIn9w_WeUTMyXu58mIrNcfiEpBuJkowQXbG4QLfWmNA2sk7zHzBk
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Sat, 13 Oct 2018 07:44:27 +0000
Received: from 183.156.49.100 (EHLO [192.168.199.211]) ([183.156.49.100])
          by smtp408.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 11cbcaf66f0c29d0795f50b10dd25afa;
          Sat, 13 Oct 2018 07:44:23 +0000 (UTC)
Subject: Re: [RFC PATCH] bit_spinlock: introduce smp_cond_load_relaxed
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>,
        Chao Yu <chao@kernel.org>
References: <1539413249-4402-1-git-send-email-hsiangkao@aol.com>
 <20181013070420.GA29914@kroah.com>
 <99c4d824-7bd2-a91f-eaaa-8cfe55c66232@aol.com>
 <20181013073004.GA29921@kroah.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <752f4ea2-7cd7-fff8-ee0b-d9c01204122e@aol.com>
Date:   Sat, 13 Oct 2018 15:44:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181013073004.GA29921@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2018/10/13 15:30, Greg Kroah-Hartman wrote:
> On Sat, Oct 13, 2018 at 03:22:08PM +0800, Gao Xiang wrote:
>> Hi Greg,
>>
>> On 2018/10/13 15:04, Greg Kroah-Hartman wrote:
>>> On Sat, Oct 13, 2018 at 02:47:29PM +0800, Gao Xiang wrote:
>>>> It is better to use smp_cond_load_relaxed instead
>>>> of busy waiting for bit_spinlock.
>>>
>>> Why?  I think we need some kind of "proof" that this is true before
>>> being able to accept a patch like this, don't you agree?
>>
>> There are some materials which discuss smp_cond_load_* earlier.
>> https://patchwork.kernel.org/patch/10335991/
>> https://patchwork.kernel.org/patch/10325057/
>>
>> In ARM64, they implements a function called "cmpwait", which uses
>> hardware instructions to monitor a value change, I think it is more
>> energy efficient than just do a open-code busy loop...
>>
>> And it seem smp_cond_load_* is already used in the current kernel, such as:
>> ./kernel/locking/mcs_spinlock.h
>> ./kernel/locking/qspinlock.c
>> ./kernel/sched/core.c
>> ./kernel/smp.c
>>
>> For other architectures like x86/arm64, I think they could implement
>> smp_cond_load_* later.
> 
> And have you benchmarked this change to show that it provides any
> benifit?
> 
> You need to do that...

OK, it is my responsibility to test this patch in ARM64 indeed.

I will test it later in ARM64 to see if it has any performance difference
after I handled EROFS product landing stuffs (perhaps weeks later,
many urgent stuffs for the current product that I need to solve...)

Or if some warm-hearted folks interest in it, I'm very happy to see other
implementations or comments about that. :)

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
> 
