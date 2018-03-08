Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489841-2-2306355648217391614
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
    t=1520489840; b=prylD+Xt1gBcboYAizgRYAMiKYmUenM8NbMuj02DicKSc7/
    JKyhv1p1zj3V/JB0ykXBS8R2XhMpuTWjwnt9H+pQEmhFv92t61CcF4doMPqnGd4Y
    jxqvDrbZe40vI3xHP0wtYAbpWhGXoHUxBslIZhMXk3feqMmMOAJBHcWI2zmBRsYB
    Bo+225BAUbFTiZX1ihk0R8MqDjtKf8eReM/hEmxtq4p/Fbzafo2OLU41EaYsDXzi
    XGKX+Qspi8cmAvH7mtWnaoC2J4c2csE1k2lHf33w8+oUfHYSfuSg3p3EkjXFArpT
    BOkBVKadDW/0qDN5zc6+VeOfAymkXengJnga9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489840; bh=+SfX0m
    2q9ZPmjcofDilitTToZT+C17tguuo9rHV6VeI=; b=WCx4f239v1lW89pPFWiTT/
    OE3Y0KZ6f8IPawdVg+NuPSd6NDAoOC5EZ+R94k2ekDUp+H2aHBSP3JJZwkkmoD3u
    T8gCzl8OALhgXaaJqb0wJGv8ujMoLqm5Kj3V7wuj5X+kR9L7OfoCtLtMzfCWH8Vk
    FYO3Gg7krj7L9XubKoGLecAxAdFyDwj/PAtt8zHG9Ydx23tTKr4stoYmdgZMTLhv
    caqk6UEOIB/E2drolFpuwOQDN4ypnYh7kmqoYDNaX2l7J9emYpRQ92fLqTt7+37w
    +sfuv8T2WOxeR2d3f4uwGyKUl0BPJoQDY+dS8BnO/U/bqUimMqxPBdSvoqh2wzow
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NisE2ADQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NisE2ADQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935278AbeCHGRG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:17:06 -0500
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:14896
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755330AbeCHFBY (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:24 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 064/190] IB/mlx4: Take write semaphore when
 changing the vma struct
Thread-Topic: [PATCH AUTOSEL for 4.9 064/190] IB/mlx4: Take write semaphore
 when changing the vma struct
Thread-Index: AQHTtpo3+VwNIszYx02s6bHvqDMvfw==
Date: Thu, 8 Mar 2018 04:59:20 +0000
Message-ID: <20180308045810.8041-64-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;7:EtudTtB7CtlAiHbB0CzzvwiEq/pV8kiiL1HyeUx+rd2fgaXqCaezsGgDRnkKAk7JG25ut3fEFRD0heBgnuSnga8VTDTLKI+Ao5R+7grW9FAKBkc5LcSBNFOjGkZiLx3TqH6S4NMffNXwXfAxHwuzA1kjZBTIA45vMl8tRSflmj/eq7qr3riHD2scr74xvc7XL34DJlENlA0z2Jf0dmRJboLD/KNgggwMzIn9qX8Fk4OmBVaOXtkcYqkj2VmIKeMU;20:uasCVqT5vkAbUmtinK/yOhL5eHpALrfYSvOFreHrI3b6/LLAVOpTljZIq9uFeK+84aPG6PjVIrSkJYBsgMEvlDdsczUvNNwcicCHMS2NoWxJ66baDxKxN1TVrm55ujhC7etYxKwkRaYlYHxvr8xpjkNxJfaQIQD63kKrmp29tA0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd7f5954-669f-4ce9-1b45-08d584b1a236
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09996702A9D26E099A8D1E77FBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(6506007)(86362001)(575784001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(59450400001)(68736007)(86612001)(53936002)(26005)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: h2r4xXfyPrNiFSnBTf6Zft0JoL1Neo/v0dKGCztwVUSGkzp7hvAcqh8JlbsvnvL/vBG6AEdF+/YesQmf8g9yAKlWKU+lLTBK8X3xIiCcTVJ5ITehzuPcT0HBgROttIMnQIWzjEunR32NvKxiXP5SdhUNPFnBKwi49Y0/B+RjRMwDHAEPL+EJxg1NPPbTr3TaVVCmCfT5YZ+2W/0gx4hkKm/q+eNsECmIQB5cqKk4SKI26Ue0KLLDGnjomQGduIfI2C+bpizu26Lx31oa/9D1MjVam9KQqa1m8wJ1D18HVR7t1DPchn/lnhr4M7VjIKp3JgyLmDNRifFo6qUb6bvk4g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7f5954-669f-4ce9-1b45-08d584b1a236
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:20.1382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Maor Gottlieb <maorg@mellanox.com>

[ Upstream commit 22c3653d04bd0c67b75e99d85e0c0bdf83947df5 ]

When the driver disassociate user context, it changes the vma to
anonymous by setting the vm_ops to null and zap the vma ptes.

In order to avoid race in the kernel, we need to take write lock
before we change the vma entries.

Fixes: ae184ddeca5db ('IB/mlx4_ib: Disassociate support')
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/mlx4/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4=
/main.c
index c41c8d0a4ac0..129dbd790dba 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1168,7 +1168,7 @@ static void mlx4_ib_disassociate_ucontext(struct ib_u=
context *ibcontext)
 	/* need to protect from a race on closing the vma as part of
 	 * mlx4_ib_vma_close().
 	 */
-	down_read(&owning_mm->mmap_sem);
+	down_write(&owning_mm->mmap_sem);
 	for (i =3D 0; i < HW_BAR_COUNT; i++) {
 		vma =3D context->hw_bar_info[i].vma;
 		if (!vma)
@@ -1186,7 +1186,7 @@ static void mlx4_ib_disassociate_ucontext(struct ib_u=
context *ibcontext)
 		context->hw_bar_info[i].vma->vm_ops =3D NULL;
 	}
=20
-	up_read(&owning_mm->mmap_sem);
+	up_write(&owning_mm->mmap_sem);
 	mmput(owning_mm);
 	put_task_struct(owning_process);
 }
--=20
2.14.1
