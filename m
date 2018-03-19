Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2207741-1521445152-2-4043775996686612641
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521445151; b=KmqO9QElYeJWADMficqnH9JXX0O9z06Sf8m3HofOtFkcnyW
    kTSGW+6dW2J+2k6I26fRUJK7hs+i2UGjy9z/73Nv/2vxdY5TfuJgB9skmMMYOiAF
    TasxUAayn25fPYFFNqEcNLv9xjGsQTMdEBcHe6ukYiv4BAyx3KP3qRPgm4tMV7IC
    uMu05qnWuYjWoCux/+5fGLCGFZxqPnGYd9qOCaVSLL6t7zhP0UxikbLo6LD9Kgb1
    zYh52t4fa6YEnk4JdeM/N7WjPwiuw/VCgytT6kkM5mKNmKNDFMWHlWh0dgoXRPm/
    wvvIAEW8AJbeyhyYLxiLGvzN/w5TwpvNusJtWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1521445151; bh=CtQpLiM
    +vqDI+Uumxfx34+LN1zXxaUPn7NEBcLVk7/M=; b=t2GDrhcUdMknaF71cNmYHKR
    6b3+P8H/3mSL0ZFHABgES9red+b+khTExd0p7zJ1iw2YlaI5t+D313Ih8bu/xgKs
    3JBjgxzy9gKTQbYqMRlTgPMT75U++0b8UdiMxsp2BkBJYZEnYvl5ppE4xoJ/s6mR
    cpDDUWlrMGNQQtxQWB0fO+XnBJwHcUVtkZRFB+G/YdsqPwdd8ps4IrvNZ5HegRVD
    CW9n0j3oSLz1BcIwF159H5bLxkdyNLFCPj6xnOlFTouJvwY2TPAzD9pCVuFNw7n2
    y6DHpHdR0QWsbJIjXHslhtxWTtygOZ2TaDnog1BR/Z9IAw96DnXLWBc36DFV53A=
    =
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduuddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtugfgjggfshhpjeesthekredttderjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepheejleegnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduuddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtugfgjggfshhpjeesthekredttderjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepheejleegnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeCSHjJ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 03:39:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37244 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755301AbeCSHjI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 03:39:08 -0400
Date: Mon, 19 Mar 2018 08:39:07 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 000/128] 4.15.11-stable review
Message-ID: <20180319073907.GA30340@kroah.com>
References: <20180316152336.199007505@linuxfoundation.org>
 <20180318102526.GC30164@kroah.com>
 <20180318111523.GB4607@kroah.com>
 <20180319033925.tgsjiqzg6r6e3dfl@xps>
 <ceb5cd06-e04e-d33e-852c-e36b9b040038@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ceb5cd06-e04e-d33e-852c-e36b9b040038@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 18, 2018 at 10:36:20PM -0700, Guenter Roeck wrote:
> On 03/18/2018 08:39 PM, Dan Rue wrote:
> > On Sun, Mar 18, 2018 at 12:15:23PM +0100, Greg Kroah-Hartman wrote:
> > > On Sun, Mar 18, 2018 at 11:25:26AM +0100, Greg Kroah-Hartman wrote:
> > > > On Fri, Mar 16, 2018 at 04:22:21PM +0100, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 4.15.11 release.
> > > > > There are 128 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > > 
> > > > > Responses should be made by Sun Mar 18 15:22:57 UTC 2018.
> > > > > Anything received after that time might be too late.
> > > > > 
> > > > > The whole patch series can be found in one patch at:
> > > > > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.11-rc1.gz
> > > > 
> > > > -rc2 is out to fix a build error on some configs:
> > > >   	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.11-rc2.gz
> > > 
> > > And -rc3 is out that at least builds properly:
> > >    	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.11-rc3.gz
> > 
> > Sorry to say, this one doesn't build properly either.
> > 
> > I tested the previous build issue on arm64 only, but arm32 is still
> > failing on 4.14/4.15 due to the following:
> > 
> >      07f498834a53 ("clk: ti: clkctrl: add support for retrying failed init")
> > 
> > I'll reply to the patch directly as well.
> > 
> > $ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm multi_v7_defconfig
> > $ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm
> > 
> > ...
> > 
> > ../drivers/clk/ti/clkctrl.c: In function ‘_ti_omap4_clkctrl_setup’:
> > ../drivers/clk/ti/clkctrl.c:497:27: error: passing argument 2 of ‘ti_clk_retry_init’ from incompatible pointer type
> >   [-Werror=incompatible-pointer-types]
> >     ti_clk_retry_init(node, provider, _clkctrl_add_provider);
> >                             ^~~~~~~~
> > In file included from ../drivers/clk/ti/clkctrl.c:24:0:
> > ../drivers/clk/ti/clock.h:265:5: note: expected ‘struct clk_hw *’ but argument is of type ‘struct omap_clkctrl_prov
> > ider *’
> >   int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
> >       ^~~~~~~~~~~~~~~~~                                                                                             ../drivers/clk/ti/clkctrl.c:497:37: error: passing argument 3 of ‘ti_clk_retry_init’ from incompatible pointer type
> >   [-Werror=incompatible-pointer-types]
> >     ti_clk_retry_init(node, provider, _clkctrl_add_provider);
> >                                       ^~~~~~~~~~~~~~~~~~~~~
> > In file included from ../drivers/clk/ti/clkctrl.c:24:0:                                                            ../drivers/clk/ti/clock.h:265:5: note: expected ‘ti_of_clk_init_cb_t {aka void (*)(struct clk_hw *, struct device_n
> > ode *)}’ but argument is of type ‘void (*)(void *, struct device_node *)’
> >   int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
> >       ^~~~~~~~~~~~~~~~~
> > cc1: some warnings being treated as errors
> > make[4]: *** [../scripts/Makefile.build:329: drivers/clk/ti/clkctrl.o] Error 1
> > make[3]: *** [../scripts/Makefile.build:587: drivers/clk/ti] Error 2
> > make[2]: *** [../scripts/Makefile.build:587: drivers/clk] Error 2
> > make[1]: *** [/home/drue/src/linux/4.14-rc/Makefile:1031: drivers] Error 2
> > make[1]: Leaving directory '/home/drue/src/linux/4.14-rc/build-arm'
> > make: *** [Makefile:146: sub-make] Error 2
> > 
> > 
> 
> You are right. Difference in my build is that my version of gcc doesn't produce
> and error but just a warning.

These trees "should" be building with no warnings at all, thanks to the
great effort Arnd put in recently.  If any stable patch is adding
warnings, I'd like to know that as it sometimes hides real issues, like
this one.

thanks,

greg k-h
