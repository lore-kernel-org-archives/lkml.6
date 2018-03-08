Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520489717-2-12408321231528414910
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
    t=1520489716; b=q/S/pMD7GunwckfvDmSxe3tJXauqCqVp/Wo5cQHTMZf4zZG
    jXy1XCKUA++mSy/q+8Y2XX6Mxgpdjjgvpjilod7fJ+7XnfsBtbrmDJSSh60Q6U27
    +P6KbxGhOi8I/66F7QRCgVM3r33hxCkaS0NLgqO6JliZ+LXKr/MCuaI5KVy2FlxY
    qSSJH7GdTNDx8XTitlIZOx6ZYs6Cky7LKDny8teCvatTV0nikFhRrsbFHH1O2+at
    OMHq2vSoH0nTCpmsMpVfPEZ+PYYJ1K17K9SPC5ebtiL2RmhhVL92MEK5pOieaaCJ
    dgxOwDDfuvJosUFRiYPbDOvCRJRZElxqvm0SC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489716; bh=IgqVBU
    Hb7p0J2PNNCErM1RLzosOHMGR5x2ei99216Ws=; b=Yf04K5CnDIGVobrVv/+zpl
    AZW5V9H2UknqtjfswIj1qfcxbitmtWHic/pBFmb4C3RR3vhXVTPbVme/+zqM9pI1
    35osEaLgWNsOyjj8t0d8wePIXINtZ2NIbKRsruJvPMW9ZdxqxZpihjzFzJA7e1QL
    IcuuWBFTS/2fyd+0hMvozJO1YXUnmA57fAl1JaO2kZqtmSLOKI4J7/3g8yy21o1M
    o5ZAPj+PzjOA+BDR7n4VsQ/mH0nBS3T2/Bn0OBNQ3mWeCnjjUZszZobJ0/GKf5nG
    MEQvYxOhxYJc3YSUHD+RI/vXAAdGjibplDb3ZQQ907Vw8d2WRLv9CZ7y29tTjmSg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=a9dBsSeu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=a9dBsSeu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755353AbeCHFB3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:01:29 -0500
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:14896
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965695AbeCHFBZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:25 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 065/190] IB/mlx4: Change vma from shared to
 private
Thread-Topic: [PATCH AUTOSEL for 4.9 065/190] IB/mlx4: Change vma from shared
 to private
Thread-Index: AQHTtpo4E7knJGk5bU2hLfM3Bjm/bw==
Date: Thu, 8 Mar 2018 04:59:20 +0000
Message-ID: <20180308045810.8041-65-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;7:B9OXxOXpy+T6rJZqpGuVGKkdYDHUwruTgG0Z1syGoMrBhQ7FIQzRqWm8z00j4c2LNXnEyLInV9U9s6J1vKWhtpinJ71y2qHiWniwtWi6YBE4HIvqX/AlDHcIUv10R1Yh3wFoHe76AU0INvBniSxvDkMaTIstPNWnZcoLa8+fFc+z+4lWyfwjLEUoIl8tczGVk2LzmmAQk3ZM3wV61xd3K06PoZ/HG+Q1OTkRM51HxxNiYeldJD4lMvw6rXk8NYlt;20:B8XY6f0feUWe/JFAk9OlZAYVo/PM2ebsA7QL7wQuE+9ZVL4X6UmmU8sRufyJ42TCf75RcwcgWcOaC8V6E3owHmD2iKXkWJxZ++O6SeW91cqfJ3R9Vv5bGnweSR/+s/QHs/wQ/YChsAgOyLOAc6AZ9Bqb1rtTCWWFtX341gHP7wE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55dca07d-8a0c-4e51-3bb1-08d584b1a281
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB099940073652A090844A546BFBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(6506007)(86362001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(59450400001)(68736007)(86612001)(53936002)(26005)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: oRpvICi6z+zd5jagPWsoWz6bSfxHTGKloLmV3Ct1cBG1gUydNejlEU0jOoVnkVJEUhS6EdMhCBioFQgjm2SC/FgbIbkBunc+ChrHMnEHA8HRNzug1y1UvrqxIR73DsNOwa4DVtc2uYzyhatqO5ZIcVbwpx9WOR+7rvyoU7XH92Fupiki15muJ2zT55vWr+VcG0wLQ0xPE56j9Rgw6ufwsHZk7i6hFuW6KcQx53rTeNP6rLiUW91G/seNVbIPxcnZmrTz5KpxYdH1dgJDqicHnFgTUkkQh2fSl1It3jXQmIkoyyLLtVc+0HRnNGFT/lpP+QFFxHd2BCCgPt9Emsdvjg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55dca07d-8a0c-4e51-3bb1-08d584b1a281
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:20.5715
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
index 129dbd790dba..19bc1c2186ff 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1182,6 +1182,8 @@ static void mlx4_ib_disassociate_ucontext(struct ib_u=
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
