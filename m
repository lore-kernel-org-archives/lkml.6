Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3379410-1519922613-2-15733966387109762857
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519922612; b=QnbXXQiHPFN4Bmu2JUXaIF2N/w75wMGG9NSqb7QnxU6wWLd
    ys7hO2xsNTrn3qchsva88ifX3jw6S7G9yOlTstHMbzv3NzocSUa+HTpKAL0zsVPO
    tYQCKnAo/ZfebBzm0Wklfvi3Lunlb4U1SJRcKHN9Ry70T8DMGTe27w82OEEmY/Kq
    l3E2YrLruxqXUMBO/w3Ojp/p/MRBJ72Ef2siZmnVtiJpEhFCf4X1YQP9U5cj6lzZ
    +exeHtmj1uIZEokIUoBGqOXg2+Z1RbAdBvfovurgnlM0s/na535P64I7YVM55e8q
    Pb80lP4hOQAhbQ1GeTMDUepb8O+FaPrFhfDWsaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519922612; bh=A
    xxpzW9EJJEI0dEJUBRzBQ/g/K1I15A/E2P8JoIYX4w=; b=ocpIJPxg0Dcf1o8sz
    vy9TXeNUIw3n+OT58BS/pN1bKiaCG5+Jrq+U1xyRIQeLV8ImOnuSJykq7+O8BA12
    xAC+/MjoTaoeUdOrR6jjg5uuBdutqamscI4Lru6u37qpxN+98IgfjroILyfsJ1/f
    0M0tu/2JAg+i9xkXQqQIxldQPDWyOWMP+ZnJ/kUcv3VBx7o8c5tWv9DpeKMiVwEx
    970lSdYkxTVx1TyIzBjkeHFgI7mRhnXLjLEreGE/pG3Qsk8c1py4NzqAGpz+lN5s
    oY9rIWkS3XmyPVB7+LwpjhxMVgJx9BYwamWPkK+wxi0Usa2QTvdFkA5cVpjorh1a
    A86Fg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ise6A5Es x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hbiGC6Bl;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ise6A5Es x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hbiGC6Bl;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELt5aycHu/dbe2Q8IlnWXekuYCE7lJh8jDV+R/6q/paN1qfEG6wy9UOFFhQE/11xAkqruwR7ef0U86+0D3vrt1A=
MIME-Version: 1.0
In-Reply-To: <1519921628.3034.5.camel@pengutronix.de>
References: <20180301040939.GA13274@embeddedgus>
 <CAOMZO5B_UGZ3De1UjUXzU6-wGMgRrRJVWZ8z+a+HoCpwWkeBwg@mail.gmail.com>
 <1519921628.3034.5.camel@pengutronix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 1 Mar 2018 13:43:22 -0300
Message-ID: <CAOMZO5C93iuJSPw48vare5qCHwZiDDOva6X0bZ=xVTr1XJRPbg@mail.gmail.com>
Subject: Re: [PATCH] staging/imx: Fix inconsistent IS_ERR and PTR_ERR
To: Philipp Zabel <p.zabel@pengutronix.de>
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

On Thu, Mar 1, 2018 at 1:27 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> Oh, this only works for csi ports that have pinctrl in their csi port
> node, like:
>
> &ipu1_csi0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_ipu1_csi0>;
> };

This is the case for imx6qdl-sabresd.dtsi and even in this case
devm_pinctrl_get_select_default() fails

> pinctrl would have to be moved out of the csi port nodes, for example
> into their parent ipu nodes, or maybe more correctly, into the video mux
> nodes in each device tree.

Tried it like this:

--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -154,12 +154,9 @@
 };

 &ipu1_csi0_mux_from_parallel_sensor {
-       remote-endpoint = <&ov5642_to_ipu1_csi0_mux>;
-};
-
-&ipu1_csi0 {
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_ipu1_csi0>;
+       remote-endpoint = <&ov5642_to_ipu1_csi0_mux>;
 };

 &mipi_csi {


but still get the devm_pinctrl_get_select_default() failure.

I was not able to change the dts so that
devm_pinctrl_get_select_default() succeeds.

If you agree I can send the following change:

diff --git a/drivers/staging/media/imx/imx-media-csi.c
b/drivers/staging/media/imx/imx-media-csi.c
index 5a195f8..c40f786 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1797,11 +1797,8 @@ static int imx_csi_probe(struct platform_device *pdev)
         */
        priv->dev->of_node = pdata->of_node;
        pinctrl = devm_pinctrl_get_select_default(priv->dev);
-       if (IS_ERR(pinctrl)) {
-               ret = PTR_ERR(priv->vdev);
-               goto free;
-       }
-
+       if (IS_ERR(pinctrl))
+               dev_dbg(priv->dev, "pintrl_get_select_default() failed\n");
        ret = v4l2_async_register_subdev(&priv->sd);
        if (ret)
                goto free;

So that the error is ignored and we still can change the pinctrl values via dts.

What do you think?
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
