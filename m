Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236412-2-14186796325787488777
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
    1523236411; b=WTOlw/MmDpsMqbeP/7EMUSXngPX0YTc/y7lx6A2mwQrvHIah7d
    mRLTrrI/63+5wEf6BX6oxvlhaPii9XIq1KTZ8kIudmErMZdcfKe9SQKymknAiR7/
    SevCiic/utykXvd+85xgKF1uLRjVIraYhnP5mn1ZFder6yJJGpbYgeHC3523jiPE
    Ip5ZGDdU3UYAkJrsYK3+Yy7l/XBewzLVZ1uz2hFGXCwAlRkZiRd9TiRCK2W6jQCA
    w69cpo+hbbje3Rww4lcZo+XqpaFHS60FjdOe+8HtaorzrrM2sfKW93Jiw2gFOh+l
    9+ab9EDKrcw/WhABCsXd5IO8nFdBLNNTHdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236411; bh=bnRAdoNymZ
    1LH7wpBQOfrqZ7TSCpQyT/FmMDHZAA4lw=; b=jbSOj87wClsgDaSBJJcdDhhZTD
    69PzzuZzVl4QIPylIGGw47Y9Ml0Ywk5zGbJHwKLtUFwJI62Nv8IRzKh2ZMuIAmqH
    VuO8IsexFvvlph/hbkGND9ygEE9J4lSJh/6eVCVYU69vjYXfRSfedcgEbmBf50jv
    Wj6HcNuQFILFTkOSxHjC6F1jkije4JTZEtIXWxNdkFWcY8qsv0yeL2AHbFpssEB5
    aPPZUY00SOb5anmBWo2xyPvc3eUUGoB+4vMzJYFup6AKtroBmmejFSleBnRbYzlJ
    Jm5RP1Q4DGfDlUswoNbjNUp3eeEt7YXU2i+eXB+nvRynU/NqGNjR11s7MEyQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U8PVV7QY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U8PVV7QY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPOm3yMm4lFEUS2D0WF1c6x8fOAapPM0bYrdWW0SBVbf3Tvh2e7bJrVcAZst8LiuzoxSddaro234yLzsvxoz8zYt8JJt0mCqTo1Dz5tfVO/51c79iWXK
    VTFlisrrZofn0iQ5yZul1ZFgO314FZL7FBP7aEv16QN7+4thDT11dqfOgNQ574n28+0X2x3R7O/CEn+Gm4gM2ZKQOTcI+5Kv4Jg+3pAN0fMhCMAjGJQByPeL
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8
    a=Tqf2YcDcvnV-e9xK7_kA:9 a=2G-oqGg-JSECXvxw:21 a=prCzMAxulp7vZNzx:21
    a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932806AbeDIBNZ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:13:25 -0400
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:26752
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755524AbeDIAig (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 125/162] Btrfs: set plug for fsync
Thread-Topic: [PATCH AUTOSEL for 4.4 125/162] Btrfs: set plug for fsync
Thread-Index: AQHTz5nO3QYAbJxCwkmPwWuv6rmAfQ==
Date: Mon, 9 Apr 2018 00:29:22 +0000
Message-ID: <20180409002738.163941-125-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:vbfyFmfb9qGtsUQbTe80a+95bazQMXYum5NmHmLa6zQVAp/SrdccfrIAvxae5E3eeH6NJ/pmmLqX0LlKH96bY+nXQ8Fn0HFd6wbUtUU47+MYN+4Y/m8WQS1suzz5k4zSrhVV2enOLLIJG8CLNPWibxhnaudS+6hKGe7XngXosHGQRVqwslIuCGKc43H1KKFXmbmoW8xcRABU/GIAWpAhWQv+WkUyzV+0WQkZVNOwZobnN7yd5MItn+xlAYo+ps/C;20:XWWQU0ZX+yunr4+wMwUSQft6c1985s9ZH64YGaEXTA5aYJNoDFwlJJ9F44MGZmSmB8TxCiOq3wR5+IlYUb97Il2q5Bd1sStb1WhS81GsmWDv3m/S20pjLouDpZKq8WZy7GQLe9pBQptAPPpK8Jj0aKW1SE2G+q2HEWXTH7txK4w=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a3a8fc5d-d407-40a8-f91f-08d59db2391d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1095389F112DC2646EE19C2CFBBF0@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(26005)(10090500001)(476003)(105586002)(86362001)(107886003)(11346002)(446003)(2616005)(102836004)(76176011)(6512007)(97736004)(36756003)(6666003)(6506007)(8676002)(59450400001)(99286004)(4326008)(10290500003)(81156014)(86612001)(81166006)(186003)(486006)(2900100001)(106356001)(1076002)(72206003)(478600001)(305945005)(8936002)(25786009)(3660700001)(7736002)(68736007)(66066001)(110136005)(316002)(54906003)(3280700002)(2906002)(3846002)(6116002)(6436002)(53936002)(6486002)(22452003)(2501003)(5250100002)(14454004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: M129+l1o/49ACwYHEkqKbrjDxPkrhRVZn9jmwjiCebn40iCNqPBweSxrxlrTzaJZ11+/q1f/9fNAwpW4Q908hE4esSpWO74EBQNMK5Ni6xjsxVY4ofmidD6k0Qo1manOiQnIycYvhOe5zG9KrrMvoHacjIO/oKMIT6RwX4n5BCzowSLvihQjX5P3U5Ojo4Z9ShUNccVdN7wdOt4786J7tWNCmzm8TIHvdGJM+/c7INaX9Ds3Bdjw+B3dVDgZBwEze6fR8UmpFEVfHOouhFxBuNAFShaAOcFnHtd4fNNillb4TJtm0+74OdNPvgSDlK/5VJO6cfWCf7JojiAWXdSKoGdoPsUGziWN4IQTDDhHqFlAl9rnD8ZDLchKQ1vZotNuxEVEOVE/8sr2y7Qi/moPphdb+eSRA+vvAFWiKtWMPfE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a8fc5d-d407-40a8-f91f-08d59db2391d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:22.0212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Liu Bo <bo.li.liu@oracle.com>

[ Upstream commit 343e4fc1c60971b0734de26dbbd475d433950982 ]

Setting plug can merge adjacent IOs before dispatching IOs to the disk
driver.

Without plug, it'd not be a problem for single disk usecases, but for
multiple disks using raid profile, a large IO can be split to several
IOs of stripe length, and plug can be helpful to bring them together
for each disk so that we can save several disk access.

Moreover, fsync issues synchronous writes, so plug can really take
effect.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index d4a6eef31854..052973620595 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1861,10 +1861,19 @@ int btrfs_release_file(struct inode *inode, struct =
file *filp)
 static int start_ordered_ops(struct inode *inode, loff_t start, loff_t end=
)
 {
 	int ret;
+	struct blk_plug plug;
=20
+	/*
+	 * This is only called in fsync, which would do synchronous writes, so
+	 * a plug can merge adjacent IOs as much as possible.  Esp. in case of
+	 * multiple disks using raid profile, a large IO can be split to
+	 * several segments of stripe length (currently 64K).
+	 */
+	blk_start_plug(&plug);
 	atomic_inc(&BTRFS_I(inode)->sync_writers);
 	ret =3D btrfs_fdatawrite_range(inode, start, end);
 	atomic_dec(&BTRFS_I(inode)->sync_writers);
+	blk_finish_plug(&plug);
=20
 	return ret;
 }
--=20
2.15.1
