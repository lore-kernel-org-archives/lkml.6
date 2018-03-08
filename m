Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488742-2-3301766915766949512
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
    t=1520488741; b=uhRv1wcLL8N6m+/182Z4ui6GY2TXkLBwvtJLCFoolbfzN4G
    D765S9L62Qi6zOI6lnQmlZstNG9lB/fdU2KrwFtZfD860PEl+zqguYawYvwXd6+z
    MXbHpxFve4VA5XWNycvQYf5AUL/8UHhuTYpKJH4vBMq9RopUWKY/zFo7590m15ep
    bW7fUnArE10B8O75+gmDfbJ/+ZYkLKj6/Hk0wnoiZLInhobkhnswoyHvGF/iVi7C
    kFKK66CSwod+bDBf0pJDtfwYoiE9dPrBW9Q89YIehccodt+a17uIbk6+WlX6EadH
    4X5BaEciVQdM7YB+97UDB7IzTCFiglP0l0u5oYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488741; bh=JOKEDs
    bW4lDdrWMW64nhicgX49buk8L9pSQh1U6vHI0=; b=XdMQVP3+oUCZQwDBWrAhZA
    lBfdRYG25ywqdMCP7a+3S4dbzwCUF+OjjZV4JZEUF3iL9DQ5OPDNRLTKDJx9pnrt
    5fHmDXmx4VDreaIG46RXPD06wgkauiMHplcF7nnF/kyLgVeLWnWL01K4Q1F7d7L5
    /Hk0mXSEBSbk+znIHNXvwHBZzNSfJLKJNKTPeQ/aekZ1+5dNB/gKFx+BNTiV/X84
    5B79qVAHU2iCj+AQ1D8pM6LGznQtbnWm00SqE9C51wc0X4057iOYvf9cPwP1T1cU
    USBwoteK+s4w+2FR64nBO893hK3/GR5eZ3VuneGT5cSYWXeYKpNiy+MAaI3snxKA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OU3iLuKM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OU3iLuKM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966161AbeCHF6T (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:58:19 -0500
Received: from mail-co1nam03on0114.outbound.protection.outlook.com ([104.47.40.114]:38578
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966003AbeCHFD0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:26 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Chen Gong <gong.chen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 146/190] mm: hwpoison: call shake_page() after
 try_to_unmap() for mlocked page
Thread-Topic: [PATCH AUTOSEL for 4.9 146/190] mm: hwpoison: call shake_page()
 after try_to_unmap() for mlocked page
Thread-Index: AQHTtppNYwgd3jYsq0qe6Nt64HSbxA==
Date: Thu, 8 Mar 2018 04:59:56 +0000
Message-ID: <20180308045810.8041-146-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;20:BBfhYrvjqnTu/tWVzjsmwN8jGbBfYUkv5eqsTxLASiA6j1P1mKrME3YH8au2eKWYbnChatovFIixb6jeNIz/XvSqm3/R9K+K9a6ineB1lZac2WaF/vXYlMRmxv1moFD4H9LOFpmkuoYtdfLlPqN0WZYXGm6GTJpAbbRwjmdEr70=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d093c02-1b43-4eeb-d70e-08d584b1ea1b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902AF2B3F757111D45140FDFBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(6666003)(2950100002)(106356001)(10090500001)(575784001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(966005)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(59450400001)(2900100001)(102836004)(76176011)(6306002)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: h9RAPTeX6ttcV5uUrwo+GoclKPPN1Uyf6X1JjGVcuSi+HuG8j0VsvYHiYLLJf1tDd2MPwPSL907gpzVN0/WXwCoUyqHMznG4FguEMLFFck0p/xPKLdcpyiMOO0UFSNWdAPpJuaRBOuv8JJAPG6H59OW8uuCYi2JZ7jIBDQQuBWuruHnx+rT9Bc368xYyUUfUc4IqcxPFN2FeJtZE+SxloZ+FsLDa7zuCc0reQz6pn5e1YiGKUgbs06JA29KZsjG20kzqvPGfJaRlKzTfSX+Ddk4ErQi/6O5yTUlFL43t7S3FdrlRlS96CbKc5CKVcJQ5Hdca/ymAIxyAH/bS8lYC6g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d093c02-1b43-4eeb-d70e-08d584b1ea1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:56.4588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

[ Upstream commit 286c469a988fbaf68e3a97ddf1e6c245c1446968 ]

Memory error handler calls try_to_unmap() for error pages in various
states.  If the error page is a mlocked page, error handling could fail
with "still referenced by 1 users" message.  This is because the page is
linked to and stays in lru cache after the following call chain.

  try_to_unmap_one
    page_remove_rmap
      clear_page_mlock
        putback_lru_page
          lru_cache_add

memory_failure() calls shake_page() to hanlde the similar issue, but
current code doesn't cover because shake_page() is called only before
try_to_unmap().  So this patches adds shake_page().

Fixes: 23a003bfd23ea9ea0b7756b920e51f64b284b468 ("mm/madvise: pass return c=
ode of memory_failure() to userspace")
Link: http://lkml.kernel.org/r/20170417055948.GM31394@yexl-desktop
Link: http://lkml.kernel.org/r/1493197841-23986-3-git-send-email-n-horiguch=
i@ah.jp.nec.com
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Xiaolong Ye <xiaolong.ye@intel.com>
Cc: Chen Gong <gong.chen@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 mm/memory-failure.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5aa71a82ca73..851efb004857 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -921,6 +921,7 @@ static int hwpoison_user_mappings(struct page *p, unsig=
ned long pfn,
 	int ret;
 	int kill =3D 1, forcekill;
 	struct page *hpage =3D *hpagep;
+	bool mlocked =3D PageMlocked(hpage);
=20
 	/*
 	 * Here we are interested only in user-mapped pages, so skip any
@@ -984,6 +985,13 @@ static int hwpoison_user_mappings(struct page *p, unsi=
gned long pfn,
 		pr_err("Memory failure: %#lx: failed to unmap page (mapcount=3D%d)\n",
 		       pfn, page_mapcount(hpage));
=20
+	/*
+	 * try_to_unmap() might put mlocked page in lru cache, so call
+	 * shake_page() again to ensure that it's flushed.
+	 */
+	if (mlocked)
+		shake_page(hpage, 0);
+
 	/*
 	 * Now that the dirty bit has been propagated to the
 	 * struct page and all unmaps done we can decide if
--=20
2.14.1
