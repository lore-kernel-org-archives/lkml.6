Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=LandisGyr.onmicrosoft.com header.i=@LandisGyr.onmicrosoft.com header.b="GC//Wmoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0DDB46063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=landisgyr.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932436AbeFFIDm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:03:42 -0400
Received: from mail-ve1eur01on0099.outbound.protection.outlook.com ([104.47.1.99]:26944
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932304AbeFFIDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:03:37 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Onnasch@landisgyr.com;
From: Alexander Onnasch <alexander.onnasch@landisgyr.com>
Cc: alexander.onnasch@landisgyr.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/phy: Micrel KSZ8061 PHY link failure after cable connect
Date: Wed,  6 Jun 2018 10:03:18 +0200
Message-Id: <1528272198-10825-1-git-send-email-alexander.onnasch@landisgyr.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [80.239.165.1]
X-ClientProxiedBy: VI1P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::41) To DB7PR01MB4267.eurprd01.prod.exchangelabs.com
 (2603:10a6:5:2d::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:DB7PR01MB4267;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR01MB4267;3:jFJd24nFD28atdGm/ipEca0RK9fOv4KBz6xrjVl7ZpepaZ8QhFhlyTf9tGUS1HzH8Gs++Pkz8DZd2aisj2C4j/Ga2U+21BhjwPgvghOwDpqjWF5gzzGzAck90VE8wzQJ058gB/+PtTLChi6kuKboTYZ0QJ9sIdzM0JKAYkyaA/jvu03NKObrdGwNbg5UhW1xgvE9Znqznrg7/uswwC8Bxo7B4XnSVhLxIxccmwHDjDd92WD4edzWReLG4zZ9nfa8;25:t25g3JvWyVPEHspdJvWjPf3Q/qd8/AqcUtIwEaD+/n+4iyKNiRsNrI8Yf0J56LGuWZbSLEAYidt10b/M9dJ7pMm2GzfP/E6uTEFeeP1+ZphKa8O/wCS8jbbdSaebxClaZD50M10MNvj5d7kU0XlpxOIeYiAlMIvtbCBpVv45w0r9ZmLGmO/DuQATpftrn5iQ4v6+eRpMHRgG0V3ebq/jGcqZepWNBqhoxJSiPrHtO9VVSQBudTz5UjN33kR9j/y/3Anzwgnb/qgfW/xNl7meRUh/c1vFSVpItEHsGcBfgrJ2JA9aMDcMlkD+sGMJowjaUiQ32LCMNwRlRegpXbjOIQ==;31:yFJAZdr/JrsJnqXs3Nuiisjw/XBbcdgwWMujQXx+5s1BqSMdsdGs8gUSaZIqnaOrjUBpUbmYh8H7kaRTwO847j4r/ZuGXIOMCPxRhu1QBWBXSQX7c7pk1LRupxDsebcef9pOHiM4U8FKb1xr2xLTZY6jh7yvWFJ6P3RT4C27Jf+mR3Q0EKZUr4SU6chGhPkpDCwo67jxAc9B4jPu/IG2IpAs5647sjqd3UN3k9NxixM=
X-MS-TrafficTypeDiagnostic: DB7PR01MB4267:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR01MB4267;20:IEYC3hlNZdWvR+l118gw6U3YRmYhGKLq8FrhENSvKmdy5ugPBRqhG3eamFPg4Wo2EEqsWevRv5lz8336v5vdxG0ZaLNZ8WIBb2ACM19noJ+XpZKWW4e/QfidRdMty1W5xFZH/aMe1HnAKyyW0OkOXhlq33HYccyHHRvtHajZkJBobj4NqODaxcWuT2kbHm3zXUQOlMGdjvv5ESjNeSd5Chl7bg/YnFVjH+oPK3CYdq2IaH9gvZs0kt/8xiKBJNCkiSCXNMcUiQ4xykz6ULeBpadYG6pt2wzQ9eUN2xbgiBSFDHvE4sJYPumKaeDBB9V5uDFQzY+1qtCs9+K8IfUhOjrbqp80MnjNxlsJW4ByJkSh4k5B5EiR/k7lbdzwWbbg/orsTUVQ8stjbPWRsPV9QzGpcpq25EjsHXssHtY1UBda41Us5UUTV8PpwtU7QLX/pCWiHCb3GDON6Ll1mkIPQH28veRmoZu03U/xC6nE8u5jpDERLoGyPrKb6bKyGJLd;4:WhQb09XRkDIYTmF0iRByu3xaq8TuOLzp/+uu8F6KNyJLVpFeAUNQ0MYhvKTBH1m3QkItSLbC1vyIYbVaEvIun1oUqnzmrTOZNbm0mqAVrcNvf0G2QFJuTa9fgBl46cM5xj7Xdwi7FXRvfmI326O12TvUflirkcrORsIOdFmwF/xRRbVqwrZm7/VfUGEZfVG6yZaNpCC+D+pjgbIwCi57iKzmy09Iu7PQ2p9KZ0E5iaTRmF9cC+z1yCwwZTw9UaB0C0FxYr+1kLYYPX8dWmFUHMnWPILi/P6NC7+fh6IHH4udKDElFs91VifuKhfVdhJ/aKNy4NzjJ+QWw7fUUwYbRgkN1M7AOPhSGVKK0WPlDvQ=
X-Microsoft-Antispam-PRVS: <DB7PR01MB426778583CD3005963B47A7AF0650@DB7PR01MB4267.eurprd01.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(144836121648609)(21532816269658);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB7PR01MB4267;BCL:0;PCL:0;RULEID:;SRVR:DB7PR01MB4267;
X-Forefront-PRVS: 06952FC175
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(2906002)(97736004)(316002)(54906003)(2616005)(1857600001)(6486002)(53936002)(7736002)(476003)(956004)(486006)(44832011)(386003)(52116002)(25786009)(5660300001)(26005)(16526019)(39060400002)(4326008)(6512007)(305945005)(109986005)(8936002)(8676002)(81166006)(50226002)(23676004)(6506007)(6666003)(50466002)(1671002)(575784001)(47776003)(81156014)(59450400001)(68736007)(6116002)(2870700001)(72206003)(478600001)(86362001)(106356001)(105586002)(66066001)(3846002)(36756003)(266003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR01MB4267;H:CHZUGPC352.eu.bm.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjAxTUI0MjY3OzIzOitQNGpGb1k3TlQraEEvbFlCRGNlc2NoR0w5?=
 =?utf-8?B?UmRySm5yU1JiZlJCSm9tVUJzMmtpaW56RCs3bm1zT1hwamhQMDg3Q0Rld2VV?=
 =?utf-8?B?dDNIZ1Z5RWU5cisyQ01zS2djaVFPUEZZSnVORUR3bm92ai9QSmRtOXFqZWFN?=
 =?utf-8?B?T1lBUTdxNXZjTWh6K0E2M29WMTZPRXJ2Qnp1ekxxejluRWFXZnpodlVzVmNY?=
 =?utf-8?B?REU3U2hWRDkvRW5ZS2g1UXJFMlg2dlRVS2J3d3BDSFRiYUJOeWRDcEQ0NkpD?=
 =?utf-8?B?WnIrN3FNcjU0ajk5RDdiMU5pc3MrREhhWFhyWXZxNVJ1QTdaUHhyV2tzZUFD?=
 =?utf-8?B?d1lZR20yQ2VsKzFjZHlVbnR6dG12NHljcHcrTTBmeFlydUJQYlZ3UjAxeExv?=
 =?utf-8?B?L3FCcHVSZDltYXNZb0tKa25jMjJkTzFMci9hdXhGZERmRTdoakMvbDgvZ1ZW?=
 =?utf-8?B?akJWMVEwNzJ2M1lBT1hnbnUzMm41cjNMdVVqL212RVpYQ01WZmtuVFg0amFC?=
 =?utf-8?B?ZStvdFpDQTZSMkM1SnR0NFBSajR4aVkzM2tsWG1za1ZKLzVTbisrZW1IWmd3?=
 =?utf-8?B?cW9vVlRjZW0xc2Nvam5yYU9ya2pmQTh0QXJTRVp4bVNVWHIxVVUvTGV6RDg5?=
 =?utf-8?B?WVM2eEg3MUEyQ2pXSzVtNndmYzBxOFpvcUVGZFZUNi9kbjVDZXllNlo3TWpr?=
 =?utf-8?B?cStnUW1LbDQ1NnV0TGUzdFI2a01KbzVYRkwrVnN2SnRhNXdDblRHYmZqNkdF?=
 =?utf-8?B?M3c5TEoxeHNZbnNuR1plNHJrM1BhOXg4Vld3MW9VaWczbUtBSUxBSHRIcU5o?=
 =?utf-8?B?SzZBWFI0QmYvZGxqMS9pdDY1QXdIeVBzL3RVWkZmamsrWE8rV0R6MDAvdnBm?=
 =?utf-8?B?SHVpZzduL2JCVjA0WjdkdXlmTTFHdGN6YlpINUMvam1aUHlmaHg3WDZzRlp4?=
 =?utf-8?B?bnM0Mmk5T09zeHhHUHA2a3ZHYi90ZEhKSW5YajB4MEJFRG1paERUV0tKSHUr?=
 =?utf-8?B?cTltbStnTjZsZkdrRC9FaXZGMkVoNVErVTR2eklIcXUyTUpvdGd4dHZUdmtV?=
 =?utf-8?B?L3dDY3dkSG1KK1JzSnpMMmEyNyt2amdpSm1yL05XOERZU0JYaFhaSUIzL3p2?=
 =?utf-8?B?MndxVktkdWo5d2pydlIxMEtWWmt5YXFQZThEUEYwaUJxZUxVem83N1dQNklL?=
 =?utf-8?B?YWxwOFlOb1A5OG1kenJ3eUdHUCtRelZyVDJGYWQyNXh2QVRPUWNNV2VtL096?=
 =?utf-8?B?b0lYdDMxKy9ESHA3SFlVOWt3bFNtVGRCaGlrbTY3UFlSeUFqK3lKSTA5Nk0v?=
 =?utf-8?B?Sk5tbUVzRlhpbXkyb1lzbmRrVm40WUZjaHMxTUthSkJnUzBsTG9Yc1dyeDZT?=
 =?utf-8?B?bHBBQVhKb0RCUG9iYzJUc2drOFFaNG9oOTJYdForUHFUYXp2UjJxazZvamxo?=
 =?utf-8?B?aVdDZU5uRjFOdlc5bzdCZzNzT2M0NFFjS0pvbHJ4Z0pod1dsQWVQWlByYm53?=
 =?utf-8?B?YjZMckEwSG9RbEROSXd5RkVreEsvVG1OQ0JZeGQ0N21iOHdJR1ZQL3hXckxw?=
 =?utf-8?B?RVVySTd1QXVEbnY3VFkxUjl6Q24xLytDVHVsTmxmOG5VUXArRDRJR2xKeUhs?=
 =?utf-8?B?TjF3clp2WGVPdkNzUzkwOGdvc1ZWREhkSTQ1SmZtdHF3UmU5NVhYeEVsOVln?=
 =?utf-8?B?QmpySmp3aWRCa2FkcXdhOFdDT1VzWDFTbDBKdEg1Qno0bWdTeFZNK24vYWw3?=
 =?utf-8?B?M2Z1bkNSOHFJVmxJaWdCUT09?=
X-Microsoft-Antispam-Message-Info: t50TlQmP9250m4Im1MYoYEsWkDFj0haanN+v9Klt5QQQ/H4PIQGktydxMKvkYy3XtF8Ett4nwvqPTppJ8uYEfFLb34ITHSTPyg7Td8RCk9pIr59iLyNji0ub6bidnuq1e7g4ePBkMkiX3lH2o0I2G6N6bcccA8R17vaMg4zwPO8f1+v5B12XhytaRz92C/Tl
X-Microsoft-Exchange-Diagnostics: 1;DB7PR01MB4267;6:Wptehk7fovtclP76cUsIUl4NKksYwCPUIQ63F5nuu6uE1aG3f1zp8DcMg1jCyG0Z0sljiFKZmsZ5txqtBVGYh/MSCXMLNmNB/uEt9Dy7/r+lEvEcozyDM+0dAqnsa0iMTTFCs32aE3pBfAid9IpcKEWOUF3ezBSQ5jMy/ZcsDagHyYLv58BgSFteqSQSv1UknuaoQEE56ynJI5Zd941ALcWElBA0+KsAB8oDtTKO/pQMmH/mocCzqT2bAVURygC1ltDJOw90qrwoTJJW7lAzBS/1cFqafENjsQRD03l50j3VOocQUJmJwBBoKMA8SfSU02AgK/ZUPPzaeQA79MvFF7J+OXUQwkoS+d7OP+Cg2rhg0Hg/+OPqwotDJU4KSWJU3PULczLaxamxJiZEGkzu/l58LN3/mKg96yhKlX7M46M/yH28DQFYDhxfPwW9sQLmEPwFi9Z5MEe0gLPURaiwKw==;5:yLrLqWCojac69aJgUqeUSuL7AjRvAmOHRXTkshjsZpGATEcagOyr36zwt+lCXU/MIH5MXw89qFT6zbocNdDqmmeXSmb3X6hp5WU92JyyxJ24F8z2zsf06WnG59Bxg9Ue2o0vYjqy+TcXdZ9QbuncW7QUQe1Xan1j6+ca0BF1k7Q=;24:SvQnQdGHwjiwdJW3HM0b2ofGZhLYL0mBjX1ZMHx3/MaKmKpBAlSsp5ik5LZSdxQId1EUzXWL5TfavgdWovmTN2xzCyR2GDl4SQUEFDT+WZI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR01MB4267;7:dAJ/4xawPJCgo1lXU5AtVYsyyJrkNguq1P6XBSdzpwZpkNoQppRaIQqHv+FHz2dn0Pq2ZWSl1XGuhgMTfFEgnj/gCbIoYM2qp3wQF4B9emhApWkhnG6hnP3m6cbKOnW95VP12nq2LkHknJ/K4c/D7JWw+zFV5thd/bR1pUCcjaHhQdwNx41RMw1KkhYG6pZlpOSG5HtoqBSB7qaWfVPx2nCKcC+1/hA8OqtF2byZADCm0EVlCbf5LeGq1v8+YLX0
X-MS-Office365-Filtering-Correlation-Id: d008f33c-4c17-4f99-053b-08d5cb840047
X-OriginatorOrg: landisgyr.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2018 08:03:33.8935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d008f33c-4c17-4f99-053b-08d5cb840047
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ee2cd48b-958f-4be4-9852-b8f104c001b9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR01MB4267
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With Micrel KSZ8061 PHY, the link may occasionally not come up after
Ethernet cable connect. The vendor's (Microchip, former Micrel) errata
sheet 80000688A.pdf describes the problem and possible workarounds in
detail, see below.
The patch implements workaround 1, which permanently fixes the issue.

DESCRIPTION
Link-up may not occur properly when the Ethernet cable is initially
connected. This issue occurs more commonly when the cable is connected
slowly, but it may occur any time a cable is connected. This issue occurs
in the auto-negotiation circuit, and will not occur if auto-negotiation
is disabled (which requires that the two link partners be set to the
same speed and duplex).

END USER IMPLICATIONS
When this issue occurs, link is not established. Subsequent cable
plug/unplug cycles will not correct the issue.

WORK AROUND
There are four approaches to work around this issue:
1.  This issue can be prevented by setting bit 15 in MMD device address 1,
    register 2, prior to connecting the  cable or prior to setting the
    Restart Auto-Negotiation bit in register 0h.The MMD registers are
    accessed via the indirect access registers Dh and Eh, or via the Micrel
    EthUtil utility as shown here:
    •  If using the EthUtil utility (usually with a Micrel KSZ8061
       Evaluation Board), type the following commands:
       > address 1
       > mmd 1
       > iw 2 b61a
    •  Alternatively, write the following registers to write to the
       indirect MMD register:
       Write register Dh, data 0001h
       Write register Eh, data 0002h
       Write register Dh, data 4001h
       Write register Eh, data B61Ah
2.  The issue can be avoided by disabling auto-negotiation in the KSZ8061,
    either by the strapping option, or by clearing bit 12 in register 0h.
    Care must be taken to ensure that the KSZ8061 and the link partner
    will link with the same speed and duplex. Note that the KSZ8061
    defaults to full-duplex when auto-negotiation is off, but other
    devices may default to half-duplex in the event of failed
    auto-negotiation.
3.  The issue can be avoided by connecting the cable prior to powering-up
    or resetting the KSZ8061, and leaving it plugged in thereafter.
4.  If the above measures are not taken and the problem occurs, link can
    be recovered by setting the Restart Auto-Negotiation bit in
    register 0h, or by resetting or power cycling the device. Reset may
    be either hardware reset or software reset (register 0h, bit 15).

PLAN
This errata will not be corrected in a future revision.

Signed-off-by: Alexander Onnasch <alexander.onnasch@landisgyr.com>
---
 drivers/net/phy/micrel.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 6c45ff6..7d80a00 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -339,6 +339,28 @@ static int ksz8041_config_aneg(struct phy_device *phydev)
 	return genphy_config_aneg(phydev);
 }
 
+#define MII_KSZ8061RN_MMD_CTRL_REG	    0x0d
+#define MII_KSZ8061RN_MMD_REGDATA_REG	0x0e
+
+static int ksz8061_extended_write(struct phy_device *phydev,
+				  u8 mode, u32 dev_addr, u32 regnum, u16 val)
+{
+	phy_write(phydev, MII_KSZ8061RN_MMD_CTRL_REG, dev_addr);
+	phy_write(phydev, MII_KSZ8061RN_MMD_REGDATA_REG, regnum);
+	phy_write(phydev, MII_KSZ8061RN_MMD_CTRL_REG, (mode << 14) | dev_addr);
+	return phy_write(phydev, MII_KSZ8061RN_MMD_REGDATA_REG, val);
+}
+
+static int ksz8061_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = ksz8061_extended_write(phydev, 0x1, 0x1, 0x2, 0xB61A);
+	if (ret)
+		return ret;
+	return kszphy_config_init(phydev);
+}
+
 static int ksz9021_load_values_from_of(struct phy_device *phydev,
 				       const struct device_node *of_node,
 				       u16 reg,
@@ -938,7 +960,7 @@ static struct phy_driver ksphy_driver[] = {
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.features	= PHY_BASIC_FEATURES,
 	.flags		= PHY_HAS_INTERRUPT,
-	.config_init	= kszphy_config_init,
+	.config_init	= ksz8061_config_init,
 	.config_aneg	= genphy_config_aneg,
 	.read_status	= genphy_read_status,
 	.ack_interrupt	= kszphy_ack_interrupt,
-- 
2.7.4
