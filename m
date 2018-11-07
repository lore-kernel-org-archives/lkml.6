Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263F2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82552085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="LkuZ6lbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82552085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbeKHAeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:34:12 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:56810 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbeKHAeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:34:12 -0500
X-IronPort-AV: E=Sophos;i="5.54,475,1534834800"; 
   d="scan'208";a="22490415"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Nov 2018 08:03:20 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 7 Nov 2018 08:03:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aG9WbN7nkDNBemQhG1bQE1xkjMq8l1srsu8/h7OQUtg=;
 b=LkuZ6lbt2lWVqpgJe8fIOGw9QGU3t8rTH/lAWXPB5gouIu2g5lmPP/vLDMiIcB9chAVjPoah93dmpcBmJNyenumaBilbGYpVxIxpKcRvHW+CTGpJSCGY5/ZKcggaX9zFZ1UgYUrX8mHmIBv+SaA3jFDXI3iQ/JQpTq6+8Y2PoBc=
Received: from BLUPR11MB0740.namprd11.prod.outlook.com (10.163.216.18) by
 BLUPR11MB0612.namprd11.prod.outlook.com (10.163.125.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 7 Nov 2018 15:03:17 +0000
Received: from BLUPR11MB0740.namprd11.prod.outlook.com
 ([fe80::2dca:81f7:b419:fdf2]) by BLUPR11MB0740.namprd11.prod.outlook.com
 ([fe80::2dca:81f7:b419:fdf2%3]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 15:03:17 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 1/2] regulator: act8945: Implement PM functionalities
Thread-Topic: [PATCH 1/2] regulator: act8945: Implement PM functionalities
Thread-Index: AQHUbUe3aB7PxIHxB0GWg8NpuJvvnA==
Date:   Wed, 7 Nov 2018 15:03:17 +0000
Message-ID: <b17eeca5-e517-393e-d9a9-bfb4121c5857@microchip.com>
References: <1540570753-16370-1-git-send-email-claudiu.beznea@microchip.com>
 <1540570753-16370-2-git-send-email-claudiu.beznea@microchip.com>
 <20181107145349.GA6809@sirena.org.uk>
In-Reply-To: <20181107145349.GA6809@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P18901CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::32) To BLUPR11MB0740.namprd11.prod.outlook.com
 (2a01:111:e400:594c::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR11MB0612;6:E4smit7P6Tq29bnfVmVYbQkCNea/SjYH8ABwxFveq4XlhVP88nkDsXpYh/PMCdoBMysaiIJAEfG6XEaWBaEA3V7d+22IE7bea9ODGXzh8HetoMr0Z9hKfQUaruUD9YTzO8Q7EC5Kc+vZhSWh2dGmZcG78bitxEepLEyP98rjVBbkIGa8CPX+vw4noVlRTJigUD203Tjd9wP8s6XvZwJGQj3RXADnAOB3d1W/QcziLIcC3Y1QDTf5wT/CAz1F1Je5zyKbTTvocjJiIW0JBnM4he/xHBJLchJLLk5o9G3xc8BHMmQ2l4MxoMCn29YS1VEIHyFfsxT8ywPRwdpbwriU93HpOKLUSZLjSTLVaq/QVZGQ7hEwO0wGEmCrLXGps4obKmxuc6q+ap24n1xEccN5xSZ3VoUkibTSKP+cBUkK/Dqu7bo4p2i/QAq1bLaovQPY5C6YBmEe8IyueMrf0Q6J6g==;5:lRxHrCQr0ehXzemv6xwLAvvN8MRR63i44GhE5i/8BsQaIte0HT12lbB7KMl1m7knyn2vlaufbrId9STrUIzuZ31GiIEmHJJ4rXjCUurmzWlR3exuzMbSVZfAr9IepN9Mw2DFrXWlm2awKhNb0e7i3QRjRsSwMa68zfTHTIN7LOs=;7:a4/F3x/y181I5u6QNK+/PMF000kMcOESgzTPCLySa+jVIKN+pmsiSgc3NuugdP4C/8CWiWrIMcdDNHcWfqpxZIXaqyZIB3Xe66OeW1Ns3En/i+AgjXpibZ7sDpRAa/Zy2ig7jZt1lNpMsqP74BwFFw==
x-ms-office365-filtering-correlation-id: 1afe31ee-4efe-4ffb-fdf8-08d644c2263c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BLUPR11MB0612;
x-ms-traffictypediagnostic: BLUPR11MB0612:
x-microsoft-antispam-prvs: <BLUPR11MB06122A845821866E4255A17887C40@BLUPR11MB0612.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BLUPR11MB0612;BCL:0;PCL:0;RULEID:;SRVR:BLUPR11MB0612;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(136003)(39860400002)(189003)(199004)(68736007)(97736004)(5660300001)(14444005)(11346002)(446003)(2616005)(72206003)(71190400001)(71200400001)(2900100001)(2906002)(476003)(486006)(256004)(478600001)(31696002)(25786009)(86362001)(7736002)(305945005)(4326008)(66066001)(316002)(54906003)(76176011)(8676002)(99286004)(81156014)(81166006)(6512007)(53546011)(6506007)(386003)(52116002)(8936002)(53936002)(6486002)(229853002)(6246003)(3846002)(6116002)(31686004)(14454004)(106356001)(105586002)(102836004)(186003)(6436002)(6916009)(36756003)(39060400002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR11MB0612;H:BLUPR11MB0740.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NBTbNxaOB6atwXfmgDz5uYJjm+0gLQEqcDt9SQJwPptEGLJ0IkPADEvuwgoNfq0YZqAwKy9kfguMI2YQaBjdXbi1TN+GFXZGgmIl61jFV7woSLoekn+MaE41N1LTz59BM4b0pdB5vwKZErcE9f1HMyUxll3yUK6lhIOvm2J5jAOti0H/WCiGmm14+WB0gEpeDMspq5HY0IcQxeEoR4F3k4j6uCuKPDGt9XmkOk2Kaw6hDWOgt6DbT2O2if3UzhdNlSIuh0cun7ykf+967hRBgGoi68KUxJOmJjsslOkC7ncHV19yV7R723vGeHG0xWRcoJi54w5LxUb2Li68r8szV9u6cbK+bVKgt2hbp9W/CqY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <D9FAE817086E4342B007D8321A94E347@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afe31ee-4efe-4ffb-fdf8-08d644c2263c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 15:03:17.7410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR11MB0612
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07.11.2018 16:53, Mark Brown wrote:
> On Fri, Oct 26, 2018 at 04:19:48PM +0000, Claudiu.Beznea@microchip.com wr=
ote:
>=20
>> +static unsigned int act8945a_of_map_mode(unsigned int mode)
>> +{
>> +	if (mode =3D=3D ACT8945A_DCDC_MODE_POWER_SAVING)
>> +		return REGULATOR_MODE_STANDBY;
>> +
>> +	return REGULATOR_MODE_NORMAL;
>> +}
>=20
> This should error out if it gets an unknown value rather than silently
> mapping it to normal - we don't know what the user intended to set here.
> There should also be some binding documentation updates saying what the
> values that can be set are.

Sure, I will update it on next version.

>=20
>> +static void act8945a_pmic_shutdown(struct platform_device *pdev)
>> +{
>> +	struct act8945a_pmic *act8945a =3D platform_get_drvdata(pdev);
>> +	struct regmap *regmap =3D act8945a->regmap;
>> +
>> +	/*
>> +	 * Ask the PMIC to shutdown everything on the next PWRHLD transition.
>> +	 */
>> +	regmap_write(regmap, ACT8945A_SYS_CTRL, 0x0);
>>  }
>> =20
>=20
> This shutdown function appears to be independant of the mode setting and
> would be better split out as a separate patch (you could have one patch
> adding the regmap stuff, one for this and one for the mode setting).
> It makes review a lot simpler if each patch does a minimal set of
> changes.

Ok, I will split them in next version.

Thank you,
Claudiu Beznea

>=20
