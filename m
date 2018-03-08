Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487386-2-9775453423358220747
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
    t=1520487386; b=sNHWe4JPwyQOA4DBHWNKkguu6f80Wk8OgYyDI6MnwlpM38n
    VmLLDH7K1lDmSZy/mKmGb5GQ4idpn5zvEBkj+B1O5jFBgu1Ss+7iPmg2GK1+7Fhz
    7msBvLmb7j5Hzgy3/485ArXhS7z+Lmr1I22unYPO0nysVj2JMKJGuzG5JuXrJK9A
    RyUJR4HHP/gouBggnwkH2GoPoZ+iQppd0BzDXUVGAfEQVe+OlnHJYdp1pymXMAmx
    kXMv+V0pyUX/cVYUuoVmv4fGustXNcqcyi+QHQeJKmCNp9AJ4ryR4oJzeWNcMSDX
    122b9LwrufuNOq6baDt6K9hxepUS8p5ze8C+ktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487386; bh=g/qJRs
    MFjK37CdJ7wnLO3tKTvE8wVZ1Wyit+yYD5Fug=; b=IZ2p6QKFbcsIvxO0r34RiO
    ZjoODwu8XdQAlZEz8tIXfzkJDwiCM9vdi0PyShiAFM1SULSBH4zbU3ELZWtOmzcu
    UNQLMkOeKilCvQ2mRDzCF2z0OhdswhhYp5GB4/YelHqwCry4dIc/j3plPgBLBqXJ
    XXYNu6x/f/6nSMFutxAEtcAabGJJOOJqi6MrjkzD4/zpNJAJesCP06aBcil5uBVF
    Xr3zv/puhpAOAr6XN7m4YKlquQkZ9BcwG6WlWMBGvlt76brfHhmLxvAbeIxoebjM
    BWyoGUOTKYNyYXr1pIIS8Pcb46HHdJVR1Ep6SFhxlpKmcJEtoHrQzfwv0FhiZPfQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AMmHTc51 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AMmHTc51 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755363AbeCHFfw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:35:52 -0500
Received: from mail-cys01nam02on0093.outbound.protection.outlook.com ([104.47.37.93]:7384
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935348AbeCHFF6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 040/101] IB/mlx4: Change vma from shared to
 private
Thread-Topic: [PATCH AUTOSEL for 4.4 040/101] IB/mlx4: Change vma from shared
 to private
Thread-Index: AQHTtpqLON/qbxjXn0+MtPUDfcJ+vA==
Date: Thu, 8 Mar 2018 05:01:41 +0000
Message-ID: <20180308050023.8548-40-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:lqf5kyqpee0jNWnrQSFwQmRKlaTQes0+6/jdksgukGwlKtvfRKZzvKO4ki+9NgBRcmLvi1ZuE5NwIXFTMqIriF2aWtja/eRVj+FKVpz2dnJ8K+eN73kdYWhYiDMZX/s0nA/x/ltNLsfd4Nl3zZeWh+Yajj0KF8VRWluEUwZVwuEIV/SSBUPUv36FDC/y0BPUrtgzZF1u65zGIJCIRXxOiaVDJ7LpLpFPHRQxD84rV1JWizZkGBHDC+GwHQj1Ukvt;20:9eHKpGeXGjN99QvqzdcL7pXRxDyMrSP3gCOERJdrfR5OjNS8Ln3VKo8eXy3IHWn7I23yPJEmvzK5MK9uMPofxNZrtiYSlUHOBYV25bI2Ob/XVzRjYTklvBWaKDthw6p1J+6JrV8O2wId3Ek3IjgKNiCFQAnuqwmfTBH290fglxE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aa6a3e87-c034-47b0-e3d6-08d584b2440d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046B608B1A98E038C58740EFBDF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6486002)(53936002)(3660700001)(5660300001)(6436002)(6512007)(36756003)(3846002)(478600001)(105586002)(305945005)(6116002)(1076002)(2900100001)(72206003)(3280700002)(68736007)(7736002)(97736004)(22452003)(14454004)(6666003)(2501003)(106356001)(10090500001)(10290500003)(2950100002)(81156014)(25786009)(54906003)(107886003)(59450400001)(76176011)(6506007)(2906002)(110136005)(99286004)(26005)(186003)(86362001)(102836004)(81166006)(5250100002)(4326008)(575784001)(8676002)(86612001)(316002)(8936002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 577i7AvC9HemlHR9uBl9X3763dyNFmqJuG8Nbiat9ympR0BtXI3f3Vn+8H64oghkOTb0ldzA2bKzQ0aBgWeQmY+fVctGAQwV3TxAR6c4aZssvrhPzG4/dFkrgveYMDGBjqx6UubvtOMKVz2X4CaJ8nfOjW8cGZTpOLGYFE+OojPt9hFa8x2Lkr9zvkjiNn0nRa5R3pXADGzZKhpEvacGdMb1NI17KzGknD5QEH+KMmH0HJ++3F8WiC6VOHRMTtZKUadDWFS9D6cF8JUSup327PSCYpJY6lhKMZUSHUR15szU/ZlJSbRPzH+GekWytPPbOc8eNHLAE3mzI34G/RcUyQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6a3e87-c034-47b0-e3d6-08d584b2440d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:41.3901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Maor Gottlieb <maorg@mellanox.com>

[ Upstream commit ca37a664a8e4e9988b220988ceb4d79e3316f195 ]

Anonymous VMA (->vm_ops =3D=3D NULL) cannot be shared, otherwise
it would lead to SIGBUS.

Remove the shared flags from the vma after we change it to be
anonymous.

This is easily reproduced by doing modprobe -r while running a
user-space application such as raw_ethernet_bw.

Fixes: ae184ddeca5db ('IB/mlx4_ib: Disassociate support')
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/mlx4/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4=
/main.c
index 9119e0b3c2b8..67c4c73343d4 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1055,6 +1055,8 @@ static void mlx4_ib_disassociate_ucontext(struct ib_u=
context *ibcontext)
 			BUG_ON(1);
 		}
=20
+		context->hw_bar_info[i].vma->vm_flags &=3D
+			~(VM_SHARED | VM_MAYSHARE);
 		/* context going to be destroyed, should not access ops any more */
 		context->hw_bar_info[i].vma->vm_ops =3D NULL;
 	}
--=20
2.14.1
