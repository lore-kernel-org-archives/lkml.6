Return-Path: <kernel-hardening-return-12703-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsGxoKxozwPhNG3a+3PMJjNO4ItwO/XgyqS/AfkQASVm8N71OrW4tFXpZ6myhZ1ZRLwYOHY
ARC-Seal: i=1; a=rsa-sha256; t=1521476032; cv=none;
        d=google.com; s=arc-20160816;
        b=OTR6exANBp4oT8O9SC/EQgHcT6G95ZU9oLhoLNYoHxEihMuIwoC2jO/FA0mneIfnYL
         8z9tcG+3DOy/p+WXaoG0MPTun7Sdcn4bG7pRjvK+pY8mA9YA9Ucu/UU22ENTT35rhn67
         bWTbC4+PY+mW9Ts3UIBFOhsojwnL+Mwa3IcOQeyYhma4asUGGq0YriXpBCSb06EZGxqd
         og+5uMcrxBTlkugNpawUj30nCWwf4NFSx4e5NYygo01PIvPN8eNKrbiQe0oXiLfYE/JT
         Uqc2AuttBQWD1c52ay8Iq8Mbg06teu9nJQ9v5cXz7AmRdUIs1vCbx1SCy6sLcLEPSkMQ
         wjuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=njddE9dl6aidpVBJwAVABGrAq+/l4ifrwU1WMTFlm/k=;
        b=IeiFG9MJtKJd9hbK3y5y/fZbs1/77XuY0dBL0giYpABlnqBn+qX/TDHvAut2YjJwoX
         gczywKj/lEWwjJWYehEObz5I+ArtZjUhg0UmadbqezntZGYY50Ih0DN7rSBlM7a76gN+
         q4rsdCIYnoO0+0AVsnDQE2v2oLUESk6+jKoHZsehp3JZp3lyIFgaUzL+o+/LYSMZOJyn
         EQRdCFHXXAS4Du8hARRKTXpuZMIxZZD4ssr667vuv8h5mPJbNWTMuJX9h8pCPavw7m0e
         SI9mTsCrburQzGXZTBDh+VTVbG7Hp40o7t4rfnV04NAeYEDpJJ/1QuMVQIqgEVm207FB
         QNJg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PtyhQCKF;
       spf=pass (google.com: domain of kernel-hardening-return-12703-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12703-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PtyhQCKF;
       spf=pass (google.com: domain of kernel-hardening-return-12703-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12703-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180319070043.GA25474@wunner.de>
References: <20180310001021.6437-1-labbott@redhat.com> <20180310001021.6437-2-labbott@redhat.com>
 <a758ce3f-fed7-2ecf-94c5-ba133ea75bde@rasmusvillemoes.dk> <20180317082509.GA2579@wunner.de>
 <20180318142327.GA23761@wunner.de> <0f17eb05-c183-bec9-0076-5ddd00d70f15@rasmusvillemoes.dk>
 <20180319070043.GA25474@wunner.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 19 Mar 2018 17:09:54 +0200
Message-ID: <CAHp75VeJ5WQeEFaoExCCrFBuuKUX+17vC5JOdMW8V4KNvniT-Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpio: Remove VLA from gpiolib
To: Lukas Wunner <lukas@wunner.de>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Laura Abbott <labbott@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>, Kees Cook <keescook@chromium.org>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-hardening@lists.openwall.com,
	Mathias Duckeck <m.duckeck@kunbus.de>, Nandor Han <nandor.han@ge.com>,
	Semi Malinen <semi.malinen@ge.com>, Patrice Chotard <patrice.chotard@st.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507304079648871?=
X-GMAIL-MSGID: =?utf-8?q?1595383251932236562?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 9:00 AM, Lukas Wunner <lukas@wunner.de> wrote:
> On Sun, Mar 18, 2018 at 09:34:12PM +0100, Rasmus Villemoes wrote:
>> On 2018-03-18 15:23, Lukas Wunner wrote:

>> > Actually, scratch that.  If ngpio is usually smallish, we can just
>> > allocate reasonably sized space for mask and bits on the stack,
>> > and fall back to the kcalloc slowpath only if chip->ngpio exceeds
>> > that limit.

>> Well, I'd suggest not adding that fallback code now, but simply add a
>> check in gpiochip_add_data_with_key to ensure ngpio is sane (and refuse
>> to register the chip otherwise), at least if we know that every
>> currently supported/known chip is covered by the 256 (?).
>
> The number 256 was arbitrarily chosen.  I really wouldn't be surprised
> if gpiochips with more pins exist, but they're probably rare, so using
> the slowpath seems fine, but dropping support for them completely would
> be a regression.

All modern Intel SoCs have GPIO count in between of ~230-380.
Though, few of them are split to communities by (much) less than 256
pin in each when there is a 1:1 mapping between community and
gpiochip.

OTOH, the function you are fixing is most likely is not used together
with the drivers for x86.

-- 
With Best Regards,
Andy Shevchenko
