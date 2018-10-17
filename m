Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0560FECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4F6214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MicronCorp.onmicrosoft.com header.i=@MicronCorp.onmicrosoft.com header.b="tqGYpY3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4F6214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micron.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeJQPux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:50:53 -0400
Received: from mailout.micron.com ([137.201.242.129]:41371 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJQPuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:50:52 -0400
Received: from mail.micron.com (bowex36h.micron.com [137.201.84.179])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id w9H7u710005214;
        Wed, 17 Oct 2018 01:56:07 -0600
Received: from bowex17d.micron.com (137.201.21.212) by BOWEX36H.micron.com
 (137.201.84.179) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 17 Oct
 2018 01:56:06 -0600
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (137.201.20.7) by
 bowex17d.micron.com (137.201.21.212) with Microsoft SMTP Server (TLS) id
 15.0.1347.2 via Frontend Transport; Wed, 17 Oct 2018 01:56:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicronCorp.onmicrosoft.com; s=selector1-micron-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYfFLW4u0r0Ebuy7FYfLEkOFvIdJTuOUfoRN2mvJDGo=;
 b=tqGYpY3XWwnf7D8BSfIY3YXZt6Uyq+0SsZFF1UDX6930A93byiYGjKgBdcSoJ95z0Rz3IkvAAWUlcDznLBAfozuI1h0q7OO7fcfo0PHLPyF71BDAGbcm4fAeLevryGuUD3cGJTi7/vZupNRsh6fKbkGSmnlCMj7+Y7NV826KZfM=
Received: from BYAPR08MB4533.namprd08.prod.outlook.com (52.135.234.15) by
 BYAPR08MB4662.namprd08.prod.outlook.com (52.135.234.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Wed, 17 Oct 2018 07:56:04 +0000
Received: from BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::d17a:4b7a:2c4:9efb]) by BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::d17a:4b7a:2c4:9efb%5]) with mapi id 15.20.1228.027; Wed, 17 Oct 2018
 07:56:03 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Sayali Lokhande <sayalil@codeaurora.org>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>
CC:     "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V15 2/2] scsi: ufs: Add configfs support for UFS
 provisioning
Thread-Topic: [PATCH V15 2/2] scsi: ufs: Add configfs support for UFS
 provisioning
Thread-Index: AdRl7szyFZC8CAUDQa2Xipmr9m5YCQ==
Date:   Wed, 17 Oct 2018 07:56:02 +0000
Message-ID: <BYAPR08MB4533120DFDB3803DB8B2E8B8DBFF0@BYAPR08MB4533.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [165.225.81.44]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4662;6:wy5vtQiPQ5e9gSU/28Oxb5cPN67BUwZmMO74xbfC7LhlStRB1y0J00ylemAW3dk05P5m84YiV+llDEuxmTyraw9tPa7J3fc3MJTayK5f56gsQ0g0jdPJYbP9Wx1EZBE9Aqb7QSQ+DiXJB64+U5ZxONQLhrK3nGOJW4c+bBWq3l+iOzTfUtV3kvs7LSQBoVYd/FoXbbl8ht8rbWJmgtsa2G3Na+n4iyUtIzVfSGn2KYDv9bJhKz+1aMgyYNfs5y/cmirk2L/EavDocRjqmF2CZLTRZdHZpZ9nQDrfPANylqO+FBimNFsk1lFyE5kRPAQEahV93FBXl+pvjOLJUYjfB8UYL0IiRYuQbBS3v9cc86wJbv1mxmphxZQ6OeGcM4T7b98ljGnMBlw0ByUKHbRsajvt+ud9/Jg1fmzLzdd+2OXktA1YqeSsO+xwkaQCSvOYkHKGRWCXdC+d6PPfKXTwWg==;5:IViGys6gNwmnQR9+ydywDtYR34pa9pln8S+pXX/ThJF7aSU2eRbXNgzjYnuaYjI++0ildb8qYQfk4nuVgvP4uSe1IHr+m6KVlUc/NlD2CySekit+IzJqoIwd1qry73NSmPEzhsdxNyX7E/aYguxARK6IwJDIHlxtIu9ljdeN56Y=;7:MKDC+wEf4vTyRSWC5WqS9z+IMNlYDzNAzGSEUSw4PsJ1drTsh3MfkZnhk5mEowSiBDpHYJXt41byhxBjPcS6iSMCibvvFper0YKLAzt2qRV9/nJn3MwddI+03aWAfFjRu10wAcLae5SmKugXC7vUkDmLHZd+Ra3ESQbJg2Qe1VKW0if5mHBbfdEjBIzCM3fd0rOAfUnMAi2Wj8/pK7IEh7lYZBzz+llheYAGh7y/iwql1KOP7MPMwRsFnEFgiX0i
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ec1ede5d-863c-432c-09a1-08d63405fcc3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4662;
x-ms-traffictypediagnostic: BYAPR08MB4662:|BYAPR08MB4662:
x-microsoft-antispam-prvs: <BYAPR08MB4662609866BABFA33B6F3787DBFF0@BYAPR08MB4662.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR08MB4662;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4662;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(346002)(376002)(199004)(189003)(55016002)(8936002)(8676002)(9686003)(81156014)(25786009)(97736004)(4326008)(71190400001)(71200400001)(102836004)(7416002)(6246003)(7736002)(305945005)(53936002)(33656002)(2906002)(81166006)(74316002)(5250100002)(68736007)(3846002)(106356001)(5660300001)(2900100001)(105586002)(2501003)(6116002)(256004)(39060400002)(229853002)(6436002)(476003)(7696005)(86362001)(26005)(186003)(54906003)(110136005)(66066001)(99286004)(2201001)(14454004)(486006)(478600001)(55236004)(316002)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR08MB4662;H:BYAPR08MB4533.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qmsYr1KQkKVwW5XTaAsPCOX++2PRjb33ucgSZMk4Iu/vrABnPii9lexFm6Dl9vO+kbUMvU6fnNhpRDFSm3bQwZkA7zfhhShqFPk/pDppPFIMU4OlAzn9xwTGSZdaSfLOO2pRG10T2AU+539AdII+nkfoZVNBcrZnrq2nrl7xScNj+RIdHQBAtuxlMIJK0Vy5LFpgmRBV9wyAehO8xZt6eV2pL952DOtqLUJois8STP4+E/9ZiVh3wzFFAXAMlHe45AU0Cl7db6fHQC6hrPCkzu8B1vekP09IY5AQv6lyijB82KvipJX57U1Z8xMFbq0vzFWd+wtGhKWms0/dI6Y7s1lXBQNMMNjO5sN8xe5u+sk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1ede5d-863c-432c-09a1-08d63405fcc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 07:56:03.7993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4662
X-OriginatorOrg: micron.com
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24160.005
X-TM-AS-Result: No--6.973700-0.000000-31
X-TM-AS-MatchedID: 150567-139010-106660-704421-708712-707663-700038-704156-7
        02762-701433-707788-703267-703176-707399-701698-707410-708257-700398-703523
        -700293-148004-148007-148020-148050-20043-42000-42003-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-CheckInternalSenderRule: True
X-Scanned-By: MIMEDefang 2.78 on 137.201.82.98
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sayali

>Subject: [EXT] [PATCH V15 2/2] scsi: ufs: Add configfs support for UFS
>provisioning
>
>This patch adds configfs support to provision UFS device at runtime. This
>feature can be primarily useful in factory or assembly line as some device=
s
>may be required to be configured multiple times during initial system
>development phase.
>Configuration Descriptors can be written multiple times until
>bConfigDescrLock attribute is zero.
>
>Configuration descriptor buffer consists of Device and Unit descriptor
>configurable parameters which are parsed from vendor specific provisioning
>file and then passed via configfs node at runtime to provision ufs device.
>CONFIG_CONFIGFS_FS and CONFIG_SCSI_UFS_PROVISION needs to be enabled
>for using this feature.
>
>Usage:
>1) To read current configuration descriptor with index X
>   (where index X can be 0/1/2/3) :
>   cat /config/<device_name>/ufs_config_desc_X
>
>2) To write configuration descriptor with index X :
>   echo <config_desc_buf> > /config/<device_name>/ufs_config_desc_X
>
>
I tested on my platform and got these error:

cat /sys/kernel/config/ff3b0000.ufs/ufs_config_desc_0=20
0x90 0x1 0x0 0x1 0x0 0x1 0x7f 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x1 0x1 0=
x0 0x3 0x0 0x0 0x0 0x2=20
0x1 0xc 0x2 0x0 0x0 0x0 0x0 0x0 0x1 0x2 0x0 0x3 0x0 0x0 0x0 0x2 0x1 0xc 0x2=
 0x0 0x0 0x0 0x0 0x0
 0x1 0x0 0x0 0x3 0x0 0x0 0x0 0x4 0x1 0xc 0x2 0x0 0x0 0x0 0x0 0x0 0x1 0x0 0x=
0 0x0 0x0 0x0 0x1d=20
0xc7 0x1 0xc 0x2 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x=
c 0x0 0x0 0x0 0x0=20
0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0xc 0x0 0x0 0x0 0x0 0x0 0x0 0x0=
 0x0 0x0 0x0 0x0=20
0x0 0x0 0x0 0x0 0xc 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0=
 0x0 0xc 0x0 0x0
 0x0 0x0 0x0 0x0

cat /sys/kernel/config/ff3b0000.ufs/ufs_config_desc_1=20
[   63.631734] ufshcd-hisi ff3b0000.ufs: __ufshcd_query_descriptor: opcode =
0x01 for idn 1 failed, index 1, err =3D 252
[   63.643059] ufshcd-hisi ff3b0000.ufs: __ufshcd_query_descriptor: opcode =
0x01 for idn 1 failed, index 1, err =3D 252
[   63.653602] ufshcd-hisi ff3b0000.ufs: __ufshcd_query_descriptor: opcode =
0x01 for idn 1 failed, index 1, err =3D 252
cat /sys/kernel/config/ff3b0000.ufs/ufs_config_desc_2=20
[   77.946097] ufshcd-hisi ff3b0000.ufs: __ufshcd_query_descriptor: opcode =
0x01 for idn 1 failed, index 2, err =3D 252
[   77.957212] ufshcd-hisi ff3b0000.ufs: __ufshcd_query_descriptor: opcode =
0x01 for idn 1 failed, index 2, err =3D 252
[   77.968534] ufshcd-hisi ff3b0000.ufs: __ufshcd_query_descriptor: opcode =
0x01 for idn 1 failed, index 2, err =3D 252
cat /sys/kernel/config/ff3b0000.ufs/ufs_config_desc_3
[   82.237656] ufshcd-hisi ff3b0000.ufs: __ufshcd_query_descriptor: opcode =
0x01 for idn 1 failed, index 3, err =3D 252
[   82.248374] ufshcd-hisi ff3b0000.ufs: __ufshcd_query_descriptor: opcode =
0x01 for idn 1 failed, index 3, err =3D 252
[   82.259117] ufshcd-hisi ff3b0000.ufs: __ufshcd_query_descriptor: opcode =
0x01 for idn 1 failed, index 3, err =3D 252
