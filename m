Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752855AbeCPBjs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 21:39:48 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:22400
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751714AbeCPBjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 21:39:45 -0400
Authentication-Results: spf=permerror (sender IP is 160.33.194.230)
 smtp.mailfrom=sony.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=sony.com;
From: <Frank.Rowand@sony.com>
To: <arnd@arndb.de>, <laurent.pinchart@ideasonboard.com>
CC: <airlied@linux.ie>, <niklas.soderlund+renesas@ragnatech.se>,
        <dri-devel@lists.freedesktop.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <frowand.list@gmail.com>
Subject: RE: [PATCH] [RFC] drm: rcar-du: keep temporary dtb files around
 during build
Thread-Topic: [PATCH] [RFC] drm: rcar-du: keep temporary dtb files around
 during build
Thread-Index: AQHTvHO6BTgamUbY0kWIDWvLB45SoqPSEOLg
Date: Fri, 16 Mar 2018 01:39:39 +0000
Message-ID: <ED290C750E1B324E972B0017C9D4BAB06479C421@USCULXMSG01.am.sony.com>
References: <20180315153730.3798004-1-arnd@arndb.de>
In-Reply-To: <20180315153730.3798004-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.231.6]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.230;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(396003)(376002)(2980300002)(448002)(199004)(189003)(86362001)(26005)(7696005)(59450400001)(575784001)(55846006)(478600001)(2900100001)(2920100001)(426003)(50466002)(4326008)(39060400002)(86152003)(2950100002)(23756003)(72206003)(76176011)(85326001)(229853002)(55016002)(336012)(54906003)(186003)(110136005)(102836004)(6246003)(106466001)(316002)(356003)(246002)(66066001)(2906002)(2876002)(8936002)(5660300001)(33656002)(7736002)(8676002)(6116002)(305945005)(3846002)(8746002)(47776003)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1932;H:usculsndmail03v.am.sony.com;FPR:;SPF:PermError;PTR:mail.sonyusa.com,mail03.sonyusa.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT053;1:/0omNvwZ0KEZi6cISls+n0oAHq3m6tRNgx35QyzIiolAVPDwcwPqjw9W/oNQaMwxDyFBnYYY1Jzk54sBoDq/nydnCfYorPZ8sExS2p/TxY2x6g/6mCRxbxnSIJHmB+DD
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95e98b90-953f-4741-7553-08d58adeca7f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR1301MB1932;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1301MB1932;3:iZ0Y2Eux7i8qub482ULVs+iblAFKjto9I+fq/qfpey7Pv6t8ed3DwbbswAlGq7Et5WM47I6ja83cszQ7jmQRn0HYvxZI7jwld3BpMj20CcAZvfgYLMvg2TWmyObO3549ErtpegfMvpTmhtvWWBq58LnNcLYvtprMZznc4wK8D9FSwIUjF1bMNXM3gIxOs68SKsOuQxqptLzrIGks6xiuiOENQFfSm87tzJTM1q3Yu2jFx035AkpOoN0HUGykrJZdXFRWcH6PFvZrYPP/SUCaXagGTVAQRaVwMRNsxXIKfwfaUbFqsQEztJMomVl8or4FCCV4yjTSo2YqZ98xJIe3BMvZEmBZ2Z4LoMgYvXSnUrg=;25:Zf605aCBoRRazHni1UlmZo3QCLf2etRghJ2EbQb9Z+1KRhM5jH0oLDlRFwNvGQSj19UmyNy+NUjl44Rh+FIc7sET842wSSL1aSxwFs5LVLS99PyqFZblcYSt0CZGvwZpQ/yWGOEsfvBw/UxvIAVT69E+5fs5smTymStLaHNhbfXij88Tn2SupA0uFmDjKmU10o414oaJV98s+NNYC8sPhaTzaGxbcW0uWyx+fD3ZvvPQicu1atvFuL8h90HV9Cfvr67kxSF9QXnfFkXNtNDvVzQZkGw3z7Y1cwuJbRXQu4RXu+BtG8C1P8ChdsEfQA+SDX5yKZTJvamHZxbuTDgZ8w==
X-MS-TrafficTypeDiagnostic: DM5PR1301MB1932:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1301MB1932;31:yHB2hESkjKkAgKPTm9radP53779T951KKYfjJVWQOOCxceaVCnTkF0zCw3iid3AAKAGtJI4YeFe1/oq2ExyL5wHcsb5H7hM8AJFxUx8m2nPxLExBJJYqOPFevj6qeKJjvfrjAEiqwxnivD2XOemcUliiRM/8CD8JLj5zRI+fypYvuo8wxMMNQQ95bzqLPBwWnOM5xoJHBKF8dtYxo92+L9fhNT12uRzrwgSUdbhy5Ls=;20:lrHfsHRg5zbwXUWCGxtWq/TVWskigfUxyLW3CmBS2DlwS1tFzDqajVDzgVolooishhR7RhNpiI7zNDXkgNfPsFZ9WYchEw0N/CANDdMTorjMoSDPnVOeqZ6+l6AvHaEI8E5mgBYXEKmuZnjysEObZuCH2u+JvkmLtyrbogRgOBfjYoZHzz0G4udMV6lugGn87XtgF4edTCHyTiZvh38IiQ9KszdKoV6r7rDF0meWjaDyfn8Bqc7+a18KVI16XU1MW6i9ks1YHuEDMRWI2lV6uMGKos+KFRAZtbNssg2fAyTON1n64c3B5zxRhac0Uau3YNAXO3le288/UNvM0oeTVEZQCLvXCnGlJR8v5ZuqScYYsD4X0c5Cm57TlihNkaczywc112lHyGxSvkyJy2nPc/qI9d3za0MGxr/lFO0bfQsBVTW3v5rwjX/iiA9Jsktgq1eKbzEc7A8ps2fKNxQOWFeq//HG6+fryND/tbczrLAbRZyZobpRKctYSmwwO/ct
X-Microsoft-Antispam-PRVS: <DM5PR1301MB1932CF92030969E747CDC460E1D70@DM5PR1301MB1932.namprd13.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3231221)(11241501184)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR1301MB1932;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1301MB1932;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1301MB1932;4:vpBkFHFcbao4nPyzDqYR/HLLJE13Ow/nvx1wpKGjxjOuPFbga9Z6ZQoa45bmJGYZaoRKfdGJ+nkRgYMNbq2lNifoMdAm3jfiEC8ai/dpv3nNyIyiA+e2C0IqdJHA0Vh4/Ni0RWOPfXw2xB/1vMbiSWOFf3EpHHfXDHiOHwqMbunoYOVcfbrw6LkLj/Zks3F8bIx0Vt0847IiFp0uDGizdcm0+hFewfWJ9siSs/DYXS5iTHwcfonDFaz0yn2YebcB/VV3rU6Dc7dp6Kf1cKJVIw==
X-Forefront-PRVS: 0613912E23
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;DM5PR1301MB1932;23:X8s2Px5ZNeceZs1n+lRF68Mepp6Qj2XHzjhSa?=
 =?iso-8859-1?Q?FIL8co12xDprhI82mVsO4KFPCHg8KjI/fzHHuc0T4KsFGOKZuJ7FoxakCz?=
 =?iso-8859-1?Q?XwrTYaZBEAFQAot5thZPmUmsDbRPlG5H6DyLkqKslH+uYySUl2sQ9AbxE0?=
 =?iso-8859-1?Q?AcYbcpp8rkWCSdq7ilUk9jB2CPwYnK8nxokMnUDshszh6c7E1WsJ/Sa4+o?=
 =?iso-8859-1?Q?56HCIrAemfI9y2ohP6ovS4DrtjFSR5tW5RwmhL1zBwx4dq1THnuvbjpy4t?=
 =?iso-8859-1?Q?H6UkIO+jFO0GZnSDuYic1aHXEpgDm3YduX9CupB7ipM9NoxVEU9Z51uTlm?=
 =?iso-8859-1?Q?uPGZQqmkvmBWdEOT4agFtXBWfzTWi6eWLBbKaoww2ZLN4uC+lSg6w9QOI2?=
 =?iso-8859-1?Q?9NARaQoZLfjqIAmU1+/ieThTXDNPCn9t/VV4dVHmfAZ0Zg1FV+/Rk/Zl6u?=
 =?iso-8859-1?Q?/x5JGmIQs6ZB1Akm75xKpp801//d2iXOLk7MaZKoT0DvvZ3Flwvq9dqMfZ?=
 =?iso-8859-1?Q?GkG7Hxtcp9tLhJX4WN7pVFM6K4YveVm9z96QvRh5VeHI8rs3fawGtz/qrW?=
 =?iso-8859-1?Q?4SvQbGn2Q5JVRQ39qdZbSclvRU213S+W1tDD6C0vrYqZNqWuvwl9X7BiIf?=
 =?iso-8859-1?Q?QjTr//oqfVPyFMhelJTI6J8f77p3l8PKXbp1Hp7EPFJjuiw6e5m8q9E6So?=
 =?iso-8859-1?Q?bMeUBQSnCsvSKeuyZUYi/PGjA08QkI1LQlmlkfYRahOoN6LekApS2G6E4Q?=
 =?iso-8859-1?Q?xgR4uzKjEAOOhLYpQjN2QRKqnk/GxsMYpj/KExidSoki3SUApqaWXB/fU9?=
 =?iso-8859-1?Q?M25cZM/CADqMe4oltm8OloVcqHAJYwdxjdbBHvRtyhRUEjE2L0eClbcW4l?=
 =?iso-8859-1?Q?ZOAARSjIpIPElmpnLpdea9NmKJI8ZEts4Vidrp4lSs2+V0GGQBHrYpdDPF?=
 =?iso-8859-1?Q?l1h1G3LyXCeRnRzSVKkm0zhui5M9YxH4sa7d5k7/2ZKNczTlt1YN4TuA6A?=
 =?iso-8859-1?Q?peWWLtY8coWDCT1WpW2DuW1qWRq9RCMk6ACOMCuDoZruimmxBH3xBexbJ4?=
 =?iso-8859-1?Q?R5H7ZDmEUNJkWZNKZEjGM1HXEh72gN2dktfJculpXC02rLlj5rNyOx74VT?=
 =?iso-8859-1?Q?fMbLlqPNatvHazIXSLE+WjBZDlQmynPCXyrZow+VCj6KYj84UBXMi4kbf/?=
 =?iso-8859-1?Q?HSQRxldjTSDwXEVu4lQ9qVjXkEwISCXs7RPHrCXCcp0dxgEdkAGrHxKafg?=
 =?iso-8859-1?Q?lsnovt2enRxHNn17pAmcWVBwmp9ZPlfQxikibeHOMo1AZGx6QdBLrqBk/Y?=
 =?iso-8859-1?Q?Dlbg=3D?=
X-Microsoft-Antispam-Message-Info: GdCPO20Lz6uviFpbtFSOLv2wAip1RWjRXV8l8pdoqVDhpYmlce10zUEN3bfbgrlZZJ/6nHj5gzWlQzFzHojqxwMIkvUAg9DvIYz78cPgQvA6GCAYS5DiFmd9lf060+NlL+E6U3yswuDsfK12B4wKN7StW5wgiAhlxpLNUQZxocwcUoVrhuza2g7kgFd23fjL
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1301MB1932;6:43dKrvM8HbDtUaQlgwmQOsrqQnhgrINMJkcbILaNbmP+HKDNy/nXh0zuA3JnQgEYGTOJCIB8Lp9zomBaL4ctT19mLH2FVI4BC3iDqo97GpSBnY+rSuPeps3ZLZ67gbJ3G2aHFXlQtV/Tzx3bvgx9vTV4wj8dlEu5UmLSjjYTtvRoLqsGIVcgQY9r+bdp8JeV60eEgG968IE8b0pA614bosWhuuXoY5bSIRmNbGdHICJMc6sbUMYEnfQMsG2z5gxWZRTHvEfx1sNa1nRa8epY1eGolGRvyr/rdczAZIJ80Qk0jn2Up7+UVOY2ROzq/YnlglCai55RWyln1PgrkT0SluUqpqrQTopHOPlR+CsDMvPowUuYRjogLzDIGiNtiFN+VpP0krBnvumvRREFZ4ZxE7daCjFrYYvw0/mLyF/0W++9DdNrECT3k17v3xL2c9/nvP2t8Vm83yS90msifjh8BQ==;5:EHF6WQnwJGiFB7jqMtfHj4+7OtipHVkB+IBGxTQZ1LGZEKL8tTHuJEeqoXRw5CtIXx4x1AN0jfjMzLVcPceM95D8HKjUvJr9GBrOlYktXT/W2GGbOFDm8j0mpV+8ZfEPfHUoQGcZ4PZau8NOdUp2DlEdGpNGPXe+Vh/iJkZxIMk=;24:9UP1brBbSKNtOlqP4bMdEZ6DR/CB4Ptem0LRiePY1Gw4pUv96l/WqqOy+Lc18TfziQwVS2C3GukyJSyOJ1ReVHjT89EFOcubbcj/lRovoqo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1301MB1932;7:idE2bqF9dKjbpxLGpAZGC0ceQCzeyXslFtd4rN9e1F6QXzDnRAaBWw/nWBY/8RKD8u40XsYlvKuTN+rpXrPik8qwtyAbtnpdTE2RDpny8ycrbQvmXHQ3/VIk0nBrH0gxmjeZsVXXPfxh2hbLrKsptmYXVusNedF6NONYUqKjBunp4p9qNNLi2g5bCVah+GKpfwjEeyElxphecLAPBA/r5QjXUenhPbuBw0oH+5XI6smVdQnAp0jOdgjrJ7Dpg96M
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 01:39:42.1735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e98b90-953f-4741-7553-08d58adeca7f
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.230];Helo=[usculsndmail03v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1932
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2G1dtH6007399

On Thursday, March 15, 2018 8:37 AM, Arnd Bergmann [mailto:arnd@arndb.de]  wrote:
>
> The *.dtb and *.dtb.S files get removed by 'make' during the build
> process,
> and later seem to be missed during the 'modpost' stage:
>
> rm drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dtb
> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dtb
> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dtb.S
> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dtb.S
> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb.S
> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dtb
> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dtb
> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb
> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dtb.S
> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dtb.S
> WARNING: could not open
> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb.S: No such file or
> directory
>
> As a workaround, this adds all those files to the 'extra-y' target list,
> but that's really ugly. Any ideas for a better fix?

Does this work for you (untested, but the way it is done in
drivers/of/unittest-data/Makefile):

.PRECIOUS: \
        $(obj)/%.dtb.S \
        $(obj)/%.dtb


-Frank


>
> Fixes: 81c0e3dd8292 ("drm: rcar-du: Fix legacy DT to create LVDS encoder
> nodes")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/rcar-du/Makefile | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/rcar-du/Makefile
> b/drivers/gpu/drm/rcar-du/Makefile
> index 3e58ed93d5b1..e5fc6ec0b8cc 100644
> --- a/drivers/gpu/drm/rcar-du/Makefile
> +++ b/drivers/gpu/drm/rcar-du/Makefile
> @@ -12,6 +12,21 @@ rcar-du-drm-$(CONFIG_DRM_RCAR_LVDS)  += rcar_du_of.o \
>                                            rcar_du_of_lvds_r8a7793.dtb.o
> \
>                                            rcar_du_of_lvds_r8a7795.dtb.o
> \
>                                            rcar_du_of_lvds_r8a7796.dtb.o
> +
> +extra-y                                        +=
> rcar_du_of_lvds_r8a7790.dtb \
> +                                          rcar_du_of_lvds_r8a7790.dtb \
> +                                          rcar_du_of_lvds_r8a7791.dtb \
> +                                          rcar_du_of_lvds_r8a7793.dtb \
> +                                          rcar_du_of_lvds_r8a7795.dtb \
> +                                          rcar_du_of_lvds_r8a7796.dtb
> +
> +extra-y                                        +=
> rcar_du_of_lvds_r8a7790.dtb.S \
> +                                          rcar_du_of_lvds_r8a7790.dtb.S
> \
> +                                          rcar_du_of_lvds_r8a7791.dtb.S
> \
> +                                          rcar_du_of_lvds_r8a7793.dtb.S
> \
> +                                          rcar_du_of_lvds_r8a7795.dtb.S
> \
> +                                          rcar_du_of_lvds_r8a7796.dtb.S
> +
>  rcar-du-drm-$(CONFIG_DRM_RCAR_VSP)     += rcar_du_vsp.o
>
>  obj-$(CONFIG_DRM_RCAR_DU)              += rcar-du-drm.o
> --
> 2.9.0
