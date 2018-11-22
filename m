Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1881C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A202220892
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKqzT4Pn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A202220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437127AbeKWAcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:32:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36867 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437061AbeKWAcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:32:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id j10so9342236wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 05:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tkjpCXJtTxG2iy23KggkSQUxzqdVmjVeFeq9szw5joQ=;
        b=TKqzT4Pnka72l6hCEwLm6T8eqAKk5/fYqglNuIkYfK9x2vvru9VXBIQpyuoe+guv7Y
         PlM+qW4SoynEMVnYJoK/lCyd+I5g90zKybFVroU6BJvwkzNYGqPRVNLLhHD275FhZyi3
         8aCEVnzEQtbDWFH6gBPQumjH+6ZhVuEgjA43p9YlR9jvAiv9Ed7CkoMurI9kXmz7UUsh
         PI5NUwvjt9gq1irimorHyfyFYlsvZb5lN7ZcoQ1rjmZLxCPUn1LqltDNWsRxJdMuSET+
         uWB9lErLkzfEDtPVRrS/fsvCTNX4hmwVd9NSE3zxpG+VjdMvIWPuam1iFD8RHiRqJUmt
         IbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tkjpCXJtTxG2iy23KggkSQUxzqdVmjVeFeq9szw5joQ=;
        b=QvdSvF2mF0Vh194OX5T5NGOJihQPQ+CNUcwSR/W1ay6gws1rgIsgF8aJ3pSgKE+0PW
         qvHTjN/1Ja8nsDHxo+3VifYyCAEtyXmHH0WvwVrPNVS4+6xYKgJEsnYmE7nkbH/+6ICc
         30SiCQY82Sz4jmX7/+ishy6IfT64nLFxX56DTIiNzsAUD4EHXLE2HmObQisqNjr0DUIM
         BcT3ih2Vppt7VMUXl8caczsJ4AlmpBt9tJWtUFWJEUjrJH17QjjjgjGGsP1/KagY1zdX
         jnbgPAGRghihI/mN4QOlWbQ/DyGxfcOeS7vzKtixaZkOAmTYDOW3Ph+JlYACNhMXmn/G
         +lGg==
X-Gm-Message-State: AA+aEWYc6ymI43IyC1NM9pVAXyUJy8BBdpcsLqiJDBE78Bqx9B24Q1l8
        MJ5POz84+l8A5ngqU8z94nY=
X-Google-Smtp-Source: AFSGD/XDJukJylQNLY8wjyw7bHJer55CadLoh8mINUFz2ybR3cQaYJDKjBa5D8PqRU62rxAFJFgHug==
X-Received: by 2002:adf:d089:: with SMTP id y9mr9993195wrh.22.1542894758227;
        Thu, 22 Nov 2018 05:52:38 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id c188-v6sm2393285wma.39.2018.11.22.05.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:52:37 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/8] staging: rtl8188eu: cleanup declarations in usb_ops_linux.c
Date:   Thu, 22 Nov 2018 14:52:17 +0100
Message-Id: <20181122135218.1703-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122135218.1703-1-straube.linux@gmail.com>
References: <20181122135218.1703-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces and/or remove spaces in declarations
to cleanup whitespace.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/os_dep/usb_ops_linux.c  | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index 4821ce2fa762..9a732adbf1b1 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -31,18 +31,18 @@ static void interrupt_handler_8188eu(struct adapter *adapt, u16 pkt_len, u8 *pbu
 
 static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 {
-	u8	*pbuf;
-	u8	shift_sz = 0;
-	u16	pkt_cnt;
-	u32	pkt_offset, skb_len, alloc_sz;
-	s32	transfer_len;
-	struct recv_stat	*prxstat;
-	struct phy_stat	*pphy_status = NULL;
+	u8 *pbuf;
+	u8 shift_sz = 0;
+	u16 pkt_cnt;
+	u32 pkt_offset, skb_len, alloc_sz;
+	s32 transfer_len;
+	struct recv_stat *prxstat;
+	struct phy_stat *pphy_status = NULL;
 	struct sk_buff *pkt_copy = NULL;
-	struct recv_frame	*precvframe = NULL;
-	struct rx_pkt_attrib	*pattrib = NULL;
+	struct recv_frame *precvframe = NULL;
+	struct rx_pkt_attrib *pattrib = NULL;
 	struct hal_data_8188e *haldata = adapt->HalData;
-	struct recv_priv	*precvpriv = &adapt->recvpriv;
+	struct recv_priv *precvpriv = &adapt->recvpriv;
 	struct __queue *pfree_recv_queue = &precvpriv->free_recv_queue;
 
 	transfer_len = (s32)pskb->len;
@@ -201,7 +201,7 @@ unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr)
 
 static int usbctrl_vendorreq(struct adapter *adapt, u8 request, u16 value, u16 index, void *pdata, u16 len, u8 requesttype)
 {
-	struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
+	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
 	struct usb_device *udev = dvobjpriv->pusbdev;
 	unsigned int pipe;
 	int status = 0;
@@ -349,8 +349,8 @@ u32 usb_read32(struct adapter *adapter, u32 addr)
 
 static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 {
-	struct recv_buf	*precvbuf = (struct recv_buf *)purb->context;
-	struct adapter	*adapt = (struct adapter *)precvbuf->adapter;
+	struct recv_buf *precvbuf = (struct recv_buf *)purb->context;
+	struct adapter *adapt = (struct adapter *)precvbuf->adapter;
 	struct recv_priv *precvpriv = &adapt->recvpriv;
 
 	RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("%s!!!\n", __func__));
@@ -426,9 +426,9 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 u32 usb_read_port(struct adapter *adapter, u32 addr, struct recv_buf *precvbuf)
 {
 	struct urb *purb = NULL;
-	struct dvobj_priv	*pdvobj = adapter_to_dvobj(adapter);
-	struct recv_priv	*precvpriv = &adapter->recvpriv;
-	struct usb_device	*pusbd = pdvobj->pusbdev;
+	struct dvobj_priv *pdvobj = adapter_to_dvobj(adapter);
+	struct recv_priv *precvpriv = &adapter->recvpriv;
+	struct usb_device *pusbd = pdvobj->pusbdev;
 	int err;
 	unsigned int pipe;
 	u32 ret = _SUCCESS;
@@ -573,8 +573,8 @@ int usb_write32(struct adapter *adapter, u32 addr, u32 val)
 static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
 {
 	struct xmit_buf *pxmitbuf = (struct xmit_buf *)purb->context;
-	struct adapter	*padapter = pxmitbuf->padapter;
-	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
+	struct adapter *padapter = pxmitbuf->padapter;
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 
 	switch (pxmitbuf->flags) {
 	case VO_QUEUE_INX:
@@ -662,8 +662,8 @@ u32 usb_write_port(struct adapter *padapter, u32 addr, u32 cnt, struct xmit_buf
 	int status;
 	u32 ret = _FAIL;
 	struct urb *purb = NULL;
-	struct dvobj_priv	*pdvobj = adapter_to_dvobj(padapter);
-	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
+	struct dvobj_priv *pdvobj = adapter_to_dvobj(padapter);
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	struct xmit_frame *pxmitframe = (struct xmit_frame *)xmitbuf->priv_data;
 	struct usb_device *pusbd = pdvobj->pusbdev;
 
-- 
2.19.1

