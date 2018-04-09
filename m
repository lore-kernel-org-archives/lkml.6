Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238826-2-11456381327769288735
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
    1523238826; b=C8X/1EQmxUlGjr4Yti1vAvpkoQ2mJuDK9Do5tEV88SzFVlk9/R
    G2YMQX5SawN9bgKpTcBvm9ZTMcFQClbFXwEEnWXUwjRxaVsq/YCNJaTClGFh5214
    6Fi4VxrGJZfpXBBopc5Rmo9cN4e3VBWBGE/s1ponBDpUnyIuiPMFzZ2zaQB3p0st
    1zSlAB9mC6aarP+24cGgCengj2twI+7/xvbI4CBmq0mgRu9GJj+qRsmEtRF1yLaM
    PZf1ulFeXAU9GAE6f6lHlwUbs+LUmZOx4QoMCKk95BqnP556Eatl7gzAU8Zbmiih
    zqczI2DwNTAJZNotA5qWy1MARjmi7AVsDUSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238826; bh=KK3Bsv53qT
    ek5AD4vaazYJBPDDl5pmnD/2Bj03Hkmy4=; b=A0wonTKMMzT0Sjw+TRrF3NXEat
    x0+Z9wwzm2q7hplyZwD1lI3AtHBUXndSRdAbfHq5Ipm/S6nOkdJnBvUCvfVlKBSR
    gf+vOTd14BYk94Hkz7ZTFyDeAcVwVbJaPEzxLcr2azmXOEZTWV0VWBVcvwp8qGtp
    27qJmtZfBxlQ9ErRwUX67mhLpVu1B5f/vq7GpOOrbIkIg88obLogxiuCENotOuqo
    N4kmErpOAKtZpSxgOcHVDDj459biH3LHtiYNUx6KqO9+i75AUGYgKMnkZIcyDsAe
    Z6AiWX9l5BLTooj+iPFKRyFGdj4U1HbGW0+VBLZkPNYHeViC1zLMTse7WyzA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BfFPXODX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BfFPXODX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLKuXVE8NmdZTjRYiuyTzKsKlntyNfJgdkQQGcaMVws+LO9vr1pxZZE5Ahnk5CFcdyiBcEtuBDBh+ZPxq/dx3bDJci75wAMY4TTJu91REo0uIr161ibq
    uX5bVrUFP9UlpfazdUuVxGeF1TVSuHlnIHALT8sS6XHpQaaD2FPn7WepoX4BuQ0so6Y8X1UAK/qVoXOaKGRRsF9TiBFZdemDyWVI/DTFxTpdiLxVI7Tb0wM5
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
    a=yMhMjlubAAAA:8 a=sdoPFwP2wC3FMohMv5EA:9 a=9sNPxEx9vO1_Ydjh:21
    a=ljEjL0k8rLSXbs74:21 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756682AbeDIBx0 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:53:26 -0400
Received: from mail-sn1nam01on0094.outbound.protection.outlook.com ([104.47.32.94]:49836
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932213AbeDIAdR (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:17 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 239/293] Btrfs: fix scrub to repair raid6
 corruption
Thread-Topic: [PATCH AUTOSEL for 4.9 239/293] Btrfs: fix scrub to repair raid6
 corruption
Thread-Index: AQHTz5lVFCxYs5l/Xkq14bDYuDZlhg==
Date: Mon, 9 Apr 2018 00:25:59 +0000
Message-ID: <20180409002239.163177-239-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:ruvEj0e1RyCFW5KOVsS8OmG1T6cdp1rvCcbq2qGkawZYku27waPNBeasWU308+SO13iLWqiOAa4MkM0wazNNU2cr0SIAIPs26PGWGj9hFKXxSyp/QDQMM8yXhNYGyHjLTmHDfCbB49vPuhUSXkXW2NK3D/adJm6QIzHXZzHxeY+zm4XjLsugEuNn1/JC1+TmIFUDQUBOT9v5WPOZTFmOyGijwkf4tyjQ4rB3xnqBc8lvvrvqpQoF/IJ+uop6TZDR;20:JA8KW0FuoQXWY32qwGNQWnn/umHWrrkTC5w92DJIUxy9LznAQZdUR14WwtEcQ5PtWH//XdGejCeCyft2Me+J7yGvgH0R9LAvFbXafIs6ozSEvT05f6TAPWvOF2cbHZwyDBPmtDmm0z6CTOFyCjkmPvd6XdxhewbMZkBCU7r2jJY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: fb41e156-d558-429b-0a95-08d59db177fe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09028DF5E0295903C07FD002FBBF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(39380400002)(346002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(25786009)(6486002)(72206003)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(26005)(486006)(10090500001)(36756003)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(86362001)(6306002)(53936002)(966005)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(68736007)(54906003)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Sc0QKFWnNmc5BeHCpvNfr6UyAJ7DkPBhDBQFE4dYuV8YcT5B2wFaQJ2of1kxYgAxoIsvqorTFI6q63CT0oa3sx7dm5QOJrob0BETcqpNzDKWMnJnZFFVxOGGwqI7ldHyMPPkkkLP4mDStkDZ1SMd8BifEtuVlfyZ0RYuGbr+MVE/ZBxQdj9rpIBxxq98ofnV7yrZLd6GceT2Vwi8UqCJoaUm0QVQPBzyfA9N/WF5IxZAbsIkpaakG8NO7IHq6H2CmAGxcHqblMT0oohnFLDvjdfONhN9WKdyF7zPpqmWXl07o30QNhRh7pYayTyzr9g8tFs2T3GdHyZKbZ9F7w0U4Q1QIBVhe4J5xgqG3aFd2AJOTb86P0FK4byUeI3rl0DPbjDjbr+7Hd2rUtyOEbXOhbTJF/MLbbgyuIJllHq6BXA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb41e156-d558-429b-0a95-08d59db177fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:59.4568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Liu Bo <bo.li.liu@oracle.com>

[ Upstream commit 762221f095e3932669093466aaf4b85ed9ad2ac1 ]

The raid6 corruption is that,
suppose that all disks can be read without problems and if the content
that was read out doesn't match its checksum, currently for raid6
btrfs at most retries twice,

- the 1st retry is to rebuild with all other stripes, it'll eventually
  be a raid5 xor rebuild,
- if the 1st fails, the 2nd retry will deliberately fail parity p so
  that it will do raid6 style rebuild,

however, the chances are that another non-parity stripe content also
has something corrupted, so that the above retries are not able to
return correct content.

We've fixed normal reads to rebuild raid6 correctly with more retries
in Patch "Btrfs: make raid6 rebuild retry more"[1], this is to fix
scrub to do the exactly same rebuild process.

[1]: https://patchwork.kernel.org/patch/10091755/

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/raid56.c  | 18 ++++++++++++++----
 fs/btrfs/volumes.c |  9 ++++++++-
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index d016d4a79864..af6a776fa18c 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2161,11 +2161,21 @@ int raid56_parity_recover(struct btrfs_root *root, =
struct bio *bio,
 	}
=20
 	/*
-	 * reconstruct from the q stripe if they are
-	 * asking for mirror 3
+	 * Loop retry:
+	 * for 'mirror =3D=3D 2', reconstruct from all other stripes.
+	 * for 'mirror_num > 2', select a stripe to fail on every retry.
 	 */
-	if (mirror_num =3D=3D 3)
-		rbio->failb =3D rbio->real_stripes - 2;
+	if (mirror_num > 2) {
+		/*
+		 * 'mirror =3D=3D 3' is to fail the p stripe and
+		 * reconstruct from the q stripe.  'mirror > 3' is to
+		 * fail a data stripe and reconstruct from p+q stripe.
+		 */
+		rbio->failb =3D rbio->real_stripes - (mirror_num - 1);
+		ASSERT(rbio->failb > 0);
+		if (rbio->failb <=3D rbio->faila)
+			rbio->failb--;
+	}
=20
 	ret =3D lock_stripe_add(rbio);
=20
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4730ba2cc049..491c14ad982a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5177,7 +5177,14 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, =
u64 logical, u64 len)
 	else if (map->type & BTRFS_BLOCK_GROUP_RAID5)
 		ret =3D 2;
 	else if (map->type & BTRFS_BLOCK_GROUP_RAID6)
-		ret =3D 3;
+		/*
+		 * There could be two corrupted data stripes, we need
+		 * to loop retry in order to rebuild the correct data.
+		 *=20
+		 * Fail a stripe at a time on every retry except the
+		 * stripe under reconstruction.
+		 */
+		ret =3D map->num_stripes;
 	else
 		ret =3D 1;
 	free_extent_map(em);
--=20
2.15.1
