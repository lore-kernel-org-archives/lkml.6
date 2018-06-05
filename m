Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeFEIzK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:55:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50756 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751911AbeFEIzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:55:07 -0400
Date: Tue, 5 Jun 2018 10:55:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 8/8] x86/microcode/AMD: Don't scan past the CPU
 equivalence table data
Message-ID: <20180605085506.GB27701@nazgul.tnic>
References: <cover.1526767245.git.mail@maciej.szmigiero.name>
 <04a252b1e06673b8a1f62196093d0573d302fc1b.1526767245.git.mail@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04a252b1e06673b8a1f62196093d0573d302fc1b.1526767245.git.mail@maciej.szmigiero.name>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 12:07:22AM +0200, Maciej S. Szmigiero wrote:
> Currently, the code scanning a CPU equivalence table read from a microcode
> container file assumes that it actually contains a terminating zero entry,
> but if does not then the code will continue the scan past its valid data.
> 
> For the late loader this can be improved by always appending a terminating
> zero entry to such table when loading it.
> This way we don't need an extra global variable for holding the table size
> and we don't have to reject such incomplete tables (for backward
> compatibility with the existing code which didn't do so).
> 
> For the early loader, since we can't allocate memory and have to work
> in-place, let's pass an explicit size of this table to its scanning
> functions so they will know when to stop.

I don't like the difference between early and late here. Just pass
explicit size to the late loader too.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
