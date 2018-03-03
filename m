Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120597-2-10287722902091757578
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120596; b=YtbzcZbsest/dAl8ZiLv5bBxyZuJ1p6IRGRZ0avrUxzir36
    HFEpvHGxfiZ5H9W5nI8dGEcoBiCzhcsuzBWC77/7UXjyWzVR3JGXPEdxlTOvTe5K
    mmeBPsYMSpFXVGwQKX/ukiRNT10MPer0h0S0MhPLXMYrcjpQrQpPmAdMXvTaWJqg
    Za/o/Y0goJEVSEfDMn6B2AxFrqMuI8WVPrNSuDSkXkhuWW/g2P4f0IjYz665uCTl
    RgKE/l5Yh60zdd0z2wx9J8YPjQffcgjoGCwUKktgztakz0Tj6JHCLhpZPjkKJ6Mm
    HgTx3FGsX/eWnbzkCk71/HhG7nzY7QMrVll80bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120596; bh=Drirjz
    M4/1VGyTFBEqdZpNEfEgoG6H6oQqsLICGqPFk=; b=rGhBpSNNmh0dSrLbzaVILQ
    y6OtrZMxGVoQpAYAyQdctii2lT6Fb/YfwVJx+MfzUI6/4xYI8cZddG1w59X0ZP1Y
    ywjlCxJ5MaI9ozFkWeTVyVFGeOi7ekGwjW/TJ6valpzrY1W6ar5D7TB7QYslN0/C
    kc/boOSv85Oh7evr7FOf8IyL9OObb+q1EAIht3klvwlHhYalKncdauN36DxkIZVc
    YZgZmBVsA2fsjQ5+M6QouCfh6NdDkskxZ3rfJcEV0AUbEeyn8QjTMA02OnAEkc+X
    gbihFfZIIFLNZoTNxRWV4hX/6QCwygDp/RcHFBsFTkaMKnG5NJVdBQDHTpe18u6A
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FXRkC9a9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FXRkC9a9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933878AbeCCXm5 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:42:57 -0500
Received: from mail-by2nam03on0119.outbound.protection.outlook.com ([104.47.42.119]:12016
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933741AbeCCWer (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:47 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nate Watterson <nwatters@codeaurora.org>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 123/219] iommu/iova: Fix underflow bug in
 __alloc_and_insert_iova_range
Thread-Topic: [PATCH AUTOSEL for 4.9 123/219] iommu/iova: Fix underflow bug in
 __alloc_and_insert_iova_range
Thread-Index: AQHTsz8L08V1DDph70mUi7bdTnlA/Q==
Date: Sat, 3 Mar 2018 22:29:07 +0000
Message-ID: <20180303222716.26640-123-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1068;7:ZE0FVx3eT4i9cgMwEDBGY7hu+0RWGbXNZ3Mgk0e0VQc5SxGIo1zv/3Y+QLRAS3kuvI9ZJ7CgSZhrJMdB7IQUED2erOBGvvE+ZBsiePNSGmKC6Ryd//R6ogfen6+JpQZI8jL6vogO5ns142zQjTnqiuxdYjNE5NlZ2r5hsNLrDiMB1XnTUxKexpcjbQOJL6ySgkELNY5a8pKI4JKHsgH95hZHlBlifDnBt8bb1pWSAotkrH7Orh9h+CLMTSYEA+lz
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49f274b3-148b-4e36-83c2-08d58156f578
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1068;
x-ms-traffictypediagnostic: MW2PR2101MB1068:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10689A55C9F55AF874548D1CFBC40@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1068;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1068;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(199004)(189003)(102836004)(59450400001)(6506007)(26005)(66066001)(4326008)(1076002)(105586002)(10290500003)(478600001)(72206003)(86612001)(14454004)(186003)(2906002)(2501003)(305945005)(7736002)(36756003)(3660700001)(5250100002)(25786009)(2950100002)(5660300001)(3846002)(2900100001)(3280700002)(6116002)(106356001)(22452003)(97736004)(316002)(575784001)(81166006)(10090500001)(81156014)(8936002)(8676002)(76176011)(6436002)(110136005)(53936002)(6486002)(54906003)(6512007)(86362001)(107886003)(68736007)(99286004)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: QHIparo8U0ymA174eJeqVZLMEE/AB5imH1oeFC/TQpPJbdK9DMXpNKBrY77TSf3o/TRoFJFgWmg/ebA4qGz23i8YljvvMpbHrRzqpLZKO8UfqFshlHKYiMNUdl3AImH6wFQrXVijdMtRfIyB3NUBLOSpiG+nbjSG+7cvL42u7UE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f274b3-148b-4e36-83c2-08d58156f578
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:07.5257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1068
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nate Watterson <nwatters@codeaurora.org>

[ Upstream commit 5016bdb796b3726eec043ca0ce3be981f712c756 ]

Normally, calling alloc_iova() using an iova_domain with insufficient
pfns remaining between start_pfn and dma_limit will fail and return a
NULL pointer. Unexpectedly, if such a "full" iova_domain contains an
iova with pfn_lo =3D=3D 0, the alloc_iova() call will instead succeed and
return an iova containing invalid pfns.

This is caused by an underflow bug in __alloc_and_insert_iova_range()
that occurs after walking the "full" iova tree when the search ends
at the iova with pfn_lo =3D=3D 0 and limit_pfn is then adjusted to be just
below that (-1). This (now huge) limit_pfn gives the impression that a
vast amount of space is available between it and start_pfn and thus
a new iova is allocated with the invalid pfn_hi value, 0xFFF.... .

To rememdy this, a check is introduced to ensure that adjustments to
limit_pfn will not underflow.

This issue has been observed in the wild, and is easily reproduced with
the following sample code.

	struct iova_domain *iovad =3D kzalloc(sizeof(*iovad), GFP_KERNEL);
	struct iova *rsvd_iova, *good_iova, *bad_iova;
	unsigned long limit_pfn =3D 3;
	unsigned long start_pfn =3D 1;
	unsigned long va_size =3D 2;

	init_iova_domain(iovad, SZ_4K, start_pfn, limit_pfn);
	rsvd_iova =3D reserve_iova(iovad, 0, 0);
	good_iova =3D alloc_iova(iovad, va_size, limit_pfn, true);
	bad_iova =3D alloc_iova(iovad, va_size, limit_pfn, true);

Prior to the patch, this yielded:
	*rsvd_iova =3D=3D {0, 0}   /* Expected */
	*good_iova =3D=3D {2, 3}   /* Expected */
	*bad_iova  =3D=3D {-2, -1} /* Oh no... */

After the patch, bad_iova is NULL as expected since inadequate
space remains between limit_pfn and start_pfn after allocating
good_iova.

Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/iova.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index e23001bfcfee..f106fd9782bf 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -138,7 +138,7 @@ static int __alloc_and_insert_iova_range(struct iova_do=
main *iovad,
 				break;	/* found a free slot */
 		}
 adjust_limit_pfn:
-		limit_pfn =3D curr_iova->pfn_lo - 1;
+		limit_pfn =3D curr_iova->pfn_lo ? (curr_iova->pfn_lo - 1) : 0;
 move_left:
 		prev =3D curr;
 		curr =3D rb_prev(curr);
--=20
2.14.1
