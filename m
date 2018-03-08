Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489744-2-11679603888545182702
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
    t=1520489744; b=JlBHxSfKuaURwnVm3zrhWsMM9eNZrhn8Q3tk0amQjmNCZ0v
    wSHHIzxDCYnJ3wxBR+GhuF96QDfXnX05yXmiOutoSCGqxO1YTu3qlgNq+z8Pbzym
    8q8zmrEEnwvNrtKyIsBC7dCmNmlYzJZTPSiDjxM3wdQld7xXABrpuuamrrv6ENVm
    sd7mOnak9rBQCIaLmqB4nyPVT7klCKSKlLLIEBa6DMi9bhI/irgq7p4t5RvHL5QT
    rjZ8YuOiRBOV7w9E7mErGUA0RtVJ27T/BxCb+rASDmlA/I2g0IB3SnJm6jYvTFri
    ADdfX1C8+ymQ70qU6CLjH289lZESPm4VEfe/BKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489744; bh=dpft0W
    1QlSyVU/gD4jtEAkk6uXH0YoBmxzfMHQsDkNc=; b=SKqiPMPXwOEAg1srldw/nk
    8+CHSxV41VmzbXMBn8c/8W5L1ibGMVPDOfgCgKXrmZmDbnOLBEbm72pwH48bjIU/
    4grw3CzeV5kvDPsqI9SgCYVFAQ9cf/82mfAVD3GiSjdYFpohmqQLVNM1225yE40g
    GlnXStyohNJVgThxqR1kqsOmLLfxmN/gLxlt3KINrqZgrknPZgwtDY+MoNSFNuNl
    N8jNvQ53jq8HehOZXIGjK++oty/m342vCcVNzMl7oegU2jmylBxqiDlnDrIe134f
    8WLrlgXzB8yInkDlKaCGLAFRkG7MJKfDfyFEDoS0t6zKR/gCKY2vD6eBshy6o4hQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Tf/zFhDZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Tf/zFhDZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965812AbeCHGPP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:15:15 -0500
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:20160
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755352AbeCHFB3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:29 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 072/190] Fix driver usage of 128B WQEs when
 WQ_CREATE is V1.
Thread-Topic: [PATCH AUTOSEL for 4.9 072/190] Fix driver usage of 128B WQEs
 when WQ_CREATE is V1.
Thread-Index: AQHTtpo5WqByAeQrS0uPnJst0mSE+g==
Date: Thu, 8 Mar 2018 04:59:23 +0000
Message-ID: <20180308045810.8041-72-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:O2BEHoKEU/3PDwnHeSRrRn9f2i7wbBx71rouHxfEaD8h/pXUxAcF9PlPK3yf5oGpEWJZWoCEOBMJBqjUYF5sqPeHgnb3GAVUwVtl+j53tty1e/LNkXPJ5i9fxI15rlf2jIMUSiNAtGxJ4IdivoNeM7FtIUc69krTUfVvSymAxvOkMztnbcJV+VjSH16nHkBYrxOcKPbADzDm9rhMNy5+zsOAKKMRROcGS+wccv1iz7QGQoxSRW+cREIlDithpj7e;20:hi90e0hASxKh6nMYGDn6d/c2TUMnf0vtFV3JdHpX5qcIPcmRxsHYNWSDlbMjuVD7rsE8zNDpn3qOpkPmrqC8oFdLUR4L+NfPmt4fhf3oz4nVx5tHof4StGAgW7Hn2sivL6CRhjspz4mIzSl/vnhm7cbX/Ryja3ZITK7uL9W28e8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d4c6c31-2baf-4b1c-d923-08d584b1a47f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0901DF4DC5F21BDE7AD7B75FFBDF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(346002)(396003)(189003)(199004)(2501003)(5250100002)(99286004)(10290500003)(53936002)(14454004)(72206003)(76176011)(97736004)(6512007)(106356001)(86362001)(10090500001)(7736002)(6436002)(8936002)(6486002)(36756003)(110136005)(305945005)(54906003)(81166006)(105586002)(59450400001)(2900100001)(66066001)(6116002)(22452003)(3846002)(1076002)(478600001)(3660700001)(102836004)(81156014)(39060400002)(6506007)(107886003)(8676002)(25786009)(68736007)(4326008)(3280700002)(2906002)(86612001)(2950100002)(26005)(316002)(5660300001)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: FxzIzgyjeJ1ULmlhFOFQvyzCxk/PadjG78lVvPPb1zc+rQ0TNgS07Yd5jWXKRJonsG3UxQL1AML27NhCwduC27EAmCIr1m0rKqjbAmXteqJzXJu3AEhFUszF294DsTyXZlNFl9Hw6gZHUd5YcWyrFWFB1vJnkfDl0iVtOKYEMyPfcUVlRuyq19zIVduER/0F1WgfKS7tNwQ7v/NblENbAeZSTVAuwLDuXtxZIvHtBZv2bYTTxGNAljBYo3XwMlXzb6WVTt7PbJ+wFKmKzdH//2q2Y06JAK3IkgwssqK/VeY5Lge6U5+CKiu/hdZhspTDn/rwYvToeQMLZkHczB/l0w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4c6c31-2baf-4b1c-d923-08d584b1a47f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:23.6426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
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
index 8f1df76a77b6..0902ed204ba8 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -13696,6 +13696,9 @@ lpfc_wq_create(struct lpfc_hba *phba, struct lpfc_q=
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
