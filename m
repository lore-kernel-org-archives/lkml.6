Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EBAC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CC52070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="1CjxrDuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbfACNTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:19:06 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:62535 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfACNTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:19:05 -0500
X-IronPort-AV: E=Sophos;i="5.56,434,1539673200"; 
   d="scan'208";a="22932998"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Jan 2019 06:19:04 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 3 Jan 2019 06:19:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MAucc6+MpOhX3uHpTXOw2AAffmO55OpasB+ucbg1Ek=;
 b=1CjxrDucY85/lQS/MmAVyD8Oelif9IEctDvhp2BvCUdt8Hk/sBiRqWl0TQVrxJNPUBJDSW16TlP8yL8iEp0NygwFXifDP+tWqVS+VIsfgSBiMJ0hwT8JVjAa9S0Bcrk9JMmCB35zgSV5J/rkUSjE21ahEchziRcw6F22fMIoqnE=
Received: from BL0PR11MB3329.namprd11.prod.outlook.com (10.167.235.150) by
 BL0PR11MB3154.namprd11.prod.outlook.com (10.167.182.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 13:19:01 +0000
Received: from BL0PR11MB3329.namprd11.prod.outlook.com
 ([fe80::8dcd:83ed:e155:9e8c]) by BL0PR11MB3329.namprd11.prod.outlook.com
 ([fe80::8dcd:83ed:e155:9e8c%6]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 13:19:01 +0000
From:   <RaghuramChary.Jallipalli@microchip.com>
To:     <muvarov@gmail.com>, <linux-kernel@vger.kernel.org>
CC:     <UNGLinuxDriver@microchip.com>, <steve.glendinning@shawell.net>
Subject: RE: [PATCH] usbnet: smsc95xx: allow to down ethernet link
Thread-Topic: [PATCH] usbnet: smsc95xx: allow to down ethernet link
Thread-Index: AQHUmRKJyp9Nu4B2WU2tC5ANn37q6qWdlNeg
Date:   Thu, 3 Jan 2019 13:19:01 +0000
Message-ID: <BL0PR11MB33295D7A045B9EDE271DA8B19F8D0@BL0PR11MB3329.namprd11.prod.outlook.com>
References: <20181221094553.13137-1-muvarov@gmail.com>
In-Reply-To: <20181221094553.13137-1-muvarov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RaghuramChary.Jallipalli@microchip.com; 
x-originating-ip: [118.185.82.6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR11MB3154;6:XbYl3MVGo3RvsINtS5XQOb5Njz1k3WSdJ3zUlxFn3g22JYbJx4M7lXkrqh4qbot2xVdiA5vbSRYLa+JBVo+ZDb2c+/3mbbNYDd+JCjUz1wJl8UCWfITODSRqyuQdCz5tQTI2NgoYMLhhaoiqYf7bGmV/7B5MczX2ZXWvHvMD6Yd2S3uCEZo8rLH4bK54R1rBqOs77B/I1iyx4r/6qH8f/J6RE+ypMBmte9M4niP2mve3xbhi1ePmlch68+LwOJilf44GeWaWGDytC/8hWtQuxjGgWool1pl23hqDYmDYFHgD2SWyAwQWl/ddnFTUwAb2Tsc1NPdPaREWO2K3Al62M+QWwxyzuELl3gDwogHOOUI0cbp5vfUsUSSG7L7bMk/4Hhl+FGTeOlfYrt68A0Cx3l6Gj7rpNDSM5fRn3wwUv5moXXK2L82oxymChC+qrSAmZXBC2/8jQlsT0ThMAPxKDg==;5:B5rILSkygmAFdBdwo0I2gfsWY4kq141QbJfT1UhpnQPVXGBm1qTnMal+yWxSIJZxyutthY2tJAbNDXBjRa/eHuzLz4w9t70CtYhWRRGUROr9hf1iQvjvhZmGSnuvHscsxKiAWXOv9ppe37vZha3CupSih9kqr20rs72nwbKb2Ki6KvbcJp9kfIoFqNvE2ZFCxJpaFkeID+6I45fbmZQkrA==;7:WcR+H61M3QITfEH2cBBoBBzB/7HsHUCm44qLMBU5DmY0voaK/Pmzptaf2BsquSnwVSE65dfMjJLXfsZnEVlwQO9J22yGt5/nVkpNyGBxHg8l7RLGVbWiWDRAC620JJvkVINI7kuFvsBdqYrxODE0PQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c90267b5-ae93-4a39-d38a-08d6717e071d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BL0PR11MB3154;
x-ms-traffictypediagnostic: BL0PR11MB3154:
x-microsoft-antispam-prvs: <BL0PR11MB3154DCA9661AE438AAD3AC149F8D0@BL0PR11MB3154.namprd11.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(823302103)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BL0PR11MB3154;BCL:0;PCL:0;RULEID:;SRVR:BL0PR11MB3154;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(51914003)(7696005)(76176011)(53936002)(9686003)(74316002)(6506007)(229853002)(7736002)(305945005)(26005)(102836004)(186003)(478600001)(11346002)(476003)(71190400001)(71200400001)(2501003)(446003)(6436002)(55016002)(33656002)(6246003)(25786009)(4326008)(3846002)(6116002)(486006)(66066001)(110136005)(39060400002)(5660300001)(99286004)(8676002)(14454004)(8936002)(81156014)(81166006)(316002)(2906002)(97736004)(68736007)(86362001)(106356001)(256004)(72206003)(105586002)(54906003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR11MB3154;H:BL0PR11MB3329.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kh4LN/lmfs7Lvr7IMH/r1YhYNmnIr7gun1mWy1MQ8j01MENoZxpUf+aZoGYiRK5xRiN16G3Hwv8GO2xCP3sLCpCgLusK8DJkQkmWgCf6V/m4MQojwZoej8YrotZMLfJSTsPbHbPNFQgkHSEuJYvNaBwWLVpSbLgwnfN06jA8kH8RdAf9YzJDwfc2dUOfEHpW46ckyx5plrmmzc3TuAuLKxfdEg6n2mZNlzTaWec6kiFujqg67LIQdWFVY62/lx3aNnsM+4Xs/HRvjsAHhgCHtiBxZzXoc1AjcTQMpcYIhe6oT/lqzrMScW8ZEHVhqnHY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c90267b5-ae93-4a39-d38a-08d6717e071d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 13:19:01.8116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3154
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> allow ifconfig ethX to down ethernet link. Ethernet part of chip is switc=
hed to
> power down more and on ifconfig up driver does soft reset and restores it=
's
> state.
>=20
Thanks for the patch.
If I understand the issue correctly, the ethernet link is not going down in=
 power down mode? Pls clarify.
Does these changes be applied to smsc75xx driver as well??

Thanks,
-Raghu


