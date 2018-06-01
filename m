Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbeFAMms (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:42:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46644 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751301AbeFAMkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:40:39 -0400
Date: Fri, 1 Jun 2018 14:40:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Sironi, Filippo" <sironi@amazon.de>
Cc: "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/MCE: Get microcode revision from cpu_info instead of
 boot_cpu_data
Message-ID: <20180601124035.GB23298@nazgul.tnic>
References: <1527852626-7258-1-git-send-email-sironi@amazon.de>
 <20180601121939.GA23298@nazgul.tnic>
 <56E0BDAC-816A-4F72-A4C6-2747F4A8AA67@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56E0BDAC-816A-4F72-A4C6-2747F4A8AA67@amazon.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 12:32:02PM +0000, Sironi, Filippo wrote:
> I've that patch in my tree already, I can post it.
> I'm still curious on why you'd prefer to use boot_cpu_data for all
> CPUs instead of using cpu_data(m->extcpu) though.

Well, for starters, boot_cpu_data having stale revision is a bug in
itself already. So fixing that is already the Right Thing(tm) to do.

Then, one fine day when the whole cpu_data mess is cleaned up,
boot_cpu_data will morph into the global descriptor representing CPU
features and keeping it uptodate now will facilitate the replacement
without introducing bugs.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
