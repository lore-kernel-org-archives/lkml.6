Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A75CC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5730E218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uO7zkQIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfBGQrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:47:18 -0500
Received: from mail-eopbgr740044.outbound.protection.outlook.com ([40.107.74.44]:51200
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726319AbfBGQrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0kAv9E2lqg7e0NAKPdzaDidqKGeyHQ6JFnCSVQFkg0=;
 b=uO7zkQIPBan8JzCOzhhsrxKIs+ahaidnTuTrZSyaZT343awV3wisLgVi5lUOt954X0TwVOy0Ckopv4UUFABS4fYAjIx5wjbGeR0WMmCUtrSvlpZ9UU3AXbnU6zcmLz8b9ICsYQpJvh+iov6vBIepzAYk9ZNO4AAESAtlDQT5xO0=
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (52.132.197.151) by
 SN1PR12MB2351.namprd12.prod.outlook.com (52.132.194.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Thu, 7 Feb 2019 16:47:13 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::14b:afeb:41aa:4287]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::14b:afeb:41aa:4287%6]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 16:47:13 +0000
From:   "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Elie Morisse <syniurge@gmail.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Singh, Sandeep" <Sandeep.Singh@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v15] i2c: Add drivers for the AMD PCIe MP2 I2C controller
Thread-Topic: [PATCH v15] i2c: Add drivers for the AMD PCIe MP2 I2C controller
Thread-Index: AQHUnXH4FvVVW5waFkOQMS4BxKV5XKXRW1uAgACD1QCAAuBzgIAADtkA
Date:   Thu, 7 Feb 2019 16:47:13 +0000
Message-ID: <8d70ae32-8e4d-d2aa-e213-4b2f678d7da0@amd.com>
References: <20181226232258.GA23526@syn-yoga530> <20190205120545.GA1045@kunai>
 <CAErSpo5kvFVwo-DCLYT_7UmRQKS1jHahFXawvnZUtZ=ApHKz1Q@mail.gmail.com>
 <20190207155326.GC4796@kunai>
In-Reply-To: <20190207155326.GC4796@kunai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::35) To SN1PR12MB2575.namprd12.prod.outlook.com
 (2603:10b6:802:2b::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nehal-bakulchandra.Shah@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [202.62.82.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB2351;20:hfsnGRooCOplWSUX4v3bZG3iKJXL+xFkiiBl6CpNrmHCS2PNY9FPWAwKHwrEsEgizX6piFYRYbIHmAeBt1n7s0XKNv8Oegu9OsmQBb34KdSYJAiXyzZy5F1uBDJVXNdyFooHGgtTBZh6o6s+t+PQE+m2OIXdUOKIesRx71lzt4cuoDDeFyDq+eYJi783hhSiRIxRd4PYpcXSFbm5ynmSRA+5s3NCKu1H81+PkARaj3CbWPHx9+P+/tiueh3eFsOk
x-ms-office365-filtering-correlation-id: 8711f28f-9606-4fe0-b1ad-08d68d1be908
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2351;
x-ms-traffictypediagnostic: SN1PR12MB2351:
x-microsoft-antispam-prvs: <SN1PR12MB2351F6E693F27D5190E1EB48A0680@SN1PR12MB2351.namprd12.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(346002)(136003)(39860400002)(189003)(199004)(25786009)(386003)(6506007)(99286004)(76176011)(8676002)(11346002)(476003)(6246003)(31696002)(2616005)(31686004)(186003)(446003)(81166006)(110136005)(486006)(52116002)(86362001)(26005)(102836004)(72206003)(316002)(53546011)(478600001)(71190400001)(71200400001)(66066001)(93886005)(8936002)(97736004)(2906002)(68736007)(6512007)(6486002)(305945005)(6436002)(55236004)(36756003)(7736002)(229853002)(256004)(6116002)(3846002)(106356001)(81156014)(105586002)(4326008)(14454004)(53936002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2351;H:SN1PR12MB2575.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MEvK/+kQ0OD/C2zxgsDRii+RAQFwzji3+NyQbqJM/wb2WyXv1+ScnJUy87bGalyulG9MIeZ/st01D56auPtq6KIAMNmwQb6pKFtxsATwGW3bkVHZincXfLsPqtwZKPcf6MHD2nwI/WsARsLlNJE9qgelUTwS3bOKlR4zNIQXIsocxW8kPwM5hB5ySkgr01W1kTSaE1wQS3K7cQQqXx9rZQriY/YKPFB2TINaWxq9m94wtArbsXiAB8l/2awj77Ts+BOjE+Xdc+PwwA6kJRH1Jj//Ohf592Whq5+UgQZl8niD4839jWVox9mKM2olhGMOfiY6Wk+XoGQnf99pwUVNvrLWgzr84fvuU3MzpZhL+4KGP3FPOvBDJOej8qC52n9lnLip9jmVoQz8R/WGVbMWAAsuSv1jEDeb+pjzI19J/k8=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <A6D645E046359C44939CA1EC24687EE6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8711f28f-9606-4fe0-b1ad-08d68d1be908
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 16:47:10.0996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2351
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Bjorn and Wolfram,
On 2/7/2019 9:23 PM, Wolfram Sang wrote:
> Hi Bjorn,
>=20
> thanks a lot for your additional information!
>=20
>> IMHO the split into two drivers is a bit of a mess and doesn't really
>> correspond with the hardware, as I mentioned at [1].  The PCI device
>> is the real hardware and the driver should claim that.  AFAICT the
>> ACPI device exists only to pass some config information to the PCI
>> driver.  I think the natural approach would be for the PCI driver to
>> directly search the ACPI namespace for that config information.
>=20
> AFAIR the AMD folks insisted on the two driver setup because they need
> it in the future? Maybe they can explain again here?
>=20
>> The fact that driver_find_device() is essentially unused except for a
>> few very special cases is a good clue that there's probably a better
>> way.
>=20
> Excactly this thinking made me recommend something else, too. Let's see
> what we can come up with.

First of really thanks for your valuable review. It may seem to be illogica=
l to have two separate drivers, however as explained
in past we are working on another solution for some upcoming thing. In that=
 case we need MP2-PCI communication driver which will be reused.
At this point of time i can't talk much about that but once solution is rea=
dy, we will be pushing that as well. Hence i sincerely requesting
to  have two separate driver.

For rest of remaining comments will look into the same. Elie hope you will =
also have a look and we will have a common understanding.


> Thanks,
>=20
>    Wolfram
>=20


Thanks for consideration and your understanding.

Regards
Nehal Shah
