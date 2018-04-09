Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241403-2-18376950034089064658
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES encafr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241403; b=uYj3lGO1zzXNvwxKVvTNgt41IIw7etH6rMgdO+ypDLjS4g+uUT
    7ACFoK3WGVB9j+nZT+gthAAFQf98EHxvoibBgO0g9AHoQ4hzQEEGZevE9K7f1gpk
    INgKM19QffGS6N0ie2QPDCvwWmvSDjA25HED+P8ERio/TnLdtYPD2M1JC+nV9Nod
    LXB7dMRfupZuxENIY2lPrSpCBUDWD7ghMGGeEG9VpZ6bB0cMpfPXOP9qFgyYYcMZ
    O5hANKXj/bh0IQxJIZEXmRSNVb/DiFyJnNymQkgsiH6y6tS3s6KGPlH1OShphYyC
    R5zOMjehJsS5j4TAAb8oHDeKA8Wc7fGAki9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241403; bh=VdUd2XY2T0
    aQvw46UQ8JAV6yUop2kU0fF1VkqsLLYXo=; b=ScyE6vRwomXf+SowvyqGPDDEy3
    FNz4Vofc7JFQunVQsJUCMiuJJiLg5tUP+M4SUrR5cFnaXr2/XAFpE7iS/TqgBLea
    5hyd6y/1/+N0YLeA32HG9Rad5HBM5tnF4z31eNr1v7ufe2mSzadakApL6d1PqRrQ
    kW3kzxjgKpPnr6MUAwScvYunbnBx+bPYF3nr7hfpq8qsKCx9ygBmCqBv0fM3oTAq
    u//qSdh5AUuRaioEgyquCvQ2jdfqRDhOLoxzNxxKEwoBGM9Aun5IRAXrqFL/JXEF
    SjFo89pIz2CxuggvM1pYiK+tpxEFvREsOJ2isvBmUFbqDJMhM51RuQFOj94Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=W+B62njv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=W+B62njv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFK6iMmjOGn80xNQ9IHBKYv7DoGLC4AES5I3Z5//mwjL3E5ty9tydLqBRS3Oa6IiPUHES8bRhPRb6w3LJVkzSV/4BMg6SQO1amSg2FT1JndhF7+/Yu8H
    pLuBVqFIeOP5rFzo+Korr+mBOVluLqDjIdc46oO01jBBtbEVHxAuxMNvG7nTa7SbQ1k06xMiym/d68NcjkmaHdaVTvv5kkxVKBIg1R5JzNaLYOZkEskJKRVa
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CDq0vqnqAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=mVir9Wizfw9NSaUnJ1kA:9 a=wPNLvfGTeEIA:10 a=Xn7iXEen_xUG9zZOO_Hb:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755627AbeDIA1f (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:27:35 -0400
Received: from mail-cys01nam02on0104.outbound.protection.outlook.com ([104.47.37.104]:11355
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753174AbeDIA1c (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:32 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 045/293] vxlan: dont migrate permanent fdb
 entries during learn
Thread-Topic: [PATCH AUTOSEL for 4.9 045/293] vxlan: dont migrate permanent
 fdb entries during learn
Thread-Index: AQHTz5j5cKeZ0Bl+DkyhYOR5uZdvMw==
Date: Mon, 9 Apr 2018 00:23:25 +0000
Message-ID: <20180409002239.163177-45-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:fZbtLVWliKqwfYxVthoPm+IQNSn18m/gMlhUW3h60IYZfO1WsBLNlxSJzo56wkuYMfCNxhP4OiF5P1TxFIjDqFgBgqkG/S2uPHWt82bJXv2fyDEGQuqqSsfnLlhUYBGCV7lPWhElHd5ZLwcpwi4A1LpGxYFI2bSFcUfVzGxk5Wj/FfnooGP6qwUYgU3COsWVtRQoNuwkStRZzxPHbenQQdZEy/yEcI2muhgG7oV4NmoWTbQSEIzIqzSs5flqNib/;20:6zPnMAQ1xEQdU7myrzgK3IQOt1yWnG1Ov1/pExTo0G/52fgqqV7mMRIbvx+cl2MTgJ9nP7uOriXdJWNAM5gATJoHT97fTXkb3wzRAX1elahaH/4+RquH9C2rvlkpPo9PQ2/9eVuP/Nunjc1VNi2jdUr/ksGX4uw52Cg8jSW9N40=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 15ed74c7-16c4-4c23-d1a3-08d59db0ab78
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10318815E085FE919AD5E800FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(192303002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: PApipaMCDRJhUxBJM6ys+U/+d+XJesPQ/CJ1R56EBak93XHwUtmh+fbcmAsm/1kSRTnVsxj4zf8T8t868PnxeKjitBc5K64g8UlOdpmI26HnMvB0sYcLV1mjGa5h4v2vs3KtXBGMcVHOeTo45g/xd8UtJ/C8gFmHTM4HWfCJqdaPi5WZHIx+gBSeLMRS50zffbCV6XyzO5x37q/l1hdGM5gSJkoNMFU/o38HA4Q3ju+U0etEID5EbAjV/ksdbdalN67O9csYXf8tfhsLIfea/QjfvvATnO+2OVUN05lHs5CCKXXD5+RCaQaWdFqToYv0hrMFJBCyxQv0YcSQjc42fh8ZvtcxJLsneetrqlTu2ML8YTyJ/1TGCH7v69FBGhytFfEVtNkUXhQkX3Z8lLtb6NQZSDplt+UR2S/YkdZHNsE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ed74c7-16c4-4c23-d1a3-08d59db0ab78
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:25.0967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Roopa Prabhu <roopa@cumulusnetworks.com>

[ Upstream commit e0090a9e979de5202c7d16c635dea2f005221073 ]

This patch fixes vxlan_snoop to not move permanent fdb entries
on learn events. This is consistent with the bridge fdb
handling of permanent entries.

Fixes: 26a41ae60438 ("vxlan: only migrate dynamic FDB entries")
Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/vxlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 0f5dfb8a545d..28afdf22b88f 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -930,7 +930,7 @@ static bool vxlan_snoop(struct net_device *dev,
 			return false;
=20
 		/* Don't migrate static entries, drop packets */
-		if (f->state & NUD_NOARP)
+		if (f->state & (NUD_PERMANENT | NUD_NOARP))
 			return true;
=20
 		if (net_ratelimit())
--=20
2.15.1
