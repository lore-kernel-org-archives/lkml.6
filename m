Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47BCC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCEA21566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvHJ9Dhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCEA21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbeI0XXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:23:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37525 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeI0XXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:23:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id y26-v6so6093862wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iDujm++goOjKgEaG66kR7P0cLsPcZZPV703TXN2hveM=;
        b=XvHJ9Dhr/zHEbB8+/tobtn4yS/p/hRP+qIX87ENYgV9DyhIlccPv9jHgAXzTyMmhCm
         6LC5vQcQoap/b/tARZApAEnZngRTlEQ3lRqKMqaLwgvM+TlGdCoVlG/DdkxSYSa+TMx1
         zanj9kzEtW/QE2p8QO9pLW8M8sPBolxHCOlGleVJTFM4ofk2Bm5ezUzMOoMBkzgxOGww
         ZdaCjpbt3n1+793syaLGnVzB322kChaDfl/n1GnvxQ4PeCAj8EwY5dDpoHQqKTUl7koM
         3Ja3QnuH0IMN1uLNeKsPjWQUWOQc+NIDlWna3utmmAKperCTHeyolEl9W1wDoNIZT46q
         +yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iDujm++goOjKgEaG66kR7P0cLsPcZZPV703TXN2hveM=;
        b=fKOk754p18A2YTQy/+dO4lzBtuOJ2Orsq8oYYTfJtisXmBFQqJFqlWmY7jZKKVA/rj
         7LtWrKQ0aKPEDfF90VxOhw8ngr4YaMmlMHqruov2yhz6SfDM5RlhgvAl0iwlxNvADeew
         8N8iiOFKpCoogbw8KZVfrFl2XJZVakNdkg/QPW1wC0o8m6Epi5KPlRthT467up4QkcPK
         6a8mhrIEvVUec0ulOI7ssuGgPyOC9dn1uniUUx0UUJf6FhhYTqNg4RxGoo3w+spk8ap7
         kZfC9NuwvZTf2TTgpyCBD9xdCHANfAA7nwCYk0SBNZcaZteZ0j3snKCusun7uMNaWHzf
         aPsg==
X-Gm-Message-State: ABuFfohnidcoKVn4gBsS9mT6PJN6jYWBiuKyTbKieFa+DltUSqNBgR5q
        GBrkJRW3Xc76FFxq+q55Wvg=
X-Google-Smtp-Source: ACcGV60dWLUqAmGHNTe9NlOGu+w7N7l2s55CSmWFMUbY48jmakazx3rr+XPF7OKsmZyeQo7dcYV6Pw==
X-Received: by 2002:a1c:e00a:: with SMTP id x10-v6mr8282510wmg.58.1538067856331;
        Thu, 27 Sep 2018 10:04:16 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:5])
        by smtp.gmail.com with ESMTPSA id y25-v6sm1956508wmi.46.2018.09.27.10.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 10:04:15 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Aymen Qader <qader.aymen@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: Avoid null pointer arithmetic
Date:   Thu, 27 Sep 2018 18:04:08 +0100
Message-Id: <20180927170408.4495-1-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid null pointer arithmetic in rtw_mlme_ext.c by skipping other field
checks if the information element pointer is null.

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 834053a0ae9d..8a3a71456cd0 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -2971,8 +2971,10 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 	/*  checking SSID */
 	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _SSID_IE_, &ie_len,
 		pkt_len - WLAN_HDR_A3_LEN - ie_offset);
-	if (!p)
+	if (!p) {
 		status = _STATS_FAILURE_;
+		goto OnAssocReqFail;
+	}
 
 	if (ie_len == 0) { /*  broadcast ssid, however it is not allowed in assocreq */
 		status = _STATS_FAILURE_;
-- 
2.17.1

