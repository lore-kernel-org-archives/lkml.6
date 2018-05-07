Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753288AbeEGUwe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:52:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:45383 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752721AbeEGUwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:52:32 -0400
Subject: Re: [BUG] scripts/checkpatch.pl: false positive missing parentheses
To: Joe Perches <joe@perches.com>
Cc: Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
References: <20180507183105.13499-1-xypron.glpk@gmx.de>
 <51c4c2c53cf166b704fdf7e8f08b3f09dbece1ab.camel@perches.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <c4b8270a-ae2a-e234-faa8-d5366605865e@gmx.de>
Date: Mon, 7 May 2018 22:52:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <51c4c2c53cf166b704fdf7e8f08b3f09dbece1ab.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JAR1YAyuTAlQVF8SaEXkRfZIFBtZ/rwLv2/JoGY55F+Ght3Tte/
 CK1SZf99QESLHUOkOudmXgbjOivBnHYg6919APNiIaju/BcRFZsXvsUZi4F8JiYwPkn+9a1
 eNeiJAW2W3jEXEnrDdvMMGX4ryesjdqA575Tsy/pPFnlcT6zXJbo5okomdvMvD7HXE0LCHp
 suhevWk8bA8udbRP4F+tg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LW1d6Tr7mfc=:tqEOA9TuN1bIPpxY11dB27
 q2vRYTlr/mWHRicHChv6na02HyaQ9anYzeSuRq5vx945vBVAXbFtHCocS2l334USR6YifwOdj
 rcaGAnvK5wMl2OfwtTryVMGH3g9yzk9Cri445BMh5LHz2m9ZSJSrFrYfr9IL26EQCS6rwMGTw
 zg+znTRg7JvEQo9LXoC3dTw4nNB438pVEhLSuxJI2bVM/TTxduDZazPjQskLZ+gHvMfG64Ctr
 EJ/w9XRU+m9Xl6Q7pyOkJE/TvsSBD4A4OZe9+CQpELjbYSQbPujyRZ0Jw3WmZEAAMBJYyYu1P
 xNA0KsuxSvHm4fx/2ZTkLY42V1qUKgzxu5Rvcmxfc+mHPcT3i1P+XJYKtoUdKjA+2fyNf0mFF
 RqmadwO3xVYOw8z4HzcucNTB+6q411DkBY1y+xwQDWB7WD8h1duhGnPzOlfKEt68avUZU936/
 9AVjnh2wTRrpoh+WKUD93QV3OYCVUok6ULBGiE9XHuO79xCPbpSbcB2gHmVKajuBVmBacNlQJ
 rRajBU3NWtRq6shuVWFKFGnhv6WZiGWJGyKO0QpXYBQmhZJpjFgG8E4PgIYwiCi3mPQExwL8U
 WuqJTJNQ3HN1zA58BbeSvFiC3rbEbzTqdN4lMUxpBxUNavm7jH/dl+tMrIKz1FmTbn7S+zlLm
 3TooiCurN0rTF89gvVIzDXCM4422iCR13afpSZs3kAuqVmW7AeaP2dEK27KVmyT9dnQCs47E9
 BsnoORkGTIzWol7jF+aAGecBK7QKn1SyXGYWwitTV/ZD0L0KF4sReRkE007JgKqfKKjugqPpx
 vYsYU+F
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 10:43 PM, Joe Perches wrote:
> On Mon, 2018-05-07 at 20:31 +0200, Heinrich Schuchardt wrote:
>> This patch creates a false positive:
>> ERROR: Macros with complex values should be enclosed in parentheses
>>
>> Here we define a constant that can be used to initialize a structure.
>> Adding parentheses would lead to a compile time error:
>> error: braced-group within expression allowed only inside a function
> 
>>
>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> ---
>>  foo.h | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>  create mode 100644 foo.h
>>
>> diff --git a/foo.h b/foo.h
>> new file mode 100644
>> index 000000000000..e2cba533f065
>> --- /dev/null
>> +++ b/foo.h
>> @@ -0,0 +1,8 @@
>> +/* SPDX-License-Identifier: BSD-2 */
>> +#define EFI_ST_DISK_IMG { 0x00003368, { \
>> +	{0x00000d40, "\x6f\x63\x00\x2f\x2a\x00\x20\x2a"}, /* oc./*. * */ \
>> +	{0x00000d48, "\x00\x20\x2a\x2f\x0a\x00\x09\x7b"}, /* . */...{ */ \
> 
> I think this line would not do what you expect as the "/* . */" is
> a complete comment and the "...{ */" is parsed as code.

Thanks for catching this. If I replace the "internal" */ by ?/ the
problem does not occur. So probably we can close this issue.

So I think we can close the issue.

Best regards

Heinrich

> 
>> +	{0x00000d50, "\x30\x78\x25\x30\x38\x7a\x78\x2c"}, /* 0x%08zx, */ \
>> +	{0x00000d58, "\x20\x22\x00\x5c\x78\x25\x30\x32"}, /*  ".\x%02 */ \
>> +	{0x00000d60, "\x78\x00\x20\x2a\x2f\x20\x5c\x00"}, /* x. */ \. */ \
> 
> here too...
> 
>> +	{0, NULL} } }
> 
> checkpatch will always be a stupid style checker.
> 
> Some false positives are expected.
> 
> I think this is one of them, but perhaps the bit of
> checkpatch logic in the COMPLEX_MACRO test could be
> improved by something like the below.

Do we have to consider something a macro with complex a

> 
> Andy?  What do you think?
> 
> ---
>  scripts/checkpatch.pl | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 24618dffc5cb..9d3bdab03225 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -785,6 +785,8 @@ our $Typecast	= qr{\s*(\(\s*$NonptrType\s*\)){0,1}\s*};
>  # Any use must be runtime checked with $^V
>  
>  our $balanced_parens = qr/(\((?:[^\(\)]++|(?-1))*\))/;
> +our $balanced_braces = qr/(\{(?:[^\{\}]++|(?-1))*\})/;
> +our $balanced_brackets = qr/(\[(?:[^\[\]]++|(?-1))*\])/;
>  our $LvalOrFunc	= qr{((?:[\&\*]\s*)?$Lval)\s*($balanced_parens{0,1})\s*};
>  our $FuncArg = qr{$Typecast{0,1}($LvalOrFunc|$Constant|$String)};
>  
> @@ -4953,6 +4955,16 @@ sub process {
>  			$dstat =~ s/^\s*//s;
>  			$dstat =~ s/\s*$//s;
>  
> +			# Flatten any parentheses and braces using the
> +			# fancy balanced_<foo> tests (perl v5.10+ only)
> +			if ($^V && $^V ge 5.10.0) {
> +				while ($dstat =~ s/$balanced_parens/1/ ||
> +				       $dstat =~ s/$balanced_braces/1/ ||
> +				       $dstat =~ s/$balanced_brackets/1/)
> +				{
> +				}
> +			}
> +
>  			# Flatten any parentheses and braces
>  			while ($dstat =~ s/\([^\(\)]*\)/1/ ||
>  			       $dstat =~ s/\{[^\{\}]*\}/1/ ||
> 
> 
> 
