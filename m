Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbeC3MkX convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:40:23 -0400
Received: from wildebeest.demon.nl ([212.238.236.112]:40154 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbeC3MkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:40:22 -0400
Message-ID: <1522413619.15770.88.camel@fedoraproject.org>
Subject: Re: [RFCv2 PATCH 0/3] Salted build ids via linker sections
From: Mark Wielaard <mjw@fedoraproject.org>
To: Laura Abbott <labbott@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>,
        linux-kbuild@vger.kernel.org
Date: Fri, 30 Mar 2018 14:40:19 +0200
In-Reply-To: <20180329180112.11055-1-labbott@redhat.com>
References: <20180329180112.11055-1-labbott@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-29 at 11:01 -0700, Laura Abbott wrote:
> I'm still mostly looking for feedback whether
> this would be acceptable for merging or if we should just persue a
> --build-id-salt in binutils.

Personally I would go with this approach. It seems simple and it might
take years before a new linker option is available everywhere.

To simplify things I think you could just always add the extra vdso
.comment initialized to something like KERNELRELEASE. Which distros
seem to update anyway to include their build number, so they wouldn't
need to do anything special to "update the build salt".

Cheers,

Mark
