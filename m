Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753890AbeD3Kfu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:35:50 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:38601 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753744AbeD3Kfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:35:46 -0400
X-Google-Smtp-Source: AB8JxZq+4x/sNuh10rRxKXdOje66hA3uYMwuoON9n68RJMoegWw/SXm5ckrncBd5/1HXK3qjExu9S3iiBUvIedeMe84=
MIME-Version: 1.0
In-Reply-To: <12218300.6oQjICIiUq@ferry-quad>
References: <9023506.UBh6vynRGa@delfion> <1524470676.5451.1.camel@gmx.de>
 <20180425155459.5a4e40e0@alans-desktop> <12218300.6oQjICIiUq@ferry-quad>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 30 Apr 2018 12:35:25 +0200
Message-ID: <CANiq72kkGrn0fGVMB=ht48_wM4Fy=KotiHed+efB2Gf9heeM6Q@mail.gmail.com>
Subject: Re: DOS by unprivileged user
To: Ferry Toth <ftoth@telfort.nl>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Mike Galbraith <efault@gmx.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 12:00 PM, Ferry Toth <ftoth@telfort.nl> wrote:
> Op woensdag 25 april 2018 16:54:59 CEST schreef Alan Cox:
>> > > I think memory allocation and io waits can't be decoupled from
>> > > scheduling as they are now.
>> >
>> > The scheduler is not decoupled from either, it is intimately involved
>> > in both.  However, none of the decision making smarts for either reside
>> > in the scheduler, nor should they.
>>
>> It belongs in both.
>>
>> Classical Unix systems never had this problem because they respond to
>> thrashing by ensuring that all processes consumed CPU and made some
>> progress. Linux handles it by thrashing itself to dealth while BSD always
>> handled it by moving from paging more towards swapping and behaving like
>> a swap bound batch machine.
>>
>> Linux thrashes itself to death, the classic BSD algorithn instead throws
>> fairness out of the window under extreme load to prevent it. It might take
>> a few seconds but at least you will get your prompt back.
>>
>> Alan
>>
> I haven t tried BSD.
>
> But when I was young I allocated 10MB on a HP9000 (UX) with 1MB of RAM. People wanted to launch me out of the window (18th floor).
>
> I did not want to say Unix was better, only with so much emphasis on security I' m surprised how easy it is for a regular user to bring linux to on it s knees.

While it is true that things can be improved/tweaked for typical
desktop/single user usage; this isn't really a security issue. For
shared systems, there are a few ways to soft/hard limit resources:
nice, *limit, cgroups, systemd limits, containers/VMs...

Cheers,
Miguel
