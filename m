Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750968AbeEaXwm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 19:52:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:57974 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750758AbeEaXwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 19:52:40 -0400
Message-ID: <5683dded80ecabef532d2e285e5fc98e29f59510.camel@kernel.crashing.org>
Subject: Re: [PATCH v8 0/7] i2c: Add FSI-attached I2C master algorithm
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Eddie James <eajames@linux.vnet.ibm.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Date: Fri, 01 Jun 2018 09:33:49 +1000
In-Reply-To: <CAHp75Vec+KZCkjcs3qpB=qLmaTon=yTLyu7S_tDrMGcobHW5eQ@mail.gmail.com>
References: <1527714464-8642-1-git-send-email-eajames@linux.vnet.ibm.com>
         <CAHp75VerhOMCTPGz5b8wUNL611AdT1iutRm-wrHfzzT+_GbvWA@mail.gmail.com>
         <58c1059a91b93a490a7fc8bda2112e67e6513840.camel@kernel.crashing.org>
         <CAHp75Vec+KZCkjcs3qpB=qLmaTon=yTLyu7S_tDrMGcobHW5eQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-31 at 09:29 +0300, Andy Shevchenko wrote:
> > If you have specific issues with how this is done, please express them
> > clearly. It's quite possible that there's some better way to do what
> > Eddie is doing here, but without *construtive* feedback this is
> > pointless.
> 
> It feels like you duplicate approach which is done in OF generic case.
> That is my concern. Though, if Wolfram is telling that is OK, I have
> no objections.

THe OF generic case is about discovering slaves underneath a port, not
ports inside of a mulit-port master.

I am not aware of a generic mechanism for the latter. We *could* make
the ports sub-devices but it gets messy then to arbitrate the
communication and deal with the common part. I've seen (and written)
multi-port masters in the past that use a similar approach to what
Eddie's doing and it works fine.

> > I'm disappointed here because we have an example of somebody rather new
> > producing what is overall pretty damn good code,
> 
> That is true. His code much better than many I have seen before

Thanks. Also thanks for taking the time to review.

> > despite a few corner
> > issues, and being (again) treated like crap.
> 
> Sorry for that, life is harsh.
> 
> > This isn't the right way to operate, and I believe this has been made
> > clear many times before.
> 
> Yes.


Cheers,
Ben.
