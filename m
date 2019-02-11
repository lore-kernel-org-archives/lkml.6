Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCA2C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B40214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="a+Oh3++W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfBKXeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:34:31 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10946 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfBKXeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:34:31 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6206850001>; Mon, 11 Feb 2019 15:34:29 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 11 Feb 2019 15:34:28 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 11 Feb 2019 15:34:28 -0800
Received: from [172.17.136.14] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 11 Feb
 2019 23:34:27 +0000
Subject: Re: [PATCH] arm64: tegra: add topology data for Tegra194 cpu
From:   Bo Yan <byan@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1548959754-3941-1-git-send-email-byan@nvidia.com>
 <20190131222517.GB13156@mithrandir>
 <dc0055ca-b9eb-bcc6-1815-2aa482fa7c1f@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <a94ab8ed-e8e7-b239-d9f1-498f6f9348e1@nvidia.com>
Date:   Mon, 11 Feb 2019 15:34:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <dc0055ca-b9eb-bcc6-1815-2aa482fa7c1f@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549928069; bh=1glK6oxJf2jb2Gzl0u5WmusBmAGiqR6gudPU2GymtYU=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=a+Oh3++WvJ1KcToIdihDS+zk6JpMwjP7yevmjLO34NFQMoBCh9hK7s7IoxOmEgoH1
         4Sm7UdL8MsBoYFXvd/jLTSw7EJJloM3oTQ/LpQGY8nradvagaGxxS964Mz/wyfyukO
         wMjn9EAgy5ZmiCX/yUl/8Kq6kVY49CEa8BMXEwB+BgRpte9sMNC8lxtHGd5Lwj7LzM
         7nBJFMfHOcYD4b8b8e9Y8UVe5RRtJvk6MKkgASojjdViBcYZE/vsfzTy7lE4mHK8A8
         yCz+bKYD9zsp42DVJKDrdhsNDsGSaPViOEF7qrNH00Wkl491dYBlZdLWxjTr1RyZ7Y
         tSLpgO51wvpFA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make this simpler, I think it's best to isolate the cache information=20
in its own patch. So I will amend this patch to include topology=20
information only.

On 1/31/19 3:29 PM, Bo Yan wrote:
>=20
> On 1/31/19 2:25 PM, Thierry Reding wrote:
>> On Thu, Jan 31, 2019 at 10:35:54AM -0800, Bo Yan wrote:
>>> The xavier CPU architecture includes 8 CPU cores organized in
>>> 4 clusters. Add cpu-map data for topology initialization, add
>>> cache data for cache node creation in sysfs.
>>>
>>> Signed-off-by: Bo Yan <byan@nvidia.com>
>>> ---
>>> =A0 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 148=20
>>> +++++++++++++++++++++++++++++--
>>> =A0 1 file changed, 140 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi=20
>>> b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>>> index 6dfa1ca..7c2a1fb 100644
>>> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>>> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>>> @@ -870,63 +870,195 @@
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 #address-cells =3D <1>;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 #size-cells =3D <0>;
>=20
>> These don't seem to be well-defined. They are mentioned in a very weird
>> locations (Documentation/devicetree/booting-without-of.txt) but there
>> seem to be examples and other device tree files that use them so maybe
>> those are all valid. It might be worth mentioning these in other places
>> where people can more easily find them.
>=20
> It might be logical to place a reference to this document=20
> (booting-without-of.txt) in architecture specific documents, for=20
> example, arm/cpus.txt. I see the need for improved documentation, but=20
> this probably should be best done in a separate change.
>>
>> According to the above document, {i,d}-cache-line-size are deprecated in
>> favour of {i,d}-cache-block-size.
>=20
> Mostly, this seems to be derived from the oddity of PowerPC, which might=
=20
> have different cache-line-size and cache-block-size. I don't know if=20
> there are other examples? It looks like the {i,d}-cache-line-size are=20
> being used in dts files for almost all architectures, the only exception=
=20
> is arch/sh/boot/dts/j2_mimas_v2.dts. On ARM and ARM64, cache-line-size=20
> is the same as cache-block-size. So I am wondering whether the=20
> booting-without-of.txt should be fixed instead? just to keep it=20
> consistent among dts files, especially in arm64.
>=20
>>
>> I also don't see any mention of {i,d}-cache_sets in the device tree
>> bindings, though riscv/cpus.txt mentions {i,d}-cache-sets (note the
>> hyphen instead of underscore) in the examples. arm/l2c2x0.txt and
>> arm/uniphier/cache-unifier.txt describe cache-sets, though that's
>> slightly different.
>>
>> Might make sense to document all these in more standard places. Maybe
>> adding them to arm/cpus.txt. For consistency with other properties, I
>> think there should be called {i,d}-cache-sets like for RISC-V.
>>
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 l2-cache =3D <&l2_0>;
>>
>> This seems to be called next-level-cache everywhere else, though it's
>> only formally described in arm/uniphier/cache-uniphier.txt. So might
>> also make sense to add this to arm/cpus.txt.
>=20
> the improved documentation is certainly desired, I agree.
>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 };
>>> -=A0=A0=A0=A0=A0=A0=A0 cpu@1 {
>>> +=A0=A0=A0=A0=A0=A0=A0 cl0_1: cpu@1 {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "nvidia,tegra194=
-carmel", "arm,armv8";
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_type =3D "cpu";
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x10001>;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enable-method =3D "psci";
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-size =3D <131072>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-line-size =3D <64>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-sets =3D <512>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache-size =3D <65536>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache-line-size =3D <64>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache_sets =3D <256>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 l2-cache =3D <&l2_0>;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 };
>>> -=A0=A0=A0=A0=A0=A0=A0 cpu@2 {
>>> +=A0=A0=A0=A0=A0=A0=A0 cl1_0: cpu@2 {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "nvidia,tegra194=
-carmel", "arm,armv8";
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_type =3D "cpu";
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x100>;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enable-method =3D "psci";
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-size =3D <131072>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-line-size =3D <64>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-sets =3D <512>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache-size =3D <65536>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache-line-size =3D <64>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache_sets =3D <256>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 l2-cache =3D <&l2_1>;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 };
>>> -=A0=A0=A0=A0=A0=A0=A0 cpu@3 {
>>> +=A0=A0=A0=A0=A0=A0=A0 cl1_1: cpu@3 {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "nvidia,tegra194=
-carmel", "arm,armv8";
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_type =3D "cpu";
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x101>;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enable-method =3D "psci";
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-size =3D <131072>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-line-size =3D <64>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-sets =3D <512>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache-size =3D <65536>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache-line-size =3D <64>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache_sets =3D <256>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 l2-cache =3D <&l2_1>;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 };
>>> -=A0=A0=A0=A0=A0=A0=A0 cpu@4 {
>>> +=A0=A0=A0=A0=A0=A0=A0 cl2_0: cpu@4 {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "nvidia,tegra194=
-carmel", "arm,armv8";
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_type =3D "cpu";
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x200>;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enable-method =3D "psci";
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-size =3D <131072>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-line-size =3D <64>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-sets =3D <512>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache-size =3D <65536>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache-line-size =3D <64>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache_sets =3D <256>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 l2-cache =3D <&l2_2>;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 };
>>> -=A0=A0=A0=A0=A0=A0=A0 cpu@5 {
>>> +=A0=A0=A0=A0=A0=A0=A0 cl2_1: cpu@5 {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "nvidia,tegra194=
-carmel", "arm,armv8";
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_type =3D "cpu";
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x201>;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enable-method =3D "psci";
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-size =3D <131072>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-line-size =3D <64>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-sets =3D <512>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache-size =3D <65536>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache-line-size =3D <64>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache_sets =3D <256>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 l2-cache =3D <&l2_2>;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 };
>>> -=A0=A0=A0=A0=A0=A0=A0 cpu@6 {
>>> +=A0=A0=A0=A0=A0=A0=A0 cl3_0: cpu@6 {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "nvidia,tegra194=
-carmel", "arm,armv8";
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_type =3D "cpu";
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x10300>;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enable-method =3D "psci";
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-size =3D <131072>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-line-size =3D <64>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-sets =3D <512>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache-size =3D <65536>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache-line-size =3D <64>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache_sets =3D <256>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 l2-cache =3D <&l2_3>;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 };
>>> -=A0=A0=A0=A0=A0=A0=A0 cpu@7 {
>>> +=A0=A0=A0=A0=A0=A0=A0 cl3_1: cpu@7 {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "nvidia,tegra194=
-carmel", "arm,armv8";
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_type =3D "cpu";
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x10301>;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enable-method =3D "psci";
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-size =3D <131072>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-line-size =3D <64>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i-cache-sets =3D <512>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache-size =3D <65536>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache-line-size =3D <64>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d-cache_sets =3D <256>;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 l2-cache =3D <&l2_3>;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 };
>>> =A0=A0=A0=A0=A0 };
>>> +=A0=A0=A0 l2_0: l2-cache0 {
>>> +=A0=A0=A0=A0=A0=A0=A0 cache-size =3D <2097152>;
>>> +=A0=A0=A0=A0=A0=A0=A0 cache-line-size =3D <64>;
>>> +=A0=A0=A0=A0=A0=A0=A0 cache-sets =3D <2048>;
>>> +=A0=A0=A0=A0=A0=A0=A0 next-level-cache =3D <&l3>;
>>> +=A0=A0=A0 };
>>
>> Does this need a compatible string? Also, are there controllers behind
>> these caches? I'm just wondering if these also need reg properties and
>> unit-addresses.
>=20
> No need for compatible string. No reg properties and addresses. These=20
> will be parsed by drivers/of/base.c and drivers/base/cacheinfo.c, they=20
> are generic.
>>
>> arm/l2c2x0.txt and arm/uniphier/cache-uniphier.txt describe an
>> additional property that you don't specify here: cache-level. This
>> sounds useful to have so that we don't have to guess the cache level
>> from the name, which may or may not work depending on what people name
>> the nodes.
>=20
> the cache level property is implied in device tree hierarchy, so after=20
> system boots up, I can find cache level in related sysfs nodes:
>=20
>  =A0=A0=A0 [root@alarm cache]# cat index*/level
>  =A0=A0=A0 1
>  =A0=A0=A0 1
>  =A0=A0=A0 2
>  =A0=A0=A0 3
>=20
>=20
>>
>> Also, similar to the L1 cache, cache-block-size is preferred over
>> cache-line-size.
>>
>>> +=A0=A0=A0 l3: l3-cache {
>>> +=A0=A0=A0=A0=A0=A0=A0 cache-size =3D <4194304>;
>>> +=A0=A0=A0=A0=A0=A0=A0 cache-line-size =3D <64>;
>>> +=A0=A0=A0=A0=A0=A0=A0 cache-sets =3D <4096>;
>>> +=A0=A0=A0 };
>>
>> The same comments apply as for the L2 caches.
>>
>> Thierry
>>
