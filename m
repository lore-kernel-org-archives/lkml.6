Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43ECC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DB42146E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="F7+v/PtP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DB42146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeHQPfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:35:01 -0400
Received: from mail-bn3nam01on0074.outbound.protection.outlook.com ([104.47.33.74]:10528
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726544AbeHQPfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UnLGoHu/mbcqL2hjfpOfEJmgYbzBksAcJMOBTOCwNc=;
 b=F7+v/PtPDT8i2rANSJxM3We7h5KEy4MwE7Qk+v6WQP+EK+gNc5c2WudWj99+qnXkonSW4hW8Kd7IaauX1WS39T8qigkBXO1PQ5N8TPUEVNwuS1v5eYM5V6nYmbDzFvpOVWE8cL7Bjt2qCZkgsNml2fBaUyXr+3xq94Yioa1P+s0=
Received: from CY1PR07CA0032.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::42) by SN1PR07MB2304.namprd07.prod.outlook.com
 (2a01:111:e400:7a45::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.25; Fri, 17 Aug
 2018 12:31:38 +0000
Received: from BY2NAM05FT025.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::205) by CY1PR07CA0032.outlook.office365.com
 (2a01:111:e400:c60a::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.20 via Frontend
 Transport; Fri, 17 Aug 2018 12:31:38 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=fail action=none header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT025.mail.protection.outlook.com (10.152.100.162) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1080.6 via
 Frontend Transport; Fri, 17 Aug 2018 12:31:37 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w7HCVZDr002417
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 17 Aug 2018 05:31:37 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 17 Aug 2018 14:31:47 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Fri, 17 Aug 2018 14:31:47 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w7HCVXVX013145;
        Fri, 17 Aug 2018 13:31:33 +0100
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w7HCVXDn013144;
        Fri, 17 Aug 2018 13:31:33 +0100
From:   Alan Douglas <adouglas@cadence.com>
To:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>
CC:     <stelford@cadence.com>, Alan Douglas <adouglas@cadence.com>
Subject: [RFC PATCH 1/2] dt-bindings: phy: Document cadence Sierra PHY bindings
Date:   Fri, 17 Aug 2018 13:31:20 +0100
Message-ID: <1534509080-12821-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(396003)(2980300002)(36092001)(189003)(199004)(305945005)(7636002)(87636003)(246002)(26826003)(478600001)(356003)(126002)(486006)(48376002)(426003)(476003)(50466002)(86362001)(2906002)(217873002)(2616005)(8676002)(6666003)(4326008)(336012)(186003)(105596002)(106466001)(26005)(107886003)(8936002)(36756003)(47776003)(50226002)(42186006)(316002)(16586007)(110136005)(54906003)(51416003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2304;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT025;1:vVUg8irZbr+Zz1tzNcaBtgSyrxp9o4KHYEbXJA7hlkvpsYMdch3SmX99lYGRcoN23o27+TLa8Enul8FWrz3iYCqP6KspN0BJPpC1HtKqYWwjRa54MaYUpL9rxyPg3Eqj
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b67d2c6-b4cb-4765-3b2d-08d6043d608f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN1PR07MB2304;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2304;3:CuLAS8n0EDAB4Eqsar3Oy6fQap82T+1s31ZkU9CHnpBvzMZved5s9MkKRG15egUyqRXhB+ZBUlcQhxOY9YFC4KA3OEbr7jFBzrWgUrKjvkcpvvmbjBAiLAe6jfdX6lZV88j1sGxQK5EvjCcx2yZutntDfk9on5RzCxcdvVKsU3Qv13AWmSKv6Qv6/fTznVQTXCRlH966S3BhgDVMR9qmF2BNVx77tKYJlFOkf697VKylTTcdQmM4H+TvzNa/xUs17TYbBMw6K5IrnwRCOV6dmhz2eCHFkVBjlgZhyR9hK74lJ5KANkYZj7JidJKaQuoakkmRdk5kzo3GZuwlMdxWheUH5InIrGYqrp1lSpM6ETI=;25:AwDVfsk79T0EEetcU55frJvpHHonUeRTqQ6QRpZ88Xf1Dq0Y/F4jR4628d0E6LoYKMHcpoavXy+zr/vXVJ0/YfFosl5uTgCl11ZLgXAVd10kTjEUl1DkMz/ys9t2NIsuGWdwrVAm1ybfhhRs6OY+6bQMNrhWdTGKY8wkOwr/VBQMvJkKtIdfKPzLrpywJhjIEshIZSGyY++m1yGjvF/PEOEaRzr4Hlmv07RxLWBLqn0jfCzfvJRe6qnJoo+MJY19o4PlCCEIGypCMopumgKc2pM0q7eek4uHkNDvnMXXvn1WxASoJmgxaCYpXgQqHFm9mx13BkY3wYwedvOs7CdhRw==
X-MS-TrafficTypeDiagnostic: SN1PR07MB2304:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2304;31:ovHKjmkukghRtHuvXK0s/5iCcJAPumKwxggzY/6Jk1+fYX+/BQvG0e2TGnx2GiA0x9F+zl4apCCYXcxILSHpYapT7KSRym7cz9HRWRDKaH4uv43Fcl4ADOVPlbIDLWDsE1i+x7MCihqXNsjGz7BCdBwAREZCUc4YXIWqqqZd7gQPkCBQXeuC4rpWnFDxXYDQJlT9KM4zEWtJIgNhtn//FZBf4UyUfdk4kyI3Kt3H8qY=;20:dHi2wWnPv1Q8J1jc0+idOtFY4xAVKqoLeB0NMjK6nArPY8nmKfj3dNfidm3o48NQR0vHc89UDZmNecHkx96rellDewwrHtkwrk+sdj6pNMJGzNJdq+6amTAHs6Ek0zM+agEeo0PNtwsarLgswB0O/gHgAFvElca4kKe4rTg0biGLj5B83PefD/0o+NYNOdk1y5r2eDQ1u3H6axMfK2WNtkJJ12CtoVoGgZ+GZmmQqSIKaY3VIMacn3SZ0TvXnTYzU/uMrekV6DchgYyZUl7VFy1ZQHkNTxdC2gQSHZIgnMmoWca+xKgDIj6iA7xrloKBNEtQwwWD4RfznmwNkUOV6ILmSIJf8uElP534oUldWYxC4ATUPjlVxaUv9MF6Z50yKB6fcEsK8KCUMJ7A1N3+VAADqXL9aAmuO2TABeNQSIukhMi7sK0Psp7gLQXVf+Frgz1ZKD4a+X6xJDa04kFJmyi9c+pFe6lshoK7myJUgGGmLMOitzZV/2Yyi9tFNFEM
X-Microsoft-Antispam-PRVS: <SN1PR07MB2304080C308D11763EAF57A3D83D0@SN1PR07MB2304.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93003095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:SN1PR07MB2304;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2304;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2304;4:P6OLQJHF5DMUt5+HqTtIY5+DRlVzj2WH7SBKqEmqZhDXRtxdEMEEedGoUC2g6mCjmDzseK2MW5FcvI9SWXABpBhmvHE2ySOwD8BQM1d3+F06mXqwcXBZqksTnP2hoK7bv385ouG+Q0gVhJmSn34sSVTPnYI1EHREq4AXBk3NrREkZDaGNSdMjgCg2d6aq7GatAmJYXRTXPc6dWaty5n8K2pSXpASTZWqx4XH4sJPeseZHkd26Vjl3WrZieK6QoVujgoXiCY+ZyP4VpK6ZAbDayk+BB/mY99595OcT0LWogoqJEx6EYYSWVH//HDnG0Jr
X-Forefront-PRVS: 076777155F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB2304;23:a4lpN2afcmcafu3EhBoy48U6kYboEO95UYYaYf4Cm?=
 =?us-ascii?Q?GXKVAtx3/fmjOnfMosYXhGDXY2yT6JrFFZF3iChQ9LS52qx64dOWOn/L3/Cb?=
 =?us-ascii?Q?ddyRDSHkJKuP+ahMUZEcZTX7w7X+wPuHOeVo8kAbSXCtZ7gipYxJP+zMexXO?=
 =?us-ascii?Q?AWi2YKBn02VdfBtFAiUzuZprvm39tNiphujc/ThQnyYL54NtEFLvZHAsQdvH?=
 =?us-ascii?Q?wj1cvZIHm6Z8ZaOWe3NnqbqZGcrDde81sQWnSX0T58XTm8qJf5thp0RtCg0L?=
 =?us-ascii?Q?J46NhNmGHPy5ef4kGu0syXT7J+BMDgSzR4T6Wsb7hYr66t9OoBNlGQLADvwy?=
 =?us-ascii?Q?bUQGHz4hy1FZwVGY3D5YBZuQh/KO6VdTERxKh0U5/6TMvRL1T0PqB7TRyOVh?=
 =?us-ascii?Q?p2wM4dVzf6WQrNM1HSgRzN0Z0HQyv4V2YP/ULMETRXPLlU5eFtTv3QAG/gnx?=
 =?us-ascii?Q?4KjsqF6So8mhk8CZzVImDCvY735N2PhoL7H3Gbr4zBdXecFAGpr+gKe5m/V4?=
 =?us-ascii?Q?6qL73S6tdNtZuJMTPEAfYSovhslD93YvpkqK8FrHKDdz498Zun95RH9zjkUt?=
 =?us-ascii?Q?p5jiH+y4pDefkxqtyOLzqOnK7XGe7K2mUmDGHEBx+13Jumekqx+zmd7TBmmm?=
 =?us-ascii?Q?hCfTPzNd45Y9vYWkbNujDVwlDQwRtp39PQDIZ3MheOupjxuoo+PnG9ikTAC3?=
 =?us-ascii?Q?PMMwiropR3udy+kMcPmkus/mpHeye1iaz/RoDZk1K/oFwfaI3NpNlej/tuZK?=
 =?us-ascii?Q?yv8/4Q+OodQfyYsSJrdKBPSNv4jN+TLxMIfbeNcYKaQcDUS4QSDmIA6w46k/?=
 =?us-ascii?Q?7R71kxA3lP9ZrAP+IZR9kAs56GRAtIljQ36RX2U4Qrl12D28mZu6Nenfj/FW?=
 =?us-ascii?Q?U5VDR/J5KZYTmbobnJgeo3RJhx7NYznDTUtpwgAiXqUW35FObpn9f+wQMyNr?=
 =?us-ascii?Q?fBkffNAdm9D0/lwO2Fv2K0GK+jhIIEoaqaTDknBQ9vYjnprx/F5GNTirHBbg?=
 =?us-ascii?Q?wN4OLzGNvOUvBhL90CoD1mBlGQcZjDQ6mZume1cX2Y2vA=3D=3D?=
X-Microsoft-Antispam-Message-Info: wWucY55PQDTf5A8Jdj35ChtvUf6ZuR9P/cDoUz6Zqce0U8rVoId+X761ZtmdIAJpCEeQVeCcRewsHuJCfvWqOFuqjs+1WKu/+uNCIrPeVaOycQ7suUzQsf8TmtMGpNRisFWCCg2mtaH4sZtoni0ejaTyuFnA/jGwp6UiAgGZeyYSfD3Ke2B1HUFWXpSARbmQUjyFozP6dv2H3iZRSgmJ115f9EingJWAgVe72fcSrsGV6qRt0TO/YW5MQwJk875i80dekFTuIeIhN53vV1+fTOiRKrftxeL9ID5mNNVC24tlALNj2IS6QkR5rWeUQmZ4tN09KGKppQDu1maluXt7dgdq9WqkXjOth+6VgWWoxX3MrJOPiAZ+8T5tU2z354k3ErGc7Dda3OfDfsSkVqFJjg==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2304;6:qMHv8zbIKlI+lJe3fxcH6N0CIFLwH7CtPwm2QAuywOAT2ieu67bpzLRuFumkpisvY9F3KYW91RXL5a9U4vQUD0Y9Or3+NQzg/5NXus06wf8D3yugAuXiNCnIc1AR4HDfGT2E2AtVZNvx01yWvR7gS37H7neBalLg2VXGvgXQOrlsktbWhdHjMFGiWidCToVIz667/tAPiOPFgt9r0K6Zc+A5Oxcw5z3WsLyPH/uv5RG9CJLnDxSzJ6Td/CxOIAimqWGMH8eOYNyPGjJuenMx9P274PCXGDVreH7/0z1r1gldTlaMU3MCDrNGTWAfIdqe1sFlca84z2+xbcyeFWiIKO/m/E/mXKFDHT1Uhf9PhbSkCAqsRoc6FX3Qgo6I4YU0wbW0ybTgtyd9lfUYWp1wTDCF8Vaxu6ZeDtkq9z1Dw65kWK3KJ9tGims/D+JhTw/iyCTvfVwriKuHBTyG7NW42Q==;5:+TcULg9ZQRyEu9gPjF2Ga90avo3WJINl4zO8uRRK5uxHGeoBm08vaHLTBsoNR5hpLfs4EaOXLH80mvsNLqpG5SFKvcT+dzPzMklsEwqhITMTShMEdOIMcqS37JJSbkismS3Xix/Tk8HiBim2h13+iP43nq56sp6Y/AP73UlXMjI=;7:JiaoN5UoBqt9EfyxLxVIKue1uVAkH5q9/Ez3zooTyUkZUBa9amX4Pin0OblmbhYCqOdPzyJR5t1zLJY3P06UnXse+jOYOKha/U/FBDs65ZbHFdsmc0aOjUS+Kc2k9Jl0Ab4qr6HMJ8EthsMUPKE0baxpYbk9/UhDNsMKSLIJt4DOo6FV/SWiy7yXF3da9b9JzW01IjO32W1IrrbXuEfOadsSGoa0QVYfRqyBKrW6Jol/zO4NQEALTinvE+01N232
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2304;20:v3BkdmALwnbnJdKKo9/r7I6zSnMHSSt/p2bw9YNuu7sH4yZvTk3Io8Is+he1BUD4hTufhanskPKahhnn30KlswHJJgw2/nuZJYWjeaZAbAFJOo5rqxPnEe0uCpYb3Rgj3zrduFI0aT8L0Po28To+wfDSAAPTuAuTQjAGfGZWIaVQxfZZZM5NjjKKT3+WSA+kKlH2I3V3EVUMG4RQUOa8JpgDQnOHZUHsOJqDZyLFfZPuGu4EbKBQowdZ/mUVykYG
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 12:31:37.8550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b67d2c6-b4cb-4765-3b2d-08d6043d608f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2304
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for Sierra PHY.  The PHY supports
a number of different protocols, including PCIe and USB.  The
number of lanes can also be configured.

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 .../devicetree/bindings/phy/cdns-sierra-phy.txt    | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt b/Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt
new file mode 100644
index 0000000..846bdfc
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt
@@ -0,0 +1,29 @@
+Cadence Sierra PHY
+-----------------------
+
+Required properties:
+ - compatible: cdns,sierra-phy
+ - clocks: Must contain an entry in clock-names.
+	See ../clocks/clock-bindings.txt for details.
+ - clock-names: Must be "phy_clk"
+ - resets: Must contain an entry for each in reset-names.
+	See ../reset/reset.txt for details.
+ - reset-names: Must include "sierra_reset" and "sierra_apb"
+	"sierra_reset" must control the reset line to the PHY
+   	"sierra_apb" must control the reset line to the APB PHY interface
+ - #phy-cells: must be 2
+ - reg : register range for the PHY
+ - reg-names: Must be "reg"
+
+
+Example:
+	pcie_phy4: pcie-phy4@fd240000 {
+		compatible = "cdns,sierra-phy";
+		reg = <0x0 0xfd240000 0x0 0x40000>;
+		reg-names = "reg";
+		#phy-cells = <2>;
+		resets = <&dummyrst2 0>, <&dummyrst3 0>;
+		reset-names = "sierra_reset","sierra_apb";
+		clocks = <&phyclock>;
+		clock-names = "phy_clk";
+	};
-- 
1.9.0

