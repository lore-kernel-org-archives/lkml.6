Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeDSIDA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 04:03:00 -0400
Received: from mail-by2nam03on0087.outbound.protection.outlook.com ([104.47.42.87]:2785
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750913AbeDSICy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 04:02:54 -0400
Authentication-Results: lunn.ch; dkim=none (message not signed)
 header.d=none;lunn.ch; dmarc=none action=none header.from=synaptics.com;
Date: Thu, 19 Apr 2018 16:02:32 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingju Hou <Jingju.Hou@synaptics.com>
Subject: [PATCH] net: phy: marvell: clear wol event before setting it
Message-ID: <20180419160232.519d15be@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0152.jpnprd01.prod.outlook.com
 (2603:1096:402:1::28) To BN6PR03MB2626.namprd03.prod.outlook.com
 (2603:10b6:404:59::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2626;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;3:y8UzKdlHT4qnxTfJX5RZaSTSmHmZPFJlIi5WGrJl2yuq6Wadxc/ZdsaRKcro6SZ7GVZq94Tu2jLglTw9AyWrTsyB/JGNo8z6xM1BeSXa6NevXgTLrkEHh2LGroyGfgghLqtjvgdS4jkUCOpiRV3RZvdTokj/5+nTdT63oPNr+ggz/d4XP3gFx66b3WLZg1cYWcw9CAEm9SOPj9MGJakIH/M1P3Zobz3aPZui91xnm1HXNosDAaW05OtufbNqYUYI;25:bjUuXdewWTLHavCFSmOoQ29vexbC5lYKjeqdo5vgEUVodTPp7jLeVy1ugSJBDSimYNeTCOyIhvQmHeFfY0AC+r5UQ1OKQrr4Oh2AjxIv71uH5k3c2YkG5adIVmgIpjBlgUT+Ocr1tx+vmNEO0d/tETmJAx5rj9lyFIS9iY/uLID9I+7DEDRSKEPQ3QiwFYnALUtYIt4IkTf1zj4V3VA1hcHSKvn6FjN5o+5NQHJ0lMqUcnbv8rQzSP7CY47wlRfbVlMwTKiJt0ecKqT6WTSSlG3HmdwWh+ZcQMJOY2NbhhvSqQ/qlVDJzSlaJ9a1sKoZIfQk1C9i3hmhu+5KBWwOZw==;31:WRk7UR97f5dMkFrZz9kztOEuN0Cjm6HX93j3RmHybvlJIdIzo9llGbPjrR+zYdn4VxqGLwSXfIOGHWZlQPiPEzwQRuoeTGTF7jqUSKeL20MLQq1JoSScqLUWSgobLqWP4j7rPyyD5TMtr+4kYc/XehsiTKXsrsMTXr/ios8sOKP526MMLjUYYfpeO585j6GSuc13OWoK2sbVbSAYIMjG7Et1mnxZd+Yya+tuLuQRQF4=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2626:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;20:7VUMcZg8M/h6rwpS8isDL2zzE4n+GItpHF5qTZn7pJ1aUBH3AOhIPfDMoEQnqNLeq6S+h8Fm9v4sqr1ZwoCpdllEX+4mFkMNSJtIZ+kE8vASC+pFF3eUPRAE+ACKy/x6IzIClitU/PGOpLu7ehuB0I8yM9cdc6vwIIJ1POKhyR8cSfjU4nBvn7WOZPD9TnR27/+vCoH9O8Yb4O0OSBP4rx1detFR9XvKtJVX4DNbj7WNlqrs/e3Mkfyt6Q3g6n+BvvMPpvcp84pa6ox8KIhL/GTdBN+ze7bficZ9lj95tutAghxcFTg78lu7gE8A3gIXC2S8LRKg2tKCAdnLJyapXd3D8ySbaKfBkDeqKpDTqF+o1PKHns5doxDKAifudTfFvAJ9dFfsUUzFE8XadeYAvpPi0y4LXVD7uvJ4b/TQVep1DUCArauN10QgJNT6s5B0wzdcqCb34ZV8HYvnKeLGcw8uoyKbX+xLGc1pif5hU+OCvW2deQ5hWPN7ESQrCgww;4:ynQuZVCnOfjtPXnkLionXeS5gcrr1Z4+b6wrxgKPoaYi6ExA1+pG3Fjy9LTMnNKLSNprwenPyEEubWkwPARDqAN/Er722SpTC36EIZn1EzTbW7zzROUOz+UJr5FCwhoHSwTbFpySR36zVwnV4xaoL5oJ5oltEIqLTAzGZ106mLaYml2pgTGK5zcMRABlX52DivfhOviEKbbJsx47CRBDNoky8DhPgoUWBGoJ/4rZDmMZM0+rSGU0ouiqw4K74tPpG48EHw6BUEuS9bY2zpmVlw==
X-Microsoft-Antispam-PRVS: <BN6PR03MB26265651FAFFE7B9976366DFEDB50@BN6PR03MB2626.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231232)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR03MB2626;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2626;
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(366004)(396003)(39860400002)(346002)(25786009)(4326008)(86362001)(8936002)(6506007)(52116002)(5660300001)(26005)(1857600001)(7696005)(6666003)(81166006)(50226002)(386003)(316002)(33896004)(50466002)(110136005)(47776003)(53936002)(55016002)(16526019)(478600001)(186003)(6116002)(39060400002)(305945005)(230700001)(8676002)(66066001)(9686003)(1076002)(476003)(2906002)(72206003)(7736002)(107886003)(3846002)(23726003)(956004)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2626;H:xhacker.debian;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2626;23:VKVK/Vj4lCxxv7uvvEI9CmqidCwobRGIIPseySWWe?=
 =?us-ascii?Q?Nz+pbetRyWmfunxiIs2uc0o4nU91aE2yyf2Z30RvTAqz9U6WbCe7R09I6k5X?=
 =?us-ascii?Q?b7vmq8SQI8f0TRWhIZwahPfoU3H1K6u46fuXFpgnro+VqD+YElP1f53ub/SH?=
 =?us-ascii?Q?JtQiIbYmzufvT3u7kpmAecLdqRAjwxhHdRwXnTRuxN9+DgErZQBgSSoYarJq?=
 =?us-ascii?Q?gEMhYP9B1PC7WbJS/1Oks+BcXd0F7v5Z2K3nJStMjTkp7VLw7dwIoPEzRh1h?=
 =?us-ascii?Q?wgiBCTLHY8mMuMGoEsllDMu7tCsRRMCc1C37WizUeo4CIxmogzESPuHw3yoX?=
 =?us-ascii?Q?DbDiXdDTtjJSK8oar741ovS9OODmMigfbVnie6Q9OHVT5CPf4FC1Fa4WtnKR?=
 =?us-ascii?Q?AoTRjozAKy6co4naLTLb/BolyUX9Cn01PjZYWlea4liGhaqqp99DeHC7qZ1Q?=
 =?us-ascii?Q?nCx5zvJuAaT/NcV0yQTWdjuBEJ4YXUu87FGIaa/HpWgW8sptaModm7X2tzed?=
 =?us-ascii?Q?sFK8c8GiCvx/Hbi9qxA1w4yE/xcGAnchYaAm46InETl6WjvvxrZxUGxxp5ZD?=
 =?us-ascii?Q?mkjLkW8+oIG2vDniLOBXMw9eba6eUI5K3xH+wMydk3t2heS1Giaw+WLAbYec?=
 =?us-ascii?Q?xjk2ZEWXSuQIgDPV913lPmOHgzmYfl1ziLohiNXj2Mbq2S4Rog1U6Hahx+7r?=
 =?us-ascii?Q?fCgi4awljmfkPMeQFVunlvfnlSc+kQ/Wa8x7dkMzd78Ev2LlUtYpoOP5i5gg?=
 =?us-ascii?Q?6g3JcHD5JfLtc6XHjPuVdu9HS7ryA0qaxVOVONqsIHeGHj8Vqt3PXWcMCIwc?=
 =?us-ascii?Q?iEnAnAPnDU/tvEfkoQN0LufuXepBt3afQ2PVX3N1f+J1sEBZpljZWhXETNGG?=
 =?us-ascii?Q?krcF8NGQ8frhnVamxOPhYQD1weKXHW0ibrT82iLvv31GR8FlRvbWkL9ii2L6?=
 =?us-ascii?Q?vNfx/0a2QCL5sDgEuWPzVRf8PTxrMSUyEjmksKMif/v7kZOJ1+sITt+R36xO?=
 =?us-ascii?Q?SAtIA+4nMGzn4QJeiAePZ2hVRLMBXywa5vSq5NEfzNzuWdi/ySvrzhLaRYxF?=
 =?us-ascii?Q?LHsBVQNjkfslxrwQ8F9fJl3k9gdH+g4egnKTyCcpvBGk5UhDw=3D=3D?=
X-Microsoft-Antispam-Message-Info: Ri1bG6Mf11nrsuM4cJ+IXptAZjfjZIvgT5cBvvxjwisk0XrOnQ7VsGE2ZwfjVwnb0ceJ8mtdJaMm/6fMnHIeJChj/G9MwGecBCZEaeAAQSUR+7mSJXNyC7IaUlF7gIpoa4HCAwsnLVtU/RewOBcHL53RFdrN7yrzEeYQCQCLE81OX4DSL72J/JPMsk3qe9Bo
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;6:tsguXaDWoUDW9WiFK9BZ3Swf5HE/WIjjiVCuXMBluWOugMnOrawU6khzV9qBO0fcR8xhmoVVCEz5osTtcdyk/xmBoF/DdbVAoFgtXp19ixwO7uu877rvIrHLc05nfizJPizBuOQSC1iKlluERMdfeh/y8xzP9ot63r7xE0kIeGEGw3YPGMh6xNlciw5KGrn05csOI+74nF1wGNefmFRk1gG7OdNSYKK/RSAe7Ft8NRRhetbL0aCcQ4nkbSY5Ev3HbyCCx8Rfi/330p6M0b9N9X8Mu63i9niJJQwJoC3vMcqZDJQYbf/i+PFzbuX9/4MtjGNOBIhJQKTOgkdgnzmcJFFcmLU7uoTA+kIn9zNUCDShE1103EZ5mRqBT11DvZQ5dh9YCHoBtLg3Nz1Neqac4MdnJ/eKWFtaxYxxONVWGd1fFYsBpV2MD3PXT5OlKMn9cdOGcNw4ezsrecnohBChJg==;5:uyA4Qe57FIrG8MCHRyncLqPnDBnctf2JEkR0Duy77CW9oMcu5rS2GPCbY91nDxAD3t2JzLma8P2Mg9Qxa8GI13ermgZSzC0DUEkG2liQYxGWyuP80QbD1lHTOiUJ2zjkaspwQkG7K3BNCdTk4p6Z30a1iuFngdy4KLSnwRXNkO4=;24:jy9Av7RN9P4pa48JLChRPoiExEINx0db73JNUpmyHte6rqUI7Qjye2r2BFZAYueVNyXjUsfVM1CoOnCwc/fvmZ3KodlscLFK0zTQVtL00mQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;7:M0ibSDuA6r6+q4wqNQ6F7rN9s3S2+OCmWvW1opbuA0NUtXPAiHLf2jgK2PpGP/twGVR+ZpWVjKu+xQ6+87LX/W8J37OwMvXkI9IlwxovXMLVw8/DAz74izpbP3qt+tGBXE8oCK+582W78m8SOmsg2HjMGEIJWXLH9dVQiXLmeBms7r0wAyeWYiFOBSXWpNFcnh/UKhdnOKnMVS+q2bntWl7p+ItZvkOUa2OxYABXDBgjjlcmhDvvjoIG8OR/dAeV
X-MS-Office365-Filtering-Correlation-Id: a1aecaa5-45ce-463d-3fe8-08d5a5cbf3a6
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 08:02:50.9090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1aecaa5-45ce-463d-3fe8-08d5a5cbf3a6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2626
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jingju Hou <Jingju.Hou@synaptics.com>

If WOL event happened once, the LED[2] interrupt pin will not be
cleared unless reading the CSISR register. So clear the WOL event
before enabling it.

Signed-off-by: Jingju Hou <Jingju.Hou@synaptics.com>
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/net/phy/marvell.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index c22e8e383247..b6abe1cbc84b 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -115,6 +115,9 @@
 /* WOL Event Interrupt Enable */
 #define MII_88E1318S_PHY_CSIER_WOL_EIE			BIT(7)
 
+/* Copper Specific Interrupt Status Register */
+#define MII_88E1318S_PHY_CSISR				0x13
+
 /* LED Timer Control Register */
 #define MII_88E1318S_PHY_LED_TCR			0x12
 #define MII_88E1318S_PHY_LED_TCR_FORCE_INT		BIT(15)
@@ -1393,6 +1396,12 @@ static int m88e1318_set_wol(struct phy_device *phydev,
 		if (err < 0)
 			goto error;
 
+		/* If WOL event happened once, the LED[2] interrupt pin
+		 * will not be cleared unless reading the CSISR register.
+		 * So clear the WOL event first before enabling it.
+		 */
+		phy_read(phydev, MII_88E1318S_PHY_CSISR);
+
 		/* Enable the WOL interrupt */
 		err = __phy_modify(phydev, MII_88E1318S_PHY_CSIER, 0,
 				   MII_88E1318S_PHY_CSIER_WOL_EIE);
-- 
2.17.0
