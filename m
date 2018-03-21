Return-Path: <rogerq@ti.com>
X-Google-Smtp-Source: AG47ELvXbvZX96mavr16cW0Pp6l3FSBT657cDdFXPuLcAonp8/MC8XRsDSo4hPvj2eW7oObPKV8n
ARC-Seal: i=1; a=rsa-sha256; t=1521635267; cv=none;
        d=google.com; s=arc-20160816;
        b=dllB7p5vx4ZT1EvnVulAyd1YNRe82Cl9X1E8RbImJToPdM/Pbe2U4EwE1pR8OlhrS7
         z6O6EY6F+N3WjNu+VANbVQ+NH/jHi518O4c9i6jFXXxFotFjZ0mJC8KrM+dNozNA54br
         qtfVVT3h8Yl7lchZo2zHsyQguqkE5aRk8MObORLin7TGe0aCLnEkLOH5xlVIpGkrdnxg
         yXM6mxEr7osLaC6w0VdsOtIgCGslQDaqlPfaCt8K2bk8vQDd+M0HzRyupcdpzXKh+/6N
         uUkG5AJIRZZwu2SZJ+PwxLVWsYjCEIoi+7uBZ6JjOjk3+kREYrOBXEyzvIpH5GsRlac8
         o/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=qo74DjqrhVX1oPkm6mUkP5bJMuy1sykVyDchTjLAh3c=;
        b=k7eyJYp4xQz/7fuRw1MwMrrK5QX7tAF5OeSz8OND03PfhO1Qg22JvD/JuHxg0HTn9J
         9NNvv1dnEmlJoiL3vHciHJeKje0Suc3xznvfsVCLvRVwS076ZwyYll+0D7Ux7KPnLDfo
         zMSxNJ8MhooDCxoXWUNdJnUO7BEaKqzUxAxuf6i+2ahw+tIayEXu87qV70R/YnyTaEka
         eY2UWHxkiJKR7tjGsTP34zBoBICiQz6Z8S1g3GP5E72SzRS8VXSIhUTn7L46A18eFBcy
         tcSkoDUhJJxto/my6WR1+eUKr1lJNxVybNXOLYHWMfnyY0yC8vd9jM5J4WmUKF8owRcB
         T9jQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=SUs09Lx2;
       spf=pass (google.com: domain of rogerq@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=rogerq@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=SUs09Lx2;
       spf=pass (google.com: domain of rogerq@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=rogerq@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [usb-next PATCH] usb: xhci: skip phys initialization of shared
 hcd
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
CC: Mathias Nyman <mathias.nyman@intel.com>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>,
        Matthias Brugger
	<matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
References: <1ece0d5508a00bca67d16e64310a071646b59c7d.1521612280.git.chunfeng.yun@mediatek.com>
 <ae71fdae-43aa-9df3-3f81-8a92460d61b9@ti.com>
 <1521633020.3717.128.camel@mhfsdcap03>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <99d5db89-0ba3-84df-5238-6edd6a3d99a1@ti.com>
Date: Wed, 21 Mar 2018 14:27:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521633020.3717.128.camel@mhfsdcap03>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595526733993033305?=
X-GMAIL-MSGID: =?utf-8?q?1595550222773259198?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21/03/18 13:50, Chunfeng Yun wrote:
> Hi Roger,
> 
> On Wed, 2018-03-21 at 11:05 +0200, Roger Quadros wrote:
>> Hi Chunfeng,
>>
>> On 21/03/18 08:12, Chunfeng Yun wrote:
>>> The phys has already been initialized when add primary hcd,
>>> including usb2 phys and usb3 phys also if exist, so needn't
>>> re-parse "phys" property again.
>>>
>>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>> ---
>>>  drivers/usb/host/xhci-mtk.c  | 1 +
>>>  drivers/usb/host/xhci-plat.c | 1 +
>>>  2 files changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
>>> index 7334da9..6bb23fb 100644
>>> --- a/drivers/usb/host/xhci-mtk.c
>>> +++ b/drivers/usb/host/xhci-mtk.c
>>> @@ -554,6 +554,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>>>  	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
>>>  		xhci->shared_hcd->can_do_streams = 1;
>>>  
>>> +	xhci->shared_hcd->skip_phy_initialization = 1;
>>>  	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
>>>  	if (ret)
>>>  		goto dealloc_usb2_hcd;
>>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
>>> index 6700e5e..65a4294 100644
>>> --- a/drivers/usb/host/xhci-plat.c
>>> +++ b/drivers/usb/host/xhci-plat.c
>>> @@ -294,6 +294,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
>>>  	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
>>>  		xhci->shared_hcd->can_do_streams = 1;
>>>  
>>> +	xhci->shared_hcd->skip_phy_initialization = 1;
>>
>> I think this is unnecessary.
>> There aren't separate PHYs for the primary and shared HCDs right?
> Yes, the primary and shared HCDs will get the same PHYs provided by
> "phys" property.
> 
>>
>> Also how can you be sure that phy_init() has been done for all platform HCD users?
> Here I assume that "phys" and "usb-phy" properties are not used at the
> same time. There are two cases:
> 1. Using "usb-phy": no "phys" to be got by shared HCD.
> 2. Using "phys": the primary HCD will get those phys, so shared HCD can
> skip them.

Now I see the problem.
But the right fix should be in core/hcd.c

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 2884607..1d1da12 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2757,7 +2757,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 		}
 	}
 
-	if (!hcd->skip_phy_initialization) {
+	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
 		hcd->phy_roothub = usb_phy_roothub_init(hcd->self.sysdev);
 		if (IS_ERR(hcd->phy_roothub)) {
 			retval = PTR_ERR(hcd->phy_roothub);

> 
>>
>>>  	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
>>>  	if (ret)
>>>  		goto dealloc_usb2_hcd;
>>>
>>
> 
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
