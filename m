Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF653C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 06:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6F9208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 06:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d+6PUZ+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6F9208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeHWKDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 06:03:38 -0400
Received: from mail-eopbgr10058.outbound.protection.outlook.com ([40.107.1.58]:30400
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbeHWKDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 06:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slUofPlVaQPWV7ke8u4HwrAygDLr3Re32wh9WwC0TcI=;
 b=d+6PUZ+96iT8CpY00rl9A+6QHTRKPrzfnVns0LpnJvqBo3x86Si0FJ6bBY3fxcV30NX031Qmipn/bAn0FHXPMDmJ0KjuJoq5Kb2fZ+FYtqaKPpjevhbhezTHtE06wHVzpmbiYel+FxMriAmU9J88vLZtmIgq3LwfhgDbQ3rbbbU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB3PR0402MB3915.eurprd04.prod.outlook.com (2603:10a6:8:f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Thu, 23 Aug 2018 06:35:23 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: dts: imx6ull: correct machine model name
Date:   Thu, 23 Aug 2018 14:30:49 +0800
Message-Id: <1535005849-14046-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0073.apcprd03.prod.outlook.com
 (2603:1096:203:72::13) To DB3PR0402MB3915.eurprd04.prod.outlook.com
 (2603:10a6:8:f::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53ccf22e-dc3c-47bc-60a5-08d608c29ce2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3915;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3915;3:jLIdqvlTt5E/oD1H97y4V3IqdLtWr4t2TCnnxvgxdTiq2TaqYF1WD8pS5ZSylgKYNgujx7oZixeqc6F5Ro1nrA7liV3d/KHwR8a/8g5NzCuxzHZTzel3R2DR7fjwPpEYj1kDFRss9xTh7dkOt2hqJkmB4VF6ztbwcgi1JTqV78Z3eum5B1LVqNlWrQawcKHTLgFN2BoO335ciHmXhixDTCvsN91ibl2OQqQ8U8ggAUblrmpX4cQw0nMWL9rjasB4;25:1oeTsaA3MycX5Cs0jclSQmMFyeiNwftgzZmwJmE0mpAt20htnYPQwDpp9e4mCY9AG+h6a12cavqKvC/pQGPm6Px9EQJHbhZqIKcNoC8AXEJ9/aBzNXrRLMlLmvZ4QXbGZl3kRAbW0P6DuB4FBSDkJ+0TaJL8EmeZXCFYKU4vExLbGeqP1gJquU0w3fGpSC8eBewQxZZ65wyPJXTRlxD6jnpyJW61tIhvGW9DUWDkWWCh39iApowbzWaLMjdHoG5nirQiTnrwDoMCyvMIhESEfndfarvxZ9q3suMVzrvaDVGYQ1SApJMtvoG3cVeqskUSiyRNJILO4jUYSr4THolbHQ==;31:2dIAxSGNEsyO7sJ4GKWzJ7Zj2GNLl5CZ24hJvGwjQz3tYOnaWPysNwy3rwg0/LuMAExrYbGlbbM/yl7cnVxfZaPEpnZ+dFb8NoECpmgBF4Xe0zQFNAvwbGY6+mzsn4UdEb6P0cjK4iuYfdApX/HZfEHJSI3k1RvTlLvzKTLjdMQw6Ah/4u4wrskFtlNk1kTyVcgc5z4vxXzOOacL/MmNFkY/r9w8uz+izL7IXsqmHO8=
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3915:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3915;20:Ui+VfrUULAPRhDRNzbI7cpQ1/0KCrp84ZgE8UNLQwqQu9oFT8YBpdMpmGL2Kx7TZPeqn+0F4bewBe47+Ta67t6iSVAod5lyG9KQrxX7d1icpedqW6ldpxOZbjurq9hj8pkrYSEWOJXXL/ekxKfLRLPWgytR3oSsnQok48dJrvrdGB6vpooLqY7+yrc43f+lqFzYeNwN+xFMMLq0pQC0ZBKJlR9WDaMxXYz9zANnLmXq/K/8FpLPWzI4dRZfJ53YkvpD+hUjS5IJlz4yNCb94ustHjDAd0LzCgzoRk7ByED9J18TfqIna56y/2DnvhzooBf15wEVn9dykUxdR0ZeUlvGbsF3hbVXbzewEkZkVEFS8tikbfR+FGSmhlbB4H0A90kMu/3cYgLKyXGvNmWfknlEAWWQaqoiGXN2CBRqpU/V2hf1a0xamUzzxNARXtNgb5kXT+0DMWvZS/8U4UFbCi61LX1TnyetONyrjeKqQ6z8raKloUcoLg2jk3ro3jSum;4:eKqpbHbtNEsCiiCTa6RjmFgqApeFPhyB65XFHIQhBheYeltXettaVQAPeU9C8wPm3V59j5yufEgMiSdgUzyUheS3COvQepyJQcR+k0NTsnJceoU1rP0kwtvlaU2nYosE2ftg0XCg41B7Gyx3UepJs/puOll5X+aJQ4JWPxHg2O46gFsMUh16Sg3uojebVA7u1I3gVPsoNpCrJFyaKwsVd3wEQMqqhpOVlFXzkpHOLVQWowveYbKzWaBX5oL/UP64etpknpRkFMhYx52s1E4yIeTQGrOxXp7J1LnrVKPeIDLr8H7dsPDoK7azmgu+FUxO
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3915301D52F3EABA8BEA64F4F5370@DB3PR0402MB3915.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DB3PR0402MB3915;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3915;
X-Forefront-PRVS: 0773BB46AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(366004)(346002)(199004)(189003)(7736002)(486006)(86362001)(66066001)(1857600001)(97736004)(68736007)(305945005)(6486002)(36756003)(6666003)(6506007)(386003)(186003)(16526019)(50466002)(48376002)(26005)(6512007)(5660300001)(47776003)(106356001)(14444005)(105586002)(476003)(2616005)(956004)(53936002)(16586007)(316002)(2906002)(6116002)(4326008)(51416003)(52116002)(3846002)(478600001)(25786009)(81156014)(8936002)(8676002)(50226002)(81166006)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3915;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB3PR0402MB3915;23:QMu11u+IuFdMADTIpOjvxslUPJisfZvhe1k0tiN?=
 =?us-ascii?Q?aGTgnpJSsVIKUeXZFVg1xlEfTJMG6dKFsOJfFY1K+79CXHRDNcvJgELLt7z/?=
 =?us-ascii?Q?ew6PJhwKJREAWgl2oG+RpP1TVMx9LjyeCvSr/+cF6FapBcCHrvJGw7J74X7S?=
 =?us-ascii?Q?uPO2YublWBUn+5iNR1boJTmzxXJQ9OeD1nJgRfAsTnc2ehVUX5rDpy9JzxZr?=
 =?us-ascii?Q?tmb3w7b5sy1VRrWZRvc1y6H38dcqa5ZrC1/yZ6Fe5Ro4GvTRaTik+IzTPKFN?=
 =?us-ascii?Q?F8NbJpfCx+kcQ8r3W7copnweRnDWnxVBIxgD8oh3PCPYgTKLDSRdSI68aYpd?=
 =?us-ascii?Q?a8X2ZP+3H3eDOxLuJk2TRimt+g3gI2hd744KzNuwGReMQNLkQZal8Phu7KJx?=
 =?us-ascii?Q?fxnZmv+2lIMBxtGlrzb9rydMfxfKsDjGNWpg3Y8PxUG9oxo4alv0DmLUR3Tm?=
 =?us-ascii?Q?PjiO7QKFyu7xUY778xmH1dBEd36py86Zr3IA1n10qx7HjEY/PZsnEWKjV61x?=
 =?us-ascii?Q?JvZWrv3wkF9rqGu7QIXsl4qKXCMEjO/YXxQ8UzVt9vga92/GMismoyKR4gFd?=
 =?us-ascii?Q?ZR4LKlBwknL7CsGeDXRwNH0snQKwxxDH91Y//ZlDUVLHo3pFlngKhaTIJw3V?=
 =?us-ascii?Q?U/ap3cOcd4jKFvvOxvrxIMbBO8WTEtF6iEd1Lcbp2AzwAyHXBFMrX8R0o32H?=
 =?us-ascii?Q?wSAo6rj5YsjN1/eCabCP8t07wBbHWLJJ1bDk0Z3Vt+oumP3YwXAHfBYz7Tyt?=
 =?us-ascii?Q?vo10sQzdi/HA9BJpfivIKg5+8x7JhtLGU/LQRQiDDHaWpRFvKA1HqL0a7B0D?=
 =?us-ascii?Q?BoT9YUis2Rx5ZiM8KOCCdrSnEJ2WyE5TNvmWIpaeL9jN+iJx++XqoGPw9ZGD?=
 =?us-ascii?Q?kOHcxxc81v1XCGisAWtVmNNDWYPTS3m5P7UA+gYgTbgPYguXCu/WqokP+ZkC?=
 =?us-ascii?Q?XVgk6weFA4iQClMxjHrchV7uPUQZy67kWMgxckvoswOL83CTBHn3wI2FTlRZ?=
 =?us-ascii?Q?zIGY40wvg2mAoHbU9dWzMbSeHFvq0vsFICmKTNyBkRc4hBPhkf6IUuKYUsRF?=
 =?us-ascii?Q?WDMbh3CWcA8oZGjy9MMaRAM0ZkAnGzzocCMtAnrLCHTaWnltkBYnP+jY6n9J?=
 =?us-ascii?Q?LRxB4QaMDJRdKaTyby6/IYFUtRf2B35G6IMwo5qDjBzq0YEOignDPuA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: nlddT2F5MmlMHvSvHLdrUKIcg9XMP3xTjOdPTTxOXV5f7somwb7sE4VMRC3Cf/OKsgdEp8I0ElItcdySTr7iV4P+ny8yeXhxWidyjp3B9m98t+8R8olIT+Uk8P2cR+0lUa+eohvLl2z9YUu+krlYUiSU4TcUR1AAAZLYl1/QBA5MwkHIQN+c59CEqvQgPdm9SCP6GqgKSwY7mwxk943rt8yBnOwepZOxgLp78x4UXKGUl5NCN8me/LkDFN9iZ7etKaPtCal6P8iE24DaRn1+wRBZLSt26jzjstuuhDYDJjNTAQDQ4j5POhNpeBYdderknkujeUjl/CHapuKcXI+PWru0fOyiFlQ6JBfgGtjtvhY=
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3915;6:6NYeqpkSx+VW9YH8JoEw+XZlCkkTAaJP9xFTpIinL1mRXD3yTELoKXBpmM8CeIniP3RvQRxxSt4mM8La53yjb5KwzxZ4Abty2ea3ZRqr1g8J2KtIgBHSDQ44aa1Qwg953d9hK1MCwPtE2TfaPm/hLG4Kjb+VJpiczStYhUMSSOUgXoAUNic7ocbyDUEJHkQVuDyku6YjaRepIXuK45VM5WDAK0Hv9ZLMZno+m6Did0cShQIcPw3KIUzHjV/w/eYsEUvd7UXlArVYuOhlDhSOVdeIu9HjFnsVqRGqeeRrEONPMFeWQBaOeUQnd1Rhq3p1qMzrlahpVjrIe+alv1ymrI8DwkwmVHRMDBFWh4FAC9MuMs08VNgKeUR2N9VlH6jG7p1lLU4BBt7T00cVt5Re3P1qNPSI6JkWUWIrtSXcayuwPNzOMcduUsotAhexOo977+oGw76zUfqjTu4Mk4ZFyg==;5:T0zTLdI+diSADygMzD3NJW4WiQtOqHgiK7/fAMG5ltzndLigloLXE+7fBFeFlpZ67RbqEDPmiDAG+db4rKZr0r4Ua0IFgGtkYsNtsMWHNoj0rvWxYnCaZn6WqpNpdO7WCN8T0dMIUyvkqptGr/HuoVXdU3+Ox+PMvTu0YT0ctso=;7:Z9OZmU+01Dp5pVD06gV0zv25+uAkjmK0YGY6jTS8kXgjBuj5W6xCK9zW1RFLWN3YXPu7ba5pELqy53BAxCnGmW8hbQj6AsvEfI21Tvps+bjHRT5gx67CALhgyuKK6+DHbiyggMh0KSItlqYjM6i9/mhMilf4KF/uV6ntrMeW1R2vFOwzZzsO945bfMvQLcM6IcUnN+9+3gh+b3O/D6iijqsmyU3r17UHnKEN/Z7cGKbB7uczttYISYJe+aagytcg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2018 06:35:23.2877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ccf22e-dc3c-47bc-60a5-08d608c29ce2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6ULL is a lite version of i.MX6UL, its full name
is i.MX6 UltraLiteLite, NOT UlltraLite.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6ull-14x14-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ull-14x14-evk.dts b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
index 30ef603..0ba6454 100644
--- a/arch/arm/boot/dts/imx6ull-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
@@ -45,7 +45,7 @@
 #include "imx6ul-14x14-evk.dtsi"
 
 / {
-	model = "Freescale i.MX6 UlltraLite 14x14 EVK Board";
+	model = "Freescale i.MX6 UltraLiteLite 14x14 EVK Board";
 	compatible = "fsl,imx6ull-14x14-evk", "fsl,imx6ull";
 };
 
-- 
2.7.4

