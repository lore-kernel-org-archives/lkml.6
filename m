Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7F64EC004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4013620839
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4013620839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934442AbeFKUsl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 16:48:41 -0400
Received: from mout.gmx.net ([212.227.15.15]:57453 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933584AbeFKUsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 16:48:39 -0400
Received: from localhost ([92.75.47.185]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LoEwL-1fvF3T1a4P-00gIuB; Mon, 11
 Jun 2018 22:48:34 +0200
Date:   Mon, 11 Jun 2018 22:48:33 +0200
From:   Peter Seiderer <ps.report@gmx.net>
To:     Steve Longerbeam <slongerbeam@gmail.com>
Cc:     linux-media@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] media: staging/imx: fill vb2_v4l2_buffer
 sequence entry
Message-ID: <20180611224833.64a89c80@gmx.net>
In-Reply-To: <892dd00e-83bc-7781-6684-603ff89378cd@gmail.com>
References: <20180315191323.6028-1-ps.report@gmx.net>
        <20180315191323.6028-2-ps.report@gmx.net>
        <892dd00e-83bc-7781-6684-603ff89378cd@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/oXRMwp7xjyIUHHijvT3eIsMhckhX8YJl2h0eFB0tfWpgCcleO6
 wWt+t1pczqT2G/jBVrT5dsjwz6GvAG9kppFfS2PnoQK1iADIyF3JBsPGNEQvDih9ZxpQ20h
 PMNcD4vWAVfTUpQxJ4DlWwr0ARZ3o9BHdxzNzK7TT+q4R8u57celMftMtMxvbBxN2mc/dq9
 /G27vhQ0m2p5cawiKE7pg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZKHkipWRq5k=:LlG2VICg/FtrUbAd2P2a6i
 DhK7Y0DCKXsW4Zeq8m6P1cRTcX+R17kVNYvXZWEjmHz3IlhODqTaA6BstbIwuK/6NwsXZUBB+
 2fCUNj295lq7JckZOzzOntjArnZc9Z6dI3FFXHifajtRbz20aizqDoVc+tXMi5c94PEuXfHRl
 AAO0uGF8eBARt2ZrsmwjZ+MLwVjCcsb5lths5dUcCV5G3znljB7hTaS+DQuSwIQiDmIbdyFCy
 LeGe1yDDMOh90sheZfxwKrI6K1NVpj0cqXi44khLyswNp9c4HvA8GK6SDkb1lZ73EjVQPus4B
 6JIZEFugpsKAkxl2IOmxnushvrTrrTOatDsQv/0U0UiBj4/ItFlaeCSgsDc7sC6jhrro6EQ2b
 JfH2FsfjkMrq7rAPIcwfpUfOHkoeWTYHhL+H55Gtbqs11ZUYlAI2NIAC+Y1RmUxvNxtrEN/dy
 xLl1lQXMNEk+euLpjnc8+Adsvy9MDJsKAU9cBiZ4qFYZ4AfYHyGzFaijbrK//HXIzv8i0XO70
 u2pNqw5vVKsptzXlMusL7aV80l7U9XaAOo08rkZliI9KdSCSZpZG7pkEYlQIy/JkV8mmhgUgl
 m1DKFA/aQwcl30WuxM6peSPyrrIADjM4h9zcs3mmv+5W8n2AWKCLQvwm8WM/YDpb704xsfmlW
 RVrhBKn0vlDdCBHxx2FJgvDq9auaeN2kaOm3nutiJBSfUwZbjoJRclJpewxtPy0HqRcW1FQuB
 ji57TM2uyLnFHm4JDjpYlMos/idaXRkh74YtbRgnkY6jivm+xKj4m0MxR6STzRhYTE+NaJtWF
 +LnwvZf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello *,

On Fri, 16 Mar 2018 10:05:44 -0700, Steve Longerbeam <slongerbeam@gmail.com> wrote:

> Reviewed-by: Steve Longerbeam <steve_longerbeam@mentor.com>

Ping? Anybody taking this one?

Regards,
Peter

> 
> 
> On 03/15/2018 12:13 PM, Peter Seiderer wrote:
> > - enables gstreamer v4l2src lost frame detection, e.g:
> >
> >    0:00:08.685185668  348  0x54f520 WARN  v4l2src gstv4l2src.c:970:gst_v4l2src_create:<v4l2src0> lost frames detected: count = 141 - ts: 0:00:08.330177332
> >
> > - fixes v4l2-compliance test failure:
> >
> >    Streaming ioctls:
> >            test read/write: OK (Not Supported)
> >                Video Capture:
> >                    Buffer: 0 Sequence: 0 Field: None Timestamp: 92.991450s
> >                    Buffer: 1 Sequence: 0 Field: None Timestamp: 93.008135s
> >                    fail: v4l2-test-buffers.cpp(294): (int)g_sequence() < seq.last_seq + 1
> >                    fail: v4l2-test-buffers.cpp(707): buf.check(q, last_seq)
> >
> > Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> > ---
> > Changes in v2:
> >    - fill vb2_v4l2_buffer sequence entry in imx-ic-prpencvf too
> >      (suggested by Steve Longerbeam)
> >
> > Changes in v3:
> >    - add changelog (suggested by Greg Kroah-Hartman, Fabio Estevam
> >      and Dan Carpenter) and patch history
> >    - use u32 (instead of __u32) (suggested by Dan Carpenter)
> >    - let sequence counter start with zero, keeping v4l2-compliance
> >      testing happy (needs additional setting of field to a valid
> >      value, patch will follow soon)
> >
> > Changes in v4:
> >    - add v4l2-compliance test failure to changelog
> >    - reorder frame_sequence increment and assignement to
> >      avoid -1 as start value (suggeted by Steve Longerbeam)
> > ---
> >   drivers/staging/media/imx/imx-ic-prpencvf.c | 4 ++++
> >   drivers/staging/media/imx/imx-media-csi.c   | 4 ++++
> >   2 files changed, 8 insertions(+)
> >
> > diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
> > index ffeb017c73b2..28f41caba05d 100644
> > --- a/drivers/staging/media/imx/imx-ic-prpencvf.c
> > +++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
> > @@ -103,6 +103,7 @@ struct prp_priv {
> >   	int nfb4eof_irq;
> >   
> >   	int stream_count;
> > +	u32 frame_sequence; /* frame sequence counter */
> >   	bool last_eof;  /* waiting for last EOF at stream off */
> >   	bool nfb4eof;    /* NFB4EOF encountered during streaming */
> >   	struct completion last_eof_comp;
> > @@ -211,12 +212,14 @@ static void prp_vb2_buf_done(struct prp_priv *priv, struct ipuv3_channel *ch)
> >   	done = priv->active_vb2_buf[priv->ipu_buf_num];
> >   	if (done) {
> >   		done->vbuf.field = vdev->fmt.fmt.pix.field;
> > +		done->vbuf.sequence = priv->frame_sequence;
> >   		vb = &done->vbuf.vb2_buf;
> >   		vb->timestamp = ktime_get_ns();
> >   		vb2_buffer_done(vb, priv->nfb4eof ?
> >   				VB2_BUF_STATE_ERROR : VB2_BUF_STATE_DONE);
> >   	}
> >   
> > +	priv->frame_sequence++;
> >   	priv->nfb4eof = false;
> >   
> >   	/* get next queued buffer */
> > @@ -638,6 +641,7 @@ static int prp_start(struct prp_priv *priv)
> >   
> >   	/* init EOF completion waitq */
> >   	init_completion(&priv->last_eof_comp);
> > +	priv->frame_sequence = 0;
> >   	priv->last_eof = false;
> >   	priv->nfb4eof = false;
> >   
> > diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> > index 5f69117b5811..3f2ce05848f3 100644
> > --- a/drivers/staging/media/imx/imx-media-csi.c
> > +++ b/drivers/staging/media/imx/imx-media-csi.c
> > @@ -111,6 +111,7 @@ struct csi_priv {
> >   	struct v4l2_ctrl_handler ctrl_hdlr;
> >   
> >   	int stream_count; /* streaming counter */
> > +	u32 frame_sequence; /* frame sequence counter */
> >   	bool last_eof;   /* waiting for last EOF at stream off */
> >   	bool nfb4eof;    /* NFB4EOF encountered during streaming */
> >   	struct completion last_eof_comp;
> > @@ -237,12 +238,14 @@ static void csi_vb2_buf_done(struct csi_priv *priv)
> >   	done = priv->active_vb2_buf[priv->ipu_buf_num];
> >   	if (done) {
> >   		done->vbuf.field = vdev->fmt.fmt.pix.field;
> > +		done->vbuf.sequence = priv->frame_sequence;
> >   		vb = &done->vbuf.vb2_buf;
> >   		vb->timestamp = ktime_get_ns();
> >   		vb2_buffer_done(vb, priv->nfb4eof ?
> >   				VB2_BUF_STATE_ERROR : VB2_BUF_STATE_DONE);
> >   	}
> >   
> > +	priv->frame_sequence++;
> >   	priv->nfb4eof = false;
> >   
> >   	/* get next queued buffer */
> > @@ -544,6 +547,7 @@ static int csi_idmac_start(struct csi_priv *priv)
> >   
> >   	/* init EOF completion waitq */
> >   	init_completion(&priv->last_eof_comp);
> > +	priv->frame_sequence = 0;
> >   	priv->last_eof = false;
> >   	priv->nfb4eof = false;
> >     
> 

