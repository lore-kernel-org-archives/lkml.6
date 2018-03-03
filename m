Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeCCPor (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 10:44:47 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38246 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeCCPop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 10:44:45 -0500
X-Google-Smtp-Source: AG47ELunLvamZ7ou/nNoBnQLpuzrkvPHphTz/phIiqi9D+sN43bCdFQr59GMMawDLk9kRnM1sr0YXozNvDpQPwvsCgw=
MIME-Version: 1.0
In-Reply-To: <20180303153723.40773aae@archlinux>
References: <20180228001525.96044-1-delroth@google.com> <CAHp75VfEaaJfREj5jBk7uwr2aRL96JN4Co=tir9Foy6L9=_o8A@mail.gmail.com>
 <20180303153723.40773aae@archlinux>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 3 Mar 2018 17:44:44 +0200
Message-ID: <CAHp75VeEXdUMw2Skr=jDjUL+Rz=Xu-0S3Mw-X6MvjAXet974hw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: light: add driver for bh1730fvc chips
To: Jonathan Cameron <jic23@kernel.org>
Cc: Pierre Bourdon <delroth@google.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 3, 2018 at 5:37 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Wed, 28 Feb 2018 17:06:09 +0200
>> On Wed, Feb 28, 2018 at 2:15 AM, Pierre Bourdon <delroth@google.com> wrote:

Better to address even minors before submission.

>> > +       if (itime <= 0 || itime > 255)
>>
>> Just side note: Suprisingly how many in_range() implementations we
>> have in kernel...
> I guess one of those things that is so simple it's not worth having
> one true in_range to rule them all ;)

We have already several implementations of the macro.

>> > +static int bh1730_adjust_gain(struct bh1730_data *bh1730)
>> > +{
>> > +       int visible, ir, highest, gain, ret, i;
>>
>> int visible, ir, highest, gain;
>> unsigned int i;
>
> Is there a strong reason for this one that I'm missing?
> (beyond personal taste!)

First of all, I'm far from being fan of mixing int ret into other
variable definitions.

unsigned int i OTOH shows explicitly that we have counter which is not
supposed to be negative.

int i in most of the cases will work, so, it's a minor. I'm not
insisting, though having counter variable on separate line is also a
good thing.

In general, having different things in one line is a bad idea for my opinion.

>> int ret;

-- 
With Best Regards,
Andy Shevchenko
