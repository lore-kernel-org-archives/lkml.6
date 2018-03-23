Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeCWDLm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 23:11:42 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:36695 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbeCWDLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 23:11:38 -0400
X-Google-Smtp-Source: AG47ELuToqkhPsDjgzwMkJGXKpNDO6ntlikIVT9UY0uovhuPi01Xv3DXd+iF7YCu7kKtYGnoZcwgrZ9X1sI1ttgFndo=
MIME-Version: 1.0
In-Reply-To: <20180307161226.vweofwcvy6nvux5p@localhost.localdomain>
References: <20180228155306.1006-1-rf@opensource.cirrus.com>
 <CACRpkdYc1Ovvhwze37-uJJL+5YG5kHuW9rgDSbfhxLRP30aPWg@mail.gmail.com> <20180307161226.vweofwcvy6nvux5p@localhost.localdomain>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Mar 2018 04:11:37 +0100
Message-ID: <CACRpkdbMnPRXpr48WWVV58y5-wkMUsHzBua4Lyj9wh+r+YbVtA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: devicetree: Fix dt_to_map_one_config handling of hogs
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 5:12 PM, Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Fri, Mar 02, 2018 at 09:42:54AM +0100, Linus Walleij wrote:
>> On Wed, Feb 28, 2018 at 4:53 PM, Richard Fitzgerald
>> <rf@opensource.cirrus.com> wrote:
>>
>> > When dt_to_map_one_config() is called with a pinctrl_dev passed
>> > in, it should only be using this if the node being looked up
>> > is a hog. The code was always using the passed pinctrl_dev
>> > without checking whether the dt node referred to it.
>> >
>> > A pin controller can have pinctrl-n dependencies on other pin
>> > controllers in these cases:
>> >
>> > - the pin controller hardware is external, for example I2C, so
>> >   needs other pin controller(s) to be setup to communicate with
>> >   the hardware device.
>> >
>> > - it is a child of a composite MFD so its of_node is shared with
>> >   the parent MFD and other children of that MFD. Any part of that
>> >   MFD could have dependencies on other pin controllers.
>> >
>> > Because of this, dt_to_map_one_config() can't assume that if it
>> > has a pinctrl_dev passed in then the node it looks up must be
>> > a hog. It could be a reference to some other pin controller.
>> >
>> > Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>>
>> Seems correct. Also the code is a little more clear
>> after the patch.
>>
>> Patch applied.
>>
>> It'd be nice to see some testing of this, I hope linux-next is a good
>> testing ground.
>>
>
> Once we are happy on the testing front, how would you feel about
> getting this forwarded to 4.14 stable as well?

Sadly too late for me to tag as stable, but you can suggest to
Greg to pick it up for stable individually after v4.17-rc1.

Yours,
Linus Walleij
