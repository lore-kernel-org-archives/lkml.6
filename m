Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2036687-1525748968-2-12995012008348748165
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, RCVD_IN_SORBS_WEB 1.5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525748967; b=ch0eBZh/uTGlVcJ+N6kNqWQVouHuEVjuMT+lx6r5DjJ60noWNu
    wPaRSw3Chaoh6o7gF0njXyCC2QqB42JYX3HHj4NSvcPOJ6V7vscEgt8XL6dn4oke
    yoKfqQZ4kAoB1V5aEQeu04Bt3TQ+5xcuNNVwCUuAqLhp/g4kACcYuJ2ckiy235+R
    yolyB4xIr6KeHS91TSYzCDzcNSd6rYt3SO5lhut5/sNOmbY23H3abhw2NKJpy1c9
    RVl48JtV04Q9XOCtteSpF28BK7C0xInwbbExFXgTHwrzQDx2Okp8XfneTVUvNlJF
    EQzoPRjA4DWAdqO+7zsLGk/G3ToOq2F2PXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525748967; bh=
    rkBKEz4P55AkURRLg/E0Vv2tAbJMb/xlDAJAqBIb0LE=; b=j1qrJ3CEC9YQWMG4
    Y3ATzkIc3awlDxr4YfSyIoigHVk3Iwn3Rsv5cYyWiN1dHeQOCIlh4TvEamcDK5yF
    PaI/Ta4DdTFnkcH3X4OUAg8YCukIXvYTv4/X788fyDC9y9YRMT7qnF99aHXwEahK
    YV+aYXEe9Mhka8/eki8i9ijQ1qkVFsXXvgROPrc6d5Y2xGOhIOYLnlruZ24ju5FU
    mQFFMpfkBfe16BC3i4F93k4ZeFeSs7+jnkbjwGHyPmfQQf6dpvzZZ3Bg3qwJxE7s
    n69xCclKlzI/iYUF/u1aU5+hdciyKv7l4TuUk56edEt/EYbdEMj7YSNEAcCSjgYR
    lZbP9A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=rock-chips.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=rock-chips.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJp3aRXpjwAIDgNYD1nVLxMZK9kZkf9CycMExbJAVEcKocScTgcFRFagpOozxWVV5bF07wrDALYIvm8J/r42ppS8+cmDxYvf6dlCSXoDWCRZFyBPsBbO
    Behc7xkXkqCsizXzky4JhgJ8vm7Xj/Le+/6iVLqsMPxh8d/KT71ecz6mkApczPloNIKSmViC/i6pHTd9aAk+/Swe7w024tlb7sNx6RoEqG1BtxqhHgg6n0hs
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=4_-BN3WEXhEA:10 a=VUJBJC2UJ8kA:10
    a=s8YR1HE3AAAA:8 a=VwQbUJbxAAAA:8 a=ZvVp6P6bRAB-60_p9RoA:9
    a=OKuXXkLbgm8jtzLI:21 a=peugBkb-4IPNGEnD:21 a=x8gzFH9gYPwA:10
    a=jGH_LyMDp9YhSvY-UuyI:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754096AbeEHDI7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 23:08:59 -0400
Received: from regular1.263xmail.com ([211.150.99.132]:58017 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753896AbeEHDI4 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 7 May 2018 23:08:56 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: william.wu@rock-chips.com
X-FST-TO: hminas@synopsys.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: william.wu@rock-chips.com
X-UNIQUE-TAG: <b187848c152f14142abda23b9f072b32>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: William Wu <william.wu@rock-chips.com>
To: hminas@synopsys.com, felipe.balbi@linux.intel.com,
        gregkh@linuxfoundation.org
Cc: sergei.shtylyov@cogentembedded.com, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-rockchip@lists.infradead.org, frank.wang@rock-chips.com,
        huangtao@rock-chips.com, dianders@google.com,
        daniel.meng@rock-chips.com, John.Youn@synopsys.com,
        william.wu@rock-chips.com, wzz@rock-chips.com, zsq@rock-chips.com,
        Allen.Hsu@quantatw.com, StanTsui@AOPEN.com, Spruce.Wu@quantatw.com,
        Martin.Tsai@quantatw.com, Kevin.Shai@quantatw.com,
        Mon-Jer.Wu@quantatw.com, Claud.Chang@quantatw.com,
        San.Lin@quantatw.com, Ren.Kuo@quantatw.com, davidhtwang@aopen.com,
        fonglin@aopen.com, stevencheng@aopen.com, tomchen@aopen.com,
        donchang@aopen.com, milesschofield@aopen.com
Subject: [PATCH v3 2/2] usb: dwc2: fix isoc split in transfer with no data
Date: Tue,  8 May 2018 11:07:26 +0800
Message-Id: <1525748846-7767-3-git-send-email-william.wu@rock-chips.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1525748846-7767-1-git-send-email-william.wu@rock-chips.com>
References: <1525748846-7767-1-git-send-email-william.wu@rock-chips.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If isoc split in transfer with no data (the length of DATA0
packet is zero), we can't simply return immediately. Because
the DATA0 can be the first transaction or the second transaction
for the isoc split in transaction. If the DATA0 packet with no
data is in the first transaction, we can return immediately.
But if the DATA0 packet with no data is in the second transaction
of isoc split in transaction sequence, we need to increase the
qtd->isoc_frame_index and giveback urb to device driver if needed,
otherwise, the MDATA packet will be lost.

A typical test case is that connect the dwc2 controller with an
usb hs Hub (GL852G-12), and plug an usb fs audio device (Plantronics
headset) into the downstream port of Hub. Then use the usb mic
to record, we can find noise when playback.

In the case, the isoc split in transaction sequence like this:

- SSPLIT IN transaction
- CSPLIT IN transaction
  - MDATA packet (176 bytes)
- CSPLIT IN transaction
  - DATA0 packet (0 byte)

This patch use both the length of DATA0 and qtd->isoc_split_offset
to check if the DATA0 is in the second transaction.

Signed-off-by: William Wu <william.wu@rock-chips.com>
---
Changes in v3:
- Remove "qtd->isoc_split_offset = 0" in the if test

Changes in v2:
- Modify the commit message

 drivers/usb/dwc2/hcd_intr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
index ba6fd852..3003594 100644
--- a/drivers/usb/dwc2/hcd_intr.c
+++ b/drivers/usb/dwc2/hcd_intr.c
@@ -930,9 +930,8 @@ static int dwc2_xfercomp_isoc_split_in(struct dwc2_hsotg *hsotg,
 	frame_desc = &qtd->urb->iso_descs[qtd->isoc_frame_index];
 	len = dwc2_get_actual_xfer_length(hsotg, chan, chnum, qtd,
 					  DWC2_HC_XFER_COMPLETE, NULL);
-	if (!len) {
+	if (!len && !qtd->isoc_split_offset) {
 		qtd->complete_split = 0;
-		qtd->isoc_split_offset = 0;
 		return 0;
 	}
 
-- 
2.0.0


