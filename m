Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8E9FC617B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34C7217A8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Fg89z4t0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34C7217A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeIMWVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:21:48 -0400
Received: from mail-eopbgr730052.outbound.protection.outlook.com ([40.107.73.52]:25136
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726747AbeIMWVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ox06nRhuBZ83QiwuiSUZA9eud+jxMMrI7mXQp8VrgY=;
 b=Fg89z4t05SKNVPzJsdvR32BBw0/SMoXF6keQs9WvPFH/GPqowbyGR32CU0ug2PqnqW8GoINz5dkqS0D69Sdg+KwKEa80gtS4NDjWdg6uKTZkevZtcVs7BguL7nZhNXSSIYlzi+QneV5TVUKRyfdoXFnD/39pM708AgpN7mOt2Ks=
Received: from CY1PR02MB2138.namprd02.prod.outlook.com (10.166.190.144) by
 CY1PR02MB1368.namprd02.prod.outlook.com (10.161.171.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Thu, 13 Sep 2018 17:11:20 +0000
Received: from CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::d401:dced:c223:a99a]) by CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::d401:dced:c223:a99a%4]) with mapi id 15.20.1122.020; Thu, 13 Sep 2018
 17:11:19 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
CC:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andy.gross@linaro.org" <andy.gross@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        Michal Simek <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>
Subject: RE: [PATCH v3 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
Thread-Topic: [PATCH v3 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
Thread-Index: AQHUShdeo4kqfJ3t0kWr5FODRvW1pKTr1nyAgAKeuJA=
Date:   Thu, 13 Sep 2018 17:11:19 +0000
Message-ID: <CY1PR02MB2138E4213DF88A2CEDAFED2CB81A0@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1536701697-23949-4-git-send-email-jollys@xilinx.com>
 <20180912011003.GA14928@darwi-kernel>
In-Reply-To: <20180912011003.GA14928@darwi-kernel>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [71.202.42.125]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1368;6:CM3PdtKb9R0JqQ7F96GuHarfmkKG1+3VydDBeUANDShVL3DVF31AIMK9pAQDSYZr++Mj0uB/2bGM2x/wsgS3atq3FRotTEGpTRePj2/CIGdADWeDYBXCYRYh2h/qq1efXVKqlgSLccMeElDVNpBz+HPXaLB9ay5HOzdujEza5LjF9YLn/Ing1MZXgziG0w7l57g84+xavJU4bmQqdruT7oFOcOl40Ih+yZTMjVu4RaGY/0LlEchgDrErO98/IU557wKEpcWxWzbYT1kveJdJ91sLJh59nucl+ikr9hvkaqjYz4jsrOBLYydWUJGuVZD5N+QDp1Ay/nGv92tnUWi15dhD6QrT/7zeP7pR7CmYDNkuaMLwywz2GZbcGW82Z7SwZzgEKXtyXkHVp53CcUDOvVEBBReMBFZpJTAKKAYGaCvooAey5WQWriO8Ne2UJrnhvAri1iAyCxCmuTv3FESCbA==;5:haHHKOAP2KfyvtNgAjTH5ZVtqVHpB7TQVKds1O6y8t8d7royC+4Dw7aZSYgbtz9w/NqSu4InbTZdStPePd9DX5VYLEBeghoog1vq5q3FzhtLpcR2gHIJFGfwCoMGfOcFB9oD13stoU45RJ0SQxIyr29KqB5uXFql9XKh1veCOcY=;7:GSIWeYSm5Q4V9w+7OSY4AbI+OlKJMBbEtsiawMtpqKd/3K4u0sPhaQMwyYw/QgZXMzmWLqJR70Xw+DyP95++jLZFQ/nrXAvnLDb36sPk7Vvu835Up7tMe3osZQ2Z3mVmLv98K3rJGUvCEQSy6Y6JXBTtHiyGvSQEJl74hdz+Txlz7XNiiFxePWK3GLgk7KEv8Uq7zgEVuyXgfcCW0C4hwNMombR16Jq5d/I6y1UeGsOT1jOmZwIqsrdkTfeF1Xti
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(51914003)(43544003)(13464003)(68736007)(54906003)(6506007)(53546011)(102836004)(105586002)(33656002)(8676002)(66066001)(316002)(106356001)(6116002)(14444005)(55016002)(81166006)(229853002)(81156014)(3846002)(26005)(256004)(8936002)(6436002)(99286004)(6916009)(39060400002)(4326008)(7696005)(76176011)(5250100002)(7736002)(6306002)(107886003)(6246003)(9686003)(25786009)(186003)(53936002)(74316002)(5660300001)(446003)(86362001)(97736004)(305945005)(7416002)(14454004)(11346002)(6346003)(478600001)(2906002)(966005)(72206003)(476003)(2900100001)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1368;H:CY1PR02MB2138.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 21e14048-b00c-4a8b-8723-08d6199bec52
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1368;
x-ms-traffictypediagnostic: CY1PR02MB1368:
x-microsoft-antispam-prvs: <CY1PR02MB13689A70F96B5A70061F028EB81A0@CY1PR02MB1368.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231344)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY1PR02MB1368;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1368;
x-forefront-prvs: 07943272E1
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-microsoft-antispam-message-info: ShiZNe/0ozuF9jZ05s6XK6rdyiaxGev/0hIKn6lD4XNKwZywPiKNPjPiixZ5Q70i7voS1iV5Yk6GTQ5XFmyHMjtIhm9Fmhtw2gmiM5BR7ss/dJOVUxPTu1M1G7Zy1WkcAOwavoeqg9fNHim1agXilpLE4t+GmRNtl9GIcFJNrdaVWqdPhHpliSBnnCypkpCM4z7CA7sOg6ySaLdvxTqli8sZG1bdlsGYwl7mA0rXpe2Jlu27e/rJXvyXiL5m+KFztjOoPONwIW03lcbDJNWppKp88xUXjTSlplzcNRWa6UUiP2Yqb7nsPgd4maN+4gYD6PtoauKDsScRBMimyO1brQxYNCXaudGqTmp1gOkrpsw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e14048-b00c-4a8b-8723-08d6199bec52
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2018 17:11:19.3866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1368
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmed,

Thanks for the review. I will take care of suggested changes in next versio=
n.

Thanks,
Jolly Shah


> -----Original Message-----
> From: Ahmed S. Darwish [mailto:darwish.07@gmail.com]
> Sent: Tuesday, September 11, 2018 6:10 PM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: matthias.bgg@gmail.com; andy.gross@linaro.org; shawnguo@kernel.org;
> geert+renesas@glider.be; bjorn.andersson@linaro.org;
> sean.wang@mediatek.com; m.szyprowski@samsung.com; Michal Simek
> <michals@xilinx.com>; robh+dt@kernel.org; mark.rutland@arm.com; Rajan
> Vaja <RAJANV@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Rajan Vaja
> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v3 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
>=20
> Hi!
>=20
> [ Thanks a lot for upstreaming this.. ]
>=20
> On Tue, Sep 11, 2018 at 02:34:57PM -0700, Jolly Shah wrote:
> > From: Rajan Vaja <rajan.vaja@xilinx.com>
> >
> > Add ZynqMP PM driver. PM driver provides power management support for
> > ZynqMP.
> >
> > Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > ---
>=20
> [...]
>=20
> > +static irqreturn_t zynqmp_pm_isr(int irq, void *data) {
> > +	u32 payload[CB_PAYLOAD_SIZE];
> > +
> > +	zynqmp_pm_get_callback_data(payload);
> > +
> > +	/* First element is callback API ID, others are callback arguments */
> > +	if (payload[0] =3D=3D PM_INIT_SUSPEND_CB) {
> > +		if (work_pending(&zynqmp_pm_init_suspend_work-
> >callback_work))
> > +			goto done;
> > +
> > +		/* Copy callback arguments into work's structure */
> > +		memcpy(zynqmp_pm_init_suspend_work->args, &payload[1],
> > +		       sizeof(zynqmp_pm_init_suspend_work->args));
> > +
> > +		queue_work(system_unbound_wq,
> > +			   &zynqmp_pm_init_suspend_work->callback_work);
>=20
> We already have devm_request_threaded_irq() which can does this
> automatically for us.
>=20
> Use that method to register the ISR instead, then if there's more work to=
 do, just
> do the memcpy and return IRQ_WAKE_THREAD.
>=20
> > +	}
> > +
> > +done:
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +/**
> > + * zynqmp_pm_init_suspend_work_fn() - Initialize suspend
> > + * @work:	Pointer to work_struct
> > + *
> > + * Bottom-half of PM callback IRQ handler.
> > + */
> > +static void zynqmp_pm_init_suspend_work_fn(struct work_struct *work)
> > +{
> > +	struct zynqmp_pm_work_struct *pm_work =3D
> > +		container_of(work, struct zynqmp_pm_work_struct,
> callback_work);
> > +
> > +	if (pm_work->args[0] =3D=3D
> ZYNQMP_PM_SUSPEND_REASON_SYSTEM_SHUTDOWN) {
>=20
> we_really_seem_to_love_long_40_col_names_for_some_reason
>=20
> > +		orderly_poweroff(true);
> > +	} else if (pm_work->args[0] =3D=3D
> > +		   ZYNQMP_PM_SUSPEND_REASON_POWER_UNIT_REQUEST) {
>=20
> Ditto
>=20
> [...]
>=20
> > +/**
> > + * zynqmp_pm_sysfs_init() - Initialize PM driver sysfs interface
> > + * @dev:	Pointer to device structure
> > + *
> > + * Return: 0 on success, negative error code otherwise  */ static int
> > +zynqmp_pm_sysfs_init(struct device *dev) {
> > +	return sysfs_create_file(&dev->kobj, &dev_attr_suspend_mode.attr); }
> > +
>=20
> Sysfs file is created in platform driver's probe(), but is not removed an=
ywhere in
> the code.
>=20
> What happens if this is built as a module? Am I missing something obvious=
?
>=20
> Moreover, what's the wisdom of creating a one-liner function with a huge =
six-
> line comment that:
>=20
>     a) _purely_ wraps sysfs_create_file(); no extra logic
>     b) is called only once
>     c) and not passed as a function pointer anywhere
>=20
> IMO Such one-liner translators obfuscate the code and review process with=
 no
> apparent gain..
>=20
> > +/**
> > + * zynqmp_pm_probe() - Probe existence of the PMU Firmware
> > + *		       and initialize debugfs interface
> > + *
> > + * @pdev:	Pointer to the platform_device structure
> > + *
> > + * Return: Returns 0 on success, negative error code otherwise  */
>=20
> Again, huge 8-line comment that provide no value.
>=20
> If anyone wants to know what a platform driver probe() does, he or she be=
tter
> check the primary references at:
>=20
>     - Documentation/driver-model/platform.txt
>     - include/linux/platform_device.h
>=20
> and not the comment above..
>=20
> > +static int zynqmp_pm_probe(struct platform_device *pdev) {
> > +	int ret, irq;
> > +	u32 pm_api_version;
> > +
> > +	const struct zynqmp_eemi_ops *eemi_ops =3D
> zynqmp_pm_get_eemi_ops();
> > +
> > +	if (!eemi_ops || !eemi_ops->get_api_version || !eemi_ops-
> >init_finalize)
> > +		return -ENXIO;
> > +
> > +	eemi_ops->init_finalize();
> > +	eemi_ops->get_api_version(&pm_api_version);
> > +
> > +	/* Check PM API version number */
> > +	if (pm_api_version < ZYNQMP_PM_VERSION)
> > +		return -ENODEV;
> > +
> > +	irq =3D platform_get_irq(pdev, 0);
> > +	if (irq <=3D 0)
> > +		return -ENXIO;
> > +
> > +	ret =3D devm_request_irq(&pdev->dev, irq, zynqmp_pm_isr,
> IRQF_SHARED,
> > +			       dev_name(&pdev->dev), pdev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "request_irq '%d' failed with %d\n",
> > +			irq, ret);
> > +		return ret;
> > +	}
> > +
> > +	zynqmp_pm_init_suspend_work =3D
> > +		devm_kzalloc(&pdev->dev, sizeof(struct
> zynqmp_pm_work_struct),
> > +			     GFP_KERNEL);
> > +	if (!zynqmp_pm_init_suspend_work)
> > +		return -ENOMEM;
> > +
> > +	INIT_WORK(&zynqmp_pm_init_suspend_work->callback_work,
> > +		  zynqmp_pm_init_suspend_work_fn);
> > +
>=20
> Let's use devm_request_threaded_irq(). Then we can completely remove the
> work_struct, INIT_WORK(), and queuue_work() bits.
>=20
> > +	ret =3D zynqmp_pm_sysfs_init(&pdev->dev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "unable to initialize sysfs interface\n");
> > +		return ret;
> > +	}
> > +
> > +	return ret;
>=20
> Just return 0 please. BTW ret was declared without initialization.
>=20
> > +}
> > +
> > +static const struct of_device_id pm_of_match[] =3D {
> > +	{ .compatible =3D "xlnx,zynqmp-power", },
> > +	{ /* end of table */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, pm_of_match);
> > +
> > +static struct platform_driver zynqmp_pm_platform_driver =3D {
> > +	.probe =3D zynqmp_pm_probe,
> > +	.driver =3D {
> > +		.name =3D "zynqmp_power",
> > +		.of_match_table =3D pm_of_match,
> > +	},
> > +};
>=20
> .remove with a basic sysfs_remove_file() is needed.
>=20
> Thanks,
>=20
> --
> Darwi
> http://darwish.chasingpointers.com
