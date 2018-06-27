Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ED5C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB7D26121
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtYfmSBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB7D26121
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934620AbeF0OHs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:07:48 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37618 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932166AbeF0OHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:07:47 -0400
Received: by mail-qt0-f196.google.com with SMTP id a18-v6so1722584qtj.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rWTQjNvS791iWama/x9hMeH4H+lYjTDjKhaGglliqxI=;
        b=FtYfmSBHSstQlklOnjbeCySD88I2g2NQqddE0k8IcavtlstzhI9OTHuwir4jZ7xy0I
         nqKV0dnvWX9w1OBuuIpxTiQWcpu43Uv/BwNug0n/ERDY/QU443BdY9nQxvKd5//R8c+V
         q87imd5qLXjaReD00hCYQ93rvswHIjlr6zFz5aT9NpWlsFWtunnI2d3VMeUl0jQrJx0D
         5iETbXZHeaQFUT/y4LhFAqedFG5uTvgohYixymNjjaJ19EceYhEoVDmeUKEgqNAkuQNp
         FNniQRaHpqOsn/Fw6dUh0O0daHe52vXf1AsHPprw4Cs8drP528LrOgF2R9ETQ3ivzWGE
         iIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rWTQjNvS791iWama/x9hMeH4H+lYjTDjKhaGglliqxI=;
        b=IHUWXKabMea2rXxxqV0djX0t+ZmqYtr6ecALf56NXTzMGIaSa22+eh4yyMA3UdRXck
         1vQt0BzGRDp+X63HjdBU9t2mpfJ2jWBz3DnZgQ4oZqYBvo5a73cmxehoiAZe5Ny+Mr3+
         W53w0XwIVYYC39nEnEw1bEWM9Isk7d+qgCYElQt4O9++fxY16NRl/uBxjD8UI8q/B2/b
         0KFd9j1RWRYRf1bSuXj0L4RwAICBn9dvkYGuZXBAb+u9mYpw8PfqGiKHffH+Yix1irAA
         PxT6GLTAit4y5rV99RkbeogopofnsIhIBpB0T7LG5UeMLgjCrBvqReQt4KETTZENRb5V
         oo2A==
X-Gm-Message-State: APt69E2Hh92tbBk1kH9oAibhOKkWry7lrHvQYg3WY6FoPSZBaO7sX2vQ
        r3pIqfsRfdRrwyUFY9jVufYsK2LqiAqh5hQrly8=
X-Google-Smtp-Source: AAOMgpdMO3/sStAO1NcRiLFLEK5U4Z5DU4Dnc+dkOf2/fPo9ycPTwtXN98d8CXHDAAHkh3bKjutv1fLRqc2xuMvFPMk=
X-Received: by 2002:a0c:af67:: with SMTP id j36-v6mr5515997qvc.194.1530108466379;
 Wed, 27 Jun 2018 07:07:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:4716:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 07:07:25
 -0700 (PDT)
In-Reply-To: <20180626193325.GA5356@mellanox.com>
References: <20180625224430.GA31554@ziepe.ca> <CANiq72mcwTkmEo+CnJ2P33TrTHgXaJEpjuxQjwGx5RTXjDyvhA@mail.gmail.com>
 <20180626193325.GA5356@mellanox.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 27 Jun 2018 16:07:25 +0200
Message-ID: <CANiq72m2=QprgcgD_dZKwSyAqZ0e2JdL+eDjq=x3O6PZqPPcMg@mail.gmail.com>
Subject: Re: [PATCH RESEND] clang-format: Set IndentWrappedFunctionNames false
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 9:33 PM, Jason Gunthorpe <jgg@mellanox.com> wrote:
> On Tue, Jun 26, 2018 at 05:05:40PM +0200, Miguel Ojeda wrote:
>> Hi,
>>
>> On Tue, Jun 26, 2018 at 12:44 AM, Jason Gunthorpe <jgg@mellanox.com> wrote:
>> > The true option causes this indenting for functions:
>> >
>> > static struct something_very_very_long *
>> >     function(void *arg)
>> > {
>> >
>> > While a quick survey suggests that the usual Linux fallback is the GNU
>> > style:
>> >
>> > static struct something_very_very_long *
>> > function(void *arg)
>> > {
>> >
>> > Eg as seen in:
>> >
>> > kernel/cpu.c
>> > kernel/fork.c
>> > etc
>> >
>> > Acked-by: Joe Perches <joe@perches.com>
>> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>> >  .clang-format | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > Resending outside the merge window with no change..
>> >
>> > If there is no clear upstream path for this file (it has no
>> > MAINTAINERS entry?) I could take it to Linus via the rdma.git tree, eg
>>
>> We can add an specific entry, yeah. Is there any policy for "general
>> files" (or some general/catch-all entry)?
>>
>> > as a 'collectively maintained' file.
>>
>> As you prefer -- I can also pick it up through auxdisplay; but I am
>> not sure if we should put it in any "unrelated" tree, though. (Since
>> the file will not probably receive many patches, I originally thought
>> that it would be picked up by Andrew or some other "general" tree
>> instead.)
>
> Well, I'd rather you take it as the owner of the file, honestly :)
> Along with a MAINTAINERS update...

OK -- I will send the MAINTAINERS update patch :)

>
> I also don't know too well what the policy is for these sorts of files
> - other catch all files like kernel.h I run through rdma.git from time
> to time, but that is in relation to patches that depend on them..
>
>> > Would prefer Miguel's Ack to do that though. Looks like Andrew Morton
>> > took the original patch introducing the file?
>>
>> Yep, I sent it to Andrew and he kindly picked it up. Probably he
>> didn't notice this one.
>>
>> As for the patch:
>>
>> Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>
> Lets give Andrew some time, he is probably very busy. If it gets to
> rc5 without it getting picked up one of us can grab it instead to help
> out..

Sure! :)

(and thanks!)

Cheers,
Miguel

>
> Thanks,
> Jason
