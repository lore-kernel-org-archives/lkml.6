Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239294-2-16249412293643358635
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
    1523239294; b=D/7vhp3Tto4b4FwZODEMFGHnS7EdvpCYAwzUHPsZcNwukIgvS6
    ndj/1MTxHXLQmyr3XY2zqQsVfanqesrPgtfT2FWhxpdcYHghFycIs4T5IIlGkl51
    ietnhMUg26E73jlfsMAzDrC7qh1MjCEISO5uG5/3M5v1Co7iQbq9AWyM1AP4zse1
    oe1f+u7z0UJ1eAInL6lctqHy1XXQhV9+Jb5r/ZJYapgcbCV8sqIPI6HlkxxukODx
    tvh/tuL9L+75vGWJzOhFomlyC35iUAsDH6j8HpXwdS4LSdDzeig/8H1Ofz3joZid
    OpBWHHm9nu+GfuwUFsVWlFiibswpAsgIhFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239294; bh=X0bJ3jAZd3
    WNdmj/FRtNyFYkrVvb9L8qG8svt8n6VdI=; b=eXewaHVVO+ZSZMA6U6mUazBnfW
    Pxm2nA0trmvDkbk5MseXmEIww4SgTAB0J/KBFNfMAh1c8xriiHsBOuUzzIp46IY2
    NT7q6GxLRYePJ+lUv3WrmbIvPRpiPoOHOkATEg3fSveB5fY7uNwadFPh5eWbbtpY
    nkBMD+0DcHgcYmiWEkOkevK9TlDnumNAZ+lJHg74N/Og/npTn47oBuof4p31c7qy
    AOIe8HySMJVbYHBVjC1szoEgt3rvEpNUImdgYelzWiTZ1ZIAe0eae0HnXqx39qfZ
    u7V4rHU/vMA+tM86IcXD8YKHFdrh5V2dKozYeNHJxbrqDr9YVA+anEwoTV2A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JIeCI/TU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JIeCI/TU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA9gZ2vOXL1DI6tWDDzcF7zaQRGV/hUIF56c810gfx43xex+iTDeP5ciWe4vRDssGiOL1IvJKjj1D2D6OISjcG1xoAJeEunLweRniqEiTnjLRI9CiwvV
    sqSuiYfPX93TQBqsVHrwk/ZwFxsShjckTuDA7IWcbXiF7xl7UkeAVpbLOXZxmc1LNMrj54LRn1vNYxuqSOzC+plYMSPvv8E2PhRA5FZ6/wGeSXm3bHYwM7IO
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=BcN0S9LAIc19CvRaRVkA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756739AbeDICAf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:00:35 -0400
Received: from mail-sn1nam01on0125.outbound.protection.outlook.com ([104.47.32.125]:41312
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756473AbeDIAcP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hector Martin <marcan@marcan.st>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 210/293] firewire-ohci: work around oversized
 DMA reads on JMicron controllers
Thread-Topic: [PATCH AUTOSEL for 4.9 210/293] firewire-ohci: work around
 oversized DMA reads on JMicron controllers
Thread-Index: AQHTz5lIEqPjPjSKvEyPJ9zurZmL6g==
Date: Mon, 9 Apr 2018 00:25:37 +0000
Message-ID: <20180409002239.163177-210-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:3uBFF+1GNDlRONtYFDpauAdQjcRD7N+7mjm0qHWrhDA24KhEVRFzvSyu1NTjnt/YambZY00PiGrOdHvvuTsyjqD2DvA62IeyCli+bXue1Y4j99x0e6CzKlpUhr2lmx1CdvVaiUxRdUmN5M+zTZtAAj0pbQ52m01pO6DhZjnnsnE7SnVB0jWekw+1x17MMPOrRYItOVk85NNVAAeXofABb9bmw0Gu2Y3aqrFewds1ySqTrEFWq79SDKE+Mv5VhDxt;20:EgoTJj0uXVYc5YdEpiT5od/avTgM0DZGoNRGLh38kbOoR02KqCN6GR8EqYuVNiPBRy0aSBI1D9ZsHEy+O3MX5cMBwMY+3+l34eaZ9QNGl7j8m4y1q4R/G49HT5HMs+9vHOgINvqaPjFiWt1gV4V9lQN+RuB5hP0Ct36WW26oEcQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e4ff9747-643e-47c3-c9ff-08d59db156fe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08069B0E4E6EE618656EFCB5FBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(86362001)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: HzracEh7Hb2LxS0cWb4ZcI4BT0Eocly2NwaLFdTzEEMzOVolVvAvkvsxIIPpOvB2JJh/T71EQiI5sGIi4tseprbK1Y/cjdlxu6K2k6XeQmZfHJSJR5eAOqT1Y3Xmc7yVKhJ/cGHINIha5nLPk5V7fMWoYJ2FgrPf7UQGGEKIZf8L/0s3mMv9G9SG3j7qIHoxFeP+Q6+ExclIZvU2egq+mL2t4+XjwXZbFDYMeEXvgqpmMGeZLRIajx6Tm9DZEumKtG3dEEnGPJxfCe2feGWq9ERe3BaQWqiVdUAOyanxb611E5hY0ZerK17ivljNSn0L3o7qxKTu6bHM78zZxqIHXV8pPFHkOD5mun3bwPNai7yEL+Rp/VaEmZD4fgO9+OSLxK0ivodhK07Qqu5/j4aCVQspv34NjLzgswKkd5Qx1rc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ff9747-643e-47c3-c9ff-08d59db156fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:37.9409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
index 8bf89267dc25..d731b413cb2c 100644
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
