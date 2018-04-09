Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246039-2-11508348412735549898
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
    1523246038; b=WSqAj443SqyUzYe8sOH3pfJugqlVMMa6aAsizVuNLYwnHXzBtl
    uIY8kqRYEcyWHXZUk4LuMjK1otITB9m6YFrhJ0jQe81Lp+lUKSQ/l/o72GLglYLb
    WCpC3ZykxNbzkFXOKvyF9O1kWcuw3EWgorWkc4eCuk3CZRvVdvBjkvAzuMOUzt8F
    E0vd04otbnTetZq4v4lbdwzraMPfbp9f/rpQZtVj3XARMOFEobIhm/cktGL2Coof
    e6gNGQOBClomLMK15FZLBTg5BucKBsbjIMhVV6MMUKLX51KmJPSZDZmxguobEExs
    nSFHFLLmRZNxGDKQVOhCADdx5onpPtW2GSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246038; bh=w8JNgS/YZ7
    ii4PTxNxOg44DRliGbMAxJPe9zvhdn9PA=; b=o+Y6SMJUUQiZIdU72S+/AfXp53
    qhKSHiJqhzZ9XHdq+ZTwOAPVT8RZ+arRcIYsuiGfsaEiu99bx4+hIIhJ2hoDtJDC
    4zv6E+cg8mC3uesJEBfkqwjE+R7LyCTcMZCvz5LSIo4otUx4Arhv9FSeEzX2h5pw
    Mfl+EkdM/IqSpeoqqLUUzl8QxNS5CCTMrP/r2PgT3XvU8EEMg5oxTUHLqeeloyUP
    opObu3hV9nrncqKFGQf8A1AaGSuhNeAA2N3g8OE9Vxb/akY1yiZgw+BAbvWB8Q1k
    J4KbkkO8kk33tk1LXc/9MYPknrLDGhd86JNYueNRIuB9Yf75N0PNN9ZY1kdw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LelT03DV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LelT03DV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCmYa2Gnd/NOhiXg7yXXTPI/8qQJn8BsEi9wmKl9XmdOD0F8bBP7sEoVL1fgExaw8a9VbhCqS7t4q/fGCDMmmxMPhLScHWKSFbgNUrukI8szOl5kw6KG
    HVEB1toZdtOUzHo1h0QfVrTuPtSYN16gVx8Y7xzbw2LPMui8taHHGSwYyGL1LHJlu/ykXYvtQFhoc/Shl1rqtbtuDXqjKfN5Ig4AvIJRaS29WMJoqwuayB3O
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=drOt6m5kAAAA:8 a=yMhMjlubAAAA:8
    a=Hd4EjHANT1J2BtSiHa8A:9 a=fmYMAI2vvugCTNh3:21 a=OrL8zmcmXUHjIvll:21
    a=wPNLvfGTeEIA:10 a=RMMjzBEyIzXRtoq5n5K6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbeDIDxp (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:53:45 -0400
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:11088
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753958AbeDIATW (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jake Daryll Obina <jake.obina@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 096/189] jffs2: Fix use-after-free bug in
 jffs2_iget()'s error handling path
Thread-Topic: [PATCH AUTOSEL for 4.15 096/189] jffs2: Fix use-after-free bug
 in jffs2_iget()'s error handling path
Thread-Index: AQHTz5g4KdFPTSJmKU6sLMLb+2RQaQ==
Date: Mon, 9 Apr 2018 00:18:01 +0000
Message-ID: <20180409001637.162453-96-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:9IlIZJq7oP6m7Bkm7/KN9KLKlEQXp8txKqs9MPPjZyhdg3pzlfiIb68p16TkPFLl6gNr7ZN7lV4OL0N5eIRfbglZ934e9In1UZRDjtG0NTsHHGvyu4KpFpiHQ6zgD8r9gfUodWBK0b2rb5WsEp5qHTGOFEuXjyrW1rUzgUVzxbsireyykt+FHSsha3gLlTe4ZN15nzUNK5i1N/zZ4qcCbdbgJXMcRCRDnLj6Vpx/9ZuDChzktnIH1A4HlkY2raWB;20:+RE1/oHgA7/p+2fGJ76xAq5C10cu2bHlnjhOb602KQBooVHlcuOqOHLwe3NsbEvnGyOIkjpL7k8EW4t+Mp2sYzwHFeJPsXTYhDd75DJMuWh0PREMiK3L+/NQ3VE4QJjcoWoy6ica8+VvoHGusAvRaLaknzLIAbptP7b73sFVfnE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a6c393b2-e5ed-4a16-20bb-08d59daf8878
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10634649E96B98C709393A12FBBF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(189003)(199004)(2900100001)(6436002)(7736002)(10090500001)(102836004)(3660700001)(6506007)(76176011)(305945005)(4326008)(5250100002)(97736004)(26005)(25786009)(6512007)(2906002)(81166006)(106356001)(107886003)(68736007)(14454004)(86612001)(66066001)(10290500003)(59450400001)(6666003)(5660300001)(81156014)(478600001)(476003)(486006)(6486002)(72206003)(3280700002)(99286004)(105586002)(36756003)(1076002)(2616005)(11346002)(53936002)(446003)(8676002)(186003)(3846002)(54906003)(6116002)(2501003)(8936002)(316002)(110136005)(575784001)(86362001)(39060400002)(22452003)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: V1z6V26ZoQMCPgGrqq4Dh/0qiBiqsOdcrE5fTrB2vBJijqzk9a73AgZJEgaVGEhrSYZPe0PAHXj9P/oMVHR82msbz9L29Prrs8zopX4zOIL4fLP4gSobE1xAMhBqhguW99VGtVJ3r4mca7duZvicX5JWg81RQ5OQRTJerR5EFltuH4VGx1vGb+3Lg02ONY+Q7iTQoCGDkcYycaYppgp1QGqffDw0CbCAOugS9paZOI/P+SAd1IKm3Pb8JNK5NnYLqMlQMYJlKiNT4BMtuv2O9olkW9Gkg/Fodf8oU8SyGhPw+Yr9o8Ox5dblw9dhTctQOxyaFS9dI+TZF9+9pSPhb5amr5eiSei3H5wSqdSmW75YeEQQrA/JeWKYbrLxVMq0Yr5Zc5p5SclExLrdCd7YtuEeL344Uw+oPSbxM35HLJ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c393b2-e5ed-4a16-20bb-08d59daf8878
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:01.6318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
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
index d8c274d39ddb..eab04eca95a3 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -362,7 +362,6 @@ error_io:
 	ret =3D -EIO;
 error:
 	mutex_unlock(&f->sem);
-	jffs2_do_clear_inode(c, f);
 	iget_failed(inode);
 	return ERR_PTR(ret);
 }
--=20
2.15.1
