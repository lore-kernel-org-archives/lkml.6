Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AABC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A0F20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fAT0H5ZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A0F20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeLLJZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:25:05 -0500
Received: from mail-eopbgr40046.outbound.protection.outlook.com ([40.107.4.46]:6513
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726514AbeLLJZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZBbW9MQK34/ZmbqOFmZOQXsDTDXuXNmqX7NSGAsGFo=;
 b=fAT0H5ZUjSHVMBMJZTMCwOAKc/587kKT9edd6nfTW8fhLKZvthdUfn8Tznqvr0JDLgt9H3T+D4EoM2AmhoHSahTj+Xsj3/VFPwimwucbxlzdVf6LUAARgn95+v7mW3QwL2ig+z0GLNha+6kE97gyVXf/j9Oafl3cwjlRB8zj4xY=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB5856.eurprd04.prod.outlook.com (20.178.204.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Wed, 12 Dec 2018 09:24:59 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::811d:1992:9a6a:bb3f]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::811d:1992:9a6a:bb3f%5]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 09:24:59 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Peter Chen <hzpeterchen@gmail.com>,
        "pawell@cadence.com" <pawell@cadence.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "sureshp@cadence.com" <sureshp@cadence.com>,
        "pjez@cadence.com" <pjez@cadence.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>
Subject: RE: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHUkIWPYiPxiKamv0Kw/89WiQfMk6V5dPgAgABym4CAAHVkgIAAUW2AgAAFjTCAABX8AIAADghg
Date:   Wed, 12 Dec 2018 09:24:59 +0000
Message-ID: <VI1PR04MB532701CEDE94C068759987688BA70@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com>
 <1544445555-17325-3-git-send-email-pawell@cadence.com>
 <87h8fkmfar.fsf@linux.intel.com>
 <BYAPR07MB47095110AF28CC11B4C9E144DDA60@BYAPR07MB4709.namprd07.prod.outlook.com>
 <CAL411-ryK2LLZVg5_sLkCYOuhwdHLVm5XavSyC9nbEXZah_43w@mail.gmail.com>
 <877egfmdxk.fsf@linux.intel.com>
 <VI1PR04MB5327B1CB6C6BC7D293701F1D8BA70@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <871s6nm9db.fsf@linux.intel.com>
In-Reply-To: <871s6nm9db.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5856;6:jhoCaPbmCRylvT2k8j79TDrT+Wwz5LCJt5b+6RHCmxdd7Qi089zUsh7iMloWltjVagcK74w9Ybt67+GY2Gm2GzOtB5cx6TynvJdLdgN1eb0tSlVCpv9y+anIZXt6mFkHorKX6ql0dSioa8canqfKV69XEBXONWQj0rjqQiKutMZw+9WAryET+8/Kgw2fwRqlDXKYcoASfSCaaXrmuPEnJi7u0EArWLL1yRtinx34G+yn0py9QMc1qebsmNuhN530cb3OaC/ZRHgyI11q2H6O5WaD2WrL/qwDICdmKZrsc7Skwk1FzjtOccU5cCfZFVYd7jrqhj0vG14pHgTp2znZGLWk/aLPejhl5YINjexew1h4+1aSHLX08w2LVmRRrXpc3XvCCwbDCyFZQsL4cVSpnCaIDEUlrsPf5Qb3p+rwanVIN3yleOADAKYIQuSgWkv3d/VPe92gwvzU6mFivu6efg==;5:EE3xwznqJ3iluT1Wa0RRFKFPigl1gLMJ/2shRFbKz8eieupfWPs93FXYP8qi+VzS0scn8ubw/dXr0a3Q570MtiLnSPgKZYTpre+m6+pfFH7ndfSrgfxmN7LBxBOUIZpuJ6rUrXR3bhCos7aIzXjlT9c/ul3s4nKfwVTS+ZmmjFE=;7:gtvdL6Q/Nd1frmgd0zoCHh3kvO4uJ+C6Jr4LUB1nzHp37qOk3rxmd3Z6Ucd1x7iF0d/riYhocj3VYvPWzWktMq9HhBOfm3L0TQgQ4I6YaDTVh36dHtsRB8IwjMFvpxgYGjbCMuDwo+4+yph3YSupvw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7d9925ee-211f-429a-6c51-08d66013b02c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5856;
x-ms-traffictypediagnostic: VI1PR04MB5856:
x-microsoft-antispam-prvs: <VI1PR04MB5856861BDDEC44D14E84B2708BA70@VI1PR04MB5856.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5856;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5856;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(346002)(396003)(199004)(189003)(44832011)(6246003)(14454004)(4326008)(11346002)(26005)(7736002)(2501003)(966005)(97736004)(476003)(25786009)(6116002)(3846002)(8936002)(8676002)(2906002)(305945005)(71190400001)(66066001)(81166006)(71200400001)(81156014)(5660300001)(86362001)(9686003)(33656002)(68736007)(6436002)(55016002)(99286004)(256004)(105586002)(14444005)(106356001)(229853002)(53936002)(478600001)(6506007)(76176011)(39060400002)(102836004)(7696005)(54906003)(110136005)(74316002)(486006)(7416002)(186003)(446003)(6306002)(93886005)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5856;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: is2yHUF0XxzTPVGoqLhTN4ru/uMYz/o8AJ3OaVHaGYMn7rfRRJZXny35Cpj1fL5S643TjlCRBpRPS4AolxoTS62IaA6MnGDa12P9743Ru/8gQ/XTcVs8zmwc/jG+wz3vZMI3Wfn8GNP+YOHbN8T6hSabwCVbCZR50Zj22Lb0dGEASH1H6B/DDt5XuyjYYz/N/tLqLme6tLile4S66be0akSWpWwiZbr7Q4uHOlOWWOj1Z3utKp5c4DKrkKYtO6kVpl4nzWWmTPswMiM9TEp3PRf2J9gMZoKY6m+dPkI3KrIWZf4Ntw+ZbI02g8/xAjoN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9925ee-211f-429a-6c51-08d66013b02c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 09:24:59.4419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> >
> > Interrupt handler (hardirq context) at CPU0, and process at CPU1, eg
> > role switch, unload module, etc.
>=20
> the process at CPU1 would need to disable interrupts (spin_lock_irq() or
> spin_lock_irqsave()), not the hardirq on CPU0 as that already runs with i=
nterrrupts
> disabled.
>=20
> https://www.kernel.org/doc/html/latest/kernel-hacking/locking.html#table-=
of-
> minimum-requirements
>=20

I see, thanks.

Peter
