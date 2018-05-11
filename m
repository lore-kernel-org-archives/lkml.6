Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbeEKHGN convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 03:06:13 -0400
Received: from smtp2.goneo.de ([85.220.129.33]:35480 "EHLO smtp2.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751406AbeEKHGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 03:06:11 -0400
X-Spam-Flag: NO
X-Spam-Score: -2.779
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 13/18] wait: wait.h: Get rid of a kernel-doc/Sphinx
 warnings
From: Markus Heiser <markus.heiser@darmarit.de>
In-Reply-To: <20180510134249.64445281@vento.lan>
Date: Fri, 11 May 2018 09:06:06 +0200
Cc: Jonathan Corbet <corbet@lwn.net>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <6C65056C-8A0D-4E0A-9A49-07F10C31955E@darmarit.de>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
 <6b9b3184cbfabab1ad89c974ddf1c61631e8f1bf.1525684985.git.mchehab+samsung@kernel.org>
 <20180510083838.GA21846@infradead.org> <20180510063805.1859b1aa@vento.lan>
 <20180510073012.5902088e@lwn.net> <20180510112113.4db65764@vento.lan>
 <20180510093846.184f6de0@lwn.net> <20180510134249.64445281@vento.lan>
To: Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 10.05.2018 um 18:42 schrieb Mauro Carvalho Chehab <mchehab+samsung@kernel.org>:
> 
> Em Thu, 10 May 2018 09:38:46 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
> 
>> On Thu, 10 May 2018 11:21:13 -0300
>> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
>> 
>>> The problem with a hint-based mechanism is that it will generate
>>> false hints. If added, we may end by needing to add extra tags to
>>> disable the hints mechanism where it gets wrong, or to periodically
>>> do code changes at kernel-doc comments in order to make the hints
>>> logic happy.
>>> 
>>> So, IMO, we should provide non-hints based mechanism, like forcing the
>>> string that prepends the colon to have a keyword that will make it to
>>> parse the block as literal, where expressions like:
>>> 
>>> 	See the code-block foo:
>>> 	See the following code example:
>>> 	See the following flow diagram:
>>> 	See the following artwork:
>>> 
>>> Is the best alternative to avoid "::", as on the enclosed patch.  
>> 
>> But this, too, is a hint-based mechanism.  Thanks for the patches, I'll
>> keep them around, but I would like an opportunity to try to do better
>> before applying them.  I fear that using magic words in this way will
>> lead to a constant stream of surprises, and I'd like to avoid that if
>> possible...
> 
> Yes, it is still hint-based. A careful selection of the "magic spell
> words/phrases" would minimize the risks of false positives, but it
> could still lead into some unwanted surprises.
> 
> IMO, "::" (or some other character combination that is not used
> elsewhere) is still the safest option.

Right, let's just stay with reST:

 http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html

We already have some special kernel-doc additions e.g. for highlighting,
cross referencing and "DOC:":

 https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#how-to-format-kernel-doc-comments

But we should not break with reST fundamentals.

There are other plain text markups on the market, I would remember Markdown as one.
They all come with markup rules (syntax), to make text parseable. Mauro brought the
example with lists and colons. In ReST, the "::" introduce an indented literal block,
which can be used for code block examples or a small ASCII art.

FWIW: at docutils there is also a (slow ongoing) discussion about reST syntax
alternatives  

 http://docutils.sourceforge.net/docs/dev/rst/alternatives.html

may the syntax discussion is better placed there?

-- Markus --
