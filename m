Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523235058-6-17097958116599609243
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235058; b=LY6mZ78sJn8L/vvD0T7re2dn3G0Ubn2q5DqbMJOn0BJdvs1j8v
    z1UwQwpKWfmjHug8Z8mi/wzsKCZDPCAtozvlZGMj80pQYg0eq+vA0yalZL2jCtzd
    pxGqtVraHY2M3MAyf5sScZiyoJeyXKyravS6r1HwICLsVi52T2Q2A1WLiIJbdAfa
    suZQaFpTQQI+twv7YL6QaWL9XUhp+3dcFWWP6KuE07ueHmU+7KcpiS70HHe/Xxtc
    fry823VWDigjhNf5Zyq3QW9VCH3P3xfAYYBqbLfjpe8L0JYUVhypa0jxylC2DYqc
    S4GD25KEjXmO8w+Un3xYru06fHFO0kfP09kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235058; bh=mKLL1kpr/B
    ckfFMZOo2tK+N4ZXFO7jd38uvtSibPFK8=; b=Eg0yt/W8f+u8NerigHnWGNdJBf
    72Act5HqDYFS0vTFUhUT0gOEhxoIjvAgv4gO2nZj8RQfASc0Rg8pCLzfKWQatnAh
    RHu3Cwh5wt6/+pwyKb711Zt+dnmd2IeavavxoD6Ai7zCWFh5wGUVqA3LSe1f4HSW
    vWRWLJ/CMTvtuNCCrAGk/vGHENWLlVF1zwCsrkM6D86LFWBchTPU4y/jfdznmDdF
    /UjlOJIkyHVGxAOD6QR7I1bCU+4ApZ4HxRVyKfLeBYvHhSA5wcv3rUtdkMdf/++4
    lx1kvk6ogzHS7LSP1i+7TZUAqkUtFgpYP2yzjyoF7nAVb/rTcGcsZtopFFNQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B+z0LDFF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B+z0LDFF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLEybDqBLFR0ifDdbsCFb7mSsbusNryzsIRr19Ta5W7RH3Lvh70x7p1pHijnPgSHQhxW0FS0XmC/bVDqDuf0RuS/SBNUy/gPFRT4JWBYBUH469cERUr8
    bqG8alOwb71O8w0nFVVXimrhZ22Oyc2wrz4e1lySSbGWeWfJkz+Wg4sy6T+kedN62cMyfSBxG0yXN1XcWkv7IqKTBmoousOT3EbyResYelo+zJv1fgnFosB3
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=BcN0S9LAIc19CvRaRVkA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932162AbeDIAuy (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:50:54 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:24363
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933456AbeDIAlb (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:31 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hector Martin <marcan@marcan.st>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 064/101] firewire-ohci: work around oversized
 DMA reads on JMicron controllers
Thread-Topic: [PATCH AUTOSEL for 3.18 064/101] firewire-ohci: work around
 oversized DMA reads on JMicron controllers
Thread-Index: AQHTz5t+xPhfUuy7W0m73HcbBZkJYQ==
Date: Mon, 9 Apr 2018 00:41:26 +0000
Message-ID: <20180409004042.164920-14-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:KW1Ed70uTxvVRoJpR+7m3se0IJzzKvtTg1keNXYTBlzmR8CE+OTW53hpLQzbJfey9esjlNVHIPAfpzqT8Chw7LAgdKQXFxOGlg8HOv5EUiru2hHFVQQbTgoiXMkJTpeNY5NJEf19ndwDy83RkRVvRUiuqAKUpO/SIwD1ibTHbWd88FZ/34UUpPYN36iMQQos0c6C0Ul8cHW1dF0jdYSof3r2jL+yUEDUX7rfqnmG3E4emB/UQk5f4QgG6JpYYeZz;20:YVli65y7qYlg3JaitU0yQ6/qlilwe72y8ces1SbmvYrpNE7xf0avzKsYBkyqVIXsMtHVls1PK6l28zzwUMczdjHYXIfh2ZdDXUuKv3YnD3IY12/szAdmFH+UgRdesCHqgK28eA87RxpECg+F8LpdcQopamm1YDvr9kcp7E65OnM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: abce52a0-91d8-4baa-4375-08d59db2a0c1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09011DC1988936D1527873EDFBBF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(59450400001)(99286004)(68736007)(10290500003)(25786009)(86612001)(6116002)(66066001)(97736004)(3846002)(76176011)(6512007)(54906003)(6436002)(4326008)(53936002)(105586002)(110136005)(6486002)(3280700002)(1076002)(107886003)(8676002)(10090500001)(2501003)(81156014)(81166006)(5660300001)(14454004)(186003)(3660700001)(102836004)(7736002)(2906002)(26005)(5250100002)(36756003)(478600001)(446003)(316002)(6506007)(2616005)(106356001)(8936002)(11346002)(575784001)(22452003)(2900100001)(86362001)(486006)(476003)(305945005)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 2a2NQnHhKnFsBWAjHYPQqNBRWr7JDfjoAvwH/TAGGamcmOYnGZAC4J6IwSqCmd/sZF2egUVu18T8q6jx+qds5O8oNONY2lL8qV6+BR/xE/AKPaqfQWMcHXI4UsAMwNurZ+TJ+s08bGPPAkDNSisqdFSsfiPD5DILIzuETRjlkqRUeJ5FywPGdgScoV1ZrdrxvsVluXZ7AnJ/2Xo/fNRJCdPC1fCg9Uoth/gCU2EaLrQ3wN6y7Fis1mycQzuty4T6Q26v55cO7t76aiw7SNdbdmJZGszCMFOBbRq49qe9VgRiJFHiYwNEnTn06bG084RQ2wW2r7tH4iw1umyPna9x0OVX5yKE/s7L5scVDc9X00P41APi/Ig9ndszwNNosiTMy3PyXzzeCHhZ3uIOVa/U9Nz//vLJzjVsMJuiqeotd0k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abce52a0-91d8-4baa-4375-08d59db2a0c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:26.7365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
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
index f047d7c2b643..437f5f0c0d93 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1137,7 +1137,13 @@ static int context_add_buffer(struct context *ctx)
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
