Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24F1C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B6F213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IGcg+1qH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B6F213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbeJAUS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:18:27 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33515 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbeJAUS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:18:26 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181001134032euoutp02880c78012725561a710659204e269d1d~Zf8VGtUIQ0865208652euoutp02R
        for <linux-kernel@vger.kernel.org>; Mon,  1 Oct 2018 13:40:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181001134032euoutp02880c78012725561a710659204e269d1d~Zf8VGtUIQ0865208652euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538401233;
        bh=Imz5q2FEfhLr6GoFk4bXsrIFoLHjQlT1MUN3EHlp8e8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IGcg+1qH9GrEylHDriIVVCf61zFSghtjIUE2IMwhmiPr0YXt1BezV4vY+M+oaItZp
         ywD+T99HMtJqqxGV+mxpKNmoIMsF+sr3O2TjWGT1r06qIqfLo8Esnwd+KeaGzlNFZ9
         oGQ9AIoW08y+8INYqao/XCWHcYTgrwd3jeorgf3Q=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181001134032eucas1p2ac4c398c2ac1c7457f8eb8261f993aed~Zf8UPgnAm3107031070eucas1p2c;
        Mon,  1 Oct 2018 13:40:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BA.9F.04806.FC322BB5; Mon,  1
        Oct 2018 14:40:31 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181001134031eucas1p20355222b5692ca99bbeb915b9dbc6818~Zf8TZ4bLI3108031080eucas1p2e;
        Mon,  1 Oct 2018 13:40:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181001134030eusmtrp1df020fdcfadc5cf4075a50c458324c43~Zf8TIar_A1625116251eusmtrp1n;
        Mon,  1 Oct 2018 13:40:30 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-90-5bb223cf9e61
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1E.4A.04128.EC322BB5; Mon,  1
        Oct 2018 14:40:30 +0100 (BST)
Received: from [106.120.51.30] (unknown [106.120.51.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181001134030eusmtip2f1b86a14bdca2b79345faeebd3eb79b9~Zf8ShjEJJ1430414304eusmtip2b;
        Mon,  1 Oct 2018 13:40:30 +0000 (GMT)
Subject: Re: [PATCH v2 7/7] arm64: uprobes - ARM32 instruction probing
To:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, peterz@infradead.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux@armlinux.org.uk, acme@kernel.org, oleg@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@redhat.com,
        k.lewandowsk@samsung.com, namhyung@kernel.org, jolsa@redhat.com,
        m.szyprowski@samsung.com
From:   Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
Date:   Mon, 1 Oct 2018 15:40:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <89110505-da2e-3266-c2aa-6e5128c520a4@arm.com>
Content-Language: pl
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRT2d+/d9bqa/FyLHTQKV5FKatHr9qAHVNz+KaOCUqKW3mbkVDYf
        WUSz1FRUUlFzlimKyVKmt6ampLa0WdHDbJGGjx4kSqa9Xyq5XSX/+75zzne+88FhSPmQxJM5
        ERnD6yLVESpaStXd//3E/+liIWTFt/rlbHpfA82mCoUStvayWcKOVmQgtv3xBMEmfrlKssK7
        lxK2q/EKzVrz7iC2uq3XlX3eWkKw5yssFGtpSUasLbOVYO+OvZewQ587qK2YqyquQlzXy06S
        u1npxwmmNJorfrCXu1l+jhttttNc1i0T4r4KC4PcgqWbwviIE3G8LnDzUWl489s+Ivq8+6nc
        nmpkQPVz0pEbA3g1lPSWEulIyshxJYKi18WUSL4h+FhVT4vkK4LcH78kMxKTedBVbFxHkDL8
        DIlkBMFkWf8UYZh5eCeY78odAgXWwqC90TlDYoGApsRq5yYar4P69iTKgSm8BFpGBmgHno8P
        QttAKXJgGfaAB4XvnTNueCNc+3zRqSWxAl69TUIiXgQXLEWkwwBwNgN5gx9IURwH9pIeJJ69
        HUwVjdMR5sGw7ZariBfAo9wMSsTx0NTR7SouSkKQl9hKiI2NMG7Kph3JSOwL5sZAsbwNqscG
        nYEBu8OrEQ/xHnfIqSsgxbIMUlPk4rQ/3PljmHbyAntiPnEJqYyzUhpnJTPOSmb871uCKBNS
        8rF6rYbXr4rk4wP0aq0+NlITEBqlFdDUAz6atH1vQM3jx6wIM0g1V+aySAiRS9Rx+gStFQFD
        qhSy246SLEydcJrXRR3RxUbweivyYiiVUlZRXBsixxp1DH+S56N53UyXYNw8DWiZwT7SpVRE
        RRgnTL7r8Rtb25WUv147fILbPXbV9GYd0CjTQvabMmtyj3da+k+Grl1R3mTLCw8IV+VYugvK
        6n6l/25/57Im39PnnLdUcbYw6+eGlsylhy8JfU2GT/5P93krl2tdJFtCb0SXe12NTU2Wdux+
        cahTU3VoT6Vn0L3+Mw9VlD5cvdKP1OnV/wDVB9c5fAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsVy+t/xe7rnlDdFG+xdZGzRdW8Hm0XHppms
        FhtnrGe1eL+sh9Hi6Nm/TBaNn+YyW2x6fI3V4vKuOWwWh6buZbRYe+Quu8WlAwuYLJqWbWWx
        2Lq/ldHieO8BJouDH56wWrz8eILFQcBjzbw1jB6Xr11k9ti8Qstj06pONo95JwM9Ni+p93i/
        7yqbR9+WVYwenzfJBXBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mk
        pOZklqUW6dsl6GXse3SPqaCJr2LyrbWMDYzbubsYOTkkBEwkVq1/zt7FyMUhJLCUUeLI16PM
        EAlpiZNvN7FB2MISf651sUEUvWaU+PTpHpDDwSEs4Cax/qAQSI2IQK7E/4lvWEBqmAU2MUns
        OnqWBaJhFpPE+1VXwaayCZhLbD/awgJi8wI1z35znAnEZhFQkdj/9gHYNlGBCInVy1+wQtQI
        Spyc+QSsnlPAWmL+x3awOLOAmcS8zQ+ZIWwRiRuPWhghbHmJ5q2zmScwCs1C0j4LScssJC2z
        kLQsYGRZxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERjz24793LKDsetd8CFGAQ5GJR5eBvlN
        0UKsiWXFlbmHGCU4mJVEeHeChHhTEiurUovy44tKc1KLDzGaAj03kVlKNDkfmI7ySuINTQ3N
        LSwNzY3Njc0slMR5zxtURgkJpCeWpGanphakFsH0MXFwSjUwKsz+YCz63Vb346unD8r6pS8a
        /rt0zaPuTu2+xNUXJ9z7OGeyD2/C9E9KaT+Uu6VPfX6yefnkj1z/XuT+uyBmya56vFw4++Cj
        8xGZ5Ymb/5xrUBa9sEzF8M/2S3LdIu1L3dxWn9Kd6CVxQCyy+e+tRZO1jQq1ZuTJ/5q89FT3
        7+uzNu1I/M940kWJpTgj0VCLuag4EQABZmSBDwMAAA==
Message-Id: <20181001134031eucas1p20355222b5692ca99bbeb915b9dbc6818~Zf8TZ4bLI3108031080eucas1p2e@eucas1p2.samsung.com>
X-CMS-MailID: 20181001134031eucas1p20355222b5692ca99bbeb915b9dbc6818
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180926121218eucas1p1b20a88cfec17c6403a35e4f23de96ade
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180926121218eucas1p1b20a88cfec17c6403a35e4f23de96ade
References: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
        <CGME20180926121218eucas1p1b20a88cfec17c6403a35e4f23de96ade@eucas1p1.samsung.com>
        <1537963925-25313-8-git-send-email-m.slodczyk2@partner.samsung.com>
        <89110505-da2e-3266-c2aa-6e5128c520a4@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Thank you for having a look at my patchset.

On 27.09.2018 19:01, Robin Murphy wrote:
> On 26/09/18 13:12, Maciej Slodczyk wrote:
> [...]
>> @@ -38,16 +78,44 @@ int arch_uprobe_analyze_insn(struct arch_uprobe 
>> *auprobe, struct mm_struct *mm,
>>           unsigned long addr)
>>   {
>>       probes_opcode_t insn;
>> +    enum probes_insn retval;
>> +    unsigned int bpinsn;
>> -    /* TODO: Currently we do not support AARCH32 instruction probing */
>> -    if (mm->context.flags & MMCF_AARCH32)
>> -        return -ENOTSUPP;
>> -    else if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
>> +    insn = *(probes_opcode_t *)(&auprobe->insn[0]);
>> +
>> +    if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
>>           return -EINVAL;
>> -    insn = *(probes_opcode_t *)(&auprobe->insn[0]);
>> +    /* check if AARCH32 */
>> +    if (is_compat_task()) {
>> +
>> +        /* Thumb is not supported yet */
>> +        if (addr & 0x3)
> 
> I'm only skimming, so forgive me if I'm missing something which should 
> be obvious, but this has a big red flag all over it. If "addr" is the 
> actual instruction address (or even a branch target, for a 
> non-interworking branch), plenty of Thumb instructions will just happen 
> to lie at 4-byte-aligned addresses anyway.
> 
That's the same way Thumb instructions are filtered out in arch/arm 
uprobes and kprobes code. I believe that at this point all Thumb 
instruction have bit 0 set. Please correct me if I'm wrong.

> Furthermore, how would this check ever catch anything anyway given 
> !IS_ALIGNED(addr, AARCH64_INSN_SIZE) above?

You're right, there's no point in checking it here. I'll fix it in v3.

Thank you,
Maciej

