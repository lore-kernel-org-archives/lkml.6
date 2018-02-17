Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbeBQQSD (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 11:18:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:4224 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751033AbeBQQSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 11:18:01 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,525,1511856000";
   d="scan'208";a="205075825"
Date: Sat, 17 Feb 2018 08:17:46 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Peter Jones <pjones@redhat.com>, "Luck, Tony" <tony.luck@intel.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Joe Konno <joe.konno@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Benjamin Drung <benjamin.drung@profitbricks.com>
Subject: Re: [PATCH 0/2] efivars: reading variables can generate SMIs
Message-ID: <20180217161746.GC3231@tassilo.jf.intel.com>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <CAKv+Gu80pJ5tbGoJqBm8CCKrEZXdkE83c944383KbQ5jREUC0Q@mail.gmail.com>
 <1518814319.4419.10.camel@HansenPartnership.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37942B@ORSMSX110.amr.corp.intel.com>
 <20180216220536.liew4p4kqmaxwmfh@redhat.com>
 <CAKv+Gu982mt==TaBRpwLLOLrX03zVJ+RznqCgDrxGNctJUVQVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu982mt==TaBRpwLLOLrX03zVJ+RznqCgDrxGNctJUVQVA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Would rate limiting (but not only for non-root) help mitigate Spectre
> v1 issues in UEFI runtime services code as well? I have been looking
> into unmapping the entire kernel while such calls are in progress,
> because firmware is likely to remain vulnerable long after the OSes
> have been fixed, and we may be able to kill two birds with one stone
> here (and not break userland in the process)

Yes a global rate limit would seem like a good compromise.

-Andi
