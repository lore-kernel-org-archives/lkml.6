Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-949627-1522615718-2-15181304034173411492
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522615717; b=U6iejH8Hv2v6t9RKFaMhHXvhnogxVAI74yKuHy2sw5vMjXTboU
    27R2wQtK8HVQOSaR6I0xueM2NfyhZGeUj6rw+SEnQeLvEn/y0nRrmTWIW0pBjth5
    /qVrtimjM0G1dw07EJAzgqE2qCz4UuwmecuuWIu+Fg8WZTS8ky3H7kfkoCcMR39H
    j5vZWuPODSymMQIFbrWGVQEwXPZitC69+AN98v6BkIxGVtFUIAHU/jR4O4a1+2VJ
    ane7dXX0CFTZBRsmi5YuMlSUatZc8wtsmyWB+IPIW8pAbNfGwynEQ52qZ8yNHBFU
    zmS8IYPpoDG3HyEzc6A1NP9uKhP22GUlfb0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522615717;
    bh=Dlg6w7R2FPsFqmT1I9xYueLd/vwtHMdOMf0D6ocNhqw=; b=Bp6kdhBzOTzo
    IeXRdduRjBWRCihQ5UZXKsiZfRNCTwa0L3nVve28ppq/Gr1pWa6sQkgDd4lvvBZt
    DGxytDHG9a2BHKyj6X59WbGk6YlT+k8njAWhGg2ykbygLnjmxuAfttWpDQW2XNw5
    mXar8ign8R2wqQn4dGh6wOrJBUtWN+QHEKyTmVEgC779ByUXQc3kORbGvB0Tp8C/
    xQT9ydI8lz6c5uwB6GQoxp6R5SYuhzpvIoDgK9mM0kPIOQ3FRyi8hJuUF0I8snPr
    Eg6Fc3warhyVacN8aXywPbC7aDeTVhZD2umamg8iLL29vKpFIqa5u+tpnN6sui0X
    ehipesK81w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF8suwKdNGhLneaExyVG599U6OgirtI0xdCiDPdaoQHBNtpAaodTKcaB1Cr5G3gA9W5GvFHAPUzGPs7uoRsIQ6Qik9zt3J2XvjDdBgdM9Ck92Bgvn3ex
    k/A/Qd7isOOmL7GL8fiR4XnkXoz7DKisFFI85hmLG+uy5+Txv0P51GW1nZ/8qIHof+FtmqcZzDXJuHt8gPh40bDj+p57403guVgMvXz/UNy8Y9PThQGEjTf7
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=sozttTNsAAAA:8 a=2KMo9-giAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=gIypJU5MUKaUxTlx8kcA:9 a=QEXdDO2ut3YA:10 a=aeg5Gbbo78KNqacMgKqU:22
    a=UeCTMeHK7YUBiLmz_SX7:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754164AbeDAUsW (ORCPT <rfc822;greg@kroah.com>);
        Sun, 1 Apr 2018 16:48:22 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:34247 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754058AbeDAUsU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 1 Apr 2018 16:48:20 -0400
Message-ID: <1522615695.2654.74.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 088/134] ARM: dts: am335x-pepper: Fix the audio
 CODECs reset pin
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Date: Sun, 01 Apr 2018 21:48:15 +0100
In-Reply-To: <20180319171902.020707561@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
         <20180319171902.020707561@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-03-19 at 19:06 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: "Andrew F. Davis" <afd@ti.com>
> 
> 
> [ Upstream commit e153db03c6b7a035c797bcdf35262586f003ee93 ]
> 
> The correct DT property for specifying a GPIO used for reset
> is "reset-gpios", fix this here.

This doesn't work without commit a825f31f9328 ("ASoC: tlv320aic31xx:
Use standard reset GPIO OF name") which went into 4.16.  Please revert
this for all stable branches.

Ben.

> Fixes: 4341881d0562 ("ARM: dts: Add devicetree for Gumstix Pepper board")
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/arm/boot/dts/am335x-pepper.dts |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/arm/boot/dts/am335x-pepper.dts
> +++ b/arch/arm/boot/dts/am335x-pepper.dts
> @@ -139,7 +139,7 @@
>  &audio_codec {
>  	status = "okay";
>  
> -	gpio-reset = <&gpio1 16 GPIO_ACTIVE_LOW>;
> +	reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
>  	AVDD-supply = <&ldo3_reg>;
>  	IOVDD-supply = <&ldo3_reg>;
>  	DRVDD-supply = <&ldo3_reg>;

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
