Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118850-2-15917951989218488541
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118850; b=cNFekeSPwmcorLUe83qzttXO8v5GrrIDSXer8pojZ4WZz76
    DcAhPEt/VUlvOXY7C6pVsR1mu0CnQ5rUOJUqAXlcCPNxRbMqjN8gkG13jYsD4GMh
    jyCzQw/dKSVBI2sr+9nXcC/W5dUt0JbitWlTk+/zsSjE8gI2DUzBTtZUvVyvtJaL
    h8ACM/YmRcZDMH4njmQmY1cnwh2BOGQ6PrNw8u6ZmoOIpX3BetgtcY6uULviT5ez
    PWb/bsXRLRFCFVnVeROciQNjVdKOhz9yt3DzOSzFRcUeGaQAQF7FbQLHT8b1cPuk
    5jHHAnLdn4KVyTK6T4IEHcNNLcMi7Pujj9rJwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118850; bh=z9rxiu
    7KCMKpDjFA7vzlkQwfSjUYcP+p8Zanh3X8d8w=; b=joYb5SwGqY/o1NyQiloqGJ
    C8pMyi21b8AQlHeNTFuCl0HBJlIeLguIRHJ2bsw7W6eIduR9BiztXvYXhCU+NyKu
    l9vQSXZt+CKKCokzHS4YMrioXTdopCCPg8Ym3vUtMFeHf7+7vhndwQ9Vi3N5TiD1
    zNWirER8ZkZUl2567u7NSqn40ma3Y+NUQd2KhWbKgRZSagDHr6e9MAuOtFHyJ+lp
    /XpTWjG5mQ3SRunpxS8n/QwyrgzYDRbX1eScXJmdKFjkcr0tJVc6VhU8vxBmoIPK
    JUfpiXQP9qLErW3xjvEGMdv39LlJkXDB5JQpozpTq9VKJtY1LFmpGuko5sAasA3Q
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TsEls9/2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TsEls9/2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933867AbeCCXNh (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:13:37 -0500
Received: from mail-by2nam01on0100.outbound.protection.outlook.com ([104.47.34.100]:14848
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935021AbeCCWjJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 040/115] f2fs: relax node version check for
 victim data in gc
Thread-Topic: [PATCH AUTOSEL for 4.4 040/115] f2fs: relax node version check
 for victim data in gc
Thread-Index: AQHTsz9VFFZ88wunzEqZA6gc5o5yNw==
Date: Sat, 3 Mar 2018 22:31:12 +0000
Message-ID: <20180303223010.27106-40-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0938;7:U6uFJfjcjHOEX5YiGND5cT9FRD2t/r6cP2XDpo4/8XjHdcKUDTzc+bYgbSBlBPY67aK43Zi0mRuTc7G1I9BQQG3oatsQs6KnySzpQDv20yrKss695JnxcAsUSd1UbpOINNUHDTj/A6lpTLI++DnLQ/xuj2fipReTgAWidlJL++51OS4omgYg6NWbsjbAS7UZIAcjrk47lv5MI4Q8k1RX8Ho+dbLYuw64a2ZgSBm7CM+HJZ9PK1vYIzQvGw5BVMd7
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 718f4535-94ce-4331-2ac5-08d581579288
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0938;
x-ms-traffictypediagnostic: MW2PR2101MB0938:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB093800D82662AA12DC7C960CFBC40@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0938;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0938;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(54906003)(4326008)(72206003)(22452003)(478600001)(25786009)(66066001)(6436002)(6512007)(14454004)(53936002)(2906002)(6486002)(105586002)(99286004)(10290500003)(3846002)(106356001)(6116002)(305945005)(5660300001)(110136005)(1076002)(36756003)(316002)(2900100001)(2501003)(5250100002)(10090500001)(59450400001)(102836004)(68736007)(2950100002)(26005)(97736004)(186003)(6506007)(8676002)(107886003)(3660700001)(6666003)(7736002)(86362001)(81166006)(86612001)(81156014)(76176011)(8936002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0938;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: URssTC1zaG9RzyGyONMG/z92/1uCNdxxEfjqRVO9GN8s9lvREO7Mn28DTlAeppbF6PZTmyYqiWTzQgH8TBoI6l9GA5rbVljbV3WMWCRskSKEzEeygnEeLWWeoJoNeEvTc7pUcy1WGTYOFSia0L8rTVMEgL4UkJ26QmuBjRAYF+k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718f4535-94ce-4331-2ac5-08d581579288
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:12.2915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit c13ff37e359bb3eacf4e1760dcea8d9760aa7459 ]

- has_not_enough_free_secs
node_secs: 0  dent_secs: 0  freed:0  free_segments:103  reserved:104

          - f2fs_gc
             - get_victim_by_default
alloc_mode 0, gc_mode 1, max_search 2672, offset 4654, ofs_unit 1

                - do_garbage_collect
start_segno 3976, end_segno 3977   type 0

                  - is_alive
nid 22797, blkaddr 2131882, ofs_in_node 0, version 0x8/0x0

                   - gc_data_segment 766, segno 3976, block 512/426 not ali=
ve

So, this patch fixes subtle corrupted case where node version does not matc=
h
to summary version which results in infinite loop by gc.

Reported-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/gc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index fedbf67a0842..928b9e046d8a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -522,8 +522,10 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct =
f2fs_summary *sum,
 	get_node_info(sbi, nid, dni);
=20
 	if (sum->version !=3D dni->version) {
-		f2fs_put_page(node_page, 1);
-		return false;
+		f2fs_msg(sbi->sb, KERN_WARNING,
+				"%s: valid data with mismatched node version.",
+				__func__);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
 	}
=20
 	*nofs =3D ofs_of_node(node_page);
--=20
2.14.1
