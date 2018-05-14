Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AB8JxZpr2boQNK9vQlWBeqJ7BTtjP6mmNfEzAIpcpT9mALevX7WOV/nDIiUrCiKzLGX6ni5/+1ff
ARC-Seal: i=1; a=rsa-sha256; t=1526320906; cv=none;
        d=google.com; s=arc-20160816;
        b=hvTO2FwwhImouDuYrT3kpR9uKy9ns/H2i/F+aflbO8csZ+JOWHUhyuSgSEWRWkDAgn
         macoyAY981PYVXgffk9vyiK3hQx6O6vI/n5NNi2FH17j6un14zeeZpQbg6Op4fgjTife
         UNWmbLQWnudQ6SsPpDlvidhmzO1lGJrZ3az7qcWgX9uFw+MWAFGQ4ZZsIOrkP0IRBn3r
         tokQoFwilgM9BPBSHZwllM0SgS2ne0GUdyWKyiN43oj6IhFYXRmXjdVh7/u4Y2S1exgC
         FyQyy9kZmFD+olZXMvSaRD6tlwocywdiEXs8OapkkTfVOj0tZnrSgu7Rvj1kaeJ3iflA
         dSnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=Xurd6BcuKGJ75DjgRyROHjPQuf98Q5fH7jOa7tA6jkM=;
        b=dO4BNosTXGJGq2+epD9BaV/nF6EIZrgRw2jOCuoK1GL2P5+zzZEzp2hzwc5rrptyI9
         oO6/PMaTxbohzLA4Z+lwEQbx+vO0YWw7eFLRTOM7u6PLvCz2diO4nAtxqrVQ7uSbOuMa
         CVWnY0XBuIG3KFzKVkQ7zuyFgPV43zxtVAs3EJcBAbdtr+2xS2FoB6U/Rr/lnj+2MDaA
         jD7VLRUmC2BrdU1NHhQC0TuUnr8Zat8BKJYxalaXlVGWszlHwatrsmZEBKRVp6jJjyIw
         8/VrHO9vRVb88Fc8mvJ2SrGs1XKuIlJlG9I99IRQvCCu43wn4ZsNbfINkqsgnnoM4GHd
         KTBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=koxT9JOr;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=koxT9JOr;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [patch v20 1/4] drivers: jtag: Add JTAG core driver
To: Oleksandr Shamray <oleksandrs@mellanox.com>, gregkh@linuxfoundation.org,
 arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, joel@jms.id.au,
 jiri@resnulli.us, tklauser@distanz.ch, linux-serial@vger.kernel.org,
 vadimp@mellanox.com, system-sw-low-level@mellanox.com, robh+dt@kernel.org,
 openocd-devel-owner@lists.sourceforge.net, linux-api@vger.kernel.org,
 davem@davemloft.net, mchehab@kernel.org, Jiri Pirko <jiri@mellanox.com>
References: <1526314803-3532-1-git-send-email-oleksandrs@mellanox.com>
 <1526314803-3532-2-git-send-email-oleksandrs@mellanox.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <338d958b-f3c3-15b8-32b9-9d30bfb348b5@infradead.org>
Date: Mon, 14 May 2018 11:01:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526314803-3532-2-git-send-email-oleksandrs@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600457078695337845?=
X-GMAIL-MSGID: =?utf-8?q?1600463471194149266?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/14/2018 09:20 AM, Oleksandr Shamray wrote:

Hi,
Just a bit more Kconfig fixing below.

> ---
>  Documentation/ioctl/ioctl-number.txt |    2 +
>  MAINTAINERS                          |   10 ++
>  drivers/Kconfig                      |    2 +
>  drivers/Makefile                     |    1 +
>  drivers/jtag/Kconfig                 |   18 +++
>  drivers/jtag/Makefile                |    1 +
>  drivers/jtag/jtag.c                  |  274 ++++++++++++++++++++++++++++++++++
>  include/linux/jtag.h                 |   41 +++++
>  include/uapi/linux/jtag.h            |  105 +++++++++++++
>  9 files changed, 454 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/jtag/Kconfig
>  create mode 100644 drivers/jtag/Makefile
>  create mode 100644 drivers/jtag/jtag.c
>  create mode 100644 include/linux/jtag.h
>  create mode 100644 include/uapi/linux/jtag.h

> diff --git a/drivers/jtag/Kconfig b/drivers/jtag/Kconfig
> new file mode 100644
> index 0000000..ba72a2b
> --- /dev/null
> +++ b/drivers/jtag/Kconfig
> @@ -0,0 +1,18 @@
> +menuconfig JTAG
> +	tristate "JTAG support"
> +	help
> +	  This provides basic core functionality support for JTAG class devices

(end sentence above with '.')                                           devices.

> +	  Hardware that is equipped with a JTAG microcontroller can be
> +	  supported by using this driver's interfaces.
> +	  This driver exposes a set of IOCTL to the user space for

	                               IOCTLs

> +	  another commands:

	  various commands:
or
	  the following commands:
or
	  associated commands:

> +	  SDR: (Scan Data Register) Performs an IEEE 1149.1 Data Register scan
> +	  SIR: (Scan Instruction Register) Performs an IEEE 1149.1 Instruction
> +	  Register scan.
> +	  RUNTEST: Forces the IEEE 1149.1 bus to a run state for a specified
> +	  number of clocks or a specified time period.
> +
> +	  If you want this support, you should say Y here.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called jtag.
thanks,
-- 
~Randy
