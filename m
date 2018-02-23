Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbeBWVJU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:09:20 -0500
Received: from mail-eopbgr40102.outbound.protection.outlook.com ([40.107.4.102]:10720
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751843AbeBWVJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:09:17 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se;
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        linux-kernel@vger.kernel.org
Cc: Andy Tang <andy.tang@nxp.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v5 0/2] irqchip: add support for Layerscape external interrupt lines
Date: Fri, 23 Feb 2018 22:08:58 +0100
Message-Id: <20180223210901.23480-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180125150230.7234-1-rasmus.villemoes@prevas.dk>
References: <20180125150230.7234-1-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: AM5P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::32) To DB6PR10MB0439.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:4:11::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4fac463-0464-45b6-22c4-08d57b01b1e0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DB6PR10MB0439;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB0439;3:5opYF+OZlPV0rZsBdLus/+nZLknyc7o988VhOR8vUnjZKTWDGKU+H3Zw92BNsmgeft+56anoiUdE/Ow/itYB2SegJzY9Ug3/mN0n0oauNmao3KKndEvHy3HcOaCT8qWsL5edzMIz6FOzuaLMKBPknOO4mmBQh82+2Qdo+x95tq7tp54O41vyB/o+VuAXF4O/xGqALnQI9B5OeoF4M5U3kSg0F0qFuXaWC1/UZEYGuhcVehwzVn8fulA75fHjwfes;25:GN2gx2LdSK6+uvQHxI0iXixHIGdQpZNGhjy3YlGcGnUANPcS3G0MKogn+SooMIOeA4xN1SiOsi8kDJTah2gHJhSOVGFSfmsKt+aYYYvY0TsLklMG0cJqi8uNGQJLui5RH19LxiHwI7EqopIToi5l20TWzsB31xnphLEkiez/iW/NxGXTW+od5uE5Xpe2T+RbexGhDFm5JJjI60ayiGsvqiY9X54Zj8wgP/ZuuEviN71OCSiSsBJW5U5IpHKfo8G1zgTdj5P+q6iAVW/F6wXiBs7/LGZ0wDTlPlvjA7U0/XTxjf82KXB4VU2RPylzREPvwmfACbo/rnP4NzvvuoVnwQ==;31:JJ71WJmX33iel275/itZKiMYSsatlynTs9ND/4akvWzJVzsezyP9R0LBEUjm9firIz2EWcqaqR/DSckkTl/qtez5W9hgxjVf5A6aUg7yeH1p/xGrBc0dRyVLS+AziLmvxsKY7KjGAQ4Z6S9jgqBQhU2+QhMwpo7HvIAdZRh5wu4sgsJkeN577rl7YzjI5kFPFvAz8vesz/1rWb6Lc3AQZ2UMwbZgZBLXhLLOK8tusKw=
X-MS-TrafficTypeDiagnostic: DB6PR10MB0439:
X-Microsoft-Antispam-PRVS: <DB6PR10MB04391DF3228EFCCA047F97268ACC0@DB6PR10MB0439.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231197)(944501161)(52105095)(93006095)(3002001)(6041288)(20161123558120)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:DB6PR10MB0439;BCL:0;PCL:0;RULEID:;SRVR:DB6PR10MB0439;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB0439;4:WtBdUmjxeE5iYB8dNqb9W8WARHRfL/VGZRFCFRDBZJlDBfUoCkYLFUuHnKG+mdwaT6e2s7qIo2edrN1evAqYIx23IH3gMpQFh0g4SFrVizL6BmuCHOsHhHKNOtUP+UdKPmQajhxTKby3JALMba4mEiU0ZNnJshStTlFtldYaCfN8+3xJvAloYiatFpaLL1R4i+aNZamhGpAA0mH3TNmeOIPcg7wAm+H1Kxne3dcUvTLg4a6orz9vzZxbgn32qkFVH5m+OlMMkgv6tb13LLVqQA==
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(39850400004)(376002)(346002)(189003)(199004)(16586007)(76176011)(8656006)(386003)(110136005)(54906003)(6506007)(51416003)(81156014)(53416004)(316002)(2906002)(8676002)(8936002)(81166006)(72206003)(107886003)(53936002)(74482002)(8976002)(305945005)(478600001)(6512007)(50466002)(6116002)(7736002)(186003)(1076002)(3846002)(16526019)(50226002)(5660300001)(25786009)(66066001)(26005)(6486002)(97736004)(47776003)(106356001)(68736007)(48376002)(6666003)(42882006)(2950100002)(52116002)(36756003)(4326008)(105586002)(69596002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR10MB0439;H:prevas-ravi.prevas.se;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR10MB0439;23:1xXJwczSj6tIkPT7YdMKvuySHvkQF3vcFS7aXa5hx?=
 =?us-ascii?Q?KQUzPZnn5IhxJlNvJVUK4rmf6wUPShmn54eM8EJjMn5OW++Xl7UE0MekBfP1?=
 =?us-ascii?Q?IvgYESU61xlv1emCKa44WTJe1UnyreLyP+QYyvtp/WJEy3w/lbdrYUw92P0J?=
 =?us-ascii?Q?L1tVu23kKA5IQG5cSZsZlx6H5a2O55O6afJhSc+kcXW6RA1iy/WtZWj9nO31?=
 =?us-ascii?Q?UTAWUKiRtqN57SvS0ZZ8OR2orzyyeqID/LyMtOvdDGYQfWRmUcMNYxpc/iOY?=
 =?us-ascii?Q?xWvO3rU8aQftDCtFuDeec5E4HO7SXHCIVoVBQ5gcRwtYusGBx3xPUERIuEJO?=
 =?us-ascii?Q?yV7LayTjIEmtkZ42YCRRmaO75z9HrkCMhHUtHMki1DFbV3L9gLC8DlgSoCoR?=
 =?us-ascii?Q?6flZx0LSJy4ey4HlchOf2qaXoZ76/il/ZCHIfHkIaqFurqRloYP06fBc3OPw?=
 =?us-ascii?Q?D56xfx4IFH36aFNTw+ubSn1mREFnNxGxYhREAmzQGHj07G1MtsLtq9aKAXas?=
 =?us-ascii?Q?kPLdniZGob7aDFl6Z2Faq/e/wkw2sipAf9P4NGWFlSlnRFhiOXtuu8d6fF06?=
 =?us-ascii?Q?DW+WFIUS2pI5YHEWYAajxtmQ67EDN1O7KhbbC3QIIwt0LDzokQmL0bWRwel0?=
 =?us-ascii?Q?uDYJDIz0Ie3eZ43G0jybIXeczLjIYc5X60kHCYec3gEABss/uoqtKi9NWo7a?=
 =?us-ascii?Q?z6oU3mrqoUsfFnRB8gJT2fLNKko2B/WJdhokk5+2VfRUDCVbR1rXkYyHf+oJ?=
 =?us-ascii?Q?4PTFfHxQXeG06AIR1rfliof6HlQywmwbiHsWfMGvBqL5sQe/vmcqpPCvpplV?=
 =?us-ascii?Q?DSYSZNILpkbFRqRM02CkoHkFaQA5KJTjrgucd/+yfNCMX1tF7BjyeHYa+p5l?=
 =?us-ascii?Q?Q0NL7WKNbGzqgCcjGlYdeD3wbb3ESnGwhbm6nGrAwR5S03O0MSFA1kyAW7UU?=
 =?us-ascii?Q?6qEQvRWYuqANclNlzNeBhplSb8Kj1ssoNb/j1ez/6I71lgI0Bt875BNB8GQq?=
 =?us-ascii?Q?VsV3liI75o81uB2s0MvMKI9zr36jlavFBKcTxGrDGk8Z1KPG9/H/MjEsTCTI?=
 =?us-ascii?Q?C/UwGTb0gyJFh7twPWKN8FEnhJiq7s2nfvfeCj5TpoNV0lpnavuNxC2c9l04?=
 =?us-ascii?Q?imPOfOpqYDQIKP716LbuTM651SmvVGJJMSY4CPbCGFl0aaCDa4l2Vr+z10M0?=
 =?us-ascii?Q?ZvO0CQ4Zy1bi0ULiwvHTmxoJn485VFRpn6HpHxnEqFrUqs+v3iAVXb0geW4y?=
 =?us-ascii?Q?QBhYk9pi3OjmAmy4RyWJUh3T3JpIb/Ggd1NE7bwK11dRbDB2sbNjMSZU0Pgi?=
 =?us-ascii?B?UT09?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB0439;6:R0c9tBbg7wc5E8Kufe43Q01QmFLwipRaHvBIE1mbG4xdC3NdvYaZ2YOjk2BVM/MsuygjDmShgW5NyXtji2QaiPoKXKz8sgyXtL/ZRia4DXArbnXgpRjgDMsHFirGcW6oOsVy7KFUsCGQuF0ZQSTR0zD8VG/vORHtylps2KsTsN6BTCx03eE+3bz2nqf9A80p0D5VFWghxDwcQaXpI+OmSmJ8rEQCwQgQFdlt6c7TJ2oXiU8/iZUnPg4hzp0RarEzamcWQvZl/pGT/EMlro1QwvaDM/nvbYXzPgWVFuU7BOG1qviyk+uK9fxTuzV3ItxSEMl/gxDxAB/rcG6zrCLhoSAzE07ZpnWxP/mM0UTC6B8=;5:XNzMeuqeO6ItIyaG3VjOI8BZz4dGRxgEwdCAJ0o3H3lsLBQQh/0sEr/X/QgJKFxvvvOjlY7u7pJUSRqvRtuCWkbxUxJ95ByDI423xyw0/YHKtbRodFnWqgb1pr5R+xMOzKV1n60Vma2G4IhfrdyJqFHewL0OSd4kXHJURewIB5I=;24:G5hR5KXRTn9eRDqm8EainIn940DwisytB4t7pguJWfT92QpAbaVjoA8GatowU7rsynm/oNUdKl8SIKDRNaZZqBrjReK8QNTY5WW6ypJ+80w=;7:9qwdauel+P59FTjAhGeHBlpB5OC7GbJLpmC1GMW/3tYiDLTnetqmptYRBj2dOLkHKwYx9VaT3+QewKx6evXygezfuK7NG7pCVshncFILh7X7f1qzzIgcendvy21nVhkj+ZUdL3ZdgOqT0IkWhU3BvmDjerjFcQMLz7TpybubC+TOn34K7s6I+Q78iUd7OF0S9PCw12ym92ivWDVsza8yxJIXDRehfkoBkb9Jpc8M6TMBPHgK31L5NIzOod95twRY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 21:09:14.7545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fac463-0464-45b6-22c4-08d57b01b1e0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB0439
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v4:

- add SPDX license identifier to .c file
- use 'reg' property to specify INTPCR register
- use 'fsl,extirq-map' as property name for the mapping of interrupt numbers
- rebase to v4.16-rc2
- change #interrupt-cells to 2 to avoid redundancy in interrupt specifiers

Changes since v3:

- Add non-empty commit log to 2/2

Changes since v2:

- use fsl,bit-reverse rather than bit-reverse
- make the dts node a child of the scfg node
- make the node name "interrupt-controller"

Rasmus Villemoes (2):
  irqchip: add support for Layerscape external interrupt lines
  dt/bindings: Add bindings for Layerscape external irqs

 .../interrupt-controller/fsl,ls-extirq.txt         |  44 ++++++
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-ls-extirq.c                    | 176 +++++++++++++++++++++
 3 files changed, 221 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
 create mode 100644 drivers/irqchip/irq-ls-extirq.c

-- 
2.15.1
