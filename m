Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520487329-2-7510482118471050938
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
    t=1520487328; b=p97wzqbcXlASyJwSss6ITIScvbwNjPKk1HzRjU7hTtGKlVn
    k5eEmCn2vmRbGIPK+SZqjCE+Lh3cM3vDf+6wFZQ6Q6ZlpDdJnb6yTTAjmV1EFEyv
    LmnxWkiSl6XlFLP0w/LCi5glS2swySiUT9ik2oN7EXVqqaxcW6Y9Wz0EJ8ZGs8MS
    TmCrKA08tUlovAubwgwWnp6wjxfgTSpFe/gy2cA5AfNiarTTpGLaS9CRfvkpqE+r
    Z8amOf5Kn0P/iPcaVLHHqQENqr+pl6KJ9S+Z+zLg4PNduNUhgVzQ4ydSKtjrV9Qv
    R15twfvEVAEhc8Z64Xz2OIkF/j/81A9qcvXDD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487328; bh=3txU4T
    /O5SH3ihDE9/+n3Bdr3CtZ3I1ynw49sNnxoNY=; b=YOyqFAvUAMsM20x5nYxwC9
    AJB574xUizerrqiGluiwX9mqJ7urDKT3dJQCJvIl8tb4gRsmbacLxIs8D01xIAFD
    sgojsYiMfMfJ+FbFGLwN1IlBJQj84VCKaiOC6XDV/UDz8jPZYlBzMpLc2NfzFfk0
    7o5HV6gg1b2G8cLPXRXAvHqbO2fnT06Bl4iyEBpWRTwHwLMoZCTBVjHshhkSIXPT
    ZW35iBusVqdhY8qYP15/IAa3T8SrQnVD1bC1O/vJvogeCYi2Y2NpSrnIZsZb/bV/
    Zz91g+oGgWnVGluKOL8cpe0DdES3dDrKGItYSTP4Nb/UJuehXmuNzFUArK7fpIOA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KUKSnQXq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KUKSnQXq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966340AbeCHFGC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:06:02 -0500
Received: from mail-by2nam03on0097.outbound.protection.outlook.com ([104.47.42.97]:29143
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966315AbeCHFF6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 042/101] Fix driver usage of 128B WQEs when
 WQ_CREATE is V1.
Thread-Topic: [PATCH AUTOSEL for 4.4 042/101] Fix driver usage of 128B WQEs
 when WQ_CREATE is V1.
Thread-Index: AQHTtpqMG37rLSHx9ECbAJF4/NkkPA==
Date: Thu, 8 Mar 2018 05:01:42 +0000
Message-ID: <20180308050023.8548-42-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:CVSlBVLLuHIGRb2HR4ZRC+yYqSbsxjXx2BWWu+OKV7teT78BvctMRZv+/gG9jb9Hg23s7H0AV5jQwLPrTB773elzWNQKyquWHnmjU4Imkeyt/UCiIZgiQbQJiXdeEzUCquzZu0+Q8FsxAv1tjf0+XlR/7U+HR8i6VvCSXSnONVsbBikvryusSByIIbUpaaT14puEe42MCwWZ/0oY8mmYl7DZj9OZsFnK4J31aePIHN5iphDLvV9oaqma/KwK84Wm;20:qab/r1nCC/h3tfCCnmYfWV7lNl21VF72CfyADzygLYQOwf917nfXksfKOZgcLZa08kM0fES5nPJmXsG6GVzLWKBZ5Ud/hH4/JJlmLkD7i06daB73d5LSfojOXpFVlY8S+nFz0EC0ZE7rvVp1Ev0r1fJICNkBfXgH6F1zt2sJr+g=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 659e0ed1-7ffd-4ac9-b9e6-08d584b2469d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09174ECE46837D6A748A59A4FBDF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(478600001)(39060400002)(2906002)(6512007)(6116002)(1076002)(7736002)(3280700002)(5250100002)(2501003)(6436002)(3846002)(186003)(99286004)(86612001)(59450400001)(53936002)(26005)(36756003)(305945005)(22452003)(6486002)(102836004)(10290500003)(72206003)(76176011)(110136005)(4326008)(10090500001)(105586002)(316002)(25786009)(97736004)(107886003)(6506007)(81156014)(14454004)(81166006)(54906003)(8936002)(68736007)(8676002)(106356001)(6666003)(3660700001)(5660300001)(66066001)(2900100001)(2950100002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: E5Vwrcg0OmfGODDTnz1o0BTUcCa5gwWrlSHN9dYv7bkT6s+9Pdd/Cyq8DORMH7oHGiCMovfVYjYtmekro5ZVZzJ44H1DqkDDOXMG+1k8QIPgVza+2py1PJyW9x7WbYzj8SL3P7AufwrfIh9QPAkRiAjvjtDWc1vp9ix2orST200YdcpqZKPVv55cNvOe1Pdkjwc2WwLR8QkzZRpkN0rqndMeDqHr6Xm6w37d/kKljfhR5Df2z+g58rdNWKrfTnG7yKssYBI/cdf9ncB1QmqBmkmTOUhm8kdVDMvneRz7peffxK1NcUzv33yPjnbwN9clwOWoB65OGbHFD3wnx/NC9w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659e0ed1-7ffd-4ac9-b9e6-08d584b2469d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:42.2487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 3f247de750b8dd8f50a2c1390e2a1238790a9dff ]

There are two versions of a structure for queue creation and setup that the
driver shares with FW. The driver was only treating as version 0.

Verify WQ_CREATE with 128B WQEs in V0 and V1.

Code review of another bug showed the driver passing
128B WQEs and 8 pages in WQ CREATE and V0.
Code inspection/instrumentation showed that the driver
uses V0 in WQ_CREATE and if the caller passes queue->entry_size
128B, the driver sets the hdr_version to V1 so all is good.
When I tested the V1 WQ_CREATE, the mailbox failed causing
the driver to unload.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/lpfc/lpfc_sli.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 8379fbbc60db..ef43847153ea 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -13493,6 +13493,9 @@ lpfc_wq_create(struct lpfc_hba *phba, struct lpfc_q=
ueue *wq,
 	case LPFC_Q_CREATE_VERSION_1:
 		bf_set(lpfc_mbx_wq_create_wqe_count, &wq_create->u.request_1,
 		       wq->entry_count);
+		bf_set(lpfc_mbox_hdr_version, &shdr->request,
+		       LPFC_Q_CREATE_VERSION_1);
+
 		switch (wq->entry_size) {
 		default:
 		case 64:
--=20
2.14.1
