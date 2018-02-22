Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933491AbeBVRjP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:39:15 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:42183 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933378AbeBVRjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:39:12 -0500
X-Google-Smtp-Source: AG47ELtJeRct+KYhxNJEealKPakxbJHvKKB2nE7KiKuJIJOqcTEqwfIc0PeMIbhW3jK/cxMY4rGbAGW9Gll2uEY2WyA=
MIME-Version: 1.0
In-Reply-To: <20180222171506.wwsichkiyc5f74pr@agluck-desk>
References: <20180221194731.t7jowrmicvaggu3x@agluck-desk> <CA+55aFzy89V13rSxGQy77Bb08qpUpH+J=trcjooKQhsAFbgrVw@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37F130@ORSMSX110.amr.corp.intel.com>
 <CA+55aFx3WKAL7e3TAs-2okggW6Z+DHANdmcsr+WTDh3N-Mx+Xw@mail.gmail.com>
 <20180222014505.2l76ccrrs36y3b26@agluck-desk> <CA+55aFzJXsPcsJ5MtsxTp2n+43xC0yGzANLNcDm1mFbZKR75FQ@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37FE28@ORSMSX110.amr.corp.intel.com>
 <CA+55aFy0hRexJkLbN7t31LjfGr4Ae0W5g6sBMqHHJi8aYuGKeA@mail.gmail.com>
 <612E894E-62C8-4155-AED8-D53702EDC8DC@intel.com> <CA+55aFxeBaTbwvbWqx1MKYjKKzLUs=1O43Bx2=JaO8qrnY-8HA@mail.gmail.com>
 <20180222171506.wwsichkiyc5f74pr@agluck-desk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Feb 2018 09:39:10 -0800
X-Google-Sender-Auth: COh-bZA-DLmz5PO1E0WVL5TsLh4
Message-ID: <CA+55aFyOLYAbvTX0F8WLHgBnhwAPWr7EOPbO_sEepmB5GsCBKQ@mail.gmail.com>
Subject: Re: [PATCH v2] efivarfs: Limit the rate for non-root to read files
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joe Konno <joe.konno@linux.intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 9:15 AM, Luck, Tony <tony.luck@intel.com> wrote:
>
> In efivarfs if the limit is exceeded when reading, we take an
> interruptible nap for 50ms and check the rate limit again.

Ok, turning that 'if' into a 'while' makes the sleeping work even in
the presence of lots of threads, and that all looks very simple.

I'm certainly ok with this. I'm assuming this has been tested and
gives nice warnings too?

               Linus
