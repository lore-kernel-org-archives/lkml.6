Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934993AbeEWWxs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 18:53:48 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41215 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934516AbeEWWxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 18:53:45 -0400
X-Google-Smtp-Source: AB8JxZrQtrVnCMTPAF5oXv4Q5Cp+eWyliiopUxQ9ZlaVRftT8OyJ9Rxwc2E3aiLd5wYrqNzgcwDNwQ==
Subject: Re: [PATCHv3 2/2] x86/vdso: Add build salt to the vDSO
To: Andy Lutomirski <luto@kernel.org>
Cc: Mark Wielaard <mjw@fedoraproject.org>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>,
        linux-kbuild@vger.kernel.org
References: <20180523001939.9431-1-labbott@redhat.com>
 <20180523001939.9431-3-labbott@redhat.com>
 <CALCETrX9P2Lwrx7wGc22poVWX2AHAqXbUdhcijyoJ3tGhaxijg@mail.gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <15dcff14-ea1b-18c8-4cd1-06586cf6f05b@redhat.com>
Date: Wed, 23 May 2018 15:53:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CALCETrX9P2Lwrx7wGc22poVWX2AHAqXbUdhcijyoJ3tGhaxijg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2018 05:33 PM, Andy Lutomirski wrote:
> On Tue, May 22, 2018 at 5:19 PM Laura Abbott <labbott@redhat.com> wrote:
> 
> 
>> The vDSO is linked separately from the kernel and modules. Ensure it picks
>> up the comment section, if available.
> 
> Did you end up preferring this to just sticking the kernel version in a
> .comment in the vDSO for some reason?
> 

Actually I remember now why this is necessary: there is not a simple way
to encode a string into a linker file as it has to be spit out byte
by byte. The autogeneration was the easiest way to make that happen.
Maybe there's some horrific c preprocessing or other generation that
could happen but I doubt that's any worse than the generated linker
script.

Thanks,
Laura
