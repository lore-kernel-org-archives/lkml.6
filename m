Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238701-2-3563114342108791869
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
    1523238700; b=fnoqiDbMrNhe8IyPLf6ap+wa4TI1LFhkawVUIr2DxIDEb+wluU
    /OdPTp4tq9S8ZLW7KxdT85Vy2I8ynZZv3ttVlJHKz1yKTqA2SHqeWkF7QbLQmr1I
    n5PmpaE4FGoHGFen4sF0O0Zn+xbhm5yygOe4yEy7wbljGtXExEMUHAF1Gql1ygm8
    11bcwWmBwkeqxYKjeeDXPwHW/wEECHLUxmgBbsQtF5FtKCtCw9/davDA2n1IrB6H
    ZPq0geY9d+Ew5exnAVczAWMtf6f5CVc1oT1DXbuHmkZtCoEENNWb4/XtZ63wsl24
    jcdGSkoZ0MNv9Y9NqI/Fz9MlPZDBmUPOTONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238700; bh=cL/iFlfnjr
    n21geDZn1eVufMpezMx73YyfQJUvrruqw=; b=YqnV1QTUzlTJbyd9XbqmibI+Kt
    7E+hdj3JhfYEHCxelXDnKidgUvFSQD3fKn69eKKTTJcQsniTYb/KTtLK2aeFZtjD
    RegeAVnPGYV7+6OIYEW4rRnEfTOoDxHj7vMJKKeuzJZesTyhL9cVxRrTxWoVLZ3P
    2R7SEQj21rgUeVwnE/eLJmBLc8gfBBjuBsn4b5ZJhOGEWIRskDx/fJ34q9f9vIPo
    Gvb9amBg601Ofu3pOTRNHy4n+ZXWA8UQrVhc+nc5kFHSPF5XHsrPh2xIi4gd4OZK
    19sM0X8Fcixb4Sm/KhwwQBWXR+EJxoome7TpXHFoE+YCm3k7dcXjPahcC1+w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WdrRhjdY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WdrRhjdY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJkPlc9NYVFf0rq5SUfEcw52BFyXIX1yMUMVQIF0iiGvP+bURa+iZFrgj64ShJdIVvQeq/cJtFQVV+V37WigDus2R3DLBdNBbWWqAfKXkMhpI+PmMy06
    /2K3cgv6LW2CO9+Gbk6HPbF86RjMJmcXqQD0cCsoQq/jTC+Nx5opreKPpjA0x2qNQi+NZeTOQ/GsiqSwcyDAc+TQO+f4IgkcFnQuvhZYovfmnir3tMVbzl5Q
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=9isDrUItAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=CLeWWt8dGckd-uDcp54A:9 a=RfgONM9Q38_H_8yf:21 a=CC5GkahYXGZ71kRb:21
    a=wPNLvfGTeEIA:10 a=01Cuw3xjDqt1ySEFOcFQ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757467AbeDIBvV (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:51:21 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:18358
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932335AbeDIAdt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Andy Spencer <aspencer@spacex.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 251/293] gianfar: prevent integer wrapping in
 the rx handler
Thread-Topic: [PATCH AUTOSEL for 4.9 251/293] gianfar: prevent integer
 wrapping in the rx handler
Thread-Index: AQHTz5la43phuBMfE0SfIdG5Zt9J4Q==
Date: Mon, 9 Apr 2018 00:26:08 +0000
Message-ID: <20180409002239.163177-251-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:CcjGj+0eMKoHwQiLsFuAhP5fIgXxiHt3PeGZDuj1K2qTunnf70aQ7ll5EGUavO1DRC336+aZynLaSXeYROJ8BP8+AeQClDis/7bbOnvfMvCcjgDJ64nwhpOq76JpXHD18+8maQFARJlk9XdR6y1RwTz1jl7rres4A+UfqxB3fNImwY/NtvwouPYOPlPY433uamu+/cqmWn5ZucDkjPQAfQPpTSeFhfniIcUUqZ7Osm3qE6ZfARiABLm3oVFEkC0P;20:mwNJMVIcGBHggGV9JQyFtwMYO4qfzHcVM/yN42r8CfKCd066N/chkOonhrc7CLLjvLjeuF3LmsA9lJGwKCj2Kp7vcLz/tzd68AXKdXJRdw/b1kYt49nLtlntpN3ZAKlCozfOTYAl+pmbYE3+sQfK2b9gV8/9nxn4ow03n9aRUeQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 355d408a-08d9-4cec-5ccb-08d59db18ed0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08067D797681F8BCFCDA1985FBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(575784001)(86362001)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Lc4Qyr1nWtf1Dyu53ORJ5FvijRn3kFYN+UBzZS83Z9BBxb6M9UkDhfZXHq1T3F2lMBlvmKbRSUUbT3871cABLnfaXaGXEFzFssBAaHLEXwAPAx2JYrkPb1WZN0vhBsCsmsU8a8RSk6FetPhhs7BCHgXzGSWafieHZ56YiHhW9vMR+nryKT49mMgoBb8TEK2AcMjvZwr/8ujU1qaYxMAPZUfj+KG1vW0VfMVD9EVme0xtBSsMjyG5kTy3deydZbqJ61d7mX8/nHvdX3BtdY2bkHVOSW68I3lsh7RVb7nJi6OpKoL4VqvQPK/CtPMoLONM3kjNuy8EzK9ZoZicar/OFBfhagsYMoP/uwSW+jMgCt3tMkZE2aAhlrnLCBmamEtEwxowqMlwc3KyQDzh6O7C9vPLoSGv5wunegiLjbL6+Sw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 355d408a-08d9-4cec-5ccb-08d59db18ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:08.3162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
index e3b41ba95168..fa877f1e7f6f 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -2935,7 +2935,7 @@ static irqreturn_t gfar_transmit(int irq, void *grp_i=
d)
 static bool gfar_add_rx_frag(struct gfar_rx_buff *rxb, u32 lstatus,
 			     struct sk_buff *skb, bool first)
 {
-	unsigned int size =3D lstatus & BD_LENGTH_MASK;
+	int size =3D lstatus & BD_LENGTH_MASK;
 	struct page *page =3D rxb->page;
 	bool last =3D !!(lstatus & BD_LFLAG(RXBD_LAST));
=20
@@ -2950,11 +2950,16 @@ static bool gfar_add_rx_frag(struct gfar_rx_buff *r=
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
