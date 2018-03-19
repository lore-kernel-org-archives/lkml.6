Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521493212-2-2221010488253662621
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
    t=1521493212; b=C/5OqtroXH+/9g6ijUEeEm/dMmcSZksTctcaa8xzsxWRHYS
    X73Emz/KWQLs6CwRoNnWPBZSnxlO1SoFmzMHteb2b6SGYs0ndJtE48yQEbHNf4OV
    qKna6DdL6DWgcmmoTNDu9gz4+hKIzOdKmH7odC+2HTafAqytRAVtiObf0AGO4G9n
    BHwYmNj4a2ZfC0qRR3tYrPBD7QW9HN7ujNyx9GayMWum4Wzd/VFPBQrUbCCGCgjR
    7g1p3ALsyugs9HvQG7Y2aYGLiWwnoUTtYbxn2T8Mbya9yXWu8Y4CMbLREJaRHcuu
    UAJkqCGAWpEEVE2G8/94Ua2x7Q2mZ5xXgYbde1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493212; bh=W4DYLr
    UcIsIvyUuktkA6kClFOgYKdn+T8KRxWhaLFxU=; b=XSAEL+W6TaRjf77i3z3nAD
    sTBlvdXR5uZXl13VMBnQfk5/XswelLmIzcJ4g8jZCu2DJUi0nDi/A28yfv9EVsrk
    ThGIe6xpVZ56XGzJ7KK1g0kKlBQ0B5juU35oNKi22xXKPxnIcgDN5IMCbVGhoNmO
    +lUYNd8bC39ACnwXLRR5u3PB2NVHKkriQesUKYpXMUCNDV38EW2XN8ItFYz2RiKx
    2lxSq9R36zvLeKn+9UQWFI9OUa/0+HlQwQH77mr/exF95U47BZl8a5gLeDB17D0d
    rNExfHqoCklQTJpS24jINwHNUl6dkCPgfuMRT5JIBrvGhQgGZ4OS04Dmh2KXvYtQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=If5VtwfP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdegleenucevlhhushhtvghrufhiiigvpeduje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=If5VtwfP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdegleenucevlhhushhtvghrufhiiigvpeduje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030516AbeCSU7l (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 16:59:41 -0400
Received: from mail-cys01nam02on0122.outbound.protection.outlook.com ([104.47.37.122]:7795
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934988AbeCSQDB (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:01 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bill Kuzeja <William.Kuzeja@stratus.com>,
        Bill Kuzeja <william.kuzeja@stratus.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 170/281] scsi: qla2xxx: Fix extraneous ref on
 sp's after adapter break
Thread-Topic: [PATCH AUTOSEL for 4.9 170/281] scsi: qla2xxx: Fix extraneous
 ref on sp's after adapter break
Thread-Index: AQHTv5uCDsXLrE4eVE6cC4DcEXWeOw==
Date: Mon, 19 Mar 2018 16:01:15 +0000
Message-ID: <20180319155742.13731-170-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:7lAF215J/UPO9GAOttbs5T0WSKNKd+PJBNzPXdxLDFK7vhovo7whIYbLPVnAADvfqi1GMQFTPeVMD5/rmac1rwDQXjj2rfF2/Vu7VxlOTLTBhLcAwPquZa4Ys65YPyqPfbaq9l+XxI4kthn5c37MefRaZ+Vzfps/iEd6k75n1+AxG0Psq0DHLvkknVMbJtWZRb58V5EUF3TUbloYSSP3A+qSZETgK5YRTPUh6xd8djVj6GQcOVhQsZptrmaoOytq;20:CkN2m14ZUsyhW9Cro7+2Yx44fy5w4W3ekxSMTnEf3ednZ/gUf+y+hH7jgXXRZKqIqekS6bgOtvsJgyHEtHIKk0AWPvknHvBeU6nroZszDk6wAJESWOTcWqVyBTMSLBUiFbjdzh9xHaSmAb3rxPb3AznWO5+9IYoF8vfWYSXeSp4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 538ce52f-b8fd-4a69-774d-08d58db2e145
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725646870D654FE82FDCA7AFBD40@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(366004)(39380400002)(199004)(189003)(2900100001)(4326008)(8656006)(54906003)(10090500001)(81166006)(316002)(2906002)(14454004)(110136005)(107886003)(6506007)(186003)(81156014)(22452003)(68736007)(53936002)(59450400001)(3660700001)(478600001)(5250100002)(2501003)(99286004)(36756003)(105586002)(6116002)(3846002)(5660300001)(72206003)(1076002)(2950100002)(6666003)(305945005)(6436002)(86612001)(66066001)(10290500003)(76176011)(97736004)(8676002)(7736002)(8936002)(6512007)(102836004)(106356001)(3280700002)(6486002)(86362001)(25786009)(575784001)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: YSPVEbOj9B/zKFI4HDVE9eQ1DV1sor2XzEOwXaniriFSy6bYHRiePk1xuwcDl93hmyO1Zzu947M8Q8NpTojo+liit0EN2rwKCd2CoAuNcUKUYYuzmsrffBb6XbRogrkeqwlKxMOY7fJLHYCGJglKzBNU3c1SRBsEzKtCf20Us1EUR9pTuq+aBom9hwhcqHhwljUEszn5M1GIK1VbRPoFaG4IxEfGFHUBmKQeCPw7QAjFPD2Am32ibHuB4ZQYcQpgkMlL0KBPj7HOsdeNjxSSolu+Ol3G7nB6WXTdrGwT2hBQyMI/8GHdA0CUBLnWm00yzlwWjsngpCvdnpPWX79l6g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538ce52f-b8fd-4a69-774d-08d58db2e145
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:15.0315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bill Kuzeja <William.Kuzeja@stratus.com>

[ Upstream commit 4cd3b6ebff8510b2139d64024411207090cfe0a9 ]

Hung task timeouts can result if a qlogic board breaks unexpectedly
while running I/O. These tasks become hung because command srb reference
counts are not going to zero, hence the affected srbs and commands do
not get freed. This fix accounts for this extra reference in the srbs in
the case of a board failure.

Fixes: a465537ad1a4 ("qla2xxx: Disable the adapter and skip error recovery =
in case of register disconnect")
Signed-off-by: Bill Kuzeja <william.kuzeja@stratus.com>
Acked-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 94630d4738e6..baccd116f864 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1443,7 +1443,7 @@ qla2x00_loop_reset(scsi_qla_host_t *vha)
 void
 qla2x00_abort_all_cmds(scsi_qla_host_t *vha, int res)
 {
-	int que, cnt;
+	int que, cnt, status;
 	unsigned long flags;
 	srb_t *sp;
 	struct qla_hw_data *ha =3D vha->hw;
@@ -1473,8 +1473,12 @@ qla2x00_abort_all_cmds(scsi_qla_host_t *vha, int res=
)
 					 */
 					sp_get(sp);
 					spin_unlock_irqrestore(&ha->hardware_lock, flags);
-					qla2xxx_eh_abort(GET_CMD_SP(sp));
+					status =3D qla2xxx_eh_abort(GET_CMD_SP(sp));
 					spin_lock_irqsave(&ha->hardware_lock, flags);
+					/* Get rid of extra reference if immediate exit
+					 * from ql2xxx_eh_abort */
+					if (status =3D=3D FAILED && (qla2x00_isp_reg_stat(ha)))
+						atomic_dec(&sp->ref_count);
 				}
 				req->outstanding_cmds[cnt] =3D NULL;
 				sp->done(vha, sp, res);
--=20
2.14.1
