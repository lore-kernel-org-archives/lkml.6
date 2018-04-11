Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753108AbeDKQGn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:06:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:1483 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752211AbeDKQGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:06:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,436,1517904000";
   d="scan'208";a="49964404"
Date: Wed, 11 Apr 2018 09:01:57 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
X-X-Sender: mjmartin@rkwong-mobl2.amr.corp.intel.com
To: David Howells <dhowells@redhat.com>
cc: Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] uapi/linux/keyctl.h: don't use C++ reserved keyword as
 a struct member name
In-Reply-To: <19745.1523350020@warthog.procyon.org.uk>
Message-ID: <alpine.OSX.2.21.1804110821140.8210@rkwong-mobl2.amr.corp.intel.com>
References: <1735b3a4-2792-0ce4-3bf4-94fee5b50ff6@infradead.org> <19745.1523350020@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (OSX 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Apr 2018, David Howells wrote:

> Randy Dunlap <rdunlap@infradead.org> wrote:
>
>> Since this header is in "include/uapi/linux/", apparently people
>> want to use it in userspace programs -- even in C++ ones.
>> However, the header uses a C++ reserved keyword ("private"),
>> so change that to "dh_private" instead to allow the header file
>> to be used in C++ userspace.
>>
>> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=191051
>
> Ugh.  Yeah.  This is a UAPI breaker, but I think we have to do it, despite it
> being 2 years old.  Maybe wrap that element in a #ifdef so it's still allowed
> in C?
>
> cc'ing Mat Martineau as he's the originator of the structure.

I agree with David's assessment.

The keyctl() system call wrapper is implemented in libkeyutils, which may 
reduce the need for the proposed ifdef. libkeyutils and its users don't 
require any updates if this patch is merged because it has its own 
keyword-free structure definition.

--
Mat Martineau
Intel OTC
