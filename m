Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbeBPWDv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 17:03:51 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:51641 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeBPWDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 17:03:48 -0500
X-Google-Smtp-Source: AH8x225HbPfQeMhS641DK5efV/Pmn94Oe3XHmM0tWG3kZpb3721pyJetTxxfq+1H87U0fUrFjlTEtQotCBlJGmQ0MrM=
MIME-Version: 1.0
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <CAKv+Gu80pJ5tbGoJqBm8CCKrEZXdkE83c944383KbQ5jREUC0Q@mail.gmail.com>
 <1518814319.4419.10.camel@HansenPartnership.com> <3908561D78D1C84285E8C5FCA982C28F7B37942B@ORSMSX110.amr.corp.intel.com>
 <CALCETrXD4qCwgnDcwnybUXzVk7zyJtzHC2xzLfcZvzrXvAB8PQ@mail.gmail.com>
 <CACdnJutPvMPUTWWjS3oRadQAqn+HpRpY+fhO0pXBj6OsQkAAag@mail.gmail.com> <3908561D78D1C84285E8C5FCA982C28F7B3795A3@ORSMSX110.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7B3795A3@ORSMSX110.amr.corp.intel.com>
From: Matthew Garrett <mjg59@google.com>
Date: Fri, 16 Feb 2018 22:03:37 +0000
Message-ID: <CACdnJuvR4NTdCwp=jT3AoW898EXuq6zakfo5hm6dd9mP-SWoGQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] efivars: reading variables can generate SMIs
To: tony.luck@intel.com
Cc: luto@kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, joe.konno@linux.intel.com,
        mingo@kernel.org, bp@alien8.de, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jk@ozlabs.org, ak@linux.intel.com, benjamin.drung@profitbricks.com,
        pjones@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 2:02 PM Luck, Tony <tony.luck@intel.com> wrote:

> > If the default is 600 then it makes sense to allow a privileged service
to
> > selectively make certain variables world readable at runtime.

> As soon as you make one variable world readable you are vulnerable to
> a local user launching a DoS attack by reading that variable over and over
> generating a flood of SMIs.

I'm not terribly worried about untrusted users on my laptop, but I would
prefer to run as little code as root as possible.
