Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeENHr4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:47:56 -0400
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:63808
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752310AbeENHrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:47:51 -0400
From: Yinbo Zhu <yinbo.zhu@nxp.com>
To: Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Catalin Marinas )" <catalin.marinas@arm.com>,
        "Will Deacon )" <will.deacon@arm.com>,
        "Lorenzo Pieralisi )" <lorenzo.pieralisi@arm.com>
CC: Xiaobo Xie <xiaobo.xie@nxp.com>, Ran Wang <ran.wang_1@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>, Jerry Huang <jerry.huang@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Jiaheng Fan <jiaheng.fan@nxp.com>, Po Liu <po.liu@nxp.com>,
        Nipun Gupta <nipun.gupta@nxp.com>,
        =?utf-8?B?SG9yaWEgR2VhbnTEgw==?= <horia.geanta@nxp.com>,
        Priyanka Jain <priyanka.jain@nxp.com>, Sumit Garg <sumit.garg@nxp.com>,
        costi <constantin.tudor@freescale.com>,
        Bogdan Purcareata <bogdan.purcareata@nxp.com>,
        "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS"
        <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
        Andy Tang <andy.tang@nxp.com>, Ying Zhang <ying.zhang22455@nxp.com>
Subject: RE: [PATCH 3/9] soc: fsl: set rcpm bit for FTM
Thread-Topic: [PATCH 3/9] soc: fsl: set rcpm bit for FTM
Thread-Index: AQHT6NlaIDu3kVsLXEyLUnaiWWDj6KQqwW0AgAPgnxA=
Date: Mon, 14 May 2018 07:47:45 +0000
Message-ID: <HE1PR0401MB1945EAD443377803A9F9EA5CE99C0@HE1PR0401MB1945.eurprd04.prod.outlook.com>
References: <20180511033530.7931-1-yinbo.zhu@nxp.com>
 <20180511033530.7931-3-yinbo.zhu@nxp.com>
 <AM4PR0401MB16995DFED0376ACE0DD5E7A78F9F0@AM4PR0401MB1699.eurprd04.prod.outlook.com>
In-Reply-To: <AM4PR0401MB16995DFED0376ACE0DD5E7A78F9F0@AM4PR0401MB1699.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2010;7:B0tO1HmpQSL/jA5SISDsvrELwkY11oV495c+l2iVQh3nhromhJQy3kb/xC9WovPtP/9Y3sO78vDmf+Mlibmru1bFLUMZhALIn9cEBaZ7zmcWsKKwf9rNdGdRHn/Ve0NptzKKUgr9EKOPCD9Hao4qpuv6uflufsBX+cuuN/D2Y6kob8QFzVR8xVKduevuNGoTkEBPagawiZqwtkadazXeU3cRIdCse2K0tscVRTiKuJYcydhWk5c8JH3TBEd9VFNq
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2010;
x-ms-traffictypediagnostic: HE1PR0401MB2010:
x-microsoft-antispam-prvs: <HE1PR0401MB20106FD5CD31838F1B0BE98BE99C0@HE1PR0401MB2010.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(788757137089)(101931422205132)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0401MB2010;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2010;
x-forefront-prvs: 067270ECAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(39380400002)(396003)(13464003)(189003)(199004)(66066001)(99286004)(11346002)(9686003)(446003)(7736002)(3660700001)(6306002)(3280700002)(6246003)(229853002)(6436002)(25786009)(53936002)(102836004)(2906002)(105586002)(7696005)(8936002)(305945005)(5250100002)(53546011)(33656002)(110136005)(6506007)(2900100001)(106356001)(97736004)(316002)(478600001)(7416002)(8676002)(486006)(476003)(55016002)(76176011)(74316002)(26005)(86362001)(3846002)(44832011)(68736007)(966005)(81166006)(81156014)(54906003)(5660300001)(4326008)(14454004)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2010;H:HE1PR0401MB1945.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: xCvebRothdrbJ8DQpwlQU4SW1raVtdFC7b3VshMWtHq1RkpUaGdAVNUFNawMSbDRaD8MRfsW8DG00d/ubqGq2OSIAfQOnm1+j6+Qs4br6+cRpi1YKM+eto2LInUGVghny/0KHgVAZsjAfbbT8/MLVudVNnje6ILwzAWfVaobAiJyYtjBIFAGnBpQjxcIfxdp
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d83abb11-daf7-4280-a0fc-08d5b96efb9e
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83abb11-daf7-4280-a0fc-08d5b96efb9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2018 07:47:45.8997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2010
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4E7m1MQ008013



-----Original Message-----
From: Leo Li 
Sent: 2018年5月12日 1:00
To: Yinbo Zhu <yinbo.zhu@nxp.com>; Yinbo Zhu <yinbo.zhu@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Catalin Marinas ) <catalin.marinas@arm.com>; Will Deacon ) <will.deacon@arm.com>; Lorenzo Pieralisi ) <lorenzo.pieralisi@arm.com>
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>; Ran Wang <ran.wang_1@nxp.com>; Daniel Lezcano <daniel.lezcano@linaro.org>; Thomas Gleixner <tglx@linutronix.de>; Shawn Guo <shawnguo@kernel.org>; Madalin-cristian Bucur <madalin.bucur@nxp.com>; Z.q. Hou <zhiqiang.hou@nxp.com>; Jerry Huang <jerry.huang@nxp.com>; M.h. Lian <minghuan.lian@nxp.com>; Qiang Zhao <qiang.zhao@nxp.com>; Fabio Estevam <fabio.estevam@nxp.com>; Jiaheng Fan <jiaheng.fan@nxp.com>; Po Liu <po.liu@nxp.com>; Nipun Gupta <nipun.gupta@nxp.com>; Horia Geantă <horia.geanta@nxp.com>; Priyanka Jain <priyanka.jain@nxp.com>; Sumit Garg <sumit.garg@nxp.com>; costi <constantin.tudor@freescale.com>; Bogdan Purcareata <bogdan.purcareata@nxp.com>; open list:CLOCKSOURCE, CLOCKEVENT DRIVERS <linux-kernel@vger.kernel.org>; open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-arm-kernel@lists.infradead.org; open list:FREESCALE SOC DRIVERS <linuxppc-dev@lists.ozlabs.org>; Andy Tang <andy.tang@nxp.com>; Ying Zhang <ying.zhang22455@nxp.com>
Subject: RE: [PATCH 3/9] soc: fsl: set rcpm bit for FTM



> -----Original Message-----
> From: Yinbo Zhu [mailto:yinbo.zhu@nxp.com]
> Sent: Thursday, May 10, 2018 10:35 PM
> To: Yinbo Zhu <yinbo.zhu@nxp.com>; Rob Herring <robh+dt@kernel.org>; 
> Mark Rutland <mark.rutland@arm.com>; Catalin Marinas ) 
> <catalin.marinas@arm.com>; Will Deacon ) <will.deacon@arm.com>; 
> Lorenzo Pieralisi ) <lorenzo.pieralisi@arm.com>; Leo Li 
> <leoyang.li@nxp.com>
> Cc: Xiaobo Xie <xiaobo.xie@nxp.com>; Ran Wang <ran.wang_1@nxp.com>; 
> Daniel Lezcano <daniel.lezcano@linaro.org>; Thomas Gleixner 
> <tglx@linutronix.de>; Shawn Guo <shawnguo@kernel.org>; 
> Madalin-cristian Bucur <madalin.bucur@nxp.com>; Z.q. Hou 
> <zhiqiang.hou@nxp.com>; Jerry Huang <jerry.huang@nxp.com>; M.h. Lian 
> <minghuan.lian@nxp.com>; Qiang Zhao <qiang.zhao@nxp.com>; Fabio 
> Estevam <fabio.estevam@nxp.com>; Jiaheng Fan <jiaheng.fan@nxp.com>; Po 
> Liu <po.liu@nxp.com>; Nipun Gupta <nipun.gupta@nxp.com>; Horia Geantă 
> <horia.geanta@nxp.com>; Priyanka Jain <priyanka.jain@nxp.com>; Sumit 
> Garg <sumit.garg@nxp.com>; costi <constantin.tudor@freescale.com>; 
> Bogdan Purcareata <bogdan.purcareata@nxp.com>; Meng Yi 
> <meng.yi@nxp.com>; Wang Dongsheng <dongsheng.wang@nxp.com>; open 
> list:CLOCKSOURCE, CLOCKEVENT DRIVERS <linux-kernel@vger.kernel.org>; 
> open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
> <devicetree@vger.kernel.org>; linux-arm-kernel@lists.infradead.org; 
> open list:FREESCALE SOC DRIVERS <linuxppc-dev@lists.ozlabs.org>; Andy 
> Tang <andy.tang@nxp.com>; Ying Zhang <ying.zhang22455@nxp.com>
> Subject: [PATCH 3/9] soc: fsl: set rcpm bit for FTM
> 
> From: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> 
> Set RCPM for FTM when using FTM as wakeup source. Because the RCPM 
> module of each platform has different big-end and little-end mode, 
> there need to set RCPM depending on the platform.
> 
> Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
>  .../devicetree/bindings/timer/fsl,ftm-timer.txt    |    7 ++
>  drivers/soc/fsl/layerscape/ftm_alarm.c             |   92 ++++++++++++++++++-
>  2 files changed, 94 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> index aa8c402..15ead58 100644
> --- a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> @@ -3,6 +3,13 @@ Freescale FlexTimer Module (FTM) Timer  Required
> properties:
> 
>  - compatible : should be "fsl,ftm-timer"

>Hi Yingbo,

>This is a change that breaks backward compatibility and not acceptable.
Hi leo,

This patch if I keep the change as inner patch and push it to dash-linnux but I will not push it to upstream, It's okay?
As far as I know, there was a other patch and file for replace the file and that the patch is already on the upstream 
https://patchwork.kernel.org/patch/9391293/

> + Possible compatibles for ARM:
> +     "fsl,ls1012a-ftm"
> +     "fsl,ls1021a-ftm"
> +     "fsl,ls1043a-ftm"
> +     "fsl,ls1046a-ftm"
> +     "fsl,ls1088a-ftm"
> +     "fsl,ls208xa-ftm"
>  - reg : Specifies base physical address and size of the register sets for the
>    clock event device and clock source device.
>  - interrupts : Should be the clock event device interrupt.
> diff --git a/drivers/soc/fsl/layerscape/ftm_alarm.c
> b/drivers/soc/fsl/layerscape/ftm_alarm.c
> index 6f9882f..811dcfa 100644
> --- a/drivers/soc/fsl/layerscape/ftm_alarm.c
> +++ b/drivers/soc/fsl/layerscape/ftm_alarm.c

>There is no such file in the mainline kernel.  So it looks like the patch set is

> based on some internal git repo instead of the upstream Linux kernel.  This kind of patches

> shouldn't be sent to the upstream mailing list for review.

>Regards,

>Leo
This patch will not to upstream.

Regards,

Yinbo.
