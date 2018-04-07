Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbeDGUgx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 16:36:53 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:41651 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752566AbeDGUgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 16:36:51 -0400
X-Google-Smtp-Source: AIpwx4+esICK9HWk/vGo3OGcb496Eti3nYGrvKKc84AmBUUDw7UySv3yhfLOul6Xu5o5Lgd8EFYxaQXo00wrfep02Nc=
MIME-Version: 1.0
In-Reply-To: <1522976022.11185.53.camel@perches.com>
References: <1522976022.11185.53.camel@perches.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Apr 2018 13:36:50 -0700
X-Google-Sender-Auth: RFKuUAxx58ZQy0TqNMeOK2mdUwg
Message-ID: <CA+55aFw=EQyJv52LjUje8ExMeX99u=8zzPsQAFv2MZ_N4V=Kog@mail.gmail.com>
Subject: Re: git source files with rw permissions
To: Joe Perches <joe@perches.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 5:53 PM, Joe Perches <joe@perches.com> wrote:
>
> A trivial script on a clean git tree like:
>
> $ git ls-files -- "*.[chsS]" | \
>   xargs ls -la | \
>   grep -P "^[^l](?:.{2,2}x|.{5,5}x|.{8,8}x)" | \
>   awk '{print $9}'

A simpler version of this is:

  git ls-files -s '*.[chsS]' | grep '^100755'

and then you can use 'cut -f2' if you just want the filenames and do
the "xargs chmod" thing.

Which I did, and committed, and just pushed out.

Thanks,
      Linus
