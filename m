Return-Path: <Paul.Gortmaker@windriver.com>
X-Google-Smtp-Source: AH8x224SvjOn+CcWItE6dc2spZrRFREB47rZKEjcgMhwKRC803usMR4i5k+pVjJN7XIl+8/QSE0y
ARC-Seal: i=1; a=rsa-sha256; t=1517857735; cv=none;
        d=google.com; s=arc-20160816;
        b=q3jEO0kh1roykU3ZwGTBY4i+fguCUn2i34XsNc2C94/IBr4ZJgYtqJGjgqRka0LZzT
         KoxBk3FuyjVVamlkmxVCNG3bvgear4y48HzTZ3okI+UQPzoz4eLFEM3ViNlhZtDL3enj
         mxdQoihRI04m6VVgFA6I67jfSmnbB8I3mloIDD6CBZ1nH9ALOzctoJYJ7jhSCEpzLJPQ
         H3Y4c1Ea3+MShD0Oiix/h078SseXmcX17p+/JdoNKxmRA6badzLDdULW1A7z/CTTdKUS
         4RRqjpvspbBnm9f9vu8JexPxm/Shl8pgMlzHrZX6ZoDqw3jdCgbxI+KF6Z7OAZ5lkP+R
         Xe8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=WjPfWbCyK6qCERdTlkjPhFOYvKbDDnkcGOnyLZbsdxM=;
        b=IwZ50FyL90OkYFsYNZMp94c9MiedG+OooKEjcozw8NbBLzllOTbklyJSiUwhDA7sHr
         jvCLFPs1SHKfAxlac9VOCEE/rDXGaaU1XUpDkcUH4KPtszfL5xaT3wdD/JQVIFNRR/bJ
         VBjd0KZrB1LTASxf31zC00/FYRIV+WX7lYW/Z+DybaTn//TcEy5jbTOrdZoIzoFgAX0F
         3iRefBxZHA5UAvVkVMTMw7xM5NbrvUP/Uc1Vql959xTWP81a0JAKvGzzAmwjJ9PPqj+5
         ujPcN0+Fh+9jRJijNyABMM/YOHStqQqYYYAPO2c1iETLZ6/Lonpz4AQztxZg9dTbSxd5
         zSlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of paul.gortmaker@windriver.com designates 147.11.1.11 as permitted sender) smtp.mailfrom=Paul.Gortmaker@windriver.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of paul.gortmaker@windriver.com designates 147.11.1.11 as permitted sender) smtp.mailfrom=Paul.Gortmaker@windriver.com
Date: Mon, 5 Feb 2018 14:08:51 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Julia Lawall <julia.lawall@lip6.fr>
CC: Linus Walleij <linus.walleij@linaro.org>,
        Linus Torvalds
	<torvalds@linux-foundation.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel
	<linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
Subject: Re: [GIT PULL] pin control bulk changes for v4.16
Message-ID: <20180205190851.GD20138@windriver.com>
References: <CACRpkdaTv4NBrRXeJE6dVi4W88+LZdsTCSzTHi0vdcKMW3Qfmw@mail.gmail.com>
 <CA+55aFzMBptQt-QHMR0MM9MA3=1rxcf8ca5qHxrf4Mm0ZobE_A@mail.gmail.com>
 <CA+55aFztiKehjo7OQQFboAEfe_BrxJQG_5wxak2a_GdNBEFiMw@mail.gmail.com>
 <CA+55aFzhp2QW9JeMwV6=W4skf0CW6E+Zg4K90n3Bo+yZmz485Q@mail.gmail.com>
 <CACRpkdZGABVtdF1HWHfx-5JPyaEhtt+Q_sjM=bkJu6cZ5WfPCA@mail.gmail.com>
 <alpine.DEB.2.20.1802051023540.3292@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1802051023540.3292@hadrien>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591331743286572652?=
X-GMAIL-MSGID: =?utf-8?q?1591589192683180516?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[Re: [GIT PULL] pin control bulk changes for v4.16] On 05/02/2018 (Mon 10:27) Julia Lawall wrote:

> 
> 
> On Mon, 5 Feb 2018, Linus Walleij wrote:
> 

[...]

> >
> > Another thing that comes to mind was Paul Gortmaker's tedious
> > work to remove #include <linux/module.h> from drivers that cannot
> > be built as modules that happened in the last few months. 

I also took aim at headers including giant headers ; see below.

[...]

> Could you explain more?  Is the point that you want to remove an include
> but it has one declaration that you need, and so you want to bring it down
> into the .c file?  Would the need for that actually indicate that the
> include file is designed incorrectly?

I put a bit of an explanation in this commit:

commit d47529b2e9fe0ec2eb1f072afad8849f52e385c4
Author: Paul Gortmaker <paul.gortmaker@windriver.com>
Date:   Mon Sep 12 18:16:31 2016 -0400

    gpio: don't include module.h in shared driver header
    
    Most shared headers in include/linux don't need to know what the
    internals of a struct module are; all they care about is that it
    is a struct and hence they may require a pointer to one.
    
    The advantage in this is that module.h is including a lot of stuff
    itself, and an otherwise empty C file that just contains module.h
    will result in ~750kB from CPP (compared to say 12kB from init.h)
    
    So we have approximately 50 instances of "struct module;" in the
    various include/linux headers already that help us keep module.h
    out of other headers; here we do the same for gpio.
    
    Cc: Linus Walleij <linus.walleij@linaro.org>
    Cc: Alexandre Courbot <gnurou@gmail.com>
    Cc: linux-gpio@vger.kernel.org
    Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I'm sure I've got more of these type of commits sitting around locally,
unfortunately there have been other "interesting" things going on in the
linux world in the last month that have prevented me from touching any
of them.  :-/

Paul.
--

> 
> Can one assume that each include is self contained, ie it includes the
> things that it needs and does not rely on the .c file having included
> other things beforehand?
> 
> julia
