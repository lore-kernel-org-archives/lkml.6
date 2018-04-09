Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234699-2-8260138844260884479
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
    1523234699; b=l1D7b0uPR99Odlvm8rWbBqVMZAIuUGaughQj00nQZCdUlf3wRj
    MikoVwNAiXIxVM9w2n6N1unGPTzE8lRAxPUmAGgK/OEVBW6wr375WBlBGwnTxvZe
    Fdu68VD6qCLbFE/bcdYm53ea8LvuiL/QAxONky+3ipOo4vsxxmS4yu6vfpXv6d0q
    AtM0Dqvx9rv8TeGOxnSz0606DmK+LV9ICVLJROwewi/4jb34/3nVUQcRkomaDxvb
    pGc2ZWGw9+mUauLvh8+JOyz7BvlvnssuLunAl571oEXKeFNfB/8KbEdRinCWAVsZ
    rOh4bUOkUKsetmKhIRgb9aR5AoR1mfsCtCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234699; bh=zH94un+VNg
    Vny/dPJNHn5+tXuQ7bTYfsn94Ptnp39bg=; b=Dh3ric9iEGRiviPoJp24LUu3ys
    N9nBjM+xmFRn9qLLCdWSrthU4nEsFTb0YkK44Vs6HfGHf2e9/88IKY8j2mw57tXW
    8KmS5XkOoI7Kx/TC3gtg2HIzAAOy/r6IUM7X7A+GmjsKPXyym0SEqCqL9UoCclFg
    xCC4e4/rEa988nRS5XVxjhevuuAj1x+CueBZVigtz3Tk7IWYGIHZJGF4XlLeEVe6
    JBiC+N9GoCJXIn84mNu1j8em65hTpRhUbkU6naovbrO3o1FwoqKBVGIjw81y6ygr
    P2p+UNaZhXEp4KR4XYgZ0e+OyNNctSBW8RIiZ6yfKkC3IJba8XWz2RmR3B1A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n1Qp8dLO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n1Qp8dLO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBk4LdalQI3FInKIADX0o4fLyLRYdJvA6bS+pdGaONIDRNPvtwYGlIfbPTBXuI+2OFDLnMvn3nER+yFM5OKWMl/R55EC9EUt4IwIDLNQr+6OAGWxM8CM
    K/0YnX3/kG6Ym7oqe9+MBvXl+5mFfgKIQIhNvP4Ua/ZbBOVHGICs0+RzmLGa+sO4OYVqKhPbSIy4/a2IUYGFGqffkAd3eKU2i6z/B4YzPKpqDudPTjUzM6R0
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=tHz9FfFoAAAA:8 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8
    a=yMhMjlubAAAA:8 a=43XURk6w0g5GeypUxR4A:9 a=wPNLvfGTeEIA:10
    a=Z52K5TbU17EcDgFyT5Ki:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753955AbeDIAoa (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:44:30 -0400
Received: from mail-cys01nam02on0130.outbound.protection.outlook.com ([104.47.37.130]:52092
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756781AbeDIAmd (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ross Lagerwall <ross.lagerwall@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 093/101] xen/grant-table: Use put_page
 instead of free_page
Thread-Topic: [PATCH AUTOSEL for 3.18 093/101] xen/grant-table: Use put_page
 instead of free_page
Thread-Index: AQHTz5uMKYqDCtMqB0SwefBqbLoBRw==
Date: Mon, 9 Apr 2018 00:41:50 +0000
Message-ID: <20180409004042.164920-43-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:rEk6zs+BWlq3ctGdHINWAGtUIfWXNUiQAN0blecwxk9yBAbjGY+9zWyUG4gduP4myflPasayI5pkDrzHL1J30HOU9P3cgg81GcfJpNBvOgZsG84TE15zSe45XqrJ6wPP3ePFyu6gWYNJhbK0M32jD3r8toMJ/TAhF2PvcuE6hNh9KmMTZlaNHm4Kz5RJygcRKtFs1hl0OnubbUcEi+699LmGnqexhCwcXlRjUP3bSRCi0xAY5vOVvGUloG/WSxCg;20:fPn/j9O8pVstZsbSwiGO1S6kFfluyhhKymF2zk8wQR7Q0rCTjZIE8LbQg7HQv6VmwZWCuJZpgY79zi/PP9v537i72SXdvy8bYe4risM6aDkeaY4MWv995N13GYbngJ4Gkw1YkOV1EJxPOXbC8s43MKDuVy3B1OkjAc1KtBvP/Zs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ffff4e6-3595-45f1-7834-08d59db2c328
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10628D1A2E0EC77D4890FE46FBBF0@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(70601490899591)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(199004)(189003)(68736007)(6512007)(316002)(486006)(6486002)(6666003)(54906003)(5660300001)(110136005)(8666007)(102836004)(14454004)(99286004)(36756003)(86612001)(72206003)(105586002)(97736004)(106356001)(2906002)(22452003)(1076002)(2900100001)(10090500001)(6436002)(3660700001)(6116002)(3846002)(305945005)(59450400001)(86362001)(66066001)(10290500003)(3280700002)(5250100002)(25786009)(8676002)(81166006)(8936002)(7736002)(478600001)(476003)(81156014)(26005)(4326008)(186003)(2501003)(107886003)(6506007)(2616005)(76176011)(11346002)(446003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: NIuRqKidwIGL27gnLvfdbwo0V1Jx24EtdcO3cmofz0eVm+9baRKWdm0Qg9OQCXkvaNY6MErnFMyFBeBWE5pZ+AjJJeS5svHAN2+3HLT8OQgQHincmXQ1qp+ymdA/EeJ0gaydt512i8IjgHl8ho7HjrijSJZcNMtxQC07gyUQnTm2fmc83lf3nDyEBtLmCnuTzFIzM6qjrmDZWNuRUtkuy4K+mnUtAI2Ua48CaBm2jhpKFVoUFUZ/PyteUzJrxOP2zqL8wK3kgeUS4HHnsVErGuebcNbOR9s+S5Iz86bUp0mJ5w3AemkxU1vg2kkhDjkm168HvG/mh2f8GpJvWKnGkBLjAoVJWf7BOfuUE9br9x/1GAe8wPkPp754ggBN+oUPKF83ZzmfQ2tYG1qp+ncr6mw1N8lXOJM8RoUqvKEYjaM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffff4e6-3595-45f1-7834-08d59db2c328
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:50.2522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit 3ac7292a25db1c607a50752055a18aba32ac2176 ]

The page given to gnttab_end_foreign_access() to free could be a
compound page so use put_page() instead of free_page() since it can
handle both compound and single pages correctly.

This bug was discovered when migrating a Xen VM with several VIFs and
CONFIG_DEBUG_VM enabled. It hits a BUG usually after fewer than 10
iterations. All netfront devices disconnect from the backend during a
suspend/resume and this will call gnttab_end_foreign_access() if a
netfront queue has an outstanding skb. The mismatch between calling
get_page() and free_page() on a compound page causes a reference
counting error which is detected when DEBUG_VM is enabled.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/xen/grant-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 7786291ba229..abdb152236c1 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -322,7 +322,7 @@ static void gnttab_handle_deferred(unsigned long unused=
)
 			if (entry->page) {
 				pr_debug("freeing g.e. %#x (pfn %#lx)\n",
 					 entry->ref, page_to_pfn(entry->page));
-				__free_page(entry->page);
+				put_page(entry->page);
 			} else
 				pr_info("freeing g.e. %#x\n", entry->ref);
 			kfree(entry);
@@ -378,7 +378,7 @@ void gnttab_end_foreign_access(grant_ref_t ref, int rea=
donly,
 	if (gnttab_end_foreign_access_ref(ref, readonly)) {
 		put_free_entry(ref);
 		if (page !=3D 0)
-			free_page(page);
+			put_page(virt_to_page(page));
 	} else
 		gnttab_add_deferred(ref, readonly,
 				    page ? virt_to_page(page) : NULL);
--=20
2.15.1
