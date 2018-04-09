Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233270-2-6054389699235213086
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
    1523233270; b=bXhK/sEgiJGjnwFpp2GG2IBDsLcgHs/GMl3GB9zOcUBICO38vJ
    blmtSrpLNhlP6gTEngmTf8oJx/jE0zGSt1u8fFDl0qJ3tS/b23jwTwzidkLD6kTs
    LSDWW8333c1m4F2ze+RPCxIE4fQMM2LKtkPnSqhJeWrQODZwZdIAbINM0/Wr1x9f
    OrqX0hA//K7uE2k99X7spPGx4zXf9W854PQrZrqQyl5cLi5vdofZNSSnCfvSw1UN
    dipSVzlLBlJRbaJ1I/+PZB//XW+/dufnr1eY1dZa52qMkaqzz2nRBl8dCD68BU/i
    hFjB7bqC0fSVTza65uhPjn5YhEUBHocWabIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233270; bh=6CeWI2K36M
    5/lckCn8QGqLvw6feOqKYCCl6qFu0QKx0=; b=JaWkWm9Ydb5OcqgXzalfZFCQ0l
    TBSCHyBV20vU2jL39dvTLDItG6MqSQrcfvfvtMZTG7o8CGoahQ1WjcyHYvvYm6AZ
    hZVy1ePHX4c/B6tLDNhcbImJxgi73ElX8I7d6LwqBC/flZ5ZasbPQDyTHVWwhzbD
    K6XYkvqd+GJ3hWuQb93feKrr8e5NN9SB61JZgE54y95k3hF/kgmuPRfhlRiXorTg
    MlcV/fN+myWHcflF9HYhPCO/iTAVHg/AxJJlz4453uKeepvPd/Ezfig6wspHKNjN
    KnsIsEPv2y1tyAh8/LuneL62NIsKYRIjsHg6LXp2bZ/MZPy6jzWmQ0b5Zb1w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PiW8jfU0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PiW8jfU0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHSA5MvDhRDHHcH2kqO2hR8CfvVIwEJThYS4ql3LM6x1uduQW2BX+PYYFDttcBW2HUl/jyXIjPPYzyre2FIBjLf0lb6058V2HYcTG9fQMBZ5bdq+QgFU
    Qs6StQWGTfPC0CnbipSbSU2cR+cKOSVICgM4SAjWZSZeQyVVUub/2JHWS67zsoXVQMW4PiWOCXMEXoKu4nADTqUsZUsWlnvEKJ4andjAbKKvEFagnRBm6eTE
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=tHz9FfFoAAAA:8 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8
    a=yMhMjlubAAAA:8 a=43XURk6w0g5GeypUxR4A:9 a=wPNLvfGTeEIA:10
    a=Z52K5TbU17EcDgFyT5Ki:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754362AbeDIAVG (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:21:06 -0400
Received: from mail-sn1nam01on0114.outbound.protection.outlook.com ([104.47.32.114]:12752
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753254AbeDIAVE (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:04 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ross Lagerwall <ross.lagerwall@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 153/189] xen/grant-table: Use put_page
 instead of free_page
Thread-Topic: [PATCH AUTOSEL for 4.15 153/189] xen/grant-table: Use put_page
 instead of free_page
Thread-Index: AQHTz5hWoeqpVbPRW0SZFZgCngoGtA==
Date: Mon, 9 Apr 2018 00:18:51 +0000
Message-ID: <20180409001637.162453-153-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:Meq0wbrSstCimBszwP+R9PBVHnG6oE0693Fokcsm9x+HZoPV1tFvWkRPurmh/w6JndTbdgWxs1CQ5/gZ0eyyNf82+x1h5shIVWV2Qq9bcc1ICXo4LTvzBvvwwgSxQd9mItBe42qrmX2IkQxZ+NuKY09ankpZFBR7XEkB+1yqliKfuwpbfqX4rV2GMkxRqG9esE1+CQrB9iTTejNZOh1Yj/wKcbZx4yvGvJgGYxqHiPLaUhZCz4Gj81kMIZrcNO9F;20:uCTtiQjDGCgkXCcLHcc1aNE1LuWnQgVG2YnOhGIdlDgTzGWzZmDWUOyg/zG0MAY4qb6SN/59SJEsbcHbxYEaHws+EDJfyeBVHIJpLNiReGYukvtpGlexYqEMrpiR2WO7bg+HT/o4QDPTEA6U9npTOx0Z/8HwVtkTzH46oUwpxdw=
X-MS-Office365-Filtering-Correlation-Id: 9d6c2a98-ccf4-4b58-4c8e-08d59dafc477
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB092078C1876101C51E2A8A80FBBF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(70601490899591)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(25786009)(76176011)(2900100001)(36756003)(6506007)(2906002)(99286004)(86612001)(6486002)(102836004)(305945005)(1076002)(7736002)(97736004)(2616005)(446003)(11346002)(476003)(486006)(26005)(6666003)(6512007)(4326008)(107886003)(5660300001)(478600001)(6436002)(105586002)(10290500003)(5250100002)(22452003)(316002)(8666007)(186003)(8676002)(110136005)(81166006)(54906003)(6116002)(8936002)(72206003)(53936002)(2501003)(3846002)(68736007)(14454004)(81156014)(10090500001)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: X+DC1BYbyN1P1PCoOFtbbIBwWvi/sRyXY6WvEZQNaqNbuZXEeCQdB/CnMMkCV0VWr8ZM0UhXJltX/IHSFi/QAfdlMtwnriOHiG4oksVqVb7ZzAFyseNPGe2Mx7pHNjVSqixDFFSgkO4uAFvj0RpAzq/u0iWtPM0v9FkhOgPE/vqMRMfyVGWJ0vXEZtje9TdzIOdYo5IDnjk8EU6iyUUrllCI/XHlC+raVkHnW1raRoJ7gbiiAsI+Z03uaeGqHwxb9SNKwG3zOd3SGs8Mne8QmkDiBJYpmgWMa1tfJYwLWYlWNfhqx7XMu5AAbPMQ+1rvVGMufIbx3TpiH6rei1TtJkNp0L/nOkUzuKrqiQ+yfrzQJZSodwF5dXOniuFfFQuqPv9ZoxJRrXqfBIakg0lWwK1L5LRhjk25n8pJchIzwS0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6c2a98-ccf4-4b58-4c8e-08d59dafc477
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:51.5965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
index f45114fd8e1e..27be107d6480 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -382,7 +382,7 @@ static void gnttab_handle_deferred(struct timer_list *u=
nused)
 			if (entry->page) {
 				pr_debug("freeing g.e. %#x (pfn %#lx)\n",
 					 entry->ref, page_to_pfn(entry->page));
-				__free_page(entry->page);
+				put_page(entry->page);
 			} else
 				pr_info("freeing g.e. %#x\n", entry->ref);
 			kfree(entry);
@@ -438,7 +438,7 @@ void gnttab_end_foreign_access(grant_ref_t ref, int rea=
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
