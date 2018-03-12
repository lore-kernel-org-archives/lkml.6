Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520863860; cv=none;
        d=google.com; s=arc-20160816;
        b=dzbr77RpIirRGYDksRRtLNKL/3cbmOULRHdN4dLXLf44Cg91qOEsjgfvGOtrsAOiCF
         oB+VlA0Lp4WZ/tQ2z23lvVsUeswDqeSU88lDGnrHgqv7WE2cJ/q5RLeB24OjnBXwXP8u
         007+OPzelbPWVFDTVF0L7Wn1f2ottNRvsV25P6Ftv5L5Hv9lzOOu2OD5kFUHKaV+pLWY
         vDTlCWRNu7CQlghlUNjC7aheDpt9aizuhQO/W7kog25cj6loNZ+TY9DPhpM0MsM4+mm5
         UwHoPd0DDynJ1z463O6lJ0bQXtSLdvsHwEJkoNLiPkRC4cMXW77CqWQmY8DbGmO3ehm4
         WqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=94Mm6Y5kWmEAvB8vATFGHHsti3PErvNsKRDyyQXcJuA=;
        b=vMtyJnZOsCHcEgx6R/iH33zxTaod/9DXBHyK/zi/LIh/0Zuw4zlbIR7ZT1Xgq4TiSE
         EvkH0BS+ksVtDipScv+H8XrPYd+V9y9r1iJWnKgf0I99v41bpCTOG28e640cudj/scER
         Kw6z+WNej3A4eUndb4UG1ZRr5E4Ajvj/jR9CdObghWChfMQ8hMT7KzQGG/dG4iiELfJc
         Q/cJAjDH/nkbHsT2SOAr9jS+MdIYR9ERFR7YCe4OAeGJkILYhKc/5N1VkF8yPSbb5//L
         13rYvWvfARhDfyaFQE065Os/Wf9atCsFvuJ3X4iD2cJsUp1p6NwzGGpCQpciav8zZeih
         8E4g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BNQNpUac;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BNQNpUac;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtszE1pZic/7DplttPF5m+TRf8V+LOWHrztcvdi5lRSfK5ozKdGewILPwlgzCCm6OEB/StwIEFuMoI0GaKvJt4=
MIME-Version: 1.0
In-Reply-To: <20180303210019.GA16495@sudip-laptop>
References: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
 <CAHp75VdAEEjycTvxb=KLOsBESRfSjio1uDXfY=gR91TxCCOkVg@mail.gmail.com>
 <20180301120609.GA31656@kroah.com> <20180303210019.GA16495@sudip-laptop>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 12 Mar 2018 16:10:59 +0200
Message-ID: <CAHp75VfCMR7v8VcP3hednbQ+CqhUHU8e+r-e=uS9aR8pOqSXLQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] parport: ax88796: Delete an error message for a
 failed memory allocation in parport_ax88796_probe()
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591772848657448336?=
X-GMAIL-MSGID: =?utf-8?q?1594741343145399672?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 3, 2018 at 11:00 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> Hi Greg,
>
> On Thu, Mar 01, 2018 at 01:06:09PM +0100, Greg Kroah-Hartman wrote:
>> On Thu, Mar 01, 2018 at 12:46:07PM +0200, Andy Shevchenko wrote:
>> > On Wed, Feb 7, 2018 at 9:47 PM, Sudip Mukherjee
>> > <sudipm.mukherjee@gmail.com> wrote:
>> > > From: Markus Elfring <elfring@users.sourceforge.net>
>> > >
>> > > Omit an extra message for a memory allocation failure in this function.
>> > >
>> > > This issue was detected by using the Coccinelle software.
>> > >
>> >
>> > Greg, just to be sure this series is under your scope.
>> > IIRC it had been sent during merge window, though it looks like your
>> > tty tree doesn't include it yet, while even older patches, which were
>> > sent as well during merge window, made it
>>
>> It's in my large "to-review" queue...
>>
>> Personally, stuff like this, from this specific developer, ends up at
>> the bottom of that list as well...
>
> do you want me to reorganize the series and resend?
> I can send patches 1 - 3 later.

Greg, this series contains patches from two developers, the patches
starting from #4 is more important since they are enabling BrainBox
multi I/O cards while cleaning up the partport_serial driver itself.
I understand you have a long queue, but would we have a chance to get
into v4.17 with these?

-- 
With Best Regards,
Andy Shevchenko
