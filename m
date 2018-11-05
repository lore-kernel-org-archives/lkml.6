Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C787C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E4E20869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Uzmu3w4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E4E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbeKEUlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:41:11 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12780 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbeKEUlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:41:11 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5be027c60000>; Mon, 05 Nov 2018 03:21:42 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 05 Nov 2018 03:21:57 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 05 Nov 2018 03:21:57 -0800
Received: from [10.26.11.240] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 5 Nov
 2018 11:21:44 +0000
Subject: Re: [PATCH 4.14 000/143] 4.14.79-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <akpm@linux-foundation.org>, <shuah@kernel.org>,
        <patches@kernelci.org>, <ben.hutchings@codethink.co.uk>,
        <lkft-triage@lists.linaro.org>, <stable@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20181102182857.064326086@linuxfoundation.org>
 <34e8a999-20e1-5e7d-863b-b0585a24e83b@roeck-us.net>
 <20181103150434.GA24235@kroah.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <978c5bb4-d049-ba9f-bda1-43c618523046@nvidia.com>
Date:   Mon, 5 Nov 2018 11:21:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181103150434.GA24235@kroah.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1541416902; bh=dRQ7W+YcYkmTbsssTkWdn4iXgKzTBurpgrghzc2QkHE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Uzmu3w4L6ZpuO/lZY84K2yGpujUUyQcPefU5RZhgxGbPXd+GUZ6Fgpw1nYks6Eslo
         yqa715L9Axp+0lFU1FDDEwFothxplMmQUqSujOLa5kO2XkwTrm41iFoNMVf+pRB1ge
         K7D2/NEi0R/y4iw9go9uA+xJq3BCoHDmlmctgPwlrydCpa2lCpDjvuK+dB/R4dqZfw
         vq1GF1PIlO+vDXqwcVQDm4wiD/SwSW2Wv+/OB//bP9Oa3M/OAAQFC4dT40DQ4Rchp+
         sW2rsNK9Ebj27nBAlP6e6XYqmgdT1O7G2DBY33LbUzjRSRUFPdTvH084A7RGxx+sl8
         iXwuONuhVZN2Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/11/2018 15:04, Greg Kroah-Hartman wrote:
> On Sat, Nov 03, 2018 at 07:31:42AM -0700, Guenter Roeck wrote:
>> On 11/2/18 11:33 AM, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 4.14.79 release.
>>> There are 143 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Sun Nov  4 18:27:59 UTC 2018.
>>> Anything received after that time might be too late.
>>>
>>
>> Build results:
>> 	total: 150 pass: 149 fail: 1
>> Failed builds:
>> 	xtensa:allmodconfig
>> Qemu test results:
>> 	total: 318 pass: 318 fail: 0\
>>
>> Build failure:
>>
>> In file included from include/linux/mlx5/port.h:36:0,
>>                  from include/linux/mlx5/driver.h: In function =E2=80=98=
mlx5_get_vector_affinity_hint=E2=80=99:
>> include/linux/mlx5/driver.h:1208:13: error:
>> 	=E2=80=98struct irq_desc=E2=80=99 has no member named =E2=80=98affinity=
_hint=E2=80=99
>>
>> Caused by commit 19b743c448db ("net/mlx5: Fix mlx5_get_vector_affinity f=
unction").
>=20
> Odd, this should be fixed by a later patch in the same queue, as 0 day
> also reported this.
>=20
> Yes, e3ca34880652 ("net/mlx5: Fix build break when CONFIG_SMP=3Dn") in th=
e
> 4.14 tree should resolve this.  Ah, Sasha added it at the "last minute"
> after I did the -rc1 release.  So this should be resolved now, I'll push
> out a -rc2 so that it can be verified...

All tests are passing for Tegra ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    14 tests:	14 pass, 0 fail

Linux version:	4.14.79-rc2-gb825fd9
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

--=20
nvpublic
