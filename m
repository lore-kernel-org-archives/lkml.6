Return-Path: <hverkuil@xs4all.nl>
X-Google-Smtp-Source: AIpwx49jYk6jgkB3LvNl7zVVeymP5JX6MuRNxSjH/50/TQmWnnoqS5H5+jWZrPMnjeNwUseg70uN
ARC-Seal: i=1; a=rsa-sha256; t=1524395218; cv=none;
        d=google.com; s=arc-20160816;
        b=CbymUgiTjGfxHSqPjsG6v43X95w6Wxgd5yYXwi/3SKWR0IddZKAmeVJ05KTulNQbRV
         FczlKinPdHls+hv/9xSXHe/RyYBCpEden24C10GRDixjvQAFtbrkr5lYPKLWDyjQYiir
         En1BzzWflh7DiY9RHcfhr6PxnHRyQ+GdI11Bvkjvt0+iMo8zEa9v6a2XZ0PuVctIWdKD
         kgNvj4zHcgkc6GVUzgK/ks5QN2Nzk32qi+FsuRYDujQJd72uax67njhkzJ0wlD9FLAK4
         YmlMBqQsNC7YT8vIvDdIhcXhqktZMCojQHt/xp6I6XjS3/NVX7GOoBYKelI3EnyTmnHl
         sg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=pibUF59dyi4aHhvK4aNEby4Vh08XD8VitMxQ98eNcIk=;
        b=ag+ojkSUuQ+gK4N88ETrXaai0I7Tw6fFycoZUCH3XYJUW+KfVd4bWFraSXHabsjGbY
         jyZwU/S87kCkoAlmVT2qpvu7Tk1JRMq/4iwv/1BdeOg3g9oZ+B2fOyPD3V5O3GMZrIxx
         WITuYYvVao3c5H/jv5B8jzQRWyHmqEc633TwLiInspMBCDN7oooXiPplJBeMfdrZ4dUD
         FVgYP035LWAdxoZRL6aFGIt0ZoFtAaPmBHAdGZAkpLNJqZQX5IWELFIIbZ2SHvRj+nl3
         hpJX3FSBXARENSE9BBxkKBWE+qs7r9LuMosqIebeUhGWhXMVF/8zs6Y2Ytx4OSQq/dVU
         SYdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hverkuil@xs4all.nl designates 194.109.24.25 as permitted sender) smtp.mailfrom=hverkuil@xs4all.nl
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hverkuil@xs4all.nl designates 194.109.24.25 as permitted sender) smtp.mailfrom=hverkuil@xs4all.nl
Subject: Re: [PATCH 04/15] media: pxa_camera: remove the dmaengine compat need
To: Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Tejun Heo <tj@kernel.org>, Vinod Koul <vinod.koul@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 Nicolas Pitre <nico@fluxnic.net>, Samuel Ortiz <samuel@sortiz.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Petr Cvek <petr.cvek@tul.cz>,
 Sakari Ailus <sakari.ailus@iki.fi>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Pravin Shedge <pravin.shedge4linux@gmail.com>,
 Flavio Ceolin <flavio.ceolin@intel.com>,
 Robert Jarzmik <robert.jarzmik@renault.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
 devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
 =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-5-robert.jarzmik@free.fr>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <89f3e97c-08a4-33b6-8fd3-0c1b4dea2065@xs4all.nl>
Date: Sun, 22 Apr 2018 13:06:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180402142656.26815-5-robert.jarzmik@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHqtpT6yjiwFYtqei8SA0FSbh6QO8VOXO7YA5snpYPodLxPssGwQ9apgwSWzllasxtdCRw+LXSpVVEKhU5oUItqh9KiRppl0QwN6rjqWFERDcocOFsyq
 fFbSOqnG4KKLLOTRv5o39VdpDHZXDJpLzGkeTZDJv6kJV1GMkSuK4vml55SJ5oa6On7JPDQ1RSR52qZctFdjDCvEaS086gpsSrcqG28+WgwaxsK1xoVtti9C
 BLvf73pz1e+jTtO+oPMBsgzLqUy25oSB2YUxm0NQr2rKFlrLXpquJornII+IjGeexlqXlz/8PhKOT7oanMWJjd/+Rcf4ShWZgqrFiYc4fBZXglUTal5GgBAK
 zIjPSF3+zPk+m8x6gn0NnrBK7xDxYd1iQr3b+6xzHVb/Fk4N1mqAlWueORv/RyFoqJmUa9rkkLt3Z5hwnMVGAYquhqZYDh9EX/Yemem6CuRcApEK7x+27O9M
 mcOIypxqm33+rPjSkSOK1O7QrJYDWS/mZ14YqEsdnAyb76+Mf73a3bfnHcgIEMUCTxutddkYs6r999HvXiqnsrbr+0smp3FG6JLvA8V1Pw37VSEvoZVzvfzC
 17DUSkPUqBcvciBwvF5eyejuBf3eG1KtmOAx21qqSl068rQucoVHVw9uP6Qbsmyg4UI886k8hqc+mKHIekwNaEb4aQsxJ2XcpJiwK9ISrVv1DiArVNS9folV
 jxVzuaAGMgvlAlq8ronrfHn7I0L1TRphq1B/MSMo1uA0v9QSdoFWRQx6Cxe8venIPm9L+wghWQQY3siETmPylpPcY/Y/ip1o6c0Smhwo3BWVyq7ldCyXwE3z
 C+CAoqXPkiXoQ8NfN0mHVNA8bGD1V6s4KckaIePvIbBfpGL6C1R0uVoZue8bvCDAFD4aNSJ9h67n2Ix9Wo425OXQj41Fl+LRKHwsuu/hsAxHp43IY/iJm6vw
 s3SDwox+tGUzqXt66dWRzYlLtYXES8udbd/wFY1rp41GnuSOaUMjUvCB4TGRsXJxyYq8cWu6r0AYSKSAURle1E7IY43wQkkFdkhjV6lu59er/i3yOgjAdou9
 DYdJ7h3oAtV2Nv92fyPqVPAB5L3OHQysL4koMmInmnkjZIkh45Lb+xPj1e2jJZIV60SvYrMP31WshWrq6sxcbDObqhuJkrLoWs6vUgWPoH57HJB2pZGIbEWA
 sFbCf0ZR0JigcrGppXsir0EYyqPKK4TLhelub7ayAJUgf61wD+WZ6M9dCVyaFErlj50bsE/Ei2J+HQefe+FKYaG78lnlcjVMHIQxjHXfW1/F74KYUrpOvZVo
 KpbvrL8I7lDb2s4k1pcQmn4YuA3CzX/iQnoAjbTbsXedo+QPdWJF9/uWL9/J2Iyyg+KKh9tDbMiZznn/FLulR5LqKwLGwVbxMnXUnxIdNc7+ZHOahwcMgH09
 CBtzuZRGAWWjSmZFJ53wJ8KmQnx897BYMiMWVFmmmHNYYtO8OI9iYxyk1McIynR1Wm7aTvLUPcmEDXK/6XNb5oRYO0Td2di+0kSPrQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596644928520099498?=
X-GMAIL-MSGID: =?utf-8?q?1598444240807485336?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/02/2018 04:26 PM, Robert Jarzmik wrote:
> From: Robert Jarzmik <robert.jarzmik@renault.com>
> 
> As the pxa architecture switched towards the dmaengine slave map, the
> old compatibility mechanism to acquire the dma requestor line number and
> priority are not needed anymore.
> 
> This patch simplifies the dma resource acquisition, using the more
> generic function dma_request_slave_channel().
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Regards,

	Hans

> ---
>  drivers/media/platform/pxa_camera.c | 22 +++-------------------
>  1 file changed, 3 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/media/platform/pxa_camera.c b/drivers/media/platform/pxa_camera.c
> index c71a00736541..4c82d1880753 100644
> --- a/drivers/media/platform/pxa_camera.c
> +++ b/drivers/media/platform/pxa_camera.c
> @@ -2357,8 +2357,6 @@ static int pxa_camera_probe(struct platform_device *pdev)
>  		.src_maxburst = 8,
>  		.direction = DMA_DEV_TO_MEM,
>  	};
> -	dma_cap_mask_t mask;
> -	struct pxad_param params;
>  	char clk_name[V4L2_CLK_NAME_SIZE];
>  	int irq;
>  	int err = 0, i;
> @@ -2432,34 +2430,20 @@ static int pxa_camera_probe(struct platform_device *pdev)
>  	pcdev->base = base;
>  
>  	/* request dma */
> -	dma_cap_zero(mask);
> -	dma_cap_set(DMA_SLAVE, mask);
> -	dma_cap_set(DMA_PRIVATE, mask);
> -
> -	params.prio = 0;
> -	params.drcmr = 68;
> -	pcdev->dma_chans[0] =
> -		dma_request_slave_channel_compat(mask, pxad_filter_fn,
> -						 &params, &pdev->dev, "CI_Y");
> +	pcdev->dma_chans[0] = dma_request_slave_channel(&pdev->dev, "CI_Y");
>  	if (!pcdev->dma_chans[0]) {
>  		dev_err(&pdev->dev, "Can't request DMA for Y\n");
>  		return -ENODEV;
>  	}
>  
> -	params.drcmr = 69;
> -	pcdev->dma_chans[1] =
> -		dma_request_slave_channel_compat(mask, pxad_filter_fn,
> -						 &params, &pdev->dev, "CI_U");
> +	pcdev->dma_chans[1] = dma_request_slave_channel(&pdev->dev, "CI_U");
>  	if (!pcdev->dma_chans[1]) {
>  		dev_err(&pdev->dev, "Can't request DMA for Y\n");
>  		err = -ENODEV;
>  		goto exit_free_dma_y;
>  	}
>  
> -	params.drcmr = 70;
> -	pcdev->dma_chans[2] =
> -		dma_request_slave_channel_compat(mask, pxad_filter_fn,
> -						 &params, &pdev->dev, "CI_V");
> +	pcdev->dma_chans[2] = dma_request_slave_channel(&pdev->dev, "CI_V");
>  	if (!pcdev->dma_chans[2]) {
>  		dev_err(&pdev->dev, "Can't request DMA for V\n");
>  		err = -ENODEV;
> 
