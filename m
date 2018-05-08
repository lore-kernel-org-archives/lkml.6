Return-Path: <drustafa@yandex.ru>
X-Google-Smtp-Source: AB8JxZqHY5t4oAzERPJbKgIHLipCsmeZt8dmL/AWVyLnd+m4KNAGX3y7RRaZ/W5By1vUt5CMy1Qg
ARC-Seal: i=1; a=rsa-sha256; t=1525777339; cv=none;
        d=google.com; s=arc-20160816;
        b=nnuGOGS8+QlPFxTfE9mVBI+p1lsN/ybY9DEIpzii/6FV+2NQzxv+MGPe5fMOghyTFr
         tPh4p9nxpr65+pEVxBFRn9hP9ed+QB3/cH/tC8DYZaIP3Q0H3WKY92AgJS8LQMVJeKCh
         P4/jdDOWq6/ytA9uFAphtLnZUsedfJna0vkn5L2vb5V0TBtl8VBqortYdpmvbygFF90F
         riK53H1UvCJZf0XWQ9rr3E7PcvpuTa6rDtVo2qFo+LWldcg115IAP134WQPQLgP0Yv7S
         SpSKl+gRfzTHrq/8U3E/z4xTfNgLhv2xoVwZzdQdwJKCcLcFVEE1DZHXuzVFjqy4i7cJ
         dpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:date:message-id:mime-version:subject
         :references:in-reply-to:cc:to:envelope-from:from:dkim-signature
         :arc-authentication-results;
        bh=pZKG8s2N3BqSZrRpwOnCxELDlAnbiPIneigIBImz/wc=;
        b=r0QhTXZn7AVbV9d6PxWJk/J9HhCCfFfPwtJWX3Y59+dSxchN16vLpcNRFx8oinwYLS
         HZZEZvpH/zGTmnrCAeqCmLE9GC2G1VAsF6JnJhMZaOwkUDZY7Zz9p1iafrdWBaF0kBZM
         zC9zt7Bflp/Nl2lakza3SUUoBHZqMVGcUoWPBwXGfdrrrTr3Gl6phKT3iqc/Sy6U5Nw4
         JMtg1sxvvC7U8Ff6drsHZ7qvaVNrsMBnXTjTs9WS0jI+FopTDBt2j2VbBt4oeiVds2pb
         LhI2T2TcNP8mg2XGIe5eCM3Zjs4fCw7T96twnA/JlCfScZ1wIfb1kQPsnPzKqYZnpd/5
         z+eg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@yandex.ru header.s=mail header.b=aZIcWwZK;
       spf=pass (google.com: domain of drustafa@yandex.ru designates 37.9.109.247 as permitted sender) smtp.mailfrom=drustafa@yandex.ru
Authentication-Results: mx.google.com;
       dkim=pass header.i=@yandex.ru header.s=mail header.b=aZIcWwZK;
       spf=pass (google.com: domain of drustafa@yandex.ru designates 37.9.109.247 as permitted sender) smtp.mailfrom=drustafa@yandex.ru
Authentication-Results: mxback6j.mail.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgeniy Polyakov <zbr@ioremap.net>
Envelope-From: drustafa@yandex.ru
To: Stefan Potyra <stefan.potyra@elektrobit.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>,
	"sil2review@lists.osadl.org" <sil2review@lists.osadl.org>
In-Reply-To: <20180502085531.GA10525@er01809n.ebgroup.elektrobit.com>
References: <20180419130254.7nriykiybpyi6j2g@agrajag.zerfleddert.de>
	 <4863111525100577@web2o.yandex.ru>
	 <20180502083420.GA8549@er01809n.ebgroup.elektrobit.com> <20180502085531.GA10525@er01809n.ebgroup.elektrobit.com>
Subject: Re: [PATCH v2] w1: mxc_w1: Enable clock before calling clk_get_rate() on it
MIME-Version: 1.0
Message-Id: <692971525777337@web22j.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 08 May 2018 14:02:17 +0300
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599341943708820209?=
X-GMAIL-MSGID: =?utf-8?q?1599893499721820025?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Stefan

02.05.2018, 11:55, "Stefan Potyra" <stefan.potyra@elektrobit.com>:
> According to the API, you may only call clk_get_rate() after actually
> enabling it.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Fixes: a5fd9139f74c ("w1: add 1-wire master driver for i.MX27 / i.MX31")
> Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>

Looks good to me, thank you!
Greg, please pull it into your tree, this also sounds like stable material, is it?

Acked-by: Evgeniy Polyakov <zbr@ioremap.net>

> ---
>  drivers/w1/masters/mxc_w1.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/w1/masters/mxc_w1.c b/drivers/w1/masters/mxc_w1.c
> index 74f2e6e6202a..8851d441e5fd 100644
> --- a/drivers/w1/masters/mxc_w1.c
> +++ b/drivers/w1/masters/mxc_w1.c
> @@ -112,6 +112,10 @@ static int mxc_w1_probe(struct platform_device *pdev)
>          if (IS_ERR(mdev->clk))
>                  return PTR_ERR(mdev->clk);
>
> + err = clk_prepare_enable(mdev->clk);
> + if (err)
> + return err;
> +
>          clkrate = clk_get_rate(mdev->clk);
>          if (clkrate < 10000000)
>                  dev_warn(&pdev->dev,
> @@ -125,12 +129,10 @@ static int mxc_w1_probe(struct platform_device *pdev)
>
>          res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>          mdev->regs = devm_ioremap_resource(&pdev->dev, res);
> - if (IS_ERR(mdev->regs))
> - return PTR_ERR(mdev->regs);
> -
> - err = clk_prepare_enable(mdev->clk);
> - if (err)
> - return err;
> + if (IS_ERR(mdev->regs)) {
> + err = PTR_ERR(mdev->regs);
> + goto out_disable_clk;
> + }
>
>          /* Software reset 1-Wire module */
>          writeb(MXC_W1_RESET_RST, mdev->regs + MXC_W1_RESET);
> @@ -146,8 +148,12 @@ static int mxc_w1_probe(struct platform_device *pdev)
>
>          err = w1_add_master_device(&mdev->bus_master);
>          if (err)
> - clk_disable_unprepare(mdev->clk);
> + goto out_disable_clk;
>
> + return 0;
> +
> +out_disable_clk:
> + clk_disable_unprepare(mdev->clk);
>          return err;
>  }
>
> --
> 2.17.0
