Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DE9ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAAD214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="ImhIomH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAAD214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeIQNb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:31:57 -0400
Received: from mail-co1nam03on0087.outbound.protection.outlook.com ([104.47.40.87]:17920
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726732AbeIQNb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvSJkITIk4arfrHQT0h+HKhu+0zL2xNPPQ1/6uQJqdA=;
 b=ImhIomH91+SsHTERIYEL96wdQ/clAexnnT1Ee5yUAEAkjdDzBCmMZHaUS4mWT+3oSOS+Yz/yDG4kpMJUm/+3Rhij7oM+xNln2iGb/OiSqhOfHGJ2ttI1GL6QGPaMQ4JvlZEnYayd9/1pIfWn72m38Rnxm0WysVf22XwfFMvIx8U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1578.namprd03.prod.outlook.com (2a01:111:e400:529c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Mon, 17 Sep
 2018 08:05:37 +0000
Date:   Mon, 17 Sep 2018 16:02:11 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: arm: syna: add support for the AS370
 SoC
Message-ID: <20180917160211.7b1cd37d@xhacker.debian>
In-Reply-To: <20180917160015.05a1fc5b@xhacker.debian>
References: <20180917160015.05a1fc5b@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OSAPR01CA0197.jpnprd01.prod.outlook.com
 (2603:1096:603:36::17) To CY1PR0301MB1578.namprd03.prod.outlook.com
 (2a01:111:e400:529c::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c57c92e4-c14e-46d4-f8a3-08d61c745b39
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1578;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;3:bwor3WkpX8mftl+0GhdfwmfWZwFl8Yw/NLNNoUfBTh2R3Qem5n4YuQOc+kDlR0JHmDyQbvCk3dagMnFDctHstmiz1cseTtfus8vnaTweF1iOjmBpCkWjGvlaSWe2jIz20uf3XsXYrAIv7ZUXc9QM0CXVlWXeOd0LAxARlUydc3w04G4rGvrs3JYvaC4/OREO8HDw4qfbMhRBFDKSg3Gi9fLKFXKnKOer6/nYOKHvctYKZWyrhJWbzK1mFP1tSySi;25:CSr5w334Pl2KmZqFmWgxeoM6psv6NRSE0xAGhT0hDFS5zqTiYcwACQ/EfvfjDMQVgTt0R8btXs49IyLUwgSdOANZOQyo3j0Wz7rlvnnOZLtPeIGrPV29zwuiOIK09W1YTSNOZi3TvfNhY4+6uxQG8RBNLx1wWmjW+ocwZeLofxBY/YGU97cL0wCjtxSu31xyEudpMApQ4vyDbolrfrfvMGrBhGZPEtVPUQJui26K9l2/nByaZUX826kaZT0LqoIBiSukJmZnxmb/cdU72YWqiPIXSKEVLibOHO7mw1FpQN4hdX+RE3mAPM8cjyOKJVW7o6XbQZZAN9DYV05kZs7irQ==;31:TXXckYIByss/6ARiCRq1PpEH7QENZqqiqwLX39DVejkOPtFi35wJa26T0QNPva/MY8JkMza/TQ6DZzK+RjjGApN5V7HJJn6KuovWvU7Nl7806ZlbwHMf7DeVFoDT6nv5arai2xmiXwLw7taCdpGKVZPUTYVXYufXNFSkjYFXym0z7XQleRbXtKpoA9JPqlkQSAb4Dg8IsUkDUoZA0iInxNS6wUGwiOcq7SS+bwcjvA0=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1578:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;20:1tMslv4YBz8nd34ocINzr10NS0gaGdv/ILx/RZEZOpUxwPX3pW1USyDR40esRJSiDj57Xh4ZgdwtX87XMmqiS84tCQcoZYy8fdxjZa+oLWJPqdEegTgS6xc+j9cN+O0gtM3bOvSLckbxm38E1Ox8xBLG47KnU4RoAVYBzzptxEIPoi/E9/KJssIrmOkxuSU1h1anND5sSOS4SJP8vLBkcEOg/0YE2HTcZkPk84QXU+9byy+UFOZRYmIalXb/eYFJX0DcAe3ydkFcB+pQC54LgZDCx4Q4jEJZ+np8oXbyHfnFk5AMWAXz0rD5py6ZdlnXv5SgAsXGwu89D0f/6Xtlhxgjbo51O2dRCG+7JT2QzKM/nzZ+RllSNQG4sWZ4pe9NsKP8uf0tRgiUX8RqgsXqeRdW5w79CVXp6IB93uxBqWKzZ7vZQ2byYCYCcQBLljKB8uGe33ezKCKphn7bY6ccAQmkqgKswnwShJBeizzuPjusqFB45QKNwKPDI3cZirLI;4:794uXbGjiE/vm5c25zDTJecddnGGpiL/swKPiwTrrQQbolV9b5vsaDIWK+SUBLNNFst8ilsVrX2b42STUlyOxPGrvgEXjxIiI9+CPYkWBFlCaMPFj7PnR1T5VgAFFvq4FbBvUJsmzqdukRDdLNEiFCBTPdec1zUpXiFs1VUOWy2PR/8pvedCcFvsLEGJGvWFMCNRPitbPT4PBbLc3QhfX+UMAiHueqyCLbA2IwIOKtw0pYxEg1shcgkH5SPZYvKzvpkqtPB3pVmu7xGMFVrcLg==
X-Microsoft-Antispam-PRVS: <CY1PR0301MB1578435EC0DE8757459C6549ED1E0@CY1PR0301MB1578.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:CY1PR0301MB1578;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1578;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39850400004)(396003)(366004)(199004)(189003)(230700001)(76176011)(33896004)(68736007)(7696005)(55016002)(52116002)(81166006)(54906003)(8936002)(50226002)(6306002)(8676002)(110136005)(81156014)(316002)(39060400002)(4326008)(86362001)(7736002)(305945005)(25786009)(1076002)(6116002)(3846002)(23726003)(956004)(476003)(446003)(47776003)(50466002)(14444005)(6666003)(26005)(386003)(186003)(6506007)(5660300001)(2906002)(66066001)(106356001)(11346002)(9686003)(105586002)(97736004)(478600001)(72206003)(486006)(53936002)(966005)(16526019)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1578;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1578;23:E964XNiv7GA2mJKSBzb1palylk5CpRrpxA5fTQy?=
 =?us-ascii?Q?OW1fvq93DmqvCwFsaSe5TZlLzHZ5O/CVUhgYqXhsteXEO/G4TcABClPRz1ts?=
 =?us-ascii?Q?WJ+eU6jYLdZY3wTq5yVl6AmKFFSTHtRYQJgRyTAAg/8FUktQppGaP05QoDFD?=
 =?us-ascii?Q?ZNOm7sWoK5C1fhj7ZZMOsG2+Giv0NBMkGgGWLMi55IGRUQQxaNbez73I4ANV?=
 =?us-ascii?Q?9uN8ZB7ugXK4XLdLqCG9Q7fhBt4sKmCIjKc7mIAB3vMR3XPRbpO6MG5ueoUb?=
 =?us-ascii?Q?l0DvtEGkEbroMEALAY6HnrS74TPxzR0gBpkVd/FgCim8bdTE6s3Y77x45RH/?=
 =?us-ascii?Q?35/gPeH/rSWHhIWKLphPpqLu3f4JZ+Dxsx/uH0UJD8L3iiRtEv9b4XOMMXeb?=
 =?us-ascii?Q?/IYNKnyVMk97wDsWDL/a9cPd6QnecSFEmO5P4Y9FO9wO45jVpFWApPKmPmBx?=
 =?us-ascii?Q?RUrClu1q10IoP6ZvStcUR2XIAwNaFLadwwmXHk7oh0f47Y84qqVpq19Ug2q0?=
 =?us-ascii?Q?oCJGdzE0p8W69ehRf0v4QSn1RxKFX6qbo08hE9ai6j5HfeQL1IcURJdBuirw?=
 =?us-ascii?Q?utJ8HL1EBq7FwHQYv/gayn72jPILCVmfj6ovb38a3fIRQWS983QRh3MX1vG7?=
 =?us-ascii?Q?PQT5sT5dDjE+U+KyhbGIMyYu3HPAHnQAOFiXx99XImIubgj+CMX5OYIaMc4m?=
 =?us-ascii?Q?cfc+W8FPnqFvOnMTQsagDuGMLyJNl4zhWMl0sbfjeoDU+JCSmlKufb9yepOu?=
 =?us-ascii?Q?M9nfZLDjbWIbgNz+VjkKbUpeYZ+N+3jAkUs7pI0aLah+S1Nee+F7CXNEn/v+?=
 =?us-ascii?Q?qQPqQPeztHSHpKHmInqEoz8ONRqe3+N86OKLpYuMjBS0H1dKCYuJZ7V9UtK3?=
 =?us-ascii?Q?YbYUZ9nn6xw81N6rUfxg6O7huAL513YrY80yiMPh6QjwmEFlnEa8BM0IvZeu?=
 =?us-ascii?Q?N+qwSQz0n5nMjvvLKTfMlYe88zm0uMmmshzTYCZiK8clBNywL5iekGILyUg/?=
 =?us-ascii?Q?4KW0KX37RXEV5E3lPfwQO7CxXCWRHTH/cW7khF+SDmPG2rwCPPPvHBAAQ92f?=
 =?us-ascii?Q?02lIAZXHNRk2GOvF1kjAOXlTRfSx0wgD0Brck815SoSzRLbbtMm5aUQa59BL?=
 =?us-ascii?Q?1TEnqYqoFW58n5Vrm68d7Scy630D8T7ijFP71b8NICFcmtYxtv5f6iIjF7Qu?=
 =?us-ascii?Q?hqqzmAu3VgWa91cE1k6lRK/WOwpwTMte1ue4SwrrgxqETPJQQ58j9v/gOz0A?=
 =?us-ascii?Q?2ALKYT3A4ebCk1a2NrpWc2z9LsK7tL9KTrHzpn3VZeYff6hJiToP4A0V+J+M?=
 =?us-ascii?Q?Vef2jhqZyzyD05vKf97QA+Ds=3D?=
X-Microsoft-Antispam-Message-Info: YX8zePLo1vlp4PCDp694BSIGhu0L/BNOfNIlfk3nKkTSv9qCBKuDP03dKAXYHVb/KqS/EA181zKiaSNy91Nh1qQHGPookdHle9a1q6V2hWEzNfVmcGcqSlpDsP/rL7pg5vVxJoe0BO4vCW8/gIpw8cTAQe6y5E+dcEVwx1QDOkY/tSzSSroxDgA67e+ByTFOtRIVpxu7lbGxbUYkWfA5oeb8WcB+Ra7rIqXTReEIolbBqTsv2VD7xNHNwxXz2w/nmdW+CcOw7VxP8nz3DbuxpdJUBvVOjho8bGWJmjirKZ1bnWC1bsP9gXfakyYLIbCgGRl2czXgOTFjkzBYQCn7JhAdeUbeB8+71KVmIk5+zhk=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;6:X3g6wL0AocubHmRkt9MF2zDBO69AqQqqpvcwW8+1mZ+x4JW7XzWszZgh1Lp10z1eT+WVhzT7ZsRi4EaBOK9jnJ3dPm5KkfbXyy+rRu/8V/4q2Rz4dRyz61mVwqwrRdK0SvNCXYVS0WKQU1yrL548+QU2AlrT1POw+GOUToTRKmKTvfBeNvCn6zXEyUmmcPc32vmqgi0r/8/F+GL2F/67/8s43asOT1iKdWwP9c5uqTU4L5sGzOAU6ANjfUuknTqpl1JqJk5V9tDaXGgDH6NvH2yEKzf7iHCNtc7UY3olwxWTy5imzcX8Bj/mFHA6BzaRhqbIm7vBiV87xr+/w9WuMOfkQ1OqnJNNt5TNklbn1+q3oyjwF/Xci53Eg1Q1aeXxRRGxhx8cXDzotC3fhWhzQQAI9XuXtSJ/sZO+EtBE04NXIJR9xVga1U+WjqlI0WFsI37HYtovoRSZYdZJByHuOQ==;5:CszYMpGREqMTKFaR2Ub22Gn4g7Z+tIzQoECuU7sB/vgFxno+jfHMmhvcXcvDcIa8QvfzQI0Hkzd+ACHjS9ub10LFw/ivLRRkYMaLtd5p/lL6czPx2c8dykQJXXpebuY6Sy8+itfWPW5KPk6GV5b+p2pl6GNdu3aqu7HtRzjahpM=;7:WwgT4MZNRzmL+8LZS0fMY1kwThwQXTX9hlbsY6vQZ5DsGk9SZigF9mHnsGsUxqki2nIFVQfouKNzs7T6cV+c7axawXlz/nXukYRaHbg359JPhTYQHtcg2wLkO7iia44KmVXlu79QdTm9LroVOPUu0qH7yFo2/AmldhZDAGS28p8d9OtB1sEitCn9mP/z/GmxNEX4L7UYcJr9/6ic46kfk3x50GZ8cbwlKXeqhUaeUbhSXWb4e2c7Zz5El1kifKak
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 08:05:37.4288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c57c92e4-c14e-46d4-f8a3-08d61c745b39
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1578
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AS370 SoC is a new derivative of the berlin family. However, the
SoC isn't named as berlin*.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 Documentation/devicetree/bindings/arm/syna.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/syna.txt b/Documentation/devicetree/bindings/arm/syna.txt
index 3bab18409b7a..2face46a5f64 100644
--- a/Documentation/devicetree/bindings/arm/syna.txt
+++ b/Documentation/devicetree/bindings/arm/syna.txt
@@ -1,4 +1,9 @@
-Marvell Berlin SoC Family Device Tree Bindings
+Synaptics SoC Device Tree Bindings
+
+According to https://www.synaptics.com/company/news/conexant-marvell
+Synaptics has acquired the Multimedia Solutions Business of Marvell, so
+berlin SoCs are now Synaptics' SoCs now.
+
 ---------------------------------------------------------------
 
 Work in progress statement:
@@ -13,6 +18,10 @@ stable binding/ABI.
 
 ---------------------------------------------------------------
 
+Boards with the Synaptics AS370 SoC shall have the following properties:
+  Required root node property:
+    compatible: "syna,as370"
+
 Boards with a SoC of the Marvell Berlin family, e.g. Armada 1500
 shall have the following properties:
 
-- 
2.19.0

