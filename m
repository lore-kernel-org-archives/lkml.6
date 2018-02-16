Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758560AbeBPQgN convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:36:13 -0500
Received: from smtp1.goneo.de ([85.220.129.30]:54818 "EHLO smtp1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758540AbeBPQgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:36:11 -0500
X-Spam-Flag: NO
X-Spam-Score: -2.683
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] scripts: kernel_doc: fixup reporting of function
 identifiers
From: Markus Heiser <markus.heiser@darmarit.de>
In-Reply-To: <20180216075642.2e56eb51@lwn.net>
Date: Fri, 16 Feb 2018 17:36:07 +0100
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <17062CC8-55BF-423B-A4F5-726291417D21@darmarit.de>
References: <1518521506-6770-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180216075642.2e56eb51@lwn.net>
To: Jonathan Corbet <corbet@lwn.net>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 16.02.2018 um 15:56 schrieb Jonathan Corbet <corbet@lwn.net>:
> 
> On Tue, 13 Feb 2018 13:31:46 +0200
> Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> 
>> When function description includes brackets after the function name as
>> suggested by Documentation/doc-guide/kernel-doc, the kernel-doc script
>> omits the function name from "Scanning doc for" report.
>> Extending match for identifier name with optional brackets fixes this
>> issue.
> 
> So let me channel akpm here and ask: what are the user-visible effects of
> this problem?  I ask because applying it doesn't make any difference in
> the "make htmldocs" output here.  So I don't understand why you're
> wanting to make this change.

Use kernel-doc -v and take a look on the info-messages.

In Documentation/doc-guide/kernel-doc we recommend to use

/**
 * foo() - lorem ipsum

to tag functions, but if you do so, the info message is broken,
the function name is missed at the end of the message:

 ../test123.c:2: info: Scanning doc for  

Here is the similar patch to kernel-doc python version:

 https://github.com/return42/linuxdoc/commit/84d665df34cc3c9908a4b8ce0fdf193165a1ffa4

@Mike: thanks!

--Markus--
