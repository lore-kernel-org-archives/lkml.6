Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1937185-1521437788-2-15040927264135545707
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521437787; b=YGjqftr1TU6zJaYq374RKFp0cbhnMQs78tbCQvxdlpwXuxs
    fcz3jAiplaW1rHZWcE6Jb+Fak/tDnYUMGkC1Wd9Gx0venNnYn//bdrVOFB8ga/MU
    paHqzZJJ7ylO2/arREFyPZ2cPSKnQuSeGXKPHOIXEY0VbfiNRD1NVm9lsLx7zrIK
    eUy/M36pKO3VWkr535EiZcg1XaJMA5pbsY3VUPqyF+zX1Z7VJpwhXHTU/fL2OpxR
    p2EiPMvbNVxnyIZ0OLhi5n7cEt1AN1OrxTr6YKNn9oVLW5Q8XimGRm1f3/Hxer/f
    Zqr/A98kdnw44gtx0xH6tfKoRRBQ/8z8W0z0CFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521437787; bh=HLlsHumHRpQzEkRvedFUtlyFZkHEyC0pmB0xMqj2ncw=; b=M
    QRyaTeyNBxu7jolePBaRalQIwYHTzVIwv2F3ATgFz5637cKyamQjrmjbZulM3rYX
    qDJBzugJA3qkZh39wzJ0do+UsnYjYZYxrudMnndYMujFoJhVB7Z2NYdSkKs8vCU4
    C0O3/eaQmWfUb6Our8FsoKdYwWv1AUIqN/T8PYcSs6c4qcOQfBs2mXw8gmWypOoI
    j5CZsUo9Lg+8jEjatE50rWqBHsB2u4oP1wM1AP/iBDjmQmyJksAhA59d4rmAH/8Y
    bXCEJJbOGBVPexDYUNYY8pbgIEWn51jKGZMiprHMaJ8eeAT6HqFC1CphC5QdI1nq
    xE8vyLAO776cgYZtQ/8sQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Pt0iD+6O x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdekkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhsphejsehtkeertddtfeejnecuhfhrohhmpefiuhgvnhhtvghrucftohgvtghkuceolhhinhhugiesrhhovggtkhdquhhsrdhnvghtqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpuddtkedrvddvfedrgedtrdeiieenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeeileenucevlhhushhtvghrufhiiigvpedt;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NL9rFmxs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Pt0iD+6O x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdekkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhsphejsehtkeertddtfeejnecuhfhrohhmpefiuhgvnhhtvghrucftohgvtghkuceolhhinhhugiesrhhovggtkhdquhhsrdhnvghtqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpuddtkedrvddvfedrgedtrdeiieenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeeileenucevlhhushhtvghrufhiiigvpedt;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NL9rFmxs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754964AbeCSFgY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 01:36:24 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39080 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeCSFgX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 01:36:23 -0400
X-Google-Smtp-Source: AG47ELs1xlj1jFKCKeySLr3QlP9rJvZj/5kXaEwo8n6JldP8oFBGzCwunJZzQMiPZ396wL4Diwf6Lw==
Subject: Re: [PATCH 4.15 000/128] 4.15.11-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180316152336.199007505@linuxfoundation.org>
 <20180318102526.GC30164@kroah.com> <20180318111523.GB4607@kroah.com>
 <20180319033925.tgsjiqzg6r6e3dfl@xps>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ceb5cd06-e04e-d33e-852c-e36b9b040038@roeck-us.net>
Date: Sun, 18 Mar 2018 22:36:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319033925.tgsjiqzg6r6e3dfl@xps>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/18/2018 08:39 PM, Dan Rue wrote:
> On Sun, Mar 18, 2018 at 12:15:23PM +0100, Greg Kroah-Hartman wrote:
>> On Sun, Mar 18, 2018 at 11:25:26AM +0100, Greg Kroah-Hartman wrote:
>>> On Fri, Mar 16, 2018 at 04:22:21PM +0100, Greg Kroah-Hartman wrote:
>>>> This is the start of the stable review cycle for the 4.15.11 release.
>>>> There are 128 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Sun Mar 18 15:22:57 UTC 2018.
>>>> Anything received after that time might be too late.
>>>>
>>>> The whole patch series can be found in one patch at:
>>>> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.11-rc1.gz
>>>
>>> -rc2 is out to fix a build error on some configs:
>>>   	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.11-rc2.gz
>>
>> And -rc3 is out that at least builds properly:
>>    	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.11-rc3.gz
> 
> Sorry to say, this one doesn't build properly either.
> 
> I tested the previous build issue on arm64 only, but arm32 is still
> failing on 4.14/4.15 due to the following:
> 
>      07f498834a53 ("clk: ti: clkctrl: add support for retrying failed init")
> 
> I'll reply to the patch directly as well.
> 
> $ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm multi_v7_defconfig
> $ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm
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
> 

You are right. Difference in my build is that my version of gcc doesn't produce
and error but just a warning.

Guenter
