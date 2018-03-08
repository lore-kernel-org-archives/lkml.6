Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489597-2-15205147383994443028
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
    t=1520489597; b=g5gduEJXlYy8ro3PPhJHjehup+8mZstbO9dxUGrsmEavprM
    Jv1VdlOvoCdNNXw/XZNMaMFutBMuikSElbVcHdvfIvu0wWMsha/hG0xN01hp3ixx
    8cn8qpJNqj/lXAzcz3/9I0A792S0+DNrvf9gZZdMPIOC6oFfTgQ+nkalZu0HCCTS
    UQoY76TUXU97ogoB0Ebie/Gk52e9KdblfUcfhdvPDd6GvAR6ZkEzH61kJtU2e8Q+
    sUdiARNH+NX/I5QIiT+wIBhg09z8naI8JOOlZXVvHTWfotefiV3mCywGzSet+fbX
    Y6zoQ83VUVkMBYHqcVz/rm5DnuHIL3/EJREPqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489597; bh=C/G5Xu
    9H6HIIoQjdQY6EOsyuYpxp76hZRcRiabUL3As=; b=PJKvWoNU/8QiYp6ncw4T/A
    hxt7IQTQ+qc1JAou12W0434ELI1503VjiotdK08yGSZ2L6HXbk8Xa9rXQ0iCq9Vz
    UFcPqEEq92+CprNwmbzkT4hMsj+GcunxtjjFCKhhjWkaqcw8m46PSDpT/5OtUkzR
    0tfMFHkr0SNfjCl0Q6brC67URpKMMaCkNt3RzvvZ2PECvd6xuck8LbC4t5zZ9pLL
    ztyojKUeMzzKOjXfBC/WMGWvWvbugoS4iUnvV78D4+HJHT9Arqo+rfLZwAGtLhbb
    8sTDLEq5h0+puLWEIdpcUtTVUodcq4TWQe4MAeOwiTLOYIDQDCKC5qjqoJ4QRZrQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XSvz2pPj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XSvz2pPj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965391AbeCHGLz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:11:55 -0500
Received: from mail-dm3nam03on0116.outbound.protection.outlook.com ([104.47.41.116]:61650
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965387AbeCHFBf (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:35 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Liping Zhang <zlpnobody@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 077/190] netfilter: nf_ct_helper: permit
 cthelpers with different names via nfnetlink
Thread-Topic: [PATCH AUTOSEL for 4.9 077/190] netfilter: nf_ct_helper: permit
 cthelpers with different names via nfnetlink
Thread-Index: AQHTtpo7juX59naky0W39YnqrXVl6A==
Date: Thu, 8 Mar 2018 04:59:25 +0000
Message-ID: <20180308045810.8041-77-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:4kYgbodNRJ4nWllpBhCU9i7Yt95ZR7hE1UvyVJMTinHD8j27NEqTZWpkOMoYN30t/pdvCSsrgV0mzKD7NF5IcgVNRCn/CV04XM9nCVe7n91EcGEjABNfsHMUPrw5Cs40dUgvIz3JN+fJSzdqodGExtfEmxwzyJlUhiyjIqXQ0+XdxeH1fNhZeiqBqNamWOBIPZshUQw+tBk2RkdtYmTvAQRlCZLOG+pk60YNHYcZaLsbFaprlpZd6xlnTqGH1LpY;20:M9zaLjRZ7dXH/MoKL/yAjHahO14yOw+k3fk8E2Oqz6Am/uQKw+zEj51ghSuQizC1GjTRZgpwVew2v3sEsV62kd+kfyZ+Bnq8wecrDZ5uSDZLC1v5gbJ/LkrqR2rzy+jz8pXeTQrwwXYSI7fiQ2ymF3Mc+mZpv/lGzp5qvTEmavQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27801368-6d58-49a5-a442-08d584b1a5cd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0901EC9941422D8175E436A9FBDF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(346002)(396003)(189003)(199004)(2501003)(5250100002)(99286004)(10290500003)(53936002)(14454004)(72206003)(76176011)(97736004)(6512007)(106356001)(86362001)(10090500001)(7736002)(6436002)(8936002)(6486002)(36756003)(110136005)(305945005)(54906003)(81166006)(105586002)(59450400001)(2900100001)(66066001)(6116002)(22452003)(3846002)(1076002)(478600001)(3660700001)(102836004)(81156014)(39060400002)(6506007)(107886003)(8676002)(25786009)(68736007)(4326008)(3280700002)(2906002)(86612001)(2950100002)(26005)(316002)(5660300001)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: dRcICBhk4nx8Pha/so8XMih2+7jJz6cu9LKaccampZ3KbkIOsbQspdR/N5dUgpveJmI4B0Ub96voQEvs4LesWn6KP5J4FPDzQCO1K5atMIrPsjGEP/JwI3v0vTD5HrrGCTheH/buM9mg1RI6rtNNelYllUMtkz7L74ZHfBph1rWQyFVxf7aCC8ZNkb0WetJ8zioqf8YINwDq5isgz4hxFOnlrYt0NLLEQu/z3P4nNUxAwNbMTbQbQpLDLsvmnu9HLL9p+T3NhTPjawe+BMYyR0E0by65eAeLcgnGyeY7bVo1oszrsP2zztctBi5IVsEXpuYCxwfPsqQlTab+MVM+yg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27801368-6d58-49a5-a442-08d584b1a5cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:25.8772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Liping Zhang <zlpnobody@gmail.com>

[ Upstream commit 66e5a6b18bd09d0431e97cd3c162e76c5c2aebba ]

cthelpers added via nfnetlink may have the same tuple, i.e. except for
the l3proto and l4proto, other fields are all zero. So even with the
different names, we will also fail to add them:
  # nfct helper add ssdp inet udp
  # nfct helper add tftp inet udp
  nfct v1.4.3: netlink error: File exists

So in order to avoid unpredictable behaviour, we should:
1. cthelpers can be selected by nft ct helper obj or xt_CT target, so
report error if duplicated { name, l3proto, l4proto } tuple exist.
2. cthelpers can be selected by nf_ct_tuple_src_mask_cmp when
nf_ct_auto_assign_helper is enabled, so also report error if duplicated
{ l3proto, l4proto, src-port } tuple exist.

Also note, if the cthelper is added from userspace, then the src-port will
always be zero, it's invalid for nf_ct_auto_assign_helper, so there's no
need to check the second point listed above.

Fixes: 893e093c786c ("netfilter: nf_ct_helper: bail out on duplicated helpe=
rs")
Signed-off-by: Liping Zhang <zlpnobody@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/netfilter/nf_conntrack_helper.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntra=
ck_helper.c
index 6dc44d9b4190..92e69af41656 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -379,17 +379,33 @@ int nf_conntrack_helper_register(struct nf_conntrack_=
helper *me)
 	struct nf_conntrack_tuple_mask mask =3D { .src.u.all =3D htons(0xFFFF) };
 	unsigned int h =3D helper_hash(&me->tuple);
 	struct nf_conntrack_helper *cur;
-	int ret =3D 0;
+	int ret =3D 0, i;
=20
 	BUG_ON(me->expect_policy =3D=3D NULL);
 	BUG_ON(me->expect_class_max >=3D NF_CT_MAX_EXPECT_CLASSES);
 	BUG_ON(strlen(me->name) > NF_CT_HELPER_NAME_LEN - 1);
=20
 	mutex_lock(&nf_ct_helper_mutex);
-	hlist_for_each_entry(cur, &nf_ct_helper_hash[h], hnode) {
-		if (nf_ct_tuple_src_mask_cmp(&cur->tuple, &me->tuple, &mask)) {
-			ret =3D -EEXIST;
-			goto out;
+	for (i =3D 0; i < nf_ct_helper_hsize; i++) {
+		hlist_for_each_entry(cur, &nf_ct_helper_hash[i], hnode) {
+			if (!strcmp(cur->name, me->name) &&
+			    (cur->tuple.src.l3num =3D=3D NFPROTO_UNSPEC ||
+			     cur->tuple.src.l3num =3D=3D me->tuple.src.l3num) &&
+			    cur->tuple.dst.protonum =3D=3D me->tuple.dst.protonum) {
+				ret =3D -EEXIST;
+				goto out;
+			}
+		}
+	}
+
+	/* avoid unpredictable behaviour for auto_assign_helper */
+	if (!(me->flags & NF_CT_HELPER_F_USERSPACE)) {
+		hlist_for_each_entry(cur, &nf_ct_helper_hash[h], hnode) {
+			if (nf_ct_tuple_src_mask_cmp(&cur->tuple, &me->tuple,
+						     &mask)) {
+				ret =3D -EEXIST;
+				goto out;
+			}
 		}
 	}
 	hlist_add_head_rcu(&me->hnode, &nf_ct_helper_hash[h]);
--=20
2.14.1
