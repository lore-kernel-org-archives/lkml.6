Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C648C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8BC24736
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8BC24736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbeGCVjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:39:39 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.161]:11406 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753076AbeGCVjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:39:37 -0400
X-Greylist: delayed 1319 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jul 2018 17:39:37 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 0613A295B9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jul 2018 16:17:38 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id aSg1fHWSYSjJAaSg3fmSwx; Tue, 03 Jul 2018 16:17:37 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=50534 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1faSg0-003Ukt-Jp; Tue, 03 Jul 2018 16:17:32 -0500
Date:   Tue, 3 Jul 2018 16:17:31 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Paul Bolle <pebolle@tiscali.nl>, Karsten Keil <isdn@linux-pingi.de>
Cc:     gigaset307x-common@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] isdn: mark expected switch fall-throughs
Message-ID: <20180703211731.GA24918@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1faSg0-003Ukt-Jp
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:50534
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Warning level 2 was used: -Wimplicit-fallthrough=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/isdn/gigaset/bas-gigaset.c          | 3 +++
 drivers/isdn/hardware/mISDN/avmfritz.c      | 1 +
 drivers/isdn/hardware/mISDN/hfcpci.c        | 1 +
 drivers/isdn/hardware/mISDN/mISDNinfineon.c | 1 +
 drivers/isdn/hardware/mISDN/mISDNisar.c     | 4 ++++
 drivers/isdn/hisax/avm_pci.c                | 1 +
 drivers/isdn/hisax/callc.c                  | 1 +
 drivers/isdn/hisax/config.c                 | 1 +
 drivers/isdn/hisax/gazel.c                  | 4 ++++
 drivers/isdn/hisax/isar.c                   | 2 ++
 drivers/isdn/hisax/l3_1tr6.c                | 1 +
 drivers/isdn/hisax/l3dss1.c                 | 1 +
 drivers/isdn/hysdn/hysdn_boot.c             | 2 ++
 drivers/isdn/i4l/isdn_v110.c                | 9 +++++++++
 drivers/isdn/mISDN/stack.c                  | 1 +
 15 files changed, 33 insertions(+)

diff --git a/drivers/isdn/gigaset/bas-gigaset.c b/drivers/isdn/gigaset/bas-gigaset.c
index 40c1411..ecdeb89 100644
--- a/drivers/isdn/gigaset/bas-gigaset.c
+++ b/drivers/isdn/gigaset/bas-gigaset.c
@@ -739,6 +739,7 @@ static void read_int_callback(struct urb *urb)
 
 	case HD_OPEN_B2CHANNEL_ACK:
 		++channel;
+		/* fall through */
 	case HD_OPEN_B1CHANNEL_ACK:
 		bcs = cs->bcs + channel;
 		update_basstate(ucs, BS_B1OPEN << channel, 0);
@@ -752,6 +753,7 @@ static void read_int_callback(struct urb *urb)
 
 	case HD_CLOSE_B2CHANNEL_ACK:
 		++channel;
+		/* fall through */
 	case HD_CLOSE_B1CHANNEL_ACK:
 		bcs = cs->bcs + channel;
 		update_basstate(ucs, 0, BS_B1OPEN << channel);
@@ -765,6 +767,7 @@ static void read_int_callback(struct urb *urb)
 
 	case HD_B2_FLOW_CONTROL:
 		++channel;
+		/* fall through */
 	case HD_B1_FLOW_CONTROL:
 		bcs = cs->bcs + channel;
 		atomic_add((l - BAS_NORMFRAME) * BAS_CORRFRAMES,
diff --git a/drivers/isdn/hardware/mISDN/avmfritz.c b/drivers/isdn/hardware/mISDN/avmfritz.c
index ae2b266..8eb28a8 100644
--- a/drivers/isdn/hardware/mISDN/avmfritz.c
+++ b/drivers/isdn/hardware/mISDN/avmfritz.c
@@ -361,6 +361,7 @@ modehdlc(struct bchannel *bch, int protocol)
 	switch (protocol) {
 	case -1: /* used for init */
 		bch->state = -1;
+		/* fall through */
 	case ISDN_P_NONE:
 		if (bch->state == ISDN_P_NONE)
 			break;
diff --git a/drivers/isdn/hardware/mISDN/hfcpci.c b/drivers/isdn/hardware/mISDN/hfcpci.c
index 34c9387..72a271b 100644
--- a/drivers/isdn/hardware/mISDN/hfcpci.c
+++ b/drivers/isdn/hardware/mISDN/hfcpci.c
@@ -1296,6 +1296,7 @@ mode_hfcpci(struct bchannel *bch, int bc, int protocol)
 	case (-1): /* used for init */
 		bch->state = -1;
 		bch->nr = bc;
+		/* fall through */
 	case (ISDN_P_NONE):
 		if (bch->state == ISDN_P_NONE)
 			return 0;
diff --git a/drivers/isdn/hardware/mISDN/mISDNinfineon.c b/drivers/isdn/hardware/mISDN/mISDNinfineon.c
index 1fc2906..3e01012 100644
--- a/drivers/isdn/hardware/mISDN/mISDNinfineon.c
+++ b/drivers/isdn/hardware/mISDN/mISDNinfineon.c
@@ -887,6 +887,7 @@ release_card(struct inf_hw *card) {
 				release_card(card->sc[i]);
 			card->sc[i] = NULL;
 		}
+		/* fall through */
 	default:
 		pci_disable_device(card->pdev);
 		pci_set_drvdata(card->pdev, NULL);
diff --git a/drivers/isdn/hardware/mISDN/mISDNisar.c b/drivers/isdn/hardware/mISDN/mISDNisar.c
index b791688..386731e 100644
--- a/drivers/isdn/hardware/mISDN/mISDNisar.c
+++ b/drivers/isdn/hardware/mISDN/mISDNisar.c
@@ -972,6 +972,7 @@ isar_pump_statev_fax(struct isar_ch *ch, u8 devt) {
 				break;
 			case PCTRL_CMD_FTM:
 				p1 = 2;
+				/* fall through */
 			case PCTRL_CMD_FTH:
 				send_mbox(ch->is, dps | ISAR_HIS_PUMPCTRL,
 					  PCTRL_CMD_SILON, 1, &p1);
@@ -1177,6 +1178,7 @@ setup_pump(struct isar_ch *ch) {
 			send_mbox(ch->is, dps | ISAR_HIS_PUMPCFG,
 				  PMOD_DTMF, 1, param);
 		}
+		/* fall through */
 	case ISDN_P_B_MODEM_ASYNC:
 		ctrl = PMOD_DATAMODEM;
 		if (test_bit(FLG_ORIGIN, &ch->bch.Flags)) {
@@ -1268,6 +1270,7 @@ setup_iom2(struct isar_ch *ch) {
 	case ISDN_P_B_MODEM_ASYNC:
 	case ISDN_P_B_T30_FAX:
 		cmsb |= IOM_CTRL_RCV;
+		/* fall through */
 	case ISDN_P_B_L2DTMF:
 		if (test_bit(FLG_DTMFSEND, &ch->bch.Flags))
 			cmsb |= IOM_CTRL_RCV;
@@ -1560,6 +1563,7 @@ isar_l2l1(struct mISDNchannel *ch, struct sk_buff *skb)
 				ich->is->name, hh->id);
 			ret = -EINVAL;
 		}
+		/* fall through */
 	default:
 		pr_info("%s: %s unknown prim(%x,%x)\n",
 			ich->is->name, __func__, hh->prim, hh->id);
diff --git a/drivers/isdn/hisax/avm_pci.c b/drivers/isdn/hisax/avm_pci.c
index a18b605..b161456 100644
--- a/drivers/isdn/hisax/avm_pci.c
+++ b/drivers/isdn/hisax/avm_pci.c
@@ -207,6 +207,7 @@ modehdlc(struct BCState *bcs, int mode, int bc)
 		bcs->mode = 1;
 		bcs->channel = bc;
 		bc = 0;
+		/* fall through */
 	case (L1_MODE_NULL):
 		if (bcs->mode == L1_MODE_NULL)
 			return;
diff --git a/drivers/isdn/hisax/callc.c b/drivers/isdn/hisax/callc.c
index ddec47a..5f43783 100644
--- a/drivers/isdn/hisax/callc.c
+++ b/drivers/isdn/hisax/callc.c
@@ -1369,6 +1369,7 @@ leased_l1l2(struct PStack *st, int pr, void *arg)
 	case (PH_ACTIVATE | INDICATION):
 	case (PH_ACTIVATE | CONFIRM):
 		event = EV_LEASED;
+		/* fall through */
 	case (PH_DEACTIVATE | INDICATION):
 	case (PH_DEACTIVATE | CONFIRM):
 		if (test_bit(FLG_TWO_DCHAN, &chanp->cs->HW_Flags))
diff --git a/drivers/isdn/hisax/config.c b/drivers/isdn/hisax/config.c
index 7108bdb8..fcc9c46 100644
--- a/drivers/isdn/hisax/config.c
+++ b/drivers/isdn/hisax/config.c
@@ -1843,6 +1843,7 @@ static void hisax_b_l2l1(struct PStack *st, int pr, void *arg)
 	case PH_DEACTIVATE | REQUEST:
 		test_and_clear_bit(BC_FLG_BUSY, &bcs->Flag);
 		skb_queue_purge(&bcs->squeue);
+		/* fall through */
 	default:
 		B_L2L1(b_if, pr, arg);
 		break;
diff --git a/drivers/isdn/hisax/gazel.c b/drivers/isdn/hisax/gazel.c
index 35c6df6..a6d8af0 100644
--- a/drivers/isdn/hisax/gazel.c
+++ b/drivers/isdn/hisax/gazel.c
@@ -108,6 +108,7 @@ ReadISAC(struct IsdnCardState *cs, u_char offset)
 	switch (cs->subtyp) {
 	case R647:
 		off2 = ((off2 << 8 & 0xf000) | (off2 & 0xf));
+		/* fall through */
 	case R685:
 		return (readreg(cs->hw.gazel.isac, off2));
 	case R753:
@@ -125,6 +126,7 @@ WriteISAC(struct IsdnCardState *cs, u_char offset, u_char value)
 	switch (cs->subtyp) {
 	case R647:
 		off2 = ((off2 << 8 & 0xf000) | (off2 & 0xf));
+		/* fall through */
 	case R685:
 		writereg(cs->hw.gazel.isac, off2, value);
 		break;
@@ -203,6 +205,7 @@ ReadHSCX(struct IsdnCardState *cs, int hscx, u_char offset)
 	switch (cs->subtyp) {
 	case R647:
 		off2 = ((off2 << 8 & 0xf000) | (off2 & 0xf));
+		/* fall through */
 	case R685:
 		return (readreg(cs->hw.gazel.hscx[hscx], off2));
 	case R753:
@@ -220,6 +223,7 @@ WriteHSCX(struct IsdnCardState *cs, int hscx, u_char offset, u_char value)
 	switch (cs->subtyp) {
 	case R647:
 		off2 = ((off2 << 8 & 0xf000) | (off2 & 0xf));
+		/* fall through */
 	case R685:
 		writereg(cs->hw.gazel.hscx[hscx], off2, value);
 		break;
diff --git a/drivers/isdn/hisax/isar.c b/drivers/isdn/hisax/isar.c
index d01ff11..82c1879 100644
--- a/drivers/isdn/hisax/isar.c
+++ b/drivers/isdn/hisax/isar.c
@@ -1089,6 +1089,7 @@ isar_pump_statev_fax(struct BCState *bcs, u_char devt) {
 				break;
 			case PCTRL_CMD_FTM:
 				p1 = 2;
+				/* fall through */
 			case PCTRL_CMD_FTH:
 				sendmsg(cs, dps | ISAR_HIS_PUMPCTRL,
 					PCTRL_CMD_SILON, 1, &p1);
@@ -1097,6 +1098,7 @@ isar_pump_statev_fax(struct BCState *bcs, u_char devt) {
 			case PCTRL_CMD_FRM:
 				if (frm_extra_delay)
 					mdelay(frm_extra_delay);
+				/* fall through */
 			case PCTRL_CMD_FRH:
 				p1 = bcs->hw.isar.mod = bcs->hw.isar.newmod;
 				bcs->hw.isar.newmod = 0;
diff --git a/drivers/isdn/hisax/l3_1tr6.c b/drivers/isdn/hisax/l3_1tr6.c
index da0a1c6..98f60d1 100644
--- a/drivers/isdn/hisax/l3_1tr6.c
+++ b/drivers/isdn/hisax/l3_1tr6.c
@@ -88,6 +88,7 @@ l3_1tr6_setup_req(struct l3_process *pc, u_char pr, void *arg)
 			break;
 		case 'C':
 			channel = 0x08;
+			/* fall through */
 		case 'P':
 			channel |= 0x80;
 			teln++;
diff --git a/drivers/isdn/hisax/l3dss1.c b/drivers/isdn/hisax/l3dss1.c
index 18a3484..368d152 100644
--- a/drivers/isdn/hisax/l3dss1.c
+++ b/drivers/isdn/hisax/l3dss1.c
@@ -1282,6 +1282,7 @@ l3dss1_setup_req(struct l3_process *pc, u_char pr,
 			switch (0x5f & *teln) {
 			case 'C':
 				channel = 0x08;
+				/* fall through */
 			case 'P':
 				channel |= 0x80;
 				teln++;
diff --git a/drivers/isdn/hysdn/hysdn_boot.c b/drivers/isdn/hysdn/hysdn_boot.c
index 4a04253..ba177c3 100644
--- a/drivers/isdn/hysdn/hysdn_boot.c
+++ b/drivers/isdn/hysdn/hysdn_boot.c
@@ -99,6 +99,7 @@ pof_handle_data(hysdn_card *card, int datlen)
 
 	case TAG_CBOOTDTA:
 		DecryptBuf(boot, datlen);	/* we need to encrypt the buffer */
+		/* fall through */
 	case TAG_BOOTDTA:
 		if (card->debug_flags & LOG_POF_RECORD)
 			hysdn_addlog(card, "POF got %s len=%d offs=0x%lx",
@@ -137,6 +138,7 @@ pof_handle_data(hysdn_card *card, int datlen)
 
 	case TAG_CABSDATA:
 		DecryptBuf(boot, datlen);	/* we need to encrypt the buffer */
+		/* fall through */
 	case TAG_ABSDATA:
 		if (card->debug_flags & LOG_POF_RECORD)
 			hysdn_addlog(card, "POF got %s len=%d offs=0x%lx",
diff --git a/drivers/isdn/i4l/isdn_v110.c b/drivers/isdn/i4l/isdn_v110.c
index 8b74ce4..2a5f666 100644
--- a/drivers/isdn/i4l/isdn_v110.c
+++ b/drivers/isdn/i4l/isdn_v110.c
@@ -354,6 +354,7 @@ EncodeMatrix(unsigned char *buf, int len, unsigned char *m, int mlen)
 				printk(KERN_WARNING "isdn_v110 (EncodeMatrix): buffer full!\n");
 				return line;
 			}
+			/* else: fall through */
 		case 128:
 			m[line] = 128;	/* leftmost -> set byte to 1000000 */
 			mbit = 64;	/* current bit in the matrix line */
@@ -386,20 +387,28 @@ EncodeMatrix(unsigned char *buf, int len, unsigned char *m, int mlen)
 		switch (++line % 10) {
 		case 1:
 			m[line++] = 0xfe;
+			/* fall through */
 		case 2:
 			m[line++] = 0xfe;
+			/* fall through */
 		case 3:
 			m[line++] = 0xfe;
+			/* fall through */
 		case 4:
 			m[line++] = 0xfe;
+			/* fall through */
 		case 5:
 			m[line++] = 0xbf;
+			/* fall through */
 		case 6:
 			m[line++] = 0xfe;
+			/* fall through */
 		case 7:
 			m[line++] = 0xfe;
+			/* fall through */
 		case 8:
 			m[line++] = 0xfe;
+			/* fall through */
 		case 9:
 			m[line++] = 0xfe;
 		}
diff --git a/drivers/isdn/mISDN/stack.c b/drivers/isdn/mISDN/stack.c
index 422dced..d97c6dd 100644
--- a/drivers/isdn/mISDN/stack.c
+++ b/drivers/isdn/mISDN/stack.c
@@ -539,6 +539,7 @@ create_l2entity(struct mISDNdevice *dev, struct mISDNchannel *ch,
 		rq.protocol = ISDN_P_NT_S0;
 		if (dev->Dprotocols & (1 << ISDN_P_NT_E1))
 			rq.protocol = ISDN_P_NT_E1;
+		/* fall through */
 	case ISDN_P_LAPD_TE:
 		ch->recv = mISDN_queue_message;
 		ch->peer = &dev->D.st->own;
-- 
2.7.4

