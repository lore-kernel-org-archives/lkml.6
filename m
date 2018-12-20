Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9830FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DFC218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DrcsL6TJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389374AbeLTUDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:03:39 -0500
Received: from mail-eopbgr1300125.outbound.protection.outlook.com ([40.107.130.125]:17888
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbeLTUDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckLtbSC5QinNXsTcnnmjFz0LEp153+0591VPoATxL3k=;
 b=DrcsL6TJ1vF8eyd+Uvmhs9sKpm9GYO3qHjFhusn67KuY2Q2u+zokzixm26nvhvF9yEQoPFuoqMF9fFLoMhYoNBY7Y7l/kJ8VD1SQ9U8H79q2koaLF3DvZ0XTvqvquzbZBaKhxycUOgRZ6fEhi45t7suahx3QlsAn0K7PS4InwaM=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0170.APCP153.PROD.OUTLOOK.COM (10.170.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.5; Thu, 20 Dec 2018 20:02:37 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::99da:e3db:6b66:c8d4]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::99da:e3db:6b66:c8d4%6]) with mapi id 15.20.1471.012; Thu, 20 Dec 2018
 20:02:37 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     'David Howells' <dhowells@redhat.com>,
        'John Johansen' <john.johansen@canonical.com>,
        'Al Viro' <viro@zeniv.linux.org.uk>,
        'James Morris' <jmorris@namei.org>,
        James Morris <James.Morris@microsoft.com>,
        "'Serge E. Hallyn'" <serge@hallyn.com>,
        'Alexander Viro' <viro@zeniv.linux.org.uk>
CC:     "Adrian Vladu (Cloudbase Solutions SRL)" <v-advlad@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "'apparmor@lists.ubuntu.com'" <apparmor@lists.ubuntu.com>,
        "'linux-security-module@vger.kernel.org'" 
        <linux-security-module@vger.kernel.org>,
        "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Tejun Heo' <tj@kernel.org>
Subject: RE: Recent VFS/LSM patches cause Kernel panic - not syncing: Can't
 create rootfs
Thread-Topic: Recent VFS/LSM patches cause Kernel panic - not syncing: Can't
 create rootfs
Thread-Index: AdSYG/wrTsN7nddLRf+g8gGOY0k+1gAgSQkA
Date:   Thu, 20 Dec 2018 20:02:36 +0000
Message-ID: <PU1P153MB0169179D2E7127E2F408CCE2BFBF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169BF1F89AE4046C9D7307FBFBF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169BF1F89AE4046C9D7307FBFBF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-12-20T04:30:01.9861660Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2601:600:a27f:df20:b062:6e52:a3be:13ef]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0170;6:CF5GlB4wANQkfbdeYkglOl0d4/aYL1dW0TB8UxldMU4HVoV569qMJy9079oRhIzVHIIRD2SMPXcmIbS7QpFQpvQZDOC6qE2apNA+cI41AgJ/jMikgOkr4Y2BY67tEguwecBLeNR64naWNp3KVtRCQso+RSM6kjyRURn9386ZyJGesZeuv0Vnl8CPIJs4OtBnnDTBikfHiN6ZFGBulxI1GeCC4c/MJdg5lU4iKKVMlO0+eM0pDqmCMkQG2mmRGgkaVpEZTeWRsedGqUse9kBqKM2t7mAsdIvMH/hl5nNoqPn+H7VPp4bpmI96dAzoDmyqwfsDIY8zYr1s2+1ifhSIg/VZScww9ER5gKr7DyNRwjS9wVga3U/9UYzrhSo+Exav4pzoUOvDFg2QzSAspKQ/BaC+99ApF5SrfZhWdIUkjzPmfvXa3ujsV7qVBEyGNTt1POo6FKh8ypIJc9TyVk0hhA==;5:LJoKUWyBz1ovqkqdDppSVkcbJmfckSHPKoC8VdnErBL10Hws3XbeplFWZnDo98Lx1DF4M3au7gGf03laTTFY4AEMNuLa+aSc/t17K+xlnz9+aH9zzgXLcZVqRaPubYIJFFbyLag2mu5EzgoyqpPbntJvToFU9UbH8SLRLLzccE0=;7:LwwXnNXhwYzqsuqTUMLGT6nd1aj028ECFwRLW3k2aIcdhR2ZRYKxHGVusPVrxwCQIgrsJdtvZVIsYyxobq2s1kbuVjYbpCqiR4vwN0sml7b3ujQdknXMs3j9FEsK0QRVR291tBEYC7jURsXsLILcdQ==
x-ms-office365-filtering-correlation-id: 6509a364-7b99-4861-3e59-08d666b616e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:PU1P153MB0170;
x-ms-traffictypediagnostic: PU1P153MB0170:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <PU1P153MB017025CE378A6F3A108E2C2ABFBF0@PU1P153MB0170.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(8220039)(2401047)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231475)(944501520)(2018427008)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0170;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0170;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(6506007)(53546011)(102836004)(6346003)(186003)(97736004)(478600001)(68736007)(10290500003)(4326008)(8676002)(81156014)(81166006)(229853002)(7736002)(25786009)(9686003)(55016002)(6306002)(46003)(6246003)(316002)(110136005)(54906003)(22452003)(8990500004)(1511001)(53936002)(10090500001)(8936002)(86612001)(99286004)(14454004)(106356001)(76176011)(105586002)(7696005)(6116002)(2906002)(2940100002)(33656002)(486006)(305945005)(71200400001)(74316002)(476003)(11346002)(256004)(14444005)(5660300001)(446003)(71190400001)(7416002)(6436002)(86362001)(93156006);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0170;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-microsoft-antispam-message-info: vjwJtwhzluODRdJhvYAiLjuYWymaq8Ua3GdgpPNOZkHmgYnUyo6wV2oHEX3Qtjq3znR4gdC2myR3/ptL59IX8v2eSt0mGfDR9HlgYBFy1ZkhLVbZbDYAIyV9hYNX5EBu9ni4CGd6LkwKqCTy6/JZMIpZ1Bq/CcSd5CwlPIAc4OcmBNciI+flkOJouE5HjffaQiWgwI6xFkH933VcgsNfedOJi8a41PUv8M7I8zcAljEe+p0o4O/WFyvQPtvjbd6x1g1rOAesnt+4f0Piq4hIHBWdwuUt3rz69zltFIYCSlGkoJgYFatCtLncHb5nuyuo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6509a364-7b99-4861-3e59-08d666b616e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 20:02:36.8567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dexuan Cui
> Sent: Wednesday, December 19, 2018 8:30 PM
>=20
> Hi,
> We started to see a "Can't create rootfs" panic with linux-next's
> next-20181218 and next-20181219. Note: next-20181217 is good.
>=20
> Our test team found the first bad commit by git-bisect:
> 013c7af575e5 ("vfs: Implement a filesystem superblock creation/configurat=
ion
> context")
>=20
> I had a look and I think another patch also helped to cause the panic:
> c36d02347290 ("apparmor: Implement security hooks for the new mount API")
>=20
> My finding is: the panic happens because
> start_kernel() -> vfs_caches_init() -> mnt_init() ->
> sysfs_init() -> register_filesystem() -> init_mount_tree() ->
> vfs_kern_mount(type, 0, "rootfs", NULL) -> vfs_get_tree() ->
> security_sb_set_mnt_opts(sb, fc->security, 0, NULL) returns -EOPNOTSUPP:
>=20
> This means: fc->security is not NULL in
> security_sb_set_mnt_opts(sb, fc->security, 0, NULL), and the
> security_hook_heads.FUNC is empty in call_int_hook().
>=20
> The fc->security is assigned in this function (i.e. the line "fc->securit=
y =3D afc;" ):
>=20
> static int apparmor_fs_context_parse_param(struct fs_context *fc,

Well, obviously David Howells <dhowells@redhat.com> has fixed the issue in
the updated version of the patch by adding a dummy apparmor_set_mnt_opts():

From 8c5887f849301a5e00fa4b5e5ea7a3feae16b02d
From: David Howells <dhowells@redhat.com>
Date: Thu, 1 Nov 2018 23:07:24 +0000
Subject: apparmor: Implement security hooks for the new mount API
(https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=3Df=
or-next&id=3D8c5887f849301a5e00fa4b5e5ea7a3feae16b02d )

I expect the fix will be in linux-next soon, probably tomorrow.

Thanks!
-- Dexuan

