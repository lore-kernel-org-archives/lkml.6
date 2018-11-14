Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EDCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D8222419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfAw4SEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D8222419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbeKOAID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 19:08:03 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40646 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbeKOAIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 19:08:02 -0500
Received: by mail-qk1-f195.google.com with SMTP id y16so25864049qki.7;
        Wed, 14 Nov 2018 06:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0evwfVr5oz23JFffPTRBSjiLxYvlnzJuk2S/0AYyRIo=;
        b=hfAw4SEIugyuR6HPAThnyOioF4fmmcM+h3N3hkdFgdb7jElzP66qUly+xw+TyhuERd
         XPlQ28+HeWJjszd7T0JhmTwujKgOM6BGUTcKkuV5O9IJ9lq3B43mozc5oXZjWJDIiRXB
         OCGi9e7lhAA4GY93/QePYQS5j42HJIyj4JuRXvAgxYZ6iXiTFU0W2TAzRVD4pK54m0dS
         N3YIwOjLb0bpIoY+9tf04m1LOeQYbZsKkoSSt4uES0x2JGAdp4fGjecGpr9slqvZV9mV
         ooeN4A9Cf3HwMIi2Y25clHQYrx70NBgoCwNkm+P4ZHPPLPKokBwgPqe9YNUZVr3KcK7o
         JWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0evwfVr5oz23JFffPTRBSjiLxYvlnzJuk2S/0AYyRIo=;
        b=i5zWngSqiuio7UmG5vJmNsaJ/mxbbcWWW15IntijywG2hDIBQ8x+BbS9a70JnXx3mB
         WZbOLEOtj0CNDpy81ozs40J6B8IVon2expD1XSh+jXetVEMofnRnDQvLeejMK+5MsbAH
         P0Q5m+gGI8KgXtI400xI0c8WFKJOmj/YSMOXIWD1c2jEkEVWkBE57Vov+ZCLW8/BIgco
         PY6q8fNpZA8CrH2kH/EL/VyE9e5FZvItCzmNuVbtih8hxaeOovRvgACFj92Yp9MoXnNJ
         oyzOdb9kWPcMhXBrFgZFuYGgHSQIwkyPyR13NQe4SQjMYWuEReeIEpmfWu0nBwVt1aHu
         Hr6Q==
X-Gm-Message-State: AGRZ1gIteN+qyaJZWBKQBsh1c+hrwdwiHUyUu+NkEECE7Cp+SGQF9I0z
        NfffEZ3E9WgNeIPChOSPjDYjzRl1OwLhiJvM7/Y=
X-Google-Smtp-Source: AJdET5etUB1hAsnlUOPYlDOaF5Jv+myOdELoIvuGIQSeZ/hhvJUfDzVTW9k4UkEMeBJWzKs0xD7P4VQFqvO8wcPi7HA=
X-Received: by 2002:a0c:c2ce:: with SMTP id c14mr1971511qvi.7.1542204278283;
 Wed, 14 Nov 2018 06:04:38 -0800 (PST)
MIME-Version: 1.0
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
 <CGME20181110181155epcas2p1ac9bffb2dc7dd6337db5c37f8a87bd5e@epcas2p1.samsung.com>
 <20181110181101.24557-2-andriy.shevchenko@linux.intel.com>
 <5BE8C821.5080002@samsung.com> <5BEB63C3.1020504@samsung.com>
 <CAHp75Vfe586+tr5mUdSHv4ehmpi0KwS_m+UC0tfFHrdXwKhkig@mail.gmail.com>
 <5BEBE741.6050101@samsung.com> <20181114093652.GK10650@smile.fi.intel.com>
 <5BEBEF7C.7060003@samsung.com> <CAHp75VcJwR7S8t2jSyRvtjKCwaUA5Pu=EL3+MjCgf3SVWnChEQ@mail.gmail.com>
 <5BEC018E.8020102@samsung.com> <CAHp75Vc3NC95Wt9T2qx9SCGtwoR2hA7azGAHhqz7LO-yKz=mew@mail.gmail.com>
In-Reply-To: <CAHp75Vc3NC95Wt9T2qx9SCGtwoR2hA7azGAHhqz7LO-yKz=mew@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Nov 2018 16:04:26 +0200
Message-ID: <CAHp75VduXH0OKcD2AyR03eNrWW8bKGL-ijfQocfQ+MDCAq0yag@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] extcon: Return -EPROBE_DEFER when extcon device is
 not found
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        USB <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        rogerq@ti.com, Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 1:17 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Nov 14, 2018 at 1:05 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:

> > > Changing NULL to -ENODEV is a trading bad to worse.

> P.S. I still disagree with your arguments in relation to de facto use of an API.

I spoke to colleagues of mine and they are agree that semantically
-EPROBE_DEFER is a wrong error code from API that matches against some
list.
On the other hand, they agree with me that changing NULL to -ENODEV is
a trading bad to worse.

So, I withdraw mine complaints against API.

-- 
With Best Regards,
Andy Shevchenko
