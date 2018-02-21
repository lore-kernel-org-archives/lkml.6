Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935359AbeBUNAk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 08:00:40 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44013 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935329AbeBUNAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 08:00:34 -0500
X-Google-Smtp-Source: AH8x226pnJpc3Uvgv+Nk5b0a+icWx8acsneLCVbV/NGLwrn6qQWQgin+eUBUb8DkS5WuHvZH43Uml+l8ECGROQrZNN0=
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-PR4mS+oB6fdGhpG3Fp+OhZUr=KkbueOoC9YpmDQgeqQ@mail.gmail.com>
References: <20180220215954.4092811-1-arnd@arndb.de> <20180220215954.4092811-4-arnd@arndb.de>
 <CAKv+Gu-Be_saZeHzpWrjJBdeiOSJih0H-d1pjkpj+sq7ytLVyw@mail.gmail.com>
 <CAK8P3a11uyLcB=42ZTFOMDvxv5XZ3tCPh+f_MN6SEAjmPRRjtg@mail.gmail.com> <CAKv+Gu-PR4mS+oB6fdGhpG3Fp+OhZUr=KkbueOoC9YpmDQgeqQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 21 Feb 2018 14:00:33 +0100
X-Google-Sender-Auth: W-86kbpHQ2J8hcgGH_d_MCGDMhA
Message-ID: <CAK8P3a15V4wHQJ=kjZz-V-R1HuP4pd3m+FoZbt_myvUCR6souw@mail.gmail.com>
Subject: Re: [PATCH 3/7] [HACK] pass endianess flag to LTO linker
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 11:09 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 21 February 2018 at 09:48, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wed, Feb 21, 2018 at 9:37 AM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> On 20 February 2018 at 21:59, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> In some cases we turn off
>> some optimization step for a file, we might remove '-pg', or build for
>> a particular target architecture. Do we have to turn off -flto for any file
>> that requires this for correct behavior?
>>
>
> Excellent question. I think the problem is that the file boundary is
> becoming blurred with LTO, and so any option that is absolutely
> required to build a single file correctly may need to be applied to
> vmlinux as a whole. Whether that is the case for any particular option
> depends on which compiler pass(es) is (are) affected by the option,
> i.e., whether it is taken into account when creating the intermediate
> representation.

Newer compilers are able to change both the optimization and warning
flags per function using a #pragma or _Pragma() directive or
function attributes.
There has been some recent discussion about requiring a newer gcc
version, so if we do that, we could perhaps replace all the existing
CFLAGS overrides with those pragmas.

     Arnd
