Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AG47ELvVokQCXWOW3nPp58R/eJCT2iTMMS/1oLrTo2JJM8uYWHgKRQDMgnbedfmd5Z7Aaot5BaBY
ARC-Seal: i=1; a=rsa-sha256; t=1520867238; cv=none;
        d=google.com; s=arc-20160816;
        b=WlBWvT4gRGHJOB7cYv0KlJ4+EW5dJik7QYJcRFw+vFc9ahFWXnF8SQLDB83ZHInV1O
         2oKuaYDF/BPa0Qz4aD0QrOIutwZ8T3oCaqEkuemPNew8+BsHLwclQwxaPnBt43BVpI0r
         cHyX5i/iRjF456c8V99R2j/bEngvrk6vMsIFyvO5eXakYG0NcB7RmO0d4eNTK2TZGL6T
         xea7bYMOjgpO+35DwzB0RUU4aLkA3Bfxk6H6oZbRXT9Cq5ya206jKJy23PlzKf11LjpC
         m16hAxxgM4DZUVxidzKUfLmXU1HtditMmYTLdtHdYyAbw9a5G0hXrQtNIAb0zQG5k1sL
         zStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=QUuFlob4/k8tLY11n29plxmwq8tj3Hegfi3QZF07bTw=;
        b=TP0Vugx9B7jc/Qub2LczDiGpRwZJv17bWdVYVuq8MXbuqx4zYMCIeSUqJr3x587RSd
         NQkDwdJL4Kmkm9vBwxRt1VulDhwmTEs16+kkRO4fo0CT5EqysaFMqvQnMb6Sm2voL7Sf
         Upwp5qsH3SmemIOQCmIn/R5P0RYZTg4qi97RrWzOCTrZM0Ocw+JERbGfDMBFV3RehgDC
         AWS4MTaOgMuma3sOSn3TcIe5ayi6GAciTbivyQDAYdvbfqkMUEYmF5y5GyUc/uXoGnKd
         m3P5UisEKHLQHrlauqhifCu0Kx+ufbstEBdLj0kQj6EH+lmN9byovnLe11E/6J4FNxp3
         HADQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.57 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.57 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:800:960:966:973:988:989:1260:1345:1437:1535:1544:1711:1730:1747:1777:1792:1801:2194:2196:2199:2200:2393:2559:2562:2898:3138:3139:3140:3141:3142:3354:3867:3870:3872:4225:4250:4321:4385:4605:5007:6117:6119:6261:7903:9040:10004:10848:11026:11232:11473:11657:11658:11914:12043:12048:12296:12438:12555:12895:12986:14181:14394:14721:21080:21212:21433:21451:21611:21627:30029:30054:30070,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: sign98_2225775560551
X-Filterd-Recvd-Size: 5731
From: Joe Perches <joe@perches.com>
To: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
	linux-wimax@intel.com,
	Johannes Berg <johannes@sipsolutions.net>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
	Florian Westphal <fw@strlen.de>
Cc: Kalle Valo <kvalo@codeaurora.org>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: [PATCH] net: drivers/net: Remove unnecessary skb_copy_expand OOM messages
Date: Mon, 12 Mar 2018 08:07:12 -0700
Message-Id: <782fa75ab2e443d275f19d97f2f3a073b6074517.1520867179.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594744886116547813?=
X-GMAIL-MSGID: =?utf-8?q?1594744886116547813?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

skb_copy_expand without __GFP_NOWARN already does a dump_stack
on OOM so these messages are redundant.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/qualcomm/qca_spi.c | 1 -
 drivers/net/usb/lg-vl600.c              | 6 +-----
 drivers/net/wimax/i2400m/usb-rx.c       | 3 ---
 drivers/net/wireless/ti/wl1251/tx.c     | 4 +---
 drivers/usb/gadget/function/f_eem.c     | 1 -
 net/mac80211/rx.c                       | 5 +----
 net/netfilter/nfnetlink_queue.c         | 5 +----
 7 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index 9c236298fe21..5803cd6db406 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -705,7 +705,6 @@ qcaspi_netdev_xmit(struct sk_buff *skb, struct net_device *dev)
 		tskb = skb_copy_expand(skb, QCAFRM_HEADER_LEN,
 				       QCAFRM_FOOTER_LEN + pad_len, GFP_ATOMIC);
 		if (!tskb) {
-			netdev_dbg(qca->net_dev, "could not allocate tx_buff\n");
 			qca->stats.out_of_mem++;
 			return NETDEV_TX_BUSY;
 		}
diff --git a/drivers/net/usb/lg-vl600.c b/drivers/net/usb/lg-vl600.c
index dbabd7ca5268..257916f172cd 100644
--- a/drivers/net/usb/lg-vl600.c
+++ b/drivers/net/usb/lg-vl600.c
@@ -157,12 +157,8 @@ static int vl600_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 
 		s->current_rx_buf = skb_copy_expand(skb, 0,
 				le32_to_cpup(&frame->len), GFP_ATOMIC);
-		if (!s->current_rx_buf) {
-			netif_err(dev, ifup, dev->net, "Reserving %i bytes "
-					"for packet assembly failed.\n",
-					le32_to_cpup(&frame->len));
+		if (!s->current_rx_buf)
 			dev->net->stats.rx_errors++;
-		}
 
 		return 0;
 	}
diff --git a/drivers/net/wimax/i2400m/usb-rx.c b/drivers/net/wimax/i2400m/usb-rx.c
index b78ee676e102..5b64bda7d9e7 100644
--- a/drivers/net/wimax/i2400m/usb-rx.c
+++ b/drivers/net/wimax/i2400m/usb-rx.c
@@ -263,9 +263,6 @@ struct sk_buff *i2400mu_rx(struct i2400mu *i2400mu, struct sk_buff *rx_skb)
 		new_skb = skb_copy_expand(rx_skb, 0, rx_size - rx_skb->len,
 					  GFP_KERNEL);
 		if (new_skb == NULL) {
-			if (printk_ratelimit())
-				dev_err(dev, "RX: Can't reallocate skb to %d; "
-					"RX dropped\n", rx_size);
 			kfree_skb(rx_skb);
 			rx_skb = NULL;
 			goto out;	/* drop it...*/
diff --git a/drivers/net/wireless/ti/wl1251/tx.c b/drivers/net/wireless/ti/wl1251/tx.c
index de2fa6705574..12ed14ebc307 100644
--- a/drivers/net/wireless/ti/wl1251/tx.c
+++ b/drivers/net/wireless/ti/wl1251/tx.c
@@ -221,10 +221,8 @@ static int wl1251_tx_send_packet(struct wl1251 *wl, struct sk_buff *skb,
 			struct sk_buff *newskb = skb_copy_expand(skb, 0, 3,
 								 GFP_KERNEL);
 
-			if (unlikely(newskb == NULL)) {
-				wl1251_error("Can't allocate skb!");
+			if (unlikely(newskb == NULL))
 				return -EINVAL;
-			}
 
 			tx_hdr = (struct tx_double_buffer_desc *) newskb->data;
 
diff --git a/drivers/usb/gadget/function/f_eem.c b/drivers/usb/gadget/function/f_eem.c
index 37557651b600..c13befa31110 100644
--- a/drivers/usb/gadget/function/f_eem.c
+++ b/drivers/usb/gadget/function/f_eem.c
@@ -507,7 +507,6 @@ static int eem_unwrap(struct gether *port,
 						0,
 						GFP_ATOMIC);
 			if (unlikely(!skb3)) {
-				DBG(cdev, "unable to realign EEM packet\n");
 				dev_kfree_skb_any(skb2);
 				continue;
 			}
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index d01743234cf6..9c898a3688c6 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2549,11 +2549,8 @@ ieee80211_rx_h_mesh_fwding(struct ieee80211_rx_data *rx)
 
 	fwd_skb = skb_copy_expand(skb, local->tx_headroom +
 				       sdata->encrypt_headroom, 0, GFP_ATOMIC);
-	if (!fwd_skb) {
-		net_info_ratelimited("%s: failed to clone mesh frame\n",
-				    sdata->name);
+	if (!fwd_skb)
 		goto out;
-	}
 
 	fwd_hdr =  (struct ieee80211_hdr *) fwd_skb->data;
 	fwd_hdr->frame_control &= ~cpu_to_le16(IEEE80211_FCTL_RETRY);
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 59e2833c17f1..9f572ed56208 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -833,11 +833,8 @@ nfqnl_mangle(void *data, int data_len, struct nf_queue_entry *e, int diff)
 		if (diff > skb_tailroom(e->skb)) {
 			nskb = skb_copy_expand(e->skb, skb_headroom(e->skb),
 					       diff, GFP_ATOMIC);
-			if (!nskb) {
-				printk(KERN_WARNING "nf_queue: OOM "
-				      "in mangle, dropping packet\n");
+			if (!nskb)
 				return -ENOMEM;
-			}
 			kfree_skb(e->skb);
 			e->skb = nskb;
 		}
-- 
2.15.0
