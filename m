Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B0BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A08C2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lzESXuNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfBVMug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:50:36 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:46496 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfBVMue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:50:34 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1MCoQeF032107;
        Fri, 22 Feb 2019 06:50:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550839826;
        bh=FoOvmWQzWQGsMJ4yExXy4ECHlJLmj5sN23X69uZgUwE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lzESXuNjs5LxjlkjBizkv8Jgi6zNgVTbYVuvhkvLOo4gClQdskmZGsECod8ptTTwo
         N9iDmf0opMkAXyeRsArvGjAod5EVdxT2aoRmhj3r0Ypb3wUvm7gZF4b/zc3jQGVnng
         72PGoCJ1n6BwxpclmXDP86Or6NY3kLeoVMb0MNhU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1MCoQLW099763
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Feb 2019 06:50:26 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 22
 Feb 2019 06:50:25 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 22 Feb 2019 06:50:26 -0600
Received: from [172.22.123.133] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1MCoPwE010602;
        Fri, 22 Feb 2019 06:50:25 -0600
Subject: Re: [PATCH v5 0/5] M_CAN Framework re-write
To:     Wolfgang Grandegger <wg@grandegger.com>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190214182754.30721-1-dmurphy@ti.com>
 <52148371-16aa-b87a-02f0-9037d5d34988@ti.com>
 <43e01edf-9b9a-c68d-ec1a-218a8117f59e@grandegger.com>
 <50a3a5d6-9b83-f0aa-095c-13b6361236ab@grandegger.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <b60b8781-d979-24e7-805a-95f9237c816e@ti.com>
Date:   Fri, 22 Feb 2019 06:50:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <50a3a5d6-9b83-f0aa-095c-13b6361236ab@grandegger.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang

On 2/22/19 3:38 AM, Wolfgang Grandegger wrote:
> Hello Dan,
> 
> what kernel version is that patch series for. I have problems to apply it!
> 

It is based off of Master

commit 2137397c92aec3713fa10be3c9b830f9a1674e60 (linux_master/master)

And I successfully rebased on top of

commit 8a61716ff2ab23eddd1f7a05a075a374e4d0c3d4 (linux_master/master)
Merge tag 'ceph-for-5.0-rc8' of git://github.com/ceph/ceph-client

Dan

> Wolfgang.
> 
> Am 21.02.19 um 17:41 schrieb Wolfgang Grandegger:
>> Hello Dan,
>>
>> I will have a closer look end of this week!
>>
>> Wolfgang.
>>
>> Am 21.02.19 um 17:24 schrieb Dan Murphy:
>>> Bump
>>>
>>> On 2/14/19 12:27 PM, Dan Murphy wrote:
>>>> Hello
>>>>
>>>> OK I did not give up on this patch series just got a little preoccupied with
>>>> some other kernel work.  But here is the update per the comments.
>>>>
>>>> It should be understood I broke these out for reviewability.
>>>> For instance the first patch does not compile on its own as including this
>>>> patch should not change the current functionality and it pulls all the io-mapped
>>>> code from the m_can base file to a platfrom file.
>>>>
>>>> The next patch "Migrate the m_can code to use the framework"
>>>> is the change to the kernel for the io-mapped conversion from a flat file to use
>>>> the framework.  Finally the rename patch just renames the m_can_priv to 
>>>> m_can_classdev.  I broke this change out specifically for readability of the
>>>> migration patch per comments on the code.
>>>>
>>>> AFAIC the first 3 patches can all be squashed into a single patch.  Or the
>>>> first 2 patches in the series can be re-arranged but then m_can functionality is
>>>> affected in the migration patch.
>>>>
>>>> Again the first 3 patches here are all just for readability and review purposes.
>>>>
>>>> Dan
>>>>
>>>> Dan Murphy (5):
>>>>   can: m_can: Create a m_can platform framework
>>>>   can: m_can: Migrate the m_can code to use the framework
>>>>   can: m_can: Rename m_can_priv to m_can_classdev
>>>>   dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver
>>>>   can: tcan4x5x: Add tcan4x5x driver to the kernel
>>>>
>>>>  .../devicetree/bindings/net/can/tcan4x5x.txt  |  37 +
>>>>  drivers/net/can/m_can/Kconfig                 |  14 +-
>>>>  drivers/net/can/m_can/Makefile                |   2 +
>>>>  drivers/net/can/m_can/m_can.c                 | 788 +++++++++---------
>>>>  drivers/net/can/m_can/m_can.h                 | 159 ++++
>>>>  drivers/net/can/m_can/m_can_platform.c        | 198 +++++
>>>>  drivers/net/can/m_can/tcan4x5x.c              | 531 ++++++++++++
>>>>  7 files changed, 1320 insertions(+), 409 deletions(-)
>>>>  create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>>>>  create mode 100644 drivers/net/can/m_can/m_can.h
>>>>  create mode 100644 drivers/net/can/m_can/m_can_platform.c
>>>>  create mode 100644 drivers/net/can/m_can/tcan4x5x.c
>>>>
>>>
>>>


-- 
------------------
Dan Murphy
