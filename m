Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDCEC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EEB22ACA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="rdOEP/qU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8EEB22ACA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934020AbeGCKEt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:04:49 -0400
Received: from mail-cys01nam02on0048.outbound.protection.outlook.com ([104.47.37.48]:10848
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933953AbeGCKD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vbj1iJKNDxS/eW4RVI9nOWW8rauPJg4aTy4z0zSuECE=;
 b=rdOEP/qUFoGQTUZfq3+E7flghKg32DKS7/RSVjm5UPPS+oHHYWB+RSwZMTQUW04pSWFEpPb3JSMjGdSDv3fiFjJETVY1+NfXfBuyaSumUj3ZxJjUJrJk3pqCqg7EevhWGDqAgGZNieRezbW5UZbbMqdB0i9X/z5Ir23T9qNx/bE=
Received: from DM5PR07CA0026.namprd07.prod.outlook.com (2603:10b6:3:16::12) by
 BY2PR07MB2293.namprd07.prod.outlook.com (2a01:111:e400:c50d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.25; Tue, 3 Jul
 2018 10:03:56 +0000
Received: from DM3NAM05FT063.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::203) by DM5PR07CA0026.outlook.office365.com
 (2603:10b6:3:16::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.20 via Frontend
 Transport; Tue, 3 Jul 2018 10:03:56 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; padovan.org; dkim=none (message not signed)
 header.d=none;padovan.org; dmarc=fail action=none header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT063.mail.protection.outlook.com (10.152.98.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 10:03:51 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w63A3mIZ024752
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 03:03:49 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 12:04:04 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 12:04:04 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w63A3lA1030279;
        Tue, 3 Jul 2018 11:03:47 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w63A3l1u030276;
        Tue, 3 Jul 2018 11:03:47 +0100
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Damian Kos <dkos@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <ltyrala@cadence.com>, <pgaj@cadence.com>, <stelford@cadence.com>
Subject: [PATCH 10/12] dt-bindings: drm/bridge: Document Cadence MHDP bridge bindings
Date:   Tue, 3 Jul 2018 11:02:21 +0100
Message-ID: <1530612152-27555-11-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(39860400002)(376002)(2980300002)(189003)(199004)(36092001)(2906002)(356003)(106466001)(8676002)(305945005)(4326008)(50226002)(246002)(107886003)(7636002)(6666003)(50466002)(48376002)(26826003)(5660300001)(105596002)(8936002)(87636003)(478600001)(47776003)(7416002)(51416003)(76176011)(42186006)(316002)(486006)(16586007)(2201001)(446003)(2616005)(575784001)(86362001)(476003)(126002)(186003)(11346002)(26005)(426003)(54906003)(110136005)(336012)(36756003)(921003)(21314002)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2293;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT063;1:yY0jwYRaaWMPnej9+gK9bGQBftOfN4/hqDebqHLkAe5ABYzei9eqwP3fRU9eFhxtxmKdE1G+LWqkRFnmASFHLtvtIBifNL8nL5GNL//bORQE/0cgzkurFsdJMLzRRDN3
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6504e5b7-9ebc-4d0e-d3c6-08d5e0cc49e2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060);SRVR:BY2PR07MB2293;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2293;3:2VQI6LQDOOTnVIvSEtOErkgIs3y8VIuojPT12zT/8gkOAYdZrfy1ch5G5NfhDXHC76K+FsELlzkNyjWImc8U3F8UMaEW1PQF86unU+AlQi8FTNGpWksERrNaYLVQEhkt59yIAG5XBzjWxHv81EPIIfTVIZX9nJGOpxEG6lh2kMgzjxBMsKFljwLoyAvm4d4JmKYau7yjlMDARcIcY3/O2AeSshfFSa/043icU3WbIuSWMSMeDkzoBOqWK2WrOH/W5FgCwFoXtLFpgVEWhDOOtkQRMUnAkTKSsdcpZ6ck5lKLYm7w9yaCfBt1Ldxqqi4ylBrc8Hh4YCtfDm69Xa32yotXkNgEI3OkeP/O8raIa/w=;25:wZCP516Szzk3uZ2h1r+37eUiFPFk/CAzxq70rjBYMjDAmXwmfxk60fxEp7Xbl+lQwXJb1/Sxtoc4bAjjgtDdWnLWQG0Q6m5bNS9OW9rNU6Y8MgA58kV+PAWpJDw12O0j4s8kDqXrFUBvhMecwQGaFf13Ddhy/NJ/BYXHY0awRICSeRlqb8ufQvw+AZrf9h3/I+6p7ijCM/Fsf+rMizkOrcVgaX+MC7svB05zb/Zgpq6B8oBZfzktCRqqWx70ldUS+LlBQ06L/faOxt/77/D/vv/DzNr1uxL8Ns+nnd0M6IfVHDoTmWu6Rraz4B2rN+4b1BljWBTj1yz9GMtvzOVVfw==
X-MS-TrafficTypeDiagnostic: BY2PR07MB2293:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2293;31:IsU2l7hujyerSbWc2lQB51yeceHW5FaIgfg/JfJL3XgQWHFVX4wMEoZdJUwOHGFm92v7OYEPhBEBd16TepdjkkF4LgAHhJ6Xxu5iLO1dfdH+nrS9OqSdpEm6ZnxOlokoZ+h+9TA+5IFc6Kyf02c4ikanfSnPy27vRV3dxvKlyV+Mz0iuJV1Edoxl9Kflu9HRN41MN+LX4RKaBpgTpQcuzYx4nFs/qbPCe4kBk+wvMH0=;20:Kpqs+LIT9YC0jsjk32liGcsvx3LSXpy6vPP5fYyP8MAla35Uoe+F5kHe0XIEvkw8f7wEWk1kUo7D/c5gM/NbUc6F0SI0hTU73MElkUjbBonxSyxYG7nQmuzxfiGMvQVeTc4W1yP4ngKi0CBaJLGJnlw2fNTNbBKyZ+iwBj8FsTtDQxYUZ2DrNo1DEn8e2TwFSmjAZSFmv7PFKdjW+2KoZ59PebLx0XiN0qr7zp9/1K7P/pRp9a292QQ6tiHtyoyYDEGCzqUDbUiiHdc+LkaIH+QBynG1x/FUDsVwybEAFj/G4v+98RIJshE4ZfmmBio2Cdf8VyDLEK5o7NAtfskd3y/nltZRvHoqrvJPwBs8YMtiO+eJaQYkpJhFxYXSyfI6sPJ7NeDM2OiioC0hE3SdQ/t/GC13Vg53mOVrG5lhte874tFvQ9YldgXy87NyC3rOht6MADybRKmhM3t7bUsqzXawvNvShAoZvHDlepDiynWuvmxz0g1KPte4FzBjW8xW
X-Microsoft-Antispam-PRVS: <BY2PR07MB22935F8D48B433BC54DD2353CD420@BY2PR07MB2293.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93003095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BY2PR07MB2293;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2293;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2293;4:/VKsY12FJfJ0xOXSdIb2//bRr+XOXFcifRzqhTdPj/pOggkMMPb4Hq13rVOv6/MtL+e0vmL5ikrlW/tyRsIoypkDZ5Xbnd6MnB55aIN+T2IFG7I2N6xz52B0yH+N6nsD3cF+z9APN33skyjsU6ZuRtriHKx0x0+unJtPFBDk3iPYvkkUs5HXKE7vn4zFYLG6hdDWEq0Qy0bkRntkpgTBJ3S+WOJRBfHEgPm0y8LCAQWTGTI2S88CGw4dwdnaKAVa87FIJ7MeSYPFFaTzJ1VYHPD7vPCduXu40CsQIEM61czb4w66c4L/i/lkK7ikHXHX
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR07MB2293;23:KVsOY/dJyma7uh5uQ5GCB8S7KE0Q+vEznOTOBQ5yD?=
 =?us-ascii?Q?2vyD0NeikNLaWxc4qhljw8dlgvWCLJG0s37UrLVmqZ88VPGzUX8nOAq/GzuU?=
 =?us-ascii?Q?SgwI7SwQzhBWILyLimE3hSAZ8eymva/zzkfRjWS2pLJvEuPJtCVz+hq4Efyn?=
 =?us-ascii?Q?PNtg6JFSI7NMhFkMgBGkK4DI0sU5Otzz8VIQ8BOanI/YmiK2TUw/NUrCNcSk?=
 =?us-ascii?Q?GpMNxUk9F/G1xE85wcAEq2DSvprtwnFvf9T4t2Hd3BK1jXxZmAGE4kApfZCM?=
 =?us-ascii?Q?kOK+qsnxkdT6qTiqLvzO9qH2CJ2ccbKCretzTZzGpmj7WmBamtMjZy3HdumA?=
 =?us-ascii?Q?qXTWoqhTgewZ4PNcN00W9JxHR0o+fj+BRB8zOothmX+LhVivyu4Cwa2326b1?=
 =?us-ascii?Q?/ndLr8uhse7yljT54Fc/pBAF1dYMAFXNOO9/iOZt8/S97IBNgYD7qNydjNtm?=
 =?us-ascii?Q?VoFdWDxusL7L8gGNNpTJbbKPc+blCKu9DLst8KsiDww9vxcd994yHV4Cfujl?=
 =?us-ascii?Q?ExfSR4MZY3K9bcTDu/tZl6dXkmXP0p9K8tYmhu2PFb2gHVVhgCJKjsr4ntSQ?=
 =?us-ascii?Q?zyNuNHTJtghCQvJ0k1/5zWf3SbDhJOqvIAusTuUr5IuLtrRqbOoWryuleVoh?=
 =?us-ascii?Q?4CE9SCRiHX8SJoA6HOeU3F66zFdlCqZE5zOw944OcRGkvKNc54bLYGa8/83+?=
 =?us-ascii?Q?29Nxrt4DggBSi7Ff2TFpXKX0Yc+lSsVqMN51oYoiyP6fF7oqFGz4llyZ5S+q?=
 =?us-ascii?Q?OsywIwtrXQBZrVlT6BEMSL/tp6JassXIqIDNQud5xvUq7sqHyQ0hcEDHUTfi?=
 =?us-ascii?Q?neoj8m/Ftz8kZVvkgnGor6l2fpCsbeC/h04nx1XNDoVSJHkdrTtqMyiK15OX?=
 =?us-ascii?Q?4hu39CINelnvJBGy2BdltRo6tnZupELG5huW9jfKRcInYBZMl9ve5ARBUphC?=
 =?us-ascii?Q?AntGViCdxNe3uJfEmjKkwAv6nU7fAlsF70mDCI7SWlhs9hTAvKui+MeSPBoV?=
 =?us-ascii?Q?orD9mL4Gi1NlIFEskxl8p6X+MLNh103PBd1tx+niH28nnaW4wXJWdcyNxWrI?=
 =?us-ascii?Q?b2sg/Ir3sCSoqHrLjlvEUAyqHbKBci9kpqPjcGVtoo9tR8hQWhamn1tionqW?=
 =?us-ascii?Q?nc2wYdQZLRBM1cJv4R1x5gGRYbgXglGtQECRyAF1h1dc8bZyWna4ODJl5Apm?=
 =?us-ascii?Q?CrVptlWXU/UJmmum+y7yvPqVBNCHhTyNSXMc360yOHU3PyRtTbov2Ky+Q=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: HgUv7An5fPncNJab2JthrIYRDAzpyy670GpEssOLkjajko9Bxoy8bkiTu/ab1dA8OC5NFJGrz9xH3lwcCRDfG9FoBVA5rkVyetuaTJhgQZkMTbygdRsQBjZZKpFDhLO/UpvNpqHntfzgkqMG23aceyPRVKsbN8+YdCS0bsTF84t/cIgJh/MKiPEFvEUMTBIroDWgMXSDt1LIuxjXB1vRc/FHYfl5watCt7K7rLQtxeRIQljDiOA/GjNe0QOZMPEVp4rwyOoZgGmhyp60NTfyro4MfWIy+Uq1wMG/IzE69YSZ0AvO8x/c3LcWvmK+4lUXbUX6vNzGvIQQAa+mknafZjS77ZeXhH4C/PWT2P9vE4gKvZXg9xaktK5AH4DOHHc3ZfOMu7pDVAePW7TARpSnvw==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2293;6:mHc10zjbm3n62Sbn1CREyCreBvXJgoqKD1BzxuH97CDPyY0rwgWLM0keSl/ecd/QYSXpR1TIbT4W7SUEaLZ0zwvefWOFGgoYdXGIA48O8RyVDGgqqo0AsrrKVicJZBDmkxfLwo7WQem9rIq9zjH3jHY/fqFb5IjOFRJygN+X1Skh5xqNLVuAxCWHPRDkYiEqa7sADpUM0BEJbyvt+/kCpo03KQQp5fS07RNK7oFSGUKZo401gF6Kzo16O8UfMd0CRUHZ76zYLxLf281zjaQLxNVRMNsm3nQ/mgaG4zMJSFv1PF8iq7+x2ENYt4vDlK/Z1t3j1VnK6L2ejeJ8w21JHekfb8Wa7gr1XrmiKgF24+L9Gz+W/sOrrC4MNDWI+7FI1FsM4XF0tNZ/Lan6hz2qFx+ra1is8ZuMEcrKmZ8YztHijCizrUWcD+swSeP8FStwISrvyG2PWQ4HP5JOWi4GKQ==;5:X2CA7vU6BwAyUkZwmXAvE5ApbREPiSuFgWmBRptydpCCrqTwyVjrwFdHDCfnQzzC3sFUMbW2lKKk9shL0etJaU/cnNJsb1Ur9Q6KskiyWH10p7tm3z9VPg+/3+bzO16ID1As1fUYrsn7yP3OgGzFxbkS+ORa4a5Npe9KChpUsqg=;24:w7D7vOt0ntCLAmFha0LKog3gt73xYc/6Zj26mOuWuekhtdxTdV+/lhPycUio1sYtuhMLdytYDBqStmXHoEsFYsE+Kwi1vl+u3eFJqGj1upk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2293;7:18512KnVp6ljtEvENa+81+7VfsJPgrUxrUolhZtKvfImKzZ4gGruHTj7XbR5ztH9qwdIVmxPIpRBiIbmeAjzEhC5Dv/OKJdJ7D0raBhzv6HFcbwr96fhdfND6SsaMi65Lav/OWcjLcjH2J4dkbbK4EhYGSfMBmNVt/xPj+pyNUzbtBc/WpVcJxlH83BWgTi4yweALQBCvr6HkwCuJxFvboRwgacbB0VUmx9Xo/AIxTsPtfBMX3otgG74GI83iNxr;20:NqdVnmhOOPgzibVZ0UXp3sPwzN6hZmup+zGKlIp4aSVWqy1M/vd2748OnCdRviBJFJWTw6f3h8bfFjB3OaGOW7gDbk/N84grqL7SacUBzajWoJGOPCsXDDr8v8XSQyl+lh8OKYeH7cydQ9jszTRCweFce/XgT7uwVrUvmHTATf5d40MCrjzCfaq2fk5mH57GVEeShyZuDfjjd6kjrjnBuzHp3qXoJJ/pzflA80KJIP00dLP7qeCAeMBfjb0PMxWY
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 10:03:51.1907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6504e5b7-9ebc-4d0e-d3c6-08d5e0cc49e2
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings used for the Cadence MHDP DPI/DP bridge.

Signed-off-by: Damian Kos <dkos@cadence.com>
---
 .../bindings/display/bridge/cdns,mhdp.txt          |   39 ++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
new file mode 100644
index 0000000..d872e26
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
@@ -0,0 +1,39 @@
+Cadence MHDP bridge
+==========================
+
+The Cadence MHDP bridge is a DPI to DP bridge.
+
+Required properties:
+ - compatible: should be "cdns,mhdp",
+ - reg: physical base address and length of the controller's registers,
+ - clocks: DP bridge clock, it's used by the IP to know how to translate
+	   a number of clock cycles into a time (which is used to comply
+	   with DP standard timings and delays),
+ - clock-names: must be "clk",
+
+Required subnodes:
+ - ports: Ports as described in Documentation/devictree/bindings/graph.txt
+   Currently contains a single input port at address 0 representing the DPI
+   input.
+   Port 0 should be connected to a DPI encoder output.
+
+Example:
+
+	mhdp: mhdp@0xf0fb000000 {
+		compatible = "cdns,mhdp";
+		reg = <0xf0 0xfb000000 0x0 0x1000000>;
+		clocks = <&mhdp_clock>;
+		clock-names = "clk";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				mhdp0_dpi_input: endpoint {
+					remote-endpoint = <&xxx_dpi_output>;
+				};
+			};
+		};
+	};
-- 
1.7.1

