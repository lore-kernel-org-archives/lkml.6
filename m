Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932586AbeCEU6o (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:58:44 -0500
Received: from mail-eopbgr20124.outbound.protection.outlook.com ([40.107.2.124]:49554
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752995AbeCEU6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:58:41 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Adrian Fiergolski <adrian.fiergolski@cern.ch>,
        linux-i2c@vger.kernel.org
Subject: [PATCH v2 0/2] check I2C device id for pca984x chips
Date: Mon,  5 Mar 2018 21:58:20 +0100
Message-Id: <20180305205822.951-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR07CA0026.eurprd07.prod.outlook.com
 (2603:10a6:7:66::12) To HE1PR0202MB2777.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d2df70d-aad2-440e-4649-08d582dbddb4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603307)(7153060)(7193020);SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;3:Di1kePZzAijsQW7WierRR3quLYcpK1NWVnLOnTseOw7dg7soAVbQfy6cFpVmQAEuP46TvNhapgEinx7ctwEXJ9tGqVuARZ+swbhVKZr78TzyOTbrjgNWGugU/zs1/Kki+hxObfXCNE2a1UE71os+lGrkz+eE1zdi+vDTamhaRq2te8tlxoJ746W66G1z4ybZh7Pq3Llmlp06QSdFaZoZQ9+ZPiZhWllJoyr9czPDMQfcS6LZyx8lOiVE7y3KwwYB;25:FqL2lDMaBf/r9vpEJi4MKP0GUpnVp7/iTcqdTwwmwuj2gX7Enz7+C8rjygHl70yig5bIQ+xJ9gER11kJWuCR+1yt88SFhdKf7urx7gIO9iStIZi1Di1nw8PNqrKVRk4BX4xrXZHOItAW3iXGJCoKtGBynULFpLuw+C8fq8IGl9rBGWxdjqdp4F9D7fZCW9zpXe2tHm11HUiFfekLzcIWHpPO+N4Bh/ZMqjtVGPu2SUB7dB/MgIEGuTOiluX4JgLt2TrGGlstMkj5OEgSw/85XC+dQfe413p/KmTbKavXeATCaP3zEAJmc3/jOiPtFb0DMt970NjSEm0Qm0HPC8s51g==;31:kgyhKYQCyOh+81DaAFhXsRdShCuQcWRYL6LuwiDDSXpuR1J7I+9FRr94Ytd01aj5fYvKZ82yNr9TtvVbiEnNtslLR2DPXa9c23wn/Vbsajjd/ipLQxXaypCX0cWRsu3qyZjnmJ29LWl/Fpewy5GufUOCp8pul69M5V3eiercs8f5VlIc71Slvcy0iGdopTuOl5hdYjpyP+wqM5s3m/75rUJLXdSoX8W2jSdRcOEqHPM=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2777:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;20:hNqEgcuAtz6fgG4mr91HM8HXf9SByUzlJxv7mVxrW+4QChaOPI6Rpl6f4Dp9KQxt8FSp4Te5wTLNkucOb7QJ0A8/T5YKfI8nLM8gN09jOSnQbHLg+0cas5TmsGn0x3n3rlWh/PZ7K+zYGNNeRgpBLLtC05xsZGJSL+yy3IGNGfA=;4:cbMBHFITU+PZ1PMWXl96LwDctB2WF/Ljiw7txwLJ7sEM86zF1DkIjB8h6opKHcnrWO8Lv8LPCBjGF9D4vlUL/xjtconrejpvuUA7qkrAUzkHx/M7tnBf3dypqZqcmeCdlsU0kTxgzoSNmdj7hMNZZe20ZGo2SgYXLLD631HaiKtCtDRowUAceWS5qHB5NuYwvw8nZ+q5gfRZfFqdOrodaYxMo6+uFkqxsxvxyuPNU+sny7erlRzPF3iOlv9pcaNxeXEWYNzJKAEfdDG6fqrEUA==
X-Microsoft-Antispam-PRVS: <HE1PR0202MB27779E84E0B83AF7990847E8BCDA0@HE1PR0202MB2777.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6041288)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2777;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2777;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(39380400002)(376002)(346002)(366004)(396003)(199004)(189003)(59450400001)(106356001)(86362001)(66066001)(6506007)(316002)(47776003)(386003)(68736007)(478600001)(4326008)(5660300001)(8676002)(2351001)(7736002)(186003)(16526019)(305945005)(6666003)(25786009)(50226002)(26005)(6916009)(8936002)(2361001)(81156014)(97736004)(105586002)(6116002)(3846002)(74482002)(1076002)(2906002)(6486002)(36756003)(53936002)(48376002)(54906003)(51416003)(6512007)(16586007)(81166006)(50466002)(52116002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2777;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2777;23:GlOgn1/gZAr+F/Xn9oTRwo5XT0+7lOPaVcQJPSN?=
 =?us-ascii?Q?1Km+U41CpAANrdQHyQy7xLJyEQN4tm78zdz4yLChiWhU+gwCHnjtX+mjVT2V?=
 =?us-ascii?Q?B+Jv+AaMqAmduKRyf5P06pJ1bkeNjekIyXG2cYKkiF2OWRG1aZl0yEPLOStp?=
 =?us-ascii?Q?GAtA1ybrhZkvmY6crmXAp/02N5p6TSRDe77KyP4r5IXtpF0iUnqxLsWjC7A0?=
 =?us-ascii?Q?Dj35ABGjFOfqX29myR4FmYGX7GEwCTlAbAMwpi8t+m/IV9mrnFoYPTQyUcUs?=
 =?us-ascii?Q?GrzfPIDo1OppfeVanftJ0CF6SLWbOC4x3YZZ3FwvCC91eIA7VP+qs8Cg5DN/?=
 =?us-ascii?Q?G6sorbAKpxkIlnkbzHHJexzV8vtAhbtS3JXAi6cQnQOjnKWpp5sQwl1Cu3Q2?=
 =?us-ascii?Q?cAhexDHx41CWt6TQzCzPqxxe9ydfc2PlA/xlE5pPh17RyO/s5nLDelHM0aDm?=
 =?us-ascii?Q?wrgXt/fVcZ7mOVsaANptZr9BOku603hkmjilMQ0wXwCmawNPGsU9SNIXKDT0?=
 =?us-ascii?Q?+o+tuZd2jZyZcW8m1BPChM5UoHPwduOrLDsD7Keq7LXBfruQhHgR9Dvjz9+9?=
 =?us-ascii?Q?AC72JMe6UkrAxUOBFErYLE8s9gJ2amVwHCtGV4BX1a452y7nDhy632VJ+Abz?=
 =?us-ascii?Q?UbDhbPZfB/v4tLwvCzI5o31e1KsK4gm2dkWBmlqYZurknkDKGNysrh7nYkZi?=
 =?us-ascii?Q?aviM6Ry8UpVqPfY4G0kdhDuLswbq+EIbPt8QrH6M95B6t+BiXDB8AM8qiUIt?=
 =?us-ascii?Q?cdhVsFfItr5/LN2sOSOZ0Ln1Ow+7InbfK/jv8DsSA3cLeT1Qr0ykhdJLGWXK?=
 =?us-ascii?Q?e1yJVtzcrX4Oll4rsOgsx6reYoFY328v7CAKCPyc5kesXh21g5/iFbWx0I/b?=
 =?us-ascii?Q?W8/NSNe8OQ8qWxOOOiasPxXasCUvkQHh21gLaiJ5vW7aag/wmy4XSKdPbfLi?=
 =?us-ascii?Q?oe6I0xeUfjjJRLG44XC6f2c+xOiDbHmerg6mwq6W0JKGX2n3m1KJl73uVUq/?=
 =?us-ascii?Q?w6PvNro3jvqz1KqbJBSQp2x7qgtRM2Uf9OAgP4D0mEY1LfanvBOsm54UBSGX?=
 =?us-ascii?Q?YJTpd1E4DGjbJKDmrp0rcJh+6Eo+A5CLs3ErQuq2pEQ89c9dP/4ApscHsezt?=
 =?us-ascii?Q?YsRysm6ScQ8t8UAUFXZQ3eSWKcY+CMdnd493LOrDxYAh13XySM3TQGw0jA5m?=
 =?us-ascii?Q?2AbeWQHbEZd6gUaakFS2fmJcsCYYJvuTXVW6U?=
X-Microsoft-Antispam-Message-Info: WR9lPbBKDkfIVJWf1sfEXHjbPEdL7JY9mcBKZG5eJNYfcrWe9Zq5AqIVPOoCQ7cYc7JkryV8UemsV9r5PC7ZewH1OjX3bCbIm3uS+1bDDtWErwyG1qmgohEhMvqRvGLLfZfj5VIjSpysv1LS82VsseglyftHiUlTsQYJSOJUZjB2UM+X7vctplU6k28qvQb+
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;6:tEHfMrx2mwfH30fRFtMuAoIKkQzgjwpjf7owDy13tnzBCppnwNPuKP7a2Sc2rm+ivr3u7FXROnhvyzeUxlvXbwgV2b32h2EU7DHhp/vKdcbJKEMyHBS16sC8PCyEC5U279YmW3L4t/9TPkUMQ4hUAKf5sBPZL3L5Z3ZjpEB9d53oSA/4/Y0pD0FQ012WVRlZNFvpB38oMME74zdb11t0h+Jq+7y6nt4rq1RjKGeSzDRTuQik3IokL72MvObQ0xkU+H8gF6gjkLTCfnfiY40ezZ+jAPWBBWAafbVcy1cmDxsHUFcn4DpyYt+rAOTB7xr6MbRHmiaR1aW1Z6MpxV45Y+4KTJKe4sE4OaHWIdj3Rfo=;5:d2sZf64Ww5xoK9Vbrx9j7hbzG+08DtdhoduHGZAYpv3DDi0+BkOGxFkPZ2kiV9ESB1WEg9mWT1bmLUx73zKnv3u6XYFw1v4AyC08K4vpGIFHA8akptjp0L6Rmj2wylMXKnHocVjkI43MXUtDENOOluo/IBrMceWn+wkRt9JSB80=;24:2DXb48k3djpQdK2STf0esyryyf+tn2XzWPbjEFqLnTn4R60mo8ixgK1D+huBJzmLy03fKPjS4xQJqclrvZm+0WXDZ70e7aOtT5R4vT3TCjk=;7:FGFAN8rjjTcKAU3FGAaNXD1xmdLsBURl6kCouh62oy7LBKbk1elqNnG0kZ6Bq8vo+llB0fzSOyONXcfjJ98pT/mHE13w721JW961vHvygdxVT4k7rAT12BHkow+5cmrJ9l1kiG3Ti/VAZfwagS3t6zlAn4rYGK6wOta4F20lIEgEA4CO8+KrN5/RnWNVPjtc73VnPuJnjehMopZ33vu3c2ovRvMl1rlnTTg1OXkwpQUXHqURrjDtduRyEU7vQLNn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 20:58:37.0258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2df70d-aad2-440e-4649-08d582dbddb4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2777
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This series tries to check the I2C device id, but instead of open
coding the check in the pca954x driver, I have a new function in
the core doing the work.

Changes since v1:
- Added Tested-by tag from Adrian
- Added Reviewed-by tag from Wolfram
- Replaced client->flags with a zero in the i2c_smbus_xfer call

Wolfram: I'll send a pull with the first patch in a few days, to
allow for a second round of feedback now that the RFC marker is gone.

Cheers,
peda

Peter Rosin (2):
  i2c: add i2c_get_device_id() to get the standard i2c device id
  i2c: mux: pca954x: verify the device id of the pca984x chips

 drivers/i2c/i2c-core-base.c         | 33 ++++++++++++++++++++++
 drivers/i2c/muxes/i2c-mux-pca954x.c | 55 +++++++++++++++++++++++++++++++++----
 include/linux/i2c.h                 | 30 ++++++++++++++++++++
 3 files changed, 112 insertions(+), 6 deletions(-)

-- 
2.11.0
