Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682557-2-11294782233616419576
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
    t=1517682557; b=PqFTm4THRUc+htynvzoqC9xrABtbXi6VC5X0ymQJB7XjYRM
    41v3enmKLALKAOeIsA81sCFQfPkievqLqDSkiMogoNnZDuJsmWSWR6vXdRi2oF6D
    NV8h7lV2SiBRC5zGz9fxACNn9OG+WW0t3JblrGcfbTkSDxW4wNJXE8Z0MIH1DJmx
    9BGY3xjTm8BMuJDd94pygqmhZ01Jh/uNi6lai2uaSQebDYvcm49AkXs2kYvp/Pe8
    3ilpwgc2ZdK+zmKyVKfRH9DOxN0xIMTY3JDPZuuGCB/oY/dhh+i/202tYttAnWNh
    RyXnoZZh9zzK+Xtka7AnPSMpD0yHSnj7unD7DZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682557; bh=rnKxLO
    x/zsH4HUxRjoqiYUm8tERpL3hV0z1nI4AF994=; b=NxJaRBI/wg++CK3WOBejMR
    ud1wk0aGsvM2MGJqEK8XOEwZjgwxHBiZF6JM0vWA1NCHZHlwHKuZ/Q9UXOKmJmur
    QuqbnotKTDiJz+QKGgNGdaTUd5KGIuiR0hJiRiPdMJEdjb87iuID7blgCGyYjWsP
    LZDZ+vReXjyMORww1DQ+i6sNStzZzR3kH/kjeALNVsAfK9TAQqDsyL17ezW01jMV
    VjQbLQmvsc/ZRWqLj2z3pvKR1zNhni/VceniVYSCrY1/PjRk3ZQeOO3xYXpQGeie
    YzAauSsdXmalDHeaC5pCrwfuJJZJw6oRw3aVZXYIJEJmgV2dwIZHvSWRp/rKKhmg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aOvSEKuv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aOvSEKuv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754188AbeBCS2c (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:28:32 -0500
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:64103
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753325AbeBCSEy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:54 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 109/110] nfp: always unmask aux interrupts at
 init
Thread-Topic: [PATCH AUTOSEL for 4.14 109/110] nfp: always unmask aux
 interrupts at init
Thread-Index: AQHTnRkHcgXo84zfpE6I3Ad8FrDJ+A==
Date: Sat, 3 Feb 2018 18:01:35 +0000
Message-ID: <20180203180015.29073-109-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:gAVnzOJiYmtZU60qDOaStGvYjzQgLUdgurS4RauiWDJGB0iBhiUcNDsRGIHjymFSTn9TrrL7XzD9GkG8pTQBi0nPAwgG89xo57+WYZ5HCuAqfX3VKkXi07Di/x5MD480vzL4dhJR1cKk1kHabi9Qc8w+92p2a9GvxACdTseWrMF1oDS0+iCWiuiiwUADarGX6VFGDXWyjXB8yTV8kvohD2wzl6PL767lm/qJCmU/jHjp3nncgbmDokLlX8VnqNpH
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 329e730b-4933-459e-a549-08d56b3059f1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB09937E5CDF9EE87D229C0C9DFBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(575784001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(39060400002)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: yaZ8lLQ+9d8OFXmy/+g/kAV4ATnV7Vbw8KdAocuxgnRpSum0c9B73AtxM96puxWVwcI4jzSGFa1W1gxR5tTEEw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329e730b-4933-459e-a549-08d56b3059f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:35.5033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit fc2336505fb49a8b932a0a67a9745c408b79992c ]

The link state and exception interrupts may be masked when we probe.
The firmware should in theory prevent sending (and automasking) those
interrupts if the device is disabled, but if my reading of the FW code
is correct there are firmwares out there with race conditions in this
area.  The interrupt may also be masked if previous driver which used
the device was malfunctioning and we didn't load the FW (there is no
other good way to comprehensively reset the PF).

Note that FW unmasks the data interrupts by itself when vNIC is
enabled, such helpful operation is not performed for LSC/EXN interrupts.

Always unmask the auxiliary interrupts after request_irq().  On the
remove path add missing PCI write flush before free_irq().

Fixes: 4c3523623dc0 ("net: add driver for Netronome NFP4000/NFP6000 NIC VFs=
")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/=
net/ethernet/netronome/nfp/nfp_net_common.c
index e118b5f23996..8d53a593fb27 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -568,6 +568,7 @@ nfp_net_aux_irq_request(struct nfp_net *nn, u32 ctrl_of=
fset,
 		return err;
 	}
 	nn_writeb(nn, ctrl_offset, entry->entry);
+	nfp_net_irq_unmask(nn, entry->entry);
=20
 	return 0;
 }
@@ -582,6 +583,7 @@ static void nfp_net_aux_irq_free(struct nfp_net *nn, u3=
2 ctrl_offset,
 				 unsigned int vector_idx)
 {
 	nn_writeb(nn, ctrl_offset, 0xff);
+	nn_pci_flush(nn);
 	free_irq(nn->irq_entries[vector_idx].vector, nn);
 }
=20
--=20
2.11.0
