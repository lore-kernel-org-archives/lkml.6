Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120397-2-14412556309191320429
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
    t=1520120397; b=bpar3UPVAeuR4opXsqnLQ9WaNJSno4/nBO+1BhKYfbv+U64
    byVX8eTi7D+ZCmZVbQTkTEv0IKdaYbznT0+KtS3MxriJTw1Wod24rsRP05nJ9uJf
    SkLrT9tP+wtW40UrekYhcqMIarZR0LqwrA9pdVNUlynESQgGT/j/0C/UpGOWhwHN
    lhNQPpyh17lSxtZzOfgF17IHpJVwu/MjNevWAEeHAXSFhBadUEOA4h2clpylXjKu
    4df2DO19CRhv8yDS3nR6yjPWn0AQLK8SuZwZsqrz9TWVBWW6BmbhySRZZ0ai540y
    Cx5FQAseUKEYoLnd8hwVOrJs047zTrIjhx0SsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120397; bh=1yn3X+
    xC4BddFc92PpS/u3BZdc9rSYFMlHOFom6+Qwg=; b=UIDRdYva/hOHo3FhLQqY9i
    ZiGAQmSjnT1tknt/+6zdAHqz3GdwCNh1muZvK2o8uca30t+EA0StqbTDF0x/m41K
    yN311zY/ZzfUv9EhUVPcDRefRDAQQjDoWIjonQUYG/on/u2riGNmw/IDdMYkT1MI
    vHZVaARJX4sDaI5mg7nzxnCx1LoSyDWv4W5vPFM9UKezToNMZ8NYWc3kanqJv2w8
    McGEseWS5hTAPn0pQpj6iXDDkELQIi1QzB9QLn/0Xb+WUGTTgOU+VmFCuYRhZkmE
    ++0dxTfRfnrkRLXKjXXMqvGaQO2mVSxuNRTpt4qfc+LGORpIshs8f+xrqEOs8ylA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Jh7rLHT6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Jh7rLHT6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933834AbeCCXjl (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:39:41 -0500
Received: from mail-sn1nam01on0132.outbound.protection.outlook.com ([104.47.32.132]:20800
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934328AbeCCWfJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 141/219] [media] v4l: vsp1: Register pipe with
 output WPF
Thread-Topic: [PATCH AUTOSEL for 4.9 141/219] [media] v4l: vsp1: Register pipe
 with output WPF
Thread-Index: AQHTsz8RFhivTXX9gUyKTEuw0+/eYg==
Date: Sat, 3 Mar 2018 22:29:18 +0000
Message-ID: <20180303222716.26640-141-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:V2jM9X1HWS0EYTqfQzHw1vlDIAgYsFsh0OsMTnHcYBDLQjtPxTlIRX4XNnoUXpMEF/5NIa1lcAP38TlsV2K0eDAJITKekxwvv0Cz9LhwHcWFL+uRK65byo4sRsdYnhOALuOvfHDcFRugd7p7VXA+X4TV4kxdkzOjr0BpxA/Ns2EWJBfDftEfJwlJ+hhgidxINaXM1HmZKa3Iu/AKQyGNIdlqnfpM5IkdJ2/1FyShihlbNILjXS0ke5lfiFPlZdfekv1I88a8GKSBQrdD1714pbRoZVoUiZen1x4xCyxV2jsdr2TFjxIWeWMdxDiPSCz8RqQs8acWxBiHKyy943IsNpFwd9tedcTDVCh3E0SFiLs=;5:MKp4oy1tpvuktBUmqR+WTSqeVZCu3mcTX8xR5mFiL9vs7wMEDAqACAYRMhADuu9mqYv7H9V/IYtK1bHEO73bfGZuGX6sgxIjf6u4GjmChWFgMJ9QcQPcQj/fkhkO8Yw7IoM+ukLINCFg2NFnn5E2Q+oODii5ekleo4hw5htWkzo=;24:fOnr5czyq1PNiXmthJKLSqlsnTuHKa5SeYtwaN+EhrqgBUufSEWT67+8TFAACBIf5Jodil6/KdAAr0Z/SxnDhIo9HPa0mQve7lh0WZ2nBb4=;7:In0xH371SfTqKU+/jBVsF3dMMG6PUIGEcxwVm46742xuqpSPkzmN2EsfJ7Aa42ZQPT5/bWbFgQ4RTaJWqj2zB7N3dOb9nhUftgYjIOwMLq0Ul9Sop9Uyk42ZcRjFi8MtTRzDG1/dgJDOxx72itqpDMkYWL6lx75fBrpudKMULr9JAOJxnRC7MY7hgmvDgqdjGOJCbvy4LZTvdaGWR0XWjy3biLj2mkx1/KzXmWycAAPYP9bCPzw7yfQYpR1Q/SuV
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: babe444d-c02e-45eb-92e6-08d58156fdd5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0924A4B6EE0C42B8782E6A3CFBC40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(102836004)(2950100002)(10090500001)(6666003)(316002)(26005)(186003)(25786009)(2900100001)(2906002)(54906003)(22452003)(110136005)(97736004)(6506007)(59450400001)(7736002)(4326008)(305945005)(5250100002)(86362001)(2501003)(99286004)(68736007)(72206003)(53936002)(6436002)(6116002)(3846002)(5660300001)(66066001)(1076002)(76176011)(14454004)(36756003)(3660700001)(6486002)(86612001)(81156014)(8676002)(81166006)(10290500003)(6512007)(8936002)(3280700002)(478600001)(107886003)(106356001)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: babe444d-c02e-45eb-92e6-08d58156fdd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:18.4632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

[ Upstream commit 1531a208ed861e4bd287444f9466ffcf98383de2 ]

The DRM object does not register the pipe with the WPF object. This is
used internally throughout the driver as a means of accessing the pipe.
As such this breaks operations which require access to the pipe from WPF
interrupts.

Register the pipe inside the WPF object after it has been declared as
the output.

Fixes: ff7e97c94d9f ("[media] v4l: vsp1: Store pipeline pointer in rwpf")

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/platform/vsp1/vsp1_drm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/vsp1/vsp1_drm.c b/drivers/media/platfor=
m/vsp1/vsp1_drm.c
index cd209dccff1b..8e2aa3f8e52f 100644
--- a/drivers/media/platform/vsp1/vsp1_drm.c
+++ b/drivers/media/platform/vsp1/vsp1_drm.c
@@ -596,6 +596,7 @@ int vsp1_drm_init(struct vsp1_device *vsp1)
 	pipe->bru =3D &vsp1->bru->entity;
 	pipe->lif =3D &vsp1->lif->entity;
 	pipe->output =3D vsp1->wpf[0];
+	pipe->output->pipe =3D pipe;
=20
 	return 0;
 }
--=20
2.14.1
