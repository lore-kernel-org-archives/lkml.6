Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520638043; cv=none;
        d=google.com; s=arc-20160816;
        b=kw/bZbrwHSihvH8RjFwPSlzLT/9u2/vsYBpzKqI9pfTGliEv7VdExvjG0N6DvHsld1
         v5AQN0LhLLVVd6e9QokBz8+JHWOEov1iYP1WunslPdpFVYrJqb7a35Z6vUztz5HuOibE
         cIFZ9WZA1CNeq+rr9g0ft7dvEVKnluIMaFjlhl5p9IpoAzRYCmG2ghNxQ5wa28fy2mC2
         1KPuKxfKyzqf6DTLWaMQYYZ7fZpV7x2LzPiid3mDX8nYq6Sq9ry4CIaMQKSLpBWlPzvp
         EqEyiSpRWxF+58+EBsQEZ88GoABDSbCJ9ml6oUTx4RYjFNQzHFMWDBZ4ML12x0IMo2Wi
         S+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=1RCUlxJ6xrmyfz4prZjln+Ma+wOFH0Egcg2I40/zB7o=;
        b=OiYjTzsPdWdZHflTBVJLDQ+YZsNSby8+bTiB4bhJAklCGhxn4x5PgY7y6LpyT4Nzrc
         UWezh8VRMkH5jClHqXj1hhVYrMtXZxJh6/d2TcavF6ugW9gb5LYUtnGhVQ7Qjv5uktNV
         5CZTn+wapZhLLWkNdkSccM3JGSZ1Sq8UqtFPBP5kKxgMgb6ZZ/eYqIA6JddqpMrDX6LG
         mq+71t96EH46EG+QY6hDsXn2swq+Cl9yt7v4YqXfNj2v+F7JNw0GdqmhzsHLzVO6jp5e
         5s8tQEBIwVofxKys4hYOUqu9ltOt0IuLVn+bo9eJEAmI+0TtkhJfi3eCD9TzlHHryAA8
         RPbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AG47ELuEukGtxNN1aOHD7UbADoZ+y7zy5EbkWxKpMTd4QTyUfXcC/6Y0SlX/vJVuTfghLTv2FRRmlg==
Date: Fri, 9 Mar 2018 17:27:21 -0600
From: Rob Herring <robh@kernel.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, briannorris@google.com, heiko@sntech.de,
	dtor@google.com, dianders@google.com, devicetree@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v5 1/3] Input: gpio-keys - add support for wakeup event
 action
Message-ID: <20180309232720.pmqaulifiqa5czul@rob-hp-laptop>
References: <20180308073213.8419-1-jeffy.chen@rock-chips.com>
 <20180308073213.8419-2-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308073213.8419-2-jeffy.chen@rock-chips.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593796398351218110?=
X-GMAIL-MSGID: =?utf-8?q?1594504556852667440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 03:32:11PM +0800, Jeffy Chen wrote:
> Add support for specifying event actions to trigger wakeup when using
> the gpio-keys input device as a wakeup source.
> 
> This would allow the device to configure when to wakeup the system. For
> example a gpio-keys input device for pen insert, may only want to wakeup
> the system when ejecting the pen.
> 
> Suggested-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v5:
> Remove unneeded irq_wake flag as Andy suggested.
> 
> Changes in v4:
> Add dt-binding gpio-keys.h, stop saving irq trigger type, add enable/disable wakeup helpers as Dmitry suggested.
> 
> Changes in v3:
> Adding more comments as Brian suggested.
> 
> Changes in v2:
> Specify wakeup event action instead of irq trigger type as Brian
> suggested.
> 
>  drivers/input/keyboard/gpio_keys.c    | 63 +++++++++++++++++++++++++++++++++--
>  include/dt-bindings/input/gpio-keys.h | 13 ++++++++

This file should be in the binding patch.

>  include/linux/gpio_keys.h             |  2 ++
>  3 files changed, 75 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/input/gpio-keys.h
