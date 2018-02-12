Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AH8x224q5djop21Ccxsj2MXFX1vsikRi0p/uAmFvY6TF6G28P0WWnTTkY3Vms81PLRzTqhFxFE03
ARC-Seal: i=1; a=rsa-sha256; t=1518479298; cv=none;
        d=google.com; s=arc-20160816;
        b=HyoX86IDS7kfh7XP8uMJJnh0N4RUGXryChrL8MqmorivKeOEaBq2jeHlqkltQ9SmdO
         e1bRMAAuovPLPBNHQcimTjqrMPKrDKxpHyJVM+RfjeFj3W9IHYwdHcK/d+eg8FVmHLWN
         KJ75eK5ofKGjym4wQJhHPJ9iKLaZ9ipFnJSrva+PnLsNwEps+fofV0EXpU4GFN04YwTY
         oqTZkUph5WAn1LBYfDk3bXh3qJ3SRMOcFwIZ0oNjhERTUw/pyMg2HNgCCVFAN2cpy1E4
         6S8WAqRA6scAa9mvlx8X6eiLP3zruGHCbAZenziNVOXKvcLYzBxUpvuslusbWIPg+jE3
         3LdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=CKzLEX+1IoPLCU4FY5vBBMod3aHY+Zh/htPul3l4wno=;
        b=jBg2DVK6bhAw9+Qkc+fFxIpk6J3hCZwTvXo4foH+aWj5Ay2SmEIP6Kw5lzFEb9ecoV
         pWuB37Y+esbunLqPKUniQ/oD9P3hbLMcdTCZRF6XsE7Ltk8VqNEZIXtE47+spAY3UthR
         LuA4Ed1iFfm3h5Dhs5rgJ/Zd0n532IGIlM/ZUC4A+xzel1WJ7B1jc6PzypZdi6UkGTRl
         9YxTB3bcaNLgorl6TOPwrP5KjF7YudunkO8p3gkwPgZePHfXhYC2VzQYFVV5UgW4hbUw
         2mlPHgqO2cQumhwBlkJoy8G4MJXluWjqGh5eM8vZS+h0/DNkhXsB84xMYI/1oaDSpHSL
         Fecw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=G+pJS6Ew;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=oNKSOdGl;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 85.118.1.10 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=G+pJS6Ew;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=oNKSOdGl;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 85.118.1.10 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Kees Cook <keescook@chromium.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nicolas Pitre <nicolas.pitre@linaro.org>,
 "Luis R . Rodriguez" <mcgrof@suse.com>, Sam Ravnborg <sam@ravnborg.org>,
 Michal Marek <michal.lkml@markovi.net>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>,
 linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
 Arnd Bergmann <arnd@arndb.de>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator>
 <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator>
 <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator>
 <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator>
 <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CAK7LNAQpS6dYBnt_PjL5zrX1=eccSg80khu=WYCjnHNvDiKa3w@mail.gmail.com>
 <CAGXu5j+7kv=jrg2u7jaxFEXwHoyzDXP_jyKHYA682_BrYuHwQQ@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <49c196ec-891d-2030-bd6c-7222feb22059@infradead.org>
Date: Mon, 12 Feb 2018 15:48:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+7kv=jrg2u7jaxFEXwHoyzDXP_jyKHYA682_BrYuHwQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592240948115639834?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/12/2018 07:24 AM, Kees Cook wrote:
> On Mon, Feb 12, 2018 at 6:39 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:

>>> (And in thinking about this, does Kconfig know the true $CC in use?
>>> i.e. the configured cross compiler, etc?)
>>
>> I was thinking of removing CONFIG_CROSS_COMPILE.
>>
>> A user can dynamically change CROSS_COMPILE from
>> "make menuconfig".
> 
> Most builds I've seen implement cross compilers as an environment
> variable during all "make" invocations.

I agree. I think you would break a bunch of build bots if you remove that.

>> If we continue to support this, $CC changes
>> according to CONFIG_CROSS_COMPILE.
>> Then, compiler flags must be re-evaluated
>> every time a user changes a compiler in use.
>> It will introduce much more complexity.
> 
> Right now, this is just handled in the Makefile: all the right
> variables exist, etc.
> 
> -Kees
> 


-- 
~Randy
