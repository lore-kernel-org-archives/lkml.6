Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbeDQJDZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:03:25 -0400
Received: from mail-eopbgr40050.outbound.protection.outlook.com ([40.107.4.50]:61600
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752067AbeDQJDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:03:18 -0400
From: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
To: andrew@lunn.ch, robh@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        davem@davemloft.net, marcel@holtmann.org, devicetree@vger.kernel.org
Cc: alexandru.marginean@nxp.com, madalin.bucur@nxp.com,
        vicentiu.galanopulo@nxp.com
Subject: [PATCH net-next 1/3] net: phy: Add binding for vendor specific C45 MDIO address space
Date: Tue, 17 Apr 2018 04:02:31 -0500
Message-Id: <20180417090233.21548-2-vicentiu.galanopulo@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180417090233.21548-1-vicentiu.galanopulo@nxp.com>
References: <20180417090233.21548-1-vicentiu.galanopulo@nxp.com>
Reply-to: vicentiu.galanopulo@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: MWHPR12CA0056.namprd12.prod.outlook.com
 (2603:10b6:300:103::18) To AM0PR04MB4116.eurprd04.prod.outlook.com
 (2603:10a6:208:65::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4116;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4116;3:aj5ioLW+YNcBcY6S6K9phgChaBHo66iRGGveM+x8pNadu5AtVQ76K8TnDa0oeQ9CCKbrJk2HPm6IMDeyiILRWeQKkiI/X5gKhLmsR8QqBY8rpJ7iW+WokViPwSTj8cKtJ9l/Q5MVLx04WW+w9QtckzdA70t30YVHzK5AC2b6LomfrLJ0lcvKrLrh4YdS3MzqIMjHuZjE78TUgIxZZlb0QLxp7dheX2xx708OmUKLOxV3ytx0bDsvyrZtF/LBG22/;25:2jutc/7ca9QVb76TeJ7nIsrEBxA0kPZg0Var06xoug2SF6UuINudQxH4Odp9+1ZcpQfZvyK4X6g3zKRdSwQxnoPMv1U/GOZcXa7N3U+n7AnD96ByNSrrdEpNqYG6w0lYcDvrb/9DSzDpecizStgHeGxcFJiTXW1ik+YPgReWXmgyOH11XXdYHX67Ox7djxj1Glf6Iak1C6zexsNUmz4HRf4v8qeNDu0G0ZgDLXQQQi7VUq1t5jEapvbin+8YY48F7W5NgnFBYmGkz+UXSQ70Q8Jrfp/Oy/U6NjRg4+FjoFqc0jk536xClLCVglle3+dWwW6XUUPdHHUWzUOtQn5mRw==;31:f6SI9IZGDVXs0aRKQdxyh6InWD5ka5A08MsB3tgt7HDC4L2j0qMhv4gtT72cmYtJAtPviI933yNKtCl5bUgbpn4liyC2e4WpeYEjCPI6DQG3sxwv6RmBkV4YdQyEzs3TAFEzwa7mF0NmbnhF+syd4TQ9ldg8L9aGv+Etaot0RRR/cXWd55ttM4xudxLnATzZv/kIuQZbxnTaTJy21HWNl1F6oLENXBgx+BturcLFYxM=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4116:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vicentiu.galanopulo@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4116;20:v4lGqkDhF+gKEgMW2rDGxOkZj7wKkozFbpg1LlaIRWO8PaRQz5Fx/gNY1fRKN+jptmShxQxzsfnqQU914Rz5vwboi0B/uaN9A6YdGxuukLWgtiHA3QqR30aAZxXoAB2LDDZ/tv785m9y1Fr0e6JL7QNfGXOzEC0J9b3cMZaH8qQrYBHmH187je/FzOaKqK19Rxpl7AjF1TnGBRwBlS6ksqoQhaKKEb2QUR8/IUP+OuQQsHcYJ5+f2U8gaw12gMv767Qv+t0sF+Nc/bJlRq7tbrswYRwqFOxV0qQTYy6FFe4Te/yDY6Dx4CT1D+yTJY+pbgF2z0OJEA7JeaZy0Q+W6BUA4BAVwd62vX46P/m1Pe4c2/3bPQ5WUS7aUk9Vs9CVOZKmn0d9jrCXG5uyK2HNSK9YQ7EklNzVRz5CjN8kdATv91fRqm16+Xs6e7oDlEdiwuGZErnfpemRI7z/BmV1PAv9Vjd0sohkzcdXOgWYIENJOWCwFJxwfSqbmxOb5P+N;4:8GKfhfY42yq74U2QhM5NiYNyrYINITRzX0LhGk8Ct8XcdfrtpVBVaO8wtWNqLXu+kK50gLbe0ilv020lAMJZGxaq98+97IG7o8xJDo//zyWG/B1JLBov9exrW6ndk9UNaIZv5agPEscHTTeKKGmT2SfctUmecp0okXw7hWRbdeg+91x0xJaXIEVlZYLRO2JhP4TOMo1MQ4WIvyXRtJn7PUInAzu1QN8Ov1Pse4RDNuliZVMtF0a+fnoeR8SPqAMo5VJfVkBKqgZIQfvqVm9aXlsQ6jrxgpkFGGcUao0sNU6qq7yOWSwIzjOV4GsjbIFA
X-Microsoft-Antispam-PRVS: <AM0PR04MB4116D4F86F943768B40835B1EEB70@AM0PR04MB4116.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501359)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM0PR04MB4116;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4116;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(39380400002)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(956004)(6506007)(11346002)(47776003)(105586002)(50226002)(305945005)(16526019)(8676002)(81166006)(81156014)(8936002)(2906002)(48376002)(68736007)(25786009)(50466002)(478600001)(386003)(97736004)(66066001)(6116002)(106356001)(316002)(16586007)(52116002)(3846002)(53936002)(36756003)(51416003)(1076002)(186003)(76176011)(6512007)(4326008)(44832011)(446003)(2616005)(486006)(476003)(7736002)(5660300001)(43066004)(3450700001)(86362001)(6666003)(6486002)(26005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4116;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4116;23:+JPviFq+prkjsUv6psaq7vcbAFUKOrC8s73IZUtnm?=
 =?us-ascii?Q?lyhtaJSV4nN9ZeJ1hQa7Uccy1Irm2XvhSddg2lYbGLPzWsUS473Xxyph+gJQ?=
 =?us-ascii?Q?AWzBkOPpT2N0htYmXdhzgKydkavanlsxPuA8iD04oUKy4UimqDQdKyQeqaf1?=
 =?us-ascii?Q?J15Qi5okK5/Exr9fM7skqJ7l1v6uN/Sik5qMqXj5/RLC/t4hfb3JkJFvn/tO?=
 =?us-ascii?Q?Mq+BtH9kUgtF+Vsu9S1bulTHMuhzawH/VDplZ3gSjMe0DNKg5Oo1WazSW3+p?=
 =?us-ascii?Q?BuZilmEWFYwO+d64ojpbkrybmKDIV17p//ndl9KLvSya8oER3QcrZMECK+o3?=
 =?us-ascii?Q?d/TAiMvP9heEJVux++l+412hfItUyL/1d3NOAfNXqbNO5gC3RlboC7iCcxJQ?=
 =?us-ascii?Q?Vtqx9QLM1zgfS6umj6BYAfyQwoNjUTqRcMDRbo3n42VNwokuXMVbrpUK0T59?=
 =?us-ascii?Q?fFZJHSycpYMWYEdxYCKXu2xbRlrTE6Izz2qsvNV9NYnsh0rpATrDPrqGLTvc?=
 =?us-ascii?Q?kGV9/nc8DkwwZPTmI7qSZOJ3VMZWxuRi2Imc1a6paG28fIvqu8/9kuuDyRX1?=
 =?us-ascii?Q?s+04savItKP2IUr7CnmAJd+qWjJq5SKtrMbAtELG/XnKk2Wyjy0aWF1iPihx?=
 =?us-ascii?Q?uvlV0W4va/QzVQNxEPWDE61GE7TKg2jy8AV5MF6zCTubJIa3QCu2gMbEbJSp?=
 =?us-ascii?Q?QPzl0UFOj81fHb9UVF+QR3wPqgtGoy8+7NFtEcYfXkRYB//H8hHJYyY4CbkS?=
 =?us-ascii?Q?g1Jhcpuc0ukCqKIcZEAo/edinVU6Pyw6pT3SxuFU7Gdo8GcNP/UaGMEaW/+H?=
 =?us-ascii?Q?PRXFbRVwtTX+P4ntzRB+UMqLrCXwOj1a18qjFkx5EXCwkPWmupMbB+eGV8P0?=
 =?us-ascii?Q?IGapBwjfDR1RmcaBdJLp21c518G3+zqMk/kpxwq57Kb8zxSlnuYvDXGxGTq8?=
 =?us-ascii?Q?8rAWeiYI0FfyV1MS5SZs0qoUmRf8wjsCXY+70rnPX94/QCmGIriFoLA6U7Fe?=
 =?us-ascii?Q?xnVqu2Q3xc7kv0DrS8RcqnqXLMRwmUr5lIrV7ZU5G1F3CFV+gNCjq6ziieZZ?=
 =?us-ascii?Q?T459X/CQDKX0/kYp8fd1FMrBDcvAgnWEi3UsYNcVT2o7AFjidBkPP64grzTv?=
 =?us-ascii?Q?0o8v5EpcJP0WjTjmbFpddX17rlwmety/dckWgooleZaa+UvybcBgT3YyArG1?=
 =?us-ascii?Q?tK2dN7xNzJ51rJDRtCIGS3C2qjfTzuUcgTkZc2IuaDrZawpb0RuqW2Sf0Y+r?=
 =?us-ascii?Q?DWk+a7ErLvpu14klJZ1OrPCjRghsLq7GOHPQrafRG3tKuu5lroCvYkb4TxTk?=
 =?us-ascii?Q?ShQnEZjFxPgvyWgU2X9DA32FNJHq5iKAk+3jfGY8JN1?=
X-Microsoft-Antispam-Message-Info: OTBNGvt/KhUa1e3vhGyyHOIaN/C/WFFRIRDHJ255x1pL17SXync4AEK10TXEcrU1gILHU1Ldwqc49LqTd943atvkgo0uWOchl7syJEVsJueL+fRikp19xJqA2fKzpzl3hLFTmAVNI3ywQ/272yLVkjK84eRiHyzmxgM4WMRkaBs40ww7NTRqLPYZN5/pgRYS
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4116;6:QtlPOSKrAVhFKV8GnRO8gxhVNcNAMQb6htYCmFzrbcrkGeRM2/17kQEssCPQMOFsM/evRtWU84pj7dMr0AVpDmSxl1Uc0iDZXpid+3wjm/ePQ5uehp0OCgTDoBiVqkSeLCD07O2TUldb5qp9wt415Lx0AHa9C6r35PLvZ/v8k65X8pwsA9cW8pkkhZFMjM9Fff5VZ18e4y2ArEH5nX6N48uC37L6DMAMpaJ7IrnijGDl2PA+5VUVjJMvf3Ldn3VDzz3dJxFVemaGeqSy0F8mhRTIha41+OQr7qi2ifyGot6mDlKIlHIH5e6txegwIRWFPYbPOMSObmBzGdVuQED0kIrYlcDZngKAnlvVdCu+/LP3z2mCIcJK/e4Fs4Uj8q3upx56pL+5UwyACPhrSoCc1Sy1pp9XGUOOIvqPidHKJCAqkh457xXRGIr2OLcVt0sIuENo8X6twoxFbMKn54powA==;5:2hdaDhz+Gb4Qm8P8iyPmlVDe7MEvcnrV1huq2DoyvrK9u72jgAGC+6OPKdwbdCWHjajSDDSfN6fOBTcc4dMkz+OtdEISYpKiXxkuDTZMdFkML6G/bbE7HxZXZfRjkqwSgcGDpK7orw+iUmJbmVW7lWvDLh7F55K2vuuGygm4I0Y=;24:dMmBr/8h/skupwO/ir7s6WmheHnUJGSduCa+mZt7pY2dbC5cFXb0Rz++KcStQk1Sc+/xVU95FXq3dtFEittyw/wIwLo0oSF5Y/f/cCHENdE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4116;7:At34NjxICSsEYg9O+63uadD1+exdbI+k2u/G9b6Mpl8L9KTgBSzq8MCsnKZrVn5Zy3YILNifFMpMq1EZj2GdMo7VFNdXiaksXcnAr5PBpNcJdtN7QYiZVvUbI4aXIkyy/3y/wgjFIEKQgJ3pFgXra1g3CRex91vU4HCo2eFP+opc0nFTth9bzTsQR8YdHKfXdPHTaA3zstfORkapZs/SqYVV5e8LKcWkPtSn/w9ClsvhlUfb9Ukpg5DhTV/KdaYJ
X-MS-Office365-Filtering-Correlation-Id: ba3c5ddb-7971-40a7-363d-08d5a4420e5c
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 09:03:13.1795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3c5ddb-7971-40a7-363d-08d5a4420e5c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4116
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The extra property enables the discovery on the MDIO bus
of the PHYs which have a vendor specific address space
for accessing the C45 MDIO registers.

Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
---
 Documentation/devicetree/bindings/net/phy.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/phy.txt b/Documentation/devicetree/bindings/net/phy.txt
index d2169a5..82692e2 100644
--- a/Documentation/devicetree/bindings/net/phy.txt
+++ b/Documentation/devicetree/bindings/net/phy.txt
@@ -61,6 +61,11 @@ Optional Properties:
 - reset-deassert-us: Delay after the reset was deasserted in microseconds.
   If this property is missing the delay will be skipped.
 
+- dev-addr: If set, it indicates the device address of the PHY to be used
+  when accessing the C45 PHY registers over MDIO. It is used for vendor specific
+  register space addresses that do no conform to standard address for the MDIO
+  registers (e.g. MMD30)
+
 Example:
 
 ethernet-phy@0 {
@@ -72,4 +77,5 @@ ethernet-phy@0 {
 	reset-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 	reset-assert-us = <1000>;
 	reset-deassert-us = <2000>;
+	dev-addr = <0x1e>;
 };
-- 
2.7.4
