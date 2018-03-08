Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486067-2-1917241951437377066
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
    t=1520486067; b=iQM0Zi/QtAzcwrj7UzdzwviRSiRmK+HRq8txh0CyfQx4H84
    lkHmPbivkNgVSyoBNyK52zYrVZhVVYvxr4x4q+xNc8LnDJYotIasokDU4VRa0SGY
    7Ct/hYZhZ6BxM2vOmYD69p5v6Ugj0PnE/AdnIgEHVms0h5NCnFz+v5EIRUBA7QKU
    7bMek1aILRrPZV7ZnN1KyoQ23a/jxOyNwkPlIVgNTDjBqpuFBUtq9IQMqG47pleC
    n5E7Fz9ra1qvqBJNKSbDaTppHd01N/Uk9WECWQNWsgdMel7afbNKZ+WpWriE3c6Y
    zd93dtcwCHx9YlNq7FR7Flyb1pEz9nH56iyMtsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486067; bh=Rla+RB
    WwYeWtGl2XWtEiqqbPbdNaAP/bqQBrNvNkggc=; b=NUZeKKOeEp4XeklEyBvgUx
    Iww/dSgKufk5tQq7OFLk2Hd3dXqDszLhKc1gpjoSZdF3dDRgeKZCJAh7YpJt3u9q
    6/kuP3BBAv5I7JNHG5CZ1gQxJR6f15eOw4oLJUXmqYSmTjWuOvI7xE4+bo/Wh9Hz
    Hbzpcps2KIhcA78+1qs2U4hk40dvbw9CWaiawS9UbENBwEqxGTbj09LyK3fJPAcL
    ZvxDK+9aOMH6s+eSdU0rN8DKdQxZ+k8x8jR9Vl3qo574tR3qLPXE5kJ0frE2TuXN
    PaaJccugFyTNomE4MVFZC1+25lm9xVbS30CjNAyU3EQIvP3m6If0drdaWMftgixQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VWh1ruNZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VWh1ruNZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbeCHFOK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:14:10 -0500
Received: from mail-bl2nam02on0117.outbound.protection.outlook.com ([104.47.38.117]:29164
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966914AbeCHFLs (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:11:48 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ron Economos <w6rz@comcast.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 46/53] media: [RESEND] media: dvb-frontends:
 Add delay to Si2168 restart
Thread-Topic: [PATCH AUTOSEL for 3.18 46/53] media: [RESEND] media:
 dvb-frontends: Add delay to Si2168 restart
Thread-Index: AQHTtprLMerSdDmFi0Gytve0ocGS8A==
Date: Thu, 8 Mar 2018 05:03:27 +0000
Message-ID: <20180308050230.8876-46-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;20:er+iLNDRita5/t7grLCYGfQTICgSf4OhEXX3rpgn8zdkf++CKQgUo+0gIrZRSJX/2AOAHb1CGLAmi/kN8e8PibbI0kR+glK+CO4qHSlOvzKebP2l8N0z6PQYY61SWv0+zUS2OiyxUzwHSxOUtJImwzMifWS7csqFAg67HToLeY4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2f19d3c4-2cba-4322-ab18-08d584b314c3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1030E5B6257A838AFCFAFCA1FBDF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(68173958961439)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(5250100002)(316002)(6666003)(6506007)(2950100002)(26005)(76176011)(68736007)(53936002)(6512007)(6306002)(2900100001)(86612001)(3660700001)(106356001)(10090500001)(99286004)(2501003)(4326008)(14454004)(102836004)(575784001)(25786009)(97736004)(6486002)(86362001)(36756003)(7736002)(6116002)(2906002)(478600001)(6436002)(107886003)(72206003)(186003)(3846002)(66066001)(8666007)(81156014)(10290500003)(966005)(1076002)(22452003)(305945005)(110136005)(81166006)(105586002)(3280700002)(54906003)(8936002)(5660300001)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: een1WupddUDBv1bpLcoaPTmQNEjm0ILLlNk/j2TCbT00Q9Fgl+BbsllFzQU5JH+4byQcNYlygPVtrLbWOIqrFYv68b/+z1MBu40XbjGKjVNwlk7wr0vOni16UwcqRwpeFlVMpBrwqW1YK+eHOb+UOns0+9wolFn6ns0W1uufttctynQ7y95NvgPpp0FXK8kPvpfaimgskzfFr2XVMX2Ml727Qu+H5W0PGXDjZwaxYx1+5rZh4h/369jo1z/FB+y1My9eZk0xBKvQyECf3hp+r+zByT2kv9x3nW7T56hr+xzVpLwwUp6Nb3OEQNT3FiMpin+osmw+0vlWYIqG5ELgaQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f19d3c4-2cba-4322-ab18-08d584b314c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:27.6419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
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
index 64a759c017d4..09fde4e51210 100644
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
@@ -380,6 +382,7 @@ static int si2168_init(struct dvb_frontend *fe)
 		if (ret)
 			goto err;
=20
+		udelay(100);
 		memcpy(cmd.args, "\x85", 1);
 		cmd.wlen =3D 1;
 		cmd.rlen =3D 1;
--=20
2.14.1
