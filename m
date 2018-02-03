Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682580-2-5016104528808563216
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
    t=1517682580; b=crQofOA0Ets1rv2uyLQA9UifOOpnRQfz7MJGm7uTSNvbQCw
    nonga58npctd99QDTLwlvyuF3nfm2U9TTZ+BelkM9rkzpLQlPbYuSJ4sjYgaV4jw
    iJIgnWua6S6MpaMdYfpIIarhsoKPyA+ivTz+oNDbiaAeoSlesAoBG7JpFd/tRuYd
    LRlcmffBnnAJGaZW24xXHvidNRK6Q+SjKwtCh/XuyYQxbBNSv+u0ytKYUt0nlJNd
    Q7xTR8wZyrAZQLa5eCK5yVY7w/ljAxRMH1G6wvSTsrLRsQld4iavxjmvRhVValwR
    JT65878ajB7pXF5lWBS6W/OdxdRWt0F5dtzejdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682580; bh=yeDzaH
    pZtzBh0fpkrCIQAHoRwiWuyXu9SyR2gaYfXHw=; b=remAmoxPK1z8dLPozGqO6f
    v8D2Uh9hg4NoykQOqHuof7UUvxFfuGDU40gN4DrZkFjTldsbXS6uo9/YfsJ5FS8+
    Gcn7nd9qhzSQp9yBFp9wuXlV/U7XwUe8WJQ7PKT2PK1y85+mm/6KGOekVorkU6Z8
    HDClEo94Gna32V0dPbzQrkHT1eGvSIPPNQqO4/Qxhl/rskXYRBdFA3aJWlj0YQoy
    iijohKPMM2nxKnVXVIAIy6zM+bdJCEffap9X4f2D8tdf9oaE+0CgAdJp+k0wkn9A
    JZ9CR2nIqJloXeMb7NvGtMg12PWiklpGJeTTDfw3GE39akKSEWcZxGORHMBTsO+g
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gAPX37Al x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gAPX37Al x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754549AbeBCS3b (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:29:31 -0500
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:60480
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753084AbeBCSE2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:28 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Karol Herbst <kherbst@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 12/52] drm/nouveau/pci: do a msi rearm on init
Thread-Topic: [PATCH AUTOSEL for 4.9 12/52] drm/nouveau/pci: do a msi rearm on
 init
Thread-Index: AQHTnRlRx+2W/AODzkmb1xQF/rzOtg==
Date: Sat, 3 Feb 2018 18:03:39 +0000
Message-ID: <20180203180303.8490-12-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;6:36YiGiWKF8PjIjF8l8SGMqULBe+0oqVOUGXZTqfkXnE1FFlQscpsT9R+Uj+RJ5A6931yi0jufIMMxyAGT6MxoomGuRn4cudChWA5V3ARtCG/m6zX0gclRPvoKHHqIuv49y1PmdJKw/+NXU5d267af9iO7ME826dRV+Ac2mpPxrBFYsgrNAkhHAhm0LD9yBERQJzw4ww930yqPqaxplFdHUSGxnKabrCaKQZwnGt07ECLbtZp2lwdld/Ti0AdgxVXiWPgI0wQNqe66ATSC+y81zHyqxGPEsGaimpZot7j0fp8XXs45jo7ty5RB9BkzKlnQzjat4tPzqZ1pJ+MiCn7tRlOKEZz9E4axvyUhyJthwVfF8EiIn4twOunHjgjc5nN;5:48ZxFLrPh+uLFMUm0pKvqZF0omkM+vPSyMadoqO9XkWxCvRSt4kzo5s8ZkqWUz1Yw2+S8pOoZHfjnZOFOWpXEREv0HL3pIDYKqYGxZOSOjA/2nqHFh5G1aEyKwMw6e8e/eLbwZfOgLYtDmboJ8BosD19ATiAX4lwpw3XiWhkNQk=;24:zxzfe+ccVbLjBOZVogFuwzUrY8/2ZDbPdgNW9xK+9pIB0Ck0Hc6bnXB4gLkCw07bA2G1mNrnVbhi18UWUKXOpdZbpFWBq1aoA6OFmajQlb0=;7:8l17mIKDQqyxPqNB9mbAHZXRxFV50iood8MCKjjl+e0qTtrfiSY+LFu/bxiPYGRCbyQzDiRYRDIj8PufSRfVYhhl86So6Kogc0AhdnA5KJ4MlfzG8QOpcYBsP3ZTOsfiLm5KUPoGUFyWASssOaNRS+2NLtzXXdNkjb7BQTGRmzIwvVpDAGIx/3uay8Ukixqcp4wEyowPtaA0rhofVqVRDBpGdSTGbOKyUTrIveeo5cOocooKQMI/0VZRpFEFBmk3
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c84fc40-ed0c-4a74-1240-08d56b3074a5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
x-microsoft-antispam-prvs: <BL0PR2101MB10916C080F0355ED96E2F4B5FBF80@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(18589796830644);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(376002)(366004)(39860400002)(199004)(189003)(86362001)(575784001)(106356001)(22452003)(4326008)(97736004)(25786009)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(102836004)(1076002)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(14454004)(186003)(6486002)(59450400001)(6436002)(53936002)(72206003)(7736002)(316002)(305945005)(99286004)(110136005)(54906003)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: U8I9r1skxd/yiJtNTzjC11sIkuAEXiAFzYVjrxhiDknieOvF6ashXTtpPkzXMB7rXET2+Pd1XbIEbfEtBlHUKA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c84fc40-ed0c-4a74-1240-08d56b3074a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:39.8464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Karol Herbst <kherbst@redhat.com>

[ Upstream commit a121027d2747168df0aac0c3da35509eea39f61c ]

On my GP107 when I load nouveau after unloading it, for some reason the
GPU stopped sending or the CPU stopped receiving interrupts if MSI was
enabled.

Doing a rearm once before getting any interrupts fixes this.

Signed-off-by: Karol Herbst <kherbst@redhat.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c b/drivers/gpu/d=
rm/nouveau/nvkm/subdev/pci/base.c
index a4cb82495cee..245c946ea661 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c
@@ -136,6 +136,13 @@ nvkm_pci_init(struct nvkm_subdev *subdev)
 		return ret;
=20
 	pci->irq =3D pdev->irq;
+
+	/* Ensure MSI interrupts are armed, for the case where there are
+	 * already interrupts pending (for whatever reason) at load time.
+	 */
+	if (pci->msi)
+		pci->func->msi_rearm(pci);
+
 	return ret;
 }
=20
--=20
2.11.0
