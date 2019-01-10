Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D951EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFF3214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="URAyVSA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfAJDqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 22:46:22 -0500
Received: from mail-eopbgr1320112.outbound.protection.outlook.com ([40.107.132.112]:1874
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbfAJDqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 22:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvDmXYwkTIcmRN/5X/HMMAAXFerpwEYAPW4Kf3jgc1A=;
 b=URAyVSA2TXJB5/WoA6D8AkOQbELQacCYhHudQyvAMw0WN6G3dTwldEn0GufMXwA9ho05QVie+r8nq/xNbRui/ibcq/TdkX2WBMUi0gfT2cg5KExpcvK1tFYx64oR5QoVfj1OaClauEcYWezimtZ0S26i3V3t8n3Xr0jyktipPrw=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0140.APCP153.PROD.OUTLOOK.COM (10.170.188.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.4; Thu, 10 Jan 2019 03:46:13 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::99da:e3db:6b66:c8d4]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::99da:e3db:6b66:c8d4%6]) with mapi id 15.20.1537.005; Thu, 10 Jan 2019
 03:46:13 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kimbrownkd <kimbrownkd@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] Drivers: hv: vmbus: Expose counters for interrupts and
 full conditions
Thread-Topic: [PATCH v2] Drivers: hv: vmbus: Expose counters for interrupts
 and full conditions
Thread-Index: AQHUpLAXsstUN2kOgUOyNPgAu50eB6Wn2pVw
Date:   Thu, 10 Jan 2019 03:46:13 +0000
Message-ID: <PU1P153MB01694872F5B98FA40AAC3E1EBF840@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <0181213190901.GA3843@ubu-Virtual-Machine>
 <20190105043518.GA4072@ubu-Virtual-Machine>
In-Reply-To: <20190105043518.GA4072@ubu-Virtual-Machine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-10T03:46:10.4319197Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2601:600:a280:1760:d0e9:4c08:1777:c6a3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0140;6:LCAcFnKgQJHEnZ3ION9OYGn1jW2Rfxltr5uLCFinljYLFisgy5WshcaA5auhQbsl9Wlpw9zPOQRE0SUlymXt7Zet2UUbwwh3qF3FVhkMp6mVWHGL+sr3sfPw0xxojt8ES4z6rV9fMgKfGJEgg63RX8Zeesyq4vj/cznZeo0h1arxTdzeBX0n7QYSeTt5tywH3UVyO/sijzaeevdoqKT2uNGLtmPwo3oN2MZ65mCbf2M+TugFDqF6qTpu4gdgIZYx9acFwzSwLKk+Vs4kBMu5uyAUP+RJ1mhXtC4OB1LSVqqw+/WsobZvmasklM14qEXA0IzjTFoUQBZxoIDJSEybYWXJwuv/kwIc5JTLWoX61d9Ya9Waf/vgqQpod1nOp8MBvBiyehPfWMU++3woMBuj/HpMC6Z4DFXhymdh21xcchDYKcRlwLC05c1rUd6QWHskwveTpNNMUrxYNMLeS/H+eQ==;5:y+OEwELxVqA1vn+meHN5QhqIj/Co7MP3b+uB1EL12At6yCBOmNfovamDermNyOkihk/Urv8oZ6TRF4PFw09WuqKjoWgyVV4djhdRGEodce+LQRnoRxBXiB4enBztKkTPVhbs+DeCIzjTr5hjACwR3v27X9+L5RFpZ32NSSXF91SQSRMuqSXlp11Vazdh1KSdhp0Mx/kAhFIsQ1YPX7bAoQ==;7:vyV5h68MoKXnbwsk1GiOPAWDXLWZWG3UJ8cAuTlRmNe1V5L3FF5caAWaugmrzY05HqdwxHt5bmva3t9czFTtvzoeUURUO14cCxsv95XCLTnMQMI+kcog9kHSX1wO/Q1wEdmEgZEI1BrlmWtMfP3KWQ==
x-ms-office365-filtering-correlation-id: 64d3e32c-702c-4620-c615-08d676ae2b14
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0140;
x-ms-traffictypediagnostic: PU1P153MB0140:
x-ms-exchange-purlcount: 1
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0140DE08DEAEAB9A389FD5A6BF840@PU1P153MB0140.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0140;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0140;
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(396003)(366004)(39860400002)(189003)(199004)(5660300001)(10090500001)(25786009)(558084003)(74316002)(99286004)(6246003)(4326008)(39060400002)(2906002)(8990500004)(7736002)(68736007)(316002)(22452003)(6116002)(110136005)(54906003)(305945005)(33656002)(81166006)(106356001)(8676002)(8936002)(105586002)(81156014)(97736004)(10290500003)(229853002)(6506007)(86362001)(486006)(76176011)(186003)(46003)(6436002)(966005)(476003)(478600001)(6636002)(11346002)(446003)(55016002)(6346003)(6306002)(14454004)(71200400001)(53936002)(9686003)(71190400001)(1511001)(86612001)(7696005)(256004)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0140;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v2TcEFHKwbJK5bPc58VHGgvNqErQq9R+F8GiOhkuec1Jh7E1wYyHON1pKG8imi3JKVU1aGv5O5hfFwfSNB3YtzzwbMzva6VOLHx6jv7RTvriy6IftlnRfsGuPF/Seu8FngRTzTwQgPirWZXExuhyIRDaF/ptBukqf2r1qKSssn0y1ZaIrxPP3lSqqaSHwyOdwpVp4w++HNWxB/bBbmjTFiF5nmjGsaNbP8ipK9uBflezcT9ChNFuXzIGITDoRvEpizMD4DZy3ddb7itYRT4cY4RiZ6DRVDJPIRfPDHOUFJ3pRVAc4ltSWGpX37X+2WzH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d3e32c-702c-4620-c615-08d676ae2b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 03:46:13.4930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Kimberly Brown <kimbrownkd@gmail.com>
> Sent: Friday, January 4, 2019 8:35 PM

...
> +What:
> /sys/bus/vmbus/devices/<UUID>/channels/<N>/intr_in_full
> +Date:           January 2019
> +KernelVersion:  4.21

There is no 4.21 version: see https://lkml.org/lkml/2019/1/6/178  :-)

Thanks!
-- Dexuan
