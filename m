Return-Path: <ps.report@gmx.net>
X-Google-Smtp-Source: AG47ELuZfN7jpEBZSzOoqJdLQqFEjN3+x/HkD+/tgAekT/WQFTpW5wgMbEOCoIZ/aMveeZdPjNDK
ARC-Seal: i=1; a=rsa-sha256; t=1520979892; cv=none;
        d=google.com; s=arc-20160816;
        b=ke5BuL8VaI2/mvGjOcEoE9RoD5YXhXSlgJG3SwbZg+N2BClfdpKGgPj6OpLOv29ImF
         44u3fKA83EsGG8YwRlNyCFcQFY3yjAQOgStZ0ocxUXMl4xffudqkUtd1SQV+u5QX49Ki
         MGfkvvB7iRq2Vorw09cxX2J/mma0UdUK/aAPGH+jAVOYczj783xAZKHd9hQXhYpPqecO
         j9OUAaJhOtEqX9qbFCoMjICdh/ewGfFjF3Fa7MO4equwpEndGeM4dbBZB5kewKt/o2Kf
         nkkzM0Mrm4GGDHEvhUPNXCNsOmVqKDeO0KIB0kBVo0wAjaA7vhxvBSc9GxdLGHVtqO5C
         qLYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=dQicruuMvLD/EHKYSnv5eJmg1+9OZPV4x7gm1tkR2yg=;
        b=pbteHhfZAG2JysIeJu7Oc/c0Jsrsp4iP4xpPoL5z62NuP5Cu37XXVogHzsmqYJ5+eF
         Zro2nvlu2dTJEPy+eXjkgra7PrYLUP6HY4r7bfT3g8+VmfYN6MxN8PJikNNa2w7Ay0ME
         P8axZ8XiJLDZYs1Idi//urQrysu/+tlbSbh5Kdi5+mJ3hytqnNSPt2WLulVe1oFR76dk
         kuohaQ1TAkYHa7pAmFUJqLZ5ZuP5GH+Qgc8LPsk5Crpai/dqnYefB7RdSTdZcm+yp6ym
         P38yyMVfgROTSeXKX6jskzsrlfasXoYbKZ7rXLosw0SuqOlk5irwUr7WFtOvYWc+buor
         EeFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ps.report@gmx.net designates 212.227.17.21 as permitted sender) smtp.mailfrom=ps.report@gmx.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ps.report@gmx.net designates 212.227.17.21 as permitted sender) smtp.mailfrom=ps.report@gmx.net
Date: Tue, 13 Mar 2018 23:24:49 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Steve Longerbeam <slongerbeam@gmail.com>
Cc: linux-media@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: staging/imx: fill vb2_v4l2_buffer sequence entry
Message-ID: <20180313232449.253c7626@gmx.net>
In-Reply-To: <d3601b40-d80a-b3c1-cdf0-82128d52b398@gmail.com>
References: <20180313200054.31305-1-ps.report@gmx.net>
	<d3601b40-d80a-b3c1-cdf0-82128d52b398@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:vvZiZ4yYB3Gr7dti97fYLAjzNw31wkBo58FOXkWpVcir2B0vNv4
 liqyXT22ZEQZoPVO6GpflCIJ7OUkGNr9pxvozvfnsNwGPhWMPXkd9bJ9IFoL/kH12B2blJy
 yqR20MYe+Z5tT2+CrCtMkySbzwYisraV/VcUGLe+lqsGO8Q/XsmAdZKEIAY6kKpMzQrRNYZ
 fYuIhcGQvEkt6rUNpCplQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yTEyhjrHnrA=:nJ/CFsz/XcKYVN1fwsx3qR
 412fucaYeKnQv2dERUlereEJeTCFw1T/+6xtmcE5WA3jA6koJZJ5fnFVP5fvBUUgeqo+9AyJS
 Hh0c5bPSff9qNrAN2VCPUtEkVnMidXFprr2pkrlGGb0MmwwU+dLjsQ+oNfsX5R7RRh3EH0u9t
 uKAcKBJ39ZzvVcJJIJe9KnZuw6JAdS4gJLOV3JcvQ1hYo6eANI8RYWlbBTJTcKHxReABfP2+4
 taNeVKAGD9z9Sti6/UJGL4NT2k8mPPTwntAmT8lFFlhOqF5BYg4mt7pohqHy1drNi5kVOH9IF
 jAzeRVAAwJJCQnMHV1icYUWD39q0+vQjW0VLBn0V1afuCaR8RxP/QKxRYbu1FRpZ2uJqXD17n
 z2sx76xdFarfbGMYEbi2spXxsv3Qd84Zs1ndAbo1ig0l44/E039P2kodjMUfCIf/p3xbezljt
 jIAZlEi8xVi5QA+6CwXZNazhKtde/irOurJj6xJt2WwPvQPaRAlahFOQqwToef9fduF5p3ixz
 ArqQhN5OmBN+yAZ9gUi5Kaaa0SPntI6p5FLC/+AGUKtqPpBcQCKkRphF5ctRR5TeYofeS60QW
 stSmx90q7XMYnq2+i3+GuDTX8PTO9etiwaOPthxBEJOe1ekxR7xozVFPjo9rQDuY343MreXOu
 IZA2FGgCMFd8fNlsUvTtekl83qcgztPmBk5Q3fM51NVnsF9+0FW85jdqEha1HPe4qo51kMdf6
 6Cf43MqPwb7Cle6tzmGh3Yg/l/PGmLmkeSgZU0tXkQ5Gj7cdN0/UvuJrFbPEkAkDGLvGp5Lfc
 olAkMG2HGJsgrgCCZy+WqmMf2+ZAcqnTLuSizUO3y3ba70J/ss=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853993876538607?=
X-GMAIL-MSGID: =?utf-8?q?1594863012202980785?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Steve,

On Tue, 13 Mar 2018 15:03:07 -0700, Steve Longerbeam <slongerbeam@gmail.com> wrote:

> Hi Peter,
> 
> Thanks for the patch.
> 
> This needs to be done in imx-ic-prpencvf.c as well, see
> prp_vb2_buf_done().

Ahh, I see...., would you prefer an follow up patch or
an v2 patch doing the changes on mx-media-csi.c and
imx-ic-prpencvf.c at once?

Regards,
Peter

> 
> Steve
> 
> 
> On 03/13/2018 01:00 PM, Peter Seiderer wrote:
> > Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> > ---
> >   drivers/staging/media/imx/imx-media-csi.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> > index 5a195f80a24d..3a6a645b9dce 100644
> > --- a/drivers/staging/media/imx/imx-media-csi.c
> > +++ b/drivers/staging/media/imx/imx-media-csi.c
> > @@ -111,6 +111,7 @@ struct csi_priv {
> >   	struct v4l2_ctrl_handler ctrl_hdlr;
> >   
> >   	int stream_count; /* streaming counter */
> > +	__u32 frame_sequence; /* frame sequence counter */
> >   	bool last_eof;   /* waiting for last EOF at stream off */
> >   	bool nfb4eof;    /* NFB4EOF encountered during streaming */
> >   	struct completion last_eof_comp;
> > @@ -234,8 +235,11 @@ static void csi_vb2_buf_done(struct csi_priv *priv)
> >   	struct vb2_buffer *vb;
> >   	dma_addr_t phys;
> >   
> > +	priv->frame_sequence++;
> > +
> >   	done = priv->active_vb2_buf[priv->ipu_buf_num];
> >   	if (done) {
> > +		done->vbuf.sequence = priv->frame_sequence;
> >   		vb = &done->vbuf.vb2_buf;
> >   		vb->timestamp = ktime_get_ns();
> >   		vb2_buffer_done(vb, priv->nfb4eof ?
> > @@ -543,6 +547,7 @@ static int csi_idmac_start(struct csi_priv *priv)
> >   
> >   	/* init EOF completion waitq */
> >   	init_completion(&priv->last_eof_comp);
> > +	priv->frame_sequence = 0;
> >   	priv->last_eof = false;
> >   	priv->nfb4eof = false;
> >     
> 
