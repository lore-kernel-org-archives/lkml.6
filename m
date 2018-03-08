Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488879-5-13035803438539143544
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
    t=1520488878; b=luSQ+Q8+GwnYZuknk3FFB30nPA38UOTjOMWJG7AlbI5DoYO
    Z3g91ZYCu52Tk9Mv4u56RK2on/jBqmYqESD8pTTxK6ton1Y9WmcBs5lo7cqt9xb9
    a9OzUPnPxGaHpBFgOT3pTmaH6I1thy+hWsrIwdYilfRYpzAqLtfJD1vw5d/lROcq
    n89gFU1k04tdu6M6L0UbgO/ii6RWI2mNUGOPMq8L9l8l1E130OlisA0AhtH0vcwX
    Yci+Mcrm+TByhLMFHDfpgSspsBPMg2OqM4OHU6U6TG+i2B987ZUxAXT7946FYaOL
    eJG26WkNwdwzve3ggwe6zisSNMiUvciOdnjaefg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488878; bh=Fj0f0N
    T1MzbTbGQavK/uYBdoeitF+NA01t7/27/Mk/Y=; b=CqNwwwDQbksgQX/f384kta
    VCxYoTnotXlOCWpnEILAaYCGmBlQcSQZF7EiGPkamhp9nbRJaNLaTfwiktFXruWS
    WdCk4Rwpyhv//hDP785YNWBSWnG05wc/seolzY0nLG3sXsmedmtakW3Zupxe0e5O
    ssCE87XV2iC9HAr2Mt4xMu6cMYVkm9NoAXZqecb7X1SfcN39MqQiHZLWRBYZCmaH
    LovFw2UGAfBSi0zM6H/vSP7Ng+piiMQvTMAjdeC2yTis8A6Kxr0zjwWBtRfhgcAo
    2BLwrHFatt2m/p+GUf2K46n+rtL9uFlodcZTSF5hUqySz+Teb5PdGWzgn7mzjcFQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ggLDb4t0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ggLDb4t0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965732AbeCHGA7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:00:59 -0500
Received: from mail-sn1nam01on0105.outbound.protection.outlook.com ([104.47.32.105]:54752
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965939AbeCHFDB (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Scott Wood <swood@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 127/190] bnx2x: Align RX buffers
Thread-Topic: [PATCH AUTOSEL for 4.9 127/190] bnx2x: Align RX buffers
Thread-Index: AQHTtppIpXigOYsX5kSx36/v5C3N/A==
Date: Thu, 8 Mar 2018 04:59:47 +0000
Message-ID: <20180308045810.8041-127-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:Wt/P2ES+hSAoD2HQd4VvYTgSi/nLc/MIMh+7OmjyifmhlPRtTWdTXBAnPheHQ6H6S+EIgcd2n6j00ywCRC+oYutjCM0rMidhmF0pZClDrBOOwsuI8Kf6BtNcTYAW/ldntXjtYfds55NUWVitZCa6FC6RHTo5g4fK7RWUV5m6dj846r0PWpk61/FJdwyQZgQrfBRp3GcBi8zxiy8icaLUJOQwMJr/0DeaUmXdV8fThPNqMDkvp2StzNBE/Bjl6f8h;20:ra2q4DS18jP1lSnGcNrSq9JvxZQ0C2PRRWuELQcN6I/o+rcT2rHq7HzjU/1WUWvNKHivdsSvPgZDALmiqYNR9aF6zOcuD3Lzuu5lVwguHVRFeSEcrXc7HJNz/b5QZOj7BrZSw6dIT0C3n0AxJIE3JNHkq9+4kwZaIMhVCzzM5Gk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 90fb64a8-bc32-40b5-c89a-08d584b1dbfb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101332019B68999281D22239FBDF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(76176011)(6506007)(107886003)(6486002)(22452003)(105586002)(2950100002)(6436002)(26005)(99286004)(53936002)(6666003)(97736004)(36756003)(3280700002)(102836004)(5660300001)(2501003)(68736007)(6512007)(186003)(2900100001)(59450400001)(106356001)(3660700001)(4326008)(2906002)(25786009)(5250100002)(14454004)(7736002)(10090500001)(66066001)(3846002)(305945005)(6116002)(316002)(10290500003)(478600001)(86612001)(575784001)(8936002)(54906003)(72206003)(8676002)(86362001)(81166006)(110136005)(1076002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: nQI1hoIrJ1ma3NmRcJ8R+NBZQ1sDARFIwnh/F+qJayzPgAWXJW8dSHm85Pz8UXvLyCOLsWud9UymF+InrkEJfCCV1ZaKp1WgjE4VQpQAM9WHsOxTUWJyb11vPKkd06lcln2xJt5tBtUfMibEbKytBI54O8QJiwhd4wS8d/KPE5A5dEqCy0FjuTslVwHliVI8HqqAQkGBKwa+UPw6BQTHcBrFXwLKc3eMJuF8pzsqBNW0ycPNmDPgJTYvkxQ/iCtemZhIalAjR2axkOnRdWT8pyFywgR4JmaUF+3DgM2CqOdmholGK4Nhkn8h4wML5QD4vr09/aPYp5V5+jRw1W6vlg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fb64a8-bc32-40b5-c89a-08d584b1dbfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:47.5395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Scott Wood <swood@redhat.com>

[ Upstream commit 9b70de6d0266888b3743f03802502e43131043c8 ]

The bnx2x driver is not providing proper alignment on the receive buffers i=
t
passes to build_skb(), causing skb_shared_info to be misaligned.
skb_shared_info contains an atomic, and while PPC normally supports
unaligned accesses, it does not support unaligned atomics.

Aligning the size of rx buffers will ensure that page_frag_alloc() returns
aligned addresses.

This can be reproduced on PPC by setting the network MTU to 1450 (or other
non-multiple-of-4) and then generating sufficient inbound network traffic
(one or two large "wget"s usually does it), producing the following oops:

Unable to handle kernel paging request for unaligned access at address 0xc0=
0000ffc43af656
Faulting instruction address: 0xc00000000080ef8c
Oops: Kernel access of bad area, sig: 7 [#1]
SMP NR_CPUS=3D2048
NUMA
PowerNV
Modules linked in: vmx_crypto powernv_rng rng_core powernv_op_panel leds_po=
wernv led_class nfsd ip_tables x_tables autofs4 xfs lpfc bnx2x mdio libcrc3=
2c crc_t10dif crct10dif_generic crct10dif_common
CPU: 104 PID: 0 Comm: swapper/104 Not tainted 4.11.0-rc8-00088-g4c761da #2
task: c00000ffd4892400 task.stack: c00000ffd4920000
NIP: c00000000080ef8c LR: c00000000080eee8 CTR: c0000000001f8320
REGS: c00000ffffc33710 TRAP: 0600   Not tainted  (4.11.0-rc8-00088-g4c761da=
)
MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>
  CR: 24082042  XER: 00000000
CFAR: c00000000080eea0 DAR: c00000ffc43af656 DSISR: 00000000 SOFTE: 1
GPR00: c000000000907f64 c00000ffffc33990 c000000000dd3b00 c00000ffcaf22100
GPR04: c00000ffcaf22e00 0000000000000000 0000000000000000 0000000000000000
GPR08: 0000000000b80008 c00000ffc43af636 c00000ffc43af656 0000000000000000
GPR12: c0000000001f6f00 c00000000fe1a000 000000000000049f 000000000000c51f
GPR16: 00000000ffffef33 0000000000000000 0000000000008a43 0000000000000001
GPR20: c00000ffc58a90c0 0000000000000000 000000000000dd86 0000000000000000
GPR24: c000007fd0ed10c0 00000000ffffffff 0000000000000158 000000000000014a
GPR28: c00000ffc43af010 c00000ffc9144000 c00000ffcaf22e00 c00000ffcaf22100
NIP [c00000000080ef8c] __skb_clone+0xdc/0x140
LR [c00000000080eee8] __skb_clone+0x38/0x140
Call Trace:
[c00000ffffc33990] [c00000000080fb74] skb_clone+0x74/0x110 (unreliable)
[c00000ffffc339c0] [c000000000907f64] packet_rcv+0x144/0x510
[c00000ffffc33a40] [c000000000827b64] __netif_receive_skb_core+0x5b4/0xd80
[c00000ffffc33b00] [c00000000082b2bc] netif_receive_skb_internal+0x2c/0xc0
[c00000ffffc33b40] [c00000000082c49c] napi_gro_receive+0x11c/0x260
[c00000ffffc33b80] [d000000066483d68] bnx2x_poll+0xcf8/0x17b0 [bnx2x]
[c00000ffffc33d00] [c00000000082babc] net_rx_action+0x31c/0x480
[c00000ffffc33e10] [c0000000000d5a44] __do_softirq+0x164/0x3d0
[c00000ffffc33f00] [c0000000000d60a8] irq_exit+0x108/0x120
[c00000ffffc33f20] [c000000000015b98] __do_irq+0x98/0x200
[c00000ffffc33f90] [c000000000027f14] call_do_irq+0x14/0x24
[c00000ffd4923a90] [c000000000015d94] do_IRQ+0x94/0x110
[c00000ffd4923ae0] [c000000000008d90] hardware_interrupt_common+0x150/0x160

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/=
ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 0a5ee1d973ac..857fdfb0197b 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -2026,6 +2026,7 @@ static void bnx2x_set_rx_buf_size(struct bnx2x *bp)
 				  ETH_OVREHEAD +
 				  mtu +
 				  BNX2X_FW_RX_ALIGN_END;
+		fp->rx_buf_size =3D SKB_DATA_ALIGN(fp->rx_buf_size);
 		/* Note : rx_buf_size doesn't take into account NET_SKB_PAD */
 		if (fp->rx_buf_size + NET_SKB_PAD <=3D PAGE_SIZE)
 			fp->rx_frag_size =3D fp->rx_buf_size + NET_SKB_PAD;
--=20
2.14.1
