Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243339-2-11311118621432374745
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
    1523243338; b=SdaqRqhF4w/aNca0KG9KW5phlH2OfmSvjkXapykb6ernh80fLz
    bknxw0dwBoU8cYfirMM2V46Zgyd/wE10c3BTekwr/iXgLn8zhN3rjE7lL4QhTOEu
    hNXILIa+Thg+b65kBD88kQ+k7TXTJwyPvtCXU4bmJUwGRzJsTrALUG67X/BkK5yg
    G5PiC8rJlvKQPyQdoI39x9OqA0BWZAwuED1A6aUqLlrCTsURh02B9Hyn/2Iurn6Q
    l38JVuDnjCqHLLHSNtBo4wlxbmGjVXoM/EkjoMnys7dALniRpCdkA0Rr6E/FtwuJ
    3njoLzbJ2Sl7HgMbM6wznMNIloA5dYKtbfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243338; bh=ynQjRCtn02
    SgZ6Y4sKpMZbj9uyTwC2zSxCFbk0h37vk=; b=wTx7CGF2cS1kr/WnqU7s1uMVlI
    w06IHBFX0FpMoz+Hedj1OXCEpUZRGyK45A1nybjNh8RQf0oZqVbsEy3xLFEvjpdd
    nivGxttjlQcrchu6imXz03PxViOz8Kg4kP6nUVc9IuH+uoljeU3H6s09X4ZDxGPB
    GaSliyDOtryzf2Fk05ST27/Mctke3hL1sn55W4VNIuF4WnP3GjempYkVIXkvB+4C
    aITIKJU+a6lrMpifeMkY/+5RXek1VFlic1VEe+NfjsPE8cPOTkAGnRnw/L8r78Ov
    IDiaFYR0/mClOvFGgDZzkrSg87BMhsv2IXoZestjr7xQrwLd6sb2OS/oVMOQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PxocHlvV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PxocHlvV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLmgQ5+vmiuo38KfDwiyBxvIlzx+ZFieIhOC5EtMxsnE3mwk4h1pFzoqZwoqJGQIX8nowmF7bZgQxgzXhp5Yw5hrWRAB5u07DefDCLqjxMY0FDjPYvYF
    ODGA8fiVIyctrfxN5xYSlki74GUzZkTUoy42qBO5aWQnssRhEGmNGQCwOgWMF50P1olUiy9pLKOoqcqqSgdaJHiJzddtI2v/78oiy+ngHiMjTKs3TnyFTO3v
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=9isDrUItAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=CLeWWt8dGckd-uDcp54A:9 a=RfgONM9Q38_H_8yf:21 a=CC5GkahYXGZ71kRb:21
    a=wPNLvfGTeEIA:10 a=01Cuw3xjDqt1ySEFOcFQ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754315AbeDIDIy (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:08:54 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:63840
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932068AbeDIAYe (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Andy Spencer <aspencer@spacex.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 089/161] gianfar: prevent integer wrapping in
 the rx handler
Thread-Topic: [PATCH AUTOSEL for 4.14 089/161] gianfar: prevent integer
 wrapping in the rx handler
Thread-Index: AQHTz5iikHYdLvPwK06Al4mvZhcwkA==
Date: Mon, 9 Apr 2018 00:20:59 +0000
Message-ID: <20180409001936.162706-89-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:qL5kcJFGP5HPBAxZ2JTArLRpy+qloA6/wDC+XxyvwAip89Iun6lTUjfd5LjxNjBarftPTcypxTDFt3eQrXKtszq+r/SzCC5XAgP2Mmkld9yoJBs3Km2PnaMh0s3TTStlj2yMD4Da8FmA1kl4qRBmBsB+YMdYgwuIMjPMojZ1JD6gNmNPOkiNYvh9I/nmZ702heIb/sWKkCTJrR95CmksPQYzQ2HSqSV57trJhQBDzTy9lwtLL4itzlU5RjtKkHAY;20:zMIIK+QCTY6Urz9FdhHjL/2+oK3SXxPTtXV0vmWi5xqXGk3YM/EelvjUSMuMu4tCjnAjVSmQcj1P4wb0TpqGF1ywRp5p3/uql6gTT+70dbOcLtMt8Cj/tcE4TYe3i1VNyia+CC7oXdX5ZkylYeK4u7mAVIdTefpxSV4clqISE9I=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7da63497-9eee-4b58-208b-08d59db0430d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09846D4F49F22E01B55872FCFBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(5250100002)(2501003)(110136005)(54906003)(6116002)(6436002)(11346002)(1076002)(486006)(25786009)(105586002)(2900100001)(102836004)(86612001)(3846002)(68736007)(107886003)(316002)(10290500003)(5660300001)(86362001)(2616005)(305945005)(4326008)(446003)(6486002)(22452003)(7736002)(575784001)(476003)(8676002)(81156014)(81166006)(8936002)(6512007)(10090500001)(186003)(3280700002)(106356001)(76176011)(2906002)(99286004)(26005)(97736004)(14454004)(6666003)(478600001)(53936002)(6506007)(36756003)(72206003)(66066001)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: qkTuQnT9oFqMmW8+nwNvMeyUtkmWM8Nwcmw7nVn3N4WMIiaja/XE2gnHCkfisVB2nq8b9XjzsDa18RpH2vqpthZQuRSfakkmGdx7mMuQcQx8icxv6OZmLc8i03NnRfIWRavGUOF/8LoCtXoj9AxMWX9h5xPfAOOUXixzPpsPmYuvTaXhxLf0FHmOsCla9Z+uVtRvc2pivkqFj4u/64Tq9PLvfn7x6OhIbJE8mXc245BdgNti4+Btay4TSGIr3O/9ENPgCOVAaSYov7tWGUKMsIfvjUE9oq/mCnVWHSggC/GYQtUedtvOwtj/Sjx4yen+0cpQhjfS1ePI/QU5g4hrPo0xLFWQ5NNE8KJ7rinFggM277tcSptSJZU0+Okde3dtU8an04nrS0sIHuEGXcvSfAw0iMVUf6835W779yQMhDY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da63497-9eee-4b58-208b-08d59db0430d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:59.5502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Spencer <aspencer@spacex.com>

[ Upstream commit 202a0a70e445caee1d0ec7aae814e64b1189fa4d ]

When the frame check sequence (FCS) is split across the last two frames
of a fragmented packet, part of the FCS gets counted twice, once when
subtracting the FCS, and again when subtracting the previously received
data.

For example, if 1602 bytes are received, and the first fragment contains
the first 1600 bytes (including the first two bytes of the FCS), and the
second fragment contains the last two bytes of the FCS:

  'skb->len =3D=3D 1600' from the first fragment

  size  =3D lstatus & BD_LENGTH_MASK; # 1602
  size -=3D ETH_FCS_LEN;              # 1598
  size -=3D skb->len;                 # -2

Since the size is unsigned, it wraps around and causes a BUG later in
the packet handling, as shown below:

  kernel BUG at ./include/linux/skbuff.h:2068!
  Oops: Exception in kernel mode, sig: 5 [#1]
  ...
  NIP [c021ec60] skb_pull+0x24/0x44
  LR [c01e2fbc] gfar_clean_rx_ring+0x498/0x690
  Call Trace:
  [df7edeb0] [c01e2c1c] gfar_clean_rx_ring+0xf8/0x690 (unreliable)
  [df7edf20] [c01e33a8] gfar_poll_rx_sq+0x3c/0x9c
  [df7edf40] [c023352c] net_rx_action+0x21c/0x274
  [df7edf90] [c0329000] __do_softirq+0xd8/0x240
  [df7edff0] [c000c108] call_do_irq+0x24/0x3c
  [c0597e90] [c00041dc] do_IRQ+0x64/0xc4
  [c0597eb0] [c000d920] ret_from_except+0x0/0x18
  --- interrupt: 501 at arch_cpu_idle+0x24/0x5c

Change the size to a signed integer and then trim off any part of the
FCS that was received prior to the last fragment.

Fixes: 6c389fc931bc ("gianfar: fix size of scatter-gathered frames")
Signed-off-by: Andy Spencer <aspencer@spacex.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/etherne=
t/freescale/gianfar.c
index 7f837006bb6a..3bdeb295514b 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -2932,7 +2932,7 @@ static irqreturn_t gfar_transmit(int irq, void *grp_i=
d)
 static bool gfar_add_rx_frag(struct gfar_rx_buff *rxb, u32 lstatus,
 			     struct sk_buff *skb, bool first)
 {
-	unsigned int size =3D lstatus & BD_LENGTH_MASK;
+	int size =3D lstatus & BD_LENGTH_MASK;
 	struct page *page =3D rxb->page;
 	bool last =3D !!(lstatus & BD_LFLAG(RXBD_LAST));
=20
@@ -2947,11 +2947,16 @@ static bool gfar_add_rx_frag(struct gfar_rx_buff *r=
xb, u32 lstatus,
 		if (last)
 			size -=3D skb->len;
=20
-		/* in case the last fragment consisted only of the FCS */
+		/* Add the last fragment if it contains something other than
+		 * the FCS, otherwise drop it and trim off any part of the FCS
+		 * that was already received.
+		 */
 		if (size > 0)
 			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
 					rxb->page_offset + RXBUF_ALIGNMENT,
 					size, GFAR_RXB_TRUESIZE);
+		else if (size < 0)
+			pskb_trim(skb, skb->len + size);
 	}
=20
 	/* try reuse page */
--=20
2.15.1
