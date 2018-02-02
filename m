Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752330AbeBBUdd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:33:33 -0500
Received: from mail-sn1nam01on0085.outbound.protection.outlook.com ([104.47.32.85]:18539
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751557AbeBBUd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:33:29 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Daniel Baluta <daniel.baluta@nxp.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <andy.shevchenko@gmail.com>,
        <fabio.estevam@nxp.com>
CC: <linux-kernel@vger.kernel.org>, <wakasugi.jb@om.asahi-kasei.co.jp>,
        <shengjiu.wang@nxp.com>, <daniel.baluta@nxp.com>,
        <mihai.serban@gmail.com>, <cosmin.samoila@nxp.com>,
        <linux-imx@nxp.com>, <daniel.baluta@gmail.com>
Subject: [PATCH v2 0/2] Add support for AK5558 ADC
Date: Fri, 2 Feb 2018 18:20:04 +0200
Message-ID: <1517588406-3295-1-git-send-email-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131620772074927366;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(376002)(396003)(346002)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(85426001)(86362001)(5820100001)(5660300001)(110136005)(54906003)(53936002)(50466002)(106466001)(105606002)(26005)(2201001)(498600001)(336011)(26826003)(316002)(6666003)(6636002)(23676004)(956003)(8936002)(81166006)(81156014)(356003)(47776003)(2870700001)(104016004)(68736007)(450100002)(50226002)(305945005)(8676002)(97736004)(4326008)(36756003)(2906002)(107886003)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB469;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD028;1:J37agPLLiMZ5AtfJ8SBBPKEl8XqkIam0W+sKvH1wcwX1QRbOWAULRSKizBIUJojKyuzZGLIhuYQBL8jMSoyPm8ETmufo/1M2Fiba+TnOjwSWlywIuG32nyiBQqoEAjmr
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae1892b2-828b-49db-53a5-08d56a7c370b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BLUPR03MB469;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB469;3:jFXgvINfn97AG2xHbjdhaS1bozh8mGGH9Xo0hMS/VRAJsQcYDr2JvBoYeFq/gEtpqSAKNGIkF1xVgsFyi9FumKvwMa06algeqD+G3iq0GDUs6/M4Om5amxIb7Yb6PtRCe1xnPtqxqtfh88TgUswiQ3OGa123wVEHkQra/6dq2cuA5Qs3efRDAqgLa0i8gGZtcxHtOxENF8LqErFyOdGqSgb82TJLyBEwtNYsDzIdXM+CrwY/6o+mTTf81cHIXTvgjABvvwA6WAO7/i2zHo8wg9dITHafM8KZBleFUPaRaYaTAlabJy4T1xNw6Rg482WZU6YKLO172xf9CrmrnTvNshpKWAe+6jl1ecjorjcwmUQ=;25:KSDoyQqBrpXYRhDdI4tfr9QIJ7Rb3N39n5x4d6m2DN+4hWS+rECPzGbaBSiJBGk0Hzt5IZriOUW7KBcCRQoxFz0zoBrKVJl1fX83mxlOGaZeumS/812yC42YgO+KowggmXWKt5B7WeYS3kg4oH6eAp84IhOwXcKPIyak+T6Y0IuhVgIxjyS0uPECMQ/9B9ncxhfPna000PrEOczDbNaz9MJlBPqCfJ7yaTwuSOZlTJTxQvi2s4422Y/VUDNb9kCBoZ8rxw1XrUn4EE7TG0jnF/TBYNqPd/gtTg4KNF3rWn/0F0pJxtOoUxnHswD+wpRRckczstvyAAOtO4UAuJ71PQ==
X-MS-TrafficTypeDiagnostic: BLUPR03MB469:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB469;31:WPbbDrS6aiQnl2RQXpNRg0vfMlGPfG9B8FebuB8iLsmWygoFNgD2+FaDBih64rkBMueBC5+tye4anpnhgjRMqOSpMvJm3ge0l4+Snk6QmrKmNq+bRgKp5o1GHax7OukzrWR9aYH2CCT5g29SD0I9t4xc9U8zp1UsVEEHO7uml0tFm0Lqux8CGjDRtejcOGHBqgp8XrXMXlDDCVwnaZWg7Hqu4ns4a67KhrjGtg7egrQ=;4:7/Vfwg/09DT7uv7C0Sq1TcxTzEJkQly/fOT6wh7Gdg9tQJk6RvcdScYzcA3REmInyIgf1atipmoL1sYpS4gkuFmHPVbKDzWf73G3EgLSno8N74rkA1YSdoWlFYjf1pxx1632l1BE54l8Mof2iWyRBprEVe6cyKBhGjYUmZ0jiwLyQLm/000sXu93g9zCWtiv2eqgKrlqOL9/fZ8HkRXlPVNsjUiCSITv/kN4HPrJWwRMeSXCoHR95UZ4wOl3p338NdHOkHecnFZ/Gwly1cr9ow==
X-Microsoft-Antispam-PRVS: <BLUPR03MB469856B6A0A7676E241FE97F9F90@BLUPR03MB469.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(6055026)(6096035)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123556025)(20161123563025)(20161123561025)(20161123565025)(201708071742011);SRVR:BLUPR03MB469;BCL:0;PCL:0;RULEID:(400006);SRVR:BLUPR03MB469;
X-Forefront-PRVS: 05715BE7FD
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjAzTUI0Njk7MjM6TGxHRmcwQS9zS2hObGc5d0VBNHNxOTJzOStl?=
 =?utf-8?B?MWhyblR3RlZ6T1Roc3RSVmtxTUN3dHNWUXRHSWhEdWNsczl3dlBZV1lNNi9T?=
 =?utf-8?B?TlJ5eGloVmI4OGhGMktQVDJ1TnZ0Uk1lQ2YzMDJ3RkVTMUhEdmcyVzlHV09F?=
 =?utf-8?B?ZjNoU0wzbEJRQUd2R2svd09VZ1FDejBVckNXNDJRaitROWFIVTJoUUtWT0lM?=
 =?utf-8?B?emVEZkFqWkRpb0RzNlpjeUYwL0N5cTdWcVJ0QnlYZkNxcXBMNGlSV2pEVlpU?=
 =?utf-8?B?c0U1V0xjWlI3ZnhYektsOGg5R1FkRFY1aFo4L0plS2o0Q2xjV2JkYlhvQTNH?=
 =?utf-8?B?ZkpSNFFaWVJRNy9udW5kZ01NVTFMd0ZQM041Z2NaL2VsamR4dzlsK0V5OHh6?=
 =?utf-8?B?SGd5ZVlPOS9MVkp3NjRXL3ROQ1QwcWNhaVVRalB0blJmRUN0L0lZVXZneEVv?=
 =?utf-8?B?ZVJ0WHJxVTB1am56TElmK2RLZ3RiRU9qU2NvdldnOC93bE40SmtRY3lVcVVH?=
 =?utf-8?B?RW1zSC9JQ3BRWHR1VW1MWkRzcUhsREJzOE56eXhFU0kvNVBRVCswQXM1eFVB?=
 =?utf-8?B?UG14ajFDZkNHWG9IcHVRME9wOGhad2cvT3pJYXJYR2FwUXU1ZTBaS2Zac29G?=
 =?utf-8?B?c0l2TDQ2V1N4Y2FldlZvN05uQ0w2Mlg0T2JlRy8veE5OK1ViSWM3aGxJMDR4?=
 =?utf-8?B?TksyOTRBVmg3d2V1TXNWUGFtUWd0ZERjcVF6Vkd0eHhHY0IyZVo5VENDcTA2?=
 =?utf-8?B?RHBmMUFFY1BweTI3N3ZWbjM5MjNnWmtKc05KVTUyckRnL3NYYktnUkpuQTI0?=
 =?utf-8?B?cDRDTG85YWhoZ2t2N0JmTEh2SVFCZW9vdDE1RE9SZnhzMTdlL1Y1MUZlMTgr?=
 =?utf-8?B?RWNPY0RZWG1oVUpGMXhnUmo5dlljdmlXc1RORTFPNjJ0TzZYMzNsSlNYVEYy?=
 =?utf-8?B?eTVwcUErQWhtZDZFSThCMzZIQVFxRHFnODYzUU5oek5RVlVtN1FwcXZrNHpi?=
 =?utf-8?B?V0FaeDA4Ymx2S2cwd21uYldmQWc0b0xsVnBQT3Mxclg5WUFROE1zT1RNOWgy?=
 =?utf-8?B?K1NaVHA0c3JKRTNSNG5tWWd5R1ZhMUt2bGhiSEdEcUp4WncyN0NsRzRCNUk1?=
 =?utf-8?B?a3JiUDYzS2c0ZUh1S3p2UFI2dHUyaUtuRXppSTBzMUt5SHJabFBuVmxvcGRX?=
 =?utf-8?B?SFZKZCtQMWoxYktHY1JUWlUxZ3Y0Q2R4TFhGMWVuOHhoUm1lYUg5a2R4ZW8v?=
 =?utf-8?B?dXc5SXlPTWp2dWNGdmgxTVFVVG15eDNBY0ttc3R0VXNTb040eHFzQXkvRWFp?=
 =?utf-8?B?eWxzVHNLMFU1bEpNaEdmVlZ5eVZjOWFnWndQMUl0d2ttUVZxQnlpQ3FTUUtH?=
 =?utf-8?B?V2ZSWHA4cGRXcm9oVjdxMi9NVjNNZG1uYVpOVjVic2RsWEhybVZGZC9aQ1FE?=
 =?utf-8?B?WGErNXQvcm9aaTBJd3RDOFpNZTgzck1uK3dBYTA2U0paQjJtSVdJWXZtMHNF?=
 =?utf-8?Q?TqEsuPpzAPpjBVv9cq2fvSRj5Xum/Q6kvsqCdbBTmLJAj?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB469;6:1G35/0CahhFkGhiCuq3h6iPWS3AaXbAZyXOlt75Zxp2WAwe/4YMxD7q6R2U1f8CN3EW7hlPx49XNxIiCvQmnfETfwkO2CgxRoLHQBBxo+tAOYksN2vIj+vBMHv/BMAstY4kJLjrW88JGEnhdHCj3h3+Dk1s6kfD/wgVUb/+YzziKq9s9TWKC7thNLt2j/+vaalCm5F2yk111JauMFIh7COO74gFeKmWQHydexvRz93ZJ6GE+vtZIF6ukZHluGlylMzej1i+Wj8psUlvRSh3XsAPFhn+BVRGZ3ohqDmX0OxWl0bwmiAz959p2Vwj7BXAjNrFxCevQUgyQmZ/jwYQlU1Zour3CpLHotKMYDYPFplo=;5:89rBHxOArSXZQKbgkwZRBGnJIv/VaYamiiY1A8verMAzg/6Y838O2TPlsEH7/oKyuVIqaRtoOyfYirTLtJcNiVzxGfq6VlhJFHDN6abKsC4NYroJv7ItsfBeCF4tm2YsbM5bZICnMhCXbSJ+vT4T1AKEruXp8EeW8jBKl5W/8Vk=;24:X44qWWTYh8uSzaf8iSGkpwIsdh7alrkufGmHRHnX1o9OJbk4r9fQVAiv/BxYlBdWPAva+NPQ0yWjLGv6rVXK4Y5AkYUkk3xKuaA/x+uBe2c=;7:HymFTMs7f5yUyI1+NGTpHnxvsH/ieB7mXe7EZXxQ70/Lok9h50f3fwtDo2ExtisVSqMWyHFyIsNWhivflhmi7WEDD0/x2oazBwJylND5mMcLK9EXyFZV4wAd+HNL35nXdE8tscOknb9/8szDk9A1/2MM3ETJwLz5awBK3p8eobf23MlFXpPxt/cmUExmlGB8s09pSyxDYMlopgRHIxGOfpjTG4AocFQWjcyGl1xzjzgS/SOSK70+V8LpVYpbmBXA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2018 20:33:26.3851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1892b2-828b-49db-53a5-08d56a7c370b
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB469
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We support normal mode, TDM mode and pm.

Changes since v1: [addressed comments from Andy and Fabio]
 * fix GPIO polarity from active high to active low for correct documentation
 * fix license header by using SPDX identifier
 * remove debug prints at the beginning of functions.
 * only support auto clock switching (manual switching was dead code anyway) (in the
   future we could add a DT property to choose between manual and auto)
 * Use gpiod API
 * use GENMASK
 * introduce power_off/power_on

One open question is the resume sequence which appears to need power_off/power_on.
Just power_on alone isn't enough. With just power_on after resume aplay plays a
song for 1 seconds and then the sound stops.

Datasheet says, page 55"

(1) The PDN pin should be held to “L” for more than 150 ns after AVDD and TVDD are powered up.

Daniel Baluta (2):
  ASoC: codecs: Add support for AK5558 ADC driver
  ASoC: ak5558: Add bindings for AK5558 ADC

 Documentation/devicetree/bindings/sound/ak5558.txt |  23 +
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/ak5558.c                          | 626 +++++++++++++++++++++
 sound/soc/codecs/ak5558.h                          |  52 ++
 5 files changed, 709 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt
 create mode 100644 sound/soc/codecs/ak5558.c
 create mode 100644 sound/soc/codecs/ak5558.h

-- 
2.7.4
