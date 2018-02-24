Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751485AbeBXUHB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 15:07:01 -0500
Received: from www.llwyncelyn.cymru ([82.70.14.225]:33572 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751428AbeBXUHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 15:07:00 -0500
Date: Sat, 24 Feb 2018 20:06:17 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Joe Konno <joe.konno@linux.intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>, Andi Kleen <ak@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>, Peter Jones <pjones@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Subject: Re: [PATCH 1/2] fs/efivarfs: restrict inode permissions
Message-ID: <20180224200617.75cfe5f2@alans-desktop>
In-Reply-To: <CAKv+Gu--iHii9SxE7RMZKdVdLvQPPGo0wdCzG30xW0+7dakbmw@mail.gmail.com>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
        <20180215182208.35003-2-joe.konno@linux.intel.com>
        <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
        <20180220211849.fqjb6rdmypl6opir@agluck-desk>
        <CA+55aFzjyB=E+=q-W9oYZ7Py7nJwm8YQHFjfbWTib6wvkP9B_A@mail.gmail.com>
        <20180220233008.55rfm7zw62hrao5p@agluck-desk>
        <CA+55aFy8JMLjpDk+sU6pirSZdVqqHtw5oocDAEC7wcHuo5Vssw@mail.gmail.com>
        <3908561D78D1C84285E8C5FCA982C28F7B37DE1B@ORSMSX110.amr.corp.intel.com>
        <CA+55aFwKsa6bq5SUD6wKv8znGcxqjLCPh33a3DkbnUkSfd68Yw@mail.gmail.com>
        <CAKv+Gu--iHii9SxE7RMZKdVdLvQPPGo0wdCzG30xW0+7dakbmw@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2018 09:03:00 +0000
> The thing I like about rate limiting (for everyone including root) is
> that it does not break anybody's workflow (unless EFI variable access
> occurs on a hot path, in which case you're either a) asking for it, or
> b) the guy trying to DoS us), and that it can make exploitation of any
> potential Spectre v1 vulnerabilities impractical at the same time. At

b) doesn't make spectre v1 much harder alas. What matters there is that
you turn on the right CPU protections before calling into EFI and turn
them off afterwards. EFI firmware internally isn't built with retpoline
anyway.

Alan
