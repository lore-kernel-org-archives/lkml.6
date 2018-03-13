Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-14183-1520980478-2-10419423615649368807
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520980478; b=rnyiXn6CEhmOlDQiRwbo1hHTJOzdFkcyRwXyPQmxGiiuBkt
    QDEQXZF5nnavjCTXmKkdvYWhoXKFF7APePUi/YK1KBTL1416hvqMe1g5fL2v6nGZ
    cZ4CaeHeEC90ya9ST8arv94RIZ+1I06srl+tb3lTxoklNaECe9y7gNBePlkRLzV9
    G68ee64CdxTdEXMtQFeSRE5plwnlIWrkHZwQxfkh0YEL+HzDQcL4sM4TYpkPqmZv
    DRytloMBlS9nSeN0BpJ+XQKGZvO+tz7w2XhwA6ztYFbMqHyOXuqe8D4bsDXBtMYD
    Tep9CMIDmlJm/4vyLE0atgA/9lwdYqM/iLb+tCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520980478; bh=e
    FlTJODfHEq+hk7w20lXhlM8ckn8dq2Kb/h4M0Nmc7U=; b=xDLgwpzouWZns/ghP
    NwzuA5N7znU268koDD86qGjxNc4rjnDSG2xiTzOA5ItsgLkGkMN4gnEk/X47wfDS
    lXKmpU3yxg51WfO3ZOdqy6syCbvRChxbWTH7PXvyCrQQRAY4ZqKSDiihRyS8iHjq
    rwg7/AMvhYP2xzLoqprVXGqxGKlFTn3LO0yeT+jufV8rGlgBb89O1rl+ymdDtkXs
    wHrvuDt3vNJi+WGbkIdgdL0ZKpg/bOy4deodG/j3QlKKYaqYK49j5O4MJGAPJvz4
    WoTy7nl8+hb/T16apiGU0usLFAwmVVTgAKn4E6oLAdiLmMqgthIklVqKfAHWEGeG
    TpI3A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmx.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmx.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Peter Seiderer <ps.report@gmx.net>
To: linux-media@vger.kernel.org
Subject: [PATCH v2] media: staging/imx: fill vb2_v4l2_buffer sequence entry
Date: Tue, 13 Mar 2018 23:34:05 +0100
Message-Id: <20180313223405.16627-1-ps.report@gmx.net>
X-Mailer: git-send-email 2.16.2
X-Provags-ID: V03:K0:/JBUzStknPThZ3i9e8HLJPKSrU61ZPvIUqj/BjhrTg6amAsB8nx
 hb1Vi730ER/XGhqJ+PLtkIlMVMaP6BmGdYJzQmM4dMzo+K6VTqOUsDFL0r0GORqx7oR//g3
 MC3Oig01+yo+SSYduEOaDz06lBHNpAknylfML8XMn3yptdNqqXgObK4C7TdQ2mgdNT/TKqO
 TfIims2GuXfjkgrLJ6KEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KvUP3pBeDmw=:N+6Ljr/tcx60azg4m9PCtd
 pH4d10ttO9NoujIMWqI3L0yvXxivWkD/DyTEG6Z+gtNpxoxVFwvaYtDsl2X4wbY0QVIXEknkU
 zXpgeu+1LTrjeMz4AcCqfQuVWyjv5kDFq/5oUeAHz1X4xipOMDE7UFHfNseYakobpz3g7RZfT
 9FKpF+dlf1MuxZUNdmXL6tf1CSQVqqIAKv3VznTdO790aCo9OemQaTSHRSkhC4dBSwZkD1LeB
 dxSEY5Xom+i6NNC+wqZcQgEawmctMMcDf2J0mGFSq0g56woWbfxZkmAyDlDXKubwZoe4iVa+5
 qBrMJmIHBCaZ1pHCj2SM4l87B+bhFMLnbJfr7b2nNgMxieGRC42H/zZnVoI8XZJn5Aj4Cy10L
 gm/nvma2sFOFbmEBjdB5boTE1IctR3tkKH12UmuKTdNq/3r0ROQJF2QkMJti465aLHpYNoZYD
 ybvalYywvQ8xJOnProSB05heySnZLjEp+5QxmWKwRtmGpvfb7wBOxUXjD7ozbgNCC7rxHiclf
 iaQHx/Z3bluhuQlQHQ+I/mOONzENJNcJdlVfAxva5w43SMG6lvYuAAHCDGKv0QoBBlV+BMmeN
 7/gtRLdnVM4ZppuaqqMxP3jzU/nsgL7f7qMIQBj/5ptfeSzQobQwSuH6w2BV6c+p9BmsfRTs4
 hBc0jsnRod1rVjhdxcPtQPozVaBHHwSPEzgfmx2j/hMOdVUgqrcvqOeqRlAd4aowWMyFIIJ8g
 7A6mSzycGQs4XoroXvquAssn9u6gu9Lx+TNLmxdRemlGkR0altjJJOVhEC/fd5AdaThNs0yqU
 4LAmZJFpE+EbtVEelzjF456kKIflg==
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
 drivers/staging/media/imx/imx-ic-prpencvf.c | 5 +++++
 drivers/staging/media/imx/imx-media-csi.c   | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index ae453fd422f0..eaca74b72114 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -103,6 +103,7 @@ struct prp_priv {
 	int nfb4eof_irq;
 
 	int stream_count;
+	__u32 frame_sequence; /* frame sequence counter */
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
+	priv->frame_sequence = 0;
 	priv->last_eof = false;
 	priv->nfb4eof = false;
 
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
