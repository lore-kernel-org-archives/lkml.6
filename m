Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488939-2-5356112240862912956
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488938; b=YUZynnrbZtsVgUNY+jTa0p+yncevvfJcdxfDOGo/Ss4hfvv
    eLpthYGJLcIvOB844P6Yau/erPXgREOx+wDl25TdY7wi6O/fVsoQojV2Alenx4i8
    JQviSpq0OaCKOSi+bbEkKpH80JJm01KQWqdP3tI2jLxKesxH2rP9aCpOqGGmjKwc
    uo/0FXDHxs0YqhTIFICUe4VF0fQMUQ3TERxhRn8OnF9a0HTf0rv1oFTlvh/6bw+B
    qhO5v14XpzShBepqenfawcNVwjmkFFZOE/NZZ2zsbiFJOxOHJeyKUTPY4dOgPhLU
    PvEM6lAEddc+R4+wk3x9shztWxlYdWYPgpgkM2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488938; bh=a/OLii
    dmD3UO/jMkgjAgYrExZJ1p+T4aIvvc3SjMggU=; b=pnBAKX27I1nUm56fjmJnG2
    tXpnoziX6QY/GjCDsOaYZFYMvvnVOQxSC8+LuzmNlMheHAU2GduziDWCjuWTHuxL
    5yQFO0VV3HoFFwIEOu/f3PzxizyEviSnDDuzfU8sSSP8gggsYPfTYs27ke4G0xb4
    PTJ8u6y47IJSx6HqBN8KU1pzGSjaAqlCpajNQWdrK/P3CgR6Mq8XrtVXOkBPYdpR
    Gl70WEDknfGzO15OUpEH+Z4+u9TrpjoKPbJLnWG6ifzkY0qZjGFEk4UsEFnI/R/M
    YSiY030VwpdZBSzCUNNYSzK82KrwjK7pSWJbGusa+MXZ7dySEgtJsxdTdihnmNEw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VKSOJ4Wb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VKSOJ4Wb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935409AbeCHFC4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:02:56 -0500
Received: from mail-by2nam01on0116.outbound.protection.outlook.com ([104.47.34.116]:5120
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751173AbeCHFCx (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:53 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe Leroy <christophe.leroy@c-s.fr>,
        Scott Wood <oss@buserror.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 121/190] net: ethernet: ucc_geth: fix
 MEM_PART_MURAM mode
Thread-Topic: [PATCH AUTOSEL for 4.9 121/190] net: ethernet: ucc_geth: fix
 MEM_PART_MURAM mode
Thread-Index: AQHTtppGOT/XDgoEh0ey8uDv8D4vzQ==
Date: Thu, 8 Mar 2018 04:59:45 +0000
Message-ID: <20180308045810.8041-121-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:rtSQDxNk2enj4yhSk+tfJbxZQ//mCzoHM3ld2zP/vnJB8YkyUwHsdB+TpAfb6BvWPQL4lFfbCQHTouyJZTSYZpnbktFPG9mhGEcK1S8zgZeicyIs9x6PmqoMuPQ0/Mc7fpE+oQgGFQakZPJZKumE6HnuBmlP6xE0kfizQpyobwk6JhaBrdaoBQ+4IjffySvxGgnsgYbAXRvPzWkJVUgSSEnqK66BBVCABD+gZJNTQVddoEirGV17kToZm7/sGuOJ;20:nUT9BtsQFhmJkz3qZXFpUwJCGbYPY9qaOmdwVhSnhqZYdtEPM49T3qxHL8qeWhlZV4wr1sW4VxDUonC3DHGyMcsSo0LMSQklbHhkv5zWN4mny8hNgllxU8+0SgILSNgn7rAwDdX7gIbIKfOe1GSbOoXTfub/ajm/zVUJAsrkPjI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30cce341-f8a7-4e12-8676-08d584b1d7c4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10133F551A140C1E717E8B79FBDF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(76176011)(6506007)(107886003)(6486002)(22452003)(105586002)(2950100002)(6436002)(26005)(99286004)(53936002)(6666003)(97736004)(36756003)(3280700002)(102836004)(5660300001)(2501003)(68736007)(6512007)(186003)(2900100001)(106356001)(3660700001)(4326008)(2906002)(25786009)(5250100002)(14454004)(7736002)(10090500001)(66066001)(3846002)(305945005)(6116002)(316002)(10290500003)(478600001)(86612001)(8936002)(54906003)(72206003)(8676002)(86362001)(81166006)(110136005)(1076002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 2RTNQgmovYJOWKkIRMIKrxpECM/yUw/dg7JgZgQuSmnKiCwO6jW0vrv8bIEyb1IKmkMVcbvuQnPuftJ/V6fYM6+V2CSo1ugU+85ytOlShnD9uyXUssrzT98Dwc6Fg12fEz5NhjVkrjVDDF2dV1k6eAkHcyhayFQx8zBhxygRt8SEkMAlPemZWHngEw4fXIm9gypbUgu67Dy1A/6GUgFW0RHcpOUs1aRjOUnOjMJbQCXmostfFYnvkSuqucAEFTPw9x5VSZhlyF0hginNHqd5AP7JQa3fWKNE+P95zS61q5YyqwcKY7y6u6UafCHRXTE+mMpUkWIxp4UysUf+pTJjCg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cce341-f8a7-4e12-8676-08d584b1d7c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:45.0608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit 8b8642af15ed14b9a7a34d3401afbcc274533e13 ]

Since commit 5093bb965a163 ("powerpc/QE: switch to the cpm_muram
implementation"), muram area is not part of immrbar mapping anymore
so immrbar_virt_to_phys() is not usable anymore.

Fixes: 5093bb965a163 ("powerpc/QE: switch to the cpm_muram implementation")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Li Yang <pku.leo@gmail.com>
Signed-off-by: Scott Wood <oss@buserror.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 8 +++-----
 include/soc/fsl/qe/qe.h                   | 1 +
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethern=
et/freescale/ucc_geth.c
index f76d33279454..ef9bc26ebc1a 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -2594,11 +2594,10 @@ static int ucc_geth_startup(struct ucc_geth_private=
 *ugeth)
 		} else if (ugeth->ug_info->uf_info.bd_mem_part =3D=3D
 			   MEM_PART_MURAM) {
 			out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].bd_ring_base,
-				 (u32) immrbar_virt_to_phys(ugeth->
-							    p_tx_bd_ring[i]));
+				 (u32)qe_muram_dma(ugeth->p_tx_bd_ring[i]));
 			out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].
 				 last_bd_completed_address,
-				 (u32) immrbar_virt_to_phys(endOfRing));
+				 (u32)qe_muram_dma(endOfRing));
 		}
 	}
=20
@@ -2844,8 +2843,7 @@ static int ucc_geth_startup(struct ucc_geth_private *=
ugeth)
 		} else if (ugeth->ug_info->uf_info.bd_mem_part =3D=3D
 			   MEM_PART_MURAM) {
 			out_be32(&ugeth->p_rx_bd_qs_tbl[i].externalbdbaseptr,
-				 (u32) immrbar_virt_to_phys(ugeth->
-							    p_rx_bd_ring[i]));
+				 (u32)qe_muram_dma(ugeth->p_rx_bd_ring[i]));
 		}
 		/* rest of fields handled by QE */
 	}
diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index 70339d7958c0..0cd4c11479b1 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -243,6 +243,7 @@ static inline int qe_alive_during_sleep(void)
 #define qe_muram_free cpm_muram_free
 #define qe_muram_addr cpm_muram_addr
 #define qe_muram_offset cpm_muram_offset
+#define qe_muram_dma cpm_muram_dma
=20
 #define qe_setbits32(_addr, _v) iowrite32be(ioread32be(_addr) |  (_v), (_a=
ddr))
 #define qe_clrbits32(_addr, _v) iowrite32be(ioread32be(_addr) & ~(_v), (_a=
ddr))
--=20
2.14.1
