Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237433-4-17063821536888694036
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
    1523237432; b=FnJXs4jV9+ln5Hzyai+S/0UYYMX2IK8aWUMZen9T0kauDj1Mu+
    2nvaJ6qvjyCff+FovQ551C3T3u95Px2ahljzTvWj1ylAiBSMyRuJP6s/HfFK1SYP
    CjIMYP8Qpc7CrURoMTkevs7TzGhbjXeMp8ZKvlCLn/5vMOhGw9FeTARGhFQFPN8O
    kOH9ye41AuY+Rl13dHabV14TU8jsmU0Is1L5rxB4ybkRV7fXEkM+LlIaSU0G17in
    +GTrZPgdIoZBBghJ0m8VbPry83KgRCH5zZWF9ywnyIVQ06I08r07H58kxYEWjCPq
    yxVIx/sGTJpnqayFDmATe6RXopcor1nL5HLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237432; bh=wuU0FbaEJK
    fWe6ozW5SL1L69RyifRZCv+EmDToaZbcM=; b=ez1djGEXyGHqc8DPw4J9z08ee+
    NU2veJOVfvqhGcb+o8u2gpTmE9p44+Un6dQYG2vhWOKgPNLBLREY9P/7/xd3euLe
    hG8AlgDNivkVAey6RPY8cS7UUivAtsC041C0p4lYD1XeJnihdTDgLs2jf1BFAQd0
    xBAMwe3+KhTN9f5RIQ6lRPHw/CgglNlvHKZjmqEpOnGeApKFlSEJYv8rjiHUO02C
    9Bmoeaut2fXElF5Dzd6Lj4GnCbv/UhUZGWb6r4DoJe/zP/Yd/KJTy/16mZjTfRoE
    TDUud0lNX2PHumy41lxJJi5bzAyzij4/mKBjfcSq6y7n860c57qZ9xQtVVnw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cKuYP6Ti x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cKuYP6Ti x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLPcbOhwkekdIKfS58X4e1QQl0pK5f6HzjDw01KYqaJHEKUBoFLSUFZKj/uFJARY3mcHraraxg3diEixnWD/xzx0oXiSR/fulfLXDj8LSHbFlyEhAo6N
    XvkwUnPPI5NYpKoQpUEWAOG50W4wjjFDr/UHhmLoGol+HcnKDarjuTSnBT8xCZCPUFjWrNmBa4SVZJdY+pAUsWsseMy0WwjJ9DDnhnKVK+s3d5Xo+WxqujpD
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8
    a=G2YI053_dnqyvRuSU90A:9 a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755949AbeDIBaN (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:30:13 -0400
Received: from mail-sn1nam02on0133.outbound.protection.outlook.com ([104.47.36.133]:9440
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756636AbeDIAf6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 046/162] Btrfs: skip commit transaction if we
 don't have enough pinned bytes
Thread-Topic: [PATCH AUTOSEL for 4.4 046/162] Btrfs: skip commit transaction
 if we don't have enough pinned bytes
Thread-Index: AQHTz5mm5PkghbLgwU6yMM5hc49jiQ==
Date: Mon, 9 Apr 2018 00:28:15 +0000
Message-ID: <20180409002738.163941-46-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:gY544n+dDgGf4TZcReXPt0Ef0nbdDNXvOaXD0JFquoahk8PX6yTdjqNpoUJnQW7FyZmvY0N31XQ0X+gqyqQ+GBwdzCmlKBjfVSZ4q62yhOE6fGyOTKh19rHssqyzZhphoPIWRJdsOocL3942UgX6g9mZpIlTZnqNc4SFRPMDOrznm1/bSNwTggC2oniZFnuQX8+ToHFrX4EdN/IRBurnOdO8w42xTFsL08Xy+iWrJkKvueHt9xuLsGI5pBrdxutJ;20:Tk60EHP5maWm0LZ0hKH6kCRxEK73RhM6CefesHetynYVvvOYbtQF+SI5K3WtCmWzwjhAY76WPY2hAXpR8++uP3QiFdrJWoe0yjCaQfdyIYNN6aAE3AhE+WNL8qDYj3tRiOd7eME9cBp1EyezQ6XnzQcL5DTxrtKWICXeq+BY9bI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ead28c2-3d8b-4079-4028-08d59db1dc03
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07255C7A6EBF6B744E678073FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(86612001)(102836004)(5660300001)(14454004)(476003)(68736007)(11346002)(66066001)(446003)(99286004)(76176011)(486006)(10090500001)(551934003)(3660700001)(110136005)(305945005)(106356001)(316002)(105586002)(3280700002)(59450400001)(3846002)(10290500003)(6116002)(22452003)(6506007)(2616005)(1076002)(7736002)(54906003)(478600001)(2900100001)(2501003)(5250100002)(8936002)(25786009)(81156014)(8676002)(6666003)(6436002)(4326008)(26005)(6512007)(6486002)(81166006)(107886003)(53936002)(2906002)(86362001)(186003)(97736004)(36756003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: N614DXd9GYdW+C+xv1ld25wayFI8XRp9K2gG1e6NrNz+OaDkqO+0IzFu2otN9xJcxugcq7TGr/d0LAgwLEUs1sn1KB1XhRVWksKO5/Mu/xBB4ZZz3aTaBhKfQnBdZQa+FMfn7I2GwCm8F9GUslPF4oN9dvq5cCg7YaxHrrdx3aXGzDU9F9XgIrnv2ltQcrkKjH6o9tv5WPaqKyvmydUJNGVQeiisIhzintQcS2Cr4O9b8dPUcGwS4+nCvDqm/r5dT/B+uphNdWMyI37XzFPoypp716rwSyl0byrLNZeEBhwc3d+nrUlvcuTNn0POplGGOwT4zuuaDHTwXqBFde3N4fsatRuRahL8yIG1VgahsI49Q7jkXrnNxHfgfZv3Nzj7UJzoRbl5HIX3AUz34lvmPqYEa0ONRs4tRAqjRBhf9Cc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ead28c2-3d8b-4079-4028-08d59db1dc03
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:15.9581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Liu Bo <bo.li.liu@oracle.com>

[ Upstream commit 28785f70ef882e4798cd5706066a55dbf7adf80e ]

We commit transaction in order to reclaim space from pinned bytes because
it could process delayed refs, and in may_commit_transaction(), we check
first if pinned bytes are enough for the required space, we then check if
that plus bytes reserved for delayed insert are enough for the required
space.

This changes the code to the above logic.

Fixes: b150a4f10d87 ("Btrfs: use a percpu to keep track of possibly pinned =
bytes")
Tested-by: Nikolay Borisov <nborisov@suse.com>
Reported-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 260f94b019c9..875e179bb2d5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4672,7 +4672,7 @@ static int may_commit_transaction(struct btrfs_root *=
root,
=20
 	spin_lock(&delayed_rsv->lock);
 	if (percpu_counter_compare(&space_info->total_bytes_pinned,
-				   bytes - delayed_rsv->size) >=3D 0) {
+				   bytes - delayed_rsv->size) < 0) {
 		spin_unlock(&delayed_rsv->lock);
 		return -ENOSPC;
 	}
--=20
2.15.1
