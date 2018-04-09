Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241366-2-17296265228628397631
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
    1523241365; b=IAd8WyBqKcQj2CJ1mrBFOnhCKBCfZ7pUmqffFYlfmCuT2RHUyH
    0SPM2d/wTn8opFFU/UerqgPZ3p4CKQRUcAYvZYCscELnc34pufH/jyT6AiElAwGY
    XC7uXJAJ7BoPD2ryOl8TIv5MUQCVElaHK2GkJj3cY5uASf/CRLTkbyapOK5usIxI
    W2tBoHfCRBXMfqQ5iRtedRuGxYKhCx0Hmibz1xhNzGgC4bICY/D5aXo/j4mMqLwT
    0nmhBe8hS4BX4gIZZL0cM8CzGqnsLLOjp8pxz3toMbCYjxxbMfAp0va3tHNjB2cm
    BCLM6tV+r3YnSPyfrzQ06iJlOvEbzpqhBdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241365; bh=xYL0Od15CL
    fiJ5IwqTRtVPzK+Jf72lwOSfiTa2Lkb5Y=; b=Ixpd7arIqrcMaXG/EzVpw8Zn30
    bW8/PGcj3Y/EKtSTtEXL+kgbSazRuXkBehTxvr2GTLRaAy2NEyehAdF2dBg/oJth
    3QE5BMqj13tnmHnqUt2Mp8KXeEEXwozUSamxHBAOJFq4yaoQWrbZZJI7qyTu3KOX
    lvguUBdWdIiiwWXWSWIOp4SIz7n9mJc8LmD6epByYx0FCK2V/U5tZzpvFXlZ5DE6
    EdzVQ7uIzgD6jxr7xYrUzk6KgqPWUjLj0jpO2crTeaXkHwTNJMAn/gUgfSuVeNIN
    pXrziRHOoA7wD4NRdQ/krmNN97+y9BekTZR5uq9uhZQmXTVSTwQv4TBWYP1A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V6zZS6WL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V6zZS6WL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAvVCUGL8MrhiB2k+prU7Kdfj6dvLNvqPW+OvISajo8Af8BpPwnxTp6oRHVFkhEkp2Eq1lXHZFTcHdfssXn+DNlNiMNtLFra9haCACHKpvTgHxOhm1k2
    gGH+G1w0lSq/2tgFBt2Za9kmjB0FC9euLONy6AUFUd1Q/bYp4N4IE+cAkVYK5madAYlgH1Qni1VCmn0C4cnzhqX9Om35M+JEM3CIMQ8iV/X8Ui08am6dmZWO
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=x5rFD9gtvE0LbX0pWFYA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757909AbeDICfe (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:35:34 -0400
Received: from mail-sn1nam02on0101.outbound.protection.outlook.com ([104.47.36.101]:56960
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755637AbeDIA1h (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 056/293] PCI: Correct PCI_STD_RESOURCE_END
 usage
Thread-Topic: [PATCH AUTOSEL for 4.9 056/293] PCI: Correct
 PCI_STD_RESOURCE_END usage
Thread-Index: AQHTz5j+cSn/fn3RLEeyF6wOhFbl1w==
Date: Mon, 9 Apr 2018 00:23:33 +0000
Message-ID: <20180409002239.163177-56-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:EgbHsqs3Owxgq7TLG/hTErotedL6CfxlwwSGcfWHVF8p0QAGcRJ+mMA2cxoXdh1S17i1p4OFbT+OH/34j67wkztZIf3JscoSofPFfrgbfOhDQ5SesSQKes+xgenICuepeDEnCRJVCyHrE6Yl6IMrqH57d/wA8W3dQKhInec/r/rKGqBpprXmtKYhLukX1Pac/HfcS1bPmfBE3JGh4JL+chC1W1Iair6nhvSFwMcUv93LH+gWKrn3GbAUfYaFRgkB;20:HI0e31qbxUZlSnYfn7gHvPR6l/+11D3UTe091y7EatqGmszXYXHHVjpT8vGCw+vGxg1LX4RGF/Xu8x2Yxn/CS35QGXlAS9ZdwHnV9l5/1NQ9IWPQOsISRsWEpBhsuNmGN44gPlEtgiuDijK2MXYVZimvZCXc5yozximNevBVDwA=
X-MS-Office365-Filtering-Correlation-Id: 260b76ab-e049-4f87-2a5f-08d59db0afde
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB087191C439B7321D9BB8AC8EFBBF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(105586002)(8676002)(59450400001)(3660700001)(3280700002)(6506007)(81156014)(81166006)(14454004)(99286004)(72206003)(110136005)(8936002)(54906003)(305945005)(2906002)(316002)(10290500003)(478600001)(7736002)(53936002)(6512007)(486006)(11346002)(4326008)(86362001)(446003)(3846002)(102836004)(76176011)(476003)(25786009)(22452003)(36756003)(107886003)(10090500001)(5660300001)(6486002)(86612001)(6436002)(2616005)(68736007)(26005)(1076002)(186003)(2501003)(5250100002)(2900100001)(106356001)(66066001)(6116002)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: XiZ7Ol01R+xfaKDQxUb/i7WmpyjbAw9OlDaL90SLYlOhLyKeoTK5eVSm9OoJ22rqCxfbBss8wLjQTuldw6Ik9a3m/sdQxh6+fHvcloUaJ54CxPV4qXFEgai6fWmAB8b0oxwO9C3ufOVd+npHIwoSCwLGtJsYTg8Db/6q7st6vMdAEMtlJIdSsn0bPPq2rul2TMkTvbK59Xgg5QeGhJOm7dMxxmjiI1KkNTncLJvb/uPQoXN/vKhcHcUFIFTpmdQ7JeaEixsZTuW2Jqpr+SHvZ0N3ntW5U6LJ3iv9WsJqz418rVNrEb3T3H/usWRMyEGOq0QbHbxIKdskMc6Pk/ORO0gH1QlWjlKrXXVoKUSaMruYDxLG6iZf1BE3t2rNiaR6wFPf3u7hLFQVtKuECD4vCJCuogC9qooo5ocYkI2fJtU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 260b76ab-e049-4f87-2a5f-08d59db0afde
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:33.5342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
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
index fb177dc576d6..0fc4843e8589 100644
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
