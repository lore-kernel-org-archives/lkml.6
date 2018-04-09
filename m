Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236629-2-9677721335587755614
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523236628; b=kzx4vyDAa0ZJDHiHm77FIaFt6+cs3BRbmEtoAg7dHh93+xYBLE
    KZ8HYUCwloFuKBIL0lbtzTQvSP8VPqpnUpoYQ4s4iQuOyiIzQikbhBrKQoTgwaz+
    oIyppP5oPMKImDRMkkDP7qIoIcXLnbbL3Vk7pTq/ELSU+ZUnKsEqh771wVcawdkg
    vL7pS7QcxZHMnahyGuTmaImvMw1tMBQSPsCeQ8yB+6qrSmZkzSHUoy91D2Rifps+
    P7G1jM0KJ3W2x45bhYNxFxNkTRzm0RjFwGakGKf1ZdDZE00aYOV07Igf6IaEx2MB
    jF8sVS9cAm1ndLJRIlXZqL10o6H53G83sDxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236628; bh=Gce/2bDvi9
    DQcKj2UuYrY7nWR2jLeljkl6SDgbNCj8o=; b=KnvFZ/CckvZ5ZfKBl8E0DC1NVj
    M7hKhPn3nOFrffERKP/T4LqfzqiDlLm+9MgFud8b8ACNjXrv3/hgW9Md+TpVDFEb
    Vth5mv343UriKMHfUz4Elgo630sueY8wo7ohaTif6EcBoCN/o8xPkKNrGhinsyw5
    jpQd/2NaK2KlC5ONvJl7i+RUMY3uVJNangeM6LN01fNxXXY4O13HvHHwuvIgAKHX
    CJjZobbmyTwG/1ZEnZ+mxpe2dOSqwuxNykYoGyyZS1Gr/Aq1XA4k/7e7sr8bji/m
    t0SZ+JxKhXXHqJDYbBTbZEJI+Rll06cjE/RKDl3MGQOU62Lf7F+DYk7z9aXQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Pi98E9BN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Pi98E9BN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAUbIVBj8y/PA7sFYrmgxrNNGkZDURxxfYjwm3mS2gXKywGq/pp+WSEkC4PB2Wu30H7UxIwCJZOGfHVIIS3pvx4YU2N2joOVu8nhwIgBj22iI6pF6K6f
    lJ12p728xL1loC6eosNFEhIHW8M/RNJkui6bCF4aO+X+lTcuyZ0gUDqfnASNnEib+NqDT8eg9oEtNhKjEou2EnhSB21cluVPCPMg0fJk/3HRdWsjX7/NfUYm
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=BcN0S9LAIc19CvRaRVkA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753693AbeDIBRF (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:17:05 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:27456
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932854AbeDIAhv (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hector Martin <marcan@marcan.st>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 105/162] firewire-ohci: work around oversized
 DMA reads on JMicron controllers
Thread-Topic: [PATCH AUTOSEL for 4.4 105/162] firewire-ohci: work around
 oversized DMA reads on JMicron controllers
Thread-Index: AQHTz5nDAeFi6kqQH0ifremsWkWCcQ==
Date: Mon, 9 Apr 2018 00:29:04 +0000
Message-ID: <20180409002738.163941-105-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:heoD4c2h76gOYZGM03MH1iIeE/H9q1TTaopxjkvS0oGkE9mqYO/YakWMCyGVUMzH9ZOLT62j42MGYcimaFErPwwY9teOkKf9ZgQxc5JsVs3Na9QWDo71AtlkT1ZOtSADHvO75XMJ1kCicJqQ0NU4BnF9S5dIKiW0WAix2AJHNpKbyp+V178rFZICgqFYerSPYVvb7PWgcTkxsWEru+Au2TdFXdCjGwuXnBIMVNrhLpJC8gUt8jMgJJeQc0/AtwuQ;20:HyNMqMn7R3sKq7j9RRqhky2/0J/0Vwao7Vm+C7tYPgO2h0bqEbAEyLVGqwfbJUaeQW0Er7+L2p1Zp3CeEuinZZ7JFmUNUlEQO0J2wEdEgz0LDZPLkvrmr9l+fRllYR3qiMbsQ/GaUoeUeuE+ncQ1+ReU98k30VQy10Iz1puix8M=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c67238be-a5cc-452b-11bf-08d59db21d9b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11109F7FF15F78E3DBAF6C18FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(199004)(189003)(53936002)(186003)(5250100002)(105586002)(11346002)(99286004)(476003)(66066001)(6512007)(86362001)(3660700001)(1076002)(54906003)(68736007)(110136005)(3280700002)(316002)(305945005)(4326008)(107886003)(22452003)(14454004)(7736002)(446003)(6666003)(2501003)(10290500003)(3846002)(6116002)(72206003)(106356001)(25786009)(6486002)(6436002)(8936002)(478600001)(5660300001)(86612001)(8676002)(81156014)(59450400001)(2906002)(102836004)(81166006)(6506007)(2900100001)(76176011)(2616005)(486006)(26005)(36756003)(10090500001)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: i1WZkf4Ob44vIIE00EQ3Pii0zbEkk/SEyhG368DvPJNNLFJT6Ga+rFt4YEQQFQNKmMnvEKioFIPKDWNhB494qZAY9WyFus2moJTw8ocPvIueoAC924+9+SizYHNIzbsPd7WzEkN+BKymMbSsfRrWKPpytf1lrlNTbbSL0PCdoYTjH0VJrtmf4SGDzstAGZHSw88bCntJ15mx0wbkCxGYuFMZzi5J+1173Tc8nU2mfZax2KVVbVe641vRxCByGJhk5Aj+InOdUkwvGLM99RNGcaeAbebeAk1+92WB+YzQ84TOfp+o3UwFikeCAgxdzDzf8n3kEUN8pfF0AnX23NU4nP1sblEpqTOTbIgfQba3W6MIlFn8r/jWZMsLujJPInRnab3cTFg/k34Q8mTgIBxwlfrtfOEuyePlfJzVrThhwfY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67238be-a5cc-452b-11bf-08d59db21d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:04.2866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hector Martin <marcan@marcan.st>

[ Upstream commit 188775181bc05f29372b305ef96485840e351fde ]

At least some JMicron controllers issue buggy oversized DMA reads when
fetching context descriptors, always fetching 0x20 bytes at once for
descriptors which are only 0x10 bytes long. This is often harmless, but
can cause page faults on modern systems with IOMMUs:

DMAR: [DMA Read] Request device [05:00.0] fault addr fff56000 [fault reason=
 06] PTE Read access is not set
firewire_ohci 0000:05:00.0: DMA context IT0 has stopped, error code: evt_de=
scriptor_read

This works around the problem by always leaving 0x10 padding bytes at
the end of descriptor buffer pages, which should be harmless to do
unconditionally for controllers in case others have the same behavior.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Clemens Ladisch <clemens@ladisch.de>
Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/firewire/ohci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index c2f5117fd8cb..5545a7f3a98f 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1130,7 +1130,13 @@ static int context_add_buffer(struct context *ctx)
 		return -ENOMEM;
=20
 	offset =3D (void *)&desc->buffer - (void *)desc;
-	desc->buffer_size =3D PAGE_SIZE - offset;
+	/*
+	 * Some controllers, like JMicron ones, always issue 0x20-byte DMA reads
+	 * for descriptors, even 0x10-byte ones. This can cause page faults when
+	 * an IOMMU is in use and the oversized read crosses a page boundary.
+	 * Work around this by always leaving at least 0x10 bytes of padding.
+	 */
+	desc->buffer_size =3D PAGE_SIZE - offset - 0x10;
 	desc->buffer_bus =3D bus_addr + offset;
 	desc->used =3D 0;
=20
--=20
2.15.1
