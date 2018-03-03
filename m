Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117387-2-4320022095463690512
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
    t=1520117387; b=bQ8Pe+bc+Hs6Puw1v7G3ihwIYp0PSbqOGkt1VKw+SFduLAI
    j2MobPqcrTmNpv2vs+49eb7YmgeeA8+T7EJnBIlek49bZ/YWkc9OYITdusiOqXw/
    zNDseVUfFr7nXP+s7n7m8hEjeb/Bw2rw3jv7ajrd7t0iBX9giWYJCttqHT8PNzF2
    fgT8Q1veUJhoZmDp9Sz0TnQJpqYQujmcFTsgy3R/aeO3215tLRxutYNbSGGj2XDL
    DoIip3Bn1K1MgoPvoTVkILXm8NeIzGMVvrIfpos21uiYyU6DN/S0A+5qJyB3qAu6
    LExhoAa9ILt68B2F1++ewe/Nn5q2dT1s5RQOlrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117387; bh=Ej0F4H
    MdnC+u7PU3AisZJpL7BNMB0yEjsIMqkmd5/U0=; b=lC/u/a3EJ8JfzHMkTm8aB3
    QU0MN5FyEcBQ2loC8zFOwTIu+FXUf7rsBKQYiIg5a+wCpCkmTQE+1SuvXIhG6D1O
    jwPjWyqMsPkaDLldPLkQ/Kvuymqp4AfiYUm5kBVVXCp+5E4bM3gj0ufnKNjf8bsB
    3/uJgjmjbjOGbiNmcTt0Xuc1UtCHFPt9NcJz4jtu3pimCy3mCHNy7vthtuIHIfUA
    dQRk2bKRexBfhf0WSu5zlgAIqw6PZuhN/qSY2ehSPulJQtMsk2bezmTA73ROlpKe
    Y0oSNwtJ6L3OfYoGlKbGau4udlPcgGJo2sOZ3LC9uXgJy9Uh421buRtcEc/FavLA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=maUEiVkC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=maUEiVkC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933793AbeCCWtc (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:49:32 -0500
Received: from mail-by2nam01on0129.outbound.protection.outlook.com ([104.47.34.129]:5824
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934475AbeCCWlo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:44 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nate Watterson <nwatters@codeaurora.org>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 33/63] iommu/iova: Fix underflow bug in
 __alloc_and_insert_iova_range
Thread-Topic: [PATCH AUTOSEL for 3.18 33/63] iommu/iova: Fix underflow bug in
 __alloc_and_insert_iova_range
Thread-Index: AQHTsz+nK7SQgLfQik+6AakPI5i1kg==
Date: Sat, 3 Mar 2018 22:33:29 +0000
Message-ID: <20180303223228.27323-33-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;6:j7JaNPZrbhGxsJJ0pRVszl61rugK3GA8iXn39cpqcapBHn6xNPV70k2yA1KRjtO2nd5j+b9c9TtanzroJdtG/ZbeJc3c0hzcTiBg6uDQdu1KxjeyBJLBIkJU+9QyZMnak85pNKtiSDkBRKyD3KPmeaP880n0h+yRb9AN/nXaB+jS/ddq75RrHIcgi+NxhblDVdAMouFfUzGJV7PlIRFB+O8Iw79ixxGKgPJq7Ny90dDkxTgZt1pzxOrkA/o8vnZE32illevAXZ5VU4GP3U45qkFXlU+dFQHL5tXoL845Qk1OBjQ/bxNYURj++oDNOB+zOVmBSvZSRMQZ5NDOV6OUSJRPQ8p+b4Wg7nn0BIFizsMRwr15KzIKIIheX7Kc4SE8;5:3M46YQpZ9ibnLjt1vT4JAdCip6ws/H19xRclasxmiMvC24V7JuRk0DBPRi9loIUBk/SaUHVS4ru40xRV9hY5vz7/SC06whvli+/zxygwVOV2SOAyFWEJResLBv7tVlgw+bp/SLl5v0Vmf+Ui9x5FAmNOItqfVppXH/Oyynn8F44=;24:TALmON8LzbJiENCPhvA3hG+pH8k2R02gedI8CZxQ1ZQ1zMp0QG2xY+V06dy58d6DBpWW8osDDSLyvNUPBJ37OFXMN3tTPBsyxLIyTa+xjKo=;7:Jmtud/92gKcmlQJI+vL6UJkuAg7TpVDNmnyJ3UKOXX6uO9rfe4KCKUhc2+PZ565KXAjI6rlFBf1Ccx6OuMqcPY+DlT0OVX2ZJ8RV3LZrlvD1+mVhyur/o4hmSl+92xNzOekokpLQ/9oq9PGsl+JvV1dLB/+pCOPnFd6N0RqW+K0abjZ7fKG4DQ5zoEHpk60OzyJVsfZvYR+dGLLmvBMrw4scWkCESfGA7Tdux6rNyo7hlWeuXBkFT8gxPv6ybanF
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c8b94cc7-a46e-4ce3-6138-08d58157efef
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB068576948BFFE34373433FFBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(189003)(199004)(3660700001)(575784001)(8936002)(72206003)(5660300001)(14454004)(110136005)(6512007)(4326008)(6506007)(26005)(2501003)(66066001)(86362001)(7736002)(54906003)(305945005)(25786009)(10290500003)(53936002)(6436002)(2906002)(81156014)(59450400001)(8676002)(478600001)(102836004)(106356001)(316002)(186003)(5250100002)(81166006)(6486002)(76176011)(86612001)(6666003)(2900100001)(3846002)(68736007)(97736004)(36756003)(1076002)(107886003)(2950100002)(105586002)(99286004)(6116002)(3280700002)(22452003)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ZI8gyaah63UYjJ1VH86gDgaltIQaWbUiYIgdbY0lMVBX49MH2uXiP24zVHGTjno/RMN76V0le1wMEmrGxc0YuPzSh+ht6PVZgNnBECwQzClDpVFr8rCKNj9Sj/BemXyjtf4no/gVzcgunDG2OrX+r8ahnDT2tvBGDpRqjpSlN+g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b94cc7-a46e-4ce3-6138-08d58157efef
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:29.5757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
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
index f6b17e6af2fb..c9e54a0b4bd1 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -118,7 +118,7 @@ static int __alloc_and_insert_iova_range(struct iova_do=
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
