Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53689C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1001521710
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="W2OhFz83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1001521710
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeI1CK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:10:27 -0400
Received: from mail-eopbgr700125.outbound.protection.outlook.com ([40.107.70.125]:21824
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727393AbeI1CK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEGiXTPJUHRWo42Xod6DtH3fXHTxOjUoUDHtwwRifhs=;
 b=W2OhFz83OHDgX0H8eeNnbsrANMnvlM5AU6zmty16Ro4fJHM5kK2vCUeEZP/KEYi/q/NBvtljlmM7VTuC6ECgMKv40izPxagVK5jns6lVY8F3q/tbwicVoIQx6YaPlVGn66YAhMAheWeRC4j4DXVUM1EQ02blinrlsvKxQ/UlMBg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0630.namprd21.prod.outlook.com (10.175.115.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Thu, 27 Sep 2018 19:50:30 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.011; Thu, 27 Sep 2018
 19:50:30 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH AUTOSEL 4.14 52/87] nfp: fail probe if serial or interface
 id is missing
Thread-Topic: [PATCH AUTOSEL 4.14 52/87] nfp: fail probe if serial or
 interface id is missing
Thread-Index: AQHUTjLuQIMIvblAXUmSJX7MvViEAaT0gfeAgBAYUQA=
Date:   Thu, 27 Sep 2018 19:50:30 +0000
Message-ID: <20180927195028.GA69414@sasha-vm>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
 <20180917030220.245686-52-alexander.levin@microsoft.com>
 <20180917070317.19c09e88@cakuba.netronome.com>
In-Reply-To: <20180917070317.19c09e88@cakuba.netronome.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0630;6:dm6jbHp5ymQDjYFmjvnv3/Bqv3bpadOBTsjeK6kIuO3rznhKRaeLYGQDVAOqHbX8zarcUqJFh5bumYHSdcn+PqtTbJWowdToBRnKiCPohMGv4YS5EJe+dqzn/Df0dqsw3dx+mnLLda7AvBoLK5ZuG1cktY6xgiCaJR8RShfCmDAAIFEUtefz5mq4900NaMnpyjrS87rXPc8srKJfRuuJq3fELTJREAMdWCsWrE66ormEO39MK5iRXee52zfUp755ynC33l0aREGb9PH+CsY/uS1vAXPs/NT6WKuh4H3YPEyFS+7UWkxJ8Asu5Ow6x1387REp6Bksjqfp0fb1TQASOYItNTGt0dFmCNmhrJaLeSfJD4aokm4doB7wJdXgTFGsAcOjfYnKSPo3L5E4vNwTUqaq/wMbdWFgOxz3LCMFODP+7lYDv67X7DM9nELBCegETThJ2kxWKRCH/r34GSdF5A==;5:H7DuusXIwGCCjYflttpi7ZWqTOGPsHWZgOJW9Gyxk1IrQEmyqQkK1I9tNmsVXlVepmFxuv49TmyrVb07EiP/cFCaNhnYOwZNlSDh2gbnF0iBi49l0Ccw90o4vz/fMi3069GGtRdwGEPvedaCt6ZmWiQF2QyPgLolCdPOXeUCrmE=;7:Lq0UwweteCx8W7B0akPxilgOOhMQo2sLFXkbqVf73PcdQuZESvRPJD2Zr9QntPzDMCNyt+hh4M7rBmuwhMh89LYQZpAb4sotDqPwDCziAJ2Fqr7F1MV/XewvgD8d5vupkUNry8MF6W9r2wyWpPa0A3oFQLEmBMnj+gkATnb6dZWDLP0dbueGVqYgoE84pVMRiI16jK/58mTmliMM+RQRluBR0uA2ZvCXl5Xkkah0vHfyyY35Dq1ehMzPfwR1TW5a
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b81b4ba7-ec6c-4919-82f2-08d624b27ae6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0630;
x-ms-traffictypediagnostic: CY4PR21MB0630:
x-microsoft-antispam-prvs: <CY4PR21MB063045C02FAD7A0FDF0455F9FB140@CY4PR21MB0630.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0630;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0630;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(39860400002)(136003)(346002)(376002)(366004)(40224003)(199004)(189003)(54906003)(256004)(33656002)(6346003)(14444005)(33716001)(7736002)(105586002)(106356001)(217873002)(305945005)(99286004)(22452003)(316002)(33896004)(5250100002)(6506007)(76176011)(97736004)(2900100001)(102836004)(6116002)(3846002)(1076002)(4326008)(8676002)(8936002)(81156014)(81166006)(2906002)(10090500001)(6246003)(68736007)(39060400002)(71200400001)(66066001)(5660300001)(10290500003)(508600001)(229853002)(186003)(6916009)(72206003)(9686003)(86612001)(53936002)(14454004)(26005)(6512007)(71190400001)(34290500001)(86362001)(476003)(6486002)(575784001)(6436002)(486006)(11346002)(446003)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0630;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: b3cd8u1Bfmv4bhac1PBufiSWggz3CD2I8cpNZNrBzUH9LbbKJltSHaFlHNzSsdrCID9/6QSbRgMkWu35MacYJRKhIWLVWaZiYACf1FyIr9X8ONMA8tkc1ZjKyU2Bepgk7FkuDzS6a8sua/EF0VStrk5xDmiPyZo6S7UrwcFKniL4H5EynW+qCuTrDWMxnAkeUfavDuEEhJ+JXdG9CWgMS+2ocWPWnHPBVrzDPK4PxSFoP6JUiRM57jmUQ/W3oz9wPmrUJhSSPpb46MVvke0z7v87Vr2FZ98qhJdMfgHP9Dbkw/RNDEeQZcGkIQ1HpwycQxk2Lea0n0wvlljcla9TOZMveJfUyKze+e2n7ARaKaQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18D40E415E95FF47AAF6BCA2A2ABC7B6@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81b4ba7-ec6c-4919-82f2-08d624b27ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 19:50:30.3459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0630
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 07:03:17AM -0700, Jakub Kicinski wrote:
>On Mon, 17 Sep 2018 03:02:55 +0000, Sasha Levin wrote:
>> From: Jakub Kicinski <jakub.kicinski@netronome.com>
>>
>> [ Upstream commit 18aa5b180f00a10c2f63944b4f0ab116bf8ea19b ]
>>
>> On some platforms with broken ACPI tables we may not have access
>> to the Serial Number PCIe capability.  This capability is crucial
>> for us for switchdev operation as we use serial number as switch ID,
>> and for communication with management FW where interface ID is used.
>>
>> If we can't determine the Serial Number we have to fail device probe.
>>
>> Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
>> Signed-off-by: David S. Miller <davem@davemloft.net>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>
>If the problem occurs the driver would usually fail to probe anyway
>(e.g. due to missing SR-IOV capability), just without providing any
>clear message why.  So the patch is not of huge importance, but I'm
>not opposed to back porting it.
>
>I should've put this info in the commit message, my bad.

Now removed, thanks!=
