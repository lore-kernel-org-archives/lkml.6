Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EEFC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F6B214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEjuVTQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F6B214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeJIXGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:06:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35399 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIXGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:06:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id e187-v6so2564122wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HvpNRSJox04iKj6UBlOYhkD1QomMsyvwWBoGA2g23Ao=;
        b=nEjuVTQjlrgO3cVTKeiESUvLyFj3h7uDz0jOr6FaRGGVHSMnL+4gz7Kw8neLKQHCSq
         Vk7pofx+wztWdV1eXFjxjLN8tOdWKZreEvVV9lbRYYr+P2DFCTkoHCKsbHU+QSVyZ3mM
         01qs3kMl+Dw8wiXkU8J5MeUy+42dDuIZVAUMccW+jwn4jix+3cv6Ngzu2FpKL+Z6KxtC
         ML0LgNnaoTOZRiIAM+abofaAIy710ch2iwTpLm3SuRSfkrEIpL3QajzV2hObDYxZdklN
         7Mlgw+DTHktEy6vzkOW9AZNwbzOaqfHZ9llMcHYst+6dd4yLpDIDw9OgOyio71PW0d0o
         HaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HvpNRSJox04iKj6UBlOYhkD1QomMsyvwWBoGA2g23Ao=;
        b=fq/q8A7YewLTxtxGfMOmJsrBI15i+Gexq3PnM101PbkrxiO2cvuGMBwiR6jkmK2m/t
         jmWNBgltpeEGQ3gFSoCn4+vhmkQ1nDIx6v0B0SnRMAX1M4p7gU+08uiHiO4aSwHR+H+S
         Gsi82/Vszj7un2jUj6f3eHr2gRDq+BbZikVYamsbo9suVvIHxGeE5PwiXQUuVZCCieUq
         mwEtUlbf4NjAF9g24DlcsaP+gnDZ5TIBjGEy6/30D/lZnEmZjTef/txyr3+K6BmOU3Wm
         Gr4MqinOzAYpvOOtfywGG5YF+uYZRRW3EhrTGaT9G6NL6FvoEtuxGnCnoUopqXUFKNra
         by8Q==
X-Gm-Message-State: ABuFfojyHz/lJSKGjoAmBuRMuwVasdeUEJALry8dEq42EDDnN5qsDaYl
        N+Rvw3oojXMCzKt+i7Mrvwg=
X-Google-Smtp-Source: ACcGV63O7ib7iwDs0Tqu/AUPJ1/AaSIS16nJrcHqDoNdo2euG70KGcQPzixS2zIYqPjXOQmeGbuYyw==
X-Received: by 2002:a1c:2bc3:: with SMTP id r186-v6mr2554225wmr.51.1539100147930;
        Tue, 09 Oct 2018 08:49:07 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fa83.dynamic.kabel-deutschland.de. [31.18.250.131])
        by smtp.gmail.com with ESMTPSA id o130-v6sm10907338wmd.11.2018.10.09.08.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 08:49:07 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: rtl8188eu: add spaces around operators - style
Date:   Tue,  9 Oct 2018 17:48:52 +0200
Message-Id: <20181009154854.9054-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181009154854.9054-1-straube.linux@gmail.com>
References: <20181009154854.9054-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '*' and '/' to follow kernel coding style.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
index 8e250f2bf39b..8de0fc53103c 100644
--- a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
@@ -45,7 +45,7 @@ void rtw_os_xmit_resource_free(struct xmit_buf *pxmitbuf)
 	kfree(pxmitbuf->pallocated_buf);
 }
 
-#define WMM_XMIT_THRESHOLD	(NR_XMITFRAME*2/5)
+#define WMM_XMIT_THRESHOLD	(NR_XMITFRAME * 2 / 5)
 
 void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt)
 {
@@ -176,7 +176,7 @@ int rtw_xmit_entry(struct sk_buff *pkt, struct  net_device *pnetdev)
 	if (!rtw_mc2u_disable && check_fwstate(pmlmepriv, WIFI_AP_STATE) &&
 	    (IP_MCAST_MAC(pkt->data) || ICMPV6_MCAST_MAC(pkt->data)) &&
 	    (padapter->registrypriv.wifi_spec == 0)) {
-		if (pxmitpriv->free_xmitframe_cnt > (NR_XMITFRAME/4)) {
+		if (pxmitpriv->free_xmitframe_cnt > NR_XMITFRAME / 4) {
 			res = rtw_mlcst2unicst(padapter, pkt);
 			if (res)
 				goto exit;
-- 
2.19.1

