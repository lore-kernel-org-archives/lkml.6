Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AA5C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A15120870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="r39Q1D5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A15120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeLLHpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:45:22 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3340 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLHpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:45:22 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c10bc8d0000>; Tue, 11 Dec 2018 23:45:17 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 11 Dec 2018 23:45:21 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 11 Dec 2018 23:45:21 -0800
Received: from [10.24.229.42] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 12 Dec
 2018 07:45:17 +0000
Subject: Re: [PATCH] scatterlist: Update size type to support greater then 4GB
 size.
To:     Sagi Grimberg <sagi@grimberg.me>,
        David Miller <davem@davemloft.net>
CC:     <axboe@kernel.dk>, <ulf.hansson@linaro.org>,
        <herbert@gondor.apana.org.au>, <mmaddireddy@nvidia.com>,
        <Snikam@nvidia.com>, <adrian.hunter@intel.com>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <vdumpa@nvidia.com>, <linux-crypto@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
 <20181211.222950.1995970751331458343.davem@davemloft.net>
 <5f70fc16-e3cd-37c1-e7ed-e131ad79d387@grimberg.me>
From:   Ashish Mhetre <amhetre@nvidia.com>
Message-ID: <eea4ccbb-a750-581f-525c-ce05d912f537@nvidia.com>
Date:   Wed, 12 Dec 2018 13:15:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5f70fc16-e3cd-37c1-e7ed-e131ad79d387@grimberg.me>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544600717; bh=dRCdnkKRT/cp8bs2ZIqwFpii6YCnBYNnaggI8TtZ/q4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=r39Q1D5LZbKs6pTBSo8VItNNpRz7XtnEVbsOwfAfj9LS8OI5sMMk/IDuXCF1T0nGR
         u94rM8vkQjw6+yOmsbJWH/RhDsEkIyQgiud+SzpVenO0Y3QL80OyY4oK7MS/YhE592
         lJdI86j3YeJwR/tFAwhlh3RvYzg05ihZ0Cr5r82CVD8rH7X3UmDfebsup4YKXZrMJp
         6wSa08fuM+XOIkh8rfrbeqZWjc8WDNpWKghvM+AWUAXV/nBt2VhY1uIq9p1rfOkRf2
         dTBL8jDRs0TcTfVf13xLMDN95zNOSAeLXG1n8hjBB0dlRHL5vUQGH6oAWVHiXISRvM
         TTdi34Mgapv3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/18 12:19 PM, Sagi Grimberg wrote:
>=20
>>> =C2=A0 struct nvme_sgl_desc {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __le64=C2=A0=C2=A0=C2=A0 addr;
>>> -=C2=A0=C2=A0=C2=A0 __le32=C2=A0=C2=A0=C2=A0 length;
>>> +=C2=A0=C2=A0=C2=A0 __le64=C2=A0=C2=A0=C2=A0 length;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0 rsvd[3];
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0 type;
>>> =C2=A0 };
>>
>> Isn't this a device or protocol defined datastructure?=C2=A0 You can't j=
ust
>> change it like this.
>=20
> You're correct, we can't...
> [Replied before seeing this issue was already highlighted]
>=20
> The positive side is that it can safely be removed without affecting the
> rest of the patch...

Ohh, I am not aware of this protocol defined data-structures. But it=20
seems that this need not be changed as Sagi is saying sg length for NVME
will never cross 32 bit size.
I'll send a new version removing this change. Thanks.
