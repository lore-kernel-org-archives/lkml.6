Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E86ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AD020842
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="IWjTcL8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AD020842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbeGMKCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:02:47 -0400
Received: from mail-eopbgr680043.outbound.protection.outlook.com ([40.107.68.43]:2676
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726824AbeGMKCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E20IyzLT9JJlxtjc3JHmsny8QyS2NkhNPpiLz9eJ7wI=;
 b=IWjTcL8aR7y7xxcWLT7ajD4rDXpAE2Qkr3tS3/zaCSDXgFd5aD8wmXTn6fShz3ezV5D4QtjGxEUU+qqEwfRIDSKx2H0PaBLF9xjsh7Wx961mjPW6jAEvIf08i2hMRg7oA7ljL4GJZeY1rC2GbJ128W8lj/962MkOyWCtJBM4CNg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BN6PR03MB2625.namprd03.prod.outlook.com (2603:10b6:404:59::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Fri, 13 Jul 2018 09:48:43 +0000
Date:   Fri, 13 Jul 2018 17:46:38 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH 1/2] dt-binding: pinctrl: berlin: document AS370 SoC pinctrl
Message-ID: <20180713174638.5e07f882@xhacker.debian>
In-Reply-To: <20180713174436.4842419e@xhacker.debian>
References: <20180713174436.4842419e@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: MRXP264CA0001.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::13) To BN6PR03MB2625.namprd03.prod.outlook.com
 (2603:10b6:404:59::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77459a9e-1804-4749-a515-08d5e8a5d3f6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2625;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;3:6En7zGwPU0nui/24Lukvc4+AObvARjyYxe2b9drvnhZ5cAyHSuNDlTK7ccEnCoR/xFjtDpdqcIj+feBrFmRbGaiar/Acjhoy3tDNoF4y8dAWHewcFAh4kzj5af6emf/krSRJKdyCjLQ/5T7nPDXfstxc80FLpMAaspSsKwKae7GUIpEB4EOb0S+v+0AD8Bp/wQveB5AE+yRjWSGGFGTCZw58PkmqIxpIB7hoLylonnzEATit1Ew0giy8rypVy7YX;25:WHYVzQe/wrkW9vrdB3579AVrCZ4XilPtwyVkW+1fqJTFPF1Q6v0PZ4aoxy2uYwBVB9w4LAlw/XhMNNZsm56Q5wpEqtad6Eo6aov3rD0JbjQSitoSP7F6Zzbx5AHKgVCSmaR1Qx7l1+B2E0i0h32O3dA+tv/srHVDjdIYAWUBdi6fmQCKe6O0z9CedcurrwzKF6NpSR6dl3U7W9lZFHXZlCfL3AW36FAQ1DGe/qlUJpRkJfYNP+bqDaPTBFI5D/ewluypYzLYqBGUs3HWVxU+VURg6HbzhiZeDWkBZcdosj7MGQkYW4njrWFWyhm8CjaEXbRDO0G+m6q4aiKfZguA7g==;31:sxBbaKv2CwnooLSXaVdt/wen9BrMXKYUb991t5rsxG5RR6ozvKbyz7qRkcjn05swslkbIe84IoH67xtm3RtgwC6VqAm1DBb1rDo/ScRYqapL68eQUsMSh5/74RE7+k6vAdxepmewcSIxDdqRExWS5l6hjbQQUIguqyNVLDFwajmgUYqXPkJcxaDNgYovVmCMwHLoMazkjajksT1IF8MvpAhKg5YqcHwzhwwam1LhigY=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2625:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;20:nUr9aImFLB+DvO+2LN8KxxLhOb9WAyiNMxi7Wik2UEHT9uSi2y/pT7EiIcvAX3/21vTw5dYhdOK0RwUl7udgtRA8FFeqsUlhQMctcA/3c8erYjLhHeuUv28lPacHtOMkfcDyeDOFM1kLsYe7dlE17oAPwQ5aAuADcQzX6dw4NQoqdXvGVgsj+7BruIZ3lopV4wW25HNeNj3kVQXOuKHGVlr+fnWYy1Pus564+EWmRjNRj/l8YpsKxc6Z79FOKSpvIg6e+mnU5WyaOOSZ+U1IGq0XfMzjhwisiWgsquRkxWnrfda3bjP4BWfrNymfG98jhO7Pp9VsX0K1GoQWoSBhkSOuTlx4VYBpCqF7CZ/1R6xSxcV03qA9VyUgviHJ0COOpQXUdkmR9HmNTUVICAIi7sJy7WqFFWk/kcLmHUuVS4u3fS6+FuyQD/nxNwKJT9NJzdfFYrZyMnCJCZpFEdBncFuXiHaYbMXvRo1FUJRpqXhz2DExVMy8QFfwjtewgj07;4:g5EvJK8Hq4h7RDy7xKXbdpW0fBtLEcpEtA2hNKjSaPFYCMeDCDdAs/2I0W+7BLed1T5zHWpQAVKYDem4+r3h1m+wtjD4ZGuCefsa/da0bWodS4xQ1boTLG4Eki8wXt/9895qqv9EXWrwwhr6b6KAKaIxKlr5YakJWTCr7Hhc8F/uWeB247SwXvSM3gsI+HGIE0rAzIygxloSOZiG0FD9Llfk0SCxykivHbZCwn6xzPAV0cKDYk+grbZku7PGvTqsiR2c0OfE+RbG7snHvbpmog==
X-Microsoft-Antispam-PRVS: <BN6PR03MB26256B10715F21AE93FFFC1EED580@BN6PR03MB2625.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN6PR03MB2625;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2625;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(366004)(346002)(39860400002)(189003)(199004)(9686003)(386003)(446003)(7736002)(53936002)(11346002)(97736004)(956004)(486006)(6506007)(476003)(55016002)(33896004)(81166006)(81156014)(8676002)(50466002)(39060400002)(5660300001)(305945005)(86362001)(14444005)(6666003)(478600001)(47776003)(72206003)(8936002)(230700001)(4326008)(1076002)(186003)(16526019)(3846002)(6116002)(23726003)(26005)(66066001)(106356001)(2906002)(105586002)(68736007)(50226002)(52116002)(76176011)(316002)(25786009)(7696005)(110136005)(129583001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2625;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2625;23:Q5eaBeK7K0Sx1x1/6k8iVlwylp8r8K+6RM29u+KRH?=
 =?us-ascii?Q?7gwE9IJ5qL4LvUJYGUfQlKx2Ys4D3Oj6N3x6vIo/DdmqxwQAotctaL3qQ3Tj?=
 =?us-ascii?Q?uEXtj0gMGPfy2Fhs6x6VsZuCMCX2my9SHvOJWbPPPWrzwCyQgNTg+NsADPjJ?=
 =?us-ascii?Q?fgerIBsfzyU68Mbuvzy7CgPule40/l6WmsXps6ALTVolpqODE4jPonb0upBo?=
 =?us-ascii?Q?DkLxFaMq5kUzOv56H7typ4YByG4zms8mBrU8AHkSIldeZFEvrqV9asuDctn5?=
 =?us-ascii?Q?mfY1VkduO5io3j8qbsC5BQpdcIbLwbRfAY4g2pzYjxcyq5um8qiMRa8QVwgw?=
 =?us-ascii?Q?PIYPZ87l6usCsTQFYu5UAqmU5mq39xqYT7wX4tXD7oo7Uw4RUBjrvFuWIk9+?=
 =?us-ascii?Q?WbQ0XP+1GOr5/vPFZk6dnkW0f6IThT7Ktiif8Dhl3TYiVe06dHOJ+pTFFjQo?=
 =?us-ascii?Q?2vohSqPAXqnfhAu1S1HDT3mu6+s22vmaVk/nM99PobLiJgPz3NmTNs/iUvbd?=
 =?us-ascii?Q?jxmznv4En3+v6uO22QQDO0KJ0T3sscy66xqG6JpZs5gShSH0rWiu0pjFoReq?=
 =?us-ascii?Q?haiaEfo8j6nfppOz9bE5IQhFw00uhHQM/ovAYQL4AGJYh0nXhUpymKfFlVQI?=
 =?us-ascii?Q?IkWUVYHoKbh1JZuYLLQFlwGOXUJMwxn/fKcSd6wExBE5oNYVD8zi+2RwXyqQ?=
 =?us-ascii?Q?kLv6ZShg/s4AFTi4pBAdHI7Jm7Qqk016JNlCJp+p8cbDaCMZLBbN+5/4Vm32?=
 =?us-ascii?Q?Inak4HfWYECRXI1Fsj/2vb8Dq4a3y9anweDp4jW9m9wDsVBLyqDPqDRymu7P?=
 =?us-ascii?Q?SvpPYBXpHCuC4DE96VK6IILpHul333FhbXc8u6ryJi4QP103ncpM3ScEHr9L?=
 =?us-ascii?Q?gZgf5hPCKOHZfJCvJqY2jEV6Nh9LmrGeVqzuSBq0Bli6JhzfFsST3MRRr7lm?=
 =?us-ascii?Q?WAOFBtTELSaW6bg/1TIU7w08YQktlLLZ1H5I8EADLv0Hxt2dn1JeZ1Etbb56?=
 =?us-ascii?Q?VKH8VjVQnp94ZvGeWCRA/tkAf1ARj+GZHNC0esB8wLh0k1udTiZy77E+R8iN?=
 =?us-ascii?Q?CHFjNJO9GLNEHPjENo347NfoDmJH5GdbPjUQ6p6IgLtNcetmyadnM/3RPUfH?=
 =?us-ascii?Q?fnbQwL9DSvaooN++Enejiq1MHaUuWAa01yqi7ErVyR9JLRsUUxeUggoBikA2?=
 =?us-ascii?Q?HXft3ifd329SB7rwIkFh2TDfTzuMncNzA+oIy21JF5InT1suZPssN8sNC4+9?=
 =?us-ascii?Q?Jmxl5aa774yetL9vVZmseG5q+vbglxSjKaPB516KCrFtUw+Vzvnx9fMuiPpr?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: N55KQ8vjSV4WRHSCriDfY7ixlc+6LQg2Y0cy5tSsT/HFL76h8jRERycBBc3AhfcKQdJYclyNcx88UD67tRZVj2WWMfO/PJq/HSfKiKxA2Y4avZYxLSCY+rTYI9R6GR9bIXzfkec36PRmE237ZQLlmUYiojhlOIeb7FmIJJq+oOXEVQDeoaH3pNel4JkcMmnI4zF2ZobiDPsqZKcjPCPti8eUrjXfU31NN7E4jCKlCTmdCrIkBV0/Dp1M6drCS2byuXj6k/StB3r1M0BiFCO/JImwZjfvjxOrJe8VqKD4pUOwg2cFdaDSSgvV0tmLbU0FgB5YY7bVLukzGyHLJ4GYuHUf34nHqIU11V0Syf/exSo=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;6:VYzoNeoBwXlxsJn7NP3txZP/qKMu92qiAdctU8O+1Dyb3vLMJWuDLtdUKUCmu8rbumZ+Zryxl3mQLUMLnFnndnd1b7JLRPTQamnOZ6XeykLeyA83Ga5pFkMxEykjvmSntMJjbxMRN+2eQtZ1A58gfrZEFsxX3ABy+9F3KpIz30Vj5j3bxe+/xEUYyZDx3uIYbpsivGvCjpvKwZuR+hCclCm3jQCpmZX2A1xAU7txDlNh1uMlxDC8NLFjyiL6eTVNsIElCFSoYyXfE1a2Eq6l8bv9xDwTldo+9fcHJENwnHKKk5HGyzyv8bvnLRLqqVulOxRMYulLWYx8VqWsBiLPh/mRuzUBtLRa7zDPC9zgHPIX4NCVaPfbqZWierIVV5vT7RNblOsw+QDhy8pku+OtagsMC8jEsYsn5l9c8TNu0xoXdrqP97/olNQzhVS6i1gJwu/WEiQAXlORPPoKuB1m4w==;5:r4h2dJhyG4xvPD0+40BrRGKI+CXaObTZVpKTxXQ0rYEUrEki8BT0T0EX8LysRSAvwNq1oP4IeNaT7siCbl/0DnFTCnaxr/RI3nT5a6vU0maU2Otix3sZMVQPoMTiga2QvGFwpPMpexqaw8VgDkjDp3AHzovWC9C4gdC6FPD8BZw=;24:aa17uiYXq838QKJbv74+009I1mhaQAgwvgnfksT1S4tZcd+7pCwEzl+CEN9sL/i79RKcb04/bvAGEab0EG9+v2T8RYuyd5nsWyoQDA8Lu/M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;7:YU748V6RjU3//ksK/feoLLYjHNXOKyY3nl2ViZTDu45Wqp6rY+ucj0bhCXgjmlywTYr9kVNH2use/7Hrb4mSYWfMzth8cGFbhTXH765ydX1y+WImEJT8Nb8jvbNs0MSRmqqKNWSohMwqkgJ92OsmtjrrT7/Qw8EoU6m+abIhvmoiatThEMKpxvr9B7QLadNP6+RyVjGJFY3NFQSfNJAxsIu6xJPI5YWY3rB6iVfFmtWoLABqdKAPK82OBsDGzQY3
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 09:48:43.6843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77459a9e-1804-4749-a515-08d5e8a5d3f6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2625
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add as370 to existing berlin pinctrl device tree binding.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt
index f8fa28ce163e..0a2d5516e1f3 100644
--- a/Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt
@@ -23,7 +23,8 @@ Required properties:
 	"marvell,berlin2q-system-pinctrl",
 	"marvell,berlin4ct-avio-pinctrl",
 	"marvell,berlin4ct-soc-pinctrl",
-	"marvell,berlin4ct-system-pinctrl"
+	"marvell,berlin4ct-system-pinctrl",
+	"syna,as370-soc-pinctrl"
 
 Required subnode-properties:
 - groups: a list of strings describing the group names.
-- 
2.18.0

