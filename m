Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935370AbeEXBgQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 21:36:16 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45399 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935109AbeEXBgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 21:36:12 -0400
X-Google-Smtp-Source: AB8JxZppwrZFgmA6kfs7pswdgaK9q4LnvAGr2trDjb3Ryp8lYl3usslHu8+XaQqP2uFJMEqGdixKNw==
Subject: Re: [PATCHv3 2/2] x86/vdso: Add build salt to the vDSO
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>
Cc: Andrew Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nickc@redhat.com, ccoutant@gmail.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
References: <20180523001939.9431-1-labbott@redhat.com>
 <20180523001939.9431-3-labbott@redhat.com>
 <CALCETrX9P2Lwrx7wGc22poVWX2AHAqXbUdhcijyoJ3tGhaxijg@mail.gmail.com>
 <15dcff14-ea1b-18c8-4cd1-06586cf6f05b@redhat.com>
 <CA+55aFxxUadENxUWU8jZqLnG=hvNA-fKCPQUMCKs2r0yWHc=rA@mail.gmail.com>
 <195C83C0-067C-4B55-89BD-9CF3155C6E69@amacapital.net>
 <CA+55aFxXCWc5qCAsuRmrCGqL7ws4f6B_zy1WR98kHgr_XZs3fw@mail.gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <6b4c2c4f-00db-22b7-db3a-a1e76899c6d0@redhat.com>
Date: Wed, 23 May 2018 18:36:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFxXCWc5qCAsuRmrCGqL7ws4f6B_zy1WR98kHgr_XZs3fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/23/2018 05:06 PM, Linus Torvalds wrote:
> 
> 
> On Wed, May 23, 2018, 17:01 Andy Lutomirski <luto@amacapital.net <mailto:luto@amacapital.net>> wrote:
> 
> 
>     I don’t know whether I’m missing something obvious, but can’t this be in C?
> 
> 
> Yes, but I thought Laura wanted to limit it to linker file tricks (this thread has gone on for so long that I've forgotten the details of why).
> 
>         Linus
> 
> 

So we have to update the kernel and every module and the easiest way
to do that was the linker script. I was assuming I'd just use the
same approach for the vDSO but you're right that there's no reason
we can't apply a different technique. I notice there's already a
vdso-note.S which adds LINUX_VERSION_CODE as a note. This doesn't
include the extra version so it doesn't quite meet our needs.
There's no reason why we can't throw something else in there for
good measure.

Thanks,
Laura
