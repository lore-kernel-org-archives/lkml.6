Return-Path: <dmitry.torokhov@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519951448; cv=none;
        d=google.com; s=arc-20160816;
        b=qc1AzaIRGOK9kd/53RcfKdxXiwE/C9b3VsVTNBswzfgAzsODs0F4UAmyJoWvtyZUga
         hz1rPjUqE4EqwQEWjZFBAuwCtdKuVjNYd8ov4OucU4UWQ2nLoeo7ZGMqXa52TVSHC5vM
         9k927VaEYOKc1Fcj4j8kpGd4Vcw2IJIrhm3/lwm5Iph55HZxpJlCbBhxZM7He00oOAv3
         ueni4h7XARHI8EVv62eBAbeHW1f8oWkjQ1P5ip3QavjFuQBzktLmD5HtmJ3RXWKKOjHF
         4+UQYTs8SesaoF2EKSXMzUmreKOIPnjiS3mdZ8Rdhnx2ouduTvEH7IaSeAbZfrwZy7cz
         dNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=mh0q7CYSVJNBXaxelZf+xAJ6fMKTury3kKnvfGy/ffw=;
        b=08yhyQ+MzEA2i1rZukKLUwZBF1U1QITLUCId32nmqbn8GnlrvjoqdPZV/0tAqxzY2Z
         YVhqTbWkBw9LYa+n8y6oeNymQk4W5ONV+vnTUcnyx738mQ4fCpXoGC6XaKDrPiHOZKVH
         f8bd6JSkEhggFX/DIZSZxI6Mxdsb/oNLqiJhf/Wyiz28Lv/Cgc6LneA3lI+sXWh16AyM
         if4xTDR3jTG7wW1eJefFPyeeZ0XBSvrOE0oYysmvNVNO8BiAApXTUylNFo7lKQbc2PBD
         3Ro8L3Gv1vovgXrWGIVYI1ct335b9CTY8w9fd7r3QafLlHpmcYpQbapzBvE8Q0K67aGB
         l+1g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fyJT5COo;
       spf=pass (google.com: domain of dmitry.torokhov@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dmitry.torokhov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fyJT5COo;
       spf=pass (google.com: domain of dmitry.torokhov@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dmitry.torokhov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELv88krQNOTxuMnb7plCf2TIJdd4dX+l9ahWhwv8PbdZPFfvkrNRXyHxdV9ilzDd++OWECiBxg==
Date: Thu, 1 Mar 2018 16:44:04 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	gregkh <gregkh@linuxfoundation.org>,
	stephen lu <lumotuwe@gmail.com>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>,
	Joseph Lo <josephl@nvidia.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
	DTML <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3] Input: gpio_keys: Add level trigger support for GPIO
 keys
Message-ID: <20180302004404.GA242226@dtor-ws>
References: <826093167e8fb24723f474b0272f3dcab1b6a97e.1519821626.git.baolin.wang@linaro.org>
 <CAK8P3a1v2GanneaFKpXWjWLt1YzibJ9Bh7vUcd_SH-4jGN_1+A@mail.gmail.com>
 <CAMz4kuLNbsZjDPW19V96yL3DzY-bJsjRR=o+w0x4PGyxZFZ0dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMz4kuLNbsZjDPW19V96yL3DzY-bJsjRR=o+w0x4PGyxZFZ0dg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593648786277200792?=
X-GMAIL-MSGID: =?utf-8?q?1593784609929493642?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 03:35:23PM +0800, Baolin Wang wrote:
> On 28 February 2018 at 22:44, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, Feb 28, 2018 at 1:44 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
> >> On some platforms (such as Spreadtrum platform), the GPIO keys can only
> >> be triggered by level type. So this patch introduces one property to
> >> indicate if the GPIO trigger type is level trigger or edge trigger.
> >>
> >> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> >> ---
> >> Changes since v2:
> >>  - Use 'interrupt' property to indicate the irq type.
> >>
> >> Changes since v1:
> >>  - Diable the GPIO irq until reversing the GPIO level type.
> >
> > I've looked at your patch in more detail now, and given it a bit more thought.
> >
> > I wonder if you could move that logic into your gpiochip/irqchip driver instead.
> > It seems that what you do in the gpio-keys driver is to emulate edge triggered
> > behavior on a level triggered irqchip.
> >
> > If you put the same logic into the gpio driver, you could simply make it
> > pretend to support an edge trigger on both edges and call into the interrupt
> > handler whenever the state changes.
> >
> 
> That is really a good suggestion, which can avoid duplicate level
> reverse logic in different drivers. So this patch can be simplified
> just adding one trigger_type to indicate the interrupt type (not
> always edge trigger). Thanks for your suggestion.

No, there is no need to add trigger type. The gpio-keys driver expects
trigger with both edges, falling and rising. If your GPIO chip does not
support it natively, you need to emulate edge trigger via level
interrupts by reprogramming trigger from active low to active high and
back on the fly. This should be done in the gpiochip/irqchip driver.
There is no need to change gpio-keys driver.

Thanks.

-- 
Dmitry
