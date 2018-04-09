Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234830-2-14288469466736216400
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
    1523234830; b=vSxcoWAi0KJbb92BkVC+aVC2MnoPV7sMuZREQk0guM+STTOUqx
    FZega43gZD0IhnKDLFMp3zG2SIBa6UgI5Dsvr0PRMo8ihuD+VakeGo1+KF9C+xnO
    stLVS1074aXX0VjePPz89o9QsydtcaK0M95eY6TRPSc8MM/JnQ0kK4+8a4t6Pbts
    UDwkNNv6JOG6nmWQJ80UpsuXUY2K7ueSJbYBultlJO9VqmU9iynLKGHlWwIpb/xw
    uqISOD5+Bs6xIvEpQ8wxco25BphI7NSaHwzv5YDT93y1Y0vG0twbM7JpVbbGo/XI
    DtBL9b+RvpfKHLwcHzr3kOmJcq2shL8QbSww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234830; bh=b21lkgfPYI
    dWqz5/KZ6r4NlbNACRO25FyEMkQWeu2S8=; b=SuvFwDDjHnb2Z4MjF8L+eqmidR
    JYeW/8Cn+VnTBrrL+6y3/5xib1C3rKt+voyi5ftmLxUXYmHFHKuJcvLIwr84oqs3
    5UHtzktJQLLNJgSc9IZzGq7xE1H40IkhFiCkBqmqYOJexZmTQXvo1U8CyrcpyGwk
    73MbMc/InQOm5jBJR4gy0RsaX+RGPMKDPVim7Uzmpgy76u+CtOIEsTZjXkeMfkql
    4+YyR8Nfo87mI6QYkxMCX/I6n+BVDptwDIOljfnb1K0SzmQ9lGQv25x0SAEEoB2E
    rd2WzmVK4x9NzMra44KzEDR+ONL8nKbBj4Sw5xVvSUqAirmRMJkKjMuGIPbA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H0mjMOhL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H0mjMOhL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKeVivWRiBHRBQiFBRRDWolhSjBw/xmZweZuVD1rxoWH6NmRxVDavlnxPtrlaqMNLP47h00Rkzg7W5srzhz1BaWWMpJtbDkN581iDm61ARigfg0jPFCK
    l5cAXM2Z8zbbmkDoCDQA0/4y9IAabepAJ84APiCoZ17wthr352DmJDX/4VPfuKlDt2AwgD24gIb8zDrRCiIkqrwqg7w7AXSIOoSMFdGnK94vapDpW7bInCsc
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=drOt6m5kAAAA:8 a=yMhMjlubAAAA:8
    a=Hd4EjHANT1J2BtSiHa8A:9 a=fmYMAI2vvugCTNh3:21 a=OrL8zmcmXUHjIvll:21
    a=wPNLvfGTeEIA:10 a=RMMjzBEyIzXRtoq5n5K6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756729AbeDIAmQ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:42:16 -0400
Received: from mail-sn1nam02on0104.outbound.protection.outlook.com ([104.47.36.104]:21151
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753392AbeDIAmO (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jake Daryll Obina <jake.obina@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 080/101] jffs2: Fix use-after-free bug in
 jffs2_iget()'s error handling path
Thread-Topic: [PATCH AUTOSEL for 3.18 080/101] jffs2: Fix use-after-free bug
 in jffs2_iget()'s error handling path
Thread-Index: AQHTz5uFdXiaagdT5kS8xiCzUr0bGw==
Date: Mon, 9 Apr 2018 00:41:38 +0000
Message-ID: <20180409004042.164920-30-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:C+KiEHI5fxkCFVmQbC207JyfmOsP3YEWBh/qRJTk0I7r+Msfs2BstTfhhPoIEeV5qyGjrVKsLHqy0np7pp44YAW+bCYG2qExJsZnYHeif6+kCer0xIiy32exNw3CutpXc4nvh34E/k86tORT9zzJ7p9dl11+9QTrgFVHgrOIbq1EcQcdthrOA2Jbh7hR3B2bZVXwFr7tvBOsDWFPsjwmtdVLTuHJZvw40+zq2pab0yhr2fmy7e/W8G6xQ0hXKAyN;20:uAGwRKufBHENnhyfU9aT2YNV8wgWFk+LAcqbweyKEkMe3U5E1bb2BRGgDLJcRu3n1VMIZWpOKir2mkWzxfUhU9dK9dIL5X72rXdr6GiyabCKmEZlv5fywL6v0gpxux04yrrKxAA1Ix5sgQvtw5HxWxjmRGtVBB6p2n0ROBJcLIc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e48b45c-3a5f-457d-842b-08d59db2bb5a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10621846979F4FE8EE7A8F87FBBF0@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(199004)(189003)(68736007)(6512007)(316002)(486006)(6486002)(6666003)(54906003)(5660300001)(110136005)(102836004)(14454004)(99286004)(36756003)(86612001)(72206003)(105586002)(97736004)(106356001)(2906002)(22452003)(1076002)(2900100001)(10090500001)(6436002)(3660700001)(6116002)(575784001)(3846002)(305945005)(59450400001)(86362001)(39060400002)(66066001)(10290500003)(3280700002)(5250100002)(25786009)(8676002)(81166006)(8936002)(7736002)(478600001)(476003)(81156014)(26005)(4326008)(186003)(2501003)(107886003)(6506007)(2616005)(76176011)(11346002)(446003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: bpFbyJriLO2h9zXzPkbNcSRFzyfnT2vtfv1LkGYXj7U0e+jPu8GO0O5le5E8Vxj9mU2NXkev8TmlwgYaSdd5xGhvTIvoLdecf6/ogaPoaAwmXIKLLTLpBs5FYx4WSE/nFqDltpLxBCeQ6VdgcHdSHVptyl9zjrfMk5ZwIPBz4bNSypfvTmVbQo9BZas2m+lfDvXwhVD42XxMSBOarN5kD8h2C3WfjgfAwC5KunMJWgc6z5iM0hxOrQKcG7vtmnosEJ9MiIIozLj0yL1Ob41YQKC/y4hjm+h37qSlyWfhQMfQTvYbTAB82+KIQp7BfhHeFZ/Ry9mtJ0IPZx7a90eF+497lahAnNY7BoVGUGWmrhJukfhvkn6Dq90NQ8/bA/UVusqsTNnyYVlkRFdSRayLgUDmmBd8TAmC7codTX7nGGE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e48b45c-3a5f-457d-842b-08d59db2bb5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:38.8147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jake Daryll Obina <jake.obina@gmail.com>

[ Upstream commit 5bdd0c6f89fba430e18d636493398389dadc3b17 ]

If jffs2_iget() fails for a newly-allocated inode, jffs2_do_clear_inode()
can get called twice in the error handling path, the first call in
jffs2_iget() itself and the second through iget_failed(). This can result
to a use-after-free error in the second jffs2_do_clear_inode() call, such
as shown by the oops below wherein the second jffs2_do_clear_inode() call
was trying to free node fragments that were already freed in the first
jffs2_do_clear_inode() call.

[   78.178860] jffs2: error: (1904) jffs2_do_read_inode_internal: CRC faile=
d for read_inode of inode 24 at physical location 0x1fc00c
[   78.178914] Unable to handle kernel paging request at virtual address 6b=
6b6b6b6b6b6b7b
[   78.185871] pgd =3D ffffffc03a567000
[   78.188794] [6b6b6b6b6b6b6b7b] *pgd=3D0000000000000000, *pud=3D000000000=
0000000
[   78.194968] Internal error: Oops: 96000004 [#1] PREEMPT SMP
...
[   78.513147] PC is at rb_first_postorder+0xc/0x28
[   78.516503] LR is at jffs2_kill_fragtree+0x28/0x90 [jffs2]
[   78.520672] pc : [<ffffff8008323d28>] lr : [<ffffff8000eb1cc8>] pstate: =
60000105
[   78.526757] sp : ffffff800cea38f0
[   78.528753] x29: ffffff800cea38f0 x28: ffffffc01f3f8e80
[   78.532754] x27: 0000000000000000 x26: ffffff800cea3c70
[   78.536756] x25: 00000000dc67c8ae x24: ffffffc033d6945d
[   78.540759] x23: ffffffc036811740 x22: ffffff800891a5b8
[   78.544760] x21: 0000000000000000 x20: 0000000000000000
[   78.548762] x19: ffffffc037d48910 x18: ffffff800891a588
[   78.552764] x17: 0000000000000800 x16: 0000000000000c00
[   78.556766] x15: 0000000000000010 x14: 6f2065646f6e695f
[   78.560767] x13: 6461657220726f66 x12: 2064656c69616620
[   78.564769] x11: 435243203a6c616e x10: 7265746e695f6564
[   78.568771] x9 : 6f6e695f64616572 x8 : ffffffc037974038
[   78.572774] x7 : bbbbbbbbbbbbbbbb x6 : 0000000000000008
[   78.576775] x5 : 002f91d85bd44a2f x4 : 0000000000000000
[   78.580777] x3 : 0000000000000000 x2 : 000000403755e000
[   78.584779] x1 : 6b6b6b6b6b6b6b6b x0 : 6b6b6b6b6b6b6b6b
...
[   79.038551] [<ffffff8008323d28>] rb_first_postorder+0xc/0x28
[   79.042962] [<ffffff8000eb5578>] jffs2_do_clear_inode+0x88/0x100 [jffs2]
[   79.048395] [<ffffff8000eb9ddc>] jffs2_evict_inode+0x3c/0x48 [jffs2]
[   79.053443] [<ffffff8008201ca8>] evict+0xb0/0x168
[   79.056835] [<ffffff8008202650>] iput+0x1c0/0x200
[   79.060228] [<ffffff800820408c>] iget_failed+0x30/0x3c
[   79.064097] [<ffffff8000eba0c0>] jffs2_iget+0x2d8/0x360 [jffs2]
[   79.068740] [<ffffff8000eb0a60>] jffs2_lookup+0xe8/0x130 [jffs2]
[   79.073434] [<ffffff80081f1a28>] lookup_slow+0x118/0x190
[   79.077435] [<ffffff80081f4708>] walk_component+0xfc/0x28c
[   79.081610] [<ffffff80081f4dd0>] path_lookupat+0x84/0x108
[   79.085699] [<ffffff80081f5578>] filename_lookup+0x88/0x100
[   79.089960] [<ffffff80081f572c>] user_path_at_empty+0x58/0x6c
[   79.094396] [<ffffff80081ebe14>] vfs_statx+0xa4/0x114
[   79.098138] [<ffffff80081ec44c>] SyS_newfstatat+0x58/0x98
[   79.102227] [<ffffff800808354c>] __sys_trace_return+0x0/0x4
[   79.106489] Code: d65f03c0 f9400001 b40000e1 aa0103e0 (f9400821)

The jffs2_do_clear_inode() call in jffs2_iget() is unnecessary since
iget_failed() will eventually call jffs2_do_clear_inode() if needed, so
just remove it.

Fixes: 5451f79f5f81 ("iget: stop JFFS2 from using iget() and read_inode()")
Reviewed-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Jake Daryll Obina <jake.obina@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/jffs2/fs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 601afd1afddf..c0ff490974a6 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -363,7 +363,6 @@ error_io:
 	ret =3D -EIO;
 error:
 	mutex_unlock(&f->sem);
-	jffs2_do_clear_inode(c, f);
 	iget_failed(inode);
 	return ERR_PTR(ret);
 }
--=20
2.15.1
