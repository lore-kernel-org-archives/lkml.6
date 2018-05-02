Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-563107-1525258267-2-12779856066164395498
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525258267; b=PtcD42vrFNxHdHvAZWhWRuFtU2lMYLNgT2BrF+JI3CJqaJdccr
    U3h0JMA+fKYBA8YDDrsMEtKJVbN2fWwKxNf020L9fO76iP6LzDyICWhaSTpi9EoL
    rWf9Ke/MuPWx2lvQik44A9mFl6peGasILMzTWxi60ol6PFcXEXlW33nmTvmwHKs+
    j+8hTxO3Kza6DWMpFbgbP8vE9nGBaa1bKIZRYorwWU3a1HcSlA+yy/a+perwl7rg
    kv+wCtkpaJSmWWelYUCQ62afAffiG+2we2DSs5h7N7ABfyvwJIotvB848V3KjyBZ
    dCyuYQxtVs9q2vBwZ/1DYVA/a4R3iKjh37Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1525258267; bh=fpnQIjD33X6Pilo/kwpsRKLdmI3enyxHsMw5pTvCHsA=; b=M
    KNwBRIKKC6UT5tCbl9oSnNFv+tYOOE0w5mOIMdU2jdcuuCVxAiveqVpzomnbyFrH
    sjbGA6CrWgJyUqtjJaavQPWqv/bluaTm7bPeEx+7T0BXCHNSnItJVN+/GkzrtBJn
    YZTpXz4YyETzbVH/+WhyZVkqsIm+DxeOPXjgiCcakOEO7fMC/QRRYuj+iQytXHio
    13g6SKwYCeXRKVhLirhua6k64H/05EvL7zO7bQxFiifS7AyLARycNpdTjWJGl3XW
    OdxpLJeJswLoJ3iSZ4cBHCncJymzp7ai0ZWhCymKyqssUt9Nv3pu2DvUbhYhGw3L
    BYX67g9cVRBygw8AtVscA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=gX2QXIh+ x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=r0CQqrbj;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=gX2QXIh+ x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=r0CQqrbj;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJrjkhZegUS1igebS2JO52rXk/9r6EYtQ5Cd43ZFXOxbr7+RstbFIebsYKyw1xvY+AvL6csLIdcjrQRrOz84C2mxUNAXU7PugIqU9WEkRmopAsOV33Qz
    wXUQgRE718olUMMcYF8hBDgO72+l7UhotKvL7dKBl6AVU4QNKH5SXwqQEh09D1VLYG16WQMXbyGAPaX5dIJJQlW92uiaehd2D9GmL1ucNuABmL3oevNBWQDV
    pR3u665NrhMSu/mlrpoeSg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=LxSDy4Xbj5AA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=0ljVl91CbZRuJI90BjsA:9
    a=Zqi2zEjxcNbGsMHb:21 a=vAZheTmtaU1Ki20V:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZr1U+uqJBBYlJaNplLgnBsKyFAcWgOYR26/0I1H2pcttmQpIrvQ4/OrSLwD1POZMXfcVscM+Q==
Subject: Re: [PATCH v2] staging: greybus: Use gpio_is_valid()
To: Johan Hovold <johan@kernel.org>
References: <5c8c96b1971bc09a2a2bfa62c343973ab986aec8.1524889296.git.arvind.yadav.cs@gmail.com>
 <20180502084308.GF2285@localhost>
 <2aa263ef-1bbc-69fc-c007-303e59517081@gmail.com>
 <20180502095737.GG2285@localhost>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Message-ID: <76b344ea-d1fc-c080-c49a-7e18db326b64@gmail.com>
Date: Wed, 2 May 2018 16:20:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180502095737.GG2285@localhost>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Wednesday 02 May 2018 03:27 PM, Johan Hovold wrote:
> On Wed, May 02, 2018 at 03:15:05PM +0530, Arvind Yadav wrote:
>
>> On Wednesday 02 May 2018 02:13 PM, Johan Hovold wrote:
>>> On Sat, Apr 28, 2018 at 10:05:39AM +0530, Arvind Yadav wrote:
>>>> Replace the manual validity checks for the GPIO with the
>>>> gpio_is_valid().
>>>>
>>>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>>>> ---
>>>> chnage in v2 :
>>>>                Returning invalid gpio as error instead of -ENODEV.
>>>>
>>>>    drivers/staging/greybus/arche-platform.c | 6 +++---
>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
>>>> index 83254a7..c3a7da5 100644
>>>> --- a/drivers/staging/greybus/arche-platform.c
>>>> +++ b/drivers/staging/greybus/arche-platform.c
>>>> @@ -448,7 +448,7 @@ static int arche_platform_probe(struct platform_device *pdev)
>>>>    	arche_pdata->svc_reset_gpio = of_get_named_gpio(np,
>>>>    							"svc,reset-gpio",
>>>>    							0);
>>>> -	if (arche_pdata->svc_reset_gpio < 0) {
>>>> +	if (!gpio_is_valid(arche_pdata->svc_reset_gpio)) {
>>>>    		dev_err(dev, "failed to get reset-gpio\n");
>>>>    		return arche_pdata->svc_reset_gpio;
>>> I'm sorry, but I don't this change is desirable. of_get_named_gpio()
>>> returns a valid gpio number or a negative errno, so there's no need to
>>> use the legacy gpio_is_valid() helper here.
>>>
>>> If you grep for of_get_named_gpio() you'll find that some drivers indeed
>>> use that helper this way, but they are in a clear minority.
>>>
>>> And ultimately, we want to move to using gpio descriptors anyway.
>> We need to check gpio validity. If we are using of_get_named_gpio() or
>> not.  of_get_name_gpio() will read a device node and fetch the value.
>> But it'll not check that gpio is valid or not valid.
> No, I believe you're mistaken here. of_get_named_gpio() does not return
> an arbitrary gpio number, unlike what you could possibly find in
> legacy board files and for which the gpio_is_valid() helper made sense.
>
> Johan
Yes, You are coorect. It'll read gpio form gpio device node. Which means
it'll read from device tree node. without finding a valid entry. It'll 
return
an error.

~arvind

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
