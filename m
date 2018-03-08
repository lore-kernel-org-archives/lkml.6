Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932142AbeCHT6v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:58:51 -0500
Received: from mail-eopbgr10105.outbound.protection.outlook.com ([40.107.1.105]:7744
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751682AbeCHT6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:58:47 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 0/2] iio: potentiometer: mcp4018: new driver
Date: Thu,  8 Mar 2018 20:58:28 +0100
Message-Id: <20180308195830.16348-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0902CA0006.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::16) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13bb80ad-3a76-4386-9d3e-08d5852effb3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:CWNCP1xPFyPk4hoKODgdKyWfFj5Cv+AluSro9TvLeyncC/Hf+fbzdU5ETABZ5VYRzr6WtdrP0OlxQcAhhEViRoGZUN0TrZkLUpCjA/nArEbpnb9CZfqo07dfqIhjQgf66DJSEgI8lM9A/bfcER3FARvJpY6GzKzV/8xDizdPSB9pYgvZtWSzJGVpyZSuSg3ezKcVhSUvKD6RaF72945oI/08Z5on5K8PPvSqnQXZaLu+DMNhivcA5yyvEmd0hrza;25:QIaX3mJl4ch1yqKOq/hPNTVZ3tvG1erFgb97oO7jqzkpFZc80E/qiY4+l6aA+3r4D3B8HjMNjLA/21WUmyRmWdJ2bdhRBeWHQ3Wbk6PYJ0yUbznvluzaQFarjSvFevaqFPLtN9PLfLiGaDnev2HvfEZHjaCorEzdAds5k30ff4XvekTC+rUfWeLQ5rX3VQRGmVh0YEMJNPo1b941EE+7Byr+b2QRUMYlcCmiKORmeB1ZT8ein0dzPXOe89C2psLG7g4szLkNJ22jLqs2l1JY2FjmS9xenOKNz/d3C9MnnZtCA1JcHY99Wj1BWFyJhFp8jaG3+i2sd+FSW7moBWN38Q==;31:MZs5wwPEzCnRExpsuYVU6fViXFqhOXFsEnQUEZk/NY74233GnvFjSnJ70UnrTUwlEkgs0j6wy8WbEYdNW/01q4AYFT4oO+7B9pmqX9cII6ajS1DtOPS72r6mZN7NrAdIgn9J7jJ3cLZzhmDjP4vENmYY5zpJeYMOTIRoCntZJhbIFEzGl9Nvucisiudp4NY803AcFixF/ZqHtHfmEwhXL1U5PsiJjDwf8X5bnY+h8KY=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB277278BE68C72089020B7878BCDF0@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6041288)(2016111802025)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:ooWHXZAT5aKh84OVCpM0mROjL8vS3gTipZbhbzIXPpvlYZuw+t0zDDe3Tq/wv49CwNmzC+gFibqDpQr+66msraz/gOGfg64OXgqFaCbJ1xetVFh9nzWw3D7nHCgVFp0oRI2WMcrsbzuqeQ0JwHSwkF8JxAMP4k4LWy/yxYroqbI91tVlAI53Rqz5Y/HgkVWJMPiKW39uOvi3JhJON30Xq+sqY7jUoezv7J81+hkzOtHQW2lkizUUsow1A2NMkrFYE2NA9jnHrU4X2VqCMVMQ0g==
X-Forefront-PRVS: 060503E79B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(39830400003)(376002)(39380400002)(199004)(189003)(66066001)(26005)(47776003)(81166006)(2361001)(81156014)(59450400001)(305945005)(6486002)(7736002)(6666003)(8676002)(186003)(6916009)(16526019)(316002)(106356001)(8936002)(50226002)(74482002)(68736007)(36756003)(2351001)(6506007)(97736004)(386003)(5660300001)(51416003)(52116002)(105586002)(4326008)(3846002)(2906002)(54906003)(6512007)(86362001)(478600001)(48376002)(8666007)(50466002)(25786009)(53936002)(1076002)(16586007)(6116002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:ZXAwsrAXjM7ncUgg4MNpgg3lBxf0NxLUVBJHWQK?=
 =?us-ascii?Q?oW7UsJWEmqN3pl412BAJspredqh3EhIPeZiMJ07VypM2YcLCyJHgrhtfiWXH?=
 =?us-ascii?Q?LZT1UPhFb0cger+KYWw0skAyLOhIFSUG18BE/ci4txnuWOyyjlZn9KMKTBjc?=
 =?us-ascii?Q?2bqUcLY2FyVdR/Oi/a/c4dguUdAzNdSlWuUZBGL2H8RUnFBPZ4TPPOmjS1F6?=
 =?us-ascii?Q?rqV53WsN6v9vYLlTsni+eDSujFne0ZYGimoxlFsnz2AO8DrCMltB92jF4iTF?=
 =?us-ascii?Q?L5pf+HaowOtwMTDpRQos8hrOv0K8i6oBbEHHTuON+DfChY+gNmfcCaOEMMHe?=
 =?us-ascii?Q?tTl++/HSacU+gXgDOZJkFlmyBJ6bTRRmreeZXE3YqX6GyWH3DG1zpuyxvx9Y?=
 =?us-ascii?Q?GQVcoss0qqzaIjpTE09SPGwYd+nNpigCTF2P2CEcCxWIQxXZ3kshCrHVGvDF?=
 =?us-ascii?Q?YJTwKYHN08wXWxxdmJYxD3o+26It9gWtmUW8RUdrxeBedtN3XVjSVF/dMmU5?=
 =?us-ascii?Q?aPAv4u8ucIY1UxO4OTSeqNFcUboCovZascAjFddVIuS+WOQfCGGrvLzSYSzK?=
 =?us-ascii?Q?kg8AwqL8PrmfkDCef3gMwSm2/3CGMBkt5lOva7/bp6chipBssxCRrp5DVdFK?=
 =?us-ascii?Q?nDhk29mhCVTdoTS43gZQFhh5K8xshmL/M7/KJ2XQn23zdGj0m+Gbd1Vcnr4i?=
 =?us-ascii?Q?oiSR+pGoLzTDMkF5eyeABzyNJD2rZTrwf1uF38zIAuY/CEI/qBYO8FFT4QL8?=
 =?us-ascii?Q?jXqYAPfmLm8Jpzt5ocPyqX92Yc3wHCqz4cwy2oXW5x4bjXQyEy6KaftwOT5u?=
 =?us-ascii?Q?SrwrZj6Uw23qtfoNdXAbSGogjk4aD5BxmZhGzcRwBsbNuv6BoSeYm5SWjAI9?=
 =?us-ascii?Q?Ryi/kVez1BRqDgMQpdkLx/JUv7+SrJWbnymKYlfqdXv4L/z7pCLjvNQWXw/w?=
 =?us-ascii?Q?8dAvz9lqB47FDpmaslucV8NFTsFWzMK4TOkgWpluJgNdT3qFJ9TM/x54r3Gq?=
 =?us-ascii?Q?YnFXKMKrnva+Hnwlji0klej+QZp/Dmllz1YIf+wVanTK06Qb4kaNHoyvxtjY?=
 =?us-ascii?Q?RbsYo+rvmTzXzBUzzfHoxLCDySXiyI5gDhLPw3cQjECKewLhThXKbwupSRpv?=
 =?us-ascii?Q?BV/RXMY1Swlc+HXPpXM6ijfAYRvPgskd+4+eCpScnN7AyFgdbe08NvLU6zAC?=
 =?us-ascii?Q?ZY2I348k7YwdfiURKyqQ7oAqHCGTtc6rWEG9YIdz0WhF6aba7g6fKZN7uuA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: acy7naH8nCcX+aBjaRmKm77DaniWE3YvsSzfmyVu+RS2OeiUBQ9LAL5q2Yfw0RiPBEE9mcnIiTzfBImhebqLSj/Vz37FHLD4PS2deIwHksS+K0S3jA3jV+XhMI/y2z7AmNct738CXMcDEpIH2G9yklyCrRlHQJ8nGd3eag8LlV0wkpuAd37j+ltEhucxXaa2
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:UEuMS9t7katc6Iz7buHj7aL519xciWKRWeANG7p+W+q7V8J/mB2PldDulUHum0e1j5Sv6Yn9Vexjb6xQ2yttm52jpsKpkZh6fKoIThmUYBPLRidbWtjqr/nhqsYE9C9L1Ol+0HD/Z2RUDiNTUW+g7lqETTzJLwRp/CBZ55TOZo8THRU8O7cMzq/qfgHFC34ZgtEiYUg+n/ZesjrRMABig3etY1x9FOOVrAt6XDEqoCe2JfAc/sjZ2GhunGqGFkNKH/uqwbjjsIwi6xn1RtOUdLgff+/a16EOEe8kvMbPvYMUToqH4hwCNxkMM5CuQOzfC3w4HSXEWxtKSy1fWXKA8XV6RjBNtbMUS9TFr9wEm/w=;5:IGgywyf69bVv+iszj/LZq9MwiIPg/Wycm6lF2dk1Cc50l+AbUsmX1kl7SUdPAwR5/B3s/wNC68PEvJIHzYOjfv5leznmzTFDFyL0il79XUYCAw49AliSPgmXwWr+QkmRSgYtX2bPgMuHZwJEP+dPXZ66OK0tBDQt+hqjjkf3R9A=;24:8Y1o/gNYlfXOacBrGmYPczXDWj51t1O8lomovKvghsAr3Lg2dqI2TGJoZEJpBSsC9nNTvRj6sqBWY73yg2eTjFkKheAwC+1GzNe/ii+amnU=;7:cBKVWvDr6AwqiVBm376Gkz9rY4HL2mWxKUrtntKo3rnK/AJHZXpDVP13nI6l6SN8pFzv0L5Cq8Oi3Q6RtL3unhMI/VIhrUqY5oe1bVCQYHhloxFZZGIDefjlwUSjM+qsBCz4d6nJWQueIT2hg2vru7+N/+o+s/JGc9rtcVvNPnuFOsPgJdAjhhbBwUWIBVwqSZDhcxhiyGx2KACU+12C5oyvMz+Kd9xAdBVvgqKj8Afz8C0tw3DSNDhcYnlAND84
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2018 19:58:44.1338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bb80ad-3a76-4386-9d3e-08d5852effb3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here's an iio driver for Microchip MCP4018 potentiometers, that
also covers a few variants (MCP4017 and MCP4019).

I found no existing potentiometer driver with a compatible
interface to piggyback on, so I did a new driver.

Cheers,
Peter

Peter Rosin (2):
  dt-bindings: trivial: add various mcp4017/18/19 potentiometers
  iio: potentiometer: mcp4018: driver for Microchip digital
    potentiometers

 .../devicetree/bindings/trivial-devices.txt        |  12 ++
 MAINTAINERS                                        |   3 +-
 drivers/iio/potentiometer/Kconfig                  |  11 ++
 drivers/iio/potentiometer/Makefile                 |   1 +
 drivers/iio/potentiometer/mcp4018.c                | 194 +++++++++++++++++++++
 5 files changed, 220 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/potentiometer/mcp4018.c

-- 
2.11.0
