Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-126535-1520983305-2-4840401142424040812
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520983305; b=Opw/GLmhRn6H4SOhO/QlIrzMAP6ujnX8Vim4AS3B/DUAPSN
    Y7pltJ2hg+EtMSxw2ye6vwcUnXAiAcAepigWUA+2+q/hu/Vavy7kSn2F51bUFg7x
    OAplDFu3Saq+BzjxhofetqqDlpC33MjjTC3DaZh2AltjcK5cmZ6m368P3uSIKNFO
    OM9RiHrE8zEmuATIoxMqqpFCl1c4miRsvmnnEgORFqrWgvBkCbKsH+ARC4xk9K+2
    0WAkdBn/Au4U1MAD/6aoyyOWzcssbCvF1aTDSFjEulDyHw/ZLcj9TQxJMSIdnjIQ
    u8qrnTGlfnj+ydqUg5UPOl2mGLiyLQrcOCVjG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520983305; bh=TxzZTe5nugKDMH/chBl+8Mv3maeKsxgHbtwG33itKs4=; b=w
    H1aWWjALFfgUTigwafpYzB2nNj4JE7wvV1ilil/Dz1YmRrGzFWfDhz4L5DXDZShM
    JUrJoOpv8x/R/TnPENog24514h1/1vJ9Cb7xV4EVdUQtDKPRppBXj8OrKLVxZHkJ
    ta6cSSXVA8itdET7qwlCKCpkVdwsG6zkH00UqPerLLw3zTuGM4dZSMbFE+zX221h
    FF/NI80IKXZSAq9o4tGVGUUc2Bhr2hTMQUwPoUmNoi+UmrbaaU6f0Sol2Fo5owxV
    fP6ujup85tHV/Pc8vQTaaRFS75A8V1ULPh93C+cGuuNpCUnhGsie6AagvqaXAghk
    nw8o1kMuz/LsOnbN940pw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gEO/VlYY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=L4sGzOj6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gEO/VlYY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=L4sGzOj6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932481AbeCMXV3 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 19:21:29 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35369 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753017AbeCMXVY (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 13 Mar 2018 19:21:24 -0400
X-Google-Smtp-Source: AG47ELuOLbQLQ3rbKzH0KuyG4c4/MNuNtJGbUgcfmcMj8Fucpdk0SvUfRwTeF/Y8ogfkUf2Zzafqcg==
Subject: Re: [PATCH v2 2/3] phy: phy-mtk-tphy: add configurable parameters for
 slew rate calibrate
To: Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org
References: <c9679bc6e969ebf0f97a01c6d1aff3bbc0e8e4f7.1520832210.git.chunfeng.yun@mediatek.com>
 <123d1a24659be168d0b040de4a67612acacf66f1.1520832210.git.chunfeng.yun@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <9abfde61-f81e-1a17-7ff9-85a7017f649b@gmail.com>
Date: Wed, 14 Mar 2018 00:21:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <123d1a24659be168d0b040de4a67612acacf66f1.1520832210.git.chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/12/2018 06:25 AM, Chunfeng Yun wrote:
> There are two parameters, ref_clk and coefficient, for U2 slew rate
> calibrate which may vary on different SoCs, here allow them to be
> configurable
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>


> ---
>  drivers/phy/mediatek/phy-mtk-tphy.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
> index 6073c25..38c281b 100644
> --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> @@ -306,6 +306,8 @@ struct mtk_tphy {
>  	const struct mtk_phy_pdata *pdata;
>  	struct mtk_phy_instance **phys;
>  	int nphys;
> +	int src_ref_clk; /* MHZ, reference clock for slew rate calibrate */
> +	int src_coef; /* coefficient for slew rate calibrate */
>  };
>  
>  static void hs_slew_rate_calibrate(struct mtk_tphy *tphy,
> @@ -360,16 +362,17 @@ static void hs_slew_rate_calibrate(struct mtk_tphy *tphy,
>  	writel(tmp, fmreg + U3P_U2FREQ_FMMONR1);
>  
>  	if (fm_out) {
> -		/* ( 1024 / FM_OUT ) x reference clock frequency x 0.028 */
> -		tmp = U3P_FM_DET_CYCLE_CNT * U3P_REF_CLK * U3P_SLEW_RATE_COEF;
> -		tmp /= fm_out;
> +		/* ( 1024 / FM_OUT ) x reference clock frequency x coef */
> +		tmp = tphy->src_ref_clk * tphy->src_coef;
> +		tmp = (tmp * U3P_FM_DET_CYCLE_CNT) / fm_out;
>  		calibration_val = DIV_ROUND_CLOSEST(tmp, U3P_SR_COEF_DIVISOR);
>  	} else {
>  		/* if FM detection fail, set default value */
>  		calibration_val = 4;
>  	}
> -	dev_dbg(tphy->dev, "phy:%d, fm_out:%d, calib:%d\n",
> -		instance->index, fm_out, calibration_val);
> +	dev_dbg(tphy->dev, "phy:%d, fm_out:%d, calib:%d (clk:%d, coef:%d)\n",
> +		instance->index, fm_out, calibration_val,
> +		tphy->src_ref_clk, tphy->src_coef);
>  
>  	/* set HS slew rate */
>  	tmp = readl(com + U3P_USBPHYACR5);
> @@ -1041,6 +1044,13 @@ static int mtk_tphy_probe(struct platform_device *pdev)
>  		tphy->u3phya_ref = NULL;
>  	}
>  
> +	tphy->src_ref_clk = U3P_REF_CLK;
> +	tphy->src_coef = U3P_SLEW_RATE_COEF;
> +	/* update parameters of slew rate calibrate if exist */
> +	device_property_read_u32(dev, "mediatek,src-ref-clk-mhz",
> +		&tphy->src_ref_clk);
> +	device_property_read_u32(dev, "mediatek,src-coef", &tphy->src_coef);
> +
>  	port = 0;
>  	for_each_child_of_node(np, child_np) {
>  		struct mtk_phy_instance *instance;
> 
