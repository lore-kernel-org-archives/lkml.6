Return-Path: <rogerq@ti.com>
X-Google-Smtp-Source: AG47ELuS5Gmny1C9ayClplAnX50G1tCUhs3a7Z41foXTwWESCZfX4GAW4Rg3A4gt1TKViSVswy6N
ARC-Seal: i=1; a=rsa-sha256; t=1521721785; cv=none;
        d=google.com; s=arc-20160816;
        b=RDXYTdX+Ij/jLWfOOFCWhQxZ7LWMlPALjJd8C4ns2dfiXXMx4bhIt6ACDDap5Wblxc
         wqmyd0NRDAvlJJS9FLnfZYqcv98jOo1t4YTex+fETr43BnZ5RfYfFn0ZyXZiWxZ3y8Ma
         yQjxgJDYon3B7/hNzSXOLxRCrkg266/XSkJkj9KEzPnDzhw0LTvMweWVBEH5Im1oZC54
         IhoQeYl94gDE+dptYMRnmQ4Ib8YaVa2a0kHq8atNGP8yP/PxAgFUb5iAIuYgOpqkUxjX
         URjHdHUshW8BF0UbhgHRf+J+v1618+eQ5KkjfFCiq7yuZkUcrBxGwOr/KoVX43fvx1lV
         CiaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=SLHNaAdZthLRE3Zi7SJvv60Vm4a4pJFlxn9ffPTybus=;
        b=iUmU4+cjaKTLthYdyC2+CW+tFUnvdUPrqXBB7IJrQovbiq2sYnCp539MW4aPzkzh3u
         oG5SQQiZOp1ii0NNSWehuvpkDL+KHSWHNufDg4UB77JvQ7kZ9kKwLGCkv6VOzsCvDTJy
         Ss7k+fYMk7N6G4afctah4j1RNmNrD3C5ZELlOgILdfQU4Fb6dy1Gn6dL5U/r3Ec5k2B/
         S8FnJcVoAzQEdh6O/xv39NExLcgYHPlrazzi0rW3zvDwJFrFZU3yYzqZ7dbKzIO+Zhxd
         N7hELupIXm8k95BfAj8ipNz6DTHCcBkY0ZwzRNBv6Xo6HYfp8e7xPQ/uofDvYCH/Vbde
         CBmw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Z9HAiD+V;
       spf=pass (google.com: domain of rogerq@ti.com designates 198.47.19.17 as permitted sender) smtp.mailfrom=rogerq@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Z9HAiD+V;
       spf=pass (google.com: domain of rogerq@ti.com designates 198.47.19.17 as permitted sender) smtp.mailfrom=rogerq@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [usb-next, v3 PATCH] usb: xhci: skip phys initialization of
 shared hcd
To: Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger
	<matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
References: <643701fef843f91931e3a68779afe053c63c96f6.1521707846.git.chunfeng.yun@mediatek.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <e3560874-cf8b-a554-5226-bc640b0edcb1@ti.com>
Date: Thu, 22 Mar 2018 14:29:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <643701fef843f91931e3a68779afe053c63c96f6.1521707846.git.chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595526733993033305?=
X-GMAIL-MSGID: =?utf-8?q?1595640943206868602?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22/03/18 14:12, Chunfeng Yun wrote:
> The phys has already been initialized when add primary hcd,
> including usb2 phys and usb3 phys also if exist, so needn't
> re-parse "phys" property again.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: Roger Quadros <rogerq@ti.com>

> ---
> V3:
>     add the following info about v1 & v2 suggested by Greg
> V2:
>     fix it in hcd.c suggested by Roger
> V1:
>     skip phys initialization when add shared HCD by setting
>     xhci->shared_hcd->skip_phy_initialization=1;
>     for both xhci-plat.c & xhci-mtk.c files.
> ---
>  drivers/usb/core/hcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 5a92d8f..777036a 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2757,7 +2757,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  		}
>  	}
>  
> -	if (!hcd->skip_phy_initialization) {
> +	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
>  		hcd->phy_roothub = usb_phy_roothub_init(hcd->self.sysdev);
>  		if (IS_ERR(hcd->phy_roothub)) {
>  			retval = PTR_ERR(hcd->phy_roothub);
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
