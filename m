Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD3AC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5292073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="EL9xPSI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5292073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeI2Laz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 07:30:55 -0400
Received: from mail-eopbgr710081.outbound.protection.outlook.com ([40.107.71.81]:65175
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727359AbeI2Laz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 07:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1IIPoxJVbnTPe+0v7TiaGUl9ec5UN0DHJcbJ5OKh/0=;
 b=EL9xPSI1/veKTn9QYeKqhvZ9DkJG3SmOQDV63eVfA7wzsIn0HmGaU6fkNs0KsjHyCbHRRbVRQzEJoZuHG8v/dyKmTBxiHhkAAPXftUVQFrwKsBJ6xCblzBr99GGjkjxDuPSY4uAqnzSwVa5TN1l0l5Q90rEsn7OUb5f05KuI6iE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 SN1PR0301MB1583.namprd03.prod.outlook.com (2a01:111:e400:5232::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.20; Sat, 29 Sep
 2018 05:03:52 +0000
Date:   Sat, 29 Sep 2018 13:00:03 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Arnd Bergmann <arnd@arndb.de>, arm-soc <arm@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: fix pattern in ARM/Synaptics berlin SoC
 section
Message-ID: <20180929130003.5dc79bed@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OSBPR01CA0030.jpnprd01.prod.outlook.com
 (2603:1096:603:1e::18) To SN1PR0301MB1583.namprd03.prod.outlook.com
 (2a01:111:e400:5232::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a54f928-5aef-4a16-13ff-08d625c8f49b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR0301MB1583;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;3:11mYLJc94PwhOKd3a5TzUZ8zA6xpO0yUJXtPlob6XaoiKawbLHnPlLmmDldCzkUQvQJswe3w2fJcFJvpdWP0D8FsuPr7ka7n5tjcFJipMra/C9SsDv79Doza2KdMooVnO6EHDqthjuijdscFqf7LvUHuoGtnt4LaC/SQbvBQupXDaPnyMjNDxBmkF4OlpR/f+/fRwoGTV+Hh43gfbx5vfenWei7cBmZRflzHRHenQZ0d0oATu+15F3U/gnuIypqv;25:bn/dGm+1Fghx/JXuxajut8uLvzD7E6YGqalDKjPag0pC73fnNSAgO7xjPWffsPJX0FG14zmFAR/LSTSZRIbAZASoCBlW3s5KuR4B+MEv8oCqcGvwehvQBpJ5N0THEruBEliZFpjR0g5BSlEeaHYLEkfJ4KiWdXmxBpapYJtfUgG4PMEKganPQSLTyDBRvKV1X0BAz+vsCfjZIgMv0HvhfRKVXReoZx81u3U6HKY+WZsansBUf2zGGtyhkmSjUmxaaP6HNFI98esYsQFuFcC5tgmC4txB1JHdckzd1lsBNT1g2f/jkBFhau9n9w9axfN8Y9xhzejWdAWppPySJ2Ailg==;31:iNGVnAMDkm+jdsuOCFM7fjohN7ZSm+GpgPF+DDcD4wFHVk2uPH3oesn6O/SA/apo9dkR01SYtnYSCH0OO4rZHHdgD0lJBpLcODMoPU5zlgnYuc+hBY7LL0+WoX+CdmnND0zHuncJWJeDFliI7DI6jl/Fx51dgHK4Z5NmykLgcZVuc5sTv5GgpCMxMJ5r2JVZMXgsxNIq/d5BkhkeJPotkoAgpogM3wawYr9IXmkvd+U=
X-MS-TrafficTypeDiagnostic: SN1PR0301MB1583:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;20:IIpJCgHSSWIxdnceS0jtHJ+RFuB3Lbdlq/ubEwE4qN2yX5WzILhCSDQJbi6tpTSTXpi8nR1aPfyDcAM1WrmSEJx7vH/b7s3iP3Kzs1sDmSBkf4AsF/wtjKOy2vWyVtUz8gI3Ho3apiY2x9IQL9QZ7qQoFrnNS19FWw6dXIX1+zg+vmjotw+f5m7Scy1XpxjyePL5MFCZam1UML5LRoMwEf0N3DaglYL0AgccAdMnmxI12DFjKkAT8JFAkJYAmxWGxUKzKZXCFEMvgMpsZE0TjXMe0/7V+52E23dQy5GOi6WnFTr4FNjX2ELCQxnJ0GGmVWcoFO8GCn1YZgB8BdaOJwhib84h3iO68keftxNvShNXABUFuOkxuUhqfv7WTxvcaB8PFYyH7UqPDkrEF4aGWfl7jdfONlumDGwPGLqX9c+uwKWZl88vC5LXputI3iTGZIrOXK+QS9EIT9lUenKtMowKH5ZgHrHDwXuoQ7aJqtqDofLljF8CeA51yjULbAYw;4:1/duKAYARQhoaG39A7mYLzXRYGMN1wDkPeZAp66p6/JTRfk+5mi58ya+yTo0TRD59mH2Wor4mXU5ZiO3uE+u5c8QTN3kiXadriEwqIkLD2zqED5n1gzRavG6jtJWSpRu1HQhZ31qpTZMEmM9EwhxqBLxy0+tljUMg8kmwHAJcyAkh77liMhuZkeTirKh9vhCoB24A3o9s+byS+D00DBpuB/vGnn74uVknFyra5gr7h41U5RxbbxA1qB/Dvqmm1AnXT6sbALRNAR6lOtf1xnv8gdGWo7CIWhNj3Aavzs9D7ohQ50dWvFKqLHer5XWPsyWTbJMF0SnRVYI3/fiKFKYiCQExoVN8ReG7NTg8ob6chha1j4VISo+7Q3qb+yzYvKb
X-Microsoft-Antispam-PRVS: <SN1PR0301MB15835E8E58DA78E8C61ADE08EDED0@SN1PR0301MB1583.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(258649278758335)(191636701735510);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:SN1PR0301MB1583;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0301MB1583;
X-Forefront-PRVS: 0810818DA0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39850400004)(376002)(396003)(346002)(366004)(189003)(199004)(316002)(8936002)(3846002)(6116002)(7736002)(81156014)(478600001)(305945005)(81166006)(34290500001)(186003)(4326008)(16526019)(26005)(97736004)(2906002)(110136005)(1857600001)(5660300001)(23726003)(25786009)(8746002)(68736007)(54906003)(6506007)(386003)(50466002)(72206003)(14444005)(476003)(9686003)(1076002)(55016002)(50226002)(956004)(33896004)(486006)(53936002)(105586002)(106356001)(6666003)(52116002)(47776003)(8676002)(7696005)(86362001)(66066001)(15866825006)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0301MB1583;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0301MB1583;23:mimcgmclqLD+8Ci/P1P+ahauQiA989HiqQLrabe?=
 =?us-ascii?Q?efwcHX4YcCJ4CRz85Q58n1e7wsQwKTkBbDiIqIQm+5Y+5aro3yB6jGM1nD1z?=
 =?us-ascii?Q?dFMiGCSTzSVBd/KVwlZUrsnB6Xqs5CSkbbAoGzgoEaH5hRUbrQrZ80e05fSY?=
 =?us-ascii?Q?vTLbhMSZhIIqCwnr3xFwDp7wpKuscvfdoaVuxGjjgfIVctqi/IXVk7+tTvZp?=
 =?us-ascii?Q?UkLdLElhOgbFR/LWaB6iiXQ7eSFgPdJnFV2JRSq/PIyUoGS6fR4cPfYFzSmP?=
 =?us-ascii?Q?mOnPvACQvwq3u4dzNablwmrEcJT46jm25boi8vg9Xteghdg/QkljyCWJdLmL?=
 =?us-ascii?Q?IpOcks6/zEwz0lMtJjAuHNRKquHx9ELobAuR5GGa9iSbQuTr4wrW5Yw6ZXSt?=
 =?us-ascii?Q?94l8ihBBZMZTDi1HFUPmSUH9xwQ7BfYZQezw63yemW9mZsOKPvT9+XO5boee?=
 =?us-ascii?Q?PHAemTTl370w1Mwl4hdPDQ8rEkx+dcZvyBh+dEVdgKNZa429A9SUWsZ4HqVX?=
 =?us-ascii?Q?CRsfPYZ4kdMioX4dhN0QbitMjE5u3OD5vAnLUtRGWkHqCqACdQoETk/dEVwp?=
 =?us-ascii?Q?1xI87+NMPY0Pk9wyRp03qGC6Ja899CEWGWBSMZOfGZ6syFLstjciH3umVsOf?=
 =?us-ascii?Q?zScH0L1urvArfw1+yMdcL+QrF9qTaXJXAIWrjO/DQ3DgjOwZ+MLzxguQ98pa?=
 =?us-ascii?Q?WHGfkif8B5mz14AwcstMxebKiJWBRibY5mNnmtX1/HuCtuxGOYrY1w6NZZ3T?=
 =?us-ascii?Q?+MfUmb5A49bquYsTG/DTAOMcQZpbZLGVv3zNBn5/NjimsTaq960VdCc2HnJ2?=
 =?us-ascii?Q?ssDEWXpDH0j9mnSF9QMM3lQlFFz4L2sVdGepVlKSiOzU7gqLckxNRTN5lC/E?=
 =?us-ascii?Q?xYr8uyo+L2hPnge4dGBgUSGANv0BRvr47bFjckZsOHF3QjZFHRIBi0Iu37jZ?=
 =?us-ascii?Q?w7nw8FsndKtmM6x/L5P3F3Vq6xFLsQBmFsWLCQOAA8QM8JUDc3PbenyrQ3lT?=
 =?us-ascii?Q?+76jGVxtvcTwfBOCz/OET8QevBA85G8bK6zaHEmXqrzaLSy1Lf+cSeOF4fGl?=
 =?us-ascii?Q?eWimxk95kEN3P8XXe4UbclpytZEo6fhFWeVp34hLeWeccoQUIrQgScDAddSo?=
 =?us-ascii?Q?jsCcQRoljL01djN/Rtl0sukqeC4z9Mg4fjX7K+LhSQnSl8l9FI4IUoZsTp6O?=
 =?us-ascii?Q?mqiqhotJbsTLctMMZqV1VyxR9CZ3tQ5p6j4xAdmwVDhK1ypAro+2qB/4BvFg?=
 =?us-ascii?Q?0jM6EixwAW1TtxYeJzvEbFj3ziw5dr1GOAPoGF3SF?=
X-Microsoft-Antispam-Message-Info: fjOMB1SYPX4gUTnqJzVj9WiOK+i3CG//9p35d58PbTmUqCj3GzsC/XATh6FCQ82GhUFgRdzQ2n3xDatFZi4UQzORhagYyWFBbbs0Mel5XH8Gma6VgQVr+naeAhRHFEo7rQ9OencWCWr7LWCmu+K3wn1rsk3nN7JAH0dUthKIm7H5t7cUevWUmVkzjMKCkaKq4aXr4t1cbd/w6qboO4BxDXUqNGp7WMUP/hs/32j9sQsGbqQLeM9ujuDOs7EvDnYwWsvkbxkjvDT8pxH1gNAmg10idl8qtUNSDqvrTImZhjwOFHUYurANJ665eE7cmOVgtPwypC7Iewjz+KxDK/AtoRAKUtVqUOF56iUq/3lUbSI=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;6:Sn1+CUsE9+JJDo6ZT/EKX/3TMCc+qgUO8BVOo5EB7nfjDXEFUMZeBycAKkQdt0uPX8hitTFcKFvH5bqIeWDG0iCKqeaipjOfyFZjN+UDzlS+kXMcnJoAd8UYTaZ4aMxeU/f0t/wMHkMwC5gZZ8de1D8deUYyko4a/tMzM1wC48VUNBejRMzywS8dzIzZoO78rIN0V8UAwY4BwKLXOKKwG4su1LzJzRLySZcfMafNoEbKQA/NsJR6D5dzucTrLbMTfx2k9qRy+YxjQv4jptbvAwURekXFcY/N44ObGzMolB0oSzv/9KaLvx2/KY5HM74BOykPfVm+Iwp6O9PTpjHcsVzwyqz18NbSfU/ec8c9eFuoDn3ThaCkzcvBGCdSmG/B7dYjEjPqv8wvxJtxkKFb/ZeytYiXEcAko/fqB64qnD0DdbZ0xH9Pvc+eNe4w8GCE0ErJfghCJcHlF8Tk8ptMqA==;5:lKiq6Uuggc2mXZHsf0Q95HAfiSc2szgTriSYJWCgi7zAz/YfiAiU60cEClPsaYLgbq63d/H1Gpy0PDrBbvSdLeqcnNm+ha2LzbsVZwjY2uijx/4jmM5FiFUjmc+g0f3tpYlvWIePPUgesypWfH03P5m5Lr+Uuk0NyEroit8pLoo=;7:ZUEHbBXyqVQpilGfCW45DdXHZZTb8zbk80UzlPA9IFFRAtS5MrB+RFAEGQ4+sp6+AfZqaIdXEP2qDfaIgGcyeP/zGDwS1tlaqwKcgIvTyV8bd696PZorFZdRZbWycQCkLExWI1XDS7Z4lzwZj4InyJegM7FoLEJkkBfPtv6/iJzWFQI2RYt8Z19tNDlI0PthBfE+8TtbZm5ygCJ+/xYxz/Xd8ZLG4yQRui5NeooJIsvhsMhMw3Yxdyh4DFS1YquM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2018 05:03:52.9494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a54f928-5aef-4a16-13ff-08d625c8f49b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0301MB1583
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Berlin SoC files has been moved from marvell dir to synaptics dir, but
commit bc52497a595d ("MAINTAINERS: update entry for ARM/berlin") didn't
update the dir accordingly. This patch fixes it.

=46rom another side, new derivative SoCs from Synaptics may not be named
as berlin*, so let's update the entries accordingly.

Fixes: bc52497a595d ("MAINTAINERS: update entry for ARM/berlin")
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Reported-by: Joe Perches <joe@perches.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a255240d1452..2be912b67905 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2093,14 +2093,14 @@ F:	arch/arm/boot/dts/stm32*
 F:	arch/arm/mach-stm32/
 F:	drivers/clocksource/armv7m_systick.c
=20
-ARM/Synaptics Berlin SoC support
+ARM/Synaptics SoC support
 M:	Jisheng Zhang <Jisheng.Zhang@synaptics.com>
 M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-berlin/
 F:	arch/arm/boot/dts/berlin*
-F:	arch/arm64/boot/dts/marvell/berlin*
+F:	arch/arm64/boot/dts/synaptics/
=20
 ARM/TANGO ARCHITECTURE
 M:	Marc Gonzalez <marc.w.gonzalez@free.fr>
--=20
2.19.0

