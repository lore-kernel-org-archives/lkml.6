Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517683086-2-6183134419571201882
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
    t=1517683086; b=F7FPGYKPiLbo+sCkzjUMK/scnpU5+LaAKEsHqLT/4DyrVdR
    /HT+ygBTtTb91GE03kFkJJ46YfE8fzwUty4IREAYRD21+zbRk44blVcrSKv4+PlL
    APYTjk/OhkEJ7hj3LhbPKD88lWGOovOrSGfhnro4rcqbAlqFgvKIPS84tNq+IYd6
    adUu4EmVW73DAfbHxm5lCQAmXT6BpkpIl9mdTRFK7+/5pIPpasrTCoiDdjp0C6y7
    ljmIaG58zF4DBgDgyFQCagz2ZKBS2fIHV465xIBv1T+LrnhSOo7sT5ikkrWBxKMk
    /RlUvEKzCHrt3idWrREGWZbU3WH1HjnD8MvRYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683086; bh=zRlZip
    l0NKYurkp9hI5u0E7ZnVFwcUDoFJOAwAGj2ms=; b=FUxLzqiALT0mlvZfIlwMOG
    SZVrG73wJTj2xZT7n6yE6U8PiQMn+NhYirk6DQz7a7RCkgCrM3vQEey74q8q+fnl
    41blf9JfihaHqf5H9LQgmZEes/7ynU2k8+o0vL2nDnd9bUOVjri6TykFANfeYoEl
    MfhmJSzml2D580ztMsvRr+N7Pk71CU5R1v+nKCeleRC2vnlpCUDPdi1EGAQ85pQX
    vI97+doXNKzSmwd9IvIXmMPpM3zFpFRC+oxG+EqZFD4udGTejdlO6xoqUkBIQSx1
    cazbuLJiI/43jsGvEL6WKTs21A6LVJVoG5/1oWKnaSoHVRcVGJy6hvsl7apEv5jw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i9AIZ7Ha x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i9AIZ7Ha x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754222AbeBCSfH (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:35:07 -0500
Received: from mail-by2nam03on0097.outbound.protection.outlook.com ([104.47.42.97]:1354
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752821AbeBCSD4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 070/110] btrfs: Fix flush bio leak
Thread-Topic: [PATCH AUTOSEL for 4.14 070/110] btrfs: Fix flush bio leak
Thread-Index: AQHTnRj7oHjxoLNSh0mf6Osm8j4Jmg==
Date: Sat, 3 Feb 2018 18:01:15 +0000
Message-ID: <20180203180015.29073-70-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1105;6:myhWl99UdFiH3e2D0OnQ62ZmlUbWKmqGJx5dxEt9Qg/Ke7wnmlnUHXtFMSbC0GAzHr2NbRngVn5riTRXl63aFY8WQvztp2TpS9tjUU+Cc4lsoYM8YLn8Y4uwFoxMnE62eQC/mVDNk4ABcS+QB4eopX/Lqp4y3bzo7P67K4YDU70ZNWsZtZa09txManj1ju+QOIJuUWiCpqdKQmAYV4X+wtx7fP7+KIjljT4SqBGevjKqj0elGF1a9G32Y0H6G9GhC1C4OqiR5QZcAjbjRvxgvYFu+McvKC13puFW6v1VrCnMlBaEOOQhkSQBuHxAgq/EXwdaOWgTgB5tOqLiCnZAuPH9w72DgG2Dg7oRdsLy8Ftv5eDL4aRKGR9vkUM8nZst;5:E5Eu1+v/NEtMP9X9yRzABlGm0QcL1j4b8JI5FD1PEWTW/ORE2hNeLN3VIVWbO4U26Ji2Od1SKitp/LFmzrA2WAUfojxlPLRFfyvtpmVC4wpQDxdQFmODcJwkkQ1v08xAnqkfs6ivrhvEsDyAVNeIULqUbArj0OSnIPq/JsQOZ3w=;24:7l5CXkBs12UfUT1SZ0pybl0cSMeTSltr59doruHvmERuv3JqU7YR17NOVVIdCOwgw5CdYyZuDED4a29zt/B2/wnAfjZWOeBbEz+Lbryo+wI=;7:bK0mc9mjvX1Iftv9trqjF3kMsQiY1o+4c3Fgj4XTq6jaoyfcg9biZ805jkaGgQRjf5xv8SONt6zYYzRgE4Hfo9XbIgNtDWEf60UHqNsplP+QfnScJJnlTbsKsSeA3ub3f8JYtsQOQDb8IX612Th8GFn5lBkVFfhXkv+y3AVs5jCMJPppFfjqMHome/e3hhCR348whmYLlz/Gg4FH7vS9/VOz3xXXOojaad/jcRk/gzS/+8vsXujN8EG1MPCgWdQP
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3f6d21a-7849-4ad5-2e7c-08d56b303cea
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1105;
x-ms-traffictypediagnostic: BL0PR2101MB1105:
x-microsoft-antispam-prvs: <BL0PR2101MB1105E1DA9C42B7B2AF90234BFBF80@BL0PR2101MB1105.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(6346003)(97736004)(6512007)(7736002)(26005)(305945005)(102836004)(105586002)(68736007)(5250100002)(8936002)(59450400001)(6486002)(6436002)(106356001)(6506007)(81166006)(81156014)(2501003)(2906002)(10090500001)(99286004)(66066001)(54906003)(6116002)(3846002)(36756003)(1076002)(8676002)(110136005)(575784001)(107886003)(72206003)(2950100002)(478600001)(10290500003)(22452003)(6666003)(5660300001)(2900100001)(4326008)(25786009)(14454004)(316002)(86362001)(53936002)(3280700002)(186003)(3660700001)(76176011)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: uDon+W+HVCCmjgcmIJQvewiFDihpQ8lm3nXiX8WOpFVV98qz+4F9uktmheK8aqpstRzTzBVPk55UYTh7gciIlA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f6d21a-7849-4ad5-2e7c-08d56b303cea
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:15.3940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nikolay Borisov <nborisov@suse.com>

[ Upstream commit beed9263f4000c48a5c48912f26576f6fa091181 ]

Commit e0ae99941423 ("btrfs: preallocate device flush bio") reworked
the way the flush bio is allocated and used. Concretely it allocates
the bio in __alloc_device and then re-uses it multiple times with a
very simple endio routine that just calls complete() without consuming
a reference. Allocated bios by default come with a ref count of 1,
which is then consumed by the endio routine (or not, in which case they
should be bio_put by the caller). The way the impleementation works now
is that the flush bio has a refcount of 2 and we only ever bio_put it
once, leaving it to hang indefinitely. Fix this by removing the extra
bio_get in __alloc_device.

Fixes: e0ae99941423 ("btrfs: preallocate device flush bio")
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/volumes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4006b2a1233d..bc534fafacf9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -236,7 +236,6 @@ static struct btrfs_device *__alloc_device(void)
 		kfree(dev);
 		return ERR_PTR(-ENOMEM);
 	}
-	bio_get(dev->flush_bio);
=20
 	INIT_LIST_HEAD(&dev->dev_list);
 	INIT_LIST_HEAD(&dev->dev_alloc_list);
--=20
2.11.0
