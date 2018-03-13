Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3973753-1520971308-2-7593192564350463744
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520971307; b=TWnR8bvRfneMRQLRapbHfySZWklkH1L08GtQWpqgf7O9lDB
    necDt2HJRJ370eX3xr+qNuW3X6RIxRqvW+ZEetqro6pFiGv74cjuvedYurXHfR9C
    b5Jw+CqvYx36D/o/olt+fyn+az0cAXIATU1mXTSthj8b1gVW2aX78zuimwEV0c3V
    C3x/2tC12txlcJ/mW0FKpNbvnE1qKmgrpoRmqPdfortuqwA/z02FlZD8UG7xadfT
    vJj5fsWxKfJ/QUCrVIRWBcw8T7cXTiLAjL0X0B5Xwu3R9La9vzW6oXIovcLZE3Z9
    UXp0nZbdxGLPOZf+TU9e/eqo1jPHgvr5h5NeNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520971307; bh=r
    COV0ob7WjzLLDaPsFWPSXCf13r191+9Bcz9392+83Y=; b=oBXIWa3Y9QzFcGSY0
    ZQAKu1OWL7KOem/R1eetDUXPC0MGzzcwWXWja/Mec+0lYsrA4vuE2APuSIC6CxVC
    5x8GbcZBLefZkFQg7lITCdCFsTO1g53fgyugbIKYNyTzf4P1n0KqTWJuSNIeX9CQ
    +sGSVV5xqnE9bPnajHjGhQf3WA+junaBX+Ka2Uu9U4hOp2B7COyFI/QLeeIlziNv
    Ql14/2HoSS3bM920NQBuRtp+HtvtDhU3676owtHmrh8hy40/4ZgJT1tdKurQ1/vQ
    QKYP2CgpwAyaMHhWX36cf52NSDt+Z7F8gMoyJlS6kj8ZfveS35hnFXzRHKz2Z5NG
    C+8qw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.net;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmx.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.net;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmx.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Peter Seiderer <ps.report@gmx.net>
To: linux-media@vger.kernel.org
Subject: [PATCH] media: staging/imx: fill vb2_v4l2_buffer sequence entry
Date: Tue, 13 Mar 2018 21:00:54 +0100
Message-Id: <20180313200054.31305-1-ps.report@gmx.net>
X-Mailer: git-send-email 2.16.2
X-Provags-ID: V03:K0:JrRqP8rd3QjM4js139s83Jud3AMVbK1GY77paZjGWpWJC+645eU
 fM94jz2xSRwqXSph8drfP9Ve1kn8Ci9bOO9ouila4bShU7w9tp1A4LUk7iJ6OlkLzYajobO
 sWKc2d04lhQQwqXr7gADe/FJgw/3uw5c0GATfo3yejF4UMNB38iIGp/EBbiaDIBKe/uxZBf
 eNw5WB6TMtdOUaMpTwgWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iYmB9bIduEY=:Rybonuy6ZQApWf3CDaSRQv
 /t7usaUodASp19dOtenZ6TBXAxAwVpxdjOuWbEO+p3YRTU9iEj8MzPQ21nSpTUWt4RAbkZaFM
 sEXBzUCdb6vkYQduFtT/v3+qNvcfPoz2N38oPrYnY6YWrBQi+t1hDFkl41KdJFXcUVM9F1QTl
 KHpfR2DaLr7Y5n5RTNGhrjPJNxZgtoJTVWgRYJCqRNAONfs/a7emzP6VLMrgrkLTKlU3D9NfC
 mUCQU9TjVxV5MEJummV1RNWNFhaN/WaQdFpzdMgx0gZG8QKTdi0CohkmKuI0Mize8NtKtVoHs
 YcQ9LZqFq3aNCSpo0AcQUX+Cbj8vyB/ZbNtcMgLw/DURvA/8q7eB/eEXFK38wSQ7e0hZh4QTU
 fM9uSdn2lgnCVJDedqQCJVo1mnHxMB6a2ut7p462xqHLPZNifoonG9sXgWoAYLs+RYIsl94zd
 i+vz6G1/pbbHqh/cNMkLcIZxFF4n5Iqb52ONu4bhNjHp7K0tUpflBHjlylQ7pGv6CVh0yeHMI
 dGRknXiONsTy+Eq1KVZGP5MJpJsv87Qx1RqYN7kCFOL5DjIyHhhCYXJRRd0+1AM2Fo8DzteKg
 gzEYzUX8MfHoU6cvBKAjaD77gZrVblzgqGfjm8/0fw8nzsZiaf9XRXNYgxx9rHtwmBgd3T13M
 By4AUPfh+MOafQukNhGwOIcHiSctiiYC3f7wzlOj/gZqlS3PiLaJoFAd7Nab1j8oWu1S1mj6i
 hTxuRExYOxbXSrrTa2D2je8stJdnpePvmQr8OBTVPwyEhXfodKkjXSAKosg7XtD6XLsRTkIXI
 900XPvlPMV1vNtnO8CIUVbhHZNXCw==
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

Signed-off-by: Peter Seiderer <ps.report@gmx.net>
---
 drivers/staging/media/imx/imx-media-csi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 5a195f80a24d..3a6a645b9dce 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -111,6 +111,7 @@ struct csi_priv {
 	struct v4l2_ctrl_handler ctrl_hdlr;
 
 	int stream_count; /* streaming counter */
+	__u32 frame_sequence; /* frame sequence counter */
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
+	priv->frame_sequence = 0;
 	priv->last_eof = false;
 	priv->nfb4eof = false;
 
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
