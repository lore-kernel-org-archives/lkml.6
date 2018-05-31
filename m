Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753963AbeEaG3W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 02:29:22 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38656 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753760AbeEaG3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 02:29:19 -0400
X-Google-Smtp-Source: ADUXVKIWEp9LBgQcdWfVKUry54mHA/MCuzhJXzbrkTs06/t3hv3UHCWO3lYOX33vWYl5WgsbjUV3H+WN5FoRR12rO48=
MIME-Version: 1.0
In-Reply-To: <58c1059a91b93a490a7fc8bda2112e67e6513840.camel@kernel.crashing.org>
References: <1527714464-8642-1-git-send-email-eajames@linux.vnet.ibm.com>
 <CAHp75VerhOMCTPGz5b8wUNL611AdT1iutRm-wrHfzzT+_GbvWA@mail.gmail.com> <58c1059a91b93a490a7fc8bda2112e67e6513840.camel@kernel.crashing.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 31 May 2018 09:29:18 +0300
Message-ID: <CAHp75Vec+KZCkjcs3qpB=qLmaTon=yTLyu7S_tDrMGcobHW5eQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] i2c: Add FSI-attached I2C master algorithm
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Eddie James <eajames@linux.vnet.ibm.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 1:42 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2018-05-31 at 00:31 +0300, Andy Shevchenko wrote:
>> On Thu, May 31, 2018 at 12:07 AM, Eddie James
>> <eajames@linux.vnet.ibm.com> wrote:

>> I'll comment the series later, though you have to address previous
>> comments first:
>> - understand devm_ purpose and how it works
>
> I think it is perfectly understood and I don't see what your problem
> here is. So please be a proper civil human being an express your
> concern precisely rather than with aggressive comments.

I apologize for this kind of tone, let's assume it was a bad day.

> Now to clarify that specific point, devm purpose is to automatically
> clean up the resources used by the device when it is torn down.
>
> However, in this specific case, it makes sense to dispose of the port
> structure explicitly because this is a failure in registering an
> individual port which doesn't lead to a failure of the entire driver.
>
> Thus not freeing it means the structure would remain allocated
> uselessly until the whole driver is torn down.

Yep, so, why do we care? If it holds few hundreds of bytes, can't we
live with it?
If no, the devm_k*alloc() is a wrong choice in the first place.

>> - discuss with maintainer a design of enumerating ports
>
> I've been at that game for at least a good 2 decades. Maintainers
> generally do *not* discuss design until a patch is proposed. I even
> still try every now and then, maintainers are like lawyers, they don't
> want to tell you what to do in case they still want to reject it after
> seeing it later :-) I know I've been one of them for long enough.
>
> If you have specific issues with how this is done, please express them
> clearly. It's quite possible that there's some better way to do what
> Eddie is doing here, but without *construtive* feedback this is
> pointless.

It feels like you duplicate approach which is done in OF generic case.
That is my concern. Though, if Wolfram is telling that is OK, I have
no objections.

> I'm disappointed here because we have an example of somebody rather new
> producing what is overall pretty damn good code,

That is true. His code much better than many I have seen before.

> despite a few corner
> issues, and being (again) treated like crap.

Sorry for that, life is harsh.

> This isn't the right way to operate, and I believe this has been made
> clear many times before.

Yes.

-- 
With Best Regards,
Andy Shevchenko
