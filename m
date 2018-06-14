Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6FDADC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD4D208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Dt/cE2aV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD4D208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936003AbeFNS2Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 14:28:25 -0400
Received: from mail-dm3nam03on0077.outbound.protection.outlook.com ([104.47.41.77]:31101
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755204AbeFNS2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 14:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgKYFAV18LermdawEPUwGHQ96WA2tXThD66/CX5hds4=;
 b=Dt/cE2aVh/Jnu/NXcIAOIfx5YYsxKtAGtwOsv20v3hk4lZ2d3lQ7WEpk/lQ1m9jkUcDrRvkdFFrbfvzR8DWwuJrarjHUC4VOKWbiDjMnhPkG/6sqMTB2aRG5rPzzBcmPMJMCmw8X4xRWbtO+CwUu5ZYhyJ0zdplG/spxKA+23J4=
Received: from CY4PR02CA0007.namprd02.prod.outlook.com (2603:10b6:903:18::17)
 by DM6PR02MB4953.namprd02.prod.outlook.com (2603:10b6:5:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.19; Thu, 14 Jun
 2018 18:28:13 +0000
Received: from CY1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by CY4PR02CA0007.outlook.office365.com
 (2603:10b6:903:18::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Thu, 14 Jun 2018 18:28:13 +0000
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT016.mail.protection.outlook.com (10.152.75.164) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Thu, 14 Jun 2018 18:28:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fTWyg-000213-Mc; Thu, 14 Jun 2018 11:28:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fTWyb-0006HA-JR; Thu, 14 Jun 2018 11:28:05 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5EIRt1Y022825;
        Thu, 14 Jun 2018 11:27:55 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fTWyR-0006F7-Fo; Thu, 14 Jun 2018 11:27:55 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v8 00/10] drivers: Introduce firmware dnd clock river for ZynqMP core
Date:   Thu, 14 Jun 2018 11:27:32 -0700
Message-ID: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(39380400002)(2980300002)(199004)(189003)(81166006)(26005)(36756003)(336012)(54906003)(486006)(5660300001)(81156014)(51416003)(44832011)(2906002)(305945005)(63266004)(966005)(6666003)(476003)(126002)(426003)(110136005)(2616005)(7416002)(316002)(77096007)(8676002)(186003)(107886003)(48376002)(7696005)(8936002)(50466002)(16586007)(50226002)(6346003)(2201001)(4326008)(47776003)(106002)(9786002)(478600001)(356003)(106466001)(6306002)(36386004)(72206003)(39060400002)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4953;H:xsj-pvapsmtpgw01;FPR:;SPF:TempError;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT016;1:+RuoglwwfBFBOVqjM8OjjTntvNrHzzH7/Pf1XZKjGf87N2am6ynMZbQMn3Kb/2e61iWTyWiuh5ZZNIlld3r+HNWtTpZPWPLU1z4xDgzthwNRbUvC1CdWgjpC0p6weTxa
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3274beaa-4a62-48c4-61e9-08d5d224961d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM6PR02MB4953;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4953;3:29dM8QP9pOX0bwU/DUsgtYlMLZyOtTw2IOhg2vPyX1409vIdCpN2xa5lHWhb0HvitOirIy53D35rBcFt+kKvEtSv39/1ijS9XB6OkFTFUFsBGO38BW5JNg8RBjplpeVbSsyYXGhOQ4I2AqcntNhaQomDHlzJC9nmhIxPFAv46C9pINdpPLzf4KbSUnLN7hB+E/dauiP1pZJ/olR5a7LthkTVXTuhJbwJL1i7PUphRN+/bAITMWq8ayRvpX1ybV3JxNWfeGuC+dOqlyd2JxPvhcL0quqYHTjyNj4NwyyVWEhap/85nTdVgC1IEX73GUJ7lC+WrSpl2aRgpjGFh61vMZVw2BrNA8SsNtTJBWltHkA=;25:iKdiZ+k8Vjukk/juZuLC2Kd9PWnr1vjw2LmsbJXaqO8CM/CVb7ng1Af2VvrMDE5sghlXy3ZNsxzoQRP+W2pAGL35fa1+Ks6K/867TId9NJiTrtKVH/Ni0KzTEjYQCWKKIs0oFQ+we68f5JFn1fHoKTI4CccwKbceR6mg6qXsG+IoJLolOsKbqpJxnbLkPFjKzJZklPygn/WkCeljcD04maURPRMq4gokhmq+Bx7aLwZ1RqqC6kNy1zG83YD3ptHBZOYbfuxqtgsQCVQ5N5/OaWH+M3B1QfT5f3MloxA7txYrrE7uOZDo4uDIybedslE5h7JICZv8+V5p0xp7se6ZLQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4953:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4953;31:UkQUhF67JFfaxfrRODSO4fe2hjKF3kqhAzpVYwSwtjEmR6kJf6LkaxXBWWZRJRdzmMI8rtDkgAiN/diV2iVhPrXrZB8dr3nsHS0uMh4t37yZBs+YNBoCasO1xObi/sCJurJJIoBhpZr424HtUoi2fqvzU3PuG8IvvDchJpjgg5aD9RkbCPBklou00jumGan91v/4+zy+1jVsZNxDXvLMfy2PxFX8elAIF7Ko7IZaZFg=;20:u314A4spf9vA60fFxaCYG3L+F5ixn3t/ODaMfhtIhhDmBdV6wjfJPRDtelbBtKXSh5Lf5qZ5m5Ivd/3OVUUL6PA0NSghYqAsv7FJbkw7W+nEnqdxwWRgMnGIiFenmz8gCayQaTdl2oKdtLV6nvYMs3VCQKOSTgN1Di0laXDZlPPwOtgLbnh9qpSutw07vCMMPveIcx8xKkMG62iSHTFy7MM+0TFH3Dbo4yj2aDt/ST2L+uklf70Vm0K4zAZzoPDHXKQwrhswoGFGd2yp9g+wS71bGwK1y393qOw+c0CkXfNh5KiPy9YRlia43nZ50GMPwwb/b+cTBXYcrliSvqMBjKBKWDdZO8pMnJxA5CCSqag69OF1RfiFiGBEIMPvX++zPqKgVpkTv4zpiJROyDJX5AFNcMWvksldBdZseL/R6c6B1nv0PZ86xdSUDuAW5XFg2ieNZ0p7JPLMHbYBzsyCEttWFx3pGAArXZn5g6pYeShA0M0HWEKxgeG6vQg4unZc
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4953F724B96D2F856C636655B87D0@DM6PR02MB4953.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4953;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4953;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4953;4:CqO0AorXi1eMCybOsCHDhCNIvXlcBeKCD6bhF+AGOTYwr2tY0vXMvbQoa+0Sy99ZC+w/pI+zNPKyo8Sx21uLlLpOXcYWdzKT6MX3XPwS719IcqBSRf8RP9SHws57KHAP14DAsD2I5eFQS5sWgJBSh8PosBQ2gKpmbAu7I33h6DD1+sxsCn75VRAAEU9rmrDZ1EG/e/tkRMyO3ajQs6Yz/8Bmk2TO6uIGWaZmDb4yKlRNFIpwMinteJ+30KJmw/P50qJumaUjIQFeEQe4JQANtw==
X-Forefront-PRVS: 0703B549E4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4953;23:J1f+0JvK05oUgZivVSnKFMbfGXIX/5slugvrQRlIx?=
 =?us-ascii?Q?B6O4nTcwt2aG2ExA4TfDWnGNeW/wzAQiWkkOlRo9b6QMz5QebUGOrw8K303G?=
 =?us-ascii?Q?6Ga2QglR4Pv1NwUazc+LV9vQYfOQMDHDrmjJIudKe5KSr3UiOo8pacVD//jf?=
 =?us-ascii?Q?hv2odImbG3hrUtTbH+2BGOuBUFjsAlCTboy0HYRb5kUcfDsbvO2uVM/8s4aj?=
 =?us-ascii?Q?9a0iEpji6PCuABl5rqvoZjJiO+hDgpJ8Ru4itbThB+uY77JpoV3TNB7/YoFu?=
 =?us-ascii?Q?bGKbbus8OJH6BmK2aAfjnTJ8iN5OpnB69WTEvNGZIbC8tTyy4frRQMP+0Hlx?=
 =?us-ascii?Q?NI32oCdJDJFzIutJ+RXqLi9likTACu3KfyhLbm4QrV1ZfzFN16N7YrwEitto?=
 =?us-ascii?Q?yFvit0xectOvYbeA2T8gT3jSZxfFElJdrUtNmmo3n64HZMXsQYZqKteXum/D?=
 =?us-ascii?Q?ZpE4CJ0LD0GCny7qKsDmNeHWYCPLfbQZEllAgwkZTRpP12PnppWP63BXn4D8?=
 =?us-ascii?Q?viiM9esSW1n5guqKLHjhZgplsC8/WJMPk2DYUrlizfRrQdbDhYRcxblvY2tO?=
 =?us-ascii?Q?foBH96uKo1ip5h/JKqkXXZ59FQ18owdTRA7TI6TxcReHYh1q0ICA1RAmVAMq?=
 =?us-ascii?Q?7Ekg7eckMfhMGCCkEiWBhAXh4XH9lN5XMnemXhJIQu9NkMc6uXuXrJ/7YDjO?=
 =?us-ascii?Q?4nzoDGrJKUKdq6rccUcQFT+IwTJGBkCTqGXXZ4LtHVVynsxzTuoH2taAcwio?=
 =?us-ascii?Q?ajTbahZQH1VIANP5gn1kOV+DpO2tbp5oHLus72Q+eCodTTzqi/8G9qp2cFJR?=
 =?us-ascii?Q?TEtM/bUBKzvhu9nwoptVaGPYp96b3fWgdikui+7HHcVALGFlrUQAmb3tlyLy?=
 =?us-ascii?Q?3wqxPgMKNYyFb9Xv1PrE2dZl2v5ItCoNUyNcFxOf2Vx8YjT2GYWuBXYnqz0V?=
 =?us-ascii?Q?jpY4GreWezyt+8HH5cOe51dUCQUrglzB3DWtXvImCZQG5hNymeRZ99LLW1FT?=
 =?us-ascii?Q?d2uz3oj23ZyqOWWYanN5DIygS0nuXM5G+dqjPSSRtRny+ZtwzyEarLPrfygy?=
 =?us-ascii?Q?2+rtP9GXpiUnD2jK/6Xc9uk4Oeb82vmat63bMWvMRLpuTZyguS0UMfpZ2jHY?=
 =?us-ascii?Q?9qP6eXgS2wSpSx8eZ/q2tfMlQ7F3sE2m3MlffxSRHEnxQGiyi3W432hrciQo?=
 =?us-ascii?Q?XuE/4XQbuqUK2AsIwu0YGlYRannAxQQMClvVndssTBk4sUpqwabaBfk++UnQ?=
 =?us-ascii?Q?R9Afpov0PapqkZp+2Y=3D?=
X-Microsoft-Antispam-Message-Info: eglP6yEL9egI8z3NliEIYG3LogR+tZmsrgk+/1Bn6d243i5xZMigDQq/FIVa7BKajzOZsqS8HvspbjNxDSbf9El22aJBtzVfx1UHN9WS2Z8JmNbQrvmq1ag/023drBiefUWW7yk/N6EXKiylaTfex6jzFBdVhoPOsvxs2ylLfR0ygEH9sn7kkfrBF3QWCMJH
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4953;6:MH/QEwYwYzcbApzxaW7LFDeB0VAHYQ/stmjJR7NWs3wTO2HPhq10rkgXOdoBBx4yHyZU6Teg0eJ3g8v9fP2Ly4gcQd35jPXF2SX5x0V+N105GQOMSkVJOwpcPOyd76Yi5FNIv7+KM94KAS7UsKVeBAjedLDx4XuAGeoMexfQpwgsbLxw97JfEX6BzQxc3Y0yNR1e7WFH0NLuiAMNw54efC/oR5Ny5kPfZ4niQsFq7Vt8mnIX0CuzKJA3bJOc0B3rsuMbFbUryz6VtjnNSxQTax1QvMnn5ihsVgDwLVUrXqRTMR/FrzbHQmpGd8ZIHANNNqQKcypulb3WRbNdYITku+NdEWwJ8jlMqxGdButcA8VPJVpZGGZmNqtVzlMmw2oRNDy51tbnYrpzyfUmyB7XRMk+iCq74SG+5z9blA2GBRqwfizsP+qUZgTkIcALes8HQn7KInlux1jugR1r6CDDeA==;5:n15x55EOBQJMGEqyudK8epP4y0ghY8EQmN7br5L0Vh6U+XnhopG+a6TuIVk1Cy677tymdny6d6qX8ueU0wInmbyoxa9rEJaK6G0MuBWmciodiyCUGF5jxBXFRU+WmMcdx/9q9cegijuvT7Daho883+6hCdUVzLEfNaXQWVAvKu8=;24:yJ3b7/TYeucXc8dyBi/ZEqZcIymFhbY5yWTRNZWIdzFfdU0veQwQ1UOCanGHhuNJWtGiaYBorCMf5bCFaGgEhkcIpxI2W8ldfxUUmaiTAD8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4953;7:NJ+L/tTX/Zf2xZfNxJAj+rhsqrYSb44EvivKosOSpoH6qDlC2c9eth0kw9nN331R0l5qUEyLQczRu9PtMK5a0BcAFygJmEAYpY6lh1IWnfEPj+za3Y3opaAKKJ/vtrEdhVHaMMJeifkX3rwvn7E4uj5ANFg91ORxCo3x/B5qB1KlvhcJ+HAUCLljTFg0uF2+gBjPWmya3H4ZWuVbdHu0+8+PrTvd9B7r7MPnxdIxw+PjV+vN8ItnNxxiN11S10TE
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 18:28:11.2269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3274beaa-4a62-48c4-61e9-08d5d224961d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4953
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v8:
 - corrected typo in clk Kconfig
 
v7:
 - Removed xilinx specific clock debugfs API support
 - Added reviewed-by tags for FW and clock bindings
 - Updated clock node name to clock-controller

v6:
 - Broke patch series to have base FW driver and Clock driver user
 - Incorporated code review comments from last FW and Clock driver patch series. Discussed below:
	https://patchwork.kernel.org/patch/10230759/
	https://patchwork.kernel.org/patch/10250047/

v5:
 - Added ATF version check support
 - Updated some functions to be static 
 - Minor function name corrections

v4:
 - Changed clock setrate/getrate API prototype to support 64 bit rate
 - Defined macros for get_node_status return values
 - Moved DT node as a child of firmware
 - Changed debugfs APIs to return data to debugfs buffer instead of dumping to kernel log
 - Minor changes to incorporate other review comments from v3 patch series

v3:
 - added some fixes to firmware-ggs.c
 - updated pinmux get/set function argument names to specify function id instead of node id
 - added new pinctrl query macros
 - incorporated review comments from v2 patch series

v2:
 - change SPDX-License-Identifier license text style
 - split patch into multiple patches
 - Updated copyrights
 - Added ABI documentation
 - incorporated logical review comments from previuos patch. Discussed below:
	https://patchwork.kernel.org/patch/10150665/


Jolly Shah (1):
  drivers: clk: Add ZynqMP clock driver

Rajan Vaja (9):
  dt-bindings: firmware: Add bindings for ZynqMP firmware
  firmware: xilinx: Add Zynqmp firmware driver
  firmware: xilinx: Add zynqmp IOCTL API for device control
  firmware: xilinx: Add query data API
  firmware: xilinx: Add clock APIs
  firmware: xilinx: Add debugfs interface
  firmware: xilinx: Add debugfs for IOCTL API
  firmware: xilinx: Add debugfs for query data API
  dt-bindings: clock: Add bindings for ZynqMP clock driver

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  82 +++
 arch/arm64/Kconfig.platforms                       |   1 +
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/zynqmp/Kconfig                         |  11 +
 drivers/clk/zynqmp/Makefile                        |   4 +
 drivers/clk/zynqmp/clk-gate-zynqmp.c               | 146 ++++
 drivers/clk/zynqmp/clk-mux-zynqmp.c                | 150 +++++
 drivers/clk/zynqmp/clk-zynqmp.h                    |  53 ++
 drivers/clk/zynqmp/clkc.c                          | 737 +++++++++++++++++++++
 drivers/clk/zynqmp/divider.c                       | 219 ++++++
 drivers/clk/zynqmp/pll.c                           | 345 ++++++++++
 drivers/firmware/Kconfig                           |   1 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/xilinx/Kconfig                    |  23 +
 drivers/firmware/xilinx/Makefile                   |   5 +
 drivers/firmware/xilinx/zynqmp-debug.c             | 249 +++++++
 drivers/firmware/xilinx/zynqmp-debug.h             |  22 +
 drivers/firmware/xilinx/zynqmp.c                   | 562 ++++++++++++++++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 ++++
 include/linux/firmware/xlnx-zynqmp.h               | 115 ++++
 21 files changed, 2844 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
 create mode 100644 drivers/clk/zynqmp/Kconfig
 create mode 100644 drivers/clk/zynqmp/Makefile
 create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h
 create mode 100644 drivers/clk/zynqmp/clkc.c
 create mode 100644 drivers/clk/zynqmp/divider.c
 create mode 100644 drivers/clk/zynqmp/pll.c
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h
 create mode 100644 drivers/firmware/xilinx/zynqmp.c
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h
 create mode 100644 include/linux/firmware/xlnx-zynqmp.h

-- 
2.7.4

