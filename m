Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CB0C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3480C20881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbfA3VGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:06:11 -0500
Received: from www.llwyncelyn.cymru ([82.70.14.225]:45906 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfA3VGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:06:10 -0500
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id x0UKjjEf003221;
        Wed, 30 Jan 2019 20:45:45 GMT
Date:   Wed, 30 Jan 2019 20:45:44 +0000
From:   Alan Cox <alan@llwyncelyn.cymru>
To:     Rusty Russell <rusty@rustcorp.com.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH][RFC] module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2"
 bogosity
Message-ID: <20190130204544.1b50027d@alans-desktop>
In-Reply-To: <875zu620yn.fsf@rustcorp.com.au>
References: <alpine.DEB.2.21.1901282105450.1669@nanos.tec.linutronix.de>
        <875zu620yn.fsf@rustcorp.com.au>
Organization: is over-rated
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 15:31:20 +1030
Rusty Russell <rusty@rustcorp.com.au> wrote:

> Thanks taking on such a thankless task Thomas,
> 
> Might have been overzealous in assuming a verionless GPL string meant
> "or later" (I'm happy for that for my own code, FWIW).  My memory is
> fuzzy, but I don't think anyone cared at the time.

Versionless always meant 'or later' outside of the tags. It's the default
version of the licence. (Whether v2 only has any meaning beyond intent is
another debate that I guess some year a lawyer will have to figure out).

I think the description change makes sense given the ambiguity and the
fact we now have SPDX headers. (IANAL etc)

> >  2) The dual licensed strings became ill defined as well because following
> >     the "GPL" vs. "GPL v2" distinction all dual licensed (or additional

The dual ones were IMHO a mistake. They should just have used GPL and
additional rights. Either you have GPL rights (and it's ok to use in the
kernel) or you don't (and it's proprietary and the rest is down to
derivative works).

We don't actually care whether its dual licensed BSD, or whether it
merely grants you an additional right to cheap pizza.

> > As of 5.0-rc2 2873 out of 9200 instances of MODULE_LICENSE() strings are
> > conflicting with the actual license in the source code (either SPDX or
> > license boilerplate/reference). A comparison between the scan of the

The SPDX tag isn't correctly capable of expressing the licence anyway. If
you have functions in a file and two of them are GPL v2+ and someone
added a GPLv2 only one and updated the header there isn't a valid SPDX tag
for it because I can still use the GPLv2+ bits with GPLv3.

This is nothing new - the headers on the files provided no more data on
that and took up lots more space 8) We've simply never tracked licence
data by line.

Alan
