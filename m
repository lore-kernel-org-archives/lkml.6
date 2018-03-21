Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3734533-1521628679-2-9289105116044238505
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521628678; b=asfSQaUOpqobS4fa6wwUomUwgb0WcftK2dbW44UBmAuPEOz
    xtn8IFKYfZxXN4kqAyBCYh43jJzwkQgFaRZV1QZt223DWYrYtgNf+bDvy/fgB1gx
    DWK3YVLBLrutvgrOdJN/FBzlvu/o6o8n1jattlLzDp/SLbb4O79CvagxTyU9bM23
    4gq7oTG0PAmmocCM2/qNNb+JtASGSDH+uJzmHpiLDc2yxpAtkDrLiLXCkvTXQuxH
    yeqWD3fzu/+VLkWwDXpNPKETqanHcIZc6SueTkm+BzUDr0peWs3vSVwnGO89e+up
    QyZhxG/ixi97s9qQmvEjmlE+4t9HKlHhW4IoL5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521628678; bh=AwTQGh9bml75uspzCAp43t9uZzwfCIdgT3DPwQjIoTQ=; b=e
    7NbQzBVbAUwzzt2JUPQ5W0unoYkwYvQr2QAB+BscPFgYSp7/VjvCJ07neMp7KovK
    Rj0m0x6Qi7b/BlcVQV/vphbwndmcrHbhsWeo5mdYxvyfQz0Fp0vSoJelaBLOdBjp
    YPGPx3JnymdX4Q5CuaH1LqoT67m0Yk/6WkDaOAJ+IbdPKajzRhPR3+pHOcCwAc4v
    m8GFXHxdOEtTULn5Wf+kEjc9Lk7F3LPMQBBXgE7oaJJJuZ1fR9xV0ide9zlm/SvE
    iG2n87Pv9aoWnRRNVIFWRwxCJOlaBpwQl41P2a/JubLDbNwllkc/3XxCzVC37RC8
    1oECA8NM4fkMPcLG3PKbg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=eH8eHJAl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=eH8eHJAl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeCUKhz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 06:37:55 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:17593 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeCUKhy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 06:37:54 -0400
Subject: Re: [PATCH 3.18 22/68] ARM: DRA7: hwmod_data: Prevent
 wait_target_disable error for usb_otg_ss
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180319171827.899658615@linuxfoundation.org>
 <20180319171830.959470467@linuxfoundation.org>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <15d675de-3e93-07cf-4c7d-aa700e38b4bb@ti.com>
Date: Wed, 21 Mar 2018 12:37:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319171830.959470467@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On 19/03/18 20:06, Greg Kroah-Hartman wrote:
> 3.18-stable review patch.  If anyone has any objections, please let me know.
> 

Please drop this from 3.18-stable as well. Thanks.


> ------------------
> 
> From: Roger Quadros <rogerq@ti.com>
> 
> 
> [ Upstream commit e2d54fe76997301b49311bde7ba8ef52b47896f9 ]
> 
> It seems that if L3_INIT clkdomain is kept in HW_AUTO while usb_otg_ss
> is in use then there are random chances that the usb_otg_ss module
> will fail to completely idle. i.e. IDLEST = 0x2 instead of 0x3.
> 
> Preventing L3_INIT from HW_AUTO while usb_otg_ss module is in use
> fixes this issue.
> 
> We don't know yet if usb_otg_ss instances 3 and 4 are affected by this
> issue or not so don't add this flag for those instances.
> 
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -2106,6 +2106,7 @@ static struct omap_hwmod dra7xx_usb_otg_
>  	.class		= &dra7xx_usb_otg_ss_hwmod_class,
>  	.clkdm_name	= "l3init_clkdm",
>  	.main_clk	= "dpll_core_h13x2_ck",
> +	.flags		= HWMOD_CLKDM_NOAUTO,
>  	.prcm = {
>  		.omap4 = {
>  			.clkctrl_offs = DRA7XX_CM_L3INIT_USB_OTG_SS1_CLKCTRL_OFFSET,
> @@ -2127,6 +2128,7 @@ static struct omap_hwmod dra7xx_usb_otg_
>  	.class		= &dra7xx_usb_otg_ss_hwmod_class,
>  	.clkdm_name	= "l3init_clkdm",
>  	.main_clk	= "dpll_core_h13x2_ck",
> +	.flags		= HWMOD_CLKDM_NOAUTO,
>  	.prcm = {
>  		.omap4 = {
>  			.clkctrl_offs = DRA7XX_CM_L3INIT_USB_OTG_SS2_CLKCTRL_OFFSET,
> 
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
