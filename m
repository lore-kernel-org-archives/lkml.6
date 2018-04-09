Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523240032-2-1397729215679970333
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
    1523240031; b=DykbJ+G6K8NbOBmBZxJNC9A9nui9n1OuAaCCqAtb1+fKgrWy+g
    ZqSGmSzl7lwmXubBdhY8H0SsBOgUD1tgds6waUSY38oeNkHH04PDhG6pzZE01xre
    WM4aamZ7HSElxitCm3QaY3iLDHpGZKIeQ0VJTGCOSN4jmnKsxobPkoQaUWOtztSi
    7VPNRFoLesP9Z7kWoqhUzYqseLbCdzpT87eP24LM2SCQ5oAZSt8RiBcv57Eyq5QX
    H2N9dM2qEs2EWLDJaHcEE7PWMujcsgVOKKdGvtnQG4OyndZkEZ54TD7jXRSQCD5m
    bbBw3TxUU30iwZyl4Bu3Pi7Qf3AXECb1cpJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240031; bh=YEDQNPuQVk
    iq57B9ck0a0x1BvKp6aoOiQRveSfpqOOU=; b=iA/ADqvWD56YMs6YPOhk0xJDRf
    rAgFAm7UyrWftndRo9petNcwZlJv9EZ58eLowP0gsjbU4GI79umaaK40Xc7iR798
    HUoM+yQuQDy2zJkwgxMmFUsIfgXYOotXGbpiAwAgKKy2F2D4nntrP0bZyg31hwth
    wmG4l3md9cuGhKU2dXvmZCGryb6XHx1+TL9EVUYxtdPz10X+b0XzLo90EH+O6yKy
    nf8bL7bG/le6ZSE0N5YN7B7lLkeHrYjyZLUOJa9Me3N9B/PLK4aZgP8mFHAwDQOv
    ly7gpCxXjjasqkvGYkOAtC+GzYcGN86DHbzNyhihXa7WTfaTmd/s2Xji2ifw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A6VZra8K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A6VZra8K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM+hWoIMKgy2q3w5X3K4TfUuH0BOK3VuUFYBTViCD87HU6iEec2oJm5v5YLRiXkpCMp2hUqAdh0nM7PpMjL7+iY51uXDW7cJRtlPP0lQa0VM9EB25oJQ
    YlJYXKI7nsJerGejKauPJvv/0xV1a5cCCwx4DHutXPdaY6esTm7tziU5vx2upf91ZeDokuniD+oJEB0dqup132SipU81R6ygnlh6PYFyp+NY2bm2Q0kXpp4q
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=TZ1GKrKtRy3C7wLF58MA:9
    a=33uJZa9bTjsWuCrS:21 a=Owpb_ewU4EkmsSpR:21 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755290AbeDIAbK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:31:10 -0400
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:16544
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754852AbeDIAbI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Lv Zheng <lv.zheng@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 153/293] ACPI: EC: Fix an EC event IRQ
 storming issue
Thread-Topic: [PATCH AUTOSEL for 4.9 153/293] ACPI: EC: Fix an EC event IRQ
 storming issue
Thread-Index: AQHTz5ktzhihB7tgB0uOmopJKil5EA==
Date: Mon, 9 Apr 2018 00:24:53 +0000
Message-ID: <20180409002239.163177-153-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:/Nd4iMK9c5Ih8/kNjwxWqkOnvUyBV9vIYMI8fNyao428G3pm0SVGRJ+TkgfyXnnrUCXAXSH+sjmQ2miqXdv4wa9rPaRqJu/lS3AUEPqatUf5FgAPO9Y3eltmIknBpYbUsCQt1/iWI/FSQQ8x+Fb8o46Ez/SjucGjeUVsH5wIc241XoevpG/+1b/IFZSNExjuNTvxKn7hRJ1U4uCtN6NoFrZsVhE93OcsyCLNuoPSWHgFVU6bz6mrsG6R1o1dLIiP;20:X3wJa2+BpWU/xJTSJbjDpVnFrByz3NuWu4cZodbk/dHBZdLoPh4UeUmMvGadRP+6CW/I5ngwAybJkQB3IsUwKehmgM1NFDuD/Kv+ROSNu0Qd9+kgHntkgppqEBqzefW4cRRYvCbWNK5Xa5Y3/jqe04U2CrvRoHxT9gvUwssnv9k=
X-MS-Office365-Filtering-Correlation-Id: 1474fb5f-faef-4690-daf3-08d59db12ebb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917C68F87C4DF97C1B58170FBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(575784001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6116002)(6436002)(2616005)(486006)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(59450400001)(2900100001)(2501003)(14454004)(5660300001)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 2rl3bmY9NgLs8oXoIye6gB5vqhFerSDEYI3mQJCeT7tnWjeE3JvpsM1m3CP0unr1LexqUdBBxuacj6jOfbP/A8H+UW+rRcH7MbrjqHuHmVfVCMyfhVmK6MVyfXlra6eZ9NZgaEGYJQkYUdkMoUXo9Ci0qErTkYTPsbsRMbrdQsUucE2mkYXgyLMP81EbaTuPSaAL4Vrbi448InLaGv1u17nEf9mQ7JXnxU1+wV/D199KFPxoewMJBJ4k1Kf6I/Zzxr6QNwaF4+pDbs59eYc7Nmws+ZquyzJrji6Wl781fJi/xbsJHDajBpt1jzHTdwGePl2A4p798g4DvvxQfZ9utTd9G12peOkqrgkEOrbZ4GP3mZzt0Ge4vIWNwqvpUznfdWFS2Xiy5iLKj/BUMrXasQtTZTS+Q8do8Hh6c8rNS+o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1474fb5f-faef-4690-daf3-08d59db12ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:53.0188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lv Zheng <lv.zheng@intel.com>

[ Upstream commit 1ab69f27cbb57e0f970bcd852d9f22ed34259b57 ]

The EC event IRQ (SCI_EVT) can only be handled by submitting QR_EC. As the
EC driver handles SCI_EVT in a workqueue, after SCI_EVT is flagged and
before QR_EC is submitted, there is a period risking IRQ storming. EC IRQ
must be masked for this period but linux EC driver never does so.

No end user notices the IRQ storming and no developer fixes this known
issue because:

 1. The EC IRQ is always edge triggered GPE, and
 2. The kernel can execute no-op EC IRQ handler very fast.

For edge-triggered EC GPE platforms, it is only reported of post-resume EC
event lost issues, there won't be an IRQ storming. For level triggered EC
GPE platforms, fortunately the kernel is always fast enough to execute such
a no-op EC IRQ handler so that the IRQ handler won't be accumulated to
starve the task contexts, causing a real IRQ storming.

But the IRQ storming actually can still happen when:

 1. The EC IRQ performs like level triggered GPE, and
 2. The kernel EC debugging log is turned on but the console is slow enough=
.

There are more and more platforms using EC GPE as wake GPE where the EC GPE
is likely designed as level triggered. Then when EC debugging log is
enabled, the EC IRQ handler is no longer a no-op but dumps IRQ status to
the consoles. If the consoles are slow enough, the EC IRQs can arrive much
faster than executing the handler. Finally the accumulated EC event IRQ
handlers starve the task contexts, causing the IRQ storming to occur, and
the kernel hangs can be observed during boot/resume.

This patch fixes this issue by masking EC IRQ for this period:

 1. Begins when there is an SCI_EVT IRQ pending, and
 2. Ends when there is a QR_EC completed (SCI_EVT acknowledged).

Tested-by: Wang Wendy <wendy.wang@intel.com>
Tested-by: Feng Chenzhou <chenzhoux.feng@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/ec.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index c3bcb7f5986e..38136d608471 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -460,8 +460,10 @@ static bool acpi_ec_submit_flushable_request(struct ac=
pi_ec *ec)
=20
 static void acpi_ec_submit_query(struct acpi_ec *ec)
 {
-	if (acpi_ec_event_enabled(ec) &&
-	    !test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
+	acpi_ec_set_storm(ec, EC_FLAGS_COMMAND_STORM);
+	if (!acpi_ec_event_enabled(ec))
+		return;
+	if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
 		ec_dbg_evt("Command(%s) submitted/blocked",
 			   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
 		ec->nr_pending_queries++;
@@ -471,11 +473,10 @@ static void acpi_ec_submit_query(struct acpi_ec *ec)
=20
 static void acpi_ec_complete_query(struct acpi_ec *ec)
 {
-	if (test_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
-		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
+	if (test_and_clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
 		ec_dbg_evt("Command(%s) unblocked",
 			   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
-	}
+	acpi_ec_clear_storm(ec, EC_FLAGS_COMMAND_STORM);
 }
=20
 static inline void __acpi_ec_enable_event(struct acpi_ec *ec)
--=20
2.15.1
