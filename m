Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523239404-2-7413558434187833410
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
    1523239404; b=PM2ZMI1METxZ7vi58PN21ovP+4xXIIbYuel8p7KoqaQkgwN7qI
    rnhmCxmFwu5UFjXrYedqtaYK6QVI2IBzzq49BitN5RPoaY6T323EEd/AWgHMp6wa
    dDAyoQQ+Ioh6QqjqAciIiiaeltwhbzFOR/tyThjF7/GHyZi4zZQWY3iYFmk4LhmF
    XVpf5/kSbbwKKssqJp26Ou/RQsiXzBh5GH8hZU1A0xZg+qwn8n9cYTY2VKAldrbH
    G0q8sAsFaw4IRC/YK8c/OnuS5XbRTMSmSA4rhpJBGlc0jmgqG95z5wbZ97e7UHHm
    ujzcptxopTfmyg838dBWDLmO2Z3QKnaKT8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239404; bh=chK/GDQ5H5
    lgT7Sh/zjDRAHgc1FhPKzC44AColOL8wI=; b=WDPCJ0/mwz5KlMO9H6+az6fwFR
    JteqTmnSr5XrnFqoklK/ouytkz0gJbAciK3XIa1b2ZNIDO1dvAFoYYfim1cfI22+
    Pg6+IoykVDYH0csMU0C8bVvF8SpH5FA+w7mY27Mo1CYEPTBif26oLbZj+E8isux/
    CZfbrBrGLTIZjY4vm7fpKVAXZux4e54N+FqJk+dWtIc0JzVo+nDERTqN3cCjCpF7
    SaOYoJjV2d9pW0vh0QXI3y61JlOK4VSP1GrsZ/NPdrvnjyTIlOWNZLw7p06Rc0Dg
    zrbdREZFa/X8SWDpy8pXcMW2IriWCszuXTq/+/WhJn0i0ymgm2zwd0WvvGeA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eIHDm6w5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eIHDm6w5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOgJZ89iqN95+mcazEs8d8nDV5slU85v+MzT61X60f88I8Q/nhUvscPe5YSgq03hxx5h2AMVymxjMuokCkI8wdp3azZRVL7EOaRTt/T0t5CiLa9kR5cD
    wr35zWRvrx2YjoLo8v6q8AYTsDNaQB6DNlT8iXwkKMo4u1u3QOTmkCKhLLJfJo3cJPUyXfyosQ9yVi8xEF6AE4v64FXFSjIPwPdbjac36SPYsnOABYpbmReA
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=drOt6m5kAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=Pq0pMy69QBtLMtXIX8YA:9 a=QMsb0lPmdDPq8qyo:21 a=n8dhMv4HDF6JOCgY:21
    a=wPNLvfGTeEIA:10 a=RMMjzBEyIzXRtoq5n5K6:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755659AbeDICDU (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:03:20 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:32931
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756396AbeDIAcE (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:04 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 189/293] fs/dcache: init in_lookup_hashtable
Thread-Topic: [PATCH AUTOSEL for 4.9 189/293] fs/dcache: init
 in_lookup_hashtable
Thread-Index: AQHTz5k/+vngwjYSsUmQTUWpfVr8Rw==
Date: Mon, 9 Apr 2018 00:25:22 +0000
Message-ID: <20180409002239.163177-189-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1126;7:vNnTXPpHaYaRg1J/NOlQB3HP9PWnSLYmG9eimwzpifrQ7FnlclpL00n8We2HUUOsHRDGBKZTT9/X7rBUlDj04CfAjPlbU4rIBcj/kVaUTxanlCuEjewFvcXHHCq1JcEKQZSJiAvaFh4KGBFoPZpD8E7wjRSz2hUXpEm6C1Q48hWCDLWKSK2OJPedS60m2BPlV0OqVpoENDFEenxUCZELb2w1wOixGiJYJSbd5DLLELmAx1hwD2ek+ff2gUik7dow;20:NG4F6MTR4O3ipWnQHAkgWchyOnfum1Y4IL21CyI/ohZQW109fMWX2J2rWYZz7vJNtpP9RK4cvaHqq0ZwhOdT8qoiGki0oldr1V9S7SfVPhVYnNh50ey8qs4QZXlvHYw1PJKtOcqzhUnqd1bTfHedi5YVh3QI8EXFFI2/uV1G694=
X-MS-Office365-Filtering-Correlation-Id: 59c91645-56c6-46c4-11f2-08d59db14ecf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1126;
x-ms-traffictypediagnostic: DM5PR2101MB1126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1126DF297D9E3D87B2924C37FBBF0@DM5PR2101MB1126.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1126;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1126;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(2616005)(476003)(81156014)(8676002)(81166006)(3846002)(486006)(2900100001)(6436002)(186003)(478600001)(72206003)(110136005)(54906003)(2906002)(86612001)(6666003)(2501003)(26005)(10090500001)(102836004)(6512007)(6116002)(14454004)(5250100002)(10290500003)(1076002)(575784001)(446003)(3280700002)(3660700001)(11346002)(8936002)(25786009)(6506007)(106356001)(4326008)(107886003)(36756003)(105586002)(53936002)(86362001)(66066001)(6486002)(99286004)(5660300001)(316002)(22452003)(305945005)(76176011)(97736004)(68736007)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1126;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: f31yKSMs49UVUX3YsoP7i/iXUK5bb25jzdAmBhTzU+WIYwE2ge5D300wCSD5PQD6ojvH9Co6uPPcLqyHJ+w8H2AJ2bdqCqIJ3aaQ+6+tt8ri7n2zVu3fcmQCkxAwuO+FO2bRYjMC06P9XFicc9IQbGB78w7k8mWjuKElCYMSUBqVR66QwGkINbfpJB7sPYEhJe5ZMOfDdT50ts6zSKYa71nDQonV9DWgy8jL3vxWC2QpNuPDDbevipiNVVee3QS/0woMmxk9W4mI5JhNrL519VelvoKjbbKVAQRNgOZ7IY1xgBVyKWIdp+okqY8pzJ2VtdMO2gvbmhNEsH6bfSgiAT0W54aCum9dZaj4S92TnNsKOUcOlb1C2Oe0JKU/odl8wmwzAJocuZzHWU5f1bmATUFi3n5/oT6kD3+uimZ2d54=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c91645-56c6-46c4-11f2-08d59db14ecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:22.0970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1126
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 6916363f3083837ed5adb3df2dd90d6b97017dff ]

in_lookup_hashtable was introduced in commit 94bdd655caba ("parallel
lookups machinery, part 3") and never initialized but since it is in
the data it is all zeros. But we need this for -RT.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/dcache.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index c0c7fa8224ba..4df3d2300c7b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3637,6 +3637,11 @@ EXPORT_SYMBOL(d_genocide);
=20
 void __init vfs_caches_init_early(void)
 {
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(in_lookup_hashtable); i++)
+		INIT_HLIST_BL_HEAD(&in_lookup_hashtable[i]);
+
 	dcache_init_early();
 	inode_init_early();
 }
--=20
2.15.1
