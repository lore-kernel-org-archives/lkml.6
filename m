Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3024051-1523602704-2-13878898408649645472
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523602703; b=RIhnsgyKUnC3VHTNpJ/dRdlAdONwj/Gv28HrjPVQNNOKlReg+a
    JTdVB0b5mYgH4wU+YU8mHXMHBhFkBRZHBzMzyFc8jC746GX/gHieH1mJXezF5lSs
    kFqFkhRQKpdx/aw3ceyiEmC3RhWOeDvzR81entML0U0ztXVxRYXLnJBvt8j7NR64
    Krh2de5zANGb19Fx15iC6oOfnQqaCPs+Fi9sxBWhBAJpFWLCzb0D2ps5CT09IF4C
    SSdet0VqWOeJjHX9WC1V07ENRLPp8vKvsdKuc17l8mg7hxP0s0J45WsQ+UFvLdlC
    4Z2oRuaWt2tFxJXTvx11ux/bP3yPa7Y2JHQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=fm2; t=1523602703; bh=a/nOBYn5U
    LPV254JhGIpYm+L//JZH7pk4+P7uOxpiJw=; b=WTlHjmphUgyICN/6Q66xOQBZK
    nSR5jrvg8/6EykmmCN2fURhyDhuLu61S3FEgWoB9j3E1lwnDQYGWC1kwAbQ/zvqj
    EFwe+CxgZLHRsXRlHabYODSVrfcGBWLs176paCkjftjhOb9UPXqGSBGsaawtpzq/
    6u1zPF0TQv+glgJNWWRlbZZT4WvQtPKwznAs05woriHmF5ylZGqOrZwVvjpKrhYo
    lJa4gIigTOAXHo/tVt82B/L/FoycIdzjwxdgWVWvdNIyW56Rn4Q33QGPlw0PbkWk
    gVKdV2e4duaay14/DDCWKMx8qhI+TGopaX+9qj9ncT57nhgicL/Pd93D5BNrw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=d9Yn860L;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=d9Yn860L;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBJVXL1hY6wVqC66P3SvAj1eJZS/wjh2g+bnbbd7Fc1LfTft5sZQFYqW4138+GMsG0OoglfTRoYsDRC20OGW8iyt9l1jBQbqXnUKMsANgeYBJSBSejMF
    Bi2sgvJ0L9KFDOfaYi4c5FGPkKn+CGLCZ4apxzJFYK4uRMGd+7r5lWvj9oiX93tENqA7CRoAnXlfgy/CLYcFCom2H9fRqytiBC6PDw+bHZS7E1ovYqK6+D21
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=0xD1uOI68rS6A9-mmcAA:9 a=CjuIK1q_8ugA:10
    a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750851AbeDMG6W (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 02:58:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54214 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeDMG6V (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Apr 2018 02:58:21 -0400
X-Google-Smtp-Source: AIpwx49YnEyzGf/aNaUXdP2sinVEj7Ni+Lyo8g3sFgUryEKVlw5CPhIH4xRHiFuNMfl+GRK4c80Wlg==
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v3] PCI / PM: Always check PME wakeup capability for
 runtime wakeup support
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180331164022.24220-1-kai.heng.feng@canonical.com>
Date: Fri, 13 Apr 2018 14:58:11 +0800
Cc: rafael.j.wysocki@intel.com, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <798A7C7A-A3DA-4C0E-A774-48042430EE1A@canonical.com>
References: <20180331164022.24220-1-kai.heng.feng@canonical.com>
To: bhelgaas@google.com
X-Mailer: Apple Mail (2.3445.6.18)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Bjorn and Rafael,

> On Apr 1, 2018, at 12:40 AM, Kai-Heng Feng <kai.heng.feng@canonical.com>  
> wrote:
>
> USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
> core: Drop run_wake flag from struct dev_pm_info").
>
> The device in question is not power managed by platform firmware,
> furthermore, it only supports PME# from D3cold:
> Capabilities: [78] Power Management version 3
>        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
>        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>
> Before commit de3ef1eb1cd0, the device never gets runtime suspended.
> After that commit, the device gets runtime suspended, so it does not
> respond to any PME#.
>
> usb_hcd_pci_probe() mandatorily calls device_wakeup_enable(), hence
> device_can_wakeup() in pci_dev_run_wake() always returns true.
>
> So pci_dev_run_wake() needs to check PME wakeup capability as its first
> condition.
>
> In addition, change wakeup flag passed to pci_target_state() from false
> to true, because we want to find the deepest state that the device can
> still generate PME#.
>
> Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct  
> dev_pm_info")
> Cc: stable@vger.kernel.org # 4.13+
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v3: State the reason why the wakeup flag gets changed.
>
> v2: Explicitly check dev->pme_support.

If this patch is good enough, I am hoping it can get merged in v4.17.

Kai-Heng

>
>  drivers/pci/pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f6a4dd10d9b0..52821a21fc07 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2125,16 +2125,16 @@ bool pci_dev_run_wake(struct pci_dev *dev)
>  {
>  	struct pci_bus *bus = dev->bus;
>
> -	if (device_can_wakeup(&dev->dev))
> -		return true;
> -
>  	if (!dev->pme_support)
>  		return false;
>
>  	/* PME-capable in principle, but not from the target power state */
> -	if (!pci_pme_capable(dev, pci_target_state(dev, false)))
> +	if (!pci_pme_capable(dev, pci_target_state(dev, true)))
>  		return false;
>
> +	if (device_can_wakeup(&dev->dev))
> +		return true;
> +
>  	while (bus->parent) {
>  		struct pci_dev *bridge = bus->self;
>
> -- 
> 2.15.1
