Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935433AbeBPLSP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:18:15 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:52816 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935394AbeBPLSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:18:14 -0500
X-Google-Smtp-Source: AH8x227uZ5TqbDmv6qTtZvUo+h9S+eA36S5yUnVXCUiekqUXbfVf4f8Gy1cNIRDG9rk8ygfqqTVbKLpu16oW6MV9VAk=
MIME-Version: 1.0
In-Reply-To: <20180216110821.GB29042@pd.tnic>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <CAKv+Gu80pJ5tbGoJqBm8CCKrEZXdkE83c944383KbQ5jREUC0Q@mail.gmail.com>
 <20180216105548.GA29042@pd.tnic> <CAKv+Gu8qm2wFxY56-eRLkLZB6fRUCmZbZo=4cvo5e4JDFh01Gg@mail.gmail.com>
 <20180216110821.GB29042@pd.tnic>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 16 Feb 2018 11:18:12 +0000
Message-ID: <CAKv+Gu_SD6yWJMGbTwGUWXtrgZKPkpANNaGe1PUruTG9j0yhcg@mail.gmail.com>
Subject: Re: [PATCH 0/2] efivars: reading variables can generate SMIs
To: Borislav Petkov <bp@alien8.de>
Cc: Joe Konno <joe.konno@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Benjamin Drung <benjamin.drung@profitbricks.com>,
        Peter Jones <pjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 February 2018 at 11:08, Borislav Petkov <bp@alien8.de> wrote:
> On Fri, Feb 16, 2018 at 10:58:47AM +0000, Ard Biesheuvel wrote:
>> By your own reasoning above, that's a no-no as well.
>
> I'm sure we can come up with some emulation - the same way we did the
> BIOS emulation.
>
>> But thanks for your input. Anyone else got something constructive to contribute?
>
> The not-breaking userspace is constructive contribution. The last
> paragraph is my usual rant.
>

Fair enough. And I am not disagreeing with you either.

So question to Joe: is it well defined which variables may exhibit
this behavior? Given that UEFI variables are GUID scoped, would
whitelisting certain GUIDs (the ones userland currently relies on to
be readable my non-privileged users) and making everything else
user-only solve this problem as well?
