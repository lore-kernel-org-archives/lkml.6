Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB6EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B14C20867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B14C20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeIDR6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:58:09 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:56687 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726355AbeIDR6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:58:09 -0400
Received: from [172.20.20.131] (unknown [182.150.46.145])
        by APP-10 (Coremail) with SMTP id tACowAAnLsZ5iY5bBftyBw--.12338S2;
        Tue, 04 Sep 2018 21:32:42 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 05/16] x86/pmu: enable Hygon support to PMU
 infrastructure
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <cover.1535459012.git.puwen@hygon.cn>
 <dcd5b900e26e3175e4cafded91ec28e53c79adf8.1535459013.git.puwen@hygon.cn>
 <20180904104812.GF32615@zn.tnic>
Message-ID: <f97a0b69-3117-3f59-257e-3aa837f54444@hygon.cn>
Date:   Tue, 4 Sep 2018 21:32:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904104812.GF32615@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: tACowAAnLsZ5iY5bBftyBw--.12338S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw18ZF4kAry8XFyftr1kXwb_yoWDtrb_uw
        4rtFZ0kwsFgr409F4kJF45C39rXr18JryIqas5CasrX39YyanYqr1qkrW8CF4SkFWS9F12
        kr13Xa1Iy3W7ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z2
        80aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4UJVWxJr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7ZqXDUUUU
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/4 18:48, Borislav Petkov wrote:
> On Wed, Aug 29, 2018 at 08:43:54PM +0800, Pu Wen wrote:
>> Hygon PMU arch is similar to AMD Family 17h. To support Hygon PMU, the
>> initialization flow for it just call amd_pmu_init() and change PMU name
>
> That sentence reads funny.

Will rewrite this sentence to make it more understandable. :)

> In general, you seem to be explaining *what* your patches do and not
> *why*. This is the wrong. Always explain the *why* - the *what* is
> visible from the diff.
>
> You probably need to brush up on
> Documentation/process/submitting-patches.rst, section 2.

All right, will relearn the document and rework the patch descriptions.

>> +	case 0x18:
>> +		if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
>> +			pr_cont("Fam18h ");
>
> Didn't we agree that you'll verify whether family 0x18 is going to be
> Hygon only?
>
> What happened to that checking?
...
> Same here.
>
> What's up?

Will remove all the remaining unneeded Hygon vendor checking through
the whole patch set to minimize the code modification.

Thanks,
Pu Wen

