Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AFCC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950F7204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="eisWjccZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950F7204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeIAAx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:53:28 -0400
Received: from mail-he1eur01on0098.outbound.protection.outlook.com ([104.47.0.98]:52099
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726869AbeIAAx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r91eJ5Dctxm0UZwvcENAqVMq0eNnmHW2qDDpfgJQNrU=;
 b=eisWjccZPzCWYGDmnDYhESmTuxaxBi1rOwcBdDp2qN6HRlTTb9ys1Crmtvax8NYsSuxMK/uZX5+PBbjrGxda5eVdv6H5qPVJuFg8ux6efLCPANm9ufXVrDPjR5NSHWytwBAV0ZUCfjE8UQLXVOlZS5mqOV77xlsPAVyFh8acgcE=
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.16; Fri, 31 Aug
 2018 20:44:13 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] ARM: dts: at91: nattis/tse850: drop 3 indentation levels
Date:   Fri, 31 Aug 2018 22:44:01 +0200
Message-Id: <20180831204403.14653-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: CWLP265CA0163.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:52::31) To AM5PR0201MB2452.eurprd02.prod.outlook.com
 (2603:10a6:203:35::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78032b25-7373-4b63-3ef8-08d60f8282ef
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:L+UU/5saKvJAgjzZQBvKAIMTFIkHWfxw/zBzXCtGDVtrk9mqJhsmh2JqeBTNuNIwxwtBr9NbzlopqMmdY43b/6V7ozaWZa/LhMBqSBAXK+HaLz6EWdIHOs+M9D3e1+CRvHfYumAfmxnINmLjA6R35xTH6hv/vhGQMt+OyxDEIyrTO0qzbsEpYNWITgqfoPdXz+I8XD6dBSllTob/g4bMB8fy4fL4tEDpSxvWMdf57ZDJ8XgQDKY3mO8AUjNZXo9j;25:q8wH61i+8BPyN7UlLkh0L4VKut4Q7WKVqBSGg5d+3uXWmMO922qxSO4kUOCLP5Y5cGoszNqlskgOiV8eCt92GvZYgC7nntAj1It0YCns7m2QZvZo6bFHSuW4A2KWB0/1vl4EgxmgQ4wAlZJsNi8bvg5n0QDLVC9r383hA+kxTX1kYlhSGVjhHh+6TqZ+tXA9GyeS4OEeqzXdMNJSDDg1fW04fUIbtjsEczBTlJKdAn0s+xZ++hfOwrB+tU94qRY0lW+PHw8l7os0KuxOuuldKjDLts4buPmt4gQRSqYfeaSgzH6JhaXW/3Vcau7LIsPJhZAVuMqITcxkagQOlXCmsA==;31:M/28CHIJPSggMn1sPyCTH4eMEAg58xr3NPX7xoD+ynRJ8sz80QeMBsLW+B4sIevY7HrctHvurUmK8e0HoYIjEtoqnZK5Sr4QmztuCotCmiJyxJhBVJsWomlKLQjQlj1xEtoG3Vz/Kh3VIW+1shcLauuON4pnDJ5Mb1A35eqAS88gIzr8LxMUaIc0HuY5u1Uejxr4RGjOcR040p4RCTadQoOjH0b5a4rZYlRJK+n9KQw=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB24522F20D828A182398BDAEDBC0F0@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:9o7bzCJy1xY1bNekJMwabFii6G5dPgNu6UzR/L16hWQkSw6KSMelCdcqdyB8VybUCsGbzen9VbtXtPwHcNqf5hEEe1wtKytuBp8/rJQBauxYHYESqoOh0gcL9Onm+qNmef1qj4vFZ7QVETyASO/m6LjTi+AhqE8joZ9lWb/CAvfLChsgLFXLDlGxt4126t9v1hKl8Cn5Z/WFbQgptkakTBJN5fSX8cKNFaognaEcLDj56OgpbFg8ztFu9D8UrwT4XQOm5RNeoty+ogeZcHaQ0g==
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(136003)(39830400003)(376002)(366004)(346002)(396003)(199004)(189003)(6346003)(7736002)(2361001)(305945005)(48376002)(97736004)(6512007)(74482002)(51416003)(5660300001)(52116002)(53936002)(6666003)(8676002)(68736007)(16526019)(1076002)(8936002)(50226002)(86362001)(6506007)(6916009)(386003)(186003)(26005)(6116002)(3846002)(956004)(2616005)(476003)(4326008)(54906003)(47776003)(25786009)(486006)(66066001)(16586007)(106356001)(105586002)(2351001)(50466002)(478600001)(2906002)(316002)(36756003)(6486002)(81156014)(81166006)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2452;23:nyDZ/n8SeTGGhN7+AZtfHEAihZ45SMpnJgAleAY?=
 =?us-ascii?Q?V3j7s8Z8cy0CymBrZMYTlX1cM1OfLUX7FXKTjORrV3kvBj1TZQr791N4Opz9?=
 =?us-ascii?Q?+i9bvxdQUT3SDB1Km3r2c9LGVrNJN2CJOb62cwUYc+VJIuud9+6VbdYiZEzF?=
 =?us-ascii?Q?quT0Z4LAUEC1utlzdjAckZtPDUv3Gz8wJoZEgn1e6EAeAPQA1UZytSOyRKs6?=
 =?us-ascii?Q?w4xwa6ff6AhGTrkiNo+5fNoTLWcWyRffdKYqcP2Zg5CEZv0ddeuG/pFJnXww?=
 =?us-ascii?Q?fapq8oBASpec9vI97L9FFWIgxilSslL4OEp8j+3ocI9WPNfKtVsgfVbWKYJK?=
 =?us-ascii?Q?C7rKbHuJUHWCcBuTsd6jGWzSWVwtffvLS5j4eAR/B0RqJ2hlpQvwH8+33f1o?=
 =?us-ascii?Q?8wAlMpKahwdyPc9Ihq58wLcjZ3Ty/JAZuttlmizw2IDzXtVnp/drTGhhOaM2?=
 =?us-ascii?Q?rMJ/D1nTHrWd/mR10SfuWHKoBgY42LuHB98s8d6Q2iDVkyA0gT0sAadHg+Fd?=
 =?us-ascii?Q?8zsyDUoqEQa8AHw/j72KI/WhasdJdoQuUARGMFUl6lJLc4rnds5U0/2i0sNq?=
 =?us-ascii?Q?aC1mIcdksb+GZl4Fz/UPRTUQIYI3Jphs1loJBIFQiY1fidzlF1lO47zHbu9I?=
 =?us-ascii?Q?FotHHsHdHa29400MZ1gAs8TODQqVxdOTSXQeoAOCfP46dtIipoIfaAs8MePC?=
 =?us-ascii?Q?euvU8gCwwEcxS2chQ8LH0OvgGnwr2GRHx1Pv/WEwFi8wvFNayL+k+AHq4sC4?=
 =?us-ascii?Q?2WpqbHW1FovOdOrGZ79z0W/xannNVsrLqGTiZ4uoxQuYsL8J2QIol+eHy67U?=
 =?us-ascii?Q?Ir8WyR4KXCav5vLvrHL9MJbLt8v2qORgXgGciYej6YO6oYBhfBQhGZpnQMi9?=
 =?us-ascii?Q?v1R/deQT9BmXMOAEPZ8z54zjuygRIaf2MuoFUC+Bu3mXt0CqqkoTpfvnd5pG?=
 =?us-ascii?Q?/WrHHNiNkPxXcuZ3Kah4C60X2xFeLMI8NCK7Zdslu5F9C1s7mHtJNKFO6Dmq?=
 =?us-ascii?Q?qDQDGkM4/lVM/1L3Lw8jrg9qSQ36lX5GMq0ZZZp25pjznqmEKYNm248wTq/P?=
 =?us-ascii?Q?1c/cWzFbwWGlHQ5uEvIeMcrs1jDkNPB/6ft5hy3akZEjc42le5XoVKGtytnz?=
 =?us-ascii?Q?8QuGWuLWhVcxoAyHr4yfvwtYTqncm2DDUyDChJoCG2rZseN9Bjw+jWd+drqy?=
 =?us-ascii?Q?FNonY6+gF4KhMwr5iS6fWvKyD2VqpcyUuETa6Soo6FiQvek1V6ezaXNMOGdR?=
 =?us-ascii?Q?Weuxa6lPZwCkTjRDqrHwwHYYfO09mqNnTU5/d7EVaVS2rwvPdCCZ7hMze+XL?=
 =?us-ascii?Q?kvlsvpbkJ2mKa5jQtP3j6t/xs55wKja5CvSh9i/jh2ET4k6puadX0vxQSA4z?=
 =?us-ascii?Q?zEuCgkQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: i62uFj0J1gXkpW2XD+tZjkkIj69ofTo1/SMP20CPLoOFIwYWfpvSRrcXmwRbaJOtF41Cus+79xvRQre4d0rLNI+kMZg7X5t9SbUb+eIAJtSoFppi5j2XIll+jS+XItv+FPyYgs6AvxIyLu9NUvPPjWuaEKoGcTsEchTPePOil3jalPMX3w0mvc2LFj8MC1ndNvyzbM5u/WtK3p4A+q/V5ySopDbysSQhx6yV3QwEOcmhuTwI6hb6WsZ4XUOWBnZ/eC2wQxrtFUwQ2fUmXUL37EYxdIO8xhSW1K4vw6Ns2MmjdjjRTyfEYP4SabSoWRrx19b32ZhE/k/W3ozLtfB+smJvV8hUCJrvfdvMz18S8+4=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:Y4AWRzQ9SiTpFOSp7mnWcAoMgqQZ7a6MpFJ+qYJdGpMdX0ZuzKezG6pTFHsP7SR5cpTe1QoX11SOXF1XOgYxu3tXKf0OKgXKKOgjT2RxQhF8koMYLiMW8bqgBkYQBJ3BQcKF5oq1nGVfBlkGqPjn+keaGlbrDQJ1aAHE7O70gg6P3QGMjVGZ9dJUafahGT3YTbiXNYkDGUGFHQkI4C9hhBDnSKG/iu5j4xKHwbTgtAlBrd9gay1X4xeBzzgS8Fj3LDe1ePIT11+MOIV1ImZiOfFS+B6KhJsa3mMsEQclwv30hZS7hRNv7mlhfHxgJX/ekZfzfaXDruK4iq4GDrDqAiHQGgComsvxcdfc+RS1j2pw+nm5bx7ks3eDemjkZOreay+FMMdbJXSZv6FmgK5SfcCgW9AEQF826NfEKqBEK7NoPJULpVjYWMZ1e7Iz6Qr9pHb2BYOS8Ro0SmCqrP4Tyg==;5:0xD67LeJMqR25M/AgIORzdMWBADMhVgrz53zo3ucB9lMINRmTwvCXgkieir6iCOFueWJELyBF2YkAXCQu3WviG0b50ugGwVgsmKpWwsaQcuqIge4MK3rbOIFLJLzluiofOiA2pfJJEqIcDoqU14JtGNX5pGR3N1Xo3cHwYD0HpM=;7:8MNKwq0o3e0+ubVTwsq7mBHLb97doanSaKTBXebUCroZdu7Wz4j9EcN1qsioskdfYCQIXKU+JA2qAGT/k0lN3mJM+aAyfAVUtdnhIw74EJC+NrKOqHZaO2nqMzDtMs5xlYCKhol3/sQuP+SN/gW0RdViQNORPCKhlzBlDsimnaOnDMTx4DEqssmKklrK47+i0YtF5owhKPwwEMsMSI9yuRhw5aKjW1ptci+WsUx/M428A8ijYJLelCLpxHe6PjBB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 20:44:13.1482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78032b25-7373-4b63-3ef8-08d60f8282ef
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I just noticed that the pinctrl and watchdog nodes in sama5d3.dtsi have
gained labels, something which I have had a plan to add myself at some
point. But now that they are here, I just have to make use of them...

Cheers,
Peter

Peter Rosin (2):
  ARM: dts: at91: nattis: drop three indentation levels
  ARM: dts: at91: tse850: drop three indentation levels

 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 72 ++++++++++++-----------------
 arch/arm/boot/dts/at91-tse850-3.dts         | 32 ++++++-------
 2 files changed, 43 insertions(+), 61 deletions(-)

-- 
2.11.0

