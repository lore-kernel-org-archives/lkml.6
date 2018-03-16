Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3497619-1521219782-2-1635236202947137062
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521219781; b=Jb2vMeCyP3/xwseVZn2rt+gXGMa5v2MTHxiJy7sJwRm2wgT
    YKwurVWDAj5HMiEXmgydhLCGdj5+uFYvEIVcP0j95s8pTD9u0WC0Vmvpie2gF/YX
    UpnA2oiBAP+JoT9sBb3siIDuUO/rA+gtbT9/EAedpinhLAwLfSJyRU7OnZU6qlgb
    RW2gbogVQfa6Qrs710AGfgp/U8pwIQseRyS3HNpJx9ncXHsigZuJeRXhpABG62si
    0AWm5nq49hJljS2UgMpK3e28Fxi5xeKd1Ih/sbxJ2zUM1wCDYoHpj4qT8Ud5V1tD
    SiM124Ppu6LvQ0M+K6uBzw1W8K1IpRK/QEwZSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1521219781; bh=3tkiiV4xv2ohafXGmsLChOBzvh872l8VC0vx5r2K77Q=; b=x
    DIjfYdBWLzorC31vbHMkJOOx+X7xBpAn5wG6FHnj2OcN62hA9hfdUp7qjxD0Tz7I
    Nuvdf5rXGHcEmcWXgY0DdETwOIb4sKW4crjHYO3UBY3q3X4CvwYtnnFR1701tucc
    c3SCSFY4jM/FmDtH++ompEKrzWIkcreMcyGrTujLeuz3+zfBKh7/VZbmiF5aSa3u
    GaMm1pwgIyY3nHa5uMggXtuc0ypHACbzuQ70qxQNe4Cfm2bMe5qdNgmdfv76PDTq
    zPR977jGKoFL/8ZVmmW5vqAOpVG80R2mbYkbszKZW3VfGAE1B9oIgHQI7hdIGb4m
    qStCFakKKytk1DqLuIskA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MRRzUyso x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Y5HJYorY;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MRRzUyso x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Y5HJYorY;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtpZhGfva2K6phxyL2MTzEmuyZFbAwtcRMm/yP67iHmmdBtM8wPgIto9UTWVG+yJsCSTp1zrg==
Subject: Re: [PATCH v4 1/2] media: staging/imx: fill vb2_v4l2_buffer field
 entry
To: Peter Seiderer <ps.report@gmx.net>, linux-media@vger.kernel.org
References: <20180315191323.6028-1-ps.report@gmx.net>
From: Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <9d5ff49f-6d07-0371-9cc1-5ee929328241@gmail.com>
Date: Fri, 16 Mar 2018 10:02:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315191323.6028-1-ps.report@gmx.net>
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

Reviewed-by: Steve Longerbeam <steve_longerbeam@mentor.com>


On 03/15/2018 12:13 PM, Peter Seiderer wrote:
> - fixes gstreamer v4l2src warning:
>
>    0:00:00.716640334  349  0x164f720 WARN  v4l2bufferpool gstv4l2bufferpool.c:1195:gst_v4l2_buffer_pool_dqbuf:<v4l2src0:pool:src> Driver should never set v4l2_buffer.field to ANY
>
> - fixes v4l2-compliance test failure:
>
>    Streaming ioctls:
>            test read/write: OK (Not Supported)
>                Video Capture:
>                    Buffer: 0 Sequence: 0 Field: Any Timestamp: 58.383658s
>                    fail: v4l2-test-buffers.cpp(297): g_field() == V4L2_FIELD_ANY
>
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> ---
> Changes in v4:
>    - new patch (put first because patch is needed to advance with
>      the v4l2-compliance test), thanks to Philipp Zabel
>      <p.zabel@pengutronix.de> for suggested solution for the right
>      field value source
> ---
>   drivers/staging/media/imx/imx-ic-prpencvf.c | 1 +
>   drivers/staging/media/imx/imx-media-csi.c   | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
> index ae453fd422f0..ffeb017c73b2 100644
> --- a/drivers/staging/media/imx/imx-ic-prpencvf.c
> +++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
> @@ -210,6 +210,7 @@ static void prp_vb2_buf_done(struct prp_priv *priv, struct ipuv3_channel *ch)
>   
>   	done = priv->active_vb2_buf[priv->ipu_buf_num];
>   	if (done) {
> +		done->vbuf.field = vdev->fmt.fmt.pix.field;
>   		vb = &done->vbuf.vb2_buf;
>   		vb->timestamp = ktime_get_ns();
>   		vb2_buffer_done(vb, priv->nfb4eof ?
> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> index 5a195f80a24d..5f69117b5811 100644
> --- a/drivers/staging/media/imx/imx-media-csi.c
> +++ b/drivers/staging/media/imx/imx-media-csi.c
> @@ -236,6 +236,7 @@ static void csi_vb2_buf_done(struct csi_priv *priv)
>   
>   	done = priv->active_vb2_buf[priv->ipu_buf_num];
>   	if (done) {
> +		done->vbuf.field = vdev->fmt.fmt.pix.field;
>   		vb = &done->vbuf.vb2_buf;
>   		vb->timestamp = ktime_get_ns();
>   		vb2_buffer_done(vb, priv->nfb4eof ?

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
