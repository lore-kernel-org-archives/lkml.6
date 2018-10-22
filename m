Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC0CC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8164320652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8164320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=petrovitsch.priv.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbeJVSGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:06:00 -0400
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:3296 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbeJVSGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:06:00 -0400
Received: from thorin.petrovitsch.priv.at (80-110-99-3.cgn.dynamic.surfer.at [80.110.99.3])
        (authenticated bits=0)
        by esgaroth.tuxoid.at (8.15.2/8.15.2) with ESMTPSA id w9M9g6ie022922
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO);
        Mon, 22 Oct 2018 11:42:16 +0200
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com>
 <20181021222712.GI1617@thunk.org>
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Message-ID: <8fb78062-b6d4-6f2d-d943-44bec6b95ff0@petrovitsch.priv.at>
Date:   Mon, 22 Oct 2018 11:41:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181021222712.GI1617@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-DCC-debian-Metrics: esgaroth.tuxoid.at 1169; Body=43 Fuz1=43 Fuz2=43
X-Virus-Scanned: clamav-milter 0.97 at esgaroth.tuxoid.at
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2018 00:27, Theodore Y. Ts'o wrote:
> On Sun, Oct 21, 2018 at 07:14:13PM +0200, Miguel Ojeda wrote:
>> From the GCC manual:
>>
>>   fallthrough
>>
>>     The fallthrough attribute with a null statement serves as a
>>     fallthrough statement. It hints to the compiler that a statement
>>     that falls through to another case label, or user-defined label
>>     in a switch statement is intentional and thus the -Wimplicit-fallthrough
>>     warning must not trigger. The fallthrough attribute may appear
>>     at most once in each attribute list, and may not be mixed with
>>     other attributes. It can only be used in a switch statement
>>     (the compiler will issue an error otherwise), after a preceding
>>     statement and before a logically succeeding case label,
>>     or user-defined label.
>>
>>   https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html
> 
> Do we know if coverity understands the fallthrough attribute?  One of
> the reasons why I started using /* fallthrough */ is because it kept
> Coverity happy.

FWIW, current "eclipse" has the same "problem".

> If the conversion from /* fallthrough */ to the __fallthrough__
> attribute means that we start gethting a lot of Coverity warnings,

We could keep both.

MfG,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at
