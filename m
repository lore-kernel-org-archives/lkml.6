Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-971832-1521141230-2-3551411078492636394
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enrosk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521141229; b=R6DbiyiQ3imvRqxgTsy99mYRe/QAWRD1Sr04zVmcDRqDldS
    fUarjKl/M7sTNJadY0c2mikj0tkxDGQ8X3/sQnp0dVr+5gMVRZbBgfNleo1Qqkde
    4/+d6oAiZVz5uf+XedUv4A3cAywRp5xkqRPu5qRpy/JNwscknW8J95kibGK9dl9C
    CYYs9rOJWCaMYZV1mNo2DaGCAeZMokTdYp2/m06ZUdh8Pn/KjdESqWTyJ8e71CVw
    EMPNlEsM+t1uHUh1w5tAvY5cu2HrANctvpAf/HB+0EvMzjNnw5Gg5kwg6Sx2t0Z9
    KCOa5wQjw/6S+2/akg0cjQRD3+cGrSpz/s766yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521141229; bh=O
    Sdn9yqAZ48AHQjDWMJGw7zacR/8CrN7yBor+joYkyM=; b=A7hIDWvyDRTMGqy7o
    fHOsUPMw3t1WaoD14P2QlnuHKERnfuXxFr8flXwjwuemO59kyegtMm/z7Ond5pia
    C+TM0dzgbbVitd/VK+2s+jX3yRAVatdeTTb84YYGy0/iwq2xkLP8RtKSJs3p/Fpx
    0bbJfLHWQop2KkQzq08jfSRPn/gorwtvXoqarZGgs6dRet4PvwuUDDIxrw0w54P+
    BZ6qlrmrZIUMWCSDbYOFbT+WFnx8sCe3MOc8CwgxgqKNuKFZl3cswKNCq/2Qn707
    c41I9YHECOT9iXv+R9US9Krf2EEuinzheMp2sil0fh8AA32wA9RLTBJb3KlqWXAA
    tg/2w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.net;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmx.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
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
Subject: [PATCH v4 1/2] media: staging/imx: fill vb2_v4l2_buffer field entry
Date: Thu, 15 Mar 2018 20:13:22 +0100
Message-Id: <20180315191323.6028-1-ps.report@gmx.net>
X-Mailer: git-send-email 2.16.2
X-Provags-ID: V03:K0:WL6VJTwE2VWy5BcRYDOzt/PBVrNYwO2d/0fb3crjGUjOSMRrl/E
 tMJP++4fVyV2XU+Cq4rAf/8+lscc8CXOKQR64wJkajRjVam1MxMDeg8Qa9cwQdKsuH/pbFT
 w2m4PUzLnPB1qVJ91VXAyEb1dua69ChpCxCqSzztFsJRITV0VFQoQ8e7GvijGzCrSjA0WJk
 eY7M2qn083ULQdxI9L+9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:scUx90wAK/w=:KpTl+FmlL5FLNaPV3dSiaU
 ahB3l8Yl/OFHGrzD0CkJiK4JsVzwNwXMn1rCg9Sn1MfKk8I/k6nvYwzVEn/j1ziQv/stbNRFD
 CY+8WDdonzqPIage4NCMZI2Fd19QZHVyP1ohzinFO6mwwx3hhBO+JL2yawhbnPG6r2EWzFaeX
 1WJXixJ/0rv0STSKJ90NvZa+BJmZCOG47AV060Lfv/aUWj3ouNRzW7U2pmVpDxuRtrsyp6aq+
 z9UokfaPq1WRfxW7gelTZ10igA1K87xstYafFs9q7LJw3bRFljQp6jDtbLsViZUuclwG0U9dO
 JYfyrZfmmFm+fRaUXj60b3JTajhekIUY9vvtvVLAtVjQXxst6HxBBlcFofhgRiXIoE8YCs2TR
 5U9t/fiSFgo+4L5U139lSWmMNAMPGfmXTwH4UqvZfFdj5i6uHqtExLgifVy/1/zSw22oKLOQu
 Iy1U7hZvz0HkW42rNf1ktUVO+DIQRuDSzbM+/a7gIg4aNAomutEmv76bMb6Sxib2787OYM9HS
 /SvmPuPqFCLFnV16Ga7i9zI54c5TOp99y1SUjNOKHC//4BmEeAMNG32qlSoXjj2vm5Fqd/yp9
 S6gGWK3MwKRabqDzEWUL6JtDvva2DyELcypr228bQBdZYqQItgYPxPukj6oH9EkN6GcdXTVmM
 /AZ1d1QRHaQ4/4TJcDrKdNIs9ovIWvnONPjcNn8ulhWuTHB7HBIZIyNabHxqHrcqMNJopSCs1
 2GaH8ER8v+cSNU/hQvbRKpJR7pBFyhitAvls6XxuH0yKTPrGfOjXfoCyYq5ootHhi847TBhrS
 NKfYlqJ7gyFmokIBuudIXwNtWILwQ==
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

- fixes gstreamer v4l2src warning:

  0:00:00.716640334  349  0x164f720 WARN  v4l2bufferpool gstv4l2bufferpool.c:1195:gst_v4l2_buffer_pool_dqbuf:<v4l2src0:pool:src> Driver should never set v4l2_buffer.field to ANY

- fixes v4l2-compliance test failure:

  Streaming ioctls:
          test read/write: OK (Not Supported)
              Video Capture:
                  Buffer: 0 Sequence: 0 Field: Any Timestamp: 58.383658s
                  fail: v4l2-test-buffers.cpp(297): g_field() == V4L2_FIELD_ANY

Signed-off-by: Peter Seiderer <ps.report@gmx.net>
---
Changes in v4:
  - new patch (put first because patch is needed to advance with
    the v4l2-compliance test), thanks to Philipp Zabel
    <p.zabel@pengutronix.de> for suggested solution for the right
    field value source
---
 drivers/staging/media/imx/imx-ic-prpencvf.c | 1 +
 drivers/staging/media/imx/imx-media-csi.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index ae453fd422f0..ffeb017c73b2 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -210,6 +210,7 @@ static void prp_vb2_buf_done(struct prp_priv *priv, struct ipuv3_channel *ch)
 
 	done = priv->active_vb2_buf[priv->ipu_buf_num];
 	if (done) {
+		done->vbuf.field = vdev->fmt.fmt.pix.field;
 		vb = &done->vbuf.vb2_buf;
 		vb->timestamp = ktime_get_ns();
 		vb2_buffer_done(vb, priv->nfb4eof ?
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 5a195f80a24d..5f69117b5811 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -236,6 +236,7 @@ static void csi_vb2_buf_done(struct csi_priv *priv)
 
 	done = priv->active_vb2_buf[priv->ipu_buf_num];
 	if (done) {
+		done->vbuf.field = vdev->fmt.fmt.pix.field;
 		vb = &done->vbuf.vb2_buf;
 		vb->timestamp = ktime_get_ns();
 		vb2_buffer_done(vb, priv->nfb4eof ?
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
