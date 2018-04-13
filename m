Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeDMQC1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:02:27 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:46317 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeDMQCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:02:25 -0400
X-Google-Smtp-Source: AIpwx4/1yBadeXK0Gv6sNoaYKJmxcHltLoKnVHW4N63Ws05Mevbzq9TyGHyBHW+Mxiz8avAxXN6dt/Pfd1mZ7Q1VTcg=
MIME-Version: 1.0
In-Reply-To: <20180413141359.793919fb@endymion>
References: <20180412213342.138010-1-hansens@google.com> <20180412222457.x4jdwt27ylgi74o3@katana>
 <20180413141359.793919fb@endymion>
From: Sam Hansen <hansens@google.com>
Date: Fri, 13 Apr 2018 09:02:03 -0700
Message-ID: <CAP9bUy7rONNHYeRkYtaWHcfqoZcGKXJz-JocED26zBj9n+-ZbQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/i2c: sync docs with current state of i2c-tools.
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 5:13 AM, Jean Delvare <jdelvare@suse.de> wrote:
> Hi Wolfram, Sam,
>
> On Fri, 13 Apr 2018 00:24:57 +0200, Wolfram Sang wrote:
>> On Thu, Apr 12, 2018 at 02:33:42PM -0700, Sam Hansen wrote:
>> > Currently, Documentation/i2c/dev-interface describes the use of i2c_smbus_*
>> > helper routines as static inlined functions provided by linux/i2c-dev.h.  Work
>> > has been done to refactor the linux/i2c-dev.h file in the i2c-tools project
>> > out into its own library.  As a result, these docs have become stale.
>>
>> Thanks for fixing this!
>>
>> > This patch corrects the discrepancy and directs the reader to the i2c-tools
>> > project for more information.  Additionally, some trailing-whitespace cleanups
>> > were made.
>>
>> Minor nit: Having the whitespace changes in a seperate patch is a tad
>> easier to review.
>>
>> > -  /* Using I2C Write, equivalent of
>> > +  /* Using I2C Write, equivalent of
>> >       i2c_smbus_write_word_data(file, reg, 0x6543) */
>>
>> Maybe change to Kernel coding style comments while here?
>>
>> > -  Not meant to be called  directly; instead, use the access functions
>> > -  below.
>> > +  If possible, use the provided i2c_smbus_* methods described below in favor
>> > +  of issuing direct ioctls.
>>
>> Why this change?
>
> I'm also not sure if "in favor of" is right. "instead of" would sound
> better to me, but I'm no native English speaker, I could be wrong.

Sounds good, I'll adopt "instead of".  Regarding Wolfram's earlier
comment, as an engineer, requiring an out-of-tree library to build
drivers felt a little off.  I can revert this section if you want,
just let me know.

>
>> > -The above functions are all inline functions, that resolve to calls to
>> > -the i2c_smbus_access function, that on its turn calls a specific ioctl
>> > -with the data in a specific format. Read the source code if you
>> > -want to know what happens behind the screens.
>> > +The above functions are made available by linking against the libi2c library,
>> > +which is provided by the i2c-tools project.  See:
>> > +https://git.kernel.org/pub/scm/utils/i2c-tools/i2c-tools.git/.
>>
>> This is fine with me. Maybe Jean has a comment on this?
>
> Fixing the documentation is always welcome, thanks Sam for stepping in.
> However we really want separate patches for whitespace fixes and actual
> contents change, as Wolfram already mentioned above.

Will do!  I'll send a v2 patch set, thanks.

>
> --
> Jean Delvare
> SUSE L3 Support
