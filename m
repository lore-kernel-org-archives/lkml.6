Return-Path: <Minas.Harutyunyan@synopsys.com>
X-Google-Smtp-Source: AIpwx4+d+FW1Ufm7G+q8BtB39ZyX+A9bLPBttNkBGTdX5aIPUvBu4hQD7h4t7SNa8ESbbYwD4WnD
ARC-Seal: i=1; a=rsa-sha256; t=1522914896; cv=none;
        d=google.com; s=arc-20160816;
        b=a3SwKSYhVQ46UYcizBg8WFHwOuoSNYF6vlQvZhWGmpR9yngRzi112q150URCIguYSt
         fnM/77cBvU+kvt4gjMhZGCam7Ctr9NEY1zVOwDXEnLKW9xGBCKnMLU9+FuHjbbPuShrW
         wXv2XJ2z4gbJNQWZDf0vE4QINoHCyilA9UdCAbDIQO7Ilo3/F2/PJEVOObfzqxx+4l4t
         lyiqvcQKIC9ytgPY5/Sq9s7Rr4UsXwc4wUGW3uSUfBrTNv4crG2o66ykoAzVDi54PVMm
         OgeXyOaf0dd9Zy6RiZ5WqixTm0k7JZE0f9/8gmn9D6D/612mULvvF+wOGFofjFHxzUsL
         Enyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=OBkYXD6rmJmPPn7pElaeCWOxAg8G6PXfgGw8xb2KMaM=;
        b=tPmAz7WT4G6A+phYfikiCU9+oxGzl83OEQnZYs3r0lFNpwTqNXu4LltbFdqdJjETsz
         PWqXxm/TQI9hjSCbKQgT9zT3Kso31ioBiN1O2Qo+NvqZ7Q7nGEgYAfAilkslEq1UeB5I
         UrvdTw191P597rfhH1MSpO20FPhRY6aUI+3i0xP5pKpbWncKBNH8ZqGDSETGZfyJAF9W
         eXcjWpsNZOwIEeh/34TP7oveQPn7MGwP5rMbubeXYmt+wUAjNYVU9QpWsaaWe2FR//Cf
         /O0VzH7zMe+K+IpNYkb4KoPzHuaciAAYtGbCrizd88oisSjW/my2JTX4LhzdxHGFGqsc
         ojtA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of minas.harutyunyan@synopsys.com designates 198.182.47.9 as permitted sender) smtp.mailfrom=Minas.Harutyunyan@synopsys.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=synopsys.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of minas.harutyunyan@synopsys.com designates 198.182.47.9 as permitted sender) smtp.mailfrom=Minas.Harutyunyan@synopsys.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=synopsys.com
From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Felipe Balbi <felipe.balbi@linux.intel.com>, Heiko Stuebner
	<heiko@sntech.de>, Amelie Delaunay <amelie.delaunay@st.com>, "Minas
 Harutyunyan" <Minas.Harutyunyan@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
Subject: Re: [PATCH v4] usb: dwc2: dwc2_vbus_supply_init: fix error check
Thread-Topic: [PATCH v4] usb: dwc2: dwc2_vbus_supply_init: fix error check
Thread-Index: AQHTxOD8nEoVzOZ04EOGN7z3QZ1Kzw==
Date: Thu, 5 Apr 2018 07:54:51 +0000
Message-ID: <410670D7E743164D87FA6160E7907A560113AE527D@am04wembxb.internal.synopsys.com>
References: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
 <20180326090001.57627-1-tomeu.vizoso@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.63]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595630296773142922?=
X-GMAIL-MSGID: =?utf-8?q?1596892010398489763?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Tomeu,=0A=
=0A=
On 3/26/2018 1:01 PM, Tomeu Vizoso wrote:=0A=
> devm_regulator_get_optional returns -ENODEV if the regulator isn't=0A=
> there, so if that's the case we have to make sure not to leave -ENODEV=0A=
> in the regulator pointer.=0A=
> =0A=
> Also, make sure we return 0 in that case, but correctly propagate any=0A=
> other errors. Also propagate the error from _dwc2_hcd_start.=0A=
> =0A=
> Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external vbus =
supply")=0A=
> Cc: Amelie Delaunay <amelie.delaunay@st.com>=0A=
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>=0A=
> =0A=
> ---=0A=
> =0A=
> v2: Only overwrite the error in the pointer after checking it (Heiko=0A=
>      St=FCbner <heiko@sntech.de>)=0A=
> v3: Remove hunks that shouldn't be in this patch=0A=
> v4: Don't overwrite the error code before returning it (kbuild test=0A=
>      robot <lkp@intel.com>)=0A=
> ---=0A=
>   drivers/usb/dwc2/hcd.c | 13 ++++++++-----=0A=
>   1 file changed, 8 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c=0A=
> index 190f95964000..c51b73b3e048 100644=0A=
> --- a/drivers/usb/dwc2/hcd.c=0A=
> +++ b/drivers/usb/dwc2/hcd.c=0A=
> @@ -358,9 +358,14 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hso=
tg)=0A=
>   =0A=
>   static int dwc2_vbus_supply_init(struct dwc2_hsotg *hsotg)=0A=
>   {=0A=
> +	int ret;=0A=
> +=0A=
>   	hsotg->vbus_supply =3D devm_regulator_get_optional(hsotg->dev, "vbus")=
;=0A=
> -	if (IS_ERR(hsotg->vbus_supply))=0A=
> -		return 0;=0A=
> +	if (IS_ERR(hsotg->vbus_supply)) {=0A=
> +		ret =3D PTR_ERR(hsotg->vbus_supply);=0A=
> +		hsotg->vbus_supply =3D NULL;=0A=
> +		return ret =3D=3D -ENODEV ? 0 : ret;=0A=
> +	}=0A=
>   =0A=
>   	return regulator_enable(hsotg->vbus_supply);=0A=
>   }=0A=
> @@ -4342,9 +4347,7 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)=0A=
>   =0A=
>   	spin_unlock_irqrestore(&hsotg->lock, flags);=0A=
>   =0A=
> -	dwc2_vbus_supply_init(hsotg);=0A=
> -=0A=
> -	return 0;=0A=
> +	return dwc2_vbus_supply_init(hsotg);=0A=
>   }=0A=
>   =0A=
>   /*=0A=
> =0A=
=0A=
Not able to apply patch. Please rebase to balbi/next=0A=
=0A=
Thanks,=0A=
Minas=0A=
=0A=
