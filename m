Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117715-2-8602021877661805128
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
    t=1520117714; b=JVgWDsNB4lzM8YAyEAnrulJePb0vkUW7W82C+hRpNk2HrpW
    G8rDVU0qRg/odmrlmkBDl0difbsoIhgyPgGQjcy2n32QXEFy6wkedPaCreJgU2VE
    TVsK0mbCuF5l8sxMIuVCR4C+b51QRZYn7tjHdCmRoqr44QL+zinhRMUALPzAdoH1
    xq8Fw41S8LwfImYtW/YR1Zeuo1y+7CU7govejInUbqLGC4kr4psY/KjCtrj0wIBL
    LxsxWJzUnYc8gVZxwJMxnyWFIlmPL8V1xDh5lTB5hfF/WB+gRi7HrxVJdIOSGaHQ
    vUP+73GD90TyBd7HRku9cGcZgz6ylG6MImdQO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117714; bh=Pk0YQ2
    PkqQ4AR9Ur4tttHpwfOOF41AmSZGh4Pjg9jG0=; b=K7H7iLTbCVALJ2yRjpfemV
    qMsD6Y+JAdC1ho/iM1WjzTs86QryxqMGRKzRYp7AxzHp27XrOSNlPDyfs1JF4GnZ
    4d9khQSj44fAnsQv9y3uFF6P6r0/eROiOa7NBr0CAm/Wb6POKqy9f5+hPkReTNoo
    SyKbrwi5OWoELIBexgWU19jAXRjUK0/PcIG6BIeSyzU5WrD+sgctcc2c2KYAmIDc
    AnIkgPnTB1k9MoMvLcaf3HOkPX38cdVrm9oQOhkjPKVIB9n5zuFBJRuaEl7GaCIj
    zeq65HeA3LaNdbuAPV73F7Zn8zu4E+gbkWtmU8cBFnSOkmHGIJ8kgSxWCN2earLw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ko9xqxP3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ko9xqxP3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932745AbeCCWy4 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:54:56 -0500
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:48488
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935378AbeCCWlC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tomasz Kramkowski <tk@the-tk.com>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 11/63] HID: clamp input to logical range if
 no null state
Thread-Topic: [PATCH AUTOSEL for 3.18 11/63] HID: clamp input to logical range
 if no null state
Thread-Index: AQHTsz+eBecXbzSkjk2IF3unww8/uQ==
Date: Sat, 3 Mar 2018 22:33:15 +0000
Message-ID: <20180303223228.27323-11-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0940;7:zdmiw5t0yvJsUeaAaxAVXfPTXEj22rrFoi2Ca+ZwU8r8aDGWZfCI0HPeY06SvEUyHeEvzFd9ISSeRmJ1A4x3KNWn+9OpgkcHSLkGI37A9u0P0z0dUJDk10aa2QM6LN6+igTOBorwpV9BGo30t9r/z1sdK89hatBLqE+hgLcQudGLN7u0/nt8jlIsouzFLi6eIO3vVpG9SajuCu+1efeyIzvI+ozPZBEmk44KOTtiohH0987S1X/DTsyJuDIqHTey
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8fd819ff-17b0-4fec-96da-08d58157d619
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0940;
x-ms-traffictypediagnostic: MW2PR2101MB0940:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09403A2831B8F830B7D1A4BDFBC40@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(176295241369792)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0940;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0940;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(366004)(39860400002)(396003)(199004)(189003)(106356001)(68736007)(6486002)(25786009)(22452003)(6436002)(186003)(2906002)(81156014)(81166006)(10090500001)(66066001)(8676002)(36756003)(6512007)(2900100001)(316002)(97736004)(102836004)(53936002)(6506007)(3280700002)(26005)(6306002)(4326008)(966005)(5250100002)(305945005)(2501003)(76176011)(2950100002)(86362001)(99286004)(3846002)(72206003)(14454004)(3660700001)(478600001)(1076002)(5660300001)(10290500003)(6666003)(6116002)(7736002)(86612001)(107886003)(110136005)(54906003)(105586002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0940;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: McLViU+SQMn4GvuK93jB+6WfZ8azDAD5h9Rzgv+ydqwTjUfcQz8oGqVcIx7yL8pxMTNfV9WH451HOkB6MDDooEUUgFdsj6tDlI8aJxeJtEJmKKPzxr59DB4Zt2GMgmrILyWY5It9wdN/bjk+m1T26a8JurcnVSn3QYew0xsCC7I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd819ff-17b0-4fec-96da-08d58157d619
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:15.4191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tomasz Kramkowski <tk@the-tk.com>

[ Upstream commit c3883fe06488a483658ba5d849b70e49bee15e7c ]

This patch fixes an issue in drivers/hid/hid-input.c where values
outside of the logical range are not clamped when "null state" bit of
the input control is not set.

This was discussed on the lists [1] and this change stems from the fact
due to the ambiguity of the HID specification it might be appropriate to
follow Microsoft's own interpretation of the specification. As noted in
Microsoft's documentation [2] in the section titled "Required HID usages
for digitizers" it is noted that values reported outside the logical
range "will be considered as invalid data and the value will be changed
to the nearest boundary value (logical min/max)."

This patch fixes an issue where the (1292:4745) Innomedia INNEX
GENESIS/ATARI reports out of range values for its X and Y axis of the
DPad which, due to the null state bit being unset, are forwarded to
userspace as is. Now these values will get clamped to the logical range
before being forwarded to userspace. This device was also used to test
this patch.

This patch expands on commit 3f3752705dbd ("HID: reject input outside
logical range only if null state is set").

[1]: http://lkml.kernel.org/r/20170307131036.GA853@gaia.local
[2]: https://msdn.microsoft.com/en-us/library/windows/hardware/dn672278(v=
=3Dvs.85).asp

Signed-off-by: Tomasz Kramkowski <tk@the-tk.com>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hid/hid-input.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 6d766fe2c7f4..bb870ee75a90 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1090,19 +1090,26 @@ void hidinput_hid_event(struct hid_device *hid, str=
uct hid_field *field, struct
=20
 	/*
 	 * Ignore out-of-range values as per HID specification,
-	 * section 5.10 and 6.2.25.
+	 * section 5.10 and 6.2.25, when NULL state bit is present.
+	 * When it's not, clamp the value to match Microsoft's input
+	 * driver as mentioned in "Required HID usages for digitizers":
+	 * https://msdn.microsoft.com/en-us/library/windows/hardware/dn672278(v=
=3Dvs.85).asp
 	 *
 	 * The logical_minimum < logical_maximum check is done so that we
 	 * don't unintentionally discard values sent by devices which
 	 * don't specify logical min and max.
 	 */
 	if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
-	    (field->flags & HID_MAIN_ITEM_NULL_STATE) &&
-	    (field->logical_minimum < field->logical_maximum) &&
-	    (value < field->logical_minimum ||
-	     value > field->logical_maximum)) {
-		dbg_hid("Ignoring out-of-range value %x\n", value);
-		return;
+	    (field->logical_minimum < field->logical_maximum)) {
+		if (field->flags & HID_MAIN_ITEM_NULL_STATE &&
+		    (value < field->logical_minimum ||
+		     value > field->logical_maximum)) {
+			dbg_hid("Ignoring out-of-range value %x\n", value);
+			return;
+		}
+		value =3D clamp(value,
+			      field->logical_minimum,
+			      field->logical_maximum);
 	}
=20
 	/*
--=20
2.14.1
