Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeBEUVi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 15:21:38 -0500
Received: from mail-bl2nam02on0089.outbound.protection.outlook.com ([104.47.38.89]:64640
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751103AbeBEUVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 15:21:00 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Daniel Baluta <daniel.baluta@nxp.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <wakasugi.jb@om.asahi-kasei.co.jp>,
        <shengjiu.wang@nxp.com>, <daniel.baluta@nxp.com>,
        <mihai.serban@gmail.com>, <cosmin.samoila@nxp.com>,
        <linux-imx@nxp.com>, <fabio.estevam@nxp.com>, <robh@kernel.org>,
        <andy.shevchenko@gmail.com>
Subject: [PATCH v3 0/2] Add support for AK5558 ADC
Date: Mon, 5 Feb 2018 19:01:53 +0200
Message-ID: <1517850115-24340-1-git-send-email-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131623356574651472;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(396003)(376002)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(356003)(107886003)(26826003)(305945005)(81156014)(50226002)(81166006)(8676002)(5660300001)(86362001)(53936002)(8936002)(106466001)(105606002)(104016004)(47776003)(336011)(97736004)(36756003)(956003)(316002)(54906003)(110136005)(4326008)(450100002)(85426001)(23676004)(2906002)(2870700001)(5820100001)(498600001)(2201001)(68736007)(50466002)(6666003)(26005)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB1421;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11OLC002;1:7PiSI/2hUVnUhJVNJhkyAfDEG5raNMvy3tJd9imwymUT0uqCIq79Hh88MV5PyXlJVRjPDTeKQBRLc+sTr7HYqEkuSbxQLV9Wqm95Zf4zDoVtog4zHdz2jyXvN9nCSRFd
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4138267-00ff-45da-c958-08d56cd5f72a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:CY1PR03MB1421;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1421;3:YxSAz7QZSwAr4YCu5u/9I5KqrHah7oaMhwYz+DnhyGNkleploKBHjxYbHMVZ0nxj2hF+kEuMBuzQKh3y1OX/5z5VoqgY+EFmdaX3AK8gfJe59mDtvcjGn5i6eauGO+JzlHHNBUaWubiioCiPTW1KZA4bjEtXl6960fEaJ8TbaSyGK6q8bZ9O8bI5E6foKhQ+3oa12e6tafbyBLuUUwLJy2Q5Isg2J7KAN7Eh3jHxdAWFNqEMdFKqzRpfGSpASLzKcgASPYjHKfHOSZYKhLfD1rjXdmQdl7xkRB43cWkn80yZa5Ev/ZdnhOIdGFIAU3b0FCZZifzJ72tM1CohxZVOH/aSNaUyGPPDWGPAlD5ATWQ=;25:xmC8X2d2dsJTmARXsup7l6vkUSlGPezsjETM2V1X3S5V/n0SgLwiT53Q2+MhWzzBR/itpJvHX4XSC3tRSBjZApgF54E73jU6barlGGugrCJnbkN8G+elPg6M17CMuk48BmL267ARN5S0R4ibJFYpdAnDY4hNviDMq58XEJ1ey/l/E5fe4xcTaWDt4XBuzseYf6Q6F4s8cqMS5nL0w2lZxA3Nw0+MGz7qEImwGHh33a/O4haC4YaRhKJvOcdY5GcPHFX6lkMnHxHZBRFB7bO1gFiOXKoJ3G25Xhmtt1oP8XFuZ7L1Ac5aYf23HCwbBo93Fs3+5tFaf/KGOKr48o43CA==
X-MS-TrafficTypeDiagnostic: CY1PR03MB1421:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1421;31:xNRebu0qpIVtJhxfqAHVD8mUPI2Qc/bmREl27YmcCl9EZYEmX0TCTM3uOtltXVTP+5LhBNj/8PWoYlBxkPyPFe7ptmitYuQ9hPkBnaCMlLzpURXeSWRZp6VhXRxi+XRBqyjc76KMs2ByDi/okQ9UgjBQzaPQFxxjw5+ygQIa1S4gz2h1yG+v5lseLLquy5ONPSev6Zo1SStC3jonBYHigTSR8XANWoTd5UkJNYeP50Q=;4:xrJ6sAaaA/QMFN2YiM4ucGqDuK4gqVCoIm4nwvu/P8OpndZEI+MRrozLJ533Md7QR03g2ZZWWj7HwL4qwymz3m7qulSj2GFGAROq+9Dy1bd2Pb4pwbhxeMPjL3niyM0CDV7zcuA6N0cAUFIgtzCKm6bxR1MH3TbNW5Aij3ru0EnpRrMjyopsEN3CtyFk9Lg7triQ1jjDoUG84kQUGTlb1txm6dFfXx/h21Fcwh4w1qRYQKZPqojKnaSisSfgK1uGOOSbv8IPzVkqm3aIi5D14w==
X-Microsoft-Antispam-PRVS: <CY1PR03MB1421257392208828CC4539FAF9FE0@CY1PR03MB1421.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(3002001)(6055026)(6096035)(20161123561025)(20161123563025)(20161123565025)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123556025)(201708071742011);SRVR:CY1PR03MB1421;BCL:0;PCL:0;RULEID:(400006);SRVR:CY1PR03MB1421;
X-Forefront-PRVS: 0574D4712B
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjAzTUIxNDIxOzIzOmRhbE03TFFrNTdDNDN0SFRncy9mZjk2Wnow?=
 =?utf-8?B?a2pMZU96d3RHL3JQSThoNEhYa2l5Z21wbkR0Q1VrbWEyU0N1NG9teGhqdHZz?=
 =?utf-8?B?OE1zdHpzQjNNM3IzZU0yaGJwMnNXZGdyUjl5bjdDcUsyQXVpYUhvbjFsR3Vn?=
 =?utf-8?B?dW10S0c1TkVWOFNtUHYrTkdKaExVL054SjIzUGZBWkxPVktzaVplSG5GQndq?=
 =?utf-8?B?TlNxbS9qSlVLZm84VjRCRkFsZ2hkOVFEOStERXZNZFFBTGF4NTRnc0ZGQXhC?=
 =?utf-8?B?SGFwdmQyRWI4azBZYUZSblc4U2EwSldndElLYyttc3dKRXl2K3ZrMnlUMjZn?=
 =?utf-8?B?LzFvdDd6UW1vbnpkZ09hejh4U3BFaXh3eGJ1UFhVS0YxeEFJTmcwci92eWtr?=
 =?utf-8?B?YkNvL3JSaElGbVhuRGpWT1ZNSFVKZ2FCZ0Nhck1sS29HZm1UZUhIV2xWWWRx?=
 =?utf-8?B?MHN3b05RWFFacXphNDZEcXhLeHF5blJBTjVBSVZ5dDdlanRKTEpnanRTMENO?=
 =?utf-8?B?bi9UWDJoWlJ0V0h5MjJoeTFIakwvQ0xZcWNFMVVaNkNPVXpoNXlENFZnekUz?=
 =?utf-8?B?Z2tIUXBMTXZUVGRRak1FVjZxTXcvKzlsTzJ1TmxEejR4bEdVcHpKMVQrVkVO?=
 =?utf-8?B?N2VEbU93YUNNNENPcUNtSTFXOXhTbkhQMEl4N3MwdXQ0emdERU1JcktDT05a?=
 =?utf-8?B?TXpsa0tmeGsvTS9aSnRTdmxha2d6NWRnd2NMK0ZIR3FEMkkvMG8zdnNZMnFk?=
 =?utf-8?B?QlUvYkQrNHJyTFk5Y2k3WFlOUXEvUHhzUlJ4bXBBN1Q0N0NSbGRuWGY3Q1JG?=
 =?utf-8?B?VGpibXUzT1JaY3BldzFJZ2VyVkR1R1hlSkVhZGtPMmRQaFFZR1RsRG9NZENu?=
 =?utf-8?B?NmdyVThkUUcyejF0TG52QVhQSHlYWWJxdFcrNHp6NG5ZYWF3QjE1alJPVUM2?=
 =?utf-8?B?M3J2RWpXU2JxSFk1Z0hWa3FSTENGMk1xS3dVVUZNNEwvOFFvNDQvN09Pdk9r?=
 =?utf-8?B?L3l5VFkwYlJhTnlSTDJjUVk2VXFEejlnR1U1L0JGTkdqYnh5Wi9ERVZwaklz?=
 =?utf-8?B?TFpHTmJYcXJ4MkQ5U0hVcnZsT2NLbEg4MUVMVmMrRitzU1I3Q0tDaFlqeUto?=
 =?utf-8?B?ekcrT3NweVFQQllSYUx0YWVNczJoMkhXaFFZTGlaeHE3dGdEcithK013bjNo?=
 =?utf-8?B?RURZblZnSFZtR2sySmVQbG11VWNmdDJpQ3h4djRGK0V1RFA0TDRrM3dwVjNF?=
 =?utf-8?B?OUk1STl3YXFhdlhTZHYzcS9ibXppVGQzM3BrSzIvbGRIRDdna0FxS0xzMjNp?=
 =?utf-8?B?OGFqaElFUTBEYW1TazBTQlA0b21tM3hLdTRPWnA0Vzh5aTdVekJaeTBSc094?=
 =?utf-8?B?enIvOGY1YlI2enpHMnh3Q2JzSFN3RUpXRHUzcjAxZy9SVDdHaTZXUG80WDhh?=
 =?utf-8?B?QjFLcXpWeEpRby9ocnh6Q3ZjQVJ6Y2pHM3FhU3Btdm9DUUFwaTFWN1ZzTFht?=
 =?utf-8?Q?X0QlM5hFHJZFR6pmXgDwhyvNQ=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1421;6:IKsiEWJ0t7JGvYLtXkqQGT7gaJJQZ1q3AAxuRxHiTfhnAzqvYB7pt5W7Ya8dv9Y3M/O8d9dHzc/Byz0sJVILmnA5eisuH/vw8UmtZHyoc12FVktqHH5DREcKRBtxyFHyDiPjsa4A1qYD7z2sgN/6zqS8OcyKeP/auhqOr7JzugIAivAi/hk6XkfmgmYTEKNaGiBar5wt5Z+jgSK2lXWbOBLEkoz3fLWU/bYrF4o0F3bMovv8noachscluILKCmp6gX3zcclzl/8wUqKwtieEwujZJrhxGCDSm3bEw7iBGa6phR9pnNctpDlaCabPNLhJ+7ZwGR/DurAvhjdFCPx+X7Q/kSKAG0NZSb1kdjYRwsY=;5:sJsm4e1yBdbLnFzjtYkT7Gp9K2wmzbSVx7Nra58im5O3QvBa8NPFPX9x4vdGsR1auGIXlXR9uLm+50XL8ospbhIiQ/YgINZq20id1SWJ6MgUFFpvxqKSKADx8SB6kINl4EYnDvyY3vNUPzbW0BRIw6mF2q6P57otK/sljm9vbLA=;24:p/BwdraxrrlASVWpi9er8RblrmfX/hmDVAyA+mEb28YVGV559czB8kiMcv0+P4zdENmnIZzQwg/4DFIhO/TCq9LH/5ZUVnhvPdu26LeboeU=;7:Ivy66ORf/tBtQfLEKuBRKAYXDqxNxieV7uvXZ7cDFmPadg9S0dowyHt1MRGri60qifCdHvfoDgeDqDqPP71sqY0XQRtn3Kp0x8E5ti5+tTvl97bMozIZenLLj6kKKNlI5bhyBIfglapmWeb1PnTNRkyS2P5IftnzGkuJfWojOOtfdavmxhdMw3b+f6GoMlcwNglyytPZSZKmQSik7rZ+gGmDdix3SzXAwpnuK9TNU0rdlvLigw/FklSIi7+TuthC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 20:20:55.8895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4138267-00ff-45da-c958-08d56cd5f72a
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB1421
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We support normal mode, TDM mode and pm.

Changes since v2: [addressed comments from Andy, Fabio and Rob]
* sort include files
* use probe_new
* reword the binding document
* use adc@10 instead of ak5558@10
* remove file name at the beginning of codec source code.
* make i2c_probe and i2c_remove parameters naming consistent.

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

 Documentation/devicetree/bindings/sound/ak5558.txt |  22 +
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/ak5558.c                          | 618 +++++++++++++++++++++
 sound/soc/codecs/ak5558.h                          |  52 ++
 5 files changed, 700 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt
 create mode 100644 sound/soc/codecs/ak5558.c
 create mode 100644 sound/soc/codecs/ak5558.h

-- 
2.7.4
