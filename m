Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486692-2-10299284607267633001
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
    t=1520486691; b=dNa4SeSyaWvp8NUWooSfeAGby3T5lH989PiKFMjmVRD/c+2
    ui4WhhBzQ5SdnmwFMWH/5+8QzfA9Ys6Vg80tIAxfeiezHWLo6YItSzWlFRfqeZC4
    GnPa/oOxybttXA1u/mNrWMqywwMLNdYNLc/H53iJULKU5F1dNdTKZ9Gylfuzm8/G
    zxMpEG8OdIkbXMUMkL+78+ogP3vgQV5hR4CItqFoX+prXZYCc5WH34WS7hsg1rHa
    BLKH9cRpgurnze4DGx5al7dSZZ+CFfVq47WefHvVnImo7Pp5Ao4kgrTf7fbTXxXq
    18C/3wTWnzk4KzYPPgxXHIsDRNS46nbYXtQeODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486691; bh=EcDtjb
    80zGz1Unx3PjUU6oIbsMDIsfvu2xxX/XDK8+4=; b=JUzO/mKsjmUKvgrJj1NF9x
    YclLfEVkxWtC1jvnI+nCAJ9UhC9zfhWl1fJISkQSaESPbIdBhHPToaST/uO03fZl
    Cnf7X/0YzVsKA0abTBjG4omKj9B4Lkzt6Tf0dHhjggQLmaVn9EOAN7D1bBlzyjYZ
    AP4N372MWZryv19urkM823KvniW3/i3mPLuLa4XQCaFEcGxM+bcskLWpv+YdoDha
    J1OtBMQYR0tfDMLgWAD32SV5nUyjDRszE2QkidxaPiQ2V8K0bbP5TH4VF4UdDdWL
    sc700sxqyVhPGfiGJteqUVwP/8GmiBHddhmSgTrukPlx9gDnF/NnuHX2YJQDTQ6A
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JGJTfUVB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JGJTfUVB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966607AbeCHFHW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:07:22 -0500
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com ([104.47.33.110]:54752
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966278AbeCHFHT (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ron Economos <w6rz@comcast.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 084/101] media: [RESEND] media: dvb-frontends:
 Add delay to Si2168 restart
Thread-Topic: [PATCH AUTOSEL for 4.4 084/101] media: [RESEND] media:
 dvb-frontends: Add delay to Si2168 restart
Thread-Index: AQHTtpqd/giwrqY/VEWch/RapdsDpQ==
Date: Thu, 8 Mar 2018 05:02:10 +0000
Message-ID: <20180308050023.8548-84-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;20:bmLv2bEaxAJGhbwKvk8y1aoIEve3U2TmAuItMviUdHFbHANt38QX1slY4NKlzUwQRJpm0QsdOKQwtCt2LWVUO9VjP4B7XZv59XHzkHL7Lfuuht65y7tQz7SNtU2kLI6siCCvKQIOe4/7OCADn8g7tjRmgi4ycOTYD9xQm679CWI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9647b75-c83f-4e13-d83a-08d584b2757c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10779D5638910558D0394EDAFBDF0@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(68173958961439)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(86362001)(102836004)(575784001)(6506007)(22452003)(2950100002)(186003)(68736007)(26005)(106356001)(105586002)(66066001)(6666003)(86612001)(3846002)(3280700002)(2900100001)(6306002)(25786009)(53936002)(5660300001)(2906002)(3660700001)(10090500001)(6512007)(1076002)(4326008)(6116002)(305945005)(110136005)(8666007)(107886003)(54906003)(2501003)(5250100002)(8676002)(8936002)(81156014)(81166006)(14454004)(76176011)(7736002)(72206003)(10290500003)(966005)(478600001)(6486002)(6436002)(99286004)(36756003)(97736004)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: NcViJIdoRXCZ0oXKvM33/zyKtbjvmN7S0Yii+ge2U++hFe6AmstKIbuUHKS9k5v3gayuifMOz7fT0a16HKe9YnGxxQ254mNpfmpk/AozQWznBmKpGzwpTQfjA+t20HpN97ptnldtpVveAe7/mq9MpGDy0mE3QNMuTFTj5bEaBE5UrJ4tbsL9Y4S4XLKzS+TYoBZz3XEQxCr5bpalHfGUWZ3UPeXG+ruB2PZYkv/tnmY7846uhPzwvj+Mshq8QKxO1kJjExcCV7sL4XFq40a1htqUudNFJ9MyjJaAGVkafQytjuPIfaCHPmKH46bXwR5NksyCj7x2gjHWQgJX6lZcGQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9647b75-c83f-4e13-d83a-08d584b2757c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:10.0694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ron Economos <w6rz@comcast.net>

[ Upstream commit 380a6c86457573aa42d27ae11e025eb25941a0b7 ]

On faster CPUs a delay is required after the resume command and the restart=
 command. Without the delay, the restart command often returns -EREMOTEIO a=
nd the Si2168 does not restart.

Note that this patch fixes the same issue as https://patchwork.linuxtv.org/=
patch/44304/, but I believe my udelay() fix addresses the actual problem.

Signed-off-by: Ron Economos <w6rz@comcast.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/dvb-frontends/si2168.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/dvb-frontends/si2168.c b/drivers/media/dvb-front=
ends/si2168.c
index 821a8f481507..9d6270591858 100644
--- a/drivers/media/dvb-frontends/si2168.c
+++ b/drivers/media/dvb-frontends/si2168.c
@@ -14,6 +14,8 @@
  *    GNU General Public License for more details.
  */
=20
+#include <linux/delay.h>
+
 #include "si2168_priv.h"
=20
 static const struct dvb_frontend_ops si2168_ops;
@@ -420,6 +422,7 @@ static int si2168_init(struct dvb_frontend *fe)
 		if (ret)
 			goto err;
=20
+		udelay(100);
 		memcpy(cmd.args, "\x85", 1);
 		cmd.wlen =3D 1;
 		cmd.rlen =3D 1;
--=20
2.14.1
