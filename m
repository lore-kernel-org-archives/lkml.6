Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELuy6/ZIh4ilcIFVbSsfBeEzdnyjRJYv5B7FkNFV3XBMBfpczhMlmVP2SrV8/JYPMgniv6ej
ARC-Seal: i=1; a=rsa-sha256; t=1522140098; cv=none;
        d=google.com; s=arc-20160816;
        b=QG9RZwXZ7nE+1q2ocYl7EsPny9bDvslrJyUmAwxYyTqvBBUEauYHmEq4ZFAvkv9rQn
         a3+ryBjrTx2/OqFEryunkxcL0pg6Gqgny8yxgMjXwbdnsRp7IImmkBjC/B6xqcLLYzpU
         6OVT8bhC+1oW4F5xnVVr3xTATwB2kxwTNCjicSvURaPb2XD3mA+hPfJAYj9wvWoR6OFg
         op88hkTRnHzwhF8GBe6yetyN/oFa0UNfrx086L/CyDGuwrl8OC1VI/t7NgODZD43s3uw
         XMFISfdSf5WqMfnBbj9m57DZtYUJNuhdVOd3pFXsqvlp5K6L4mxKgLnFEdV5jobESZ+m
         gUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=rlM3zVU5CJxkvnSHNwQxeqw7KpZl/xwv+PGKMILaAJI=;
        b=BHoyVLh9afb8FT7NEyX9AcJcRO/Bb0TFNOxbjNJBkt3103ZSc+q8qemmTQbYKbDhdI
         GzFy0SVuouYErOqEAvYAAVuwRB1nyuPIMR2y5mG5KLV6f55Nw+K3dQjKi8a92KRDdf06
         VXwcGZEvCZhvqOOxdMtBgoeLju60WnE3No3dV0Z19o0a6qcOV2HEbSM5IEPWbDA7Z14u
         vI1GDtNUjjD8Z2OYp63xjfdIMwENcM+GdnX10tI4lX4kSb+345fbZ8jnTyXXepK0iihs
         lGnLNK6ASDNDxYNy5TtEIOxr7R30z9mHeRJ1AGlsAR/SR4MdJ0xFKXXoHWBo21tOFZj+
         43lw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 19/23] staging: rtl8723bs: Factor out rtl8723bs_recv_tasklet() sections.
Date: Tue, 27 Mar 2018 01:41:11 -0700
Message-Id: <20180327084115.16129-19-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:fGiBRHDBrjHY4XiIVh32BGAz/nvJURti0OSnCnV3mKmfPNQ8bMq
 1uIiykhwFt4gbuuoSn1BW1tmRKRQD2ahFdNIIwc8z2UkYht81jKcbGodPo8hSK2Rk+fyOhi
 mv6QnTt/dTZP7e01L7YxXGJtJvAa5VdOZe2PZAqGKRBpNHmgE51bmfZziaslIwugNDhN916
 XoYaWZglkadBEwkev7IRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w5zhEFVkbWs=:EVpf1EM8XLLS6oKb+IOMqe
 VQLDh+qY8T5VMz+4Z+XycuDrR4Bw9jQVLYHN1KvTO8OB3YBGCIvFadEowNp6jdzvYX0iNX/fC
 4McPbAEg8pIn8mwKSK9qukJVTV4x3MmJbrxkkqQlWq6yrWBQckDRqEN6opFl83GgSr9O3rlOg
 ZzAgy8jBIp0c+SA+LinpadH8E7BqEJtiWHdl/VW2pgnZuwsyUvQ5MHJeicgW25XanLfXRcnik
 QIz6X2XD4FX/Kb3G691Zs5HMchPaUbaI7t80DAp0nzB0U8N893LoDzT2lEnJmKv7UcxbaOmHr
 C2WzQ99xaDO26UOnhUTCcE/sIFAUnMx/es3eJItKRTibQULipxpm73AqJY7LtchCklqJDwIVV
 qDKek6PF2S8RKHQKsPiKUo+asCPzfYPbS0O8k6m7ve/raOcC11ePmQolMVzsA/UARiLV1CDRv
 PDxzcrCzBOdjanDLe45PKl7/61/PH2sP+JKYAMz2B1sjn2JI2RWsQhivUfOOhLZWQ62WKsSn5
 H2xoQNRqpqDztNrq0GccsGTc6LYsA0o9YMTHRW1crqDetjFBKJ9YkgqSa3v7aXo2hQrYD6XK3
 6J0sHrjRcJ9n7jpnwO1IJHZQbnqn7/BjH3fYvgpRA5sJOVjkYY3qiN27mhs8CnXPyVlxKJz/u
 qabn2u128RJbzjsKnPCRdCFBwQjA9tn7vWlX5n6a+umU1sIBu7+x3x/GCfAGmIisAaLurCd0V
 u+6Yi57+h+crUJ50tLEkw/R5Mvnc0oSGoKbnNg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079575554329626?=
X-GMAIL-MSGID: =?utf-8?q?1596079575554329626?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Factor out code from rtl8723bs_recv_tasklet() into helper methods
to unindent lines over 80 characters.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 95 +++++++++++++++++++-------
 1 file changed, 69 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index c4851a825fbb..038481655858 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -189,6 +189,55 @@ static void rtl8723bs_c2h_packet_handler(struct adapter *padapter,
 	return;
 }
 
+static inline union recv_frame *try_alloc_recvframe(struct recv_priv *precvpriv,
+						    struct recv_buf *precvbuf)
+{
+	union recv_frame *precvframe;
+
+	precvframe = rtw_alloc_recvframe(&precvpriv->free_recv_queue);
+	if (!precvframe) {
+		DBG_8192C("%s: no enough recv frame!\n", __func__);
+		rtw_enqueue_recvbuf_to_head(precvbuf,
+					    &precvpriv->recv_buf_pending_queue);
+
+		/*  The case of can't allocte recvframe should be temporary, */
+		/*  schedule again and hope recvframe is available next time. */
+		tasklet_schedule(&precvpriv->recv_tasklet);
+	}
+
+	return precvframe;
+}
+
+static inline bool rx_crc_err(struct recv_priv *precvpriv,
+			      struct hal_com_data *p_hal_data,
+			      struct rx_pkt_attrib *pattrib,
+			      union recv_frame *precvframe)
+{
+	/*  fix Hardware RX data error, drop whole recv_buffer */
+	if ((!(p_hal_data->ReceiveConfig & RCR_ACRC32)) && pattrib->crc_err) {
+		DBG_8192C("%s()-%d: RX Warning! rx CRC ERROR !!\n",
+			  __func__, __LINE__);
+		rtw_free_recvframe(precvframe, &precvpriv->free_recv_queue);
+		return true;
+	}
+
+	return false;
+}
+
+static inline bool pkt_exceeds_tail(struct recv_priv *precvpriv,
+				    u8 *end, u8 *tail,
+				    union recv_frame *precvframe)
+{
+	if (end > tail) {
+		DBG_8192C("%s()-%d: : next pkt len(%p,%d) exceed ptail(%p)!\n",
+			  __func__, __LINE__, ptr, pkt_offset, precvbuf->ptail);
+		rtw_free_recvframe(precvframe, &precvpriv->free_recv_queue);
+		return true;
+	}
+
+	return false;
+}
+
 static void rtl8723bs_recv_tasklet(void *priv)
 {
 	struct adapter *padapter;
@@ -197,6 +246,7 @@ static void rtl8723bs_recv_tasklet(void *priv)
 	struct recv_buf *precvbuf;
 	union recv_frame *precvframe;
 	struct rx_pkt_attrib *pattrib;
+	struct __queue *recv_buf_queue;
 	u8 *ptr;
 	u32 pkt_offset, skb_len, alloc_sz;
 	_pkt *pkt_copy = NULL;
@@ -205,52 +255,45 @@ static void rtl8723bs_recv_tasklet(void *priv)
 	padapter = priv;
 	p_hal_data = GET_HAL_DATA(padapter);
 	precvpriv = &padapter->recvpriv;
+	recv_buf_queue = &precvpriv->recv_buf_pending_queue;
 
 	do {
-		precvbuf = rtw_dequeue_recvbuf(&precvpriv->recv_buf_pending_queue);
+		precvbuf = rtw_dequeue_recvbuf(recv_buf_queue);
 		if (NULL == precvbuf)
 			break;
 
 		ptr = precvbuf->pdata;
 
 		while (ptr < precvbuf->ptail) {
-			precvframe = rtw_alloc_recvframe(&precvpriv->free_recv_queue);
-			if (precvframe == NULL) {
-				DBG_8192C("%s: no enough recv frame!\n", __func__);
-				rtw_enqueue_recvbuf_to_head(precvbuf, &precvpriv->recv_buf_pending_queue);
-
-				/*  The case of can't allocte recvframe should be temporary, */
-				/*  schedule again and hope recvframe is available next time. */
-				tasklet_schedule(&precvpriv->recv_tasklet);
+			precvframe = try_alloc_recvframe(precvpriv, precvbuf);
+			if(!precvframe)
 				return;
-			}
 
 			/* rx desc parsing */
-			update_recvframe_attrib(padapter, precvframe, (struct recv_stat *)ptr);
+			update_recvframe_attrib(padapter, precvframe,
+						(struct recv_stat *)ptr);
 
 			pattrib = &precvframe->u.hdr.attrib;
 
-			/*  fix Hardware RX data error, drop whole recv_buffer */
-			if ((!(p_hal_data->ReceiveConfig & RCR_ACRC32)) && pattrib->crc_err) {
-				DBG_8192C("%s()-%d: RX Warning! rx CRC ERROR !!\n", __func__, __LINE__);
-				rtw_free_recvframe(precvframe, &precvpriv->free_recv_queue);
+			if(rx_crc_err(precvpriv, p_hal_data,
+				      pattrib, precvframe))
 				break;
-			}
 
 			rx_report_sz = RXDESC_SIZE + pattrib->drvinfo_sz;
-			pkt_offset = rx_report_sz + pattrib->shift_sz + pattrib->pkt_len;
+			pkt_offset = rx_report_sz +
+				pattrib->shift_sz +
+				pattrib->pkt_len;
 
-			if ((ptr + pkt_offset) > precvbuf->ptail) {
-				DBG_8192C("%s()-%d: : next pkt len(%p,%d) exceed ptail(%p)!\n", __func__, __LINE__, ptr, pkt_offset, precvbuf->ptail);
-				rtw_free_recvframe(precvframe, &precvpriv->free_recv_queue);
+			if(pkt_exceeds_tail(precvpriv, ptr + pkt_offset,
+					    precvbuf->ptail, precvframe))
 				break;
-			}
 
 			if ((pattrib->crc_err) || (pattrib->icv_err)) {
-				{
-					DBG_8192C("%s: crc_err =%d icv_err =%d, skip!\n", __func__, pattrib->crc_err, pattrib->icv_err);
-				}
-				rtw_free_recvframe(precvframe, &precvpriv->free_recv_queue);
+				DBG_8192C("%s: crc_err =%d icv_err =%d, skip!\n",
+					  __func__, pattrib->crc_err,
+					  pattrib->icv_err);
+				rtw_free_recvframe(precvframe,
+						   &precvpriv->free_recv_queue);
 			} else {
 				/* 	Modified by Albert 20101213 */
 				/* 	For 8 bytes IP header alignment. */
@@ -301,7 +344,7 @@ static void rtl8723bs_recv_tasklet(void *priv)
 						skb_reset_tail_pointer(pkt_clone);
 						precvframe->u.hdr.rx_head = precvframe->u.hdr.rx_data = precvframe->u.hdr.rx_tail
 							= pkt_clone->data;
-						precvframe->u.hdr.rx_end =	pkt_clone->data + skb_len;
+						precvframe->u.hdr.rx_end = pkt_clone->data + skb_len;
 					} else {
 						DBG_8192C("%s: rtw_skb_clone fail\n", __func__);
 						rtw_free_recvframe(precvframe, &precvpriv->free_recv_queue);
-- 
2.16.3
