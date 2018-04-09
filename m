Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523240973-2-9965196899433246312
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
    1523240972; b=ZXwLCyFjj7KiiVORqBNmz0WJAXh/NfCHUdYibJAI/IAYeh18Au
    MI9a5I0r8/dj9h7nvOdgExzQSbt4pRWiN7sfLCNLlpgFL/uobXy0Q+zizClg1epB
    GROSXIMFv/ej/dfA8MXISTWdfRhb2+OK0ywqYyGlcFOaRjPRlCzXA4fEmBsm0P2I
    1RXBQgKrY9wD2/Ivul7cFtcLZxZqoQ27qWBBmdBLGxLTD38LpDkj3o3xs78hEv7Q
    mrQviwfjGwDL5HEaQZuG5+IB80Owe+YmsyOhGcd3opYbaDi78/8tzI+N82bJmbT+
    DyV9igg8bECh3DU9qoh0UoOnsyYevbNSVNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240972; bh=zsSgVKpeT/
    dy6fwxWOuZwP25S9y74kRVeGJwtcSBPL0=; b=NyL1bJWMTkbmsu/Sxi8mncUxvQ
    73bkh4U22VEryUN5FI5wF1hBiAHbigSSvj6SIqZuatUggV2hG7FbsEak6w5i1LxE
    ZnttH0VPKYR+7A7v4+6MPJcXK4tgb0iYQSDgl74eaxLO0P4xW8fno2YRsvO1Ov49
    rC+xHZgrdZudv3LiYFxGzWAOkyi8xXE35nkPkZF1MdDw7w+zpz3tBfBJNMNxEIhr
    fuwR6VIA0IBeZ0v8CHJOwFe9wpaKUe3GsyFE3FZD8sZlkFaBvpPA5WGwJs4fXgkM
    O5bgRRCrPYB1miCdt4l+Zd1I9TN3iiI2sFXvkNMD3IrED/GgD290u9KwP8Uw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YYNC0I8+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YYNC0I8+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPWdLfhXS92PvAslMtgcxkwQj70M5VdkVCEE3HqGb8eg0MVGokR/zK/4F3aAlpGoxaQwXDDWxCOXkXIInAf2//6T2okN+7YJZ59oWWbpu2zRxIdoEmXf
    Jme+l21afP1UjfXoI267NCd+lpQEVCREMEEtofIcHTULS7POY2bRWuXwxnJKYIg4fLDQmJ/RqSfUB3Emf2QGk89DcZTHFPtPiPshZ4pYygQVpY3xcVUkJcVv
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=t65mLZ0eXU-IP_uKplgA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756291AbeDIC27 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:28:59 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:12595
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754313AbeDIA2h (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 080/293] Revert "dm mirror: use all available
 legs on multiple failures"
Thread-Topic: [PATCH AUTOSEL for 4.9 080/293] Revert "dm mirror: use all
 available legs on multiple failures"
Thread-Index: AQHTz5kMD1+1agiVSUWdZLWCnwGFRw==
Date: Mon, 9 Apr 2018 00:23:56 +0000
Message-ID: <20180409002239.163177-80-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:ZOuuJEIkuf9hJrL9BdYAIrsczQGF6XEEWZhzqopOyC2ZJVw54aaBbpWm08eoS4J8+aj5dRYYc6bU54jwAgw8sWHb/RO5/rR1XaYQaZ0UPk48SU5c5/svscWae2TvtP3dqhSbpVpjsZ48jrOIOga3CZVWFzcLD9M4t1YCTmCA1OZSoZv7g0ho8ZsSIIpzyd0A2mmA9eLQoNWTQoHQejt/GDyq07OTYWNNMchRCh+CtiacfDSlJqDOlRJM1nmVciBc;20:XAP9uQUUWa4vlyARpn9eRXdivWofpWAig2OJBMHKEws4KxR8ytRTNe46UdiLBrbHT1/fmtWIR45RnahEaA9OF4guuZ+mz1XzURZoFRGPolYbHRsUQ+RBDsJzA6y0mYH88RQ/5IkhVyxHZDBnKNWh0ACVqttRA9t/gcC4Y+2OeXg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 781aecbc-8638-43ea-bb6b-08d59db0d272
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08071E8CD8AB32253FF03A75FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: WeQ2TIn0k6CzMQXftJOoyVI9d4k5vGw9fqT7zlhtIQTXO+zepCDO4fRqLDyaO2xKHBsC9lUZnU5UxnJ4+OnDzGk5HUzCT2gjHgjI1mMvPAiw5aagyu4VMcqObzRS17FqlwinkykEyUNuFM5PGkTHprwRrBYHi4C3yg2fOFO4k2a7i0WlSRazfP3ikBU7tGs/VyruisLwHvRXd8fbJVcntTzq4zqHtdh78WiDSznE0SdWjND/WUOFBWpxJbuk6L85IUDpVOM5pCh4MHNr8RSD7p07wXjflom8887/JkmAapUn6bWMnLVWKLUxWwk3FxmknaX9tyBh/sFlJ1bXAG6fozR/C76WmyglW7VzKDxTQzEScj62C/k89CmoQeu9iMcgnUd7styDQnQYLIqKtdcsz4lGWzOoPmSM+3gASrg6xNE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781aecbc-8638-43ea-bb6b-08d59db0d272
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:56.7531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mike Snitzer <snitzer@redhat.com>

[ Upstream commit cd15fb64ee56192760ad5c1e2ad97a65e735b18b ]

This reverts commit 12a7cf5ba6c776a2621d8972c7d42e8d3d959d20.

This commit apparently attempted to fix an issue that didn't really
exist, furthermore: this commit is the source of deadlocks and crashes
seen in multiple cases related to failing the primary mirror dev while
syncing.

Reported-by: Jonathan Brassow <jbrassow@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/dm-raid1.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index 9a8b71067c6e..7a6254d54baf 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -145,6 +145,7 @@ static void dispatch_bios(void *context, struct bio_lis=
t *bio_list)
=20
 struct dm_raid1_bio_record {
 	struct mirror *m;
+	/* if details->bi_bdev =3D=3D NULL, details were not saved */
 	struct dm_bio_details details;
 	region_t write_region;
 };
@@ -1199,6 +1200,8 @@ static int mirror_map(struct dm_target *ti, struct bi=
o *bio)
 	struct dm_raid1_bio_record *bio_record =3D
 	  dm_per_bio_data(bio, sizeof(struct dm_raid1_bio_record));
=20
+	bio_record->details.bi_bdev =3D NULL;
+
 	if (rw =3D=3D WRITE) {
 		/* Save region for mirror_end_io() handler */
 		bio_record->write_region =3D dm_rh_bio_to_region(ms->rh, bio);
@@ -1257,12 +1260,22 @@ static int mirror_end_io(struct dm_target *ti, stru=
ct bio *bio, int error)
 	}
=20
 	if (error =3D=3D -EOPNOTSUPP)
-		return error;
+		goto out;
=20
 	if ((error =3D=3D -EWOULDBLOCK) && (bio->bi_opf & REQ_RAHEAD))
-		return error;
+		goto out;
=20
 	if (unlikely(error)) {
+		if (!bio_record->details.bi_bdev) {
+			/*
+			 * There wasn't enough memory to record necessary
+			 * information for a retry or there was no other
+			 * mirror in-sync.
+			 */
+			DMERR_LIMIT("Mirror read failed.");
+			return -EIO;
+		}
+
 		m =3D bio_record->m;
=20
 		DMERR("Mirror read failed from %s. Trying alternative device.",
@@ -1278,6 +1291,7 @@ static int mirror_end_io(struct dm_target *ti, struct=
 bio *bio, int error)
 			bd =3D &bio_record->details;
=20
 			dm_bio_restore(bd, bio);
+			bio_record->details.bi_bdev =3D NULL;
 			bio->bi_error =3D 0;
=20
 			queue_bio(ms, bio, rw);
@@ -1286,6 +1300,9 @@ static int mirror_end_io(struct dm_target *ti, struct=
 bio *bio, int error)
 		DMERR("All replicated volumes dead, failing I/O");
 	}
=20
+out:
+	bio_record->details.bi_bdev =3D NULL;
+
 	return error;
 }
=20
--=20
2.15.1
