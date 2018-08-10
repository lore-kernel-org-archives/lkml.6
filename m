Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554BEC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE30223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="HeIHNklC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE30223F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbeHJLQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:16:31 -0400
Received: from mail-cys01nam02on0058.outbound.protection.outlook.com ([104.47.37.58]:33328
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727133AbeHJLQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9RSB24KGa0R9DRarMP5tsNTQubJFS7cRc5bKzovVPw=;
 b=HeIHNklC8LQSrbbcDhFXC9VKPE0wZXgp1wwsLuLEo9klmOuwEKfnEeyjUP8efDM2Cs/KAzLtuzReYILU7p5d7GxoGaQ8vT9/LSv2QDtVKNkOoegzszWiuy/hKgTHpMiYkT2OygWvevjEAg6sP/CEapCoP5ACdw4QFXrOUhAGkmk=
Received: from BLUPR0301CA0010.namprd03.prod.outlook.com
 (2a01:111:e400:5259::20) by BLUPR03MB550.namprd03.prod.outlook.com
 (2a01:111:e400:880::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.19; Fri, 10 Aug
 2018 08:47:31 +0000
Received: from BY2FFO11FD003.protection.gbl (2a01:111:f400:7c0c::177) by
 BLUPR0301CA0010.outlook.office365.com (2a01:111:e400:5259::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1038.21 via Frontend Transport; Fri, 10 Aug 2018 08:47:31 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BY2FFO11FD003.mail.protection.outlook.com (10.1.14.125) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Fri, 10 Aug 2018 08:47:30 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w7A8lUx9019023
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Fri, 10 Aug 2018 01:47:30 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Fri, 10 Aug 2018
 04:47:29 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/6] dt-bindings: iio: accel: Add docs for ADXL372
Date:   Fri, 10 Aug 2018 11:46:19 +0300
Message-ID: <1533890783-13456-3-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
References: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(346002)(2980300002)(438002)(189003)(199004)(106466001)(7636002)(6306002)(305945005)(4326008)(2906002)(72206003)(966005)(478600001)(1720100001)(77096007)(126002)(2616005)(476003)(44832011)(486006)(11346002)(8936002)(106002)(7416002)(50226002)(446003)(50466002)(51416003)(8676002)(6346003)(76176011)(426003)(186003)(7696005)(246002)(336012)(5660300001)(110136005)(48376002)(16586007)(54906003)(316002)(47776003)(356003)(36756003)(6666003)(53416004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB550;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD003;1:6KN7nj++I9WeVsi5TACoU4P/ZXyj9FCIvkQdK02MT1y7WB03NjiR5feEaCvjXkfzc4QIyVBnrV+bIGtcNFrRo+ZsveNKWtbwB0nQiPZGi8caIlT6Ng/IfsljgDiYGAY2
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f45788d-b998-4fac-d5c3-08d5fe9de8dd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR03MB550;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;3:5yVHpxmqvGmmfYomw8WbO6Vz5r+ndC9QZT2YR84+E8cNdQt8fluglyiJ/RYUy8THpYdaSFbcN4uD60XfP4i6oENT+kp1JuDtv2zF0zzZx5KIeZ/ub94qmyTVXKli3G3qocGncGf+dSL8RqJjbiF089NwppFp7qJrKBTGcdFY1BelcySKnDd5D77XEvT5DHe9/Bx5VeaqhucxoYC4fncwx7C9ACnZNxsmq5p0+ayNcAUOb9VMnqeVG0Ce1dXEizo4+HKWvhYvDynBnpCGthVqV/BAi/ddi+teJz9VFH08jcBz/CKRZwPkoGWbD0dsp/ZbpYqx5E18gzO8UxpNC30hBbtn3E3LfszjRgJZ2IYOYt0=;25:1BzDVzUZlL70R/xvHN6Ar7xNbAzXkFYMHgRr9vVBlR8gqvNNIR7AeIqznNzCv2JFGc1PnsHyAcEO/WgC5wCAz3GRc/ClqTFTf41B4h/scnbIsdwfutmibdWCdkZF2zzIZ0AYUqvzgNj4AkxEXpxK6rYXMmjzQeEeySr4UFslxMl+J92+L0cqmC6yvGpracq3Xz2cdcsHO+oj21k9zATonL1H5La7sikE3b5RxNEyyPw5m/tH32ammG6dP/wRysju/eRvmAHYTipZUqO10Lp3mXORAyL08BC3vbKcnMKBYDDLSZ5sAxC1pNxEqXOcJOUDIMHLwKRrT7eIm9uH/ceVXg==
X-MS-TrafficTypeDiagnostic: BLUPR03MB550:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;31:0LyGxPsjhFOApvlCdgcvXtHEt/KQYsJoidyiORVL9lXPdRvmrgSmKXhbOVXc46IbAyuwL5VZeyXWQ+Zg0Sy4QJO9Jp72XXXcjsHd1fXDfrmJzrJ4JDEljci4JtUORs0lwmb8RAdcsGDVcpnCr8TmAYP8Y0iXCXuW5ibxcVESkP/xhf6Bx0r/d6PzvZ1cB0Dz1dATVMWpqBMuDg9980vWwF+nq8AGir1DGXwVyNCNvM0=;20:Ivc7TZA+7th6KuvDbXO5o4SQN3rHluo9Vq7Rrx57HtuKBSNxY8czEOpqOBPT3ctquS++tAIIuZ2BfS1L1On3sWk3/YaqqZDFg1FEU+tJou+sFcNIwqedH/fpfYqwdOttlBM6hBZGl55636d+nkledEkJD5zmaZdq0eaOwnVZF3NKQAKI2Ugj+qVg/6I+F/Y76o4be60qj0vOe1bjfuvSrphCUOFuT1W2Zu3Ggr0xPMrjEmQJFuMuPuLta79e0n1S4D+2dSQeNnIx6NFxKRQOlqIqrgyk5v1DR3VI10iSVA1NEhq0g8fA+ChE33pepBsjZ0F1u4qOfanmtd7G4eCG9wj9rIGwnjj+UoelAoimmqCmqiZpgJ67KejgjiWJuKr0OaayMy9GgTPwJyC5pCfLl52vuN22aW9y8QCIsIiwWy/CRP52xOCqSIB79IP0LkCfhHRXV4URhFOERbtg+kLYQwOLZitnxqPv1plvNKlDKZsWX00HLxvGvlq1tWFbXp22
X-Microsoft-Antispam-PRVS: <BLUPR03MB550E5E7F41A2E60433779629D240@BLUPR03MB550.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BLUPR03MB550;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB550;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;4:lD8VfTZbVZQQyxvv4xt3UhzNzzuf0+dNPNiZujB+rgHLMKjCmCKbLBgPd0XJLy4cgxScJakOA9kVsYDndrcqpZ/T0q6V9VgBMjbs8ArnH0P5wIgStpniQo2e07hPK3cL5IwFmeJlGtVU7KUkQDpjMfYcM4F9eJNS2cXtzqyybjEvlRSw6sqiSqKLYK65Q0iEq/jseVyu+3t8hxmKKGqK9EprGtBTTzxUutvM0skVyW68eNwiFAO3aCGlz6r58lANPvEzUmFAXdXBAqv56xdUgPT6jhGvDIpPi/IE8t2FIRYcmzD6ADuKG+Y/NaTGhcf/3H9nftyo1/8IXd9JYP0s/J20pHyd8UoY/+pbF4sg8GLngJO9gzSZiYqCsalIRK2b
X-Forefront-PRVS: 07607ED19A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB550;23:EGMmEaux77DKYevth75Yp0ezkEhfPfENW3+mgdZYy+?=
 =?us-ascii?Q?mdsadcaXVBhRehJssqCiSNnAWVwCcPwhseU3rj9NaMt8zlubG+uhRO96gEoA?=
 =?us-ascii?Q?uISveSo9QlBPThy2n3Kt/t/u0MG4+/jaCqBRVYRBygZbrI9EN7onT68sk5Mt?=
 =?us-ascii?Q?fd2GAbv0jcW46xX9eqzRzIFE0FF6J73idZsdCN4k+FhM+w4FDbv6V15ITWWq?=
 =?us-ascii?Q?4qe/CgbhZu/YnLUX73Twdd2FBOG5LLEjis4YeHfGF+BZdPwXkG8T2zqWxd9K?=
 =?us-ascii?Q?I0fsfe0cOUaW6e+IvQIs5p3Csu3KuSvNVlK/7eDrnfBaNgnTOhZMhShO6+p6?=
 =?us-ascii?Q?0Eo1tknuiQauKuT3cNOvfAKBRnLJay+KyLlAcivlfKTbF67XdbcFYEe7IoeB?=
 =?us-ascii?Q?V/pSDFIf+ErAdtn3dlJBogjXG66hvD8XU/hYUJ6qHtxck1F3kPjLCBzYQjSh?=
 =?us-ascii?Q?4Np9SJun2Js3jQ3+hwFHrfocKOqEei646Co8QjmZL1DhBcwDi+BsYCDOaMCi?=
 =?us-ascii?Q?rFeiktijCouephaiSPDVRNWPkf9GtCJcnd1B31F5zqMQYIKo/aoQDd4TI+RE?=
 =?us-ascii?Q?IIlyG7XlOwPkeNioLoAtYOeW3WLGqKzsZVpX9kZ2gXOnr/qbtBx0SmYEvkbv?=
 =?us-ascii?Q?26RUrDdN5GP5mIJU025M2rPypFTUqZx+VlVXfPCIx2UQHnj/B8HmJ5dqSXqr?=
 =?us-ascii?Q?/UueuSAStFYgGQa6yp0YRZUOv1KccZle1e9c2sRLTCexxqPeUeGJyNGZR+Hi?=
 =?us-ascii?Q?7swDk1r9sDK5/r76s401YVXe7187FlJo1xiVDeh29HZcA8tfOBIuFRkyro+3?=
 =?us-ascii?Q?ovo8eugFzfd+W4vJvxhFVHAkY2Jw0rHHsg+ASgdsI4vghzNJ6OkLfMU+Qqc+?=
 =?us-ascii?Q?6rrrX1GC21NEN7WiZem6O9wtHgaxi55paiFpihrIcLOEbabzAQ9x6M16DzI8?=
 =?us-ascii?Q?A8k0ss2hSVF+BKPCR9ew+k7lLKC3VgDzte07MtfDx5vDnFoKajOUbqn0yhig?=
 =?us-ascii?Q?Ef7Xk53v0spaG43bw7RNbyXEFTf2wDwGPGbSQVNzmB4+t7SSwXuHz+yRzor4?=
 =?us-ascii?Q?VzwEdydpJlPXOzKVRRmVrg0r3yFoXjU63bsqNp/luF3uE223AnJQbY/dDkmd?=
 =?us-ascii?Q?cSpXwT8XmvOXypYKd9fC1x22XB/b8JIqk+T48obfeYMKHk4EQGyA=3D=3D?=
X-Microsoft-Antispam-Message-Info: IvLYviwHs31spa+PT03oJ+TXIDWDS6xHRJq2Migb2C4SBFEUAkYZQtLYuiwU0nZX3QAuZp0G6ZfCrOR3aR0iFjdTgbPE0ZBG31P0CrxAK+YrRt5aY48PZ/6txK8V/SJ2Q9RhwDd+rzOfJ/1ccusQafBoVRrhpnZXEBPn4eRvZXi/1fXrVQBRplQaEYEZz9G40+4ZN805sweoNO5zy6XY1CW6SIaeu1eImX/Hu70FYsbdQxhOmgQnts7+nRs06XhbpI21vRBxQQmO3bZT0DECTKtpzHVpBeC0jyenkELX0BlWyweRAvi7ihTWi+mz7gawSygehtCMZdqxV1PBJnKAleMHTarkGakYckPOLGsJrvE=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;6:o+mVOahzHY+0e94ISHw6PLIRhyBnN84dlhcs/GxSexHwn/y8eVhKdR9YLQQ8x3gtYcas3Lu1jgQuHmcz5DOsStNh9id2HuqH6Imbog5jOBq4pGhQcVo39rkeAnJtyeocAIRQPSgfmMaLSYmqpldHUwOVWGIf50OI1KIxJx6iLzK83vlkMPM8LNJLKRqpy4rf/Z6AascXpbVA5j7ACCWDJjmR8bq/zl57hyIYN/QOUqxX5OH8WDN8ZTbtKuEkVxfNNoS2mfxNO+xLAYHiVXD7oMK7I0a2qiKOKhy9aRvm+JXmlTRkWL55QSV4CG21NpIjIK+hiDfnbRJDlXsSR2hHtu4r6GZV5DutR9qXNp615FgSYYeL+B3JNl7gZY7FHtjzKQgqev6E6yJcRi2fulIBpjbvdnPdj2u/wHEVSMagCeiN3OaI7j7e23wrc6cw7Uh78k+yGu2QfgTTTdTe9q62Ow==;5:yy6RM3CGq8OecFhON66DG2naoQvf0EYb8QN9btHEr2B70S8oFKXuLG5WWZEcBDbc4qEOj+8yBPOiBRLOMl6IeKdBXjnGY1YM5dbC2Xa3R0Kz71xzXUU/sbD0JZDbRXeTwFDoYPoaLvLAI4Ga1htGITHOYDSnbt/Zwp+TspwrAlM=;7:1ntX4LcuNJ2KIBwHWUp23QhyfN4PpRErRTFLTNQ5CHOlqnUvYNSxK1bHgnDGignLcMYWu4SECCC3Fe0a19OwZ8Lu8uMwRwXXB0aFiYMXZofX9giEGqiHKkb5H0XQrMX7+3OqGJpDBdd3zDNCcbS50uepXoAvtPu2xuZ12+3hsy1zMwVShtjW6zxlUwja9CDvvbGfhw6y9AVkPs/jAGeDfIDwdQWwu9bK+NnvQPRafe8qPsB0QeidfSAdB3nl5hpT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 08:47:30.9996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f45788d-b998-4fac-d5c3-08d5fe9de8dd
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB550
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device tree binding documentation for the ADXL372 3-axis digital
accelerometer.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iio/accel/adxl372.txt      | 22 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
new file mode 100644
index 0000000..9409984
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
@@ -0,0 +1,22 @@
+Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
+
+http://www.analog.com/media/en/technical-documentation/data-sheets/adxl372.pdf
+
+Required properties:
+ - compatible : should be "adi,adxl372"
+ - reg: SPI chip select number for the device
+ - spi-max-frequency: Max SPI frequency to use
+
+Optional properties:
+ - interrupts: interrupt mapping for IRQ as documented in
+   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+Example:
+
+	accelerometer@0 {
+		compatible = "adi,adxl372";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		interrupt-parent = <&gpio>;
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 2ba47bb..c8dd09c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -548,6 +548,7 @@ M:	Stefan Popa <stefan.popa@analog.com>
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/accel/adxl372.c
+F:	Documentation/devicetree/bindings/iio/accel/adxl372.txt
 
 AF9013 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
-- 
2.7.4

