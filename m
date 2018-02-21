Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeBUAtS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 19:49:18 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:40622 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbeBUAtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 19:49:15 -0500
X-Google-Smtp-Source: AG47ELuDvKmhNzdjPL74zM59W+Kh8/aajJanrSlWvwuhYc1doQBCtNSunc//5QTSUmb4usnVP4RBilxolK80yjwxuVQ=
MIME-Version: 1.0
In-Reply-To: <20180220233008.55rfm7zw62hrao5p@agluck-desk>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <20180215182208.35003-2-joe.konno@linux.intel.com> <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
 <20180220211849.fqjb6rdmypl6opir@agluck-desk> <CA+55aFzjyB=E+=q-W9oYZ7Py7nJwm8YQHFjfbWTib6wvkP9B_A@mail.gmail.com>
 <20180220233008.55rfm7zw62hrao5p@agluck-desk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Feb 2018 16:49:14 -0800
X-Google-Sender-Auth: 5ysrwbO2sU8z0hnTDvf6f7BkDKQ
Message-ID: <CA+55aFy8JMLjpDk+sU6pirSZdVqqHtw5oocDAEC7wcHuo5Vssw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/efivarfs: restrict inode permissions
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Joe Konno <joe.konno@linux.intel.com>, linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>, Andi Kleen <ak@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>, Peter Jones <pjones@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 3:30 PM, Luck, Tony <tony.luck@intel.com> wrote:
>
> Too much weasel there.  Should say:
>
> EFI[1] stinks. Reading any file in /sys/firmware/efi/efivars/ generates
> 4 (yes FOUR!) SMIs.

Is that actualkly the normal implementation?

Also, if these are just synchronous SMI's, then don't we just end up
correctly assigning the CPU load to the reader, and it doesn't
actually matter? Where's the DoS?

                 Linus
