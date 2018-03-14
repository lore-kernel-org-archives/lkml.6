Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2203218-1521048105-2-11354776514743602652
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521048105; b=ED0lgoOqeBtBqBdnUxh5M5mvqDoomIiHITFhv7l+bE/ZA0l
    V0HJn9dABMX4peRLrHDFBHA7fcj/p/44p02YkXhbBdXbLONx9GtACia3Sw/R067K
    Q2HZsIHkrbZG8bT1IcP2tnCi32CDX4S6LyxYzIz3q25QfoDmZ+aylCxk0I+AHj+Q
    Xj0HmTbQOQ0iAc54K3RuI34z76027A9UqfyyhPbbPlJjWzTt27S/EuagaaMNt54v
    6UZDPV4pyAcrbrkTdoOFBNb3CJyw0C7nzr0N6yU5bDv9aNI6pF2wU83gx6T/MsSb
    e1FCShGV5MbBLgHk5qrbv97eakPocYnmJXxpGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1521048105; bh=3gjt8FmX0RxHKCGE9T9RtrYNO+8YGLylEDOSr+vhgFg=; b=R
    Sdgc/J81RCksaRjPzJzP6L/OSYHbb3aYwxb28s7PD/ueHYbPa4ePiEuzJAXPCaZi
    xKcMy9dLBhJQefd1+Hiq5p8uNzrWAGSP6X1rmX54r572jljK81L4X2+rmoHUkDs1
    q2l4SqJk6xLTA7TkUvDX5XV0zATsS7JpX1yQXhIUEQAmKjkseoikqv3FT/jKInlA
    h5xa8WYhB4Io/jP4hy5+qUalIVwdL4uYi0uq0/xfV2GSHyB3jeS1SPPhrqbRMxQl
    ymR9Sop2bcODE7mSi9hLsfbuPSCuPuHxqUJvjDi9vtppB3bmWnUzuZZdKIQbiP3I
    pXcLwZll6NZMWQv3T+EiA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NJfI8LBw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OQ1A0vWB;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NJfI8LBw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OQ1A0vWB;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELs9zTQ00R2Lu5QjaCffV1jXsR2BWJBzebLd2fZDi/N0cSXXKB9QFo6+cwkfczg9oulofAP83Q==
Subject: Re: [PATCH v3] media: staging/imx: fill vb2_v4l2_buffer sequence entry
To: Peter Seiderer <ps.report@gmx.net>, linux-media@vger.kernel.org
References: <20180314165139.5356-1-ps.report@gmx.net>
From: Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <7f723320-f1cf-a769-dd32-d48c49b041e1@gmail.com>
Date: Wed, 14 Mar 2018 10:21:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314165139.5356-1-ps.report@gmx.net>
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
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org,
 Philipp Zabel <p.zabel@pengutronix.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Peter,


On 03/14/2018 09:51 AM, Peter Seiderer wrote:
> Enables gstreamer v4l2src lost frame detection, e.g:
>
>    0:00:08.685185668  348  0x54f520 WARN  v4l2src gstv4l2src.c:970:gst_v4l2src_create:<v4l2src0> lost frames detected: count = 141 - ts: 0:00:08.330177332
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
>    - let sequence counter start with zero,

There's no need to initialize (unsigned) priv->frame_sequence to -1. Just
increment it _after_ the "if (done) {...}" block instead of before.

Steve

>   keeping v4l2-compliance
>      testing happy (needs additional setting of field to a valid
>      value, patch will follow soon)
> ---
>   drivers/staging/media/imx/imx-ic-prpencvf.c | 5 +++++
>   drivers/staging/media/imx/imx-media-csi.c   | 5 +++++
>   2 files changed, 10 insertions(+)
>
> diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
> index ae453fd422f0..274683d2d4ba 100644
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
> @@ -208,8 +209,11 @@ static void prp_vb2_buf_done(struct prp_priv *priv, struct ipuv3_channel *ch)
>   	struct vb2_buffer *vb;
>   	dma_addr_t phys;
>   
> +	priv->frame_sequence++;
> +
>   	done = priv->active_vb2_buf[priv->ipu_buf_num];
>   	if (done) {
> +		done->vbuf.sequence = priv->frame_sequence;
>   		vb = &done->vbuf.vb2_buf;
>   		vb->timestamp = ktime_get_ns();
>   		vb2_buffer_done(vb, priv->nfb4eof ?
> @@ -637,6 +641,7 @@ static int prp_start(struct prp_priv *priv)
>   
>   	/* init EOF completion waitq */
>   	init_completion(&priv->last_eof_comp);
> +	priv->frame_sequence = -1;
>   	priv->last_eof = false;
>   	priv->nfb4eof = false;
>   
> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> index 5a195f80a24d..161a92946a86 100644
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
> @@ -234,8 +235,11 @@ static void csi_vb2_buf_done(struct csi_priv *priv)
>   	struct vb2_buffer *vb;
>   	dma_addr_t phys;
>   
> +	priv->frame_sequence++;
> +
>   	done = priv->active_vb2_buf[priv->ipu_buf_num];
>   	if (done) {
> +		done->vbuf.sequence = priv->frame_sequence;
>   		vb = &done->vbuf.vb2_buf;
>   		vb->timestamp = ktime_get_ns();
>   		vb2_buffer_done(vb, priv->nfb4eof ?
> @@ -543,6 +547,7 @@ static int csi_idmac_start(struct csi_priv *priv)
>   
>   	/* init EOF completion waitq */
>   	init_completion(&priv->last_eof_comp);
> +	priv->frame_sequence = -1;
>   	priv->last_eof = false;
>   	priv->nfb4eof = false;
>   

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
