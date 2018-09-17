Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106DEECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07CB208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="SjYImgcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07CB208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbeIQI5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:57:24 -0400
Received: from mail-sn1nam02on0053.outbound.protection.outlook.com ([104.47.36.53]:34880
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729315AbeIQI5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=416xl4x5h4ef72JPztdsXRUle72nv/LFTTKyQldAx6g=;
 b=SjYImgcQBdMInjzvtJrFyDJc+cLkerskDVXHZKIqidHVwI9MXbNQYUXX+UYw3TWPiIDfJ+/TKeTyltjyY8trkgLpEYOVKithrJf5aTRU5MDF2PHbs/AbyC/o3jFAkHyqagWOaWfsgvIigAqGpvidXfOzD53orjPRumQWSeHbQVQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 SN1PR0301MB1583.namprd03.prod.outlook.com (2a01:111:e400:5232::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Mon, 17 Sep
 2018 03:31:55 +0000
Date:   Mon, 17 Sep 2018 11:28:30 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: i2c: designware: add optional pinctrl
 for bus recovery
Message-ID: <20180917112830.2a3c9be9@xhacker.debian>
In-Reply-To: <20180917112633.252c591c@xhacker.debian>
References: <20180917112633.252c591c@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: KAXPR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:402:19::22) To SN1PR0301MB1583.namprd03.prod.outlook.com
 (2a01:111:e400:5232::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4c51553-ca0b-4c1c-4dfc-08d61c4e1f54
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR0301MB1583;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;3:8c7+qFSvpo5XoYeuy3yHihQllmQpl//uIMrig/qC33Yi1UFzwHF2f5/VURa3VxJ23Tejb1HrocvmBwKk4ihWyJlvD1QxkuMHITUlMLSM35UU36h7VqDUewpuaaESl7wvla42k2osUSYuKwFBsYTjnyX8Z0i2SeYw2NeacLqPff5NApNKoCjm1r7xM70ihcEqAtogeAwPYYSCEoANJOR8fdNkOE4qq8lAQLqbW1Xx7CETKhrLMYEMQEMf0Akxo76g;25:l5HTkhdWbLXKk+liGJ2uG7PPrJ778WSmw8eEm7LPOnwHbiwneBBXT3iyX0OYuKImdopQ0DVNh2tn4Yq2O28PKAJL7+LLSZ7AW319h68lizVj/sveNdEawa/6FN7dO+Ppo/c1jqc8AdsufMpWy+4v1Zhsgrq/I7vLapHBjWOdPhhb5Yf0ujjVWaXnbrdAld3gFCNxs+h9qUNLKWCsjHMWuJLmSZz/lDY4b9PDIBmspZ/21h52K4rVgvoQlLXHBjodYpyl7RLJg1GVvyREISaNGWAsTh1QKBpx2ipVz5EjBWwBbECMOBmVpljEeHfkMAJ8snh04smShZBycZ6RPxiIig==;31:eD9Xse/xhgFUDpDaJ47mYf+o5Btz2aTtAUxNsu3tttaRLROgRBM13MVKwWoe1m+PuSpPZKfMEqu7kVl2pPbrvY18vXxZeTTdnw3rlgIORFrSJHqp0DE+gUfhk4daljSnQ/cuyIY/dkV6imEIXabDdZVlxKpjqgHuElsOwTh1WbWoSW74t0ZrugjRZanrvBLaJggl9N62IIAbVOYX1uMqO0ro7YPOqmNLQ2BhmTpmnxs=
X-MS-TrafficTypeDiagnostic: SN1PR0301MB1583:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;20:uY60D6AYaWNH3MJPNYNRaDTZK7hJCgOP++FjIuoSLjBYb6gizzknZXQvpB6BvR96T8iviOearKyARUxf8CmjwKy0RJRgdgCmd8fWJ6gEgIuANrLHyEL4jMTrFL8vhCdLqazzDOWtYPtCYgMgsOyiW4aT4sPoLGedGYyu+slSu8aiaZJKL/KmhfymqYNI0JerB+GvkTea/LauPtjViyA6coWpIVfbwYsmXq3vXX6dOeJFiPCzZ8B3Jfrs//w4dc6VHVTDASZtRVs8SM7Zf3JMbznPnKjGZ6SXS2o4DKU1P1YqS368v2eh7+CNcwshqzj3ljoA+c2UsUzu3EWox9JXBLGq8S88LJ2+EN6ProoKLoX6YFkl84q8DB1Xg7U4TCuDiy2Fyekg+iJ2XqWpVeni2KDSwg4H97aHeB0odFNv8a0Tj400IUzXb2vWwmZT5TcEm7YBG/p/FOHoFx1J8flNx6Uz5y+7rcR0m7T0YZIMiG2OLKv6rozuosPZo8AV2irK;4:gzx+F56dfU4JXs40yUzpJdSWJPVKbesLEUkUowHaYQelPPuxpNtsibrW8YSriKljs9XamosTyWqRMkh+BPgkEB6oSC/iZoFev3E9ZEnqFKinx8PjEa0JZaz80JT9rjCPfMhgAdzAb3ZGEJ3ig+qpzW1YJxVHv58gtgU21CEIRfdJ+IudDW9UF8JlK1t8+3h2Ntcrd2wjWlnzJWDiB/2gX8gV+1V+k37mhTH73xCu9EeirPnW+wCgRbPiZSPT+mHR0H0WO0/1X1dff9llK2OLiw==
X-Microsoft-Antispam-PRVS: <SN1PR0301MB15830F9A702D3A568A0C8253ED1E0@SN1PR0301MB1583.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:SN1PR0301MB1583;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0301MB1583;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39850400004)(376002)(346002)(136003)(199004)(189003)(3846002)(53936002)(6116002)(446003)(11346002)(478600001)(8676002)(68736007)(50226002)(81156014)(23726003)(8936002)(33896004)(2906002)(50466002)(97736004)(72206003)(81166006)(26005)(16526019)(4326008)(25786009)(52116002)(7696005)(76176011)(186003)(6666003)(86362001)(7736002)(47776003)(386003)(6506007)(5660300001)(956004)(66066001)(106356001)(9686003)(55016002)(230700001)(305945005)(476003)(110136005)(54906003)(105586002)(1076002)(486006)(316002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0301MB1583;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0301MB1583;23:F2sPmgc4fCAh0izA3cKrXg4ZmupcdPkdSo2zbaA?=
 =?us-ascii?Q?eMHpmVAhqey+wVjDK6L5ncfmVIztJ2C5aHnoYnM2hZvgMBd5Qy9dFfOX5Fv/?=
 =?us-ascii?Q?gHpwy+powZbvKNQpDUlI2FZZnahWBtV7xnLW5xwOvjsOCqiLjTyo55EybQbq?=
 =?us-ascii?Q?yistCoD5DTOgWKqVJwd7B2cMlLvT/ZtsfOYQQhhKoIBZjzy8HTG7FmKyG5AU?=
 =?us-ascii?Q?8pkVIPe0WyzBEJ+D3yRgzIVy8Tv/Zoj9+IIlQi9XJJyu8hjnckgWb5D9pW9W?=
 =?us-ascii?Q?1X06SaJagBGh8L6PZvEJQxh+QD7/NZOAiSbXW32lfPvGeM4TQYB5irUJvzHn?=
 =?us-ascii?Q?V5QrkYCzhelc0rynM/4PB/4WBB4lwE9s1tDEYIoRGfKFXssfKPTgVIXb7Xhm?=
 =?us-ascii?Q?K7+s72YT884CuFXpnMspUFqhY3qHdHMupbo6HUbDNIq5Q5yfC12t19rgkCqi?=
 =?us-ascii?Q?E7AK4yPp0wPzPld6nMK1OQLaT6IIWbQcavxlGMd0UvK+lmCLbfViHCL98WO7?=
 =?us-ascii?Q?9WQpnCCoTBFiAt+r+KYt+3+qtE1TVFKghtoHjZVapmTMoUntYU30Yf38gFJT?=
 =?us-ascii?Q?SGtIrDY7XhDbMmxfcLty/vDdErKW2hMMlPa4E2GUlfNi8BI5MJzoxj0Y+B0q?=
 =?us-ascii?Q?y73Am0LWjdi0gFKCcoLSmHdxFp4VCOfs7iU9rWGVh/QgVn2Faw7mzigvnqTB?=
 =?us-ascii?Q?1yP5XBdyTBxaxmP9AUlVGjlvrPiWKeYnIgO78lcI5G4cP/vRWR3y7GoftNJe?=
 =?us-ascii?Q?94XLNOu9J+ePAqzE+as6ga1QiJFcRt6zj6huLXvNqGZvFBZ7Ct3i3cgAvX7N?=
 =?us-ascii?Q?yDGpyCsMqhtnOJIjaN6EQyzGNJ6xY3j2YilpMYl8eO9uRqlJgaY96cz+ZxeR?=
 =?us-ascii?Q?6LtsbaCy8RFUIQbOL/KTSQxqJu4WmkHYbh2Wxktp2KFqPjAjOfA0il8XISAR?=
 =?us-ascii?Q?nAkUjPb3yNnOrRWftTlkKlBlJQNc85K59UUZZHrV0dwAlZukYU+NacdpNjJ1?=
 =?us-ascii?Q?yThuhMmoRT2NMKSWpMeLXM2bAMKW+d17LInE+MOovgZJua809tLbhclnDM+O?=
 =?us-ascii?Q?Ro/FFmRzRLzyXyw7hwLTka6Ynwt2x2AoO8zogBaE1kzdcQ1hYJjBGzBjWpOK?=
 =?us-ascii?Q?yoPPEdC/QSG/8PEZfkfJwkA+KXE0VzzREZfRX2lWuszm929K0aFAGycSUXiq?=
 =?us-ascii?Q?ONeDwyWfQxIeQ5RrOvw47r6/MviZO3KDDFne/+TWMI9BwqCbi42n6zMvpREX?=
 =?us-ascii?Q?dvs0TfLlk+81NfmHz72A=3D?=
X-Microsoft-Antispam-Message-Info: sD5XXpz5nyLprxFf8fPa/cfmQE3f+PTjWFL2hLznRgKpOg5LdyCEAmcM5/XQJLzmG3VwApUmLeBXqePNg62ncqfy+K7UUt9Qk9dMCJFmw/qxUpjzff8RreGSc58s+aWtmJL5W60Pi5HmzHRitr7/xdDr4ZK93iyVSZxr5rlqvAo/aKERyvcYi+L7puBE/bAD3HOK7wofIbswhDFEhL4Vr/2ARa3BJ/ZauEMjS/mmvklhrEkH/63AyaG/6auBvaVPVUy4cG5L03ash5OB0OjqtUnKbZKdnhgCSVzce3TnixbpGxNEOgFYK42Td4rxNAOfMuGsBeL1U1ft18RiQdya6JcEmS8VwA+kQzmYDiOowyE=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;6:D5motpG+GTQCwJLlAAVPaZOz/SL9tnUvNjVAOgJsAdnfhEdyT+WVOXuHfcTX2CGBPQnSttug83qZNvqqZFYJivta4ubDMw6Qvcl/CqZY3KO6B5P2UtnVJJr1j9Q93U7wTiEMMb3R81fmiebSIONXxrJY8CWKW3+dLB8PqX1+ZMY0OiqaG1ZLoPoob2llrCxB6kknx0FXXuetogcy3E6fQorlkFSKjPihHLQ/R6eTnDEv1ebGinyyFCMna5KqdeLtW/hAis4imtZmpjw9R/ZqXeJrENqcGM20ItLgP2EKw8WYrd5BuyeADMO9tBkvIfWSEniwa2MphE/J1YeauGfQn4WU2VXtqcQSUf8BjW7/iR8cnMLVefCAmipUsM2gZR7UCImWAmMdp7NWIoOH/OHpSbA9cgGZPLqLvEx2STVrZvDy425VI+4taKYYSHjIGoWVODEjASodNiYrAO/KyhHBTA==;5:IS0UhFJhI+RMEmLWfCorCrXnfwakrzf5G3GjfTcXf87DcoIk2xc/A8SmcZ0BrW71IiunpF/Zhv97yacjMp5imBuOlJDV6R+MxXU1d03OfkmX6f4x6wF3DNEPwz6K9IxuJOrZCk0jdpk1mTVBuHoXzQl5rImxSCMhNh5ThkPP148=;7:JcuT8MubqAC74gdna0yJnBLTI64mzWRLrohz+bmCPWlm4BXWZo3OtGfchfK0YpfswEjOZVc8zmlKSC7BNTcnzlt3omeIwrdWuQZWfiaEGKdggaGm4rmqSHE6Hg4WDdSLBWDoN4HtpPX3/L2UiN6I9sZtvA6fTmhp2i0wuMsvcmK0DVCI1Om29LCIaJOG2WoDfARjUwq8jl4dzLUsb9y4p37llyxcUxXPvNS2DTIW1fIHmC0v7z4EHoKnLlvQf1BW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 03:31:55.9984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c51553-ca0b-4c1c-4dfc-08d61c4e1f54
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0301MB1583
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the pinctrl property for bus recovery.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 Documentation/devicetree/bindings/i2c/i2c-designware.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
index 1d6a6a8061ba..c1544d1f7b55 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
@@ -24,6 +24,9 @@ Optional properties :
 
  - sda-gpios: specify the gpio of the SDA line for gpio recovery
 
+ - pinctrl: add extra pinctrl to configure i2c pins to gpio function for i2c
+   bus recovery, call it "gpio" state
+
 Examples :
 
 	i2c@f0000 {
@@ -46,6 +49,9 @@ Examples :
 		i2c-sda-hold-time-ns = <300>;
 		i2c-sda-falling-time-ns = <300>;
 		i2c-scl-falling-time-ns = <300>;
+		pinctrl-names = "default", "gpio";
+		pinctrl-0 = <&pinctrl_i2c1>;
+		pinctrl-1 = <&pinctrl_i2c1_gpio>;
 		scl-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
 		sda-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
 	};
-- 
2.19.0

