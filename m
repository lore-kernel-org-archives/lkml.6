Return-Path: <tomeu.vizoso@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524489865; cv=none;
        d=google.com; s=arc-20160816;
        b=e9cnZ8r4C0zV4RPsSoXT1/Yxqfl5pmmQ4k/5x0PX5fU/3bUxvx9ixaayMPH3F9cygd
         q9tgV6LUpV0x2g/DdjJjoDVdu5vboo28gL8Lissclb9xSqzBtY9U81o++18WB/lPUH0S
         F5SuZndHsUQVYxIZwF9AofWPX8pYFvBlKwPcxLcKF0e+jvIPZ7r9vb/69dQJZSCKL3fY
         Wsy9rU2mBEo2l4nthKtNblR4TLZvWZQRPlyiBSnGwCniy9pZvQDQWLIYuelcmZXNFDjz
         LC6aM/oib/aFH3dw5yPNEP502PLRMm1s0ZS8IxeDTpnF05gvqpRRAC5eLBTDRi421PF7
         WwEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:sender:mime-version:dkim-signature
         :arc-authentication-results;
        bh=VfidN0Xc9RRWDY2tasEc71IzkHV4Wn3lI+63khsFB+w=;
        b=XOq7yOIJbi6LwZgWdFiedOI7J5rBP82Vt09HjgaDKv1RHqJN3apUl0FhPqiseDCazB
         h77uph8WTzHqME1hN6adUrF9aiZ6riNsjzCSgQKZWRBUDXyTK4pTyaheUw+m2sAty/Jd
         iuUp9iOc6mW88RnXNRMMIGfwAtDlNUbmfWLkhsVy2PYVZ39Re5tNLt/5lAPcgI0jUdyc
         cpc7th6ArpZMZJqxzTPTBVaMBovzUwfQexUgwF+fBm4NzfFH327tzKCc8v9LoCh/fkDT
         GidubUiw4Y7jchwDT4yHeUDSG8x6CvliFCDBHKWNT0dHs8aOEPzknPYcl9PmI8M0M6Ib
         a7ZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bw6T9i4u;
       spf=pass (google.com: domain of tomeu.vizoso@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=tomeu.vizoso@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=collabora.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bw6T9i4u;
       spf=pass (google.com: domain of tomeu.vizoso@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=tomeu.vizoso@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=collabora.com
X-Google-Smtp-Source: AB8JxZoMbWnDPoTy+8yxDoxE2wt43YC8di0M+tRYthrs3X2XZr0eoF8bocwUXUrLWmtI/VCrr3UUPkU23HFs/bctY80=
MIME-Version: 1.0
Sender: tomeu.vizoso@gmail.com
In-Reply-To: <410670D7E743164D87FA6160E7907A560113AE831F@am04wembxb.internal.synopsys.com>
References: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
 <4613360.AXT7q7Ng0i@phil> <410670D7E743164D87FA6160E7907A560113AE7E5C@am04wembxb.internal.synopsys.com>
 <41174786.HiOuqceMIB@diego> <410670D7E743164D87FA6160E7907A560113AE831F@am04wembxb.internal.synopsys.com>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Mon, 23 Apr 2018 15:24:04 +0200
X-Google-Sender-Auth: fFydHwOIFuBR39IELXpQUA29gxI
Message-ID: <CAAObsKC3BiojwOhHoDe1-NJ-p135GZmpLGpTBRKP3-9ryuY2uA@mail.gmail.com>
Subject: Re: [PATCH v4] usb: dwc2: dwc2_vbus_supply_init: fix error check
To: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Felipe Balbi <felipe.balbi@linux.intel.com>,
	Amelie Delaunay <amelie.delaunay@st.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595630296773142922?=
X-GMAIL-MSGID: =?utf-8?q?1598543485316810929?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

could this patch be picked up, please? Or if for some reason it cannot
be, could the commit that introduced the regression be reverted?

It's causing some tests in KernelCI to fail:

https://storage.kernelci.org/next/master/next-20180423/arm/multi_v7_defconf=
ig/lab-collabora/sleep-rk3288-veyron-jaq.html

Thanks,

Tomeu


On 11 April 2018 at 08:50, Minas Harutyunyan
<Minas.Harutyunyan@synopsys.com> wrote:
> Hi Heiko,
>
> On 4/10/2018 7:37 PM, Heiko St=C3=BCbner wrote:
>> Am Dienstag, 10. April 2018, 15:52:25 CEST schrieb Minas Harutyunyan:
>>> Hi Heiko,
>>>
>>> On 4/10/2018 4:28 PM, Heiko Stuebner wrote:
>>>> Am Montag, 26. M=C3=A4rz 2018, 11:00:01 CEST schrieb Tomeu Vizoso:
>>>>> devm_regulator_get_optional returns -ENODEV if the regulator isn't
>>>>> there, so if that's the case we have to make sure not to leave -ENODE=
V
>>>>> in the regulator pointer.
>>>>>
>>>>> Also, make sure we return 0 in that case, but correctly propagate any
>>>>> other errors. Also propagate the error from _dwc2_hcd_start.
>>>>>
>>>>> Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external v=
bus
>>>>> supply") Cc: Amelie Delaunay <amelie.delaunay@st.com>
>>>>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>>>
>>>> The patch that gets fixed here also breaks display-output on dwc2-base=
d
>>>> Rockchip devices (likely even more), probably due to making the regula=
tor
>>>> framework hickup.
>>>
>>> Could you please elaborate what mean "breaks display-output".
>>> On which Kernel version you apply this patch?
>>
>> I think I may have written that poorly. _Without_ this patch I get
>> display breakage on the most recent torvalds/master (merge-window)
>> where "usb: dwc2: add support for host mode external vbus supply" is
>> applied and this patch fixes the issue.
>>
>> "breaks display output" means both hdmi + edp output are missing
>> also including the backlight staying off.
>>
>> The patch we're fixing here, causes a null-pointer dereference in the
>> regulator framework, which seems to also cause issues when other
>> regulators are enabled, which I think is what I'm seeing here.
>>
>>
> Thank you for clarification. Earlier you added "reviewed" tag, this
> feedback can assumed as "tested" tag.
>
> Thanks,
> Minas
>
>> Heiko
>>
>>>
>>> Thanks,
>>> Minas
>>>
>>>> With this patch applied, apart from not seeing the NULL-ptr, I also ge=
t
>>>> display output on my rk3288-veycron Chromebook again, so
>>>>
>>>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>>>>
>>>>> v2: Only overwrite the error in the pointer after checking it (Heiko
>>>>>
>>>>>       St=C3=BCbner <heiko@sntech.de>)
>>>>>
>>>>> v3: Remove hunks that shouldn't be in this patch
>>>>> v4: Don't overwrite the error code before returning it (kbuild test
>>>>>
>>>>>       robot <lkp@intel.com>)
>>>>>
>>>>> ---
>>>>>
>>>>>    drivers/usb/dwc2/hcd.c | 13 ++++++++-----
>>>>>    1 file changed, 8 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
>>>>> index 190f95964000..c51b73b3e048 100644
>>>>> --- a/drivers/usb/dwc2/hcd.c
>>>>> +++ b/drivers/usb/dwc2/hcd.c
>>>>> @@ -358,9 +358,14 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg
>>>>> *hsotg)>>
>>>>>    static int dwc2_vbus_supply_init(struct dwc2_hsotg *hsotg)
>>>>>    {
>>>>>
>>>>> +  int ret;
>>>>> +
>>>>>
>>>>>            hsotg->vbus_supply =3D devm_regulator_get_optional(hsotg->=
dev, "vbus");
>>>>>
>>>>> -  if (IS_ERR(hsotg->vbus_supply))
>>>>> -          return 0;
>>>>> +  if (IS_ERR(hsotg->vbus_supply)) {
>>>>> +          ret =3D PTR_ERR(hsotg->vbus_supply);
>>>>> +          hsotg->vbus_supply =3D NULL;
>>>>> +          return ret =3D=3D -ENODEV ? 0 : ret;
>>>>> +  }
>>>>>
>>>>>            return regulator_enable(hsotg->vbus_supply);
>>>>>
>>>>>    }
>>>>>
>>>>> @@ -4342,9 +4347,7 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
>>>>>
>>>>>            spin_unlock_irqrestore(&hsotg->lock, flags);
>>>>>
>>>>> -  dwc2_vbus_supply_init(hsotg);
>>>>> -
>>>>> -  return 0;
>>>>> +  return dwc2_vbus_supply_init(hsotg);
>>>>>
>>>>>    }
>>>>>
>>>>>    /*
>>
>>
>>
>
