Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FE6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21FF218A6
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IRg698lZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfAGORn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:17:43 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53343 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfAGORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:17:43 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190107141742euoutp01485a0aabfb5c74f37dc58d05395ec128~3lqvk-mRE3141231412euoutp01C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jan 2019 14:17:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190107141742euoutp01485a0aabfb5c74f37dc58d05395ec128~3lqvk-mRE3141231412euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1546870662;
        bh=bX9cA7naX9SVkxoW2KStoudCXCD34h7BlnH2KpwPN5U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IRg698lZvTRapFzYh84BHlxkDK3bbEUQ+6bNJxP/S1OBFkqujJzlzQuX3ZQa2neI7
         WNwt08DRpM+OarmR/hlfDl0Kzgt03KoIS2D71JwgK9Osspcr9cA9/htjECYRUDPfPZ
         WHIPPz4ch9jNuO0sVxXdLCxZt+poy4Rzl8IvI0T4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190107141741eucas1p21c779ff297fccb1ae95343389be5597a~3lquo-g_q2113921139eucas1p2w;
        Mon,  7 Jan 2019 14:17:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2A.D5.04294.48F533C5; Mon,  7
        Jan 2019 14:17:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190107141740eucas1p15f2975c3d87e7a8fce9daeaea41525d4~3lqty5ekv2621926219eucas1p1R;
        Mon,  7 Jan 2019 14:17:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190107141739eusmtrp2c96a405d31def5e84bad5965307c7dbd~3lqtkcqv61588815888eusmtrp2r;
        Mon,  7 Jan 2019 14:17:39 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-e6-5c335f849e87
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 16.89.04284.38F533C5; Mon,  7
        Jan 2019 14:17:39 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190107141739eusmtip1af30042c7d77dcc320ef32d16eafa059~3lqtNQTXL2954429544eusmtip1k;
        Mon,  7 Jan 2019 14:17:39 +0000 (GMT)
Subject: Re: Re: [PATCH v5 02/11] ata: pata_acpi: Make PCI dependency
 explicit
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sinan Kaya <okaya@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <7d6b9323-7760-944d-daa4-6fc663a32481@samsung.com>
Date:   Mon, 7 Jan 2019 15:17:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gkGaxgr+-CzsabqrfVFQFo_R+G3VEg3qF_sGWa6bT-Dg@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87ot8cYxBt+fG1isvtvPZrF8Xz+j
        xbEdj5gsLu+aw2ZxcGEbo8XWOWsZLeZ+mcrswO5x+Wypx6ZVnWwenzfJBTBHcdmkpOZklqUW
        6dslcGXMebGXpeAhT8Xy/jUsDYyTuboYOTkkBEwkGt+9Yepi5OIQEljBKLHx80NGCOcLo8TC
        A8+gnM+MEns3zGOFadn/5zILRGI5o8T3Ncuh+t8zSqx5tI4FpEpYIECi//EWsA4RAS+JpkOH
        2UFsZoHpTBJfGstBbDYBK4mJ7asYQWxeATuJ1mlvwOpZBFQkLl7fydbFyMEhKhAh0X9GHaJE
        UOLkzCdg4zkFAiUmdF9mghgpL7H97RxmkBskBCazS3RO38oMcamLxM8ff6FsYYlXx7ewQ9gy
        Ev93zmeCaJjOKPHm11IWCGc90AdnjjFBVFlLHD5+kRXkCmYBTYn1u/Qhwo4Sjy//YAYJSwjw
        Sdx4KwhxBJ/EpG3TocK8Eh1tQhDVahIblm1gg1nbtXMl1DkeErf3vWWewKg4C8lrs5C8Mwth
        7wJG5lWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiBaeX0v+NfdjDu+pN0iFGAg1GJh3dH
        rHGMEGtiWXFl7iFGCQ5mJRHenKeGMUK8KYmVValF+fFFpTmpxYcYpTlYlMR5qxkeRAsJpCeW
        pGanphakFsFkmTg4pRoYaxNmBXP7S4QLeV1s3KO/S0jmY4MPW7uwWL7drLTAGNGHn4sfCZwu
        T2dgOj51a4Hjjne85Ya66uWaOhOO+xi4PtFk7OV7W5dwh4Ej2mbRkqyfhx1aF1xbH+bAq1kv
        t3T27k/HvmSYNm/7K7rjRntIV+6JmauPTo9xf7n9smHhtXCnc5kZj3qVWIozEg21mIuKEwHL
        pwcmJwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7rN8cYxBm+mGlmsvtvPZrF8Xz+j
        xbEdj5gsLu+aw2ZxcGEbo8XWOWsZLeZ+mcrswO5x+Wypx6ZVnWwenzfJBTBH6dkU5ZeWpCpk
        5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GXMebGXpeAhT8Xy/jUs
        DYyTuboYOTkkBEwk9v+5zNLFyMUhJLCUUeL2phbmLkYOoISMxPH1ZRA1whJ/rnWxQdS8ZZQ4
        um8/O0hCWMBP4v6Zh2wgtoiAl0TTocNgcSGBZYwSx1bXgdjMAjOZJNZsFQex2QSsJCa2r2IE
        sXkF7CRap71hBbFZBFQkLl7fCTZHVCBC4tbDDhaIGkGJkzOfgNmcAoESE7ovM0HMVJf4M+8S
        M4QtL7H97RzmCYyCs5C0zEJSNgtJ2QJG5lWMIqmlxbnpucWGesWJucWleel6yfm5mxiB0bLt
        2M/NOxgvbQw+xCjAwajEw2sQYBQjxJpYVlyZe4hRgoNZSYQ356lhjBBvSmJlVWpRfnxRaU5q
        8SFGU6AnJjJLiSbnAyM5ryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMH
        p1QDo1YAx61ms/zDZRW5DuFvyjLTFl3SeZ3JF3PmLvcR0/sGn1t3/l9Sc/Ol1Ou/vWImz+v3
        v2RKTfv54pGIztk8pf7MphrRU3/7cydtOGl9y//OxdXVC1a0fz8V6ebH7H/ya276nwcVz3e3
        MH5Z7hKjxfHD6IX167Lp5U+srU42Pe9e/SR7ra2ZqRJLcUaioRZzUXEiAEU/IqysAgAA
X-CMS-MailID: 20190107141740eucas1p15f2975c3d87e7a8fce9daeaea41525d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190107141740eucas1p15f2975c3d87e7a8fce9daeaea41525d4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190107141740eucas1p15f2975c3d87e7a8fce9daeaea41525d4
References: <20190102181038.4418-1-okaya@kernel.org>
        <20190102181038.4418-3-okaya@kernel.org>
        <CAJZ5v0gkGaxgr+-CzsabqrfVFQFo_R+G3VEg3qF_sGWa6bT-Dg@mail.gmail.com>
        <CGME20190107141740eucas1p15f2975c3d87e7a8fce9daeaea41525d4@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/07/2019 12:12 PM, Rafael J. Wysocki wrote:
> On Wed, Jan 2, 2019 at 7:11 PM Sinan Kaya <okaya@kernel.org> wrote:
>>
>> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
>> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
>> satisfied implicitly through dependencies on CONFIG_ACPI have to be
>> specified directly. PATA_ACPI is a PCI device driver but the PCI
>> dependency has not been explicitly called out.
>>
>> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
>> ---
>>  drivers/ata/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>> index 4ca7a6b4eaae..8218db17ebdb 100644
>> --- a/drivers/ata/Kconfig
>> +++ b/drivers/ata/Kconfig
>> @@ -1091,7 +1091,7 @@ comment "Generic fallback / legacy drivers"
>>
>>  config PATA_ACPI
>>         tristate "ACPI firmware driver for PATA"
>> -       depends on ATA_ACPI && ATA_BMDMA
>> +       depends on ATA_ACPI && ATA_BMDMA && PCI
>>         help
>>           This option enables an ACPI method driver which drives
>>           motherboard PATA controller interfaces through the ACPI
>> --
> 
> Any objections against this one from anyone?

Patch looks correct to me (pata_acpi is indeed a PCI driver):

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

but it is best to wait for Jens' ACK if you want to merge it
through ACPI tree..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
