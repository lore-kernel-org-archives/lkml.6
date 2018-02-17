Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbeBQSMl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 13:12:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbeBQSMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 13:12:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BCF217A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AH8x224w1/T7ET4uIHB+zH2sA0VZctiOw5os+JZOtIxefWM6rpzLzPUwFPYQJguhdJHVSihd3B17elwTcAuEYlanpZ4=
MIME-Version: 1.0
In-Reply-To: <CACdnJuvR4NTdCwp=jT3AoW898EXuq6zakfo5hm6dd9mP-SWoGQ@mail.gmail.com>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <CAKv+Gu80pJ5tbGoJqBm8CCKrEZXdkE83c944383KbQ5jREUC0Q@mail.gmail.com>
 <1518814319.4419.10.camel@HansenPartnership.com> <3908561D78D1C84285E8C5FCA982C28F7B37942B@ORSMSX110.amr.corp.intel.com>
 <CALCETrXD4qCwgnDcwnybUXzVk7zyJtzHC2xzLfcZvzrXvAB8PQ@mail.gmail.com>
 <CACdnJutPvMPUTWWjS3oRadQAqn+HpRpY+fhO0pXBj6OsQkAAag@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B3795A3@ORSMSX110.amr.corp.intel.com> <CACdnJuvR4NTdCwp=jT3AoW898EXuq6zakfo5hm6dd9mP-SWoGQ@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Sat, 17 Feb 2018 18:12:18 +0000
X-Gmail-Original-Message-ID: <CALCETrV0+d-f0GeJ3phcQcyJu1_Uj08ST8x0UBnUzTDcwMR-oQ@mail.gmail.com>
Message-ID: <CALCETrV0+d-f0GeJ3phcQcyJu1_Uj08ST8x0UBnUzTDcwMR-oQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] efivars: reading variables can generate SMIs
To: Matthew Garrett <mjg59@google.com>
Cc: Tony Luck <tony.luck@intel.com>, Andrew Lutomirski <luto@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joe Konno <joe.konno@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Andi Kleen <ak@linux.intel.com>,
        Benjamin Drung <benjamin.drung@profitbricks.com>,
        Peter Jones <pjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 10:03 PM, Matthew Garrett <mjg59@google.com> wrote:
> On Fri, Feb 16, 2018 at 2:02 PM Luck, Tony <tony.luck@intel.com> wrote:
>
>> > If the default is 600 then it makes sense to allow a privileged service
> to
>> > selectively make certain variables world readable at runtime.
>
>> As soon as you make one variable world readable you are vulnerable to
>> a local user launching a DoS attack by reading that variable over and over
>> generating a flood of SMIs.
>
> I'm not terribly worried about untrusted users on my laptop, but I would
> prefer to run as little code as root as possible.

I think that, for the most part, systemwide configuration should not
be accessible to non-root.  Unprivileged users, in general, have no
legitimate reason to know that my default boot is Boot0000* Fedora
HD(1,GPT,ee...,0x800,0x64000)/File(\EFI\fedora\shim.efi).  Even more
so if I'm network booting.

Alternatively, we could call this a distro issue.  Distros could
easily change the permissions on /sys/firmware/efi/efivars to disallow
unprivileged access.
