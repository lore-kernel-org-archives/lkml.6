Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120671-2-16773401683048599574
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
    t=1520120670; b=xFtoP+6cnLBolH4i55rQy4lEfCvniYQQfjoTumMwMKTX6Qy
    cth1E22998NygO1WuVjB4kJnvW99+WRScupEqmI67aXkzMiew9uYW0QLPrHajnRS
    5QAt5vwpbRUNjVrJ8wemlCnZ9R2cQEB6LVQYvp3ERSwGJLsfR1Y7QClkvSm7ecZN
    eNzPULNBXvH214pcRBSQ8P2wMKYdAGZRyERl6chSeccq1nY27tJllB0Yjc38Nhu3
    jxM9aSxLx1O9b2BQiZlQBpS715rEdR/pb4WqXlsbMz/8NvfkfwsiQZEB6CTwTEUE
    VZ0wwwIvU6cMG+XA02x1LxpC/bM5M7MyA24iqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120670; bh=FlpnZE
    H/42NifludOyk9EihlItLB06tyDCnswfe85Jo=; b=DVvVlFCImcQp+enOEgDMDf
    yTtJ6SweakRnqTQAx+dGJodwg5hL17/k4r7tZktWfevoJ3F8f1wCTD5xBl+3PIkF
    xk0nYAlkHWzAREsv5t6S60dAocGnp//bEQkVnhYHuyTCmgO3j9gE8kp/S7oAVbOU
    w6mFh3l82k47HtRGcPjVUnW1OT26qaQ85X4Psu0TFkj5fCNVgsPp72ug8JGRduYQ
    WZBDn6q/+EHJHZT9YWO5QHJ9wEAXnMH4vI1hByp2HAVv4M3nmKtWwIVHPBmLR4wv
    xRwW30gke+kC9PcQLgDIfgrg0xYTDpSMKZbV1+TWPUWycoTp0oLA+YJyZxZQEGuQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dm2XG+9p x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dm2XG+9p x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933871AbeCCWed (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:34:33 -0500
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:59936
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934193AbeCCWeP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 120/219] scsi: ses: don't get power status of
 SES device slot on probe
Thread-Topic: [PATCH AUTOSEL for 4.9 120/219] scsi: ses: don't get power
 status of SES device slot on probe
Thread-Index: AQHTsz8KYxNSk2OkMkOT63DR33kB6A==
Date: Sat, 3 Mar 2018 22:29:05 +0000
Message-ID: <20180303222716.26640-120-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1068;6:s0NwZ/feHMAyjnTQqS+Ut2zgGtRe+zEmW7D5qeRAju34tkiCyJXy0b8uj05CPSx4qqTFcZEPHVR/JqZwQpbr1jjIAF1y9ya6c1yMv29yFwz7aLtCkeSeDkuQEdG9uS+fRjQyaCbhBoyOQZ5waBU1KaoUp+QJ5UoAzee90r/11pEw4WJ00R1KNai9ZGJGa+NJANZvY2ael9UnUeENv6CCp05bFQgK/2eJYn1IENVrDXh/8c4RWTQweiXRnBK1jaF8PHXsAmBonUe7Wt1I0m4XZh15gAwdZGpj8NlEjE3v3MStIRt93NCXR4WlL187ugfdjynpeNOjyVucxP7IGHCOqQWUXgtlR+sRFg5CKmvu7YtF7OlZttOg9UkQY3qKFr95;5:i5FHQLtyw0+G52wLCf9gSwLI1NHEgNPkOrL9JuINw9eLRCNl7dI9qIgiAJ0Gn86CGi5ty66mOld5kdrw4BFOUlj3STgHbyAkPC6L+J7juvRHUHdQ85ufXc2kWw0RhrJyRcZc9mFvOoqWfUQCqmXJ364ONLwwzADc63GykehccjA=;24:gcAiUl7dohZ4pk0vxj63Gdb0z/phtbMWf+lHoXIW8AfyNWUsel4ub+6g8mfRpSSq9OWZuLlIokTOlfqluXB9B7fNI0GYvS3K0Q2d7hTUEJU=;7:CpE9PkFb8jKjA20v8am8d/PHkEEKqvNC3eP2FQMmjGcwUKZmx+iZsRRnUYhR+hl23/IV1SuN7aFzgaLF/ZbkHCc8vbUs7oqB1zzH8uD514xy83NOthsgoJw/+XeJJGL5ErhUsB5HT9SigoJ08PEiEBfkzsvBZpTfbEZEAR/2BRWKEJU4/pGe+PKzjDaJU1NgD2d7gMa5hd2vkEpJTw62XMM1VTvekchduoNxsu1Tl+WCvZeFIcnq6HSDr/C53cly
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9da03bd-ff39-4b99-52f3-08d58156e2a8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1068;
x-ms-traffictypediagnostic: MW2PR2101MB1068:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10688EEF81A56D434657C008FBC40@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(104084551191319)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1068;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1068;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(199004)(189003)(102836004)(59450400001)(6506007)(26005)(66066001)(4326008)(1076002)(105586002)(10290500003)(478600001)(72206003)(86612001)(14454004)(186003)(2906002)(5890100001)(2501003)(305945005)(7736002)(36756003)(3660700001)(5250100002)(25786009)(2950100002)(5660300001)(3846002)(2900100001)(3280700002)(6116002)(106356001)(22452003)(97736004)(316002)(575784001)(81166006)(10090500001)(81156014)(8936002)(8676002)(76176011)(6436002)(110136005)(53936002)(6486002)(54906003)(6512007)(86362001)(107886003)(68736007)(99286004)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 535wuj6S6kvtFwtRF3VBjjltbNVusFup/urs3NRNETWqXNa72QHP46VRXXE8/5gEkTuVCFljwVKm7w4/pgF7rel91m2Wu/k2ZbXKd2ESTeB48ssZRCuSsyYJTJ8alkb/s3wrIvW1ycmufttVnuhb2F8ERfEPHyQGpUbHk2UwONA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9da03bd-ff39-4b99-52f3-08d58156e2a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:05.8226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1068
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
index 50adabbb5808..f1cdf32d7514 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -548,7 +548,6 @@ static void ses_enclosure_data_process(struct enclosure=
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
