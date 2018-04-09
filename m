Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237687-2-7599358521941544234
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
    1523237687; b=fE5iM9srX9Q0Owd7AOyfnOf2s92w0Pzyr5PDSFS/EGXR8GEH17
    1AzbSOOp4hxKNJwPMWNG0Mi4kZfHnCRFm2TMFVtPJkB/4M1tLnCE5eTC7j0hGeuk
    tU4VoFCSNVzocgqNDwrvCzR4BPM8eZ5UjTWvomYl3yytgIWUV6fSsWuJd+lEu0jA
    YfodG+Dp0fIxDiRzb9AILggtfQcJDIJebMdMwzzrdZX8COn721Sjos9NTSH37tOE
    9y31VR7wO9JYt9qv2q4lI/9hishQs4WH68SpCXEL5+NKuY9y7l8laWo5/rf6w6fS
    0gT4xM5Tmans0rWiDIBEVzi9Gi1c5Ypcrstg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237687; bh=D8VG+OC4dV
    GTGMC6YTmPWhhOi8w+Ljm1yIWLfr73EBA=; b=ENolSDf+AbhmBDn242Atat7R8E
    uyNVqpJ7SjrFnbLMsec6AMwMdfVsv0XLWB/xPI0Uen83aWMIA+9Fb77k9wEt+1AL
    wyXWdCs8AfJqcWpNYHRRltMbLiUCxx+2FbRoNGiIamDt9UiGSfYElEcgSR5l1YxM
    M04QIQNnq8EgqK36jMsBX8EhhQXMswhBRaXusbJNgKxht4vU3FiyTjnwh2FOAee9
    KFF0IdaAjlAgA4fsNNm+mUdPfk6TAf5Siv8rRNa6lArMfx4gSpbMjenuVNI2Sand
    TubU3hAhfEDc/NgFMxaxFmPPs7IPDgcxTgNSQORzmNkl/SX8CHYgjQzDQh8w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HqucqdNj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HqucqdNj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCAqUrhUFYbhbpMLkI4DDvQehJxpaxVDxOR+YVXcmHJps0jKbIX6VD0SA/xgDHEdqcxkfoEd4q1z6cO1MGUx9H32iLzZyQsAZsHINe6VAZ70JeRClhES
    KJvbZ8w3JPT7Xe9JihNiOwV68sxHp/mCHXABGWcuNmsc1AABdIm+jjHPo5d+/beFwrV01XxaIOk8LuWASPYQg8FEcH6zp9Dz71dij7gkP2f2FPyDvKdbT2i0
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=x5rFD9gtvE0LbX0pWFYA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932725AbeDIBei (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:34:38 -0400
Received: from mail-sn1nam02on0098.outbound.protection.outlook.com ([104.47.36.98]:45151
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932595AbeDIAfL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:11 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 028/162] PCI: Correct PCI_STD_RESOURCE_END
 usage
Thread-Topic: [PATCH AUTOSEL for 4.4 028/162] PCI: Correct
 PCI_STD_RESOURCE_END usage
Thread-Index: AQHTz5mffdEG0RkUEUumcnd6H+oHnQ==
Date: Mon, 9 Apr 2018 00:28:03 +0000
Message-ID: <20180409002738.163941-28-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:z2A2Scde5wRd+tIGiZvTWtugR+qngw9ZMjnLFXuZ7fgRYLAXjfrqwjjvPgPYY11ql9w5ogyDlHvZIfNEiIZBZ1WaO8F5LW+U5rLZ9r7vi4xE6IyNB78mh5OCH7FHaXcwgco0kWPbzWfNi0OyR6xlQin5C/GwK/uC1Yxot3gZ06i2RGHRlBbOFgG461bXlzVHM/R0puB2+SP2ZK/VOb8BlLWgoeR46CvSeZrDMN87+KvF1uhZoY0rhZtE3eUZ++cK;20:z2+L9xX7fn9EZUAYluTfjQxHn6rRABD7vgXrn/K2h+exHU8pRmnetQFUNSpIla45ClV+q0sbC6feO4rgM7B0O5wTNdmHJ+mUbdmhSUhDHw8k1fBD5S9BhSf/LUbR8O4G3LtkBpNse+TXltDGhl/VM2dW6KfuKv44Pv0h/2pXgwE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1fe657f4-b86a-4510-766f-08d59db1bf0c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725E2DD4136940755D866F1FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(86612001)(575784001)(102836004)(5660300001)(14454004)(476003)(68736007)(11346002)(66066001)(446003)(99286004)(76176011)(486006)(10090500001)(3660700001)(110136005)(305945005)(106356001)(316002)(105586002)(3280700002)(59450400001)(3846002)(10290500003)(6116002)(22452003)(6506007)(2616005)(1076002)(7736002)(54906003)(478600001)(2900100001)(2501003)(5250100002)(8936002)(25786009)(81156014)(8676002)(6666003)(6436002)(4326008)(26005)(6512007)(6486002)(81166006)(107886003)(53936002)(2906002)(86362001)(186003)(97736004)(36756003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: /usNTDp6zdmCA6LeUQoBVKFMHOUXcFofJnDTCvBRBc3eo/8IPsurcMS9lET0DanvhqMPgzdVl/l6oQFNSQOQ/u1n/7WsIe0H9br6jfA6GCCRwJ+LzPypNN9whyzCtCt8VPp9jq5cPOVZIWNJyZNpZiLN8GR0t+uS4+2hBDYBe52zBUmZA/JPwYqQayKgVjbeSGX1KYGMlT5bReCsD2v5MBwrWmIfH3ew7qxu5S/flOALBvkXDdJ/C4UZIsuV9+lJLcQrPBLLhVshc2YGM5BR0HS3x71bW6oNYThYaLyR6SnKQT0EJB36Q82utayaWinaFOHSwm5tJSO2I3ImOgb1LEYWLioanrT8ZPWRmgN/vokzeX3jfGGAGl4UL7+OGWDzbOnxV2BUiThRlbiMe0DxXJCLGf/swkTbCQfv2laP8fQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe657f4-b86a-4510-766f-08d59db1bf0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:03.0361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit 2f686f1d9beee135de6d08caea707ec7bfc916d4 ]

PCI_STD_RESOURCE_END is (confusingly) the index of the last valid BAR, not
the *number* of BARs.  To iterate through all possible BARs, we need to
include PCI_STD_RESOURCE_END.

Fixes: 9fe373f9997b ("PCI: Increase IBM ipr SAS Crocodile BARs to at least =
system page size")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4eb1cf0ed00c..ae6aa7b385c2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -304,7 +304,7 @@ static void quirk_extend_bar_to_page(struct pci_dev *de=
v)
 {
 	int i;
=20
-	for (i =3D 0; i < PCI_STD_RESOURCE_END; i++) {
+	for (i =3D 0; i <=3D PCI_STD_RESOURCE_END; i++) {
 		struct resource *r =3D &dev->resource[i];
=20
 		if (r->flags & IORESOURCE_MEM && resource_size(r) < PAGE_SIZE) {
--=20
2.15.1
