Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2207741-1521442681-2-12524077372742870093
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521442680; b=FZjrVhgtuipLpeAaPfvvr1+Yjyib3z7XKPFTwsDwC3IstRY
    /o2eVDIo8Qr3+zvlAe6fvP7sQqCmig6SJ1YH3oMuUnMKmx+c7iVDxLC59dVCpBKj
    4YCh0eeSXcboK1DTKpdraSrzV80mGzzgZS+Bnqr945GnL/H4HCvgCFNQAepIKLQj
    c2STRZ4XY/XjoJ3pbwSszg1wsH/D/1zFBbacU1veBnDLQW9sUQ8RHkST5MDy/iz7
    7yS4qXPqXhk0OLRrPJzrvzFstnKriQHgqsFzMLUcJhEpYcbru/IHEgaq6R+ONgjK
    G0xLmU3xDImwrdH5WcvUFObt0v9Q179vsb4yG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521442680; bh=JsBP4OsxLDsdAdVR6WxwWVnli4S9cDBpRZ/3v0h/ciA=; b=i
    VBLQWtNLKZoBUECZq02rRCSIc7ySFcxuhqWEocCdCxN9rrVuT3KQyFoyE519i3F6
    oWaN0GICUrFbdXOXKwdUfzwDMpKI2owsX1nd1AOX2VyeW3dEw+whSLML7fAI/OO7
    68KrL4UW99fLk0nC+u6Jzak5xKgYZegangSVePBhd5WR1PBe807nc6/Ote0vwx5u
    3kf6Hn5WnSiNAkKvN6HPG5m1hW//TNSPP4Vvzac4o5qnfiIVkAeudoJtDcp5vmFi
    +TGc+XU+1faOasc7xdFP1ZzZN8ZIzcKBVLZssOfWVDiEQwACrfCnJpNmgJRv37ep
    0P7C7G8O6RiFMn6e+iPCg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=YB71+Wu0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgshhpjeesthekredttdefjeenucfhrhhomhepvfgvrhhoucfmrhhishhtohcuoehtqdhkrhhishhtohesthhirdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdduleekrdegjedrvdejrdektdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeefieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=YB71+Wu0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgshhpjeesthekredttdefjeenucfhrhhomhepvfgvrhhoucfmrhhishhtohcuoehtqdhkrhhishhtohesthhirdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdduleekrdegjedrvdejrdektdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeefieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932197AbeCSG54 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 02:57:56 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:21050 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932190AbeCSG5z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 02:57:55 -0400
Subject: Re: [PATCH 4.14 056/109] clk: ti: clkctrl: add support for retrying
 failed init
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180316152329.844663293@linuxfoundation.org>
 <20180316152333.001660820@linuxfoundation.org>
 <20180319034408.wi6wfosbcckw22j6@xps>
From: Tero Kristo <t-kristo@ti.com>
Message-ID: <67169312-ba94-7a68-56cf-8412d8b42169@ti.com>
Date: Mon, 19 Mar 2018 08:57:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319034408.wi6wfosbcckw22j6@xps>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 19/03/18 05:44, Dan Rue wrote:
> On Fri, Mar 16, 2018 at 04:23:25PM +0100, Greg Kroah-Hartman wrote:
>> 4.14-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Tero Kristo <t-kristo@ti.com>
>>
>>
>> [ Upstream commit 729e13bf58e643b9accd2a14c55b555958702fb0 ]
>>
>> In case the clkctrl node contains assigned-clock-* entries, registering
>> the provider can fail with -EPROBE_DEFER. In this case, add the
>> provider to the retry_init clock list so it will be cleaned up later.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This fails to build for me on arm32:
> 
> $ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm multi_v7_defconfig
> $ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm

This actually needs commit ffb009b24388b896d9ca8b54e39a879302142518 
("clk: ti: convert retry_init param to use void data type") as 
prerequisite, otherwise it fails building.

-Tero


> 
> ...
> 
> ../drivers/clk/ti/clkctrl.c: In function ‘_ti_omap4_clkctrl_setup’:
> ../drivers/clk/ti/clkctrl.c:497:27: error: passing argument 2 of ‘ti_clk_retry_init’ from incompatible pointer type
>   [-Werror=incompatible-pointer-types]
>     ti_clk_retry_init(node, provider, _clkctrl_add_provider);
>                             ^~~~~~~~
> In file included from ../drivers/clk/ti/clkctrl.c:24:0:
> ../drivers/clk/ti/clock.h:265:5: note: expected ‘struct clk_hw *’ but argument is of type ‘struct omap_clkctrl_prov
> ider *’
>   int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
>       ^~~~~~~~~~~~~~~~~                                                                                             ../drivers/clk/ti/clkctrl.c:497:37: error: passing argument 3 of ‘ti_clk_retry_init’ from incompatible pointer type
>   [-Werror=incompatible-pointer-types]
>     ti_clk_retry_init(node, provider, _clkctrl_add_provider);
>                                       ^~~~~~~~~~~~~~~~~~~~~
> In file included from ../drivers/clk/ti/clkctrl.c:24:0:                                                            ../drivers/clk/ti/clock.h:265:5: note: expected ‘ti_of_clk_init_cb_t {aka void (*)(struct clk_hw *, struct device_n
> ode *)}’ but argument is of type ‘void (*)(void *, struct device_node *)’
>   int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
>       ^~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> make[4]: *** [../scripts/Makefile.build:329: drivers/clk/ti/clkctrl.o] Error 1
> make[3]: *** [../scripts/Makefile.build:587: drivers/clk/ti] Error 2
> make[2]: *** [../scripts/Makefile.build:587: drivers/clk] Error 2
> make[1]: *** [/home/drue/src/linux/4.14-rc/Makefile:1031: drivers] Error 2
> make[1]: Leaving directory '/home/drue/src/linux/4.14-rc/build-arm'
> make: *** [Makefile:146: sub-make] Error 2
> 
>> ---
>>   drivers/clk/ti/clkctrl.c |   12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> --- a/drivers/clk/ti/clkctrl.c
>> +++ b/drivers/clk/ti/clkctrl.c
>> @@ -400,6 +400,12 @@ _ti_clkctrl_setup_subclks(struct omap_cl
>>   	}
>>   }
>>   
>> +static void __init _clkctrl_add_provider(void *data,
>> +					 struct device_node *np)
>> +{
>> +	of_clk_add_hw_provider(np, _ti_omap4_clkctrl_xlate, data);
>> +}
>> +
>>   static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
>>   {
>>   	struct omap_clkctrl_provider *provider;
>> @@ -411,6 +417,7 @@ static void __init _ti_omap4_clkctrl_set
>>   	struct omap_clkctrl_clk *clkctrl_clk;
>>   	const __be32 *addrp;
>>   	u32 addr;
>> +	int ret;
>>   
>>   	addrp = of_get_address(node, 0, NULL, NULL);
>>   	addr = (u32)of_translate_address(node, addrp);
>> @@ -485,7 +492,10 @@ static void __init _ti_omap4_clkctrl_set
>>   		reg_data++;
>>   	}
>>   
>> -	of_clk_add_hw_provider(node, _ti_omap4_clkctrl_xlate, provider);
>> +	ret = of_clk_add_hw_provider(node, _ti_omap4_clkctrl_xlate, provider);
>> +	if (ret == -EPROBE_DEFER)
>> +		ti_clk_retry_init(node, provider, _clkctrl_add_provider);
>> +
>>   	return;
>>   
>>   cleanup:
>>
>>

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
