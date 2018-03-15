Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-977033-1521141231-2-2594556224168289754
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enroca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521141230; b=HXT2tPd0wI0vVEkTtDTHmM95Xs4jWanYzLGTNXkXpZwQg+c
    jhk7rG5h+XOOM4EX+dkMBPMAQphOZh+vZh/B7G5WcoK5kjPKX2EJrWbUV/dISmmP
    6/DH8EmKJN7FJ0BCN//aSyFE6xNKHjNO23PfRIc7B1t8X0IvtgOFflihOQauseys
    iAZsA1fSQ/AA/D80UKfLlk914WQvItQA+vNtsSXNmN4JXvm8JKk/TjTwFX/sQPzz
    kIxtlPHPYfn7Je7R8HYQIgXFOIBdjShtMjoV4k6SKV0SUO2rh45OIrIyH4sIdKGZ
    UdYmAw828IxCCQUwP1EmaJSexwul/qlmcII798g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521141230; bh=y
    igttnSKinuC/Q8dbKmBXUZDtNkjaUYNieD6BeR2nLg=; b=htD79oLr7DWmQMHXR
    68Tyi8dKrRKG8s57FGwkyjhiNc+rZS2VsoiNsIGibbcotL1oydgzPenUj+VAlE/x
    GPdtARRyhAADdfQ4CpurU3RK22qDBNyZzX0qp140mTe/gZRcXZ1FdErawk/7U8uA
    AAqpCRBMipRyyeVEq2WH1Iy4rEj0XT1sUkrUfBH7aqeTl34d2uacXU+GSnsz2kw4
    r+gFZ7afVp9OizeMQmH0gruybahKevczSdudcORUYd5k4ZsuspMDKWOC9UcMMl7o
    ewTWRCVowIehgyNbClvxLHg6ukKw/ADsKbNKe04/EtHCSs/+7pgVJr84xjJc8Pae
    HTPTQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.net;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmx.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
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
Subject: [PATCH v4 2/2] media: staging/imx: fill vb2_v4l2_buffer sequence entry
Date: Thu, 15 Mar 2018 20:13:23 +0100
Message-Id: <20180315191323.6028-2-ps.report@gmx.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315191323.6028-1-ps.report@gmx.net>
References: <20180315191323.6028-1-ps.report@gmx.net>
X-Provags-ID: V03:K0:XGCi/6HZZ9n5xUkmaRXUq0Bctcea/xGfHRAWeyy8COzTQf6Yc/H
 HwOcNvnbflUjaL2lZbP+/Tpt7oUUjAa9tfVxlXAAGzIXwToiUOT2Vum9McKAYUnecVJn9YN
 NasQWtfCU08jNkTbCaBx4E03dIeZB5ZHLOrL5fFr/GU41cmwFxKMVLD/6Kim9nSEtf4SeVx
 WrB/gHNboSEvK9Nm569lA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CSsI+BVLhPE=:sNeqcodGA3s6iZDPYMOj2V
 9ZTZbUUJ9Fj813arN1x7LDZB9VwrSRFX6g6I7watmtwO9rFAuvJbMSl6lEG0KZOttRPzDWvha
 NWDaCZoRt/kuEcE34mYy2+Dg5FN7AuVKFVvWcBxSRS4mGi0R3VioWrngfxXw1ITI8N8Jjlyny
 t8atl3IJRmV3y8RwgAFBsW3xjKm7mGVPt5dS8Zz6WGxqz+4R4jWuVN/uH5l3NiswcKPc/+9pM
 3Tcgv3/pj34JOopu9+yJjrSY1bixGtfKJnscu0BHCOjKTK1MP9KyA6UPNSVKEvbEH6YKh2zMM
 gEFrvJZiB+FgRsr1ClxfP/pglWzwUmt38e/ClnpNlKlwRywFp/E+Wj3aUgOdnl1usJUvOK1H2
 5bSE6jPp8dxBRPBbs+DauEKF62dnnjNbfVfCdLrEyptodt72IK/RWcSdkckvNry2whWsVp7XG
 PBVqxjbYEZVcJKHHHZXxGE2GKf2Oc10in+ZDpmm1GPcCOrjo/bj4T95MRbVQuxkWOEJckexgY
 IYg1xK/lSikNZi5IBhP2QtX0wiBd6KawZauuS327syZiPbxCQ0Bp3Kt/NHwUnYbusTDEOHahw
 jTJHm7Kwja17QuwERasb+mkXT5txvZq0ehtUq9n+iUKoIPxhfBfBer69DaA2LcDO5XkbI66Xu
 lODpT3Mcklp36ZgWSAtHEVMLQCyE1hlkNxR9YkKrfKycnYu26Ey8wx19o7uNT9vOkjBIEpNwD
 GcYPlkoKqoOrcZT9CA7GnhFtK/b+jNd7UXWGPjEN/giA2fn2VouOm8j5JTG7sABUeaUFz0Qyk
 VbUc0SO5MJcsR14ohUqtv63AzSFnw==
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

- enables gstreamer v4l2src lost frame detection, e.g:

  0:00:08.685185668  348  0x54f520 WARN  v4l2src gstv4l2src.c:970:gst_v4l2src_create:<v4l2src0> lost frames detected: count = 141 - ts: 0:00:08.330177332

- fixes v4l2-compliance test failure:

  Streaming ioctls:
          test read/write: OK (Not Supported)
              Video Capture:
                  Buffer: 0 Sequence: 0 Field: None Timestamp: 92.991450s
                  Buffer: 1 Sequence: 0 Field: None Timestamp: 93.008135s
                  fail: v4l2-test-buffers.cpp(294): (int)g_sequence() < seq.last_seq + 1
                  fail: v4l2-test-buffers.cpp(707): buf.check(q, last_seq)

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

Changes in v4:
  - add v4l2-compliance test failure to changelog
  - reorder frame_sequence increment and assignement to
    avoid -1 as start value (suggeted by Steve Longerbeam)
---
 drivers/staging/media/imx/imx-ic-prpencvf.c | 4 ++++
 drivers/staging/media/imx/imx-media-csi.c   | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index ffeb017c73b2..28f41caba05d 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -103,6 +103,7 @@ struct prp_priv {
 	int nfb4eof_irq;
 
 	int stream_count;
+	u32 frame_sequence; /* frame sequence counter */
 	bool last_eof;  /* waiting for last EOF at stream off */
 	bool nfb4eof;    /* NFB4EOF encountered during streaming */
 	struct completion last_eof_comp;
@@ -211,12 +212,14 @@ static void prp_vb2_buf_done(struct prp_priv *priv, struct ipuv3_channel *ch)
 	done = priv->active_vb2_buf[priv->ipu_buf_num];
 	if (done) {
 		done->vbuf.field = vdev->fmt.fmt.pix.field;
+		done->vbuf.sequence = priv->frame_sequence;
 		vb = &done->vbuf.vb2_buf;
 		vb->timestamp = ktime_get_ns();
 		vb2_buffer_done(vb, priv->nfb4eof ?
 				VB2_BUF_STATE_ERROR : VB2_BUF_STATE_DONE);
 	}
 
+	priv->frame_sequence++;
 	priv->nfb4eof = false;
 
 	/* get next queued buffer */
@@ -638,6 +641,7 @@ static int prp_start(struct prp_priv *priv)
 
 	/* init EOF completion waitq */
 	init_completion(&priv->last_eof_comp);
+	priv->frame_sequence = 0;
 	priv->last_eof = false;
 	priv->nfb4eof = false;
 
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 5f69117b5811..3f2ce05848f3 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -111,6 +111,7 @@ struct csi_priv {
 	struct v4l2_ctrl_handler ctrl_hdlr;
 
 	int stream_count; /* streaming counter */
+	u32 frame_sequence; /* frame sequence counter */
 	bool last_eof;   /* waiting for last EOF at stream off */
 	bool nfb4eof;    /* NFB4EOF encountered during streaming */
 	struct completion last_eof_comp;
@@ -237,12 +238,14 @@ static void csi_vb2_buf_done(struct csi_priv *priv)
 	done = priv->active_vb2_buf[priv->ipu_buf_num];
 	if (done) {
 		done->vbuf.field = vdev->fmt.fmt.pix.field;
+		done->vbuf.sequence = priv->frame_sequence;
 		vb = &done->vbuf.vb2_buf;
 		vb->timestamp = ktime_get_ns();
 		vb2_buffer_done(vb, priv->nfb4eof ?
 				VB2_BUF_STATE_ERROR : VB2_BUF_STATE_DONE);
 	}
 
+	priv->frame_sequence++;
 	priv->nfb4eof = false;
 
 	/* get next queued buffer */
@@ -544,6 +547,7 @@ static int csi_idmac_start(struct csi_priv *priv)
 
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
