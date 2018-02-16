Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758503AbeBPQLG convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:11:06 -0500
Received: from smtp2.goneo.de ([85.220.129.33]:47538 "EHLO smtp2.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756775AbeBPQLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:11:04 -0500
X-Spam-Flag: NO
X-Spam-Score: -2.767
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 4/6] scripts: kernel-doc: support in-line comments on
 nested structs/unions
From: Markus Heiser <markus.heiser@darmarit.de>
In-Reply-To: <20180216125651.45401575@vento.lan>
Date: Fri, 16 Feb 2018 17:11:00 +0100
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <0BE9A02B-4870-4AA0-9165-44B98295EC07@darmarit.de>
References: <cover.1518788761.git.mchehab@s-opensource.com>
 <cover.1518788761.git.mchehab@s-opensource.com>
 <a4f7680bf956e6c98f612bcfc7aa817c344ebdab.1518788761.git.mchehab@s-opensource.com>
 <54EF06CB-C31F-476D-B674-579E9385D635@darmarit.de>
 <20180216125651.45401575@vento.lan>
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 16.02.2018 um 15:56 schrieb Mauro Carvalho Chehab <mchehab@s-opensource.com>:
> 
> Em Fri, 16 Feb 2018 15:52:33 +0100
> Markus Heiser <markus.heiser@darmarit.de> escreveu:
> 
>>> Am 16.02.2018 um 14:48 schrieb Mauro Carvalho Chehab <mchehab@s-opensource.com>:
>>> 
>>> The parser at kernel-doc rejects names with dots in the middle.
>>> Fix it, in order to support nested structs/unions.
>>> 
>>> Tested-by: Jani Nikula <jani.nikula@intel.com>
>>> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
>>> ---
>>> scripts/kernel-doc | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>> 
>>> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
>>> index fee8952037b1..06d7f3f2c094 100755
>>> --- a/scripts/kernel-doc
>>> +++ b/scripts/kernel-doc
>>> @@ -363,7 +363,7 @@ my $doc_sect = $doc_com .
>>> my $doc_content = $doc_com_body . '(.*)';
>>> my $doc_block = $doc_com . 'DOC:\s*(.*)?';
>>> my $doc_inline_start = '^\s*/\*\*\s*$';
>>> -my $doc_inline_sect = '\s*\*\s*(@[\w\s]+):(.*)';
>>> +my $doc_inline_sect = '\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)';  
>> 
>> Thanks!
>> 
>> FWIW: added similar patch to python variant of kernel-doc:
>> 
>> https://github.com/return42/linuxdoc/commit/5c5da9a
>> 
>> rendered example:
>> 
>>  https://return42.github.io/linuxdoc/linuxdoc-howto/all-in-a-tumble.html#struct-my-long-struct
> 
> On a quick look, on your example, bar2.barbar description looks different
> than what we get from the perl version.
> 
> There, it generates it as:
> 
> ``bar2.barbar``
>  Description for **barbar** inside **foo.bar2**

very attentive, thanks a lot!

When I implemented support for nested data types, I missed
to fix the highlighting pattern of those.

  https://github.com/return42/linuxdoc/commit/4b43f419

rendered: https://return42.github.io/linuxdoc/linuxdoc-howto/all-in-a-tumble.html#struct-my-long-struct

-- Markus --
