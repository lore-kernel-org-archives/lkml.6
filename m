Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2139197-1523043571-2-6110490651657110387
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523043571; b=dkRVCoW491Sn4SB17onp7M9YotmRtg4cx3+9+seimHBwYYkuVN
    xR6EmxM4+RCsp+kzah/1C+NcU6D587Q1sNC4q+Rr7eYbY3N4XySBUpSTr87S9V73
    5ZPXXZclHaciyQ8REiaG9VHOHetfBulN9HXLpUVVDtsQ2KP78+Bwpy/BDXkCDX3Z
    muYCpiQ8uoS8iRWBGEjR74Tzwr7aitCUVvK+rw09T3jEX4mgj8XxmPhIzxkP4+c/
    NS9O/XMdbNvP0N/LtwFnxjSuoSzjlgY1tCc4qYH0d7hGoXr5m+CKkl0D1UW223gC
    aiNcLs7HSRmk/lCwGrhM2wfZ8pBPd+K2uACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523043571;
    bh=hlol09TCau+OdC9FTVOzWvmkY7GvfAdrV03NV06k06k=; b=pZCwM5Hc8Zc2
    EN+meIU/Zp0Pfa83rz3Sz8eB/mtVygIurQkKQiLLOnpLGy9dk1ML0WDOS7MpKuB4
    eIWvXdNJzM/OhQusles4jQ+zok38x+1F/f2EXCWZ25W5YF71bSoRy+ViimghKeCL
    lPVczSB7QvyN5zABqEPDPOGsc6iRrfLlynKDdj7VmLLo5dfa0+fH/+7Ws9NNC68N
    twmXDqKkbXZaCpHB9nAfhqMMyydJfKvrzt9bKH9de9PmS5ZtgEcRRIsPTuYkMDaT
    fRj372VfONvkkf+W2CBWo88BYhaiIihXirBvIkIMd1aerwI/6+SESQlxfeC3f2aK
    BBC2Riv33w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=PWFIblb3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=PWFIblb3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPFv08JaJdfZRDBfldbXBLGQu21cCmD+6/2+vHXr6oJ761RxbGQRfVkEHWyrDUtNsnMk7EXV1iAtiTgH1NLVAKa2O0wiVwEJZ+RwThaZak7Nr2DWS8jQ
    yqPrcFaSYsbBgMYi48CwhhUvm2ZnfQ6Eijq+1wSygXtDIKGtLfoH/gFFE4y6YdQJ7gH+HSWc4TklRXf2UyF5eiLbgnHGy9+FUkFbn7el3IVaM5nPU5UqYeYK
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=r2R0xKT_Ks61qsG6fQAA:9 a=QEXdDO2ut3YA:10
    a=aeg5Gbbo78KNqacMgKqU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbeDFTjS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 15:39:18 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:44631 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeDFTjR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 15:39:17 -0400
Subject: Re: [PATCH] mfd: twl-core: Fix clock initialization
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <tony@atomide.com>, <lee.jones@linaro.org>
CC: <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hns@goldelico.com>, <stable@vger.kernel.org>
References: <20180405114636.16294-1-peter.ujfalusi@ti.com>
Message-ID: <8a06e6f0-3350-5cb0-48fa-3fd770421aca@ti.com>
Date: Fri, 6 Apr 2018 22:38:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180405114636.16294-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/05/2018 02:46 PM, Peter Ujfalusi wrote:
> When looking up the clock we must use the client->dev as device since that
> is the one which is probed via DT.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: stable@vger.kernel.org
> Fixes: 7e2e6c5758de9 ("mfd: twl-core: Do not create dummy pdata when booted with DT")

This is not correct, we should only apply it to v4.16 since things worked
before that with the drivers/clk/ti/clk-3xxx.c and
drivers/clk/ti/clk-3xxx-legacy.c

Switching device to look for the fck might fail in pre 4.16.

But if this is the case then we might want to rename the fck clock to the
correct hfclk.

On top of this patch a DT patch for the affected boards will be needed after
4.16 to define the hfclk clock (or if we do not rename it, the fck).

I'll send a v2 on Monday, but would like to hear your opinion on renaming fck
to hfclk from 4.16 onwards (and update the documentation as well). The DT
lookup is broken anyways w/o a patch similar to this.

-- 
Péter


> ---
>  drivers/mfd/twl-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index d3133a371e27..c649344fd7f2 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -1177,7 +1177,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	twl_priv->ready = true;
>  
>  	/* setup clock framework */
> -	clocks_init(&pdev->dev, pdata ? pdata->clock : NULL);
> +	clocks_init(&client->dev, pdata ? pdata->clock : NULL);
>  
>  	/* read TWL IDCODE Register */
>  	if (twl_class_is_4030()) {
> 


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
