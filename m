Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbeBJP5j convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 10:57:39 -0500
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40502 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbeBJP5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 10:57:38 -0500
Date: Sat, 10 Feb 2018 15:57:34 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Joe Perches <joe@perches.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Jiri Kosina <jikos@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: Software evolution around =?UTF-8?B?4oCcY2hlY2twYXRjaC5wbA==?=
 =?UTF-8?B?4oCdPw==?=
Message-ID: <20180210155734.708d01b6@archlinux>
In-Reply-To: <1518274783.6579.2.camel@perches.com>
References: <0406765c-bdd1-1a82-cf66-1c248063ae4f@users.sourceforge.net>
        <20180204112346.0977e938@archlinux>
        <9420fc82-1a37-3601-bafe-f57ef953bfcd@users.sourceforge.net>
        <87DF341A-1356-4B1B-8D25-14D5B0AAB01D@jic23.retrosnub.co.uk>
        <f008911b-c595-6e0f-d85f-076e994ae7db@users.sourceforge.net>
        <20180210145336.233c721d@archlinux>
        <1518274783.6579.2.camel@perches.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Feb 2018 06:59:43 -0800
Joe Perches <joe@perches.com> wrote:

> On Sat, 2018-02-10 at 14:53 +0000, Jonathan Cameron wrote:
> > While it would be great to improve checkpatches false
> > positive rate, it's very nature as a string matcher makes
> > this hard.  
> 
> true.
> 
> what are the false positives you see?
> 
This particular case is only 'sort of' a false positive
in the warning that a message printed on a memory allocation
failure 'may' not add any information over the generic case.

Very hard to judge on whether it is useful to know more than
an allocation failed somewhere or not.

Message makes this clear:
>“WARNING: Possible unnecessary 'out of memory' message”
>(from the script “checkpatch.pl”)  

We also have the balance between any changes to existing code
adding 'some' maintenance overhead vs changing this stuff
in a new driver - which is what checkpatch is really intended
for.

So I think checkpatch is striking the right balance here in
how it warns.  Obviously if it could assess the text
and come to an informed decision that would be great but
we are some way from that ;)

Jonathan
