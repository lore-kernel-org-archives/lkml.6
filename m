Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754035AbeDAWUf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 18:20:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753943AbeDAWUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 18:20:34 -0400
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
To: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dad672eb-a343-b899-6936-5d18a62e6beb@infradead.org>
Date: Sun, 1 Apr 2018 15:20:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2018 01:40 PM, David Howells wrote:
> 
> Here are a series of patches to start converting the kernel to C++.  It
> requires g++ v8.
> 
...
> 
> What I would disallow:
> 
>  (1) new and delete.  There's no way to pass GFP_* flags in.
> 
>  (2) Constructors and destructors.  Nests of implicit code makes the code less
>      obvious, and the replacement of static initialisation with constructor
>      calls would make the code size larger.
> 
>  (3) Exceptions and RTTI.  RTTI would bulk the kernel up too much and
>      exception handling is limited without it, and since destructors are not
>      allowed, you still have to manually clean up after an error.
> 
>  (4) Operator overloading (except in special cases).
> 
>  (5) Function overloading (except in special inline cases).
> 
>  (6) STL (though some type trait bits are needed to replace __builtins that
>      don't exist in g++).
> 
>  (7) 'class', 'private', 'namespace'.

Please fix https://bugzilla.kernel.org/show_bug.cgi?id=191051
while you are at it.  :)


>  (8) 'virtual'.  Don't want virtual base classes, though virtual function
>      tables might make operations tables more efficient.


ta.
-- 
~Randy
