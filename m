Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1330799-1519988119-2-1513445749796256522
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519988118; b=JoFNjCCIliXAPynTO3OCc4O6j21Jdz530K/5q+Ho7edmCoK
    +QQAFu0NxcmlgH4y/wUsQA5b9HH38sUrBMczwRF6yIYvV/Azo+WGrETySBvHpiY0
    qaFyxHG7QA62fDsjjXSEPw+R3IDEdX0Bq2J/QD/CkM/Lng88/r0qFno6Hfd0p3VJ
    oOJp/VJT5QHOPeM/cofN78BRLk1xEM8aKpmjkpz7lCjipciha7EwhsBIdS9EkyKT
    tWcROuzSU+h3nacUK0a3xd65k387DmGa5aQGvLunllfD/2LlD0g39VJTfVg+9XCS
    n9pgPOQ5QcbXOWsyMoM3Kr2dMN3vMpWo8jCshzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:date
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519988118; bh=k
    IGwTRT1chI/+TcbDRxQrlkQW534uV8pxavAyZSG9Ns=; b=IsLTV50EivQnI0WU3
    r7aK2PGD3NkiU2MVVJtpH5igo2xjOhzukqH1GJVfu3qmVvwiiAOvCGsc+E91sit0
    tEW8i7WNTVV1gsrtXe3OIAnpMOwVZRNLxd5CTgIYPs8FtsrQDgY/jUIj8pkYa4uh
    RrUVTxqnK9wgp8vpot7IsyTM4pVZufZgUTi8FAKoY343q02fDhGZaNYQGCASq8u+
    WpGCZ3EzuuNkVsA//01MGT27kXfxfDSxQax7K8Oeo64COf734iaWA4drVuF6wnhR
    o+Xh/lz8N/9WTdc+AGnyboXI9PfGYBXKILZzZ3ra9MGMVGJ0nx8LakwnAI9NrXSG
    VB8Vg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=pengutronix.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=pengutronix.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Message-ID: <1519988099.16239.5.camel@pengutronix.de>
Subject: Re: [PATCH] staging/imx: Fix inconsistent IS_ERR and PTR_ERR
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Date: Fri, 02 Mar 2018 11:54:59 +0100
In-Reply-To: <CAOMZO5C93iuJSPw48vare5qCHwZiDDOva6X0bZ=xVTr1XJRPbg@mail.gmail.com>
References: <20180301040939.GA13274@embeddedgus>
 <CAOMZO5B_UGZ3De1UjUXzU6-wGMgRrRJVWZ8z+a+HoCpwWkeBwg@mail.gmail.com>
 <1519921628.3034.5.camel@pengutronix.de>
 <CAOMZO5C93iuJSPw48vare5qCHwZiDDOva6X0bZ=xVTr1XJRPbg@mail.gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: devel@driverdev.osuosl.org
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
Cc: devel@driverdev.osuosl.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
 Steve Longerbeam <slongerbeam@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Fabio,

On Thu, 2018-03-01 at 13:43 -0300, Fabio Estevam wrote:
> On Thu, Mar 1, 2018 at 1:27 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> 
> > Oh, this only works for csi ports that have pinctrl in their csi port
> > node, like:
> > 
> > &ipu1_csi0 {
> >         pinctrl-names = "default";
> >         pinctrl-0 = <&pinctrl_ipu1_csi0>;
> > };
> 
> This is the case for imx6qdl-sabresd.dtsi and even in this case
> devm_pinctrl_get_select_default() fails
> 
> > pinctrl would have to be moved out of the csi port nodes, for example
> > into their parent ipu nodes, or maybe more correctly, into the video mux
> > nodes in each device tree.
> 
> Tried it like this:
> 
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -154,12 +154,9 @@
>  };
> 
>  &ipu1_csi0_mux_from_parallel_sensor {
> -       remote-endpoint = <&ov5642_to_ipu1_csi0_mux>;
> -};
> -
> -&ipu1_csi0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_ipu1_csi0>;
> +       remote-endpoint = <&ov5642_to_ipu1_csi0_mux>;
>  };
> 
>  &mipi_csi {
> 
> 
> but still get the devm_pinctrl_get_select_default() failure.

Yes, this would still require to ignore the pinctrl error in the CSI
driver.

I just think that this is might be more correct, since the external pins
are directly connected to the mux input port.

> I was not able to change the dts so that
> devm_pinctrl_get_select_default() succeeds.
> 
> If you agree I can send the following change:
> 
> diff --git a/drivers/staging/media/imx/imx-media-csi.c
> b/drivers/staging/media/imx/imx-media-csi.c
> index 5a195f8..c40f786 100644
> --- a/drivers/staging/media/imx/imx-media-csi.c
> +++ b/drivers/staging/media/imx/imx-media-csi.c
> @@ -1797,11 +1797,8 @@ static int imx_csi_probe(struct platform_device *pdev)
>          */
>         priv->dev->of_node = pdata->of_node;
>         pinctrl = devm_pinctrl_get_select_default(priv->dev);
> -       if (IS_ERR(pinctrl)) {
> -               ret = PTR_ERR(priv->vdev);
> -               goto free;
> -       }
> -
> +       if (IS_ERR(pinctrl))
> +               dev_dbg(priv->dev, "pintrl_get_select_default() failed\n");

I would add the error code to the debug print.

>         ret = v4l2_async_register_subdev(&priv->sd);
>         if (ret)
>                 goto free;
> 
> So that the error is ignored and we still can change the pinctrl values via dts.
> 
> What do you think?

Maybe we should still throw the error if it is anything other than
-ENODEV (which we expect in case there is no pinctrl property in the csi
port node):

	if (IS_ERR(pinctrl)) {
		ret = PTR_ERR(pinctrl);
		dev_dbg(priv->dev, "pinctrl_get_select_default() failed: %d\n",
			ret);
		if (ret != -ENODEV)
			goto free;
	}

regards
Philipp
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
