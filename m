Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771F9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DE62089F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="GGn+kXsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25DE62089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeH1NkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:40:20 -0400
Received: from mail-eopbgr70139.outbound.protection.outlook.com ([40.107.7.139]:45339
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727592AbeH1NkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRJK8oNL9EgiaqNSSbpMQ8HEqVPZ0yyWQiuTxLhS9l0=;
 b=GGn+kXsNnN7TCliSYIPLN5D7sXHSgP7BFFgBkTZPu4H4q5lP1iMEo82uV3RGmy80IREV0JMt86E3S0QGJBAZeCulLCSdjyMHaFZybB+omc++sxrgwLXON4IxyMSRVPf4/y5UX/DjP4vd0rGdRXY5Bfkdm+eFNgb7BLzoLy+nvw4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2449.eurprd02.prod.outlook.com (2603:10a6:203:34::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Tue, 28 Aug
 2018 09:49:24 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 3/5] ARM: dts: at91: nattis: state the actual lvds-encoder chip
Date:   Tue, 28 Aug 2018 11:48:42 +0200
Message-Id: <20180828094844.10018-4-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180828094844.10018-1-peda@axentia.se>
References: <20180828094844.10018-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: LO2P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::22) To AM5PR0201MB2449.eurprd02.prod.outlook.com
 (2603:10a6:203:34::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 081b0f53-03ce-4087-ff36-08d60ccb89fc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;3:3DHsXw1gXMi7QaIfmZb5FblfRb6r/q9AeyOjaqArmxf80KxPHsJxEEXTPUkQDBALsv1MCDk4HGXR7kU9gfhWsMGIEG/tuXgGJra3dxa5+LduBgGX9E0rgp0+abPIe1TzROAn2/keBaZPrp2UbuMhb+R70E9f8xMMXcuskUztTZ83GqJJBPri0JQkvHWJOqZb8WP25VLbxpblPJOEKN5zT16Stgl7ULDqfi71M3mqMaL0N2g6SA/+NXTVgO/74xF7;25:7PokdTSOchvmSR6fJfa/erYt/DCCc0LwSpfB64gCo6nKZCPP1QDKlg8NJI8iB1sJD6x1hGQgXvPWkvHsUc0xSaNlsg7vZmsiyPWz4/cBFdqiB0wr0W6YsTb1qNoEMZjQili3iIKJXXVfB/EaJ8XNo2jHRv45N+e/fMIpM14CWDN+YaJoYBlMASSe7n8I0OM+gpZdDwcY8rI5f38PeA4LDNjW0AlbCvFZi2KyvhVK85wLWBClVLAkkz/Vv/4HQnk+xT0SvJXfyDU9b9m6l6+kFSn8JSA2YI70/S5LoRC+UQRzUB4oP4mYIgYc+GCwNSsP3q2/l8ju1D9pEYJN2xlAww==;31:h6OPvyDeQJVhAUZp2qRFWDfLqPfyj3LGRGqRcOEKIdgBCFhbwcatJrpSW0I/Mi92+UYHoXdO9Yqo/JMzriwNw/pD/F9UM0oMx/O4pMToTsvZzFNlRnA45eXbOwi+0maRT4z61L9qPISqmkN8zKGEmujUdo3zoREl79n/CDt7Crb1rhwkKuQWZ49hBBgckcR0bHhdFZpjcvs0caH83SJvjMfyphHNLjSYasuPDlrSovI=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2449:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB244922F158286BD3D9B28283BC0A0@AM5PR0201MB2449.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2449;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;4:uXhq8p+hkYF+gJ450XSDDd/ooFY8KmECAUukPeklHZkBVbICktD9XdltUawUn3nuNP6iEOL/IrvE3X7WRl+GhLfzMmEJObn8hcIn+ymiu10v48GuUBrCKHZGoaQ5QyL4OGm07tOOyYBHaBn8nAJWo1Ec8m0XdhXut4JJ3ox5NbQtDaKuqQ5eUOuYhaKlxg3V6FuuMuXBSoeEDcykMrZZKjPyxGbhCdEqBlzvi9cJtr1VNqw8MCD3uVX74YlJ3WSawlm/XcwSJyOLDO3pmYsPyA==
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39830400003)(199004)(189003)(74482002)(16586007)(54906003)(26005)(4326008)(2351001)(6506007)(478600001)(316002)(386003)(16526019)(186003)(2361001)(36756003)(2616005)(476003)(50226002)(11346002)(956004)(446003)(6116002)(97736004)(8936002)(3846002)(1076002)(52116002)(25786009)(86362001)(14444005)(51416003)(76176011)(6916009)(5660300001)(6666003)(486006)(50466002)(48376002)(81166006)(53936002)(6486002)(6512007)(105586002)(81156014)(66066001)(106356001)(305945005)(8676002)(7736002)(47776003)(68736007)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2449;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2449;23:/7cYb4hWIwqm8pXuQFlEeggGdZzbzeDHTp2fwS6?=
 =?us-ascii?Q?XcENgNoaWaue9ztZKCg9GM32Yl0OkmWBLjWqd7M1OF1XPh3WOgzFRxKLklHG?=
 =?us-ascii?Q?hLGhXvkfG6K4rtUbtBb1pI8LUgkc1GFyJZCXnXdtbicwwEBCUrw5n4u3XVdO?=
 =?us-ascii?Q?pXBaNqXrwsNtSjQrzaIqXLy5kwilGC4C/mQDOj/MlrCAWPZHwozNi5SUIaY5?=
 =?us-ascii?Q?3Uo3CZDYeuYjAAufN03iQsrkcuLF7vyL4ipEkSSNjuTFnfgNxxeqdxjfVHwk?=
 =?us-ascii?Q?0ov0xuix0U72PBtbDU+0lj8LkcamR0pY5YmnbOcRYIcIJ9ERM7ZciiHT/gzI?=
 =?us-ascii?Q?Ghk4em1fvmfCcXhGfh2xfV1jHp5KLevYNGSuPflZ+CkD3L5ZYx9l9yiGCafy?=
 =?us-ascii?Q?1OtvTVcCN0I07loPshjo0oBaxUqTxJptk/p5GeveaU9cyWk3Dzz/OFMAxZLW?=
 =?us-ascii?Q?2F90AjPHokJWumtapc+zTfvZEqcWOdINWWSXDWCJmPrWcz4Oep8evzwBTHw0?=
 =?us-ascii?Q?FJfvHYpsrcNIZOkLiXsYkQ5lv33kbKRY0IqvKcYfuheKwkXRDYDhjkyIGs3v?=
 =?us-ascii?Q?coqVxwgPZQHjxY6obdATFMQvwWSeiG1jFLJC8sKzrPkmLwqu7Dwve4cEye3b?=
 =?us-ascii?Q?tptAQ83S2YBEDByic4gZcw/Zaa80Qq/KzpsHT15WFNF5ax4r0BrRcrd2UL48?=
 =?us-ascii?Q?Xu4jG3ZmVwMm2ezQ/8n7QtTMbXNcAGz9fDoi0a0CgMngBcqiYyMqZefnNSGX?=
 =?us-ascii?Q?aWTCoYW1U6KjwWVO6r1hwdIIqENgjWXE9sPJG3Yq5G/whjke3stS5r0u5SD5?=
 =?us-ascii?Q?A/uaz9ED42+ki51W7rDKLDjBpCeFIQ+nczp/p6btRsmOz8gGlEQ0Rt5KEZA2?=
 =?us-ascii?Q?bXexubSEqmWkp5Cao0nRfpcZ5yCcfo3SBizvPVOoGqLGA1FMnCM4GdFVnusG?=
 =?us-ascii?Q?BmOFVlDrxTN5wcnrfsq2uXCoHdB0OYmHKuhyPr25tTFTPYXkLcNJKlAh6Iaa?=
 =?us-ascii?Q?etvdN/jn7agoJL207PXcyagHVHYzcD9wvqJQob6wshBZg46cp6oAY283Uwu4?=
 =?us-ascii?Q?tib7VeMKWXZFYO6qBSEPDbuvi+J3KDbk3wGhU5MX9AHtMsBzPEX1WmUq+PyU?=
 =?us-ascii?Q?oascgKPcpScn++SNqu2qNEKMWsGW9oROJGttD3W/zZWHNEsIeLEPe5iFwJ3/?=
 =?us-ascii?Q?HxPMBOAvpFjeV68NpU0Eu1fNH5MqHNUcDjvLjBD3OVIur34r5J2YD+WemTq9?=
 =?us-ascii?Q?uMWLvXtTOmV1RjKMlWwiLiwQ8TvstnFWpZEX1AqN/td4gTBDUBjpyeJPorfH?=
 =?us-ascii?Q?08jZ1BkK3cG2ndftmMQtk1cE=3D?=
X-Microsoft-Antispam-Message-Info: Ryrv8Y/bnjckbG8nGJ0CemqUsfABGg7NtY2RdS8yBpOzr0eX5dOR3O497+UJNeYf12Y/OVnn77TipiDJrfPTfSYEM0HW8vKAB9YABtJ20V4MGCC6jOtmkRGm41vXJm2RkEOMrp8Pkczk4IRTgt89V77gZU2Scex+uj4U49QAqRv5IVo3MtW4RmXxOqonECrmml6Dty1bpLU0LVzjvQiIX1MkWhwpT31Xr6nKRu1rgwV2KXNvxHJuYzPXaj5A6IgWwFA0Kc7w9Ky3MeZVluJ3QCCOi8DSe45oV3Sw0Ct9qLLXOv07a02EvdWqnlv3IpTvIy1TAnBeeG4fBv3eZyDPbiEZVH2MeYHsyBW4O8AiADg=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;6:XW4ByahxrZjmNmD6MUyQ9IOkoZdZ08fma8QzxtOMA+TqIn1yZ3p2U0snN9cJfVPu3Sr6NG5Xxc12XN6WE8D+C/jR+uo5JgF7xabqogjzY2+Gv1y8HZRz98776yGdIr8muF2jM6suRnsOGOe3kxBoOABixecR6C8gbMz/fECHgku6NJOLA7vZmJ8+eKlVepx4LnykXDTuSOouSNQF3Etn5x2ETxzxfw/rsdZ1QY/fMRm0YegC/nw8guKmqQeCooBnCrwbuHo7VJJSfrGG+lTb2+inKXKOl2raji6bMJC548bA5X9VB65e+Xx/ny9QKxWPXU1Z1bKwYiMpeXx5Vc0gy0IaSQWf4K+9/KzUDaoeGqmao6R/5dVGFfvOCt+ruUMAdAOYzDZiCrZiNiY0nRDRZm4VLB03XK5oA/H/yckq3uObQwXUnxvIOPic92ZcGmM/Mdhkqfv5vZNhP+H8ocIbQw==;5:yaRkLMLWGfAHdZlfOxJB7KEag4R9q2jsV6HRPduMo64xanaQjIi2yY18C9ZLBO6DGkssD9nB95DVzmwPRRoFkdVWme3RVciN/V4fyyZ2cP3Vr5EqHETUnx+0tfPy7ccDd7TZXb6j8KyrLIUBeLzgCDxPr7f/tm/8jH25PAVecR4=;7:6fyY/ffL3KWz2LB2MNut8kKv8WnSusL9xbFtYAPY4lJGoEwfMUpRrbVqROlUu+tS5LCxViZGjGjrXjuCchW0dxliyWbTd51IfYmuX1pTZZ7KZMdHnzZUBQDt9KWHl7b0VQ1z/OEBLnuMJfyS+9mmPq67Hi4/5TiIbBe49ZDemCe/y/0i/rd1j47Q2N3/V00vKtHzcavUPKmtH0HLdgxMe8K7iz/29QBNcCwQuUg2T+omeaNxre+Jje2YaGbken7g
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 09:49:24.6762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 081b0f53-03ce-4087-ff36-08d60ccb89fc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just to be explicit.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
index 4308a07b792e..fbc796125c56 100644
--- a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
+++ b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
@@ -117,7 +117,7 @@
 	};
 
 	lvds-encoder {
-		compatible = "lvds-encoder";
+		compatible = "ti,ds90c185", "lvds-encoder";
 
 		ports {
 			#address-cells = <1>;
-- 
2.11.0

