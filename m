Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeB0F5o (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 00:57:44 -0500
Received: from relmlor3.renesas.com ([210.160.252.173]:58033 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751037AbeB0F5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 00:57:31 -0500
X-IronPort-AV: E=Sophos;i="5.47,398,1515423600";
   d="scan'208";a="273581852"
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=<>; 
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 1/2] phy: rcar-gen3-usb2: Add support for r8a77965
Date: Tue, 27 Feb 2018 14:52:26 +0900
Message-Id: <1519710747-26435-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519710747-26435-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1519710747-26435-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [211.11.155.138]
X-ClientProxiedBy: OSBPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:603:1e::31) To SG2PR06MB0981.apcprd06.prod.outlook.com
 (2a01:111:e400:5213::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f1a258a2-e0b5-4321-718b-08d57da6f9e0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(8559017)(2017052603307)(7153060)(7193020);SRVR:SG2PR06MB0981;
X-Microsoft-Exchange-Diagnostics: 1;SG2PR06MB0981;3:EV2e60Cn+moob76suqVDUB8RNP+PW2Yq32Vdl5S1wjTU/cquegykqTo3HqG6blGz40n1CW8PUACgYXtyIIWBP8bLa1ifOGGApsoDdEyHGd0tZu4c0rgjSTl9aAhdciS5JTxCVAW1QN1fRon6/+q6Y/kmq+L8a90XnewLWlk2L2hnNAVOoCsW2eGzKET8lAhEAl76b4myNKbpZ3vos51GNfgfSngbcUP61k0+64B79tI7nI6mHlJ5H2neOugZPTL3;25:zcmvHi1Pgm3kgpVPDA6kxkIRAZz1ivcI0moh4tw8eMGBtKKvMmDxwanZVe+vzbU6U7VZE2dREQWlGoKQu0JPk0mmy7u6KHR+N9zmRx8AYC1j+qyqqPMSwCFDn2NBAq/C4JqpWGXKRKsyYd1eemzbrG3EvmKYVdMmXBbhaAN8GiwowtsA6Y6ssUBhUoLGTrNGSFbDFiGbxLZ1pYzoUT/unmt0FuZ0FN7mim60JpuvavVsMVColgzslbL1C5qFH3iBt3gO4Y2mXxIFX7LFhU3VMIq30r/SXdszaVuHvvs/NYBnJA2Q3vPEtXaZLpI4igzioXPoJ80/qHQsaJRA6Lw+zA==;31:Nhm+iEE4w+1iwjV4rkE/yj6cJa8hm+NbbeX5WxOfSTZnRB7gQDUPGo2Rev6sAb9dVy6KTUnWlZwfnQBWHWVFh+r3kbHYcxnWWtBeJjBMWzA30siO61RO/hPDKvnhYAZ5hIy721HGbpgp1DN/b/sGd7EOhXJ+e/AQD6KCK+Zz4OhN2KAIuy10RBojx7k0B4LlbqQCFK9mtBVi0Aus1QXSOoQSj3GDHq7dXdysCIP56Ow=
X-MS-TrafficTypeDiagnostic: SG2PR06MB0981:
X-Microsoft-Exchange-Diagnostics: 1;SG2PR06MB0981;20:G55dIa7L/sDVAumcLt3flqLBNKCs9UgyIymNw1E1Df/OdjLSxwmAMpZ3HmPjwIO9t1TZof5ADw1hv8BX7Temx7D+DJ4eBMvSmhe5P1Aqg+11EJfbXLPO7j+qvBH/z/KBc5Qk2boBuXI/D25NKnf8BEWSfESIwSvP9rToZx3ldAbDRNCfkOOr9kWNHMojLGo4ZN9YeA7yer/HitCQTMuWSTuX5R+004FzXhjHIVMOOErnfLe6QEyxNBn0LxoFHW10M5v7TnMqdHnvj2YsfOhQl/5mhBp81HL/VlBHt7r7spxcqWByem/TVV47tm1OrKWvJdP25uvp9uE8daHjUi7TRuSHtr7tpIMNAlKho1u/N9zRk5U79JvVWZ1r22WklCDluSui2v1bLNpRwsM9TsyeQgMESst1/ce+cHFr1dbkzFu6DRkfSTkk/sbKwWRoUzfVdrzsyrFIPubtGy5BxapmDfJPXXQXRiOnK+mNYoCczxRwEeQAAkqp2olG4zk82EyM;4:Dna0s0KvqADoyIsP0atPnyLIZdzfQ/LQcxa9VF36ohBhm4/Db4m7u5f3ocguCraHTL5U0DIdnxHrotRUJ5Jehs4vk1j1qhEexZT405wetZicQIwQLGkqVUQ1cAl2uP1wCzLUp5EMwsiXNxJvW2U2BqW8cE58/HUyfDQlWeHi2T84IUychSvckNDGO7SnS+WwSQNhaUYEzjP3GVoM4N0fskLhMSEIxCDjiionM25XG+/eYApJsK0irMXhhhkPRAYwVfuEOh0SDFBgphNh7SwOvQ==
X-Microsoft-Antispam-PRVS: <SG2PR06MB098116648387DD19F98A4E02B8C00@SG2PR06MB0981.apcprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501198)(52105095)(93006095)(10201501046)(6055026)(6041288)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(6072148)(201708071742011);SRVR:SG2PR06MB0981;BCL:0;PCL:0;RULEID:;SRVR:SG2PR06MB0981;
X-Forefront-PRVS: 05961EBAFC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(346002)(376002)(39380400002)(39860400002)(396003)(199004)(189003)(2950100002)(106356001)(8676002)(386003)(6506007)(3846002)(26005)(76176011)(42882006)(16586007)(316002)(66066001)(6486002)(52116002)(68736007)(47776003)(53936002)(6512007)(50466002)(51416003)(48376002)(498600001)(8936002)(97736004)(36756003)(7736002)(107886003)(25786009)(50226002)(78352004)(305945005)(105586002)(4326008)(2906002)(6116002)(81156014)(81166006)(16526019)(5660300001)(3720700003);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2PR06MB0981;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:0;MX:0;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SG2PR06MB0981;23:18ytKpN74Y5I3T1xl08NJUXoYCYEITiTW8ngmFTD/?=
 =?us-ascii?Q?xxV/Ikv+eFmFTK1+xafDUsJPQPFYEBosnSjZ24WCepxg00+51CTyp7OZR9H/?=
 =?us-ascii?Q?v1yJ6z5tkZ6DuDvFIDzKHE8oLd44b4GIPhdl1yHaqEMQWq4mlXrviDZeKf1Q?=
 =?us-ascii?Q?uR8VKKbqzkYEUfcJbNe0G2wfyisRabqLSyJB7l7/LRTV+Rw+8e0gzEXUf/9z?=
 =?us-ascii?Q?nJUtsRl3VgK/4BDamWK2ifkODVhws6Rb8YyLSbn+6Q6Ys0xCeMlFc/YTrrpc?=
 =?us-ascii?Q?c37XAdJQTzGz2ebXmIOIxq/yXpLfr1iuLRqoYgZkl9gnvf741dvgbkSDhkvC?=
 =?us-ascii?Q?JokMN3iAyK3fp/qbpHHUOtzxHJ6dLsvYypCrrpFDsfmoii89ZkIsKVp8Rm7q?=
 =?us-ascii?Q?AZXBWgH7VHd9XNJhBmKQ7PI/X2vft1ysJz7tn9i6/K4O76CnDDUl6oTSyMVH?=
 =?us-ascii?Q?8KOIKSv/zWKz/pjBwBGW7OEaVQTxvSBvPBfZvgR9e4NSX6abeCQBCuk8sPmt?=
 =?us-ascii?Q?aBsvXRzg36bqfUKskdlFXUKx9SKYwinHFXXKuHkPq/Epj9J/Asl2M5hZ/+4T?=
 =?us-ascii?Q?WpvnmsqFK6MIllnlWooS4BQwiQtB6ouf0wCxZ8HpFSPTYHSlN0STGJkjDsME?=
 =?us-ascii?Q?UZMZzSD5ybEP//2KjH0WE4oWLgX6O4GMo9E8F6Ww1OB0QHalSpszb0mgGTPE?=
 =?us-ascii?Q?Qfb65BBEcaax56pTfGO4tjc0eyJZ9T7PngtvaJjBdvT1Aa6/g+oFnZ8Swbs6?=
 =?us-ascii?Q?UVRDJs32m7j1NBGe3pEE1LJnb9PnuYAmD2NvFcvoxSxsNWmoJw/3mpXzFuEk?=
 =?us-ascii?Q?CjSLPXLHgnJZoBhtniKBG7abb9dw358J9yZjiQ1LP7MeXD7ZTGDdxw7BgbGR?=
 =?us-ascii?Q?aWi7yG9BW4QIZim3seFLnQsGYdzK68bqcygzgbaJvQ1LcSr5QU5MI4GngfzF?=
 =?us-ascii?Q?8FV8aiG9cL8Vbz/2QIoB7swvs4ii1M5d8FnLf/sy7X6sdNTbBe8SsiPopMYq?=
 =?us-ascii?Q?dNbjcl27WUUuEOhq+9pYDgIWjoMszl/vhKwEzy82NEa4lc+OUrEPzVXmF5iZ?=
 =?us-ascii?Q?gDcDfdu0DDr/jwGrneTiIHSnvrl0Seqp2jquRdAwZIG7RgAojj83jKOePDDj?=
 =?us-ascii?Q?OV/uu7lQ80B7zWn1Duna+SoUdoeR9Yk?=
X-Microsoft-Exchange-Diagnostics: 1;SG2PR06MB0981;6:jaixc/xzkHQZHdY79qR0Zpyfd9BYqCD0MRs0V3QgpDwMNeGMsIs72N+7iR1HCbjkkNy8S6uhPfdUhJMRKIUDJCVRJ0DIkh7Dg9Oo7DdDyIj+wuirwnHBH1/92obP2xQ18lSQ9Qd9C7VWZD4QuaFO+jYOivh3/6L1rbgJxt9tZfjaqNynLuFAz2MG5VlXK1oHMr94AMt5VbgcKmWxk2bDpLh0wMkAdY6YCcS8iKzJFFMGMY5EdCkbQJ1y1e3zuuUvUICh9o/h5VMp7cX1sLFFLBzRdhrClt/vSH/x7s8tXBHeuo7GbkgbXBWrQmgDwqGP02KR1F8AdydpkV08DdQwCyjdcKzkSYp1M4ytdzdADZI=;5:zZAvd/fg0EGavXY0wl6sj796ppuKjRYmx0rPLVSuLsiHL1+2P0fPsAk8wFlpIw/y2xs6oCVEpOdiMQaeHRZSTPlQPTmZde+Mp7VwsIQwqLaEvEFtZpnAV/mbY1s5WOAWh3mW/5hWRh7qYb01v9pzgUhHALWXOClCtF+Kpd894Ek=;24:spjK9/05tyD4lpfj7OJvUuNiCeuZH7ElkdMNyE5unnyxQsAQbXpIfhc7NyVHOcvZdNN9nMD51A0Rsfp65bznVYMiJgG/0wuW2ogdX+tPQGw=;7:XK619oVHAU1JVMXRog7ObI2tCPdMTmmWAng7lITX5t68IYDoZ3lKXgtwDSj5WUn6c0NSa3RnCRZp89Cw9kYURCGmUriRc6BcOwUSdnXSSg+VS0hhDyS16JdSEqSl1mMbNtVa8qikyJ8ZJmcWkKNJYNbhiFZXkUrbYil11dqtAefGNarRbjU2VF1GDMkwBinAAThT693m3TY08RcoJ/eK+0rVVKwAPzZyADvQWra7JIsBlpErgHghr08qvnlbS+b9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SG2PR06MB0981;20:AIkHrHrovSAE1D2p/IBb3mYJ993wuc/DpZ2+wpuWS4CJu9dtm4R55Av0iyWF78L4HoSQgLJNCB6zei+127kcJv6iqqOKCLuzpUzljp8HHMqGPdpRH1oTDrA4f8z6VLwwt7mZf590WfgWYXgq+CTob/wM7dAX/ccOBN3CKk6H5OA=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 05:57:24.4790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a258a2-e0b5-4321-718b-08d57da6f9e0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB0981
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for r8a77965 (R-Car M3-N). This SoC has
dedicated pins.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 2 ++
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                     | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
index 99b651b..dbd137c 100644
--- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
+++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
@@ -8,6 +8,8 @@ Required properties:
 	      SoC.
 	      "renesas,usb2-phy-r8a7796" if the device is a part of an R8A7796
 	      SoC.
+	      "renesas,usb2-phy-r8a77965" if the device is a part of an
+	      R8A77965 SoC.
 	      "renesas,usb2-phy-r8a77995" if the device is a part of an
 	      R8A77995 SoC.
 	      "renesas,rcar-gen3-usb2-phy" for a generic R-Car Gen3 compatible device.
diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 9c90e7d..fb8f05e 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -397,6 +397,10 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 		.data = (void *)RCAR_GEN3_PHY_HAS_DEDICATED_PINS,
 	},
 	{
+		.compatible = "renesas,usb2-phy-r8a77965",
+		.data = (void *)RCAR_GEN3_PHY_HAS_DEDICATED_PINS,
+	},
+	{
 		.compatible = "renesas,rcar-gen3-usb2-phy",
 	},
 	{ }
-- 
1.9.1
