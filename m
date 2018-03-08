Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490294-2-6548142143555932655
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490293; b=TK1/yJ8kIYxFXwCyBMxl4yMQPsNDDpcEFg4JtFAaLQhalHf
    GzpsI8EMfBbYj38IcH/v3oKFNk503YQ+XKUjCCUyTqOcFcPrfg51AujEIlb4+OhK
    xCWXPasHF2a/YjjF9FQ1n0w0+xOsMX5n3zAtspyZiiy8B5SiPRh6n5fuxMFOjH1+
    pl7zCLWC/YAkxBK0ozMnpoJz9xQo8o/B/7GovM248y/9P2KIdFCc14bA5a+tooDy
    d7FRFxYQokBNVpFzSkaalJOpoqrL3BfmYbW1Fe9h0OQ8PDMYLuOtlL4P3r8bxWUL
    3qvZirLVDSog5AewTyY9TSy+Vwnen9cuCExRLJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490293; bh=nJd1bX
    9lN48OzyxnnH8bu0NzFeQuijyl1iUJJDD3/dE=; b=A6BBbszFmv8sL3XRXw4mDf
    i2L36C3GtaatLJPiVpYVdzb9QLHSwnB/qbJBoLjRkgDVhD6LWiakwPO9AoTG92IJ
    SCmOsm2gt4WH0G4NaaZM5Hb2ajW/bOSsf6OCBfRC4zOy0gCr28HqWSlA7GqOs+dA
    W0A07DSzp47fcQ4Q0T8/HZrxREllhXHWQJukpMZKpjC0sjBOMSd4t6oliKdnqo4t
    T2O4EE6g1gkbxRjRw79FVDw7ebB8moqgbSaRwGn56r0O0u2AETjMouAWIJ7ZWt5v
    eYWb3Ac2FqLEbTyqjKq45vY86YGy9FIdnr36xJFIAefPNCeojaSIAZgx02Lp4hjA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gBlg9n9V x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gBlg9n9V x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965159AbeCHGYu (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:24:50 -0500
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:53598
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755326AbeCHFAo (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:44 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jasmin J <jasmin@anw.at>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 039/190] [media] media/dvb-core: Race
 condition when writing to CAM
Thread-Topic: [PATCH AUTOSEL for 4.9 039/190] [media] media/dvb-core: Race
 condition when writing to CAM
Thread-Index: AQHTtpows0SetuQDOUOpF3ekL7B9MA==
Date: Thu, 8 Mar 2018 04:59:08 +0000
Message-ID: <20180308045810.8041-39-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:5xj1SJ3ctccIIcwfTioJFMzdY/qQq+3I7YMrIIsaPrHcS+U6sFzAMVPS2xVlKeMf6pvnOej0wDwWK1BHdwF2uNuOmc6JwgmdrqHkB0xhSt1LpK3JcP1SzNmpJuCE/GwstgHv5BYluzATxlURwj3p4q3NRTNSNSmhH+03W7sS0W6WFBwQmm3g6E/94d3xpG8B9MQSslyoWlGJOfMHouCYYnHS+j6bIV9Ef4nb22c2wTirIU2cpsIKT+ajp3/OwjH7;20:ZpkiSv6c0PPxyhOokD7SIfl+EiqVI4pbloagYLy5iSItjnTEbCz9/NIWjd7oUkSfHmQ9ufMkpa4U/1tIzqFeZT2ehXjj8FCLY9rDbq6PevKMkCMAi38yasCgP/xbskeEKH+CBPLRWwHmGjJ5NMRojCOmga+0quMsGfxQ6dFj+7U=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6c7d3796-8f53-439b-1e6b-08d584b189d5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11123C58A5BC95AB9D994608FBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(6436002)(36756003)(305945005)(6116002)(8936002)(2900100001)(6666003)(97736004)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(59450400001)(110136005)(22452003)(86362001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: /TMZjKLE4fc+3CkpRS3FVUr30AwdrHZW1qAA1sKIE2Ubg5rdLsyjVRYoju8bJ9jNvI2dV0eueewhcnjjkzGZbHhbjy6fot69KRQWxMMfLSbBVfpqPTZA53NDvYD1nz07OWBC5HFkD6T48FrpzfxvLo7wmy1LjPbtsE4F7CU2SSeRqHREZa0xLVnWgIp1MXEWP4+Yh3SUT/p5VoLEXO90pgnjRlF0Q784FQywFIK6yI45IJ2qggRm1sQXbs5ZFKbErwWw2IpG5zLGTaXCu+qxK12QYDCra9JuUVDx4Xj+uHTSgJD/IkF5x61K1FpNzGsowSOvPLQyPmMb95KP36dvsw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7d3796-8f53-439b-1e6b-08d584b189d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:08.5309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jasmin J <jasmin@anw.at>

[ Upstream commit e7080d4471d805d921a9ea21b32f911a91e248cb ]

It started with a sporadic message in syslog: "CAM tried to send a
buffer larger than the ecount size" This message is not the fault
itself, but a consecutive fault, after a read error from the CAM. This
happens only on several CAMs, several hardware, and of course sporadic.

It is a consecutive fault, if the last read from the CAM did fail. I
guess this will not happen on all CAMs, but at least it did on mine.
There was a write error to the CAM and during the re-initialization
procedure, the CAM finished the last read, although it got a RS.

The write error to the CAM happened because a race condition between HC
write, checking DA and FR.

This patch added an additional check for DA(RE), just after checking FR.
It is important to read the CAMs status register again, to give the CAM
the necessary time for a proper reaction to HC. Please note the
description within the source code (patch below).

[mchehab@s-opensource.com: make checkpatch happy]

Signed-off-by: Jasmin jessich <jasmin@anw.at>
Tested-by: Ralph Metzler <rjkm@metzlerbros.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/dvb-core/dvb_ca_en50221.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-co=
re/dvb_ca_en50221.c
index b5b5b195ea7f..42ce88ceac66 100644
--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -779,6 +779,29 @@ static int dvb_ca_en50221_write_data(struct dvb_ca_pri=
vate *ca, int slot, u8 * b
 		goto exit;
 	}
=20
+	/*
+	 * It may need some time for the CAM to settle down, or there might
+	 * be a race condition between the CAM, writing HC and our last
+	 * check for DA. This happens, if the CAM asserts DA, just after
+	 * checking DA before we are setting HC. In this case it might be
+	 * a bug in the CAM to keep the FR bit, the lower layer/HW
+	 * communication requires a longer timeout or the CAM needs more
+	 * time internally. But this happens in reality!
+	 * We need to read the status from the HW again and do the same
+	 * we did for the previous check for DA
+	 */
+	status =3D ca->pub->read_cam_control(ca->pub, slot, CTRLIF_STATUS);
+	if (status < 0)
+		goto exit;
+
+	if (status & (STATUSREG_DA | STATUSREG_RE)) {
+		if (status & STATUSREG_DA)
+			dvb_ca_en50221_thread_wakeup(ca);
+
+		status =3D -EAGAIN;
+		goto exit;
+	}
+
 	/* send the amount of data */
 	if ((status =3D ca->pub->write_cam_control(ca->pub, slot, CTRLIF_SIZE_HIG=
H, bytes_write >> 8)) !=3D 0)
 		goto exit;
--=20
2.14.1
