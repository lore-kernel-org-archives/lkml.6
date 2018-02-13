Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934828AbeBMQzt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:55:49 -0500
Received: from mail-co1nam03on0078.outbound.protection.outlook.com ([104.47.40.78]:26704
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934561AbeBMQzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:55:45 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
CC: <mihai.serban@gmail.com>, <linux-imx@nxp.com>, <shegjiu.wang@nxp.com>,
        <daniel.baluta@nxp.com>, <linux-kernel@vger.kernel.org>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH v2 0/2] Add support for AK4458 DAC
Date: Tue, 13 Feb 2018 16:14:46 +0200
Message-ID: <1518531288-2017-1-git-send-email-cosmin.samoila@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131630145429392349;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(39860400002)(346002)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(81156014)(104016004)(105606002)(97736004)(106466001)(8936002)(5660300001)(53936002)(81166006)(50226002)(316002)(16586007)(4326008)(110136005)(54906003)(47776003)(26826003)(305945005)(50466002)(956003)(498600001)(2906002)(356003)(2201001)(336011)(26005)(6666003)(86362001)(68736007)(8676002)(59450400001)(48376002)(51416003)(450100002)(36756003)(85426001)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB480;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD022;1:va2Tg9RqvwVoN0NuKsPeQ8eDI3MF9Zor/1AlTqLkMY19L1DOXwXUrtF6PFIQCasFBubzkBK7zEK7N8QGt0T2/H7myKgQmBcTe6yUkQ2jDKPYhqZON8vHtaQ3UVnjRfFV
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cb8b41c-7def-4591-891b-08d573029e7f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:DM2PR03MB480;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB480;3:pGTePPi5QzTrBDc9jqj85G31NXV5Nkjj+xe9zt/sSodFiJ9jk0JMxh/jv3RSxjKGjDxp6e2H1D1ecF4CYr4+O94GS9gjnzt7OYNcjrUMUcAsp2luzomH0HABA3qUdpXOHum3yhMTOMI/tv0dSw/HkNKdTlyQIgBrEehqMALAwHXbXFqyPPwE+UW1qj2+S8CeCNuNlWAIlLmSJXzOvgSrdwO19M6fAKGN5zOgDAHaSJ0YtmyxQQKevarsX9EpYsdXro3meqkqRb1caNF67sgIkYbBqizyYfI4QLeAPS5QKnkQymVSI9UCH8H1Rfbae9oUiytmcvx2rKQqRBvSBVSqmgqfB/Wqb/72NY+6x+zjUjE=;25:IrcHtI/3eFv6+bRIMF4mhM02z2/cVBpfFAa1NkuOmb+aw0hB+ai8UUslBTbO0jCcbvUzO0i/asyXYI+7mhTWZcSTuyF3LRA6R1JPIXx66OG90dW0/dEXvfsyRTPG5HqfUpJzfVdYNqu/43epkNy16WaEPdHi2qDqlljOrNlge/JQHIKDLjv6q+QsR8Z0MfGvKlFG+kNLXgnDkns0a6+U3/EWeOTYdiOdKYzgn5JkIxo3AOg3h1BfJIQcjj8xi5yB0U0FIkKtrGXctS8VXXNeVknx4aSLzpVb3lamVoF+P6WhZILw9yKIhl0K48+rtzn4nYDNTGHu1TNlBfBL6e+xEA==
X-MS-TrafficTypeDiagnostic: DM2PR03MB480:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB480;31:oe84udcF9YvW7XG1GmkljAhWWGWfOgADgdCtDnsGWryoU68OrjzSO09rRGyL4RFbGvmzp31L8nHXlaOv0S+VbVSNQiUcSGWqsHtyYLZJwIHr190vo2DnmGMGoMVaJa9BzLBsQQnLXLzkzNlj0xsczp4QoHS61FQDxhkohmJUe4E67n6ABYCHKBtHXXEFliKYe3Mp5xmX3bwddQxogO06fWO/A/9xkUyOPeADI1wmEEk=;4:UBkpAKEXKRCNI0NVex5nCeHIENX5V5chN+xHpetw8SwJ+vwL+XYfa5ucrMJAQ011rKib5OfhohA35uHRLUtbi6Rc2PcEBaqHO0hFlHPT0Xf81ms/5TA1ap4s24WTGblUMKDzuTC2/YyNwd4OtJGiuzcLNV78ayrvkerApMt7+vz0oRFG1dLsi9mV25O4XAbJKuowh5/Dxblo/VZlVvVDsiODOm+KuaqtFTXt3S/SOHhIOeWqepkJTIYTZ8UaDCNALIwuwWAIuxwE7mLYegXo6w==
X-Microsoft-Antispam-PRVS: <DM2PR03MB480A4EBA2FC4A753BDFAD049CF60@DM2PR03MB480.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6096035)(20161123561025)(20161123556025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123565025)(20161123563025)(201708071742011);SRVR:DM2PR03MB480;BCL:0;PCL:0;RULEID:(400006);SRVR:DM2PR03MB480;
X-Forefront-PRVS: 0582641F53
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR03MB480;23:+MQQQtcadPI71gQt8rpmFBHfwsfk4N3J30as5v6NWQ?=
 =?us-ascii?Q?24IfvZCX3r1ljF8yFuoKpkFwLY/NqJC9Umt1AcBtWLkqNmXIsNqvT8QWS3yl?=
 =?us-ascii?Q?N9lqB7G3t5N+X0w/VxKwPA4j/to0P95IJqFJiyQiHdy8iht6wHK+5TPWJ+iD?=
 =?us-ascii?Q?KDmyjSYfrBo/EYLnvKrxy2SBKJ8e41YA03StAoyOfwOjF7HWKDNQXpMccqoU?=
 =?us-ascii?Q?qMQgIG6Azd1EO+Z1nkaaTyJeS9HYvYNJyueQML2G75NJGPRsx8iC6Z1wrQkP?=
 =?us-ascii?Q?rvwaEhdwZ941B8DF3QxSRM8AAthDqA5pKIFjcyosIngumf1gD2NReG0mQZUN?=
 =?us-ascii?Q?xnAN7Su9piVTloBpIZ7ApYALOCc4IN32qYVSMnRIa63i0wAPvfSuy3fg0FEf?=
 =?us-ascii?Q?Ipi5oLm2WOyBpx1b+DCVi1op1sRzA23OdAoW6uEiH59BEU1AZZNjelvFTO0y?=
 =?us-ascii?Q?neB6Q56NMP/8Bgdnb+kGG7Lg62HnLanuhl78q/NDuI1NyNofWeLRuwxN23yB?=
 =?us-ascii?Q?H+ZjSWIKw03AbB5/6/gG6VHCZV4neEqnuOXRDbhej2Nz8zYVORtXxSzMUxsf?=
 =?us-ascii?Q?rugxGggxJ/K3Sg/RP0xhvP1Q1bOeTWdRlKWwJaHzy+XH/RvVEsZsGdDNxyp3?=
 =?us-ascii?Q?2XmIVLH4oExkh17JIBoFBhW6wyGQgDKQQSf6Az+toVtUxhDbHD9T2rU7f8MC?=
 =?us-ascii?Q?/yu9M/JwSp1cdgnMv3wVB0EpPCMfA+MmH/sjwiJdnD9SQQ9a8Bt1NZJmeYcl?=
 =?us-ascii?Q?OM9NdVjdoSCQNgEqH+jFX9Wxzt7+iETSUcOK0s4fy6jh6CPbICcKRFfTQQxy?=
 =?us-ascii?Q?3gmyOUR7RGbz50dFRg6i5deCFTlrMOCB0wWh1x42EvA5MGaTuOb+4Y205OAL?=
 =?us-ascii?Q?wOK7UU1XCnNfg7t4ldP6t+3C/UNLQvCCqbOccxj9Mo2aQTIzaooklClavZky?=
 =?us-ascii?Q?TyWh7MFfq3siyI6XaxxApr8DWGtvP5CFfvOzxmjcCiVYsYfWafdmVtT12ppU?=
 =?us-ascii?Q?IXWgxRwqBT27IRrm/vM1360XnztYhVdoFT3Dn2lbWYyPxq/6YI3N0VYxPNBz?=
 =?us-ascii?Q?aq9F3qXue0tOvAm8QF2dIopExEvR6WSWYRxxBOagnQnPzi8VKWG0S4X1axJY?=
 =?us-ascii?Q?cUTfOq6b4=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB480;6:Yp4iN50WVhdBaAQHN1ZNWJahPq10wZ1BAVQ1uOnLg2UEQFNAFyRK9Tw1cVbqXvQQ6DV3iWXQck6blUdBMDK2bAIjnma3ksW3P5msoHiV3Cceia+de9A7U5I0lIS/UAXhPmTIm4YmzXn/Yiu2BzbQF8UZBMOF7SmUuzw/w4KSkagRElF5mVOvrOdwjpAdDljdO/4U2PcgvKvUPVBL/eKBfuZlOZ/I+59+e23FUDSmj+oVJNLx6ujsAROyADkdF5L7esBJtsBPwPFs9AMAr/lH7NhRcj6/Eq1Tgmp3+POPbzYGKQb/X9dlmcN3u1MeLY6hPGbz5Mrh4whj8set5zDHYQJxzdJkPx0Dk/aiqyKC0Vw=;5:ZY0/zMpInRuV+LqoqGd0rFgMotaG6k8yLtrGRBNjtTZ3czZRyQ6sEFkplGCv3MbwSZLLas4nBwWbOWFw7XrAsy3EPt/e2khFwIXnplIQJsUIiBp+DgI2W/JnaUIPFcBuic/eB4IB7SaoGNGoC+F89BD6YY/6Oopn/cgxM3EwoUM=;24:b9aNDz7V4UPVqPgZ9hjctWEKbJq6w0RJLMKM6stQ1RXrbuyk9Q0yWCnRtdZwRyvgsSy2SBh+o1/9BC0yTGSJRVnKFsmML7dayV8yHcBiJck=;7:4MsItBaQozILCpGx/PU0oK1ynW+09Y5s/TfIcYQl3WkJRzpU2jpTcHodvldCehgJnB+CAn1IhgANz/kOf87CW7G37EdHiW1mAbOnh+s9P6xRIrI1rrx3rOEI4w3PhEymoB7PNZ1OVrdbpFIChb+g6kCJeN8vQHIL4epi1b+9dFKYn0tv573VazvW/Fzix/UUkuwVz9VokDkc5grLQNXU1R2TJCBWBFT/r4dRu9KhlhCFEj4vsPy6Jy7V4RR6l/zi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 16:55:42.4400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb8b41c-7def-4591-891b-08d573029e7f
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB480
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We support Normal Mode, TDM Mode and PM.

Changes since V1:
- support only i2c
- i2c probe / remove/suspend/ resume moved into shared code
- change enum array to separate variables
- aggregate Volume control for Left and Right Channel
- remove mux from DAPM
- remove unused functions
- remove unused controls
- remove unused macros
- use snd_soc_update_bits instead of soc_read + soc_write
- use GPIOD
- use SPDX identifier
- use dac@10 instgitead of ak4458@10
- use explicit power_on/off functions
- add __maybe_unused attribute
- use probe_new for i2c_probe

Cosmin-Gabriel Samoila (2):
  ASoC: codecs: Add support for AK4458 DAC driver
  ASoC: ak4458: Add bindings for AK4458 DAC

 Documentation/devicetree/bindings/sound/ak4458.txt |  23 +
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/ak4458.c                          | 684 +++++++++++++++++++++
 sound/soc/codecs/ak4458.h                          |  75 +++
 5 files changed, 790 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak4458.txt
 create mode 100644 sound/soc/codecs/ak4458.c
 create mode 100644 sound/soc/codecs/ak4458.h

-- 
2.7.4
