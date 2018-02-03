Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682204-2-231057236038534863
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
    t=1517682203; b=sMHtZJ+gAgQ+RA2XjSdNWSBoEDgEJTOw7ajG2+XHtf4j+uy
    +/YfQA8zvnldPty06CizTxQ4EV+LbDlG6PMSqHb++TRTB3H9zkWsLPeI5fgQfAtc
    FBxelSH5Lnu1R3y5tFtgWRG2w+tEd5yAjDWh9faWeEiaoi3hADKIQLxFAOhhsomU
    swgjfBTN3Xt5UO9Bsmk5IRIPITI551Omid1Q1C+1rKB5kHLus5wVc0fobytNvI9B
    NvXlhEjXyFsk3CrapVOkx0hYHsxpzcZTtd4VKk/VzAs9b/VSYl6OA4YHy8UcgprD
    0ZCVfwhRA8wDAib9i+VxHqZWidJ+RmoGfTtwZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682203; bh=AgWOxk
    T6ax326dAvtZYuNHWgn2XYcSNG602x+UmeM/U=; b=WbqfVmVnnnHi4U8eMlEHfd
    45tPY5X7rAhq4s6b9Cj8HNNSNO0o0mpcbAMY39VRyxtPIGjxdFI2r99w1be6DVMA
    f4GnefznZ/DiPZMkJIqyTt+sjMs5DBKn05ZTFOuJk54NcTelrkueblHpKAfiEtAi
    uYMp4SL8b2g1S2uTbEtnOVt3hqGQhdAsl+e/cThXVNL86YREIa6cuhwm2s3q/CRR
    icEFBqEEvVZ/fa3fRpr7yqWlhi3j8qgB28AzT6L+EqaL/Xiy/26mHqUzzzI1Nh02
    1I9jz4ARkVGjPRMx0UzZ/IPQTL9DZNAPxOgONWpXZk5afqq5TCcd5jLcAWX78DdQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M26gan4g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M26gan4g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754265AbeBCSXR (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:23:17 -0500
Received: from mail-by2nam03on0108.outbound.protection.outlook.com ([104.47.42.108]:45412
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753462AbeBCSGa (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:30 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Karol Herbst <kherbst@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 06/32] drm/nouveau/pci: do a msi rearm on init
Thread-Topic: [PATCH AUTOSEL for 4.4 06/32] drm/nouveau/pci: do a msi rearm on
 init
Thread-Index: AQHTnRlup+YGpqaHqEOfi2+wek6Vgw==
Date: Sat, 3 Feb 2018 18:04:27 +0000
Message-ID: <20180203180413.7438-6-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1089;6:yI5f9KU9thTFRabGHJayAVjbASmoVPOsFo1zgFk+3LaQmU3fFleEPxjp1qfNoWy+YC3Xgm15jukHZeGDpZjq24Yhm3TnHUkiq+snTIA19V4zXDQ/ROr5eNV13mkd7wigB7I+oMwBRmonW61OOy/h4BE2BSRyFa5rVnspUSaI5wI4Rl29xozTKB13ptUTa8reW5N74uOY5sx6PfIYU6QCDs3uc2QLbM8HeEjBBIYYQGe6V8aj/u4cGki2kXH3T8oWxV70r9T70z6cjYOIYFl3QG4IvFETl+feDiTur1UAZ67pi0Z/NmdhOspV6hw53rp7wOpJlO4q/hAabxEvU+Yy6XD2BUm833p44IhPbg0XI8JBwOMkjgqSegz7TavDtWxT;5:A0lwBdjXx48fcmtlP7C/0qPiUeHp0utEuZ8L2/fpmTreL2QJWoZoShubivPjGCPqU3v7Ty3ZJL37a63uh9PPwIc6WYxSn/sarshCwjAaGmuHeyAC7a9eocY/eJ0D5UnUhSs9fuAmegxB1fpEk+UiW1UdbEJnrSxv99v7yTVnHHU=;24:rZXK0/PIzQkjQW2wj/hZJ+NbQinmf5kkfnhngd604T5MzQ3vr8enH0t5rP4/2kAbBqdr7H+7/LzPsgwuoaxJxv6rJqcDzsQURlCgrk725D0=;7:tiQGrj8TjjWhGTwQkQsNtgOHHXIWivXfLpN0GMHkn6fIoeZZW9WUdEPnwGbZB7zYDNRBAOd6yDkcWTw3oqCYyjXtafaxjv+KOtAH1Xp98CRqEl99Jnm9qz17fPkBFxCcrS6y1jPTpp5UW2j+6QPXGBslL2PTTjv9ONjyLXhBDVNhkybEVHuXr/ZkpJD9IPMrzN6idyJl0F3NnUMafMTopoB7i1zGuW2b3kQNTbKZ+kDBKW7RFIXk0jcS6MXlMVQx
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 38155a90-9c34-41b5-3d56-08d56b30a69c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1089;
x-ms-traffictypediagnostic: BL0PR2101MB1089:
x-microsoft-antispam-prvs: <BL0PR2101MB1089809DA48C996E8A41D073FBF80@BL0PR2101MB1089.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(18589796830644);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1089;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1089;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(86362001)(575784001)(106356001)(22452003)(4326008)(97736004)(25786009)(6666003)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(1076002)(102836004)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(186003)(6486002)(14454004)(59450400001)(6436002)(53936002)(72206003)(316002)(305945005)(7736002)(99286004)(54906003)(110136005)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1089;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: v0AMeNxTEA9+LEl6WkYvzjj5j6qXJGLa0OQh0hvCr1DWeqGGryOcfCWWt7KXEK5KvjqOJQ3f1AS82uz2TGqDeA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38155a90-9c34-41b5-3d56-08d56b30a69c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:27.0652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1089
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
index 4896474da320..3021fcd0a3df 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c
@@ -127,6 +127,13 @@ nvkm_pci_init(struct nvkm_subdev *subdev)
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
