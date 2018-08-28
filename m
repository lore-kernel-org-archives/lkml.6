Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AFCC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240962089F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="iKkMilcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240962089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeH1NkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:40:06 -0400
Received: from mail-eopbgr70090.outbound.protection.outlook.com ([40.107.7.90]:27616
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbeH1NkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTbghi0CxQpzRW3fOZtx9T35xNHgZ4zGas/lqGjijmI=;
 b=iKkMilcdpKzSLKAqhLd6B96SxoKRkVfauU/vApBOfLFSnndE8H5qT66FGPcqfUK9VbnLOPUDbfw37/6sZ/dEcafU5/WbaVfeavMT6vJJUhS8ebfG4ifNtb5o9LQCxzHVmjwEVQFoUccPu52io+lAo5yB+8RXQlmujWS9oYYDd3g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2449.eurprd02.prod.outlook.com (2603:10a6:203:34::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Tue, 28 Aug
 2018 09:49:07 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 0/5] ARM: dts: at91: nattis: some cleanup
Date:   Tue, 28 Aug 2018 11:48:39 +0200
Message-Id: <20180828094844.10018-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: LO2P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::22) To AM5PR0201MB2449.eurprd02.prod.outlook.com
 (2603:10a6:203:34::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af6c324c-c261-4995-45d8-08d60ccb7fc5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;3:Z0+OgrYAZL6pnC0irjZyK+9QDU8pMI9xotaia3qrUZ9GTB8/pPnburPGQETn70uf6BE68jNAymWEIVRBjBoa9C01PBuIpBNsNACpwLB4j5jmubvP6RNzZN3fI+g9WAxhwJmOZhlDth+XNr3NM6IIjQDN//p0Jx1VuxDMLmxrO7NpAfYrkK+OeX0EjBLBYkz6Y8Wh/GZyur58MTWSkC14/fZNgyODOigqIZwnZ1VBIrDSxleqYIB3E1+U6JZgzHp1;25:PQ3Lr5OzcYVH2uOtXF7+vgB3Hs96Q1UXesxaPlZ2YGaifeVdG2Vj2SLt5d1717VREo3twi8YDhgSEgDs/q32VnjDcbAtfUsUVbA6OjmdsqbVURLTFknsmJXn8cyaIj3CHsneFQ4KawKNGja5V08B/J02aRyQIPmTF/d4iYD8Wuqi3qfAMLcxA5eoFZxCyOlI3LwJSlSsG6eCC71wEAlxcBO3RvaNpWLhX9R3liI3xODuMBszjuf10dVw0bXFPB3iGtIorGnElt8SFYAIalpfB/neSOh+slRJkvpz/VqEnkWqLWnarYewjGHUC4yEZtx8F8gVb4LgYqZb29BoTLSSdA==;31:oqj4edR54SvjWqPgmbThA6oxW2H1smU1ELQxylfdStAO7VUU8KobXXXUWluEGIv60SclSq45GT1sRcwTGWFCMdt7i8HrsjwIFSpXnbg4dM0td25Y1H5tSdiMMEao8h8iKLw8kXd4aACaZ86KA7RO//KoCcMtty9TFtaPEJOSUNHgAvmekn1olyiwqQZZXIE7p1ZdlpcWiJz6u+9HDY5/2GD0HYtVkPMtkIxW3MAFp6o=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2449:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB24490F3A8EEA67F5B7A90BB4BC0A0@AM5PR0201MB2449.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2449;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;4:ocd4cXSei/WKwdpH0ti3qDsPCFViaan0hWWTJYtfCGIYfUKkixs7Fmls+sDmgL/9fMEBL/DZ5sLaYDJCDEgk6AqYRxePZAy7yIDOS9Ds6Gp7Bh6264g7CMDU5lqVtdVp2eXbtYN+dnn3fKrWI6y7C4fSsfBNNhfmlL+SoW6oAYsvYoRATn4GQDtZhJNNOW57hCDwTaCW2RWaV9WR3QyrAdnsPUT/ux9E+bDiNx76nvSP9/zsM2nfNpB0M2jLwOPa5PUoK/iBb3tEoRPssALIIA==
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39830400003)(199004)(189003)(74482002)(16586007)(54906003)(26005)(4326008)(2351001)(6506007)(966005)(478600001)(316002)(386003)(16526019)(186003)(2361001)(36756003)(2616005)(476003)(50226002)(956004)(6116002)(97736004)(8936002)(3846002)(1076002)(52116002)(25786009)(86362001)(51416003)(6916009)(5660300001)(6666003)(486006)(50466002)(48376002)(81166006)(53936002)(6486002)(6512007)(105586002)(81156014)(66066001)(106356001)(6306002)(305945005)(8676002)(7736002)(47776003)(68736007)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2449;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2449;23:hV41CgZveoGi1u4cMMcqD7iyF8X8RuPXqE/z547?=
 =?us-ascii?Q?Db7Fq5YLv9BzsOgHMm6xwkHmnZ0o4CK54zEAZQxvyzu1Avu2RYn58G5AR3i4?=
 =?us-ascii?Q?f46Jw0CNtNYiJH0IkZcJlKWpLaPbOtiLlsPZbCsi/fRfbufSj4qwfegaJiJK?=
 =?us-ascii?Q?dd3Fzr52h48JJmygECNVkxMuRLQ+ZIRfG2EBeIwqF0RP1b4tEWms9PVHeIyz?=
 =?us-ascii?Q?eYXqScUBvGAsX0xUuYhkWlxrXUW7bL4AUrSleB0j/jL6SdXwStfB+DKIIwPW?=
 =?us-ascii?Q?os7k/oGCtyGqkXfi3hHUYABhqM/L3ma0Iq75r8CV9vyOt7j6hkgr40jKcsXf?=
 =?us-ascii?Q?8KRAfpsg4XG5mfIFPe8l80zEfiii9ByL817BqRLFYxWr2ilepGY4mT/m88wS?=
 =?us-ascii?Q?SVTpqZfqRF+QPSzcAwyNdthnqwJJ1hf5epk2kXKnULVsljaVs9CCoO/3I1nO?=
 =?us-ascii?Q?XjpOiZGINFevzY7mWGuESvtBFFYehH1rTtz+GhXB+YsyWUzi29YrUQhox9Rx?=
 =?us-ascii?Q?guLXEDllrd0NjOLx6r1zFqtRoVz6SZKgLc4qTXNlWygxcOnJUSRtLVn4GVaJ?=
 =?us-ascii?Q?PgmmRCly+E+78NDy4hjP+FmUEhljGsq8MtZFKEoQGo4D/wUhWGugGCsUnr+9?=
 =?us-ascii?Q?O2AnNjYzNlOQzaU53RmI3KcV8xxkKar82HFLcDx/QvtWr5gKycCugnQxx/h0?=
 =?us-ascii?Q?RKYyXDtuFlOmvdJt/zdX8FnNw8afeFP8TyGVTVMoEMieMGCBJxJSnKo9sj/0?=
 =?us-ascii?Q?RygxAm4B8yKD3hPLEEIgUw9R4peaFCsi7lEAx+tFwbGAyX7IOo2HiqigbnkY?=
 =?us-ascii?Q?nmsGPHPDFAqynKg+ILsJuPKpYzp1YmWxTqzjU+FUnl8XrdU7hdoFqJaLCi39?=
 =?us-ascii?Q?RgR95z19oyUt7ld7hyz+HKWCOs+FQIYAhgOQk7WTwAO6bdxFDElRZ+7A60M6?=
 =?us-ascii?Q?PnVrnb2OEPZ064hZeFuLqGYJYQCiD2Monw/sGb6EplMhzqg86YlPQYJvK24A?=
 =?us-ascii?Q?6UjMCDP515Gy47cVsTpML4XFBgJbRX8buyZa5Glv5XuELA2Fz3FagqU7jrAo?=
 =?us-ascii?Q?p6gDFkVsuD3YV3nLG/DRW3Y1SaQ70LH/3Faj+fssHgbJEFHLJ3xTjzHeorpN?=
 =?us-ascii?Q?oNtDy7Qu85I1ZAg5he4zPpBpg867dS8aVSZW9Tq5UtyW8qTfTbUmoc5RpJfU?=
 =?us-ascii?Q?Y6Ho0YUovCGysgLiy5v9i+kgBRm9B4BD1bmW5n4RGGvDYeu1bss486ZA0SlS?=
 =?us-ascii?Q?446h1ZWhMXPrN83aSmjlpMkbNL+WWma4LsXvhr4lX?=
X-Microsoft-Antispam-Message-Info: J5y0xWGza4Em5gKcOhc12SCh4jN++lugXiBbjrrtLjDzWM68/1CtDkCWqQEDpJdQ+LqKYqLp606DnP//RlMePCXliNagI4IedEXh6wf8t7NCOybAa/RldDxjbk+rgt08o0HeZJoSOMQ+07iAAu+GWGVcmLSq/Lg2G/jwq/fVxeffNnXK2BoeleM3mRqeAqWXjwYHomHQEvigshIELi8gMbEHQwdcqAWiWDhGaFDSKrHZn3ky7tttmXGnP/uE8klU++XFQwSXNfDwH6M1hFFpWUI5wmkuKuvw5zZ/7+egBllLWerEYmugFH6KDrJ4gC1B25qsFNFAHFngzRrRgOa7kI3q35ky/YhVKEfNVcB6ojc=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;6:hauDhyrMenFLp+Ok2dP5hERWSxqBjt8t7xvG3zxM6jATOat3dPclCVkv6arjuJk8vENA9SQ+rtM6v+Qr/Vruvkrarn65TJEfsHRa/kMGvhNMjERi46kSzIWzTQ21Sv9C3tEDbZmmtnimVKEXU73R+91OLVWIOh91nRUJtOBtJQ98kBDPyV/gXGv+nETv6BU5xMFuI6hgfKQUB3rxf0z3McMNzoGv5ODCabMs5il5exJ6v5C+verpX31w26HCduoU4N9nr7n9HH9MS0Dzm7SNHk1dYADo509gbAMnDAC3BLR1nLgZSOnmEwdI5Z3B69d5M4sQxhLy4AVK3fLc88ttoRosvw8bZmBJ7qpq+iwsT3qHbdhsImL7OnXIQHIi6c10nOvsHamRSV4W4jxxq+uURJVYfwcVpttxlRq3NJT8gZFhMpEOnKOxb80ofFJ1Z8taPJAM0c9Jz0AhCr+uEpPeiw==;5:2Pqbsv7ONBVPnEj7WM4DC1OvFu/JFOLHthPnPkstYhuAr4S2MTD8YWgah3dxivH7WXFoPFu6I5QjvMEHUQDirTYYN2LDgDvGS7NqYM5t7CDaESXzeT2qF28kfifhDpf3ldgQXjbway7k1JevhzbEdrL0c4xJeolKphTFCtNXf70=;7:BqqRkWmXD4B2msrAeX1cvWa7JHFKuLuCvc4PhrlsckPk8qmzpjEC5whVM+UAhW05aV/inWfeot4ysuFL9skPfYQuel0QGJRu/lAcED36zigysqJGa8ZALVarmH+046d7NzFP8vwYHZfr+R7ukHm7A6UB7bNq93Dg1O/BBl9IzY4xXKZIMn/yhQDqrk9taalySIFkZ2+tLiEvhFVqnU/CXJxJF1C6a0P+uu/VHN3LvwlijvyDSicDmR223lz6tL/F
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 09:49:07.5328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af6c324c-c261-4995-45d8-08d60ccb7fc5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Now that some other patches [1][2] have finally landed in -next, I
feel that it is time for this cleanup series that I have been hoarding
for a while waiting on those (weak) dependencies.

Cheers,
Peter

[1] https://lkml.org/lkml/2018/8/24/187
[2] https://lkml.org/lkml/2018/8/25/64

Peter Rosin (5):
  ARM: dts: at91: nattis: set the PRLUD and HIPOW signals low
  ARM: dts: at91: nattis: make the SD-card slot work
  ARM: dts: at91: nattis: state the actual lvds-encoder chip
  ARM: dts: at91: nattis: move pinctrls for the lvds chip to the lvds
    node
  ARM: dts: at91: nattis: describe the lvds panel

 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 43 ++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 10 deletions(-)

-- 
2.11.0

