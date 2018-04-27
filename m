Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-147147-1524833465-2-17827900396014349681
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524833465; b=hE6B7gi5JWDOh2AMMg/0eil3XhdmcrRqLKdrIEP8vxXLy57myF
    5Afe/FVKoQnytDSLTPDbrrqtHDrUAyH/lhUdqAeAkSsY36hJs1cGoXXP+MgJZYIO
    1dLXDAGXXDDD4UhhB9V2XDB2/0hgCi0gX6qOYB+6tr3y2XDwFg7L+rxbojlHgvIF
    SQk3IQDYqlaQqBnZA6lq4RsQS6p//Up1keXbYtaVwHsmL+ZG/iikCm8iUrfvxL6C
    o3O1dPaLcPthuFev1JPhcQeb/BwcSTXwfSvCVmiM2X2S6m77ZK5vYC+eYNHSpxIo
    N0ESFZbbrnVLlMjp3LJm3utP+b4Nzd37P0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1524833465; bh=IHxGbMk8nAjhozEk9JpXCLufqodo7hc2XqougtBOeNY=; b=L
    3Wi+3f7YkcUnQee+O0WIzefKYaP3jXX5mqVjY/r9q3mAhUgpIohg+N/vHJIV3/Hp
    BYV6gkLrzM/pz1ueeUJEPJvRDfE/CAjDy7WZp5UfXNIJR+XkeeLE8V9/PAKWnRcU
    55nZUIKPnXnWHwcwQSsCU2pD0Vn5Vwk1NdvYHCf+DoQ7cgSfBFmTHlIi4fBF+6FL
    Q6Q6x34G8J5TlC7uTcQP8ibXaY+Z5hK7SFudNYwCXENVGhBf89D4rEjddxQ57/sC
    Y2LA3vGyjBa5Y8tqpdeO959vAHeXGmgO15nO9L8j+ajGZxJ//tzkbLpHfYLQvfCm
    8tdqubBmV3CzDWOWYnlTQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UbL1dpxT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cIeLobj5;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UbL1dpxT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cIeLobj5;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCl9pxiktcHqmXpfuceciQ0OphHJPoz2HArCmfhtBPDw5sKdVuX2rjfGkmztyZSAEHfwTMJofJ0jKWavZrUArj2Xy+bKfi3kzlZmd0r5W8yVveXjMIL0
    /ps7TWOQqqNyVdbGJ1WS5E/Y4ga/ZpAYKCzF4zTf9ME4rrokPUL0p2vm9RjN5edFMEyZ/rF4curLTArKR1kBt1hD22G19WmrxnqzsOQFcrAs5InLV9VHMapc
    nUr7np9vgr/lunSCFEXiig==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=LxSDy4Xbj5AA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=F9cQ4q0Gn4PUF6tNBNIA:9
    a=jvCi_JULQ7fMZpuO:21 a=bg333JIOREgi4ndX:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqUQEQLX+bJNq9xoff/V0+/dEZXRuwDVBynTFlJo1rjy+3VpOPJcHqSIYBq2QamDQMWtUfFHQ==
Subject: Re: [greybus-dev] [PATCH] staging: greybus: Use gpio_is_valid()
To: Alex Elder <elder@linaro.org>, hvaibhav.linux@gmail.com,
 johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org
References: <785eda4d65f396b353393e9538eba21095ce876e.1524825902.git.arvind.yadav.cs@gmail.com>
 <7ebee672-6413-6f1d-fe57-2e278c90cf9e@linaro.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Message-ID: <3910023d-143e-7618-1fd4-f3bdffbfb3ec@gmail.com>
Date: Fri, 27 Apr 2018 18:20:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <7ebee672-6413-6f1d-fe57-2e278c90cf9e@linaro.org>
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
Cc: devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Friday 27 April 2018 05:47 PM, Alex Elder wrote:
> On 04/27/2018 05:52 AM, Arvind Yadav wrote:
>> Replace the manual validity checks for the GPIO with the
>> gpio_is_valid().
> I haven't looked through the code paths very closely, but I
> think that get_named_gpio() might return -EPROBE_DEFER, which
> would be something we want to pass to the caller.
Yes of_get_name_gpio() can return other error value apart from
-EPROBE_DEFER.
> So rather than returning -ENODEV and hiding the reason the
> call to of_get_named_gpio() failed, you should continue
> returning the errno it supplies (if not a valid gpio number).
>
> 					-Alex
I have return -ENODEV because invalid gpio pin can be positive.
static inline bool gpio_is_valid(int number)
{
     return number >= 0 && number < ARCH_NR_GPIOS;
}
Here if number > ARCH_NR_GPIOS then it's invalid but return value
will be positive.

We can return like this
     " return (gpio > 0) ? -ENODEV: gpio;"

But not sure this is worth to handle this.

~arvind
>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>   drivers/staging/greybus/arche-platform.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
>> index 83254a7..fc6bf60 100644
>> --- a/drivers/staging/greybus/arche-platform.c
>> +++ b/drivers/staging/greybus/arche-platform.c
>> @@ -448,9 +448,9 @@ static int arche_platform_probe(struct platform_device *pdev)
>>   	arche_pdata->svc_reset_gpio = of_get_named_gpio(np,
>>   							"svc,reset-gpio",
>>   							0);
>> -	if (arche_pdata->svc_reset_gpio < 0) {
>> +	if (!gpio_is_valid(arche_pdata->svc_reset_gpio)) {
>>   		dev_err(dev, "failed to get reset-gpio\n");
>> -		return arche_pdata->svc_reset_gpio;
>> +		return -ENODEV;
>>   	}
>>   	ret = devm_gpio_request(dev, arche_pdata->svc_reset_gpio, "svc-reset");
>>   	if (ret) {
>> @@ -468,9 +468,9 @@ static int arche_platform_probe(struct platform_device *pdev)
>>   	arche_pdata->svc_sysboot_gpio = of_get_named_gpio(np,
>>   							  "svc,sysboot-gpio",
>>   							  0);
>> -	if (arche_pdata->svc_sysboot_gpio < 0) {
>> +	if (!gpio_is_valid(arche_pdata->svc_sysboot_gpio)) {
>>   		dev_err(dev, "failed to get sysboot gpio\n");
>> -		return arche_pdata->svc_sysboot_gpio;
>> +		return -ENODEV;
>>   	}
>>   	ret = devm_gpio_request(dev, arche_pdata->svc_sysboot_gpio, "sysboot0");
>>   	if (ret) {
>> @@ -487,9 +487,9 @@ static int arche_platform_probe(struct platform_device *pdev)
>>   	arche_pdata->svc_refclk_req = of_get_named_gpio(np,
>>   							"svc,refclk-req-gpio",
>>   							0);
>> -	if (arche_pdata->svc_refclk_req < 0) {
>> +	if (!gpio_is_valid(arche_pdata->svc_refclk_req)) {
>>   		dev_err(dev, "failed to get svc clock-req gpio\n");
>> -		return arche_pdata->svc_refclk_req;
>> +		return -ENODEV;
>>   	}
>>   	ret = devm_gpio_request(dev, arche_pdata->svc_refclk_req,
>>   				"svc-clk-req");
>>

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
