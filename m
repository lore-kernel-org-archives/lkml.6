Return-Path: <dan.rue@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521430769; cv=none;
        d=google.com; s=arc-20160816;
        b=ku1vF3c4jOKLi5IEu+W4RHJ4tIqrdHytYKbQ/lhlOOhgEnTCrzS3cGJhmPpx7bUKU+
         uG0E8Yihlma55igkwWLO4xGwFA9YYyupEvqy5xTnTME4vXmYHOclgIrplXMEH9Q8q2T2
         gmDogRr4Jt0AR7XTPWF2T5AiG8OeFkec0ibDXB6C1kkybbDdS/+3tYOcHv1aPJ/xmhRx
         sUAriCDGw6rgS8rlxchcwH2yfK8H7BuZyBA4WA8kLeO7PrpI+3X/1JKrbYGx2basBa7Z
         Q4qB/7cZWOnRgA7kORhDC6BbfQ1Ba0RxEUpj+KxJ9s4NjCxNe9v1b0El3Np5iUQ+sI1o
         btjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:mail-followup-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=BBFwR0FAAZo/ZNOQz7CJR8i/Ab1EPz08YvxkRRjuITo=;
        b=vfNHXp7trdHlQICeEaTUpPj2Ku2WnUvX3g+r3QoxQWbuQNi1ZPhZojj4twu2gsLQ9x
         VxXL5OR8PNSVH49DqRNDsHEqh9C3EcF7c3K5AKIaVqtysV01qDdDvOKPMqoT8LdA6HM4
         ARjP66Fm+xXRhjQU5Qff/+Gkw8ihIbc/mf52qwiVBZ0VvXlEckicdziFTzFRIOJHRSln
         pBHVqipXwfj4z/avGr9de9LkQ2/NRVLRoBZJcsT7vQLzZzCxXCtGc+UZar19Ce5ZfZPr
         iKINbirK9o/HsDJA/7UGpFGs4wJMeAEp5VsxbgQ1n437Rn5i3uOyvBQrQNkmLx2ezmmC
         yI5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=WkmhLH8w;
       spf=pass (google.com: domain of dan.rue@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.rue@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=WkmhLH8w;
       spf=pass (google.com: domain of dan.rue@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.rue@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELuGlb6u/IIvnJK2T5bj4ALCaQ6aCia+cp1KgiSSGV3iDy1UJnHNRYBzI6YOE6bs54gmMPUMyA==
Date: Mon, 19 Mar 2018 11:39:25 +0800
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net,
	shuahkh@osg.samsung.com, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.15 000/128] 4.15.11-stable review
Message-ID: <20180319033925.tgsjiqzg6r6e3dfl@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net,
	shuahkh@osg.samsung.com, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
References: <20180316152336.199007505@linuxfoundation.org>
 <20180318102526.GC30164@kroah.com>
 <20180318111523.GB4607@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180318111523.GB4607@kroah.com>
User-Agent: NeoMutt/20180223
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595109395590505536?=
X-GMAIL-MSGID: =?utf-8?q?1595335790212153497?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 18, 2018 at 12:15:23PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Mar 18, 2018 at 11:25:26AM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Mar 16, 2018 at 04:22:21PM +0100, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.15.11 release.
> > > There are 128 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sun Mar 18 15:22:57 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.11-rc1.gz
> > 
> > -rc2 is out to fix a build error on some configs:
> >  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.11-rc2.gz
> 
> And -rc3 is out that at least builds properly:
>   	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.11-rc3.gz

Sorry to say, this one doesn't build properly either.

I tested the previous build issue on arm64 only, but arm32 is still
failing on 4.14/4.15 due to the following:

    07f498834a53 ("clk: ti: clkctrl: add support for retrying failed init")

I'll reply to the patch directly as well.

$ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm multi_v7_defconfig
$ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm

...

../drivers/clk/ti/clkctrl.c: In function ‘_ti_omap4_clkctrl_setup’:
../drivers/clk/ti/clkctrl.c:497:27: error: passing argument 2 of ‘ti_clk_retry_init’ from incompatible pointer type
 [-Werror=incompatible-pointer-types]
   ti_clk_retry_init(node, provider, _clkctrl_add_provider);
                           ^~~~~~~~
In file included from ../drivers/clk/ti/clkctrl.c:24:0:
../drivers/clk/ti/clock.h:265:5: note: expected ‘struct clk_hw *’ but argument is of type ‘struct omap_clkctrl_prov
ider *’
 int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
     ^~~~~~~~~~~~~~~~~                                                                                             ../drivers/clk/ti/clkctrl.c:497:37: error: passing argument 3 of ‘ti_clk_retry_init’ from incompatible pointer type
 [-Werror=incompatible-pointer-types]
   ti_clk_retry_init(node, provider, _clkctrl_add_provider);
                                     ^~~~~~~~~~~~~~~~~~~~~
In file included from ../drivers/clk/ti/clkctrl.c:24:0:                                                            ../drivers/clk/ti/clock.h:265:5: note: expected ‘ti_of_clk_init_cb_t {aka void (*)(struct clk_hw *, struct device_n
ode *)}’ but argument is of type ‘void (*)(void *, struct device_node *)’
 int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
     ^~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[4]: *** [../scripts/Makefile.build:329: drivers/clk/ti/clkctrl.o] Error 1
make[3]: *** [../scripts/Makefile.build:587: drivers/clk/ti] Error 2
make[2]: *** [../scripts/Makefile.build:587: drivers/clk] Error 2
make[1]: *** [/home/drue/src/linux/4.14-rc/Makefile:1031: drivers] Error 2
make[1]: Leaving directory '/home/drue/src/linux/4.14-rc/build-arm'
make: *** [Makefile:146: sub-make] Error 2
