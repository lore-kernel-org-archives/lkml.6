Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA2CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A1E23F4E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="G+vzLfCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A1E23F4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753604AbeGFJQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:16:42 -0400
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:42880
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753052AbeGFJQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVTvERbHeWW/qjHW6Lct0jyIhbcmWcPw319cH7Oq6/k=;
 b=G+vzLfCxwu1HDvc3jYluFQeLTkTKkdtN1T6jvOwj1SMomnB/dRjRyAOsQKXSdvFHWE/mG5o3IUAnzqoVtf5BDZQmzYp8Z7KrXzT6pIhQzUUKFahzsjixL91c6cuilDLODUPyNZB/EJaFV2cW6hlSZRSAYSHFNvS6G1tAq44GQH8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 VI1PR0801MB1391.eurprd08.prod.outlook.com (2603:10a6:800:3b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Fri, 6 Jul
 2018 09:16:34 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com
Subject: Re-sending the drm_fourcc.h (with the no -disclaimer added)
Date:   Fri,  6 Jul 2018 10:16:24 +0100
Message-Id: <1530868585-11068-1-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530807905-18248-1-git-send-email-ayan.halder@arm.com>
References: <1530807905-18248-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR0601CA0032.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::42) To VI1PR0801MB1391.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d58ced1-57ab-493c-e8bd-08d5e3212ba8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1391;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1391;3:XPqmP2Q7rfcbjrsYd/BvoAx7f9+rNrKQWJdy3cWPQ11QfA1cDslvSMhYXoQlcUa7y5SXlOTPVrrwhvKXfyUDeE4Ejthth8PDoC3n5Spk3aWuLj/qR3EnvFZCHJ6vuopKv0sM2iHTN+uWdBErjW7CtvSfUkVT5+J6YVsVkkA2PfwgpibrSOr0921JKpg/3YHLfhsEPpFMH3LdZACiL53c8Mr08WiK7emeqd3dLVspUNSX1nTuTuaPJs03OioO6st8;25:iivo7XW4pgyOhBDYG+XCMuVblNGYoMi+0qMUzFAKb3wIvPXwezEZLwXlyhOEbwXEMVTDtNEHnEdxicLCLW8KQV7BwhaYCaQhMNrA6YEWTXYyVUsGw7xz85I39fgNyWFeF3g4Kku4jjIBiZFEDSLuEUS0izOnuMEU6M+r1qi05q2PoWv+cJ881WxwLBjKsW2eO5zHLgHBqeFyn3QbSU46qvB3auFjbQHD5vUCWNUIjVMM7D1p0ZZBIkxlSgnl5cnB6ldLN45ZuoNFpyaReXhfzms7XP/uuvUQ4MZVFHTScZv6/8BCbQP8HjJh9CYItHhtrrU7yC6gdNc0msM1M1vavA==;31:GtJY9l9tAZURGThkioXqvfBCqyH8nzRWPAX116tyqWkouZ04DMrKPhXYhmVVHHmapwDhvmEjtl9JMxDuHZgS9JrjfXiJYlGJdhcL7AJ+CGIacCDShrygCWPrCxWvz8HFCAcSWiTsQrDoJdu3ofNNWz+lGuDlFpf8/I0obshuV5FhHMAekO/eBWNN2qDiDXUZdXOxg/2yBieVR7sK8aOesKnKiLM1A0ehzf5uIxcjTp0=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1391:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1391;20:coa+KNP6kT1mdjxOynXPdg+hW/1VrwI2ZFfdtYlSQMF4JrQ9U/GE1eiEXcvd1/CQDrRkDziNGnt0qTmsUbADx+BJwKlKDE08qcqDAqaZdATQ2gpBrmV/Huq9/gK7blVIc+/cZEk8KcafYwkaAPVvqJ3y+GEJu5vf4swkOq0vEY4=;4:t0PEYRRQEhBICh8Jnq6mZUT4Z6yd3h6dq/zhqZQgLE0p0Sgl45TReXHqofY9C9X7NssigDscRR2qEuOvXnXhzqFngqXPleNMvor4fD2ld4OxR1E2ru/e9YLcswcjnqqKI07gx5AgpeX99N5eMQ+8HrW9qAaIWMGAlCRaeaTcRSqmI6QLE2UgdXcJqwixBh/t8cQwmW7UnRfHUi8JbBqTaK0FedPYxYsVw8ie/4pfFMW9YxRAIXJ+mc4PRgzYg2YThV6sMukRVDyyFOylNqfWTw==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13911D690DF8041CF2DA39BEE4470@VI1PR0801MB1391.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231291)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1391;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1391;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(376002)(136003)(189003)(199004)(47776003)(66066001)(478600001)(6116002)(72206003)(52116002)(7696005)(51416003)(558084003)(106356001)(3846002)(105586002)(2906002)(6486002)(48376002)(50226002)(68736007)(6666003)(16586007)(316002)(8936002)(26005)(16526019)(186003)(81156014)(8676002)(86362001)(97736004)(76176011)(305945005)(386003)(7736002)(5660300001)(11346002)(2616005)(956004)(25786009)(36756003)(476003)(50466002)(81166006)(446003)(486006)(4326008)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1391;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0801MB1391;23:dPYLk1Fqy9ygKNX/Vd0teO56BE+Dkj5VVJw+0wH?=
 =?us-ascii?Q?qdoih7Ar+E2ZIpoU7m4l7HUlfL1oLUMKmC0A9iz2G7dou8F+Ipkc8Ay3LboE?=
 =?us-ascii?Q?U7Yx+E1ORsI6AvmUDLvpDNdv8b5zRuMbMHqITEMFQME5Ml+2hUxSX29NX5/6?=
 =?us-ascii?Q?f8VsekqMf1nHl1+IHUBI9h8sGT2yW+kthv1o5oZhTt6HrZP84WCNDVIGTEEl?=
 =?us-ascii?Q?NDvwoRgGgliSs8QtiQTaSBDEIfFyGuuqES0KuFueUrRc7TvCQ8FRKxMG6E89?=
 =?us-ascii?Q?V0/OmzIVgeF6k5KflF61iY4U5qoyGoM1G2M7waTMUsCg6lxhBRBvtrDvrxoS?=
 =?us-ascii?Q?5tPqfuA72JI+zGI6703k7hmPAz6GEOOVergwAf9/4lKXBeQTVPeRp5Ge86SH?=
 =?us-ascii?Q?7Ttyujs0tYT/ikTLRJi0EqJqj/PbGa+d0oBGtEaO0IrQHd6k7h19uIX6Yg+t?=
 =?us-ascii?Q?/N9AHQ9pAWxabwcaiNBCpQGS1+QAnXkRVRUzRuUFOA5bheSkgY1ETBOSBofI?=
 =?us-ascii?Q?1XWekvLxLU1Tts/kF+hsSwCbz1/2rY32ieHCSV5JiOzsmKkwoMKTt2b7r7I3?=
 =?us-ascii?Q?wfmmrn7U7GaV1Eh/wvhpr2UHu69fxBcmPVH2Virepc+K0TILAUE9mRxU0erm?=
 =?us-ascii?Q?ysgvm31up2xvxUP41xwn6VYswtNNeD8JhihBxrJvUH/NYsdZKCorrjDzzi2x?=
 =?us-ascii?Q?sN10z+ReA21SV5dS8VxCX+6/laCZH2WidGwDH9bKjtWpYTdv1LK4csvd5DaE?=
 =?us-ascii?Q?zP4JSgClr7DqoKJ1fL8mqf0ch638I/gdJ9esc3qVuAxjlGlB4YlUUen9jPBQ?=
 =?us-ascii?Q?JWeWDUgy5eG3Fv96BpNgsDkaEIgtuVGjnl5waSUSZUnJkOeSzEOHDwCEKgtM?=
 =?us-ascii?Q?XPUuU5u6ZrdK6vn+Q4/GYU914/qabDO0JeM17pT3Z+whnkKlHQ32ovrUbKG4?=
 =?us-ascii?Q?tyRXXJZtptWcICU++WskTMWXg80QBPffxU5UK4zth0Q5pyq2hF2oe6zbPiS8?=
 =?us-ascii?Q?qPp+7h7ItGx0ifpaq3V0+qU9YKVtbGGxIjZZnRuofNxs8iW1CLLGZOh8VyGb?=
 =?us-ascii?Q?kqFxlzp2xGvhDI0rDz9JhZqbG5ffs0rBZ49pjuv6ILEDl/oxydKPCJqkM5el?=
 =?us-ascii?Q?RtoKq5hEtVGnsRKcNCun9jZDh6x+pbEfOWnt0OxZqTxVjaEUHOS2yrLrYmAX?=
 =?us-ascii?Q?peAs+2ODrhs82p28=3D?=
X-Microsoft-Antispam-Message-Info: 3OW3GqIWH7wY4w7uqIGAoOKoZcdm4Z8ziJg2NKRv/ZdmZ1ukfjQbU7Ba5oKPEKCenNFEVgaXJ7X0W6UK5dA8OdJMv7XEwhBo+ErGmNGjR6xJuTzxBy976guDNI4P/nKXh3K0WL0yXVOlJhQtTzzoX1Wmw4pEdzQZ6t8xU8X+e5Tb96ZlEbgS3WvjZT9avsefYitd0AGIzemcZcwK+GhXiLhHBYb7hrKTfxdl8bDhNX6VNJHue8dvOG3z43qoLfQrbct2EypiX2vsfDl1ENA97jynobuH49S7luuGXxALnm29P/98u7I6znw4ida4qbp+G9UNkh5xQrln/awknN4URHDfwbEqpeZIwjKIu7wemVI=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1391;6:PE+kCqg5sIDc1cIrr8fqNZGz+ssQQpiMAxqnXqTdZqE0rDJ/CPXjSR2TfqMm2NVsdpe2Bd0oORaw/Cw56pPCRgjnuMlVG9aowCOEuhvgT4Iam0GytabGethcB6RvaikHLc6kONn0gQ1B7JRZ0ewsieTZbxDICJUATBvopC0hov5RAhBhCD9i1ddbpnzymAfZ265FDenP4g5icvnT4Au6tgDFX9FFdK4CwQW24uq+Ntmzvfa+RDrXTfTLpQ+ZCn9njk7OLni8gONHmcllW0gHyAAu/w4F6qwfbpBLSuJNgKSoE9ilSAWSMAppfgMoEDfREHVl4VwaluQFO1go4EE1ll3L0b1ygf58p2GOzg0cQm22Z3ZPkKBXnf8GwMvQryDuyzHq/5AlMREywWP4P3zcN5cO1JPMWHuCRI/unZddFw72Wal7aJ5HrHVLObsnQ4zNxRuTngeR6uQr8CWf+x2gdQ==;5:RAy7W5rs0QRGswoie1TnJxCI7++FJOplHjW0HUwm107+bWZ/4Q6I2QTHg26dQkw3t2TDrrNnfU0AiuzGpDxFBWxeA5bdLfuj8DnWAczAXN/+jDQtKm9D/NzoLV8yH99AwNUH15qmjAtTsmySw9ehzjsX7Z6X459Z4Zgx7AMDLqU=;24:fc7IfGs1omfVtg+TNu1TydVIIr+gioOp8CTZf+9aagf4adEHBObh2T/lZ/MTpib0U0amkWwDPp7Kziw9L26utlq+uMeq84CXDhWn/amSsC4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1391;7:pM7S6ybuZr5fakrrS9jqqv9AuVUgw+Lr6DmZrbljhw7QdxXqLzAqjFbvThSKlJwT9p6SG0sn7bopnfpW6yB11jk5Pwj5qRZRtpeFBOnh17nb+urezo6k7ZXBnUa0FqkwTKSaCutgvVxuKp6GKkAxonDRIESLUtR+K1iaj0NiUk2XtxYfsD65WM+HTcFVfcEN9jmvVYepehUIyiH/856/rNnghAS079V5ZS7Q6NGHLpPvPpVXMwPMvWMJgjJlPKvA
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 09:16:34.5326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d58ced1-57ab-493c-e8bd-08d5e3212ba8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1391
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Apologies for spamming the list.
I forgot to 'no-disclaimer' email alias in my previous patch.

Regards,
Ayan Kumar Halder

