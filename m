Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523246179-2-5420343961164776261
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_SBL 1.623,
  URIBL_SBL_A 0.1, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246179; b=P7sb7n/Lx+m+N+ncd6HclgfOJG/6xn7caGSvVD6O7EH5wE1q0h
    +Y3RUflA5MADRMKp1BJFfdebYwW1xYef50I1O4iVbnP2KAWCkOIw8VsIv5I18FvT
    oqMClFggOVcVJrP66cJBa7wW2BqDsm/46eWany8cbjnP1R96gGXRNB6gTJSMwxnC
    YfO7uvYJCi/Av0Ae3jBN86JUWLvxhM7hmVUxuGUmE8PYiqCDaSCC3vPUovzA/rui
    y0Pjx6s25KF38e8r7SzZ+L8O8XRTnP+oMyhN0S5Vwzo/1XwS34dV9c94HWP76TJE
    NJpjw9Lu1fl74zS8ubGYZ6oovKlunqNYVeNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246179; bh=jxX0CcdG6P
    6dpr3NzEAnDzvk4pjayEDc3M12Q/+6mhw=; b=Zx9VcO9ntjputgtcZVwcU9gha6
    RxW6Er780aeFLZuUrUjpJCO7qtGkvUcedMhE3WrDOLi3rK8nJfBhRh6TgPHTKzF5
    fxIATrBypcs2sZ5Q1HGu+hLb9o3fg0FpKuaqRqXH6mgVwU0sy84S0ZEwDOHpo2K1
    eD505rzQlE7SUCkWtqSq3QrQwhz+QprbErkvfCQA/PPdbcI8Z8NDkeJV0gJg2tgm
    gu04tOR3v7C1Vn5PC0tmooFNadXyeH7yFCGys4hTrUq2xGn2Ev4ZWTxz/JBqf+vs
    VZGqezLJsRj3OGB+uuu+AOBFlzK/7jdWM1G+gghguF5aIyiQgIWi1+PLeSCQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jNG2S2c9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jNG2S2c9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOhsM4lbAQ/eMBRzSYopUvSxJov25oRuJaylEP2gv133YxVzyDbJ34scp9CI+KdDWEx1FwL3UoPzqHFhminEqlO/U0xV+1Z/xwbB2X3nIHUy/4CHniS3
    yLeUdp8JcpmIJs/H1zAF8OPTg61ig7TAD1NB3rdwjDfIHIqvxFMzTCOW4zZRfC8IMjFU81Ljwgq18Fa9xzMT+mUKsMfFjNmwReLNxNsGplm5Eat6lJ+vkPsr
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=Q-0LPAu1DzJBLX4319oA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbeDID4Q (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:56:16 -0400
Received: from mail-by2nam01on0126.outbound.protection.outlook.com ([104.47.34.126]:59343
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753778AbeDIASs (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Eryu Guan <eguan@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 084/189] blk-mq-debugfs: don't allow write on
 attributes with seq_operations set
Thread-Topic: [PATCH AUTOSEL for 4.15 084/189] blk-mq-debugfs: don't allow
 write on attributes with seq_operations set
Thread-Index: AQHTz5gykjFfMh+GGUiXOF+6xTfgsA==
Date: Mon, 9 Apr 2018 00:17:51 +0000
Message-ID: <20180409001637.162453-84-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1128;7:qSf76zbajB2J8tEjC9BlWmYzJE8B+KQPGpa4R6m+Uk2YFvM72A7Z/p7MFntqWz5vj1uKP0fjKKjJ6gZa1mfGhIXXxgpPEnHKGf43v5CHiUDdl+W6gLkJCFFwQfkvVClVte+O/H/ghviWabHH8v3KhiQhU7zKBKCmCQZi6ys5Ijhv64eRgSJWTY57UEYZiiqVVb+EGWHHsUwOGVz0dgnVFKM9AWzhIdr8U2RpCWZwC7UjwdYCLw6mgJfSALC7xnUR;20:gSQZPqm7bj4DapYsQzj7qLqCEKDxRu8tUl2yaqafmOtVNyFyjvTT67sVnmo2flHKyF1TWOFs0xo8jijjBafm07ilrodbilR+l+2q37qOPdAfV1cXlKle5LZpJlhZBMuBD60a/BbMriahiXrPL26E0qg/zCDxkg/Wd010T9yYdQQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 499fca3a-4961-4017-b248-08d59daf725e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1128FA0F47B88A921C632C36FBBF0@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1128;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1128;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(2900100001)(25786009)(36756003)(6506007)(76176011)(2906002)(6486002)(86612001)(99286004)(102836004)(1076002)(7736002)(575784001)(97736004)(2616005)(446003)(486006)(11346002)(476003)(26005)(305945005)(6666003)(6512007)(4326008)(107886003)(478600001)(6436002)(5660300001)(10290500003)(5250100002)(22452003)(316002)(105586002)(186003)(8676002)(110136005)(54906003)(72206003)(53936002)(2501003)(68736007)(14454004)(6116002)(8936002)(3846002)(81156014)(10090500001)(106356001)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1128;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ZTQ8qqY+rl8vYNc6CDBjXtoKofWSCg6CWukm+z7t8vG+/Inb9ZqLdFc4cPFkR+TD2PZbBxLYxmUBCUmd19oFhicE99ks5Oz4VkCrSLmI0vGHxOYSp85Mr6accbzfJWdRMJydFs2VHxtmjzohXluwMzH+6+OVRHN52Z7UtsXTGcfAM/dqO+39KIuui66ZfbxcdwzCMxe31GjErsTye0Rtx4N0HNE/q4hc+HEHbrfu4mgAg0sfotYM8zTgZblA66VO2Vlqyq5fWw+I+GPpVkt3vO3npH9Gl47w1G69C3ZmT90/bfXpI3jQDkTaa+WbTa7Tssne182A8OQ35WRBS/QN+of6batEnAdFeWr4hfZr7l7mexRerV3S/KSYsc+1rjrIFvSPIB55Oqezxri1P18XkKG+TBR4/iCXIB/LmCx2Lgs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499fca3a-4961-4017-b248-08d59daf725e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:51.7419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Eryu Guan <eguan@redhat.com>

[ Upstream commit 6b136a24b05c81a24e0b648a4bd938bcd0c4f69e ]

Attributes that only implement .seq_ops are read-only, any write to
them should be rejected. But currently kernel would crash when
writing to such debugfs entries, e.g.

chmod +w /sys/kernel/debug/block/<dev>/requeue_list
echo 0 > /sys/kernel/debug/block/<dev>/requeue_list
chmod -w /sys/kernel/debug/block/<dev>/requeue_list

Fix it by returning -EPERM in blk_mq_debugfs_write() when writing to
such attributes.

Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/blk-mq-debugfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b56a4f35720d..54bd8c31b822 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -703,7 +703,11 @@ static ssize_t blk_mq_debugfs_write(struct file *file,=
 const char __user *buf,
 	const struct blk_mq_debugfs_attr *attr =3D m->private;
 	void *data =3D d_inode(file->f_path.dentry->d_parent)->i_private;
=20
-	if (!attr->write)
+	/*
+	 * Attributes that only implement .seq_ops are read-only and 'attr' is
+	 * the same with 'data' in this case.
+	 */
+	if (attr =3D=3D data || !attr->write)
 		return -EPERM;
=20
 	return attr->write(data, buf, count, ppos);
--=20
2.15.1
