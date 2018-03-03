Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118622-2-9898570065369332489
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118621; b=dMso4kUgOZ6yWKy8gthyP16ndDZLbQhm7xREMaC/UMHmR4H
    qVXwxAA5O0E4F1yMNoy0Dbj/OaGMaEVrq2orH6BMMJWTBdvOg+87dIssrviBtAHg
    IM1/I9ya+yxNOshKV6AB+h0iQSrT8mZblmRPjavFSN78S6yGmk+XMFHsWc6vlb0n
    dNV5e3q7VOy46ZDoACz5O/a8rDxq9R58Bin22kquM5b9bYo+qyOX27MPCbqsAl1W
    GLka5vQVy9Hd0fubnp7H+8Kg9q6wKDp5fhxiUWFc/Bz8IfYXi7HlLguT9+Peaxou
    Wd3ihDndk+LyEByKZzU1JHD1VZ3bFa+lVIF3yQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118621; bh=dn4ZKS
    DYou+iD5c4neKn/EVbm1Z5Iu7k1vOqSPy27IY=; b=Kt2c6imVmLOjEPYm4SEPxe
    aU0dMJlBYpQqwTvhj7tDUEVJ1ZZq+i72mZZRl7Vbq7EoSny9zD+prKSM02nsGFrj
    64QbTOLjheiARMOAqBi+p151Wy4AumIFMoVdl55286ldpwWq+Psvs+4MLX0lOykm
    IJatQnp2bhwiXgJnbNG7YiurBp543+w78T5svUsGfTPMKAvpyp+ohazG01EQ3vfg
    d88HVHL7obqrIflYyrNcfiVPebVK5H4Azkg3SX2eUO1WdODqnpy7NJfpYrl3BEgW
    Xa4QK02Qp+7b+Hu84dHO+MprIhe0T2QhZK+krAznRjslAZx8LINlB4wrMA24aryg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BOqmmIAM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BOqmmIAM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934399AbeCCXJl (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:09:41 -0500
Received: from mail-co1nam03on0108.outbound.protection.outlook.com ([104.47.40.108]:14523
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935097AbeCCWj0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:26 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 059/115] scsi: ses: don't get power status of
 SES device slot on probe
Thread-Topic: [PATCH AUTOSEL for 4.4 059/115] scsi: ses: don't get power
 status of SES device slot on probe
Thread-Index: AQHTsz9bE3zFweLrPkW4mCvhrlD8ow==
Date: Sat, 3 Mar 2018 22:31:23 +0000
Message-ID: <20180303223010.27106-59-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;6:kQvCdgy+3W/b0SGhnyjaZ6nmDp/ZWXgGFhTGQoaO6DYQxErkbhlz5X1J0xcHnDRmD1RmIQyI9n/wTGy1z6JCqdL7Vd8FQXhBj7U3JfqHPvhXCYN9ejVgRcsqS/BvZimh+gahObh8qyslpxmDq58gM5ZVjmSnBqybbTcNCqPtRTbnMHlJplJ36lgGaqgiMKhGXmn44hO6//Q78kTwHB7hP5qajVTzTu/xa8TGtcs7w8q+DF9kB5PrgzumzegsiJ0VKM1ULtpcFqlPEKhhsBIawlP2j5AUuFDiquIWsLU9UGozlCcxpSz/9qB8YXf8vTTm1KidNmJcS4UiPF2p/1fD1qPmQMlgPff3yidsZdJuE6df8o6QJkMxPZQ6J25trJ9r;5:zPPcox2+wjnDb14TpiKkdiNLxY+dfBDtnzLxYpkxqk+/Fsl61Zq8ikcjoKIiLBANSIEWAoKYsffk0o+K1bS8VmcffAWVbV2i42G3j/hnlEYXCX15dxeoTuyhM1oF7lYFi7oif234mWt2/GBQLSyJxPv0Q2OAOW6gR37olmtXTBs=;24:wctocrjcDGNVcOts1F0RAG1uFb7zjtr9k0d6nAfSbIgrjOzVLgQRRaqoTkLVzVk2p3ZuArKECiuJEZR2Z2B8Jioqua+qFzlBGJ2vQFNMU7Q=;7:g9t2THnntLvWUjIIQhAmQ+0f/jhd10IzeLRv0VAEeYrQHv2cZM9gfSRU/U7tiETBSFnC90bmS+RTta/G6e3gFEaywHpxycMMiPdr3Xq4nEPCRbXYLvQz1bfIvLSgFGH4UmtwnhlZe3rIK1NKRE60SWM/ChkieIBoMpbHA89CcSrfFPoYKRcYaP+A8t1Py6j+BSyISDM6cDNp1CT3mlwxftSHIklu7q4YHcEwV0U81PClNYNsPq5iZEwSgS63iKBe
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 72c95c75-6ee5-4211-eea4-08d581579b65
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-microsoft-antispam-prvs: <MW2PR2101MB1113F6877360CCDDB41F1BC6FBC40@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(104084551191319)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(68736007)(7736002)(10090500001)(6116002)(3846002)(1076002)(2906002)(5250100002)(6486002)(5890100001)(2501003)(6436002)(76176011)(575784001)(86362001)(22452003)(6512007)(53936002)(66066001)(86612001)(99286004)(59450400001)(2900100001)(316002)(36756003)(54906003)(106356001)(110136005)(6506007)(102836004)(186003)(97736004)(26005)(6346003)(14454004)(3660700001)(8936002)(107886003)(10290500003)(5660300001)(81166006)(478600001)(3280700002)(105586002)(8676002)(81156014)(4326008)(72206003)(2950100002)(305945005)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: ULmDOCDyaWQfUDsJm6FhVcCS+7Teh2/+VMiiK6M694DjSf/k5BNAWBPF6yBWhbPsg5o+WmuSQZTb9QKknNE80UDpDp0E1lAO7kDWEUAsnU7hGOmRLQllPqZ541/Tvrbh8cqBqWqKJp4xRp3lyZ9+d6RMo0iqsAcevRzdHhrAV/g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c95c75-6ee5-4211-eea4-08d581579b65
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:23.1665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1113
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

[ Upstream commit 75106523f39751390b5789b36ee1d213b3af1945 ]

The commit 08024885a2a3 ("ses: Add power_status to SES device slot")
introduced the 'power_status' attribute to enclosure components and
the associated callbacks.

There are 2 callbacks available to get the power status of a device:
1) ses_get_power_status() for 'struct enclosure_component_callbacks'
2) get_component_power_status() for the sysfs device attribute
(these are available for kernel-space and user-space, respectively.)

However, despite both methods being available to get power status
on demand, that commit also introduced a call to get power status
in ses_enclosure_data_process().

This dramatically increased the total probe time for SCSI devices
on larger configurations, because ses_enclosure_data_process() is
called several times during the SCSI devices probe and loops over
the component devices (but that is another problem, another patch).

That results in a tremendous continuous hammering of SCSI Receive
Diagnostics commands to the enclosure-services device, which does
delay the total probe time for the SCSI devices __significantly__:

  Originally, ~34 minutes on a system attached to ~170 disks:

    [ 9214.490703] mpt3sas version 13.100.00.00 loaded
    ...
    [11256.580231] scsi 17:0:177:0: qdepth(16), tagged(1), simple(0),
                   ordered(0), scsi_level(6), cmd_que(1)

  With this patch, it decreased to ~2.5 minutes -- a 13.6x faster

    [ 1002.992533] mpt3sas version 13.100.00.00 loaded
    ...
    [ 1151.978831] scsi 11:0:177:0: qdepth(16), tagged(1), simple(0),
                   ordered(0), scsi_level(6), cmd_que(1)

Back to the commit discussion.. on the ses_get_power_status() call
introduced in ses_enclosure_data_process(): impact of removing it.

That may possibly be in place to initialize the power status value
on device probe.  However, those 2 functions available to retrieve
that value _do_ automatically refresh/update it.  So the potential
benefit would be a direct access of the 'power_status' field which
does not use the callbacks...

But the only reader of 'struct enclosure_component::power_status'
is the get_component_power_status() callback for sysfs attribute,
and it _does_ check for and call the .get_power_status callback,
(which indeed is defined and implemented by that commit), so the
power status value is, again, automatically updated.

So, the remaining potential for a direct/non-callback access to
the power_status attribute would be out-of-tree modules -- well,
for those, if they are for whatever reason interested in values
that are set during device probe and not up-to-date by the time
they need it.. well, that would be curious.

Well, to handle that more properly, set the initial power state
value to '-1' (i.e., uninitialized) instead of '1' (power 'on'),
and check for it in that callback which may do an direct access
to the field value _if_ a callback function is not defined.

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Fixes: 08024885a2a3 ("ses: Add power_status to SES device slot")
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/enclosure.c | 7 ++++++-
 drivers/scsi/ses.c       | 1 -
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
index cc91f7b3d90c..eb29113e0bac 100644
--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -148,7 +148,7 @@ enclosure_register(struct device *dev, const char *name=
, int components,
 	for (i =3D 0; i < components; i++) {
 		edev->component[i].number =3D -1;
 		edev->component[i].slot =3D -1;
-		edev->component[i].power_status =3D 1;
+		edev->component[i].power_status =3D -1;
 	}
=20
 	mutex_lock(&container_list_lock);
@@ -600,6 +600,11 @@ static ssize_t get_component_power_status(struct devic=
e *cdev,
=20
 	if (edev->cb->get_power_status)
 		edev->cb->get_power_status(edev, ecomp);
+
+	/* If still uninitialized, the callback failed or does not exist. */
+	if (ecomp->power_status =3D=3D -1)
+		return (edev->cb->get_power_status) ? -EIO : -ENOTTY;
+
 	return snprintf(buf, 40, "%s\n", ecomp->power_status ? "on" : "off");
 }
=20
diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index 044d06410d4c..01168acc864d 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -546,7 +546,6 @@ static void ses_enclosure_data_process(struct enclosure=
_device *edev,
 					ecomp =3D &edev->component[components++];
=20
 				if (!IS_ERR(ecomp)) {
-					ses_get_power_status(edev, ecomp);
 					if (addl_desc_ptr)
 						ses_process_descriptor(
 							ecomp,
--=20
2.14.1
