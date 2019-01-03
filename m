Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD30C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF942073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="FZLNL2QI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbfACRXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:23:06 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:14419 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730229AbfACRXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:23:05 -0500
X-IronPort-AV: E=Sophos;i="5.56,435,1539673200"; 
   d="scan'208";a="24607043"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Jan 2019 10:23:05 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 3 Jan 2019 10:23:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CttSHzc2jrkcak3ipssjETMniScXtT6CpOz5P4u51Ik=;
 b=FZLNL2QICNFd/gNkz09gYEjFRGsNV7sxaZPFgNd4mVqhfJA6DvHUL107FH0m26X+jwE1qagztB56mJR2k+gzpiwh9z1Jx9rEfdSG0mSEG1PiusQaUGDXneV4dQ9J0WBeGc51StjIZo1ipatpeMqYebomNsBPVrhJJVtY/ExEbEs=
Received: from BYAPR11MB2855.namprd11.prod.outlook.com (52.135.228.141) by
 BYAPR11MB3110.namprd11.prod.outlook.com (20.177.227.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.8; Thu, 3 Jan 2019 17:23:02 +0000
Received: from BYAPR11MB2855.namprd11.prod.outlook.com
 ([fe80::1137:d81d:de30:c394]) by BYAPR11MB2855.namprd11.prod.outlook.com
 ([fe80::1137:d81d:de30:c394%5]) with mapi id 15.20.1471.019; Thu, 3 Jan 2019
 17:23:02 +0000
From:   <Don.Brace@microchip.com>
To:     <gustavo@embeddedor.com>, <mahesh.rajashekhara@microsemi.com>,
        <don.brace@microsemi.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <esc.storagedev@microsemi.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: smartpqi_init: fix boolean expression in
 pqi_device_remove_start
Thread-Topic: [PATCH] scsi: smartpqi_init: fix boolean expression in
 pqi_device_remove_start
Thread-Index: AQHUo4QlKeU9Ob6thUOlxM+a2JutdKWdyrhQ
Date:   Thu, 3 Jan 2019 17:23:02 +0000
Message-ID: <BYAPR11MB2855EB0DA808D21EFE6C6A24E18D0@BYAPR11MB2855.namprd11.prod.outlook.com>
References: <20190103164744.GA16360@embeddedor>
In-Reply-To: <20190103164744.GA16360@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Don.Brace@microchip.com; 
x-originating-ip: [216.54.225.58]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR11MB3110;6:3tHintHBYgHDfaT6PhiuA9b6+IWHvFs66ebrcpZcCOiuLKsM+ko8PEn5oluSHJG3+U6diK+XIe5S0IU2ehzQxhIPZGSi0SDSBTt1g3Zfz8IE3A8OTYCK/JX4N4jn7R8USA45yBR+wKlFGzQWRS3OaBMIlhmUaKCk92W3zFZvBkTsJddNkQV4JyC3QFCAQzCHlgAdDPtzoUackemfCmHA0ElzCxEbx9wTlYcgvd52LkPzI1kyRdCoWRXCYeWbqjmchDFWz6ewH/BMkOpkRuSzfUQAztHjWefBLub/9vuhyyhTM7AlXYsAsr9TPfFoZasmN3nstFLYA/GD8oylWLCtWBj39KARq9TzLPEvQabENpf2Is7DBEMKE3Ne3NeAxFlPkHcfeTOouVC+DgVDvGLkbhEG5GPNUMSqfU0z7zmXeAyBKfv1ADqVJu4arqKD5NGXgbURWruMvcVtJuYy+SpIkg==;5:iPRmMYmuEcdDSeMfRpWSPB/XuhLsXvAlQ7dqQh+X22eqHJruhUhjs7Z/LWsdWyFoOUYDRwAIA0Ei7NkO10Pbgz+KN9iw8KijLpSZk3xkgbOqkXNkSM4nib0waW+8nOcfE12LoIV9WZuigK224N8sycCJJke1oYbAR9mXYtbQzBnqFUsbgDwR3kFKUOeggbLlBMDSOCMt4/IMjHMrWxb/6A==;7:6D1aXQp4/A63ysoZygb8WYRXXTG85JmCM3HsHLgboUZpaFEQdWDr0pkJ8Tpoha1V+pl/rx5qedee7lTSRB2gHbHo3H8TvDcuANe0EXZZ2EBFypmGAwigTJNEFYEpp30nj5LxkCh5qXORYf4ktFwa1g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 22c86b51-723c-4625-b8e8-08d671a01dd7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR11MB3110;
x-ms-traffictypediagnostic: BYAPR11MB3110:
x-microsoft-antispam-prvs: <BYAPR11MB31105998AA794D8985B328EFE18D0@BYAPR11MB3110.namprd11.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR11MB3110;BCL:0;PCL:0;RULEID:;SRVR:BYAPR11MB3110;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(396003)(136003)(199004)(189003)(51914003)(13464003)(305945005)(4326008)(14444005)(256004)(7736002)(5660300001)(229853002)(66066001)(2906002)(106356001)(105586002)(486006)(25786009)(33656002)(6246003)(9686003)(53936002)(110136005)(54906003)(6436002)(99286004)(74316002)(8676002)(86362001)(97736004)(68736007)(186003)(446003)(26005)(14454004)(81156014)(72206003)(6116002)(71200400001)(81166006)(316002)(8936002)(3846002)(55016002)(71190400001)(478600001)(76176011)(476003)(7696005)(53546011)(11346002)(102836004)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3110;H:BYAPR11MB2855.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8tYcU7+XxEH+ugO7+eFnghv62yhOGA2EWV63uos2stvjo8qKc5xl1yk29aH/c3DX0kDdhg+/kHQSfJw6tHZ5O/VXf+G3P4OXf3sCo0tMuPBwvfMPk9sQpLlyovonWOgr3Ff0FgwS3Yu7NexTSctFUfDshTyZWQvmLiIgjf5r6GBgzsRep+qLJnmNl0aWeHMeSrvb3a/3vuiz+Lp9UsigK8LibSwwRg99GL7sDJrNWIfWaCvLvvZ9wd3dsq3oCiby6bCmxS3CW56P3umDxMFSwstYBpX1D1PvSSy51URiktkvXgK/u0Ktc4s4Z1gqcPv0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c86b51-723c-4625-b8e8-08d671a01dd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 17:23:02.7535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3110
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Gustavo A. R. Silva [mailto:gustavo@embeddedor.com]=20
Sent: Thursday, January 3, 2019 10:48 AM
To: Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>; Don Brace <don=
.brace@microsemi.com>; James E.J. Bottomley <jejb@linux.ibm.com>; Martin K.=
 Petersen <martin.petersen@oracle.com>
Cc: esc.storagedev@microsemi.com; linux-scsi@vger.kernel.org; linux-kernel@=
vger.kernel.org; Gustavo A. R. Silva <gustavo@embeddedor.com>
Subject: [PATCH] scsi: smartpqi_init: fix boolean expression in pqi_device_=
remove_start

EXTERNAL EMAIL


Fix boolean expression by using logical AND operator '&&'
instead of bitwise operator '&'.

This issue was detected with the help of Coccinelle.

Fixes: 1e46731efd9c ("scsi: smartpqi: check for null device pointers")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks for the update.
Acked-by: Don Brace <don.brace@microsemi.com>

---
 drivers/scsi/smartpqi/smartpqi_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/=
smartpqi_init.c
index e2fa3f476227..40f58238ce4a 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -323,7 +323,7 @@ static inline void pqi_device_remove_start(struct pqi_s=
csi_dev *device)  static inline bool pqi_device_in_remove(struct pqi_ctrl_i=
nfo *ctrl_info,
                                        struct pqi_scsi_dev *device)  {
-       return device->in_remove & !ctrl_info->in_shutdown;
+       return device->in_remove && !ctrl_info->in_shutdown;
 }

 static inline void pqi_schedule_rescan_worker_with_delay(
--
2.20.1

