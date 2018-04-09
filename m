Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236321-2-12732439216637578895
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
    1523236320; b=e2hUFsxzQE2truM7iMcqBzsHkALB6vEMwM7XjpBIgF12KDph4Y
    D/tpMkWT15ultoPtQ5mUXgushsY36Dt6OoMjB/Xdve8lwTgHCOQEuZPlBgLLbTj9
    vcqVRaGinD5wOECkkhB6hPZK+9WjfVyyQCNvAnpLwQq7UAUyFxpzlPCj/bhuE7jP
    fPirmZFzLStWr6JmA6fGCGgoqIUjz2aEJmImopj59xSsZatebRT8i6lhTxZGdLQ7
    L9PpE6JvE8I1BImLtAG18zSMDzFi6Hzu4cotV/JDst9xRjN2i7VetCs9bEZNPUbs
    AdbNdu3nYHXXf3R7ZLOCKJcQlvj0rQF8WeeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236320; bh=/wGUSpKW1b
    VhUr2s8pSeV/cIDbDASVu0OYV4NUE+a5w=; b=qLjTXgz+B2b5If79lORM1xWzVV
    oJIBmvJzjB0vbs2aWu8eqcjiQgZO9TO7eJL5teohoswb37ZHRowFNfpALDdtYK4i
    v3vkOMToohXW9o6U7CE3FehOCA4cQmX6IKBmZE25SOQrAMMQcl8ey4tVQO9YAYHp
    IYhJYAbVn9VjO9p7Ft1oTBDJ5Nb72gr9xjA0jPQ/YT7txrEEPGMF0LAfKTUTmbPl
    vqUSZ9DnBnEheNzjqEV5x3u3qdXXr2d9bMqoQlC9JsC59DNk2gL0JYYdv2gCKtGZ
    vT6Mw1JNAf44en+aC59AzP/nstkkIsDafZtFXi+LS0q4gv/AUnTit84lwrOA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ged6yqIi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ged6yqIi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI/Z7Ppg88yTdhd0aDZc3GnDXzzDDTzWJDHIU/maR7Jq3esj5oxPR+QbWibuLv1yVY/hmozBiV62klfeABaVMcxOTh0hkMnkWkEUzH0n41TR//iQJiDp
    zhsmU0ke0dk9uIyO5Z1OYeHd2cybsooSKAVfv5CFLfR007reSXv5EEwyz+1dZm8J0i432fBEtafM9qIsvqZqFBmiJTvsSFyH3mX7JshAMRgQOtfXE8G0SvAO
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=drOt6m5kAAAA:8 a=yMhMjlubAAAA:8
    a=Hd4EjHANT1J2BtSiHa8A:9 a=fmYMAI2vvugCTNh3:21 a=OrL8zmcmXUHjIvll:21
    a=wPNLvfGTeEIA:10 a=RMMjzBEyIzXRtoq5n5K6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754080AbeDIBLb (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:11:31 -0400
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:26752
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754975AbeDIAim (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jake Daryll Obina <jake.obina@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 131/162] jffs2: Fix use-after-free bug in
 jffs2_iget()'s error handling path
Thread-Topic: [PATCH AUTOSEL for 4.4 131/162] jffs2: Fix use-after-free bug in
 jffs2_iget()'s error handling path
Thread-Index: AQHTz5nRhoI6CcHV6EqYqBWnx5flEA==
Date: Mon, 9 Apr 2018 00:29:27 +0000
Message-ID: <20180409002738.163941-131-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:yAwcHB6jsr0Zf5hkTfnox3enLaGMhS2B8047bbIpeAY8el7FmiFZ1VG03Q6oFNdMTzy9P0zqMnkzcO9CjD+kjbsCye60wl+J7yUXbmzcQUSlAk6BppPX6zcNXD4QhH0x2dbrpnBpNcQf2hC6Yy4Qm8IcPdmGnpJyw52wh+Y68BEf6jXREuGj16UTsZ79SRDEbRpc0kXraFp+ubQnn4gnvmAYUgXTEv3cMKHNCBvUYNGvjmjjhj3VAc/MQGtfatLb;20:/MlR3QTvZg4DAWS7o8KumwL6lTSxW+0bbGd/4WlEiYt/PSNDR/FDWKzAPA9MtOGkfIVs7gAypJ/OuYrHqe44Z8ZIDhJjXwqlMAYQmGJaCQH0TYpnmxt2FRwHFCnfxaeN0iuj9czcfmQj8eUr7GRG3EBVwk6OVpF1QWgjtA7LQdM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76f93cf5-254c-4916-f297-08d59db23b5e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10955C18BCA2EDE58642AD81FBBF0@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(26005)(10090500001)(476003)(105586002)(39060400002)(86362001)(107886003)(11346002)(446003)(2616005)(102836004)(76176011)(6512007)(97736004)(575784001)(36756003)(6666003)(6506007)(8676002)(59450400001)(99286004)(4326008)(10290500003)(81156014)(86612001)(81166006)(186003)(486006)(2900100001)(106356001)(1076002)(72206003)(478600001)(305945005)(8936002)(25786009)(3660700001)(7736002)(68736007)(66066001)(110136005)(316002)(54906003)(3280700002)(2906002)(3846002)(6116002)(6436002)(53936002)(6486002)(22452003)(2501003)(5250100002)(14454004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 3WFYEzcr/8SAmV/cY2VpalHLJ1ozEp3qEyNFZLQ7Z4bOIjB1DNMXc1HVuEMgD5q+k9p2zHgTf2zLWrUDkGJp6DOvNdSvVwFOswO02bT1OGK41WdWnBhAcpG68C76Ej9/O0y2S9xUKOkcEwuChj027ImdWoz9hepCG1YVgCoO2xwUsNPfT+x+qkCRBTZWsoqVxc45i9J7dVdEtP+knvewFsT1wLPP2jZ41O0XZnWhFPFyJJvI/hCAgO6JhEKhkaQDq7qlvalC+7UwuBOia6brwfOsaR7EiQ5TleOGsegvl1/xE1vpiI2uQ7PFgz3ZcRXc1reAYm5z8speffM6ZPKURfbKuiIFSMs0kOdYlrqRrDj6wPjFhJanfp5P76a6rEHxQK+xz3GNF7DEZpkuA3W+gPeQHXJUQHG3BnYcrTd8JmM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f93cf5-254c-4916-f297-08d59db23b5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:27.5837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
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
index 2caf1682036d..85e2594fe95c 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -361,7 +361,6 @@ error_io:
 	ret =3D -EIO;
 error:
 	mutex_unlock(&f->sem);
-	jffs2_do_clear_inode(c, f);
 	iget_failed(inode);
 	return ERR_PTR(ret);
 }
--=20
2.15.1
