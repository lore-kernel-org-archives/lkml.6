Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9492FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5983A20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="udYO8WKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5983A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeLJIEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:04:41 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44804 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLJIEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:04:41 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBA843Ii061422;
        Mon, 10 Dec 2018 02:04:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544429043;
        bh=YUaTvCEoGoQ9M/VI0rsqshq+eCmW3OAv+7vup59ErDI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=udYO8WKM5MDXlSNpxfdpt6V1JIXBVzy54EBqiVDP0g6IdSeLIAH0vB4YLi6k7WW5H
         EoYHqBpu2ZGHl8FUnaQ7mRs9GvA6VJZsePLVVKD6L3Ko/FZVBdWBCX5ogKExB/5LMt
         LlN6WavWzN9BVFC/gRIwlIipo2HqR0CHhGUeIZ0k=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBA843d9045242
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Dec 2018 02:04:03 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 02:04:02 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 02:04:02 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBA83u76031129;
        Mon, 10 Dec 2018 02:03:59 -0600
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am654-base-board: Add MMC/SD
 support
To:     Nishanth Menon <nm@ti.com>, Faiz Abbas <faiz_abbas@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <t-kristo@ti.com>, <kishon@ti.com>,
        <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <michal.simek@xilinx.com>, Tony Lindgren <tony@atomide.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20181207084233.13700-1-faiz_abbas@ti.com>
 <20181207084233.13700-3-faiz_abbas@ti.com>
 <20181208155427.jmidz4vsw4k4qj36@akan>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <c1dd9783-84dc-9dad-ea94-9a14a4ad814d@ti.com>
Date:   Mon, 10 Dec 2018 13:33:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181208155427.jmidz4vsw4k4qj36@akan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/18 9:24 PM, Nishanth Menon wrote:
> On 14:12-20181207, Faiz Abbas wrote:
> 
>> +
>> +&sdhci0 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&main_mmc0_pins_default>;
>> +	bus-width = <8>;
>> +	non-removable;
>> +	ti,driver-strength-ohm = <50>;
> 
> ^^
> 
>> +};
>> +
>> +&sdhci1 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&main_mmc1_pins_default>;
>> +	ti,driver-strength-ohm = <50>;
> 
> NAK.
> 
> $ git checkout next-20181207
> $ git grep ti,driver-strength-ohm Documentation
> $
> 
> Nada.. And.. I think "new phy binding" probably introduces this.
> [1] https://patchwork.kernel.org/project/linux-mmc/list/?series=53185
> 
> If your patches are'nt really ready, please send them as RFC, I am not
> really in a mood to track the status of every single driver subsystem.
> 
> If your binding is not in linux next at the baremin, as far as I am
> concerned, this is not ready, and should be RFC.

No, RFC does not say "do not merge" or "this has dependencies". RFC is
used to invite a stronger review when introducing a new concept. Its
fair game to apply patches marked RFC if maintainer is okay with the
content.

Dependencies are either noted in cover-letter or below the patch
tear-line. With what you are asking, looks like patches need to be
resubmitted once dependencies are cleared, even if there is no change in
the content itself. This will be additional work.

That said, if it makes life convenient for you, you can impose such a
rule for patches you need to handle. But I think it will take some
getting used for developers who send patches to you as I don't think
this is a norm elsewhere.

Adding Tony and Arnd as well, in case I have missed some recently
accepted convention.

Thanks,
Sekhar
