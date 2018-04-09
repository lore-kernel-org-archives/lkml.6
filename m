Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244098-2-2497919579162051960
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
    1523244098; b=q2hmZw6wparM6lxjfGWrj9GaJHreq5nuBuWdzr0Ut+zUansYHY
    QbRdExCohPWR/fREjBy14eNWqTFUT5/CBLaz2rvaUd17cRC4d1Mdp+bIVcPQP2+r
    K3u3jurH46wX1OLAIRfMcFDzp758nNL2GBNxtpr8Z5mrIxMIZpqxt+wDcs5xTvoc
    xquOIR3mHMtBEJWgPAV7Z43jPpmqSA+LrovUta8UL1/SPzUZ0rRX+Pqh6/D3pZO7
    KtErcQ+q8eaRUz18wliZiznZyfYXMhoq6bAXze922BSF8wF7ePQz5Qe5p3CAh0Bb
    WVOFnH5Aymi2mvtBQiCm72qYkU8wc+tSjQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244098; bh=yEtiVDME/0
    l2wI5PzWjxaXuYgQNkzzr7qL0upqy4JzU=; b=wL+syfxwVvdGO0nbjfx704EHcY
    JMicsqG/E+hxBReRmsa9uVZpVcDEo+AlnCSz/8Rc3l/jp9+E/d7l8CoanewJ2cPA
    N72Ogg3ua8cnQJ5h+1E0AMsD4c64S4Earg3EgyC7tYQXarv1PKa9UKDshFzVU1/H
    f/pOsZumx/GKfPu81a0a90iiIEkFlxHtI8Y3nZOelJ5u/XJXe0UGN0xCrkagBCo1
    sVgxNyQqLkjvb4+FLa4tggA52SMfjx/P6ZMpQhzmucMIHpFZEUUePNtmSgNRo2wr
    EVrRNAFaKCAQQhzI/d9m9tfLsO8b/bL51c6FoTCvxDmzRTBxPYPwRWKkNbMQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c8mCqUA8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c8mCqUA8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM0QC8tNyJG7rWZhSvPh+rUeX6pRj+a9HuJzL2xrNKfHmOTdKlZOSjoQI0peYvTGkrHljJwwQSZfRwfr+mId6IlDDgHo0u3WWgJhXrd8Yf208m784cwX
    jFfZGY5lizS/yTIwIa8p2OsuI/2T50CPh+ML6fHemBpLZF4XfJno2N2EgqC51xD32Vcx9q3T3KJo2ww4OTLuOOnT5hJHfgfLo954YbcmN0o+Im4mJKTfeF8n
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=O0o0-iZq6OI_uB100M8A:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754761AbeDIAW4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:22:56 -0400
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:20813
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754734AbeDIAWu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ming Lei <ming.lei@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 033/161] dm mpath: return DM_MAPIO_REQUEUE on
 blk-mq rq allocation failure
Thread-Topic: [PATCH AUTOSEL for 4.14 033/161] dm mpath: return
 DM_MAPIO_REQUEUE on blk-mq rq allocation failure
Thread-Index: AQHTz5iFt6UhgfPJA0KObtb923wp6w==
Date: Mon, 9 Apr 2018 00:20:10 +0000
Message-ID: <20180409001936.162706-33-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:YKSTzF1pmC6MjbmhQk5smF0WESIQy/hVZidzrfWDIIAicVpkW1gbfwnt3SIukpUx+Ux0DYmuzTd6yi7anRgC5QKcWk5OgHWLsfzXtmaNog5lIKSHi91iGZniBaR2Ardr+p7nDusiABtozNWKIJ0gtq9PxahIwOhgxeiS5vt1/EArwlkof7K0Y0hhWJwN2AOF79ZHhPP3sA+a05Xw+DPaLPS/F/4mGd/XFlaRtZnPHxquayGbeyDE5Yzkd6Mf5A0X;20:fEhkAO2ikS0hZ9GsHGesIIsw/Vmr3ubFeKs4krGJ2pi8+msDFgrx22p+rbRnIPoazJbxuxMAQ63TeMdHS/HYphggBKzOy5Yx/j6shXpsMfkxjLy6A1DhdVPzQhCB068IU63RQZPiPw4sh+hUAfiATOnsDnvP0I4UeEv+ylzuiN4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 99f9117c-1362-40a0-ad62-08d59db00428
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09669320A5C982F2CD86F237FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(199004)(189003)(6512007)(316002)(59450400001)(6436002)(186003)(6666003)(2900100001)(8936002)(486006)(6486002)(6506007)(10290500003)(81166006)(22452003)(25786009)(1076002)(81156014)(53936002)(106356001)(10090500001)(5250100002)(107886003)(102836004)(76176011)(8676002)(66066001)(2501003)(446003)(476003)(36756003)(99286004)(478600001)(86362001)(72206003)(2616005)(68736007)(5660300001)(305945005)(3846002)(6116002)(26005)(86612001)(14454004)(97736004)(3660700001)(4326008)(2906002)(110136005)(54906003)(3280700002)(105586002)(7736002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 1zlQG1GifkVOAKz8D6oWClwgSd6BkI5QqFrSOeDXoqeElf+f+p4PB372+BoyrxmQQaMhDiCVxtN/9t1bmALEtMSCU/sU3E9Q/OIDAqFT6yu8dgqNctThMmrmhP/NweY1LLCYL1+f30s4uKftDV36+5hfJJO767ooCzXHYih92lhypO5YjcsxhWsIxKu6mqApkOIV02UmihVeTvTmZzMI8n/jRkaTqnAlHubDb0qVWnloD4ltg4w6AGcC/6OH4A6ifgQZMr59XtrBTg605bvTI+WKjCRyUneK0quHNAUW7zDi9F2Op3aGbKQGVccYZHoc98HLN0fxyah3cwgBD/zq7PsuUGgeA9fdvJvPCk43uDT3iFkdfVR/cbfjqdYGqditKRdBbOb8DYkPkmy0sZGar41kwYPj1DuWN+AH0wCT+Vs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f9117c-1362-40a0-ad62-08d59db00428
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:10.2228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
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
index 2704a55f8b6e..8b7328666eaa 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -502,8 +502,20 @@ static int multipath_clone_and_map(struct dm_target *t=
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
