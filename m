Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeCNUQo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:16:44 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37451 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbeCNUQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:16:43 -0400
X-Google-Smtp-Source: AG47ELuCs2pE4mx9fVBWhcEsMhQd7R7RLzsbrL/ZGsn6vG/EcEvKwB4o85IJwjrPjze3iZPZzhgcB9WYiF3Ahu5H1mU=
MIME-Version: 1.0
In-Reply-To: <1521057831.18703.101.camel@redhat.com>
References: <20180220205638.1959033-1-arnd@arndb.de> <20180228211514.GC13394@ziepe.ca>
 <CAK8P3a2dsQ7QAb64DCp9Fc2xXjEyHNjBFdRc=y6FanQKsXhADg@mail.gmail.com>
 <20180306234539.GB1037@ziepe.ca> <CAK8P3a0mHEm8m8=CfV5Qmw0EcVCc31OetdFXHQ0KEvWk6K40Gw@mail.gmail.com>
 <CAK8P3a2cqjQzhaPwk9rE6=s4QQVFk8vAoYQfqSrh1nOi-KpZew@mail.gmail.com>
 <CAK8P3a2SS4RBwjrd2XCnpA8W_bmHtjdjWdX1RTnkou0OQ5ROdA@mail.gmail.com> <1521057831.18703.101.camel@redhat.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 21:16:41 +0100
X-Google-Sender-Auth: eawA7_yCRKkUfKOQ8fnonQlBDzQ
Message-ID: <CAK8P3a1=h7cF8kRUWpFG88-OSFL8_7SgUkaX4TUEhG6ypPODkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] infiniband: qplib_fp: fix pointer cast
To: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Eddie Wai <eddie.wai@broadcom.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 9:03 PM, Doug Ledford <dledford@redhat.com> wrote:
> On Tue, 2018-03-13 at 09:50 +0100, Arnd Bergmann wrote:
>> On Wed, Mar 7, 2018 at 11:12 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Wed, Mar 7, 2018 at 10:05 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> >
>> > > A small complication is that I wrote the changelog for the build warning
>> > > on 32-bit architectures, which is more elaborate. kernelci.org for
>> > > some reasons currently skips the allmodconfig build on all 32-bit
>> > > architectures (I should ask the kernelci maintainers to change that),
>> >
>> > I see that Olof's build bot does have build results for arm32
>> > allmodconfig, which is also big-endian, and reports the same
>> > errors that I described in the patch changelog.
>> >
>> > See
>> >
>> > http://arm-soc.lixom.net/buildlogs/arm-soc/v4.16-rc4-25-g41c42fe/
>> > http://arm-soc.lixom.net/buildlogs/arm-soc/v4.16-rc4-25-g41c42fe/buildall.arm.allmodconfig.log.passed
>> >
>> > for today's results.
>> >
>> > This bot reports one other warning for arm32, but it's
>> > specific to the toolchain version used on that bot.
>> > I have a fix for that one as well, but there was some
>> > discussion on what the best approach would be.
>>
>> Any update on this? This is now the only remaining gcc warning we get on
>> allmodconfig builds for arm (both 32-bit and 64-bit) in linux-4.16-rc.
>>
>
> Do you need the full series to fix this (it looked that way to me)?

I just double-checked, as I thought only the first one was needed, but
indeed we do need both.

       Arnd
