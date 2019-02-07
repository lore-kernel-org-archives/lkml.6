Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED40AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E712147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfBGHRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 02:17:43 -0500
Received: from smtprelay0158.hostedemail.com ([216.40.44.158]:43605 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725923AbfBGHRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 02:17:43 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 5EC0F100E86C3;
        Thu,  7 Feb 2019 07:17:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crib50_7d2e405754e2e
X-Filterd-Recvd-Size: 5742
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 Feb 2019 07:17:39 +0000 (UTC)
Message-ID: <65ceabf611b845b5d278dba73d30f16b33e10d6d.camel@perches.com>
Subject: Re: [PATCH] staging: vt6656: Use the correct style for SPDX license
 Identifier
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>, devel@driverdev.osuosl.org,
        Forest Bond <forest@alittletooquiet.net>,
        linux-kernel@vger.kernel.org
Date:   Wed, 06 Feb 2019 23:17:35 -0800
In-Reply-To: <20190206162524.GA22989@kroah.com>
References: <20190205150620.GA17522@nishad>
         <20190205184431.GD22198@kroah.com>
         <7771453cf380ce43d906f6648edecd8b58fec38a.camel@perches.com>
         <20190206162524.GA22989@kroah.com>
Content-Type: multipart/mixed; boundary="=-Qr+OWaOSwYco/TihXJhf"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Qr+OWaOSwYco/TihXJhf
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On Wed, 2019-02-06 at 17:25 +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 05, 2019 at 10:59:40AM -0800, Joe Perches wrote:
> > On Tue, 2019-02-05 at 19:44 +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Feb 05, 2019 at 08:36:24PM +0530, Nishad Kamdar wrote:
> > > > This patch corrects the style for SPDX license Identifier in mac.h
> > > > by using "/* */" in place of "//" as per Linux kernel licensing rules.
> > > > Issue found by checkpatch.
> > > > 
> > > > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > > > ---
> > > >  drivers/staging/vt6656/mac.h | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/vt6656/mac.h b/drivers/staging/vt6656/mac.h
> > > > index 94e700fcd0b6..75166020f7c6 100644
> > > > --- a/drivers/staging/vt6656/mac.h
> > > > +++ b/drivers/staging/vt6656/mac.h
> > > > @@ -1,5 +1,5 @@
> > > > -// SPDX-License-Identifier: GPL-2.0+
> > > > -/*
> > > > +/* SPDX-License-Identifier: GPL-2.0+
> > > 
> > > Should really be:
> > > 
> > > /* SPDX-License-Identifier: GPL-2.0+ */
> > 
> > There's a fair number of style inconsistencies in the kernel
> > sources for that already.
> > 
> > ~8% of the .h files that have an 'SPDX-License-Identifier:'
> > don't use the recommended style.
> > 
> > $ git grep -h "SPDX-License" -- '*.h' | \
> >   perl -p -e 's@Identifier:.*\*/*@Identifier: ... */@; s@Identifier: [^\.].*@Identifier:@' | \
> >   sort | uniq -c | sort -rn
> >    8506 /* SPDX-License-Identifier: ... */
> >     593 // SPDX-License-Identifier:
> >     154 /* SPDX-License-Identifier:
> >      53  * SPDX-License-Identifier:
> >       1  * SPDX-License-Identifier:	GPL-2.0
> >       1 //SPDX-License-Identifier:
> >       1 /*  SPDX-License-Identifier: ... */
> 
> Then let's fix them, the documentation says what the correct format is,
> there's no reason we can't actually follow what is written...

So here's a script that does most all of them except
the 50 or so that use the SPDX-License-Identifier
in the middle of a comment block.

Using:

$ git grep --name-only 'SPDX-License-Identifier:' -- '*.h' | \
  xargs grep -L '/\* SPDX-License-Identifier:.*\*/'| \
  while read file ; do perl -i update_spdx.perl $file ; done

produces

$ git diff --shortstat
 748 files changed, 902 insertions(+), 902 deletions(-)

And

$ git grep -h "SPDX-License" -- '*.h' | \
  perl -p -e 's@Identifier:.*\*/*@Identifier: ... */@; s@Identifier: [^\.].*@Identifier:@' | \
  sort | uniq -c | sort -rn
   9254 /* SPDX-License-Identifier: ... */
     53  * SPDX-License-Identifier:
      1  * SPDX-License-Identifier:	GPL-2.0
      1 /*  SPDX-License-Identifier: ... */

and the perl script below is also attached

$ cat update_spdx.perl
local $/;
my $file = (<>);

my $spdx_regex = '/\*[ \t]*SPDX-License-Identifier:[ \t]*';
my $spdx_actual = '/* SPDX-License-Identifier: ';

# any // use converted to /* ... */
$file =~ s@^//[ \t]*SPDX-License-Identifier:[ \t]*(.*)\n@/* SPDX-License-Identifier: $1 */\n@;

# first line use with /* without trailing */ gets */ added and 2nd line updated
$file =~ m@^\s*${spdx_regex}([^\n]+)\n@;
if (defined $1 && $1 !~ m@\*/$@) {
    $file =~ s@^[ \t]*${spdx_regex}([^\n]+)\n@${spdx_actual}$1 */\n/* @;
    $file =~ s@^[ \t]*${spdx_regex}([^\n]+)\n[ \t]*/\*[ \t]+\*@${spdx_actual}$1\n/* @;
    $file =~ s@^\s*${spdx_regex}([^\n]+)\n/\* \n@${spdx_actual}$1\n/*\n@;
}

print $file;


--=-Qr+OWaOSwYco/TihXJhf
Content-Type: application/x-perl; name="update_spdx.perl"
Content-Disposition: attachment; filename="update_spdx.perl"
Content-Transfer-Encoding: base64

bG9jYWwgJC87Cm15ICRmaWxlID0gKDw+KTsKCm15ICRzcGR4X3JlZ2V4ID0gJy9cKlsgXHRdKlNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOlsgXHRdKic7Cm15ICRzcGR4X2FjdHVhbCA9ICcvKiBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogJzsKCiMgYW55IC8vIHVzZSBjb252ZXJ0ZWQgdG8gLyogLi4u
ICovCiRmaWxlID1+IHNAXi8vWyBcdF0qU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6WyBcdF0qKC4q
KVxuQC8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAkMSAqL1xuQDsKCiMgZmlyc3QgbGluZSB1
c2Ugd2l0aCAvKiB3aXRob3V0IHRyYWlsaW5nICovIGdldHMgKi8gYWRkZWQgYW5kIDJuZCBsaW5l
IHVwZGF0ZWQKJGZpbGUgPX4gbUBeXHMqJHtzcGR4X3JlZ2V4fShbXlxuXSspXG5AOwppZiAoZGVm
aW5lZCAkMSAmJiAkMSAhfiBtQFwqLyRAKSB7CiAgICAkZmlsZSA9fiBzQF5bIFx0XSoke3NwZHhf
cmVnZXh9KFteXG5dKylcbkAke3NwZHhfYWN0dWFsfSQxICovXG4vKiBAOwogICAgJGZpbGUgPX4g
c0BeWyBcdF0qJHtzcGR4X3JlZ2V4fShbXlxuXSspXG5bIFx0XSovXCpbIFx0XStcKkAke3NwZHhf
YWN0dWFsfSQxXG4vKiBAOwogICAgJGZpbGUgPX4gc0BeXHMqJHtzcGR4X3JlZ2V4fShbXlxuXSsp
XG4vXCogXG5AJHtzcGR4X2FjdHVhbH0kMVxuLypcbkA7Cn0KCnByaW50ICRmaWxlOwo=


--=-Qr+OWaOSwYco/TihXJhf--

