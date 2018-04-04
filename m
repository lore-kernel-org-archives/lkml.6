Return-Path: <kernel-hardening-return-12848-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49kBOYd9r5MpfgsiWAZwYyIzSwK1s/vxGJ4h4e5Vurb4ipinN/P1igTILuRobyu66X5DZzv
ARC-Seal: i=1; a=rsa-sha256; t=1522846444; cv=none;
        d=google.com; s=arc-20160816;
        b=XMiD2HLD9WtSMVhBppEvkQAnum3KxIl1wLCTylWygb8P8snzJ9dA9q8SzL8mzlRRD3
         pzz28BCgNHPXabymJ6NrALHOW436IaG7V/y0peTwtP/MWK7t8vzkMUJxEIwcK6aUWphP
         Y5nKtolMX4/90b0yrMWwAzeDIZrUqxSKvYcCBqcN1M5Rui2G+kFQHl9ZwqjGKDSCJmBf
         B0E4DOYK74CMmLtR/hY+D1ShjJfw5sTFxNFhgmh/OXPiTK6K9sKuk2i5t24xoF3ljHKo
         JGypJ4/CVJv0JsNs3yuhgmZU0WHbstFhVDiQsimA0TSE0sA4P98HhLxN6NCyBqUSsJbe
         xVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=8cW3gsKXpO29gdUoCTDc9v1UX87CiTI13FQdfTWzl5Q=;
        b=FruyOaM5TbPGHTvHrfXi97SQtgaFgWkET2mKFfdRvbyOdkqlNCYv0NiIgkM5jPwBLP
         lBbw/BYNOFYfikw1ZY1gpFv0A5VQgzm5tbHXPIe9VsiOjRNlaYpFDjzJ+AKamqSwerQp
         +QJ3eav8+oOCUW3OmLpjDfA+kLE4zHDY8PyAt3QiCKc1kzV6oYY3J8qIAv2D3oky7mKm
         Nxr+0Kteb0eVHW4gWurW9sV7dV10Pywbz35mKS/oTPP9RHQ4heLhjPxAS14ILbbLxLT+
         bJ6MxRAOaltfiU6zZaArObYThIMfhsA+8O+tCn7EiEQN6Kr5wEEPdmB/+/zvwbARVbwh
         NdCA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=G/pU7Rzl;
       spf=pass (google.com: domain of kernel-hardening-return-12848-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12848-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=G/pU7Rzl;
       spf=pass (google.com: domain of kernel-hardening-return-12848-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12848-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <90ca44b5-52d0-be74-f36c-55d6f4a9bf25@redhat.com>
References: <20180310001021.6437-1-labbott@redhat.com> <20180310001021.6437-4-labbott@redhat.com>
 <CAMuHMdUfGp_rn_fMWdOfWxPvyE1Y9oemm2piXszFTvBi9sQ5Eg@mail.gmail.com> <90ca44b5-52d0-be74-f36c-55d6f4a9bf25@redhat.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 4 Apr 2018 14:53:42 +0200
Message-ID: <CACRpkdbVAr62X9FrkS5cVpfpr+vgvnwmRfy0zKM=Vo=E+LjA9Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] gpio: Remove VLA from xra1403 driver
To: Laura Abbott <labbott@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <keescook@chromium.org>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507318656304803?=
X-GMAIL-MSGID: =?utf-8?q?1596820232851642649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 7:27 PM, Laura Abbott <labbott@redhat.com> wrote:
> On 03/28/2018 12:27 AM, Geert Uytterhoeven wrote:
>>
>> Hi Laura,
>>
>> On Sat, Mar 10, 2018 at 1:10 AM, Laura Abbott <labbott@redhat.com> wrote:
>>>
>>> The new challenge is to remove VLAs from the kernel
>>> (see https://lkml.org/lkml/2018/3/7/621)
>>>
>>> This patch replaces a VLA with an appropriate call to kmalloc_array.
>>>
>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>>
>>
>> Thanks for your patch!
>>
>>> --- a/drivers/gpio/gpio-xra1403.c
>>> +++ b/drivers/gpio/gpio-xra1403.c
>>> @@ -126,11 +126,16 @@ static void xra1403_dbg_show(struct seq_file *s,
>>> struct gpio_chip *chip)
>>>   {
>>>          int reg;
>>>          struct xra1403 *xra = gpiochip_get_data(chip);
>>> -       int value[xra1403_regmap_cfg.max_register];
>>
>>
>> Apparently xra1403_regmap_cfg.max_register is always 0x15?
>>
>> What about adding
>>
>>          #define XRA_LAST 15
>>
>> at the top, and replacing both "XRA_IFR | 0x01" and
>> xra1403_regmap_cfg.max_register by XRA_LAST instead?
>> That would avoid doing yet another memory allocation over and over.
>>
>> Gr{oetje,eeting}s,
>>
>>                          Geert
>>
>
> I'm okay with making the change but I think Linus already picked
> up the patch into his gpio trees. Linus, do you want a patch on
> top of your -devel branch or should I just send a new patch?

Yeah a patch on top is fine, I sent my pull request to Torvalds
today so we can take this as a fix for the -rc cycle simply.

Yours,
Linus Walleij
