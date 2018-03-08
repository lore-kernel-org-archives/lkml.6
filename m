Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491574-2-3764728806289618791
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
    t=1520491573; b=UNHNDsOAoQXKkEsYTGy7BPzFYC3iiUY3ZcnE2w6oH177JZZ
    wFdx3ZkQD/sAWI6cgPqdHPhg+epIYBMPIM1PD+Kas2yQcfHOjzYceJywIRUWpjaX
    f1/hbE3OjrDIqyT+jLpXj/A8jU2A+iOiV2NJJin+4J+MWHctE9QOdTYhgIsFoWyT
    IBsaNx8QZ1S34evJbg7o1La1U9FUuINrlwfa6eADJg3gi7itwlfQmJR6qnaRnlT5
    v4CPx2q5HM5y2UVyZJ3MCWpQleSAWH9Vy4zBD7nCKSoOauqfKEew3ZKIUE12JrGF
    pBz/aYu9Q2O6/s95DYA1gWWfaHI18DX7p7RpNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491573; bh=EbtkPQ
    Hni5OTrpj0OXDg373OJxOd1PMC75BU7HbkZLY=; b=W+5IV2Fst3bqV25fkRgdrU
    sVVq28sh1bsmnrZf+rbalCOhr3B6UE3PtPVtGNJb20npGAqhYLONt/LshfKYz0WV
    +e/JKGBVnftiK+4EGClvAd5O5IR0+j+Bmm9ltBkDmrMZLZHRYMwOwxP2LVFa1wpD
    0DCJ6tX4gGZ4YWPmPn4O10EiTsPeKq0UF4X5MaHk2GKIdG6KPzb5MB+OoUpw7GAV
    Ef8ReY6jqx/yFmUL5YdZ+IfZHwIwLym2+lwurRBzjQL10NEp2b8UHILr/DecOZki
    01rk+mfCe4R2kqKx247UQM4dYgL69dLJ005YEkfKsc+1zj9uUILt77SbDC11KjzQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cY9M/Nh4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cY9M/Nh4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755238AbeCHGpv (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:45:51 -0500
Received: from mail-by2nam03on0101.outbound.protection.outlook.com ([104.47.42.101]:17968
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965134AbeCHE6Y (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:24 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Liu, Changcheng" <changcheng.liu@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 29/67] mmc: block: fix logical error to avoid
 memory leak
Thread-Topic: [PATCH AUTOSEL for 4.14 29/67] mmc: block: fix logical error to
 avoid memory leak
Thread-Index: AQHTtpn+QIfN8D6xnkS4R0+IqOgxiA==
Date: Thu, 8 Mar 2018 04:57:44 +0000
Message-ID: <20180308045641.7814-29-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0808;7:6ont5woyEFcSRHKdQJ9PG8QKbSq2fMhReOjV+ARb1977JrbO4nnDb3e8FQkhhUIBmbg5jQn65sqiPF6rZyOVLJWi+2TbHso8YftMq3iBYzCE3QODeexkE/yLCs2nKgdlapLbCX10S3AjSP/gkPo2U2tKh/RdR/Pdg1M+ucVVpYNtc4cIFuSF5XcoO/8aaffIS+Wka7BV/v3xM0TMNjc0PMxUY6zxIH5OhUwzh+lYKMEXMSUFZ/eQuMHg7MT1qBVx;20:BXlrtkZRYdqhAbYWX/nfvpm6rxnO9aWQuipvxPFRj6N+3LNuadPrWVO3/3n9QERIiAfKCkORsEjn5cpFKl9A6M5lfcCPk86xkG2ZFbBxF3FxwagxzNn55K3l5DCzAd8E+S2yT65ANtqW7RjvluEXD/LqUY7XgkNlPVvV9CJoCIg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e59d6c8a-0823-4ceb-a207-08d584b13548
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0808;
x-ms-traffictypediagnostic: DM5PR2101MB0808:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0808314FDC26E726C15B6E37FBDF0@DM5PR2101MB0808.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0808;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0808;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(22452003)(99286004)(76176011)(2906002)(105586002)(3846002)(86612001)(478600001)(72206003)(14454004)(2900100001)(8676002)(102836004)(68736007)(5660300001)(316002)(6116002)(54906003)(26005)(6506007)(59450400001)(1076002)(86362001)(36756003)(186003)(10090500001)(110136005)(106356001)(4326008)(6512007)(6486002)(7736002)(5250100002)(3280700002)(3660700001)(2501003)(6666003)(81166006)(2950100002)(305945005)(53936002)(107886003)(8936002)(6436002)(81156014)(66066001)(25786009)(10290500003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0808;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: ETP2WxGPytrBhAhyfIN9zfW4M7WXjl4YUiSUk+EgQ2K6E8jZ7rzkiamco69+HnynnQ1+3WCfcdtdq7N45Il0wZbhpUceroCzYIUw00EWyn2Po0PhYqcuwgD2GrdVFzOCxNwuwiexJmaqpKxtXDq+MbSvrbJkADC4dQuTkgOYGETg1Jr7ezIwCsBd5zo1BTNJERVeS39jh2uPpMFB58gSLd1Bgseg16/pqkSGfBeBg6KCnETCei7GsFOS4G5mpdGUNxboDrLoc+YuuatauH9SxLz98AMQ8a80ojN/u8L/P0HKz6uzcb+t/5JjfFy167eOMBNFivSGnexjH9WEScnocg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59d6c8a-0823-4ceb-a207-08d584b13548
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:44.2857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0808
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Liu, Changcheng" <changcheng.liu@intel.com>

[ Upstream commit 0be55579a127916ebe39db2a74d906a2dfceed42 ]

If the MMC_DRV_OP_GET_EXT_CSD request completes successfully, then
ext_csd must be freed, but in one case it was not. Fix that.

Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mmc/core/block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ccb516f18d72..9c6f2ce3b710 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2387,6 +2387,7 @@ static int mmc_ext_csd_open(struct inode *inode, stru=
ct file *filp)
=20
 	if (n !=3D EXT_CSD_STR_LEN) {
 		err =3D -EINVAL;
+		kfree(ext_csd);
 		goto out_free;
 	}
=20
--=20
2.14.1
