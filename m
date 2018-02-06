Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753924AbeBFW4Q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 17:56:16 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:50861 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753650AbeBFW4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 17:56:13 -0500
X-Google-Smtp-Source: AH8x2268AttDFlPakac+t6G3zOK86fV3Agxa9GG9O7nbzlZ5AygYvuEHyoZ8Wb5AXS1oE2EC4dgUmjppmPuXKBEEWO8=
MIME-Version: 1.0
In-Reply-To: <20180206212546.GA2026@light.dominikbrodowski.net>
References: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151787989146.7847.15749181712358213254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206091727.GB15925@isilmar-4.linta.de> <20180206105139.nwlg3fwdxyhhrtc4@gmail.com>
 <20180206212546.GA2026@light.dominikbrodowski.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Feb 2018 14:56:11 -0800
X-Google-Sender-Auth: yVoxDaxi89ryNS-SfDoPdqGoCV4
Message-ID: <CA+55aFwuBi8xTNk8Qe+Hw+4z07GPqAq40mYiiR3V71v_EDzhfw@mail.gmail.com>
Subject: Re: [PATCH tip-pti 1/2] x86/entry: remove SAVE_C_REGS_EXCEPT_* macros
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Ingo Molnar <mingo@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 1:25 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> The macros which save all but specific registers have been unused for
> a long time. Remove them and the SAVE_C_REGS_HELPER macro, but
> instead provide the SAVE_C_REGS macro directly.

Ack. But see my other email about even more cleanups.

At least the SAVE_{C,EXTRA}_REGS -> SAVE_REGS combination cleanup
should be totally mindless, since they are always used together and
with the same argument.

Unless I'm blind.

           Linus
