Return-Path: <pombredanne@nexb.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518155924; cv=none;
        d=google.com; s=arc-20160816;
        b=oTJEouFcXiffEom2M8mPnQLt0zU46RJq6vdb2FrkUDDBTTk0zKilblpqqW2JBxCUk2
         qTRhv0JHZERIkibJ//0OwolbiUz9e3qAIAqGUB98hOzTnLcUMjC/H0/U7Nr/sBLfS2OC
         WZkz6H3sScECkF+0O0arwuJtBhGPDgZVJEZpSjc6TyA3RXZy3ilm0JlW1t4g2N6vedkw
         nwm0w5uZJjN00NLZdMKNZ2TEJjfZFn5unXOTVJpNwFab0flzFpTaOaYKCyo4vekr5lkD
         2Y4NJtmszE4dKukYweHFghlioUdC55zyFAmKroFlGA9es5aXstIdBCLGbU7Mke5QUdxS
         tkwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ffbMSe41tvpWGg4/J4B4hc8bXmLEF87Fv39xISvs1rM=;
        b=orjAslpKXFFKw9DmzmLgqLhKs0/zSfj1muZBnzmekODEph13PRUsKPU+qoikcnc+2r
         jsrqpgXF5UqvTbcKYie7wv0VpV95G+O/UHRMmE6wnlsepMma1V/DQ2dLyLOStPPaVvhC
         Ke/xAaMVJ1X/TrzoB+8UTrWN/SxggkfXmT3kGxLztXWX71ZboCpjdhJoQYdQgVEVAR4G
         NQtqmDWn/4Ahc/9nFr9S26ECAiwz0UunzVwYpDT+UdFdTfMRR5Ih/zXM0xOrkbzPY3S+
         VPewBtBouL8yerfoDXRs87xSI/56abyvv/KB/jY91udyNfAARlqmC4RVv0Nl3PMfdkMy
         ttrw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=W/ZVbeEb;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=W/ZVbeEb;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
X-Google-Smtp-Source: AH8x226b/xU+9S+NKJ+s9P18RVXYi15upft70gNhr24wV7iMDDzrLITUEgMLV517HShNY70ql0nCJj5hi17UTcDIpqE=
MIME-Version: 1.0
In-Reply-To: <1518136556.1815.10.camel@perches.com>
References: <20180202154026.15298-1-robh@kernel.org> <1517606282.7489.165.camel@perches.com>
 <1518136556.1815.10.camel@perches.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Fri, 9 Feb 2018 06:58:03 +0100
Message-ID: <CAOFm3uEzpr7idZQz4kBCDwZ32uFwaYU3hsVoQwYw_gys3M_xjg@mail.gmail.com>
Subject: Re: [PATCH v6] checkpatch.pl: Add SPDX license tag check
To: Joe Perches <joe@perches.com>
Cc: Rob Herring <robh@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@canonical.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304287671259020?=
X-GMAIL-MSGID: =?utf-8?q?1591901866877403815?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 9, 2018 at 1:35 AM, Joe Perches <joe@perches.com> wrote:
> On Fri, 2018-02-02 at 13:18 -0800, Joe Perches wrote:
>> On Fri, 2018-02-02 at 09:40 -0600, Rob Herring wrote:
>> > Add SPDX license tag check based on the rules defined in
>> > Documentation/process/license-rules.rst. To summarize, SPDX license tags
>> > should be on the 1st line (or 2nd line in scripts) using the appropriate
>> > comment style for the file type.
>> >
>> > Cc: Andy Whitcroft <apw@canonical.com>
>> > Cc: Joe Perches <joe@perches.com>
>> > Cc: Thomas Gleixner <tglx@linutronix.de>
>> > Cc: Philippe Ombredanne <pombredanne@nexb.com>
>> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > Signed-off-by: Rob Herring <robh@kernel.org>
>>
>> Signed-off-by: Joe Perches <joe@perches.com>
>
> Andrew, would you pick this up please?
>
>> > ---
>> > v6:
>> > - Dropped script extension check and only look for #!/... on 1st line. A
>> >   text executable file was not reliable either.
>> > - Support .awk and .tc which may or may not have a #!/.
>> > - Fixed a typo in script "#!" regex and also match on first /.
>> > - Add Greg's ack.
>> >
>> >  scripts/checkpatch.pl | 27 +++++++++++++++++++++++++++
>> >  1 file changed, 27 insertions(+)
>> >
>> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> > index ba03f17ff662..6db245e5f93b 100755
>> > --- a/scripts/checkpatch.pl
>> > +++ b/scripts/checkpatch.pl
>> > @@ -2225,6 +2225,8 @@ sub process {
>> >
>> >     my $camelcase_file_seeded = 0;
>> >
>> > +   my $checklicenseline = 1;
>> > +
>> >     sanitise_line_reset();
>> >     my $line;
>> >     foreach my $rawline (@rawlines) {
>> > @@ -2416,6 +2418,7 @@ sub process {
>> >                     } else {
>> >                             $check = $check_orig;
>> >                     }
>> > +                   $checklicenseline = 1;
>> >                     next;
>> >             }
>> >
>> > @@ -2866,6 +2869,30 @@ sub process {
>> >                     }
>> >             }
>> >
>> > +# check for using SPDX license tag at beginning of files
>> > +           if ($realline == $checklicenseline) {
>> > +                   if ($rawline =~ /^[ \+]\s*\#\!\s*\//) {
>> > +                           $checklicenseline = 2;
>> > +                   } elsif ($rawline =~ /^\+/) {
>> > +                           my $comment = "";
>> > +                           if ($realfile =~ /\.(h|s|S)$/) {
>> > +                                   $comment = '/*';
>> > +                           } elsif ($realfile =~ /\.(c|dts|dtsi)$/) {
>> > +                                   $comment = '//';
>> > +                           } elsif (($checklicenseline == 2) || $realfile =~ /\.(sh|pl|py|awk|tc)$/) {
>> > +                                   $comment = '#';
>> > +                           } elsif ($realfile =~ /\.rst$/) {
>> > +                                   $comment = '..';
>> > +                           }
>> > +
>> > +                           if ($comment !~ /^$/ &&
>> > +                               $rawline !~ /^\+\Q$comment\E SPDX-License-Identifier: /) {
>> > +                                   WARN("SPDX_LICENSE_TAG",
>> > +                                        "Missing or malformed SPDX-License-Identifier tag in line $checklicenseline\n" . $herecurr);
>> > +                           }
>> > +                   }
>> > +           }
>> > +
>> >  # check we are in a valid source file if not then ignore this hunk
>> >             next if ($realfile !~ /\.(h|c|s|S|sh|dtsi|dts)$/);
>> >

BTW I forgot this if you like to add it:

Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
