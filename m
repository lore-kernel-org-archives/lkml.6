Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517683432-2-2935331244511892021
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683431; b=GedGXmaf/NGc6j8FP/mxq2m/MD+9Lr43NzqAqPuZLJjEQ6g
    BMLaa6fSQlSFMSpdZrAUvP75Kxde0+ZN1staQ6t6lK5ihN8Z6ETZl5ZG3CuU9MPT
    qQUTrRQ0Bcl9cw9lFfzMqJCgRyXqhg7IvG64onYceTLexh4hPRagNKFhZiH7qQVy
    oqMsISUX2b7PZWg5A06aToO87WaPATZbnEtWBfHdyyD/ONNuxd2gBomoy9+6bNvM
    jgTy77B/yJN5MQ176zQYoOtH4y6l8KlkbRSISwRdbGAAsQ5dvDA3/EYOLhqYbROa
    jtrR/l8gZRgTEiWraR6UcKXLtQPBODnOCSeaI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683431; bh=QXRNGV
    ++h/YKwaXzYF1LVBDgAtAwBoKBrWtOAy1LkdA=; b=dZCccXZPyw9vbJkgAIf3O7
    gGYoyTj0zoMO3+X3q7wiapfylLYSr6K9R+JbMLZ61JJNzwKn4A022E3M0yqQUgHs
    S1mUdbX1K1XgVZJYwzoF9itQOWDE1b/iDZVWh4QT74yOUaAgxUXo7STrarFKDAxW
    FNAAgkFnnCvLbL309k+2pJqCrz7+arGGexHq8hJ96mVL45dU8b5RQ8Cu5neraeYe
    H0BOA3P6BXIYipkEYS/6mu8bbpw/SeQR1vcrSsxdOIzeI+xzj52bvDseEm14OsRy
    OkwTgoRw+T70RtNO7U+14A1ZB0VV1Azek9nYUjTHhAVZ6G8vZ7r9zkg0wxwfrdXg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oUs8BDho x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oUs8BDho x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755215AbeBCSnp (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:43:45 -0500
Received: from mail-co1nam03on0092.outbound.protection.outlook.com ([104.47.40.92]:4928
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753176AbeBCSC5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:02:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bryan Tan <bryantan@vmware.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 050/110] RDMA/vmw_pvrdma: Call
 ib_umem_release on destroy QP path
Thread-Topic: [PATCH AUTOSEL for 4.14 050/110] RDMA/vmw_pvrdma: Call
 ib_umem_release on destroy QP path
Thread-Index: AQHTnRjuk6YgTj1zikyn1nBzTRHqww==
Date: Sat, 3 Feb 2018 18:00:52 +0000
Message-ID: <20180203180015.29073-50-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1092;7:LZIUlp5tEv5wf84DBQs3vxtvKRhnrJytVvdkXvv+j7DllpXjbGH7wRLtQXudPFrU3K7CgtTL0myuYV45R+OEk2D7H0HRDu6wrtsOtfhKzKGG+RnWRn+gF+J+FcVMJBUXd4FXZ4BtS5JSMHdMfpE/yNNh7/yL3KcVP+sFjox4vsYyl3frkdNHAmMPi1xd6UEFXzuDuibs44Vb3/XWwm2fyXK87d/Vo2fJLjsMzE5eQAqjZ7zP5wKdbAujHsz4ouSh
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49d17e2e-8381-4479-3b82-08d56b30253b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1092;
x-ms-traffictypediagnostic: BL0PR2101MB1092:
x-microsoft-antispam-prvs: <BL0PR2101MB10921CC485D267976F80C21AFBF80@BL0PR2101MB1092.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(61668805478150)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1092;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1092;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(3280700002)(14454004)(3660700001)(105586002)(3846002)(6666003)(22452003)(6116002)(99286004)(305945005)(7736002)(2950100002)(66066001)(478600001)(54906003)(110136005)(68736007)(316002)(86362001)(106356001)(186003)(26005)(6506007)(76176011)(6346003)(10090500001)(102836004)(6436002)(4326008)(8936002)(2501003)(53936002)(86612001)(2900100001)(6486002)(2906002)(6512007)(25786009)(97736004)(72206003)(1076002)(107886003)(36756003)(5660300001)(5250100002)(8676002)(81156014)(81166006)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1092;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: /zFVB71lWby4xXumEyr6R4FAgXjKCJP4ZYsF3CfcyBHoBw0J0Nl2qF29XTPuh9/jOTtPba6bN2Q9vpb82vVeDA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d17e2e-8381-4479-3b82-08d56b30253b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:52.4878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1092
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bryan Tan <bryantan@vmware.com>

[ Upstream commit 17748056ce123ee37fb7382bc698fc721e3c4a09 ]

The QP cleanup did not previously call ib_umem_release,
resulting in a user-triggerable kernel resource leak.

Fixes: 29c8d9eba550 ("IB: Add vmw_pvrdma driver")
Reviewed-by: Adit Ranadive <aditr@vmware.com>
Reviewed-by: Aditya Sarwade <asarwade@vmware.com>
Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Bryan Tan <bryantan@vmware.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infinib=
and/hw/vmw_pvrdma/pvrdma_qp.c
index ed34d5a581fa..d7162f2b7979 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
@@ -406,6 +406,13 @@ static void pvrdma_free_qp(struct pvrdma_qp *qp)
 	atomic_dec(&qp->refcnt);
 	wait_event(qp->wait, !atomic_read(&qp->refcnt));
=20
+	if (!qp->is_kernel) {
+		if (qp->rumem)
+			ib_umem_release(qp->rumem);
+		if (qp->sumem)
+			ib_umem_release(qp->sumem);
+	}
+
 	pvrdma_page_dir_cleanup(dev, &qp->pdir);
=20
 	kfree(qp);
--=20
2.11.0
