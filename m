Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-9491-1520978598-2-17541381372190297743
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520978597; b=ZeyoWTZBuUu5tYrkUjhc0YOkrvvhliBMGENDsZ/7E99h6ir
    kdeIgAM4Zp0XSwAl+5aWjfLPog+dNKYvnqNbDR7Q6022N/b2kuUfCCBoPYguRB+X
    CJF3F5Jmor8HbS9/OI2zfTOOHDIOBDkUTLrKwLaqyLlrMvMbAVm3wmiLOiV/Y95Q
    /JQ46xp2Z3dmQVH3zLwVZw3lba+pznI6k2ClWAMsz5rfOPy/i46Al4rTZj4eKZoh
    0h/3vwM3GDAZrn+mdRoUDUxbjekU2aIixD5JR92ShoYyC/EtMAOMfF/leIfRIhPD
    Bl/WnjfafGQEaTNib5FejXI+SAYr8ANExuF57QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1520978597; bh=tWXjGapVawmAsuTIMT2/eTOLEXaFVYrsgbIVe6TeAZU=; b=n
    TxguVpJheL+0G11GxmlM0b0iku86x++766vVxSoXP/1/KTuEZmirogdW7xgruzfQ
    xi4h+9mzP1fytnjEaePPzMJotMDw/uq+UZq6EV1060FTO0Ku/tOgZCi05pq/hd2F
    JvO1t7O7CSvitDDYrW1aHsk7HxQHTRoiwla0O/8HYZM97MzmaKcRv9GHCEREFWgz
    FspLkZ72x/yI4bi6LXQ5gm/qkM6R564x+GUFDptbvXJ5YsEZa8woMMeA48K61H/y
    fMdNj4p201oK6x8se++C6+imOvQ1dXfzypH+oUd7xu+YfFv2GUhGJ28nNYX810uh
    LkwQxKszaX062C95FTQnw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tDJruWSp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iKpVZAmr;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tDJruWSp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iKpVZAmr;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsx7bx8LNvXj1eXFJVI2evao+8zQg/VhlRbxS8Y3Dr7kNILmX5mZ+L0qGuLtjd+I+NGkjIs/Q==
Subject: Re: [PATCH] media: staging/imx: fill vb2_v4l2_buffer sequence entry
To: Peter Seiderer <ps.report@gmx.net>, linux-media@vger.kernel.org
References: <20180313200054.31305-1-ps.report@gmx.net>
From: Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <d3601b40-d80a-b3c1-cdf0-82128d52b398@gmail.com>
Date: Tue, 13 Mar 2018 15:03:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313200054.31305-1-ps.report@gmx.net>
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

Thanks for the patch.

This needs to be done in imx-ic-prpencvf.c as well, see
prp_vb2_buf_done().

Steve


On 03/13/2018 01:00 PM, Peter Seiderer wrote:
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> ---
>   drivers/staging/media/imx/imx-media-csi.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> index 5a195f80a24d..3a6a645b9dce 100644
> --- a/drivers/staging/media/imx/imx-media-csi.c
> +++ b/drivers/staging/media/imx/imx-media-csi.c
> @@ -111,6 +111,7 @@ struct csi_priv {
>   	struct v4l2_ctrl_handler ctrl_hdlr;
>   
>   	int stream_count; /* streaming counter */
> +	__u32 frame_sequence; /* frame sequence counter */
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
> +	priv->frame_sequence = 0;
>   	priv->last_eof = false;
>   	priv->nfb4eof = false;
>   

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
