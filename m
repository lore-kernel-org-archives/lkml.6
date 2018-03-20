Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeCTDsT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 23:48:19 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:42176
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750968AbeCTDsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 23:48:16 -0400
Authentication-Results: spf=pass (sender IP is 117.103.190.43)
 smtp.mailfrom=sony.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=sony.com;
From: <Yasunari.Takiguchi@sony.com>
To: <arnd@arndb.de>, <mchehab@kernel.org>
CC: <msebor@gmail.com>, <Toshihiko.Matsumoto@sony.com>,
        <Kota.Yonezawa@sony.com>, <Satoshi.C.Watanabe@sony.com>,
        <Masayuki.Yamamoto@sony.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Yasunari.Takiguchi@sony.com>
Subject: RE: [PATCH] media: cxd2880-spi: avoid out-of-bounds access warning
Thread-Topic: [PATCH] media: cxd2880-spi: avoid out-of-bounds access warning
Thread-Index: AQHTusQsLRxlP2UKTU6MiC2XSQrj0qPYhUWw
Date: Tue, 20 Mar 2018 03:47:57 +0000
Message-ID: <02699364973B424C83A42A84B04FDA85484BC2@JPYOKXMS113.jp.sony.com>
References: <20180313120931.2667235-1-arnd@arndb.de>
In-Reply-To: <20180313120931.2667235-1-arnd@arndb.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [43.1.76.63]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.43;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(376002)(2980300002)(438002)(13464003)(199004)(189003)(77096007)(46406003)(106002)(4326008)(54906003)(39060400002)(33656002)(2906002)(110136005)(229853002)(16586007)(316002)(107886003)(186003)(53546011)(6246003)(59450400001)(478600001)(2900100001)(2920100001)(106466001)(6116002)(3846002)(5660300001)(336012)(72206003)(2950100002)(246002)(2876002)(23726003)(47776003)(305945005)(7696005)(66066001)(76176011)(8676002)(8936002)(426003)(7636002)(102836004)(55016002)(86152003)(7736002)(50466002)(55846006)(97756001)(26005)(86362001)(356003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN4PR13MB0498;H:jp.sony.com;FPR:;SPF:Pass;PTR:jpyokxeg103.jp.sony.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT036;1:uxjxZ+JlyfX3omsJVBQqdmMwC1ncz3+nCJb5MjVOWxEJMh2GlL7yxuf1I7uJkhrpkzr5cUQlyMVFd4ru0E5wim776dUgN89elwi9nzStCCVuFUbUrWew7VORriGJyJT9
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cc75e27-05eb-4ef9-da1f-08d58e15672a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BN4PR13MB0498;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR13MB0498;3:h3d3K4FcKIZNl8MvBTJcWlK1ESbWV90fBHY/SU2G+EzCPuyS1EKDuVJNKxagFfLK7MOD1pFI6jhOpMxVyHi94a+hoOZuXiF1FEY1tZGf3LMSjJwaymbjW+2qksPLwxQxjXaIbmHFIYzgFrISapAZRxD5Sf4MtroqQZ4fuC+ubX3c7xze3K4Yt8gnhQmUKXTe6VozbnEZusblL6s/lS5F4Lv+D+rDGhHstlF0yFnHMWf0hjm3WHkA1AvDPP4REuNtkdrK6sAbWWSHUXPn6n5OaXwQMwUBn55UAIEJSTkjjDJAU7pPd6m9Nzvhy8NhNgk2nPi3BJynoLtNVGYW18avRriCHwdlje+RxyqoOIwOV54=;25:+b7RL+AaPIieTIsMUy0V/kC6OojGshr/oBsb1PnJeApP990a2m09xuTrx0ReRoLKj8++m2kCbCSKeCgAifoYkg5F/fUF/m4tFBUuU1q1HFKq2Pe0OsToDEhDj/rXa8/FtTt8mVpouZ5BO6ebZkO4Q4H8wodhIOnA/ZelfU9nSajDuDDRlnvu6DsaMY85GiUEEBLvewyBifJLLC0aaHYELiF1p9S4kt0RYHRMvXUAljbUaqNxV4HWtuyKYcrNpnVZz53BVVDoJTFHZRukkXhRsNJbl6mYDnQ0CYp4reE+jj8rDK9XkCUdJjvnIml7++fAzA3zoIVXHa9ngXMF3KHBeQ==
X-MS-TrafficTypeDiagnostic: BN4PR13MB0498:
X-Microsoft-Exchange-Diagnostics: 1;BN4PR13MB0498;31:sQW74xqorT+110ZS/tL8u8JQVFgIUpJ97yctrrkaiya5cH2zbolsQwPIYmW5ZwY3uz+pNs+0iKkypTYKQY38eqUkTN1tZIRq6VPj9y5XiugHmBJVllJikMxukx8WaFbXP2qt4bj/hriMXz486He9Hk+23/m44qg5W8Os8O1AZdku6vNerdXK7BJoanJSBMy4cwVYsAYlE2OluJEE09LuuuDMHEGY7e5wcjG/UqjRelw=;20:yw2rjkwhHyhqXdL2dh6hZbDnoWBqTjHtEgnQey6moN3Euj5+TV3rD5RrM8IKCNl4bWM23vcSbizZB1pT5uB8ZAAOreWzFu6w/G/mliPJ1KxeeNe6AsGbSx3ntZjZwzk6e0uNNjz+TNyT1rRF8/2Z+EWf6iYe0m/MAmqNFOnz2D2l5jwgJYQ1zYlFlRGCq21rNjLXpWTQEySmmQ/4xHQIPznr+d7qPNV4+naR5mjNROFYwpf99h9Gnsme7tte8Ur+rsorwtnW9vCtVW5utRsZv1VGIgLncQeG8n8frUtjbzX/0e5TUxZFg3hnO+5nOd21817lIUjaMTZ9RuzRAPcnfA50mIEuPcNqKJkZ1RrbcS65pOm39gIqXg8H46+UyPjfvzOS/e2z7ORf7UKSHrvcqKhUz62+hEeBIsDkMuX8JUeFEBOJJeA5+tX69OTM+xaWFwTuk5GiRn8WqqMzcvEpaTXAq8FH0CIVb1TdUrHFKL7g8ZRg44RIT6n9FYiUX9+a
X-Microsoft-Antispam-PRVS: <BN4PR13MB0498EB4258BF7469FEB5F944FDAB0@BN4PR13MB0498.namprd13.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(182409339516656)(9452136761055)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231221)(11241501184)(944501306)(52105095)(93006095)(93004095)(3002001)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BN4PR13MB0498;BCL:0;PCL:0;RULEID:;SRVR:BN4PR13MB0498;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR13MB0498;4:AtLJeX3MXlqA8gZDTlA6hhndfFM46B0C3OUFi7ZofJZfvkzn0ju0UQot1sXw/6bTX2+r4RCjeAl/8hcfmOC71CJXywLSfeT57hGbj04l0sGMrmouUM6XEokgsUjUOb7/FM/ABaOFwxFvazDl/hRL8ph5Jo6xwMk99vmriDaSUfzUEEisGHWTBijnfGYz/YFbXpNJfze6Ihuat8G58SZADAoeKnqrp6ieERjrk3rvpGQ7kg6WDgwixazoXdt3R9jL5eQwZZUXN3tKOnIuTCYi0HZOUAqIkdFdZesONrmYJsLFEJrDZUKnjrpLvybOnfxnNbm56QBXuoNXxlKlFWbG5HVpZ4VMOvN9OgXoNiqs7SlJpD4+HOpyucJm9XL13Oh0
X-Forefront-PRVS: 061725F016
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN4PR13MB0498;23:9+UtJcHvdFRk71RQSjrB++kstQdxPakwPZjy+SuyH?=
 =?us-ascii?Q?XXapsJ7I2VsOVrTd9+75ZgljKIREKIWJlVB4osJDnW9jFzDoJ47Dm+5ygeSH?=
 =?us-ascii?Q?v2b4rsp2sWI8P/IxB0iqNwPhNCQd+l+xHf/awqUCAuMFxtb+DdrfjzYgfoTK?=
 =?us-ascii?Q?FOfKWFMCvhd6DHxKVcSI5m30/OD1fkbOP60xtStV6Pw0qk93eHJ4g7ry24Qy?=
 =?us-ascii?Q?7LtLpmeLIYWKNaOaKlCR3bmNFOKJbM5Ne4ae9BauEql0hEg4l5xe4dMVPtEU?=
 =?us-ascii?Q?QtbvTkIKJHmDx5vu7jaixpl1voYzajA8qIcyVCe0BIaYWOjY2oxYxnzP/v3+?=
 =?us-ascii?Q?3a5GVo5EEdFxQM/KUOg/v5e6gC8gLe4Kxb+qIPlgfyDCFi5x//dIbqrwzTQx?=
 =?us-ascii?Q?G/9GgH6Voc1SjruiSsY5jVTSrNKgxD1DSGA9hLo+AC32FgM2sx8kXLsfLhfK?=
 =?us-ascii?Q?u2qaccRzPBcaao1ANC4V7RwlBPRwjrBYcRjtpIecqYPmU/Xfp1wyfWNOSCwR?=
 =?us-ascii?Q?lFLjW4fSLh2YtweGDU5a/Q3/dAGTJojdSdqiTKJikoJ/CkafQtSH9ymIggtp?=
 =?us-ascii?Q?g2MHtyIkpv7GGYcxcJZ7rTsn0WWwqFN6E7lPnKOh4mdj2yMcJ96q7o86l+hv?=
 =?us-ascii?Q?FP4I6DezfdG+ZbgdCDcY60BSjOXuE404DD9tr8px+LlhewlKQrurY2A2gyN3?=
 =?us-ascii?Q?+NInGI46+eqLN9Zg37bwxfNA5zProKw8lSBwK1r/wNGOQyM+wxOHJ7GzGXyE?=
 =?us-ascii?Q?kzKmoG7p7Irw4l9uNSSHiDrY2/ch5voCnRH839/v20Syd0qOZnea9roqPU16?=
 =?us-ascii?Q?y1fJtAEaWnLlEzc1PeIPQvvfYBaTSyWL43tVC8K+SKcSEi5M8l6cEn+Ph5Uy?=
 =?us-ascii?Q?KHQh3G262J5fghDr4ge9hjtkQG6CDtrs2Ti4OHuYszGxz2zLKFQaD7lTyp42?=
 =?us-ascii?Q?L79uWsqhNNm1xzbSl4A6ouv7FQlA24c2L1zLcUmKUwgLElbf4qFm4BX1zm5t?=
 =?us-ascii?Q?io+XKDNFy+qlu7+tWBpH2zGOfs9pJ4AE/Px9OCAVTMpgRO8sYkQoRlY9yGbJ?=
 =?us-ascii?Q?TfTKwHvzPEEfHmjU3PEffoBz62PZirkL9SFbMYqY5WkdJlt/p435mAVH5Fn5?=
 =?us-ascii?Q?Zy082YBzmIDRNYBtAGpqu4k6eGCua4BU684OWdlghiVWKPvnVf8yGAkf36pz?=
 =?us-ascii?Q?AbsPL+vIdUN6oRwaLXlt9grd9t8DwXD90BLrCD0E7MPhDQ+rM5WRZUJYjhpx?=
 =?us-ascii?Q?Q5wr6VAdWR7/sEQCOAjzlLt+Y+Q2G+E3wURy9c1UorXpjVXzZRzIVaESlQgI?=
 =?us-ascii?Q?IQx7l7J4pTN+HTZw8OXwtatjDiCnxiPeYmA/ALDulBo?=
X-Microsoft-Antispam-Message-Info: kugneEmgd3MdQsZp9y956Uv3jSrCkYbtCdyMThAK0BsVfYdtTKubR+iocWwcNJNZdDupYIl+2dNHAkZgwA2jxkGskLAZuqv9XqMczaqmL6wFnPC/ZrlBraiOBI002L4ZUfmXfMVu5if8xPGmXnl9z7nvQbzdVmw1FW+kJxzm1jXGlptkDoveEnrVXbs557vP
X-Microsoft-Exchange-Diagnostics: 1;BN4PR13MB0498;6:O56qX8tUEldJAH4zsUHwnPGeaBDthAhnZLwoYedWW6lpKnQX+ZUab7v/Qjxa2KVfmSh7Qapjc9+S4tphPRN7pqO22fhc1/2e3LWQOZc8UsYFrjXjNZ76stCeVY9mSXF3u8tRfuQkZpl23JYkGmo1K35yGXtq2y3PhCwcQDYCApcXF+FyrsVj5qcVlRRvL3KLWVR0Jo78mM5WhMjqQg3w7Jx7jxHThN7zPRvOM5Rd/yFGGPTeU/jdijFyNlbDn54vLWk4lVZTZg4ckmZpO8ZZ4t1zygvKQHGKGyTafpUf186eCOVeNrkj+P+SyHyrLuXDlB7C12tlTZaNhUa3S8dnIwLhI94kjvIP08zgj5Lx37XUZbzvfqGVUe+782WGs5sd1V9Z6JaHFkRux6QCCtfS+vMEbVBmW9BeoZGfKVvWPpgSX+XUqgll1oZOJvmKK8GWuvCbIjU8I1Tk/gNbwqtIrg==;5:/63AwPzVX7W0QjZ7utnwCQIhgm6eF1YDMB+DMigvzBLBmz0+dwnb2ZlQERAYv8bmijf9yq7TQtrx9ck7EHw6owSBTCOv4Q5P8WPoqaF+/oGdjmq+8bIsD43ThnWBmAlEIJCsMeF8fS64wY0FpvmUB2Lz1N/OhYBa/6QKOIgAoMA=;24:rf/ioeMPOppNDL6qOmF5Vpqvubdyo94vsDAolFEJYL3879QMxo2i+kySMbd17jIwWuHe+MrUUs6pfI/86rxKXNiumrnx7uVqiuPiJWtVj+Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN4PR13MB0498;7:+Z20ODVoziB13G81O328hSxZ+eUZRrTBhJZ8WLXd4Y6DxU69eU+qGwXZBss07+iMeg2ar0pY4p0oxX4VeA7WH+HJXJCmcZcpPrJVj4qEsKNQ+ItJNR1bIGdef11KTv60gnSyySzv0AU30WQC0sTpTJ9dGI1XyY+00OQNEuB4qokTva1JYucGDu1S/aj8Lsywm/vSWlEC/3Vda6HfZ7CO5Mkr4DTeXAYQ8yB7hOPWsLoom+rPy87vnw2jFTObzu6T
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 03:48:11.4268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc75e27-05eb-4ef9-da1f-08d58e15672a
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.43];Helo=[jp.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR13MB0498
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

We check the patch. 

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Tuesday, March 13, 2018 9:09 PM
> To: Takiguchi, Yasunari (SSS); Mauro Carvalho Chehab
> Cc: Arnd Bergmann; Martin Sebor; Matsumoto, Toshihiko (SSS); Yonezawa,
> Kota (SSS); Watanabe, Satoshi (SSS); Yamamoto, Masayuki (SSS);
> linux-media@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] media: cxd2880-spi: avoid out-of-bounds access warning
> 
> The -Warray-bounds warning in gcc-8 triggers for a newly added file:
> 
> drivers/media/spi/cxd2880-spi.c: In function 'cxd2880_write_reg':
> drivers/media/spi/cxd2880-spi.c:111:3: error: 'memcpy' forming offset
> [133, 258] is out of the bounds [0, 132] of object 'send_data' with type
> 'u8[132]' {aka 'unsigned char[132]'} [-Werror=array-bounds]
> 
> The problem appears to be that we have two range checks in this function,
> first comparing against BURST_WRITE_MAX (128) and then comparing against
> a literal '255'. The logic checking the buffer size looks at the second
> one and decides that this might be the actual maximum data length.
> 
> This is understandable behavior from the compiler, but the code is
> actually safe. Since the first check is already shorter, we can remove
> the loop and only leave that. To be on the safe side in case BURST_WRITE_MAX
> might be increased, I'm leaving the check against U8_MAX.
> 
> Fixes: bd24fcddf6b8 ("media: cxd2880-spi: Add support for CXD2880 SPI
> interface")
> Cc: Martin Sebor <msebor@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/media/spi/cxd2880-spi.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)

Reviewed-by: Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>
