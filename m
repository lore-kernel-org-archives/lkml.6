Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485820-2-10819251119998236473
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
    t=1520485819; b=rQFcGho7m3diXjXIDLzS65pUob7b7Hwt+T3zhFkMreyaSc9
    QZgXbwmEDJo0euwvqhr05XKCS/vJrhWS64lXolrqrB818r+VW9wxYF35TPxurFAW
    EMzmKJGwl3TmwjLLWsFbgJRU5cxemqCnrifl+BNiGqVc1j8FotbfeBCR3R/jpDy+
    GmZj+JA41yj2sNHNKQXK55jo4DsqqN1JEIeEwkQYVSgGSLlzNtrRvTeaO1XPtF7a
    lahhpmQgWqmXGX8OhEqcZ6ZvBZa7CtlhEeXXNJJ/4RnNmvD37GgWc0oC/oDY8mKv
    BmHu+81Te/MjXGni+zv3UnsOmgyZBB4zBHIQNhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485819; bh=TodFyK
    ODGyyE4ogc3hBO+M2Qm2bDXTQu2UVM2RPgbWw=; b=L2YbJX4WXa6L8HdFRII+5j
    Bz0lzVMlUVzrlHQa3zTbS/AsWqGL1w4fdzmRKhWomuKmzRvFbxjKq1rxNR5aC50u
    Tv+IwldcRYER1UK4bfhq3Z9Ct9GpeZ5xg0Pf2QruRaIGzEShIe2DH7ubvtbi2hBl
    J9uMH1zcSkqaRhbHTf2Gtmzbd2YymejiC9iTHJbvJpO7yWVFGCyB3o6pine0MVN/
    Koqjvxa4LLbG4yeEuCYBsUIrzzZStYvqR0koey/+X4XolsbZLCarlO/0XMsHxNyn
    aHWn40CgXXppTBId1CC+VOpu31Rj2z5QRW7z6pZS7ubaXXLCbudmTbvaa15hHRKw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LihYFimu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LihYFimu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755363AbeCHFJE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:09:04 -0500
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:61856
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966829AbeCHFJB (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:09:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 26/53] Fix driver usage of 128B WQEs when
 WQ_CREATE is V1.
Thread-Topic: [PATCH AUTOSEL for 3.18 26/53] Fix driver usage of 128B WQEs
 when WQ_CREATE is V1.
Thread-Index: AQHTtprFtsTBITCvWE6l2y494F9WTA==
Date: Thu, 8 Mar 2018 05:03:18 +0000
Message-ID: <20180308050230.8876-26-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:AI+RChpAiDjI7OpS3BuPvXSaf/wAU2LjpseQn/MPLllcD/A0YQgd0zhyWe7pkIlIdCYkInCwE4mDwhpq9j8WtQNQXdMdI4jQ1KegSX+FLw0M/+q3DNMGe698vpzXbZXUdkzBtbAInxjWlMdluAwMJtrza/4m7fUVTuuCTxPvSr8zcG4EAyAuJcJDn57y3Rvj31gXerjD1XeJGRILAZWL1ZdmLe9FVNqoOd3E8nwgVES9Ui5wwrnSS1BUcuAYBJIn;20:2RLjw4h0m9X+RaBHQICkw8IYSJs4/3IpxWJ+3RF9QFoVoIVhgvKGgN4vWdYr9W+6U8pGXM7PxRt34m2egwzRr2ezEkDnNOJqzyDhyVkQkSvhbt6l+m6YDCuwKf5qHPvhmOuZlbhrRnVxyyCdYzSi30q+lwvfGLU78X1iEto+YYY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c96f8d89-0dc8-4a99-ae24-08d584b2b286
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1030C63CE39BF260D9DD7428FBDF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(5250100002)(316002)(39060400002)(6666003)(6506007)(2950100002)(26005)(76176011)(68736007)(53936002)(6512007)(59450400001)(2900100001)(86612001)(3660700001)(106356001)(10090500001)(99286004)(2501003)(4326008)(14454004)(102836004)(25786009)(97736004)(6486002)(86362001)(36756003)(7736002)(6116002)(2906002)(478600001)(6436002)(107886003)(72206003)(186003)(3846002)(66066001)(81156014)(10290500003)(1076002)(22452003)(305945005)(110136005)(81166006)(105586002)(3280700002)(54906003)(8936002)(5660300001)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 2Ms4PKKa+JR6zsX0I1FF+C0kAISXNRf3KAvG8dpLmY17kSWbViUlOGTTQTCnimQdse4PxpBYm0OP9mKKFGWSxAo/25XE1QWJAxPuisR6MwvzLIjA0dNLnYMBqvNYLGHKTH5TEBKkK4KLHH4eWwneEJidOZsnlB2qAKBkoFoGfNOlKHPzXrhaPkw4YYmthth+M1Vq3FrqrXJDY6F3OXEg+qkpOtxRuC7THe3XbbIEjh4DlL5zSgzgxGOXbgbz5GyRWkTctKzsiw3qGAe3lJ8TB/ir+fcQVga+p1F/Z2S5DwqdIkn5t+kFTJ9e1vL+tky5D6JlIV0neDD6+s1HyftNww==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96f8d89-0dc8-4a99-ae24-08d584b2b286
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:18.3371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
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
index fb7dc27a2e1c..c3cdb9f72bd8 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -13469,6 +13469,9 @@ lpfc_wq_create(struct lpfc_hba *phba, struct lpfc_q=
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
