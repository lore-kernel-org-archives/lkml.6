Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeFENxp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:53:45 -0400
Received: from mail-co1nam03on0044.outbound.protection.outlook.com ([104.47.40.44]:47327
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751590AbeFENxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:53:42 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mchehab@kernel.org>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
        <linus.walleij@linaro.org>, <rdunlap@infradead.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH 2/2] dt-bindings: iio: dac: Add docs for AD5758 DAC
Date: Tue, 5 Jun 2018 16:53:18 +0300
Message-ID: <1528206798-14095-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(396003)(346002)(2980300002)(438002)(199004)(189003)(54906003)(5660300001)(107886003)(4326008)(336012)(1720100001)(186003)(305945005)(6306002)(8666007)(53416004)(478600001)(126002)(966005)(72206003)(44832011)(476003)(2616005)(426003)(8676002)(246002)(2870700001)(106002)(26005)(47776003)(8936002)(50466002)(59450400001)(77096007)(2201001)(5820100001)(50226002)(23676004)(6666003)(316002)(7636002)(2906002)(356003)(106466001)(110136005)(7696005)(36756003)(486006)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3424;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD008;1:Ou9jsDKSbWEl3KSACghdekHnSWtUztVu+BsLLbSlr6fm0a5HdalDjfhIqno+XyLEuEsz9f/lmqmZ+vq0f48GB3npsftWDRoOWJ0PSkeLHJS9sOmuODxQejM2NHTpgBef
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:SN6PR03MB3424;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3424;3:qkP55NOudJZtBL2vrLbLvNkNimf4o7DjMFGO5hCbVexyZcj6dENy71w0nl/tiI5Iw8PQgs0onzUFuxJs9hr95Em1dB2+jB4+ldZ46F1PRp3Vq/Ds8EC6DHuecP0zlepJ8UYu1IVqfT+R5KPzuX11Cb82lDgw+TMqwF2zA7kLcLwUcLgv4un4BanVETo1CCJdCcliBEYHPDvKUlOKqA7i/LxmL65AMpkufQ0PLxo6gxyiCQ7mVMnbqwRQqBHq0/s7kbR9zgKv8jQbWV2spqBmo48vp6oVEt4SY+167p2HSvmdR8fd882HxRZfBeEdKSLLY9VxZ5iWu2cAQbhXemNENA==;25:93o2Hj3LakWW9WlW7zwyRqCdH1PKbZNKjaRN537P3NnZ0DqLOam8XNHOjq5WBBwQaQJHK7SlyFGH1GVzRBAfIHn0TYLFbsQ2jFiInMaUEQSBrtiH2Bmu5AXJSmYpzkn6UGyScpJeleNOVp68QUaf5ljpJv1jtp1kkGtGNPCx6N8vkU0z2IeuNv4SnbP5sZ4g8cgLcFFzqq2a82kfthFA423nd8mJKtczp0KJ7URGW5PKVR7dFfyzStzM+rdXjIt+qlsor4PdwvJylwVgF2TbSGaO4iWTBA9SDciI7NRZvfBlPWD6anQkvNM+04F6mcK8SICBqWSZyh2ym5pKbDg1cw==;31:qyifx0b5FZ9YV1JAuOZEkOxfa2HgcSDWE8jtg/gErsYdz1abPFeHFv6VPvTJS3SmbLDDAqDatEpWg2Uaruy9xNnLBrXMaaM1conTtsr6K2R+5Y8zX6htppJOKoPwsqGfhGpYZ9DWZ08hl/QuiyCYe3OmLZnsFFkw3qzVamV92htoPJATM/tlwiYKeXEHtld7o/lGs7GFAoxzW+K7f4DtzBKV+zcojSiJpGuz7Oq9I+A=
X-MS-TrafficTypeDiagnostic: SN6PR03MB3424:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3424;20:F/eU4URBJHFDtszXlqmGXaVB4vizeVjxWPX4+SqQ47JazX8gZv/Qsk3Ya4uP4xAwzamalxc67gu5COp/QS1FdPNqUpeYbS7FPmwqI5/TKm3MtbNOliyZiubTSh02gNGcZwPVHtdKJTVKFoIY9S6VnQdmzbUc2RWciC3T523VWBDsws64V5ceQB7XJjeD+t3LyfZEzz4eI0bShQwhbulWJLCydlHbxEssTjw3kd2wVb0nh4PX+5FhMlXCNEOjRJ0IrKzqofXlphbcH7aSNud3fLLv2W/E1CT6b5i8KaHb4efL5VdTNPf7nbywvQtq71aGZYz6qR0Ar3XwoTLo9PfqXxWyPcvzQ8j177dhyejq4RIBnGesXg3swRtEK7A/Bt4PrXYFpx0bFniVnqX/NrinDVPPrZnstFGCV+CRT+ZX5cEu22vjE0aeBFN2efSxdQkkMAR7E5IehY3hY3tQ3iqh+EIyxRWyL6F1cL8aDER63gSJ8/zz5OhDrwtDsIv224Ge;4:HHpz8WERnldRVc6RBTbguD+buX3aBkgl86bQRF2FBgFMvA0KI71kv0gLr8JDxKyTkMJ+XaqRcAU1voURz0vDj20iiJ+9XWxvCUtXbe2TmxETyIJrF8KACkPGFs0dxi4rrsGFBHgpDfc5A+Ds2rvSJc/zVOQk0I0AzOU3sgJ53MDcW/gFrLqUv335OO8oXk4BKgwBnFJtub2QLyJQ90tt6mkNJTNd/lvDQQUvVM3maO6oXn/N5UCj+CNM7noUjVYaY0po06oCi3eCEwDWFZ+ivdr8hILDqIliHdhUtMeMsFk6gb+gca49Wd+MQHOP5XWeIFsXI6b7zpYWMioEKI+Y6rrbaR7yyy0T9CzJQm7c1Id+4YNC4Z5kLg0BsERE7gFyNYdwnfdFV5zUFcsen7GTaK65qAn5gJ9AjEPBCTa5YV4=
X-Microsoft-Antispam-PRVS: <SN6PR03MB34244A5B8C428C36C2C682A59D660@SN6PR03MB3424.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(232431446821674)(95692535739014)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR03MB3424;BCL:0;PCL:0;RULEID:;SRVR:SN6PR03MB3424;
X-Forefront-PRVS: 0694C54398
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjAzTUIzNDI0OzIzOjg5MC95S1c3R05aN3ZyRXIwcTRhZzBlQlI1?=
 =?utf-8?B?R1BDZUpuZXJUYVhPdklvUXoyaXhNZkwzZ2NML0QwdW04bTEreU5nRnY5QkpY?=
 =?utf-8?B?eWJVME9pTXgwY2ZYNVcxaFdpZFA3ZzhZMzFlTE41azQ0ckd6TmIwWHVHTHpU?=
 =?utf-8?B?OWNWNHo0bTVvTVlWZUs4MExCSlZjNTVXc2dSRHZSWk95cEw2M2hUbFRGMklk?=
 =?utf-8?B?MUg0dWYzMjVPMXhoQytaTEZqcmtvREhGamRFZkpaNXQ5THZ0OU9YaTVIajZB?=
 =?utf-8?B?dk9KL2h0VmZlR0hyWjF6MCtFaC9xalpsRUxybnV2NUlVZXEvRlVqTTBKdUNN?=
 =?utf-8?B?eXczNlk4SjNnZmNwSEJiMFNJZXRkYkVmeFZ6Mm1JaXZDV2VPeFZZRkIwY3ky?=
 =?utf-8?B?STFGQzczOFdHd1QvdzUrQWtaQ1BHaS9JUktteWRwS0QzUEZrUUFWbWdPRkxJ?=
 =?utf-8?B?M1ZUM3lMTzBvd1BzbUYxQlo0K0h0aEExSDQ4eHBodXZNZW1CN2tleVZWUGxE?=
 =?utf-8?B?T2MraTl6SkxMZERIT1gvMXpBSVJBSm02VVJTSlR4dFltbjZPeE9QT1F3TURw?=
 =?utf-8?B?WTRDQTNVbEFFQlcwbCtIZFpGT0c3RERBcEIvSkJRUjc5U2R6SFB5YU9RaEl4?=
 =?utf-8?B?cHlqK1dRcHhDTEtMSDM4YzZxMUtKQkdUK3pvVXRyeU1qbzQ3NzVhU2JVZzlu?=
 =?utf-8?B?d015Yzlqb0RBakhHWGEzYnVZeEZQeXY2ZDdjU2xMbnhPdHhjeWZEN3FqN2J5?=
 =?utf-8?B?ZGFQQ2tqMkdzdEJGN0lMbkhwdk54TXVYWUJoUGhaSldJSWN1RnE5bFFSNUFB?=
 =?utf-8?B?R29HRnlCMzg0LzZ1Y3BGMEZMS0lSM0xxVGM2aHRvNEhYTkUvTVNSOGU4MnJv?=
 =?utf-8?B?SC96ckJTSFlXMkc4WmZ5STdHeG5CakFURjhzSkszeG9jdXFUYzV0MTl1QmpN?=
 =?utf-8?B?THBwSTYxSTlOOEY2dDc4emc4UXl2OHdKVTM1dnFCeEJvTFhTLzJHUjdZUElF?=
 =?utf-8?B?SzJ4TE5ic3hPOE9LWmQ0VDRSWnVxMFgzZXRVRmw0eXhsYzlJWmVxbmxZd1c4?=
 =?utf-8?B?L1pvMnc2TWVMR25nT3NSVDJ2eWlWREp6OUVIdUhoaU0wK3l2ZlRGVkw2b1M4?=
 =?utf-8?B?VGxqOWM3Rk1uNEx3eGJaVS95d0loS2l1RWhoWFFUM24rK3ZPZTNuTEV3elhN?=
 =?utf-8?B?Qy9xdnMvL1lOWUh1eCsrYTY5MWJKWlhwVkJCb0g5L0tNekJsam1hNkgwMlpx?=
 =?utf-8?B?a0tQaGF0blY3THFwV2FlV2xkY2p1bjYxRW1kcE8vNU5yN2s4Rm1DaE9UMGwz?=
 =?utf-8?B?V3dGN0hqZEU3Zzlzby91T01wQnZoYStTc3pmcGp1UlFqTVk1d3NmMkZLaVZq?=
 =?utf-8?B?U1o1WSs5dnNTTXVLelVYL0tzNEwrUVJrUDFRam1JcU81VHhDei8vUWxzNkFl?=
 =?utf-8?B?dllVQzM0ZjVKcVdIdzJVOUd1djZYcGczcEZIMGdEUnlTbWdmYTFiQU50YTJF?=
 =?utf-8?B?S3h1bmlXN1FsMnM2M0xmZktUZjZsNGFCR0tCN1dnYmdRL3BhNHFVQmRCM3g2?=
 =?utf-8?Q?dwXxIEj22ZTREY2xEyhZJdL/XB4MTjDYN3vuB1Qk1HuA=3D?=
X-Microsoft-Antispam-Message-Info: 0ylTLxZ70xj5aGiWSA8OjyqW3Z7vQmVJGGfVnIvz+5wzYMnfUT8fc+knP59KuVivLzToEF2ZJLHguvd5c1MQ7O4xRrQwSX2fut9rlDsByUg/H74nP4J42eAHft2AHU/i7a21rgw8bqyJ8huuL9Gd7JF6UU8hQuMWSDo9kVeLMd7ZPvsdeqAPxEry5nU8RLXp
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3424;6:XGFCnZXTytQYOqKGHFtm856Qg5FM2C4SNtX2vz4KQcjzJbIUCHNjWHIDbeaeTB3U/4gr+y4O9586ubOaW0E9DlZhSHhmP57A6h1oFJykMEOW2/wKgEnQPUADIsB3a1DO7j0sSowPMu+/YePiHOf03SN57m2bW72g+Mkas7nkJmaR7e3yUi+/pihCCVSqD4WWrTqsGvl2K0ARVLvlKb7m1c8Q+g1hpNksk6LDy2OmMyUfbJVlahPSrZsftP3v91FKjsUpJp7XD+j1bsQ2uOofKpuF+u8aIbCOF22jwD28YkhnesKqd/QPlPMSCPrW4RztkI2m2XWvJIOFjeTVTfsu3hjsL6Mx+8h4XEUCTDPuHurHg59OFp02Se0IoY3pDMgRen+1ZFqf+HPeAtxGmLJcKNkhrcMNiXb+V4xYZsIRM6Sz5WOv+cvCLbmqARBzCfPlEukXNijn9pGQp70q/PlBig==;5:bxIreOuXPA8aIF7RSSq+LkPxQXywb4ozJ38GL2bRilD5hqPXLBLi0DPD9PtWucCqRI/ZIMHNxIqb7tWAKlodFnaPICEv/+NaRqlLPHNnOdB/GjiCiVr9LkwnGqmmU4q/MpoHkuNE4U3z6L5u+NCKzuOJpbsD2o5yJTakgfF4dLk=;24:/G+WmXVdyrJX4hNhKHadup+wnmr6tlSC2FpoXUZdmuwkasfB+7RJhS7UzFGC2PDCEf0ZmfePxLAUmhVjeghGbMwnonfzE/bOdqgVUnNpwzY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3424;7:jhtr9BaAHivNxOzdw3qKp4vkkwu1Gub0bniBT9d267gUA9gqrujCZinehPt8cU4ZnaZ8UaJW5+hE6JDt+uuL1JbrNImG3abgTUpK9IvXMUjkySDjZs9FcRQV7R+B6MOqG5xkMgCR704qTeX79P1EPppny0B5YnHWD+NMLhzOXfanmclaEb1Ls91PNfZGd06hwbd75gRC23iUhfF1elxb/i1NYC3TJrj7xB7KPlh2y0sUUBmbhbFd/shARRHJ31WX
X-MS-Office365-Filtering-Correlation-Id: 52d72c6f-d9cf-4e46-9111-08d5caebbad1
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 13:53:34.1342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d72c6f-d9cf-4e46-9111-08d5caebbad1
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3424
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../devicetree/bindings/iio/dac/ad5758.txt         | 84 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5758.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ad5758.txt b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
new file mode 100644
index 0000000..75fff6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
@@ -0,0 +1,84 @@
+Analog Devices AD5758 DAC device driver
+
+Required properties for the AD5758:
+	- compatible: Must be "adi,ad5758"
+	- reg: SPI chip select number for the device
+	- spi-max-frequency: Max SPI frequency to use (< 50000000)
+	- spi-cpha: is the only mode that is supported
+
+Optional properties:
+
+ - adi,dc-dc-mode: Mode of operation of the dc-to-dc converter
+		   The following values are currently supported:
+		   	* 0: DC-to-DC converter powered off
+			* 1: DPC current mode
+			* 2: DPC voltage mode
+			* 3: PPC current mode
+
+ - adi,dc-dc-ilim: The dc-to-dc converter current limit
+		   The following values are currently supported [mA]:
+		   	* 150
+			* 200
+			* 250
+			* 300
+			* 350
+			* 400
+
+ - adi,slew: Array of slewrate settings should contain 3 fields:
+	1: Should be either 0 or 1 in order to enable or disable slewrate.
+	2: Slew rate clock:
+		Valid values for the slew rate update frequency [Hz]:
+		* 240000
+		* 200000
+		* 150000
+		* 128000
+		* 64000
+		* 32000
+		* 16000
+		* 8000
+		* 4000
+		* 2000
+		* 1000
+		* 512
+		* 256
+		* 128
+		* 64
+		* 16
+	3: Slew rate step:
+		Defines by how much the output value changes at each update.
+		Valid values for the step size LSBs:
+		* 4
+		* 12
+		* 64
+		* 120
+		* 256
+		* 500
+		* 1820
+		* 2048
+
+ - adi,range: The output range
+	      The following values are currently supported:
+	      	* 0: 0 V to 5 V voltage range
+		* 1: 0 V to 10 V voltage range
+		* 2: ±5 V voltage range
+		* 3: ±10 V voltage range
+		* 8: 0 mA to 20 mA current range
+		* 9: 0 mA to 24 mA current range
+		* 10: 4 mA to 20 mA current range
+		* 11: ±20 mA current range
+		* 12: ±24 mA current range
+		* 13: −1 mA to +22 mA current range
+
+AD5758 Example:
+
+	ad5758@0 {
+		compatible = "adi,ad5758";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		spi-cpha;
+
+		adi,dc-dc-mode = <2>;
+		adi,dc-dc-ilim = <200>;
+		adi,slew = <1 200000 12>;
+		adi,range = <1>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 1993779..f640146 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -808,6 +808,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/dac/ad5758.c
+F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
 
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
-- 
2.7.4
