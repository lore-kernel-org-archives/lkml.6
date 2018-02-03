Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682031-5-15202558551128948714
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682031; b=QmpliHr0o4wI+y0pBKxwHAZvtE1UtyNbz6GyXsyPSNEc07e
    +u9Z9q6Fe/KpyxIub00Av9IYJItmwYwHm1WZHjZAhrD2q1RRGz5NmFqNi1qCKix/
    5/geY8xRWL4e2pC5hh4alAay0G8UgCJlpZ7EYZp1tCJqQWqDQlsuofW6/G5n4d1n
    ii9fF8B/o10iTaavNFK+akUhfVSECqH+a58mMtqPOYvM94197A/ESTPC9Q2mMNup
    ucF8a8MWZaAjWZdhmQQkmX8TgOWXLcC0xugtWjozIuBpr6m8cOpKJsLpHWK8mBI5
    kru8kIixGkSIjMY4Ic0ErCQ1PfopfWz6zL38SWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682031; bh=Qd5pZi
    75lLozFE87IeYbu6cpDkHOxzai8NExGnXnLNg=; b=h69byooE2oR9MJVqE6xs1A
    RI+1M4PKXNpvWE0mFWuNGarsXeFnqCJn9zgiPZ7PIS7xveFV6SSprtNt9rrzhv6h
    5+7EjCzD3gtuK0lBd6GlLSnYlIqhOTvJ7qm+X3XMFobQDWhLMUi+HZq70DlrHYcE
    CS6iA4Yvw87KvQuPPizthdboKBVdK+RyT9Kwt0Dzo2UDEBLVLMiAHrKuU0lkgMVN
    1uCO69WU6NVkCEfAx244MEYqnIVyNTKeGXJCbKvwH4DZRUz6vwz2ma9q2gstuohq
    wIL1LAkoZ34sbfnSyjDiCp/NBjTumeYdSwYac2BfESavBiByArPjXWazOFyNT1AA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ID6OK/mE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ID6OK/mE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752716AbeBCSUX (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:20:23 -0500
Received: from mail-co1nam03on0108.outbound.protection.outlook.com ([104.47.40.108]:59967
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753482AbeBCSGm (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:42 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 23/32] mac80211: mesh: drop frames appearing
 to be from us
Thread-Topic: [PATCH AUTOSEL for 4.4 23/32] mac80211: mesh: drop frames
 appearing to be from us
Thread-Index: AQHTnRlzMJOB2JnzqEqTCESBAFQUAA==
Date: Sat, 3 Feb 2018 18:04:36 +0000
Message-ID: <20180203180413.7438-23-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1009;7:duDRT2FrPirg6HfEjdlj94p1/5Hn3GvddlFJpuXUrMX5VkTtlXqBDptwZ6r+tOZKwRZkCRtUZkz1Q8HxL3CVFthd61ucWLmf46k27HHXoPdkXG0cBP8G3AryBK9kyATyyG7fcW0TMf8YUc1M7d6TXEdJmxNwp7DemqVCIv22hzzBuRkNR9Gw1G83ZVaX5IguqMP/hU0nGixAuK7ReNdiLDaWAA+FGnTdEevzj87xUMmvCj4fqjcdIgqOqUGpbuUG
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5261f062-2b77-4de9-4375-08d56b30c5ee
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1009;
x-ms-traffictypediagnostic: BL0PR2101MB1009:
x-microsoft-antispam-prvs: <BL0PR2101MB100949EF6C54B64EB7A74727FBF80@BL0PR2101MB1009.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1009;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1009;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(52314003)(6346003)(1076002)(26005)(107886003)(186003)(25786009)(6116002)(3846002)(3660700001)(105586002)(2501003)(10290500003)(99286004)(2906002)(3280700002)(5250100002)(4326008)(66066001)(36756003)(81166006)(81156014)(97736004)(8676002)(8936002)(54906003)(110136005)(72206003)(6666003)(86612001)(22452003)(53936002)(478600001)(68736007)(5660300001)(76176011)(6486002)(316002)(6506007)(102836004)(6436002)(2900100001)(14454004)(305945005)(106356001)(10090500001)(86362001)(6512007)(2950100002)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1009;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: lke+/6LCupGypzUQP3M+umQ6uOiUeb+LmVrkA9aAFaaOeIN/Oaf01TPvsANl4V6fZz8OeSPunCIxFTSi+ESGOA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5261f062-2b77-4de9-4375-08d56b30c5ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:36.5339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1009
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 736a80bbfda709fb3631f5f62056f250a38e5804 ]

If there are multiple mesh stations with the same MAC address,
they will both get confused and start throwing warnings.

Obviously in this case nothing can actually work anyway, so just
drop frames that look like they're from ourselves early on.

Reported-by: Gui Iribarren <gui@altermundi.net>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 3bcabc2ba4a6..f8406c37fc1d 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3367,6 +3367,8 @@ static bool ieee80211_accept_frame(struct ieee80211_r=
x_data *rx)
 		}
 		return true;
 	case NL80211_IFTYPE_MESH_POINT:
+		if (ether_addr_equal(sdata->vif.addr, hdr->addr2))
+			return false;
 		if (multicast)
 			return true;
 		return ether_addr_equal(sdata->vif.addr, hdr->addr1);
--=20
2.11.0
