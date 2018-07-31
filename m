Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C155C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22784208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="aRtMJcS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22784208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbeGaJxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:53:43 -0400
Received: from mail-db5eur01on0094.outbound.protection.outlook.com ([104.47.2.94]:12419
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727307AbeGaJxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZEwYYcb/sWYaVLNvnvdI1Vl6NvD24a4o2e5p6GFhPI=;
 b=aRtMJcS8X339lrk9JfzjWBpRXgA6oacRgemfjQcLxbP32as3TIJVGc6PpjhByL4TS06VgSxTQ06tFLW13tfGQtN6uqQa+1d7Nqk2CiOqiLuWjEWcGYMZmIyHLTikwbsNgfwQAkst5VYNLae5O2R/47rj1Ctvr41aQQWYyQSwxbQ=
Received: from DB6PR07CA0056.eurprd07.prod.outlook.com (2603:10a6:6:2a::18) by
 DB6PR07MB3383.eurprd07.prod.outlook.com (2603:10a6:6:23::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.8; Tue, 31 Jul 2018 08:14:26 +0000
Received: from DB5EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by DB6PR07CA0056.outlook.office365.com
 (2603:10a6:6:2a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.7 via Frontend
 Transport; Tue, 31 Jul 2018 08:14:26 +0000
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.240 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.240; helo=mailrelay.int.nokia.com;
Received: from mailrelay.int.nokia.com (131.228.2.240) by
 DB5EUR03FT026.mail.protection.outlook.com (10.152.20.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1038.3 via Frontend Transport; Tue, 31 Jul 2018 08:14:26 +0000
Received: from fihe3nok0734.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0734.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w6V8DBhu015759
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jul 2018 11:13:11 +0300
Received: from [10.151.72.141] ([10.151.72.141])
        by fihe3nok0734.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w6V8DBr5015740;
        Tue, 31 Jul 2018 11:13:11 +0300
X-HPESVCS-Source-Ip: 10.151.72.141
Subject: Re: [PATCH 4/6] mips: factor out RapidIO Kconfig entry
To:     Alexei Colin <acolin@isi.edu>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        John Paul Walters <jwalters@isi.edu>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-5-acolin@isi.edu>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <7f7b9813-7e32-e42d-3f6b-f8e0af506d24@nokia.com>
Date:   Tue, 31 Jul 2018 10:13:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730225035.28365-5-acolin@isi.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(396003)(376002)(2980300002)(438002)(199004)(189003)(336012)(478600001)(5660300001)(31686004)(26826003)(2171002)(6246003)(97736004)(229853002)(53936002)(106466001)(64126003)(2906002)(36756003)(31696002)(39060400002)(4326008)(65826007)(86362001)(58126008)(76176011)(22756006)(81156014)(53546011)(446003)(110136005)(305945005)(316002)(65806001)(65956001)(6346003)(26005)(11346002)(230700001)(77096007)(186003)(356003)(106002)(8936002)(50466002)(47776003)(126002)(476003)(54906003)(23676004)(2486003)(2616005)(8676002)(486006)(44832011)(81166006)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR07MB3383;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DB5EUR03FT026;1:iPvEe/FBGnOW4vHIfumyhzywiStucSJIWMHJ1GxNioLOv75a6gZOgxxDIcmCzdTT2uSc8DGatLbQSfo2DXGz/TvN/lXTlVXNEg/yPedvryLv9OoOIn1PZTUFtPvbCqaV
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38cba819-07c0-405a-f26a-08d5f6bda195
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328);SRVR:DB6PR07MB3383;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3383;3:x66e9MmR8r9Zg823nbUWnwlf5/vpYR8v4TX2TZ9h4k19J4rQK/GiJDJq8iywbhJkE7YrPkf0IXs59jlB8UP5CLaWN7RdoXZBXZVJJZj07tL5k5Im2KjkMI9jVxkmZOuwr8vfdYE81PgHFrVwYyzSuyzIAevEzKdYCJ2tGqNkBOerz0bHqaFYWFKLG6dxYmNKltPQd1V3MoMgEWj8YG+8YrDCGX/KaN3SAzpxVRrUuyYaeu+0Plv25GocikYQJe+sHQmyv9Q0oINaYEusQhjFwectZWDzAT1jyo0UUbK7xm2S7XgJtj/LP4NmGCsuedx2Ksz+6pB5tQ5Jr1PheHL2E15oVD1gLoZkCP+/zfGdTe0=;25:4lSK1N5IoqS+VEWFxPkOgiQe2rP/WGl+iRTsnogOj1czVMWUDvSVUoZM59Pnher4GG5zeMwNH9zEfA0WYFHXk+UQR07bwOZiuvRfvrv086UBkHjdtA+m2VJkL3TkIQ3U+fTgSGsHNz0fwcf0T8R/qaHwffIKOcWSjwo4kbHmkL7SwGbBAVb7fyU2OJBTWVHbBN5F/44947kerdrGNRrnb/Lk50h1zZDaeUfZyidZl5Pa5p0s+dCsJij40eDUxLgxQ5UMRvIMPDeAuedTDPmSicSt5NAawHNeEVH7aOONtJiYPlA9GvvuE0300CNBXFqY2t0/wBl53lnxrnx9+gZohQ==
X-MS-TrafficTypeDiagnostic: DB6PR07MB3383:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3383;31:Q3V1qLZbvNyU3VxXNnPFlTiNQrSo+9Ov9x49NXzTdmbc10bZMPKIT2H98zWX8wb9C/egFKmcVL990QXiQ57UTdLO/vxqZdXsK6E+zO/LsAvWaaFrq2KhrtBpzPNCSnXozek01C2DZ9iiVZCS6otaVaiLqt+FoYoTTXd6lS4VepmoWfXT5LSlCzoQeXK8mfHdZrkWxaRyANtwc1qNhPs5DeidyS7UxYLVTA8pDgSdl3k=;20:MCPS7aKHvViTJL00JpUrCy3UD5ZSx7dw42FlH/L0S3/XGTf7Poi/1M+dX9USyi2LMFGakNq2ue4m5vNBX+9rEcJPoRtyhOHGFQVv1D1r91scSv7c8D6n9jcFubCLlIM6FRK7n3VS+WAWyzWFBX0y3flTQomXOzYLVN4ZTGL38r97ArxfvPJv7HCaMBGg0UQyQAucxkmdB+32i0HzFEL+zosVy1qDOh+VVI8UfyGa0Pwv+wImRv3Bs09gRa5Gr4liFwVLEb2Pi6sl1q5sJTjgO8Op6NMCBLoInOwG8vhlVLAdI/lStVQpeodRnBCM3PIreroRvwSmicmlAyvsPrqe76L8SQUhbV1aPr7MAROVyKuwSfPtmFTvf2M9pIQMqHhZBf8Tx2/pfcFoplGF2Wue9mRQ4/QV8m18HBZYooQCMYLgWZrhF09xoSU1r5dH+epgJ4GFNwFJ1SsH0w42PErIA1h9kyGYf96Bpu7cntiSRlvmY8Uw+ylDV2mmAlM2dEMK6gGk9AsfWEPlGBtO3hyd4dSzR5HLEpSEFA6Wmp+NKiJUG1oGKyQGftZnPQz7akX+rK97MKobiZMJ+ocu2fQf5gBzm7j+OmO9kx2cn3wlix8=
X-Microsoft-Antispam-PRVS: <DB6PR07MB338374BA55F41CD4E78F3F4D882E0@DB6PR07MB3383.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(82608151540597)(109105607167333)(195916259791689);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(806099)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR07MB3383;BCL:0;PCL:0;RULEID:;SRVR:DB6PR07MB3383;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3383;4:KORCqK2coCyJVGtHIT48EfW4wJeupSiTvM8JKOhe9y0q55/OB8ZPK6h0bPsUiytIvI1Q8vC9vnpGfSy0wDv7JaXun+q6nJrOvzR+sL4/uR3KEVGs9j2nLsCyTtoU3yZY72TTlM7Ed7kM66YA9fiY/SlO0UbvkE0DuHUsoax7xyzohl8RzbJb9BIpw7p/6CYDe/kuDSlbO/XP4h+paqJvFdK7pBGvoG0kFggwm3p2m2fK5xxW4udJDwSbY7pXTUYChyLDjqNTJSds3PUJhGejpqqv3Q+LvES4qTqQNkNXnbEFmpzNA4l5FxA90Hi+CL7jkIX4a6fdh3zddSLMONoYZ+DGYFb+7wJzPUx1iadnnzfsshkF0oqXB9lydazgPjT1YbqUPjwv3TaA179+Gfb/zE1NeSPZ0h1BFzMUy7epoFM=
X-Forefront-PRVS: 0750463DC9
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA3TUIzMzgzOzIzOlgzeVJoZENCeUhHclZMeTJXL3h6cnFnd0dY?=
 =?utf-8?B?TEFOdGc0VW5kSy9ZVHRscEJic0ZibDBoRXF6MUEreWg4cHJFalFsOWF1L3pB?=
 =?utf-8?B?T3pLZ3lSN1RKOERpVVFWaCtYWWwxeEpNc1pFS1dTK2xQcjhhOHM5cENhV0Zu?=
 =?utf-8?B?V0pIb1dPOVVxd24zTDhzR0VUQWhxbDFZcXhjTTBleitPYndWY1lya3ptemJy?=
 =?utf-8?B?SEN3NC9qbDR4S2JnVzNUS3NtMitrL2c5dFNaZFNnSFd3di9QRmxWV3BqcXN4?=
 =?utf-8?B?OEZhL1BCZzIraW0wS201MkppUjRiOVAyNmg4V1dPVU9Yd1dqTFBLUW5HRmNK?=
 =?utf-8?B?T1luSGJsaisrdFVwR1V1V1d3ZUhEa1dyZU1EOTU0RjJPR2h2Yjl2Vk8zWFlZ?=
 =?utf-8?B?TlVlUGxLSURCZ0pHRVVvaGhUU1dheVFSN0NmVWc5VVBxQ2ltN0RWQVJuZEgz?=
 =?utf-8?B?c3p3YWE0YnA0M1BDVlo3Z29PTWpPOUtrRjJIS09zbXBneE4xYUJLWWF6cE9u?=
 =?utf-8?B?ZjU3U1VLYmdGbnRkSE5yZnZ5OGZqL251SitNcmM4aE1UZWxGRkZZN0Y5Yk04?=
 =?utf-8?B?aUVRZ3E1R0hZTWlTckdrUjh2MGk1dmZPREZ4dUxEbmhUUFd4Z2FIQ2xYaXp4?=
 =?utf-8?B?R2RDQ1JMQndzWmVzSTg3blJUTXYzaFMrSmJIcHFFaE5zREFkVGoyWnhoQ0U2?=
 =?utf-8?B?SWthOU0wbjh0SjZQYWdYSEZGczhtRTR5UENpRnVFSm5wTFRXWGdUYUpqVmZM?=
 =?utf-8?B?VHpPeFdOc0pZN1B2TEE3ZHhHQSt0L0s2ZC9mM211YkJuVFVXbnVCa1BJSmNN?=
 =?utf-8?B?QkRSdXRyQldPYll6Uk9McUlWZkdIZFQvOWQzZjFpVUkrdkZEdzRWSjZrM1Jn?=
 =?utf-8?B?YmVBSTJYOTRub3pzUzFMcDlNT05LdHFJcHNvQ0pxMFF4elY0UjBRWG9VK0dU?=
 =?utf-8?B?UG5aSXp2Sm9WbTYrQWcwOWZLRFdXV1Y4dlhUQ1hFQ3VLOEVobit0ek9HUFBX?=
 =?utf-8?B?SGdzNXMxZU5BVERQYkxEUFcra29ZOU56YVpDZnJrRXo2WWNwek1XK3lvZ2s0?=
 =?utf-8?B?TkVlTlBNMzRob2UyVHh3Q2ZYSDdTRzRnd0JVa1cxamduTEhEVE4yN3F1UEFy?=
 =?utf-8?B?VzlGRmw5UEtMS3NzcG1kZkgzWXNXT2pJclJxUkpkSGtXWUFHRGpDVzFUY1pK?=
 =?utf-8?B?cGJBbEsxRVRJQTJQdzdSMjRIRVJ6YnQ0REtTNmlqcjNxUzdZbnViVUw5VUxq?=
 =?utf-8?B?VlpQUlpJOFd4ZFk5VjJ3cVl3alFmZjQ2MFJPZi8xL0ZJeEswdUVlbXkxRVA4?=
 =?utf-8?B?diszOWcwWnM4aFFYU2k5SEtVNlJrUThwMjl3akR3aitVV1hkS3hoU1d5bHlR?=
 =?utf-8?B?U2p3Y3V4R3RlSWtYVWh5MDllMlpQOWdWM0prdlpUZ3dkcy91R0lsRFRRY294?=
 =?utf-8?B?SDhISnA2NXhUWkNuNUtmMUxNbkZJOEI1K3JybW9CM0o5dHBwWGRXNU93NTZx?=
 =?utf-8?B?Y21IMjYzdjE0bDNDL0ZnQ3lnVExDRkp6dkZBS2h4Rk1KYU42YU9mMTN5bU9M?=
 =?utf-8?B?WnYwd01pbGtIM1hsSVpFVU5qa0NNdWE1N1d1QitmUGlEdDg4dW11a2hFM1NU?=
 =?utf-8?B?cU9rK0J0WlBmakJjempWQnViSlhoN29sTmdpb3U3bkRiTCtRWU84bGQxR21k?=
 =?utf-8?B?RmhxNkxXZllVcmlXMUJPUGo5cmk5MGhLSk1wYjV6TVl5QUkycVhnNWRlZG1j?=
 =?utf-8?B?UG1lNGF1MmpJWFBGVERIVjNQN2pZMzYvai9naUZEc0dFNnlyTjl4c2I1dHVH?=
 =?utf-8?B?QkR4SmNyUWhCWjNvenlyOEVJcGp5T2pQS1NzRVp1Z0E2Nnc9PQ==?=
X-Microsoft-Antispam-Message-Info: hVpaJBL2SCK1zyCp3qKIDQK5IQ4sS81L3S+221peaN/txvmh9zGH+gNDfArL9GT8xu76ZY5Opt12EJdE98n/+FVd+BMaRN134HIgWVUa8mIorcI5d5e4cYnOdsMOwfGmOo5kpz12JNcESRPv7iXpKIvggZP6/xaKx5INLpiJu+NDhmbenn2TwE+Gyz/dRqgZaV+O3g2ykyWpJOEVBge/W0Tgl5pEDz9Th/SbypxFNlLmvaMXxoU+2i12MeXi72YbBxoYqTcXZUjpI4Q09JiKPr6UWtgQShfBxoCqOocmQwnfBrju3rFhZrfx8oOEqGENcceFKarPlIDngO16OQTHGNThKngS7VEfUku/p+SisnMF92gMhgLd7rF8KORugK4W09cQVH5Mi4zhRRD1iiWuyhK1ZTdGDwTZ7tlXdnAWmSAX4nctbWefwO5kvvBLE4wZ
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3383;6:9GvBx+c7ig0yPWHK+eosQYigO+ol+lkzE/y6FsIOsGbmQOWV6h/58/WZx7qzA9VtXYqfxx7EDwGWNWmjvSdlEG2/jQfDwdeAG5q4SpZi3RzU58ok+xmmaiSdplsvsjiFGpx10+M03tj7jDkhRD368LRHKbEa1ivhitBj/q+/Ayxk+VT64uG2MEDuoFmL6ZsTEgZqOyrm7gTDqlGrXiZsialoyoe+eEtdktmFTKlx4haopoFgYbESJQ22oGVtab7nUnFaqF1cMjbjOaJcG8zjov8h6d0gjn4WxUjnQ0soT4sREu3wKIdUY9rQ6fFU9/QqqGOXX9Nt9+iV7HBcIzmsw0jZ1VO0OTZKf7KGbXMRLDDnDXLoM+zSCo4yt+7dNZXJ+Y96q83Vq/ZHbc8cghACHt4ohy1mNGDtoqteV3222IePvNxA2OZYMu/KRR8eFD8kec7Pw6tucqwEk8CnCLsf7w==;5:4B7wHErjrkabLsZ4zPHnHv5wlU7c5ExK+CoBEoaPvsKicaUFCsyLWN7tYU/hgn7IdmQ+9spDtttTXlGG4TgKrrV0s/SRS55FGuQvU4a4HZMcO2KJllixe4HZJicnsZ2VwRUlr8TYhhJ9BxrKVape60/xOmXWMtKvg8zzlen8gME=;7:bPzupdPYZsTZD/k4lzdTL7L64Fl0Ka49aWiPYkeGiXzMogD8C89WYi+Yx1oZQu3Dtp0GdP0MztUo4HNha3Orc8n6QoKHvu2JHnmX4NsJ3z7d99/clGD/MJG/Luz1gMKcpyK4eYoNS1ZN/vNaQqJtIYLN2i88P/uuu/YgtcqUXan1K/7VzC5WI5zfDgWe6W6LTRO9+hIyg/C1d28MQYjZbXZcey0FNRYz3CuV/g7/+BQZg4S5vVS0S7DrUuRnpj1y
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 08:14:26.1128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38cba819-07c0-405a-f26a-08d5f6bda195
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB3383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 31/07/18 00:50, Alexei Colin wrote:
> The menu entry is now defined in the rapidio subtree.
> 
> Platforms with a PCI bus will be offered the RapidIO menu since they may
> be want support for a RapidIO PCI device. Platforms without a PCI bus
> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> Cc: John Paul Walters <jwalters@isi.edu>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alexei Colin <acolin@isi.edu>

With patch [1/6] together this looks fine to me.
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

> ---
>  arch/mips/Kconfig | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 10256056647c..92b9262ee731 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -3106,17 +3106,6 @@ config ZONE_DMA32
>  
>  source "drivers/pcmcia/Kconfig"
>  
> -config HAS_RAPIDIO
> -	bool
> -	default n
> -
> -config RAPIDIO
> -	tristate "RapidIO support"
> -	depends on HAS_RAPIDIO || PCI
> -	help
> -	  If you say Y here, the kernel will include drivers and
> -	  infrastructure code to support RapidIO interconnect devices.
> -
>  source "drivers/rapidio/Kconfig"
>  
>  endmenu

-- 
Best regards,
Alexander Sverdlin.
