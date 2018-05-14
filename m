Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-460432-1526287179-2-7592856424967518736
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526287179; b=TKlQwyGUsEzr2sJ1qMm4OQHPq5msst5OXBfFAOaj3H7P6QfMTm
    Hur9hTW7fcPUZe+8CzgBvmbKA5s/11NtaPrrc+7gP3IxMGhZQms8HeCArg40zOSQ
    mU/dyfCdvVTmLsqkD2SxR/JQr/x4NXJUuUA9Vfpb3WgGZSAeelropXH/AZrH8raV
    PVtwrzAsKoZWHvsXD1SrW1c3DLsvarnGVzZ40Mp4opoxk7ESfSt4Cq+9gMGgPmE3
    D5trcLEMwr5I6QE8lQidHuvckhBWWCo/A+r5GHnjIOwvUw3yT+5U18a9PvNMXLGV
    i1bdbiCygmLdkxL3Hw/SaD3sWZqfxXDQ8XSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-transfer-encoding:content-type
    :references:sender:list-id; s=fm2; t=1526287179; bh=xpovO3AqFnwz
    L9h64M0Ke66zrDw3ucFPsIBm7sXhFaw=; b=NRWR7ow56+Z4p1HntTQYomWPEyav
    VnSteVkerNlLMzP2EwafvVO02iN2tle8pEF4fbUta0E9a7u8FP+afirLd7D39ixT
    ds2rGdjokcKuBkyNJnTdQQZtH6rp8dk9ae5zIMPYm9xSIGwq8mejZO1fUZbDbu9X
    xt7S5aA0uiawm/6NlpsxTtbWwZcQt8ylps471wQ85S9yv6T9dPhlos3OwyjRQaAD
    0NsxeJ1K6/CmCmfKF34ron4m2kCEgQy39+6Vy0thR79GkBspUbFAkcxLrzGkQc6N
    dwkZvtB31HVs5PZO/cYW+xf6nY/9oiXkM1YhUckwrgmuZvxLNDFbU62m5g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=samsung.com header.i=@samsung.com header.b=kiu69aXI
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=samsung.com header.i=@samsung.com header.b=kiu69aXI
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOBHKFTWTXzi7QXng6Ru3NwCYbMsc0N8ts9/eyu7Gu4Pst/DhZUD3p3tKvgutVZjISIwfxhBhyjXxgJMiCS5vSSJmVhJ5/hevhe2xdiHxac15LA7CNGd
    Vh/JVOZnfH3nS7SnoPbraUveug1G4iC4r2WNBICtlJ/jwVBQDH3NnuVcD4VC3euFvNnBOw9iBUbnJQYiSFpbtUxBqQ70uuyDhRCqdhjY/92PftO+wUm3T6/4
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=AeaHy0ZplXfnLad-K1cA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeENIjJ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 04:39:09 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51832 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbeENIjH (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 14 May 2018 04:39:07 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180514083905euoutp02264ed80680761b396a8d02300208e653~udhJkKL9z0649306493euoutp02M
X-AuditID: cbfec7f2-5ffe19c000011644-9a-5af94b25da8f
Subject: Re: [PATCH 1/2] USB: dwc3: get extcon device by OF graph bindings
To: "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <1080506a-adaa-193b-24d5-a779486dacc8@samsung.com>
Date: Mon, 14 May 2018 10:38:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180131155718.5237-2-a.hajda@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0iTcRTtt+/pbPq5WV4faS2MnpYR8kEmEgUzjaIIYlA269OkOW3LR0UR
        +R4kpkXbtAwf+WixNHv4SvJJSk7N0iQzS1IjpXxEK7PcPiP/O/fce88958ePxsTdhBsdqTrD
        qVUKpZQU4o9aLOZN3sEW+ZYrAxvYcp2JYFtShim2d3qEYPOaOgg2scBEslmDmThrNt+n2PSr
        hRT7sjqXZHXmpwI2/04yxt5rGqDYot4uAZtc10QFOsiMt4xIlpOmJ2QVZemkrP6mkZJlVJYh
        2VSF535SLvQ/wSkj4zj15oBjwpPlnXMo5ptrwjVLO3UJ9TlrkR0NzDbIqSjCtEhIi5kSBJa8
        JIIvphEkTc5RfDGFoPTdFK5FtG2lfySa54sRlHxvWxgaRzCb0odbdSXMHkgvnKWs2JkJgt6P
        EzZZjOnAYfb9kK1BMuvg94M3pFVVxASAvl1ipXHGG8xDesKKlzGH4fKIxTYuYpzguX7Ypm/H
        sJBb+0xgxRjjBY/HczEeu0D/cJ7AegsYCwVjulKKD7oLPnTrSB5L4HNr5QLvAX+q8gQ8Pg9v
        Ri/j/HIagsFfqQsL26GxtYuwGsXmTZuqN/P0DqicGxfwr+IAfeNOvAcHyHp0A+NpEaSliPnp
        VTD44iHGYxco6pwhM9Fqw6JkhkVpDIvSGP7fvY3wMuTCxWqiIjiNr4qL99EoojSxqgif49FR
        FWj+p7XPtU4+QTPdYQ2IoZF0qWiJ8YdcTCjiNGejGhDQmNRZVLPVIheLTijOnuPU0aHqWCWn
        aUDuNC51ER1de1EuZiIUZ7hTHBfDqf91BbSd2yUU2TP9IUGZfbrmgM9ue4/isesTmbXacPKI
        o/atKbHtkFujfVWw/sv7Zc312pVffPYFfvrae8zdN6dhz7rZ9aq0ENfGu/mhr1/tHQ3P6A9a
        PjA1UBCWWlk39jPbt6ZPcmGnqbbHcY27X/pY3ERCjLm7S3awucrot9GrJYSOr1ohD/D3lOKa
        kwrf9Zhao/gL33oTlWUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xe7rK3j+jDBbvUbPYOGM9q8Wxtifs
        Fte/PGe1mH/kHKtF8+L1bBaT7k9gsTh/fgO7RefEJewWl3fNYbOYcX4fk8WiZa3MFmuP3GW3
        WHr9IpNF694j7A58HmvmrWH0mN0xk9Vj06pONo/9c9ewe/RtWcXo8XmTXABblJ5NUX5pSapC
        Rn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gxgv/GAs+SlZM+Xma
        vYHxhkgXIweHhICJxK3n+V2MXBxCAksZJTq+vmDtYuQEiotL7J7/lhnCFpb4c62LDaLoNaPE
        /ZadTCAJYQEvic4lf9hBbBEBT4nrj9+xghQxC1xgkfj38Ro7RMdORoktP66zgVSxCWhK/N18
        kw1kNa+AncTM08IgYRYBVYnzD2eCbRYViJC4d/4TWDmvgKDEyZlPWEBsTgELiTl7DoItZhZQ
        l/gz7xIzhC0vsf3tHChbXOLWk/lMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy021CtO
        zC0uzUvXS87P3cQIjOJtx35u3sF4aWPwIUYBDkYlHt4VK39ECbEmlhVX5h5ilOBgVhLh3W30
        M0qINyWxsiq1KD++qDQntfgQoynQcxOZpUST84EJJq8k3tDU0NzC0tDc2NzYzEJJnPe8QWWU
        kEB6YklqdmpqQWoRTB8TB6dUA6OewnF5kSbTpUz75d9cuTvj2R4de+WrO/tXLmBfHcpTmOlh
        NO9cpstc51Tn7V27pD+6hE+8ufkYu7WPq+7KLrPgj2veGWRtmnA08XmZTGbhjwgu2S72W8tk
        8pdqz3qz7+r5zU0e5t2X9hvPUry8/taHxZXvIitO3U6R1/hYO13X77zPx/8yfbeVWIozEg21
        mIuKEwGfh11u+AIAAA==
X-CMS-MailID: 20180514083900eucas1p153e0fd426d99f8388e4664224440bc3b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180514083900eucas1p153e0fd426d99f8388e4664224440bc3b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180131155734eucas1p2b55ad1aab1d5086566dad7a79b25ccf3
X-RootMTR: 20180131155734eucas1p2b55ad1aab1d5086566dad7a79b25ccf3
References: <20180131155718.5237-1-a.hajda@samsung.com>
        <CGME20180131155734eucas1p2b55ad1aab1d5086566dad7a79b25ccf3@eucas1p2.samsung.com>
        <20180131155718.5237-2-a.hajda@samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 31.01.2018 16:57, Andrzej Hajda wrote:
> extcon device is used to detect host/device connection. Since extcon
> OF property is deprecated, alternative method should be added.
> This method uses OF graph bindings to locate extcon.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>

Ping, 3.5 months passed.

Regards
Andrzej

> ---
> Hi all,
>
> This patch implements alternative method to get extcon from DWC3.
> The code works but is hacky, as DWC3 must traverse different DT nodes
> to get extcon, in case of TM2 it is USB-PHY and MUIC, but other
> platforms can have different paths.
> I would be glad if it can be merged as is for now, but additional work
> must be done to make it generic.
> I guess on DT binding side it is OK. So the problem should be addressed
> in the code.
> My rough idea is to implement kind of extcon aliases/forwarder mechanism,
> ie. USB-PHY will expect on its output remote port extcon, and it should register
> extcon-forwarder pointing to this extcon. This way DWC3 can look for the extcon
> on its PHY phandle, and it will receive via forwarding mechanism extcon
> exposed by MUIC.
> As I said this is rough idea for discussion, other propositions are welcome.
>
> Regards
> Andrzej
> ---
>  drivers/usb/dwc3/drd.c | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index cc8ab9a8e9d2..eee2eca3d513 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/extcon.h>
> +#include <linux/of_graph.h>
>  
>  #include "debug.h"
>  #include "core.h"
> @@ -38,24 +39,38 @@ static int dwc3_drd_notifier(struct notifier_block *nb,
>  	return NOTIFY_DONE;
>  }
>  
> +struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
> +{
> +	struct device *dev = dwc->dev;
> +	struct device_node *np_phy, *np_conn;
> +	struct extcon_dev *edev;
> +
> +	if (of_property_read_bool(dev->of_node, "extcon"))
> +		return extcon_get_edev_by_phandle(dwc->dev, 0);
> +
> +	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
> +	np_conn = of_graph_get_remote_node(np_phy, -1, -1);
> +	edev = extcon_get_edev_by_of_node(np_conn);
> +	of_node_put(np_conn);
> +	of_node_put(np_phy);
> +
> +	return edev;
> +}
> +
>  int dwc3_drd_init(struct dwc3 *dwc)
>  {
>  	int ret;
>  
> -	if (dwc->dev->of_node) {
> -		if (of_property_read_bool(dwc->dev->of_node, "extcon"))
> -			dwc->edev = extcon_get_edev_by_phandle(dwc->dev, 0);
> -
> -		if (IS_ERR(dwc->edev))
> -			return PTR_ERR(dwc->edev);
> +	dwc->edev = dwc3_get_extcon(dwc);
> +	if (IS_ERR(dwc->edev))
> +		return PTR_ERR(dwc->edev);
>  
> -		dwc->edev_nb.notifier_call = dwc3_drd_notifier;
> -		ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
> -					       &dwc->edev_nb);
> -		if (ret < 0) {
> -			dev_err(dwc->dev, "couldn't register cable notifier\n");
> -			return ret;
> -		}
> +	dwc->edev_nb.notifier_call = dwc3_drd_notifier;
> +	ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
> +				       &dwc->edev_nb);
> +	if (ret < 0) {
> +		dev_err(dwc->dev, "couldn't register cable notifier\n");
> +		return ret;
>  	}
>  
>  	dwc3_drd_update(dwc);


