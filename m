Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238331-2-6488157044656746912
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
    1523238330; b=HY/495to5tAKmZa2TnhpBClGRlfObSvr/024jHErK3bwPvb9gl
    5I7/zXFURLDUlnj+ZB4hRfDWfrTM04yMsesfCDRiZGoF9dCEJl3ECWjni+YBGze3
    wnI9Hj04v52qsYjlMViNzq4LrvrQNSZXGdyuVJPRG6TkpIrpL3LrSVSCqLhXm8SU
    ow1KfB5U0+rxi9UrtUg+wdBdVPEIOsVxRK4DUJd2A0wZNaqc/nNBE2BSs6N9MxWW
    kdEYq0p3Kul/MhJKcMQsTCCtr2s6YBHl96P0rbZjYsrgp/TFvT/ptlpGISp4U9BA
    E9gZGMourKkzAnhMGQRP58fd8LNrgYnj1yqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238330; bh=k7m8b19C0Q
    xHzoetaytuXTgPHc0pKo1QKH8VATBsyZE=; b=fYeAgqCY/0Zk2fT/EfQsjk/0tO
    Zlye8QfzckZnVvPkNGy0xgDR6ifK3nBGqKIfdwvbdNKKyF8tUGCcDNn3Cdpj+OWz
    tmvFO75XldSr+PvLcnVCrx2sLCbGNiHFMBJzrJyT1/ENyqsVkbCqG8De9AtAgVeV
    uxGQ5yUE3mLvDCe8oK4Cc226DZk/haKKz4CHF/qpOWm+F+hL1OMClwlal/MkFozw
    NEJU6qzDS0VkPpRiyEe523yQGCULcu0yqNAGNRP9vDIyqGko+Lk5eK6Y5/yVE1qi
    h4iGz6gGhpKb6NCKLvIzkJCi7uajW3QYZv927zXu8B1v7u0V2RyZREOgG94g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=exL8QHRb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=exL8QHRb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB8ElpwbHV7ZXImufZkv0lhlIX0sUDNglY7cWXRSjvkr+CA+AdL1DydUEYvTl9vYwVe2tfZFAP0OikEoUn8vzic/slR7jbogUNOg+wD/Are+vTWTqDAJ
    OKgLirsZ7NEJ5fUv04OwGsvG6YMvEZk5SluYheztRiBj/Bil7eM4HDSXI+jGv4nAlr5QECFlBNr3ytqByRtNFwGJhAOnYdvZBH8g4he5ObjaunkTH/Ern4oi
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=tHz9FfFoAAAA:8 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8
    a=yMhMjlubAAAA:8 a=43XURk6w0g5GeypUxR4A:9 a=wPNLvfGTeEIA:10
    a=Z52K5TbU17EcDgFyT5Ki:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932501AbeDIBpA (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:45:00 -0400
Received: from mail-bl2nam02on0134.outbound.protection.outlook.com ([104.47.38.134]:51004
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932494AbeDIAen (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:43 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ross Lagerwall <ross.lagerwall@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 276/293] xen/grant-table: Use put_page instead
 of free_page
Thread-Topic: [PATCH AUTOSEL for 4.9 276/293] xen/grant-table: Use put_page
 instead of free_page
Thread-Index: AQHTz5lopQEofBPJi0WQFAgxU9u0Wg==
Date: Mon, 9 Apr 2018 00:26:31 +0000
Message-ID: <20180409002239.163177-276-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:RsxtLSM5eTlMoNsyw1SnRzOHR2xeboIuQ2B7epIgCEUKfJ3cI8G9YmXjmm8V71iPLrXZAqmLAHy3NGHDylpYnjhjDd4QP2U9b5Zx4LZt34IdkJXJd6aaaT36Ex475tqV+gUXoOSnMt0z+7mZsGPs0nt8RnPjCs9P+Bn0W54WSFYnj1vjhjLdH9hB7z9UBfXoudCAYkctYPkYjhnMipR35Q9At6+XUAm9MZjxL/vdX8MQ7oncrTmXn7LELk4nOkJg;20:iuydZ5e4VTF9csqkG57gxwB/dbltRjL5DqaZPAoicJYxOGDj81j8HX0JifYSKKtXOBbi83pFSqdMW5prpjVMLbWoilwA7nsdfdx3HhwF57rlDyrKAQGUXV7EUQg3ulb0jWk55lEY0Mhymo1S9iRuo59cKBXBmoHKlInOHOZAM+M=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 04431fdc-ff6a-4bb2-3eef-08d59db1ad61
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984E9484D7B9809C6C60DB7FBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(70601490899591)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(39860400002)(366004)(39380400002)(346002)(376002)(199004)(189003)(26005)(99286004)(2906002)(14454004)(97736004)(59450400001)(8676002)(81156014)(81166006)(8936002)(6512007)(106356001)(76176011)(186003)(3280700002)(10090500001)(36756003)(6506007)(66066001)(3660700001)(72206003)(478600001)(6666003)(53936002)(2900100001)(105586002)(102836004)(2501003)(110136005)(54906003)(5250100002)(486006)(1076002)(25786009)(6116002)(6436002)(11346002)(6486002)(22452003)(4326008)(446003)(7736002)(86362001)(305945005)(2616005)(476003)(8666007)(68736007)(3846002)(86612001)(5660300001)(10290500003)(107886003)(316002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Hd60k0iFkyC2HVM9PnASXxNZdgW8161za50kwsyFD3xAaC/U/RZVdop36CjdmQjzKWfLv0N/7fjxmQt+FJzoFcjkooKS9KxE59SSvTm63DGPNzLZkWoNriYBBcvBtC+LhG1tJzQbn9tlCcMgF+JllV+9KBNxUaZKs61qakLESxoj5MmoExnFqesbxCe2pvOTM76O+b8apO2q+C0g0UKszubK+FSbSR5CnOdzRPnPqj3FKLN4Nyt1a3jBurZf0jho+hy7ibnJU0lwj6b/4T3rYfgu5xRXDXTsngzNpus8gMbRhdhpx6yGK+HLMiH+ZY+WO9CTa7bfAauRS2jY1wFAV7M9y/nHGck3zQLCyb09kGxqIjakia9C+IIRkEcy9ctGdOEv7jCtv01IaoBCZ1m2Fh5XS3+H0JaPjRtosrx29rw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04431fdc-ff6a-4bb2-3eef-08d59db1ad61
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:31.5352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
index bb36b1e1dbcc..775d4195966c 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -327,7 +327,7 @@ static void gnttab_handle_deferred(unsigned long unused=
)
 			if (entry->page) {
 				pr_debug("freeing g.e. %#x (pfn %#lx)\n",
 					 entry->ref, page_to_pfn(entry->page));
-				__free_page(entry->page);
+				put_page(entry->page);
 			} else
 				pr_info("freeing g.e. %#x\n", entry->ref);
 			kfree(entry);
@@ -383,7 +383,7 @@ void gnttab_end_foreign_access(grant_ref_t ref, int rea=
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
