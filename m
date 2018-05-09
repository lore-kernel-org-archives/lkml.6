Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-206431-1525860776-2-12682031782804930440
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, RCVD_IN_SORBS_WEB 1.5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525860776; b=EuZobEcdzZA9v4Wa5pnN1btK1DNdgKUC12499YNqHIDUKip26b
    SoFBMjsfkKlt+DKEtshb2W2lg9RVBIHHyt4olW2wvG7wZOfvvOGsy/jYatHEt0og
    G5j89Wq/BN3uIudrcuXGRZKc9hLjeiTBNSbXm442jM+zAzhlDQpT2FL5Nebs3KyW
    3bdjdt456f3iYdX0yCMgjCROuwsT6COHHP+MrLTzJlRaldWbsh8QnC+EqKih7tqO
    l7NYRLbS/BvuWUIo3C1UTayDFlmATetz12h6MwGDOO3ikgxefkk9erKfynVS7lSo
    Hz1Ar2A1n4iQsheY4vifcUOwYVCOaUIBInHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525860776; bh=
    2B6qjcWo/0MFCtJ2tQQ4rFwZF/3C6d5grZ/M7+3kkzk=; b=KTYUsUJuVBUaYc81
    v+Dmd4YP0ANoQHT8o2oauKDhP4mLBbuvM27vzCSzyhjQ8HKnQGr5lSfQXum01e59
    1m7t5Uk/p9pttKG5koZwGxQzQuVBPkQGemhAY9D23BBmloPo4ZEAD+dXsjjSvQZV
    FZcV+u62cUlJFsDEvOeBnSmFRjcOQcfPBCnGxw56QcjQjzRtMkUOE/TlPqM8sHOq
    tA6KP/BVo7zNf41HuOKYE15lpntSuFRhruxajqmVMpsQgJVmsC58lrubDxir7aQI
    VN+dSWFVxal3dno2mDF+ibofboAKuYqL+ro2IdvlvdyD0RQsMTxleuq2iDu5q5b5
    0GaRxw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfIwKsJqJgjrEKEq9Cc2FkTwHZ5LyYeXgz4dSyaSYlGHu4G0opvJvzl8IDHXnWjFcNuASTzFjCm3SzF6O2v6okMAM9dzJiE3nT/QGI5PITcatN3DCydT0
    qByKOSqtKE9xKSOneDi84g9fOMWgWXsFbGKx0S4gYYpCJb2e2jLZYT7+zjqKzo+MO4k7D2Xk5TgAFjlwMY0eCJuh5QtG3xza2wt/jg6Vpp92i/KkRFcqhsWT
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=4_-BN3WEXhEA:10 a=VUJBJC2UJ8kA:10
    a=s8YR1HE3AAAA:8 a=VwQbUJbxAAAA:8 a=ZvVp6P6bRAB-60_p9RoA:9
    a=JUXAwFLBUM4cW0Se:21 a=BbKhak3R6c8ITP1t:21 a=x8gzFH9gYPwA:10
    a=jGH_LyMDp9YhSvY-UuyI:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934479AbeEIKMl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 06:12:41 -0400
Received: from regular1.263xmail.com ([211.150.99.132]:36414 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934288AbeEIKMc (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 9 May 2018 06:12:32 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: william.wu@rock-chips.com
X-FST-TO: hminas@synopsys.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: william.wu@rock-chips.com
X-UNIQUE-TAG: <2d80648360591190056a8074192f86fd>
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
Subject: [PATCH v4 2/2] usb: dwc2: fix isoc split in transfer with no data
Date: Wed,  9 May 2018 18:11:01 +0800
Message-Id: <1525860661-18619-3-git-send-email-william.wu@rock-chips.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1525860661-18619-1-git-send-email-william.wu@rock-chips.com>
References: <1525860661-18619-1-git-send-email-william.wu@rock-chips.com>
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
Changes in v4:
- None

Changes in v3:
- Remove "qtd->isoc_split_offset = 0" in the if test

Changes in v2:
- Modify the commit message

 drivers/usb/dwc2/hcd_intr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
index ba6229e..9751785 100644
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


