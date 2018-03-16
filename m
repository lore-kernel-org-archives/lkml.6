Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3497619-1521219956-2-1438035591290658670
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enroca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521219954; b=KmopVRkR3i/T3iWjuCDToZdy5hteVH5eEP3jL3JjUlfa5vE
    6Ovn0O5PMpQrUxRpGi1nnadWiAFj48QQGC+/eX66sWYEHkL6sw+XP62b2gLJj5mv
    9kzXCqAc4EZusHNhOG0DQTAzgy8YQXlkKd9POD+EKcjpttuFs+vAGXIMM1obqr6F
    pgP7V3xvM5kgcwyEzWNIcKbImAql9WEySzRSVeiepijkWpwsA3k4p3gch5EleE4w
    n7ysmQGVIQ2pyFiz4JUEjaZ6mKPsCV9wZA7id7hpqnKz3excfibY8hf7wmzoXFcl
    74HBBhs/hybp7nUCK22sERdaCHBpWOUwVS8cwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1521219954; bh=/QhfdWLa/sxrj2b18iJRb3ERX03kN2nUdVt8u0SdfRw=; b=O
    oiDNZgHQmV1IWd2R6GMP3BbwWeOlJGmWAv18hiJbpuahBN384L+wkQlthM2cDaem
    WdJ8WvuYAoAu+w2FR9DVD3HaIcA+4EdG3890QN823Gr1xaH+Dc+/zhLDC+p9jste
    XDH2r/oCjJpsDyoYsXpFfZkv4iLsfQam5uybEVdqFDGwvwKR5dyJg2JxNXMBGvkW
    r5Mi4WLy62w8NkojUX3/6VOsVlIPsKxjdvPdH6blWiDZK5UT1ANFyGosHrylEGM+
    bISyvWCTbxytqYy3WRMMinBRdNOCJHFszvxgYtZMwrCdDMHeZa89qRhx2c0+4pb1
    0rnHzw6iM8o0mrlKgQ7ew==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tZp1UDGo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DL3WZd57;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tZp1UDGo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DL3WZd57;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtRz8vaRYUaZ4DUFf/BcOIpxPpszRrDq1bSV7uLwu8f3VchrJaSdD53wZdWYxQD52/K+jWziQ==
Subject: Re: [PATCH v4 2/2] media: staging/imx: fill vb2_v4l2_buffer sequence
 entry
To: Peter Seiderer <ps.report@gmx.net>, linux-media@vger.kernel.org
References: <20180315191323.6028-1-ps.report@gmx.net>
 <20180315191323.6028-2-ps.report@gmx.net>
From: Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <892dd00e-83bc-7781-6684-603ff89378cd@gmail.com>
Date: Fri, 16 Mar 2018 10:05:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315191323.6028-2-ps.report@gmx.net>
Content-Language: en-US
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
 linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Steve Longerbeam <slongerbeam@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Reviewed-by: Steve Longerbeam <steve_longerbeam@mentor.com>


On 03/15/2018 12:13 PM, Peter Seiderer wrote:
> - enables gstreamer v4l2src lost frame detection, e.g:
>
>    0:00:08.685185668  348  0x54f520 WARN  v4l2src gstv4l2src.c:970:gst_v4l2src_create:<v4l2src0> lost frames detected: count = 141 - ts: 0:00:08.330177332
>
> - fixes v4l2-compliance test failure:
>
>    Streaming ioctls:
>            test read/write: OK (Not Supported)
>                Video Capture:
>                    Buffer: 0 Sequence: 0 Field: None Timestamp: 92.991450s
>                    Buffer: 1 Sequence: 0 Field: None Timestamp: 93.008135s
>                    fail: v4l2-test-buffers.cpp(294): (int)g_sequence() < seq.last_seq + 1
>                    fail: v4l2-test-buffers.cpp(707): buf.check(q, last_seq)
>
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> ---
> Changes in v2:
>    - fill vb2_v4l2_buffer sequence entry in imx-ic-prpencvf too
>      (suggested by Steve Longerbeam)
>
> Changes in v3:
>    - add changelog (suggested by Greg Kroah-Hartman, Fabio Estevam
>      and Dan Carpenter) and patch history
>    - use u32 (instead of __u32) (suggested by Dan Carpenter)
>    - let sequence counter start with zero, keeping v4l2-compliance
>      testing happy (needs additional setting of field to a valid
>      value, patch will follow soon)
>
> Changes in v4:
>    - add v4l2-compliance test failure to changelog
>    - reorder frame_sequence increment and assignement to
>      avoid -1 as start value (suggeted by Steve Longerbeam)
> ---
>   drivers/staging/media/imx/imx-ic-prpencvf.c | 4 ++++
>   drivers/staging/media/imx/imx-media-csi.c   | 4 ++++
>   2 files changed, 8 insertions(+)
>
> diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
> index ffeb017c73b2..28f41caba05d 100644
> --- a/drivers/staging/media/imx/imx-ic-prpencvf.c
> +++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
> @@ -103,6 +103,7 @@ struct prp_priv {
>   	int nfb4eof_irq;
>   
>   	int stream_count;
> +	u32 frame_sequence; /* frame sequence counter */
>   	bool last_eof;  /* waiting for last EOF at stream off */
>   	bool nfb4eof;    /* NFB4EOF encountered during streaming */
>   	struct completion last_eof_comp;
> @@ -211,12 +212,14 @@ static void prp_vb2_buf_done(struct prp_priv *priv, struct ipuv3_channel *ch)
>   	done = priv->active_vb2_buf[priv->ipu_buf_num];
>   	if (done) {
>   		done->vbuf.field = vdev->fmt.fmt.pix.field;
> +		done->vbuf.sequence = priv->frame_sequence;
>   		vb = &done->vbuf.vb2_buf;
>   		vb->timestamp = ktime_get_ns();
>   		vb2_buffer_done(vb, priv->nfb4eof ?
>   				VB2_BUF_STATE_ERROR : VB2_BUF_STATE_DONE);
>   	}
>   
> +	priv->frame_sequence++;
>   	priv->nfb4eof = false;
>   
>   	/* get next queued buffer */
> @@ -638,6 +641,7 @@ static int prp_start(struct prp_priv *priv)
>   
>   	/* init EOF completion waitq */
>   	init_completion(&priv->last_eof_comp);
> +	priv->frame_sequence = 0;
>   	priv->last_eof = false;
>   	priv->nfb4eof = false;
>   
> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> index 5f69117b5811..3f2ce05848f3 100644
> --- a/drivers/staging/media/imx/imx-media-csi.c
> +++ b/drivers/staging/media/imx/imx-media-csi.c
> @@ -111,6 +111,7 @@ struct csi_priv {
>   	struct v4l2_ctrl_handler ctrl_hdlr;
>   
>   	int stream_count; /* streaming counter */
> +	u32 frame_sequence; /* frame sequence counter */
>   	bool last_eof;   /* waiting for last EOF at stream off */
>   	bool nfb4eof;    /* NFB4EOF encountered during streaming */
>   	struct completion last_eof_comp;
> @@ -237,12 +238,14 @@ static void csi_vb2_buf_done(struct csi_priv *priv)
>   	done = priv->active_vb2_buf[priv->ipu_buf_num];
>   	if (done) {
>   		done->vbuf.field = vdev->fmt.fmt.pix.field;
> +		done->vbuf.sequence = priv->frame_sequence;
>   		vb = &done->vbuf.vb2_buf;
>   		vb->timestamp = ktime_get_ns();
>   		vb2_buffer_done(vb, priv->nfb4eof ?
>   				VB2_BUF_STATE_ERROR : VB2_BUF_STATE_DONE);
>   	}
>   
> +	priv->frame_sequence++;
>   	priv->nfb4eof = false;
>   
>   	/* get next queued buffer */
> @@ -544,6 +547,7 @@ static int csi_idmac_start(struct csi_priv *priv)
>   
>   	/* init EOF completion waitq */
>   	init_completion(&priv->last_eof_comp);
> +	priv->frame_sequence = 0;
>   	priv->last_eof = false;
>   	priv->nfb4eof = false;
>   

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
