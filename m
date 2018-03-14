Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2139802-1521046323-2-8251503771798896336
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521046322; b=bnx6egMiS/UmO+NcG0pGTsCBNgZ6qgKbhA89N7LH1HQ6dy6
    GzaZzzjf754AXvBfS4YQ0EA8+T3rn6/Xa587U8AbByVLahtC2lnMY91varVbwg8Z
    WxsoMq1GT4tk3A/nOtx2jnjDUe3K/xMVe4CQJzprQhng5HUeocjRtKIn7sRpQUit
    N8yuPzY6L1XxNmymHeuAxXtFHqtW3xyDf2AQ0Cb6aIQL8sf2TRwKv32Q1aPX/vRd
    8cOYdkUNV1JX/QBS1Qrg82OftoT57BXljc+6AdDu2Qaq2EVS5KLoxy//M1Lw/wqn
    2AVfRf9ksvNdn9myrBK8keURLNQG6rmvHb1ITWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521046322; bh=c
    YCXfxkJtB+7twAnkiZCmW21jxs0EFjn4OE3g/NwhSI=; b=wkkp8MqRQPtSwW4Ox
    hZqNLAkZuBNWWBgtG2ald29aG1ZVpL9Eu5ZS2rrnAndVA56G6qIlZSySNHn+MPj5
    UySeHdySe8n2xbO52O4Nec8XP7auHm6lzFm2ucejoXhOD0kS0eHDjVOjHFr3Qpm0
    suAPa8j1RwD3Aduglo51vJer52XtKYsZ8P01drgBJ4eHR83RtjoYnj1SB45jKVMm
    tM971t6pnAy33SWFhowgk4a65xlumvgJdE7GXDfv7s/W2v+TssdHOKwV/IDyILRw
    mRKututvFzxXwDiZzspGa3FFsaz9PgDz3wM7WhDhM0UmeqmKQzbwIn5laymu60Ky
    qOvOg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.net;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmx.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.net;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmx.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Peter Seiderer <ps.report@gmx.net>
To: linux-media@vger.kernel.org
Subject: [PATCH v3] media: staging/imx: fill vb2_v4l2_buffer sequence entry
Date: Wed, 14 Mar 2018 17:51:39 +0100
Message-Id: <20180314165139.5356-1-ps.report@gmx.net>
X-Mailer: git-send-email 2.16.2
X-Provags-ID: V03:K0:AMQlfiAbu6xwGIHavbo8gFeLsx3iDR+uzaG35igP4KBVru9YQSe
 OBSlQNeM9WTku1dUQzpoJ6iy2Nk09YT8eYr6lis43tocKBmjmT16/6o1Y3SK8CCwOf4k0Xp
 9Fwd8iNTI+poGxoSn2Gk5u1u3hQD38uYSdKUbY71aKibRXKBW7XuJHNKld5l9Jx4gj0vISX
 ZfZJj+6uKaN/fYSRqMyuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BhH0ddctKY0=:mTsysCRGK2h6fv3x7aXY/3
 LT53ft7MQG2qYQhOUqyxHBk7I4YrccQ513/DSxOOu0wXugfuWHAqPvoc4yyCkt9Joxjw30VUk
 BLf9ck3SZ4GNLQxzZganOaH4vrjDlazj0sE7B9d7mLfC3MsYxh9YuCLtoOLVuie+g1KTN21fA
 BUGo5QqzEqdeotlbV/9NAh+vxTghzj6GKHNfxKSe+Txp+gHIuhfT/InjwpLfPtJt5C+AetQV5
 sg5DLs9wSuq4GUm3sFwFHEvkti4XQ0J2trJHO9wm6EaqJY/u8dhW4O0BVlkOmDG38pABibHdK
 ppLnh4doWybIqAOFbukOV4xhmMx1iWL83LDdAheMCCs5YVgHk3K7UjP0ysyCvwQUwWLMi4ptW
 JfwO3LJ2bUjwZlqIpR88EVSvxmSC/9iMBVR7peVEZfC1gOF/MbsQcfHgQzjKv0bUeKSWvnCMl
 V6yd7c/GVMwV1uJNmNacvVyMwfA8z3bgVBxAPzBv50nukSls5KcI0/m6DIW60XS5Bb59QBGpP
 ku/8R4pXIrY7J+ygfoYxeBkOv9GwKMNR+xJ/3RwKF2p3w0hDdRpELJC8n2WVArci6KiwZ5gcH
 0jFqaxs1T7Ld54t5mksK6WmuICttP/vuwQzHMUuu498mAk5eOeiMQQGi3/N1f4F84xsLeISlI
 JZn7ExMvDYWl25jHjiwAQAnK0k6jPXRMTe5VIXFrvqMrIf9W6/CLtXaQcWMLTIfvFrDDy219r
 PMKMzQuAs3SNfW36U2jRXTkdtuL/YrIDC3V7uUQNQYWBJpf2w3LUr3eMjG8ahnkhnye9CU9r/
 i4Vri5oC5bo2b3eceuEzuTfhSkeHg==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Peter Seiderer <ps.report@gmx.net>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Steve Longerbeam <slongerbeam@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Enables gstreamer v4l2src lost frame detection, e.g:

  0:00:08.685185668  348  0x54f520 WARN  v4l2src gstv4l2src.c:970:gst_v4l2src_create:<v4l2src0> lost frames detected: count = 141 - ts: 0:00:08.330177332

Signed-off-by: Peter Seiderer <ps.report@gmx.net>
---
Changes in v2:
  - fill vb2_v4l2_buffer sequence entry in imx-ic-prpencvf too
    (suggested by Steve Longerbeam)

Changes in v3:
  - add changelog (suggested by Greg Kroah-Hartman, Fabio Estevam
    and Dan Carpenter) and patch history
  - use u32 (instead of __u32) (suggested by Dan Carpenter)
  - let sequence counter start with zero, keeping v4l2-compliance
    testing happy (needs additional setting of field to a valid
    value, patch will follow soon)
---
 drivers/staging/media/imx/imx-ic-prpencvf.c | 5 +++++
 drivers/staging/media/imx/imx-media-csi.c   | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index ae453fd422f0..274683d2d4ba 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -103,6 +103,7 @@ struct prp_priv {
 	int nfb4eof_irq;
 
 	int stream_count;
+	u32 frame_sequence; /* frame sequence counter */
 	bool last_eof;  /* waiting for last EOF at stream off */
 	bool nfb4eof;    /* NFB4EOF encountered during streaming */
 	struct completion last_eof_comp;
@@ -208,8 +209,11 @@ static void prp_vb2_buf_done(struct prp_priv *priv, struct ipuv3_channel *ch)
 	struct vb2_buffer *vb;
 	dma_addr_t phys;
 
+	priv->frame_sequence++;
+
 	done = priv->active_vb2_buf[priv->ipu_buf_num];
 	if (done) {
+		done->vbuf.sequence = priv->frame_sequence;
 		vb = &done->vbuf.vb2_buf;
 		vb->timestamp = ktime_get_ns();
 		vb2_buffer_done(vb, priv->nfb4eof ?
@@ -637,6 +641,7 @@ static int prp_start(struct prp_priv *priv)
 
 	/* init EOF completion waitq */
 	init_completion(&priv->last_eof_comp);
+	priv->frame_sequence = -1;
 	priv->last_eof = false;
 	priv->nfb4eof = false;
 
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 5a195f80a24d..161a92946a86 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -111,6 +111,7 @@ struct csi_priv {
 	struct v4l2_ctrl_handler ctrl_hdlr;
 
 	int stream_count; /* streaming counter */
+	u32 frame_sequence; /* frame sequence counter */
 	bool last_eof;   /* waiting for last EOF at stream off */
 	bool nfb4eof;    /* NFB4EOF encountered during streaming */
 	struct completion last_eof_comp;
@@ -234,8 +235,11 @@ static void csi_vb2_buf_done(struct csi_priv *priv)
 	struct vb2_buffer *vb;
 	dma_addr_t phys;
 
+	priv->frame_sequence++;
+
 	done = priv->active_vb2_buf[priv->ipu_buf_num];
 	if (done) {
+		done->vbuf.sequence = priv->frame_sequence;
 		vb = &done->vbuf.vb2_buf;
 		vb->timestamp = ktime_get_ns();
 		vb2_buffer_done(vb, priv->nfb4eof ?
@@ -543,6 +547,7 @@ static int csi_idmac_start(struct csi_priv *priv)
 
 	/* init EOF completion waitq */
 	init_completion(&priv->last_eof_comp);
+	priv->frame_sequence = -1;
 	priv->last_eof = false;
 	priv->nfb4eof = false;
 
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
