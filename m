Return-Path: <chunfeng.yun@mediatek.com>
X-Google-Smtp-Source: AB8JxZoGZYAsiMYdaAZL/Phv73MqRmxvLyiO0KgFtJfpZdT4AHLI7VRvKma8x1f4wkFfhxfxtkFg
ARC-Seal: i=1; a=rsa-sha256; t=1525918651; cv=none;
        d=google.com; s=arc-20160816;
        b=YGWgil4NVJRWyrqf39cu9Bi38iXdr/g2PjWZK7P4pQ72oh8Xs+SxFAWzlM8p3oJWtG
         9IPE17V8I0VMxizV6cYSnvN3dGvI+lgpUQPDm1RKNLfIpxlRtt8hvBnqRmfP2s0yjDue
         hRYGlzc+bFxsHOYKDXVoXSwueeq9lBnaT9miPaME1Coq45psHaoU6UgjWJBpNIPdO3kK
         r2nZ53XqE5LqqyvQuwn1Xuikj3wjhKmKfOnyrExtN2opLBr5t3WEuDcih49JumucUUKh
         YvelzqFhm7nm15Q/AjKiNWRDZRJKKZriLighN1MRiJ6YrDrXb2GnCX58gviZAtJF4uRm
         sIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=ONAVNfQ0fMaXkSsjOCvFdQYC7Wh91WXZjOL2oreSeNI=;
        b=PyxW+a3IUNhx5wx/mxtndlYUn4s8Zr986PU8qW4PMq4KGo9mce5aGVZmy/jN6+g83T
         fhQgWbBdr6UyZgi6M00C8Jm6gnIGn1z2FTQ8IBlR+DeuIZoXDJZQKpaNtBnQdNqOSVdK
         O+3Fxgxwxj33IbzOtmfAdLQdNKUy0AaVpGAxWWicWWf+ppbhnKrqHJkVB/1We49ZXCOa
         7AVY1MPkmMa4ps8ZorrKpYp2f86oysk6hdPWEDrfXKGrTWjVgrCyPWkPfFF6vMw5Iaay
         FZcSzlyrFrBcdU9uAEq8VVyLZn1c8NKx0gQzzRQ1L6ajGtHP1rCqgfYCahGQv1eBAZM8
         tl4g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.78 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.78 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
X-UUID: cea30eb580c84613bb6f622c5dbbdb76-20180510
Message-ID: <1525918606.32173.9.camel@mhfsdcap03>
Subject: Re: [RESEND PATCH 1/5] usb: mtu3: avoid TX data length truncated in
 SS/SSP mode
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Felipe Balbi <felipe.balbi@linux.intel.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, <linux-usb@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Date: Thu, 10 May 2018 10:16:46 +0800
In-Reply-To: <3b0c7ca576fee8220d63c9914483b70b0fbc8783.1525486663.git.chunfeng.yun@mediatek.com>
References: <3b0c7ca576fee8220d63c9914483b70b0fbc8783.1525486663.git.chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599588978733393138?=
X-GMAIL-MSGID: =?utf-8?q?1600041676025495719?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi, Greg

   Could you please pick up the series of patches, thanks a lot
 
On Sat, 2018-05-05 at 10:21 +0800, Chunfeng Yun wrote:
> The variable of 'count' is declared as u8, this will cause an issue
> due to value truncated when works in SS or SSP mode and data length
> is greater than 255, so change it as u32.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/mtu3/mtu3_gadget_ep0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
> index ebdcf7a..d67b540 100644
> --- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
> +++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
> @@ -546,7 +546,7 @@ static void ep0_tx_state(struct mtu3 *mtu)
>  	struct usb_request *req;
>  	u32 csr;
>  	u8 *src;
> -	u8 count;
> +	u32 count;
>  	u32 maxp;
>  
>  	dev_dbg(mtu->dev, "%s\n", __func__);
