Return-Path: <ck.hu@mediatek.com>
X-Google-Smtp-Source: AB8JxZpLE4ygiBgmsOF6r0umyW7E2kkE4DQdQV5RMWWUEkcGajtdgVYTfHATPF2riB+zjRTHwj9T
ARC-Seal: i=1; a=rsa-sha256; t=1525085922; cv=none;
        d=google.com; s=arc-20160816;
        b=QihSb6pDeE3YG12MUKeFLuxFsSuI2HCv4sO4H6I1euFpZAouoXDpQ5h4PPYHRKrSdb
         fkcWPgYltHaTlJzkPWxL+oc9ZJqIUY/nmoPFNDEo858dCuNpyr8+YCtudlodTcGkNvxz
         nJ5amRoRUHeyIFL8oZWSuw25Nm60jaubI/it4xupIwN0v+Of/5QPVnehX/xwVJ2qRkk/
         OBeVcsQe1dtkVKZ+3pnWI35h+KaxEUf7h8ZUExWDLeonPK2e0sHeeFVOmtIC9HniJTVr
         sASVaucF7h52f3/Ojnu9IloNiOXpqpXm/xuMimy0vqBQlsVcVlpnuNU+SsDSoxE/7gWq
         sy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=IeI8HD5ZDC8ctfZ2s5viDGXaPDJokMth+PUbdMfJP0A=;
        b=d98mNua9b1PsQx0YuUc+d/AyJuundLb8nB5pTJiSfVXGx87F3Ed3YSAcDUsCpBfAls
         gQGWpOt/QsplPkDmuACd7emSMpuY3YqhpWNQoXnjGB2V8hVNAwQtrGQvzs0PjPsD3sim
         c6RD4NDh8CJXiJNoRgKv0E0fzg8JpEU8x0QZnuWfQuLyVm9HXQpSKYOY79e/4LneyW8G
         qeCzf6yA1UeE2iYh6YQQ5BXvDdfqHNYIxofFPPzoZZOtIoYEjIOm4/XHWNG/nQz3YPoC
         eyCuQv7L5299www2cug7nzZD9gAHv3blfIKrIFLut/i1DXnKl4qXHnxsXwUvtUola9vq
         Gw6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ck.hu@mediatek.com designates 210.61.82.183 as permitted sender) smtp.mailfrom=ck.hu@mediatek.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ck.hu@mediatek.com designates 210.61.82.183 as permitted sender) smtp.mailfrom=ck.hu@mediatek.com
X-UUID: 8065ca0fb21e4205ae8cfd25f66f2a29-20180430
Message-ID: <1525085916.25456.8.camel@mtksdaap41>
Subject: Re: [v3 09/10] drm: mediatek: Omit warning on probe defers
From: CK Hu <ck.hu@mediatek.com>
To: <matthias.bgg@kernel.org>
CC: <ulrich.hecht+renesas@gmail.com>, <laurent.pinchart@ideasonboard.com>,
	<p.zabel@pengutronix.de>, <airlied@linux.ie>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>, <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
	<lee.jones@linaro.org>, <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
	<mchehab@kernel.org>, <rdunlap@infradead.org>, <sean.wang@mediatek.com>,
	<linux-clk@vger.kernel.org>, <linux@armlinux.org.uk>,
	<matthias.bgg@gmail.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Matthias Brugger <mbrugger@suse.com>
Date: Mon, 30 Apr 2018 18:58:36 +0800
In-Reply-To: <9d514a4ab45f0700663fa756d5aa3913922b6fb7.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
	 <9d514a4ab45f0700663fa756d5aa3913922b6fb7.1524820923.git.mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598890812954762218?=
X-GMAIL-MSGID: =?utf-8?q?1599168497059683912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi, Matthias:

On Fri, 2018-04-27 at 11:24 +0200, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> When probe through the MFD, it can happen that the
> clock drivers wasn't probed before the ddp driver gets
> invoked. The driver used to omit a warning that the driver
> failed to get the clocks. Omit this error on the defered probe path.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

It's better to use 'drm/mediatek:' for title to align drm commits.
For the modification,

Acked-by: CK Hu <ck.hu@mediatek.com>

Regards,
CK

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index bafc5c77c4fb..6b399348a2dc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -374,7 +374,8 @@ static int mtk_ddp_probe(struct platform_device *pdev)
>  
>  	ddp->clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(ddp->clk)) {
> -		dev_err(dev, "Failed to get clock\n");
> +		if (PTR_ERR(ddp->clk) != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get clock\n");
>  		return PTR_ERR(ddp->clk);
>  	}
>  
