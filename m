Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233077-2-10064906674464282551
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
    1523233076; b=eu7OOyLcORUixJzMzE0byvjmu1tkSOj7dZyAkXutjCLbSfc00T
    InPwQhWa4Dw0K2R9WScGa3CcE1QsZ6jsGOJUO9EmyaECuSS3t2aVgbjEYPxiq0AU
    n42Q8T5YY3FOC8RnhU3S5r3zJII/BXzM6EFFRG+eLbDwqvcObCVqZJb2LNCokwGA
    oxM1WIa8+veJqAH5KgSHCX2xtArESGo4S+5gyxZdtoMUetvs23jFNwHuWkghJ5XO
    4C10r4gcXrS/EJ+OFUYk41S9jGxakOOFunWXXofToRsPYX3RaNAJ2gPDSLsgt624
    D7he6m+nacs5+UUWy2kOARYC9i/XOn/ktIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233076; bh=U/dC7VwxQs
    IaWUlqFUHHB+mY1ZHCsPToS6ybAk0ERt4=; b=HpJbwBSVU0to7QoDeXTN9qc4ui
    Khrzs16dM15URREZkwmCJUjntxOEBhtuL6wrWt5uY+vZ0YLJlFCDe5g5vDeuXBGe
    fsEpj/Sj+6JvV53O7JP4oLk5TEmGkzkiNewqmCUAi3A9ifgVcqBkGKHc/1WcHtRT
    5HH1q8zf4T2YuSjOL+plASX7Xm1ZgXAAT09aaLFHzWNWrXjKjBWL4iA6L4iD1otp
    hKyXKRkK/iye3FC31bWz4YIhfQXliJgGChSIJBFMlh4tggwX4/p02zUsQjVY2GNy
    qx/Q2jlHpE/bADIjv/S+Tx2iPWRCyv0LFiO2EMjdLEht+Gd4to9zxojpViOg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jHcMZuEB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jHcMZuEB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIddMv+xLkZBmat0Kzs35NaPkubqjYoncif11LKxnaf1m+RWm5agCeTNkkpeWjdBBozQ33rv7qkoZaaXn4uo1j4laHBdHkFRV2IVRZuTE5xgorChTpjd
    rX1MNkLD8FB3oCF1/pE2PnsVfzqrN865UBJm+r1CLRPeC1ILO7nIMm1xAmWwT8ILigLLgBMPP1mdQLCxOyzqeDLcw4+mzlYt66tz5QZWvVATjT1N9djPbHM7
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=O0o0-iZq6OI_uB100M8A:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753254AbeDIARw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:17:52 -0400
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:51875
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753214AbeDIARu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ming Lei <ming.lei@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 037/189] dm mpath: return DM_MAPIO_REQUEUE on
 blk-mq rq allocation failure
Thread-Topic: [PATCH AUTOSEL for 4.15 037/189] dm mpath: return
 DM_MAPIO_REQUEUE on blk-mq rq allocation failure
Thread-Index: AQHTz5gdzpIHyS8FGUiNk6hfOHmWDQ==
Date: Mon, 9 Apr 2018 00:17:15 +0000
Message-ID: <20180409001637.162453-37-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:1AuiRWL/iayaC2bxA6N/JqpsbU4pC795ZmOjUd6L/hvAjAegeVw0LKAivFznyJQ5j8hnLmUA8W6tx2RMr/Qj+bBF9n2UFEDE8OZQHAPRH2RnrSWEknj13pEUAS8glQvqPkIeoG/Rj8PuWXXdVgO9m0KG13VWSFGi/X0n3hs4JO9ev7PaLVyq0QbSOWoKs7mkIpFM41ulH5S6Xv0Ur5wszODuHGP/dYq5DOnhjBal4DRUtyR7prbNTD/xjmB9t2vK;20:nTzZeDYBH9s8Zt5NM/odm4JGk2bPlvpnlDtxhrtfeHP3Sa2iS7WPhq93lrfGwiyzZMnUdv5PPZk8gH0JW9CiffnVMlwrKJhDIax1cGx9aEJB9aC2+A3I62X59eFG3YqiOzvu9APeXBKrYaCs5qF4SNKgdHEAFZsylifyPGuKdKk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a1a21865-ffd9-4c12-c1d2-08d59daf50da
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1048BEC375FEC289247D5A60FBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(86362001)(1076002)(99286004)(6116002)(110136005)(3846002)(54906003)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(59450400001)(86612001)(25786009)(2900100001)(14454004)(97736004)(53936002)(107886003)(68736007)(102836004)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 8mrZZC0+y/5V1exkh/lgkWn9ZqrbvU56OggSNSVK/2p++32xqQB5CIjqJKaEoaN6SPuUzryXJ9O1Ph00ZzgDChFdkqSd4DW5dvBWgr1GlfsNg561bEP5gmWBAFEFzfpCLX2PT78qKcUUfGe6ooKyxqoi3Rlg1rXwUxX4+CltfSYzcR/pYGItuklESDf9KFd+TrVWGXwsR6dpZCn1hAyTLnpGXyo2HfQ5QKIONJMArAvvHL104qYuDKurA83KktroqIcgdU8VGmii+zA+8Yk0kbYP9m5fqgkomjHeU5QPU2NhpmqcrCUxEhFrxaZEMK8Q3am3NbJrnH1SwreiQ21LDoeg2eL36h0LeYdqDSdqdWWSkSBZ74gz2lsBF4bzMAcnb9uS6v5epZxCczoErAeN0c4Ad1DAI9XpYTJnNNaIkP4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a21865-ffd9-4c12-c1d2-08d59daf50da
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:15.4641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 050af08ffb1b62af69196d61c22a0755f9a3cdbd ]

blk-mq will rerun queue via RESTART or dispatch wake after one request
is completed, so not necessary to wait random time for requeuing, we
should trust blk-mq to do it.

More importantly, we need to return BLK_STS_RESOURCE to blk-mq so that
dequeuing from the I/O scheduler can be stopped, this results in
improved I/O merging.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/dm-mpath.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index 025e033ecb78..a3223c8fbaac 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -534,8 +534,20 @@ static int multipath_clone_and_map(struct dm_target *t=
i, struct request *rq,
 		if (queue_dying) {
 			atomic_inc(&m->pg_init_in_progress);
 			activate_or_offline_path(pgpath);
+			return DM_MAPIO_DELAY_REQUEUE;
 		}
-		return DM_MAPIO_DELAY_REQUEUE;
+
+		/*
+		 * blk-mq's SCHED_RESTART can cover this requeue, so we
+		 * needn't deal with it by DELAY_REQUEUE. More importantly,
+		 * we have to return DM_MAPIO_REQUEUE so that blk-mq can
+		 * get the queue busy feedback (via BLK_STS_RESOURCE),
+		 * otherwise I/O merging can suffer.
+		 */
+		if (q->mq_ops)
+			return DM_MAPIO_REQUEUE;
+		else
+			return DM_MAPIO_DELAY_REQUEUE;
 	}
 	clone->bio =3D clone->biotail =3D NULL;
 	clone->rq_disk =3D bdev->bd_disk;
--=20
2.15.1
