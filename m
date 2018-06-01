Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbeFAMT3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:19:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46008 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750790AbeFAMT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:19:26 -0400
Date: Fri, 1 Jun 2018 14:19:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: Filippo Sironi <sironi@amazon.de>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/MCE: Get microcode revision from cpu_info instead of
 boot_cpu_data
Message-ID: <20180601121939.GA23298@nazgul.tnic>
References: <1527852626-7258-1-git-send-email-sironi@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1527852626-7258-1-git-send-email-sironi@amazon.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 01:30:26PM +0200, Filippo Sironi wrote:
> Commit fa94d0c6e0f3 ("x86/MCE: Save microcode revision in machine check
> records") extended MCE entries to report the microcode revision taken
> from boot_cpu_data. Unfortunately, boot_cpu_data isn't updated on late
> microcode loading,

Actually, I'd prefer if we fixed *that* instead by adding:

	/* Update boot_cpu_data's revision too, if we're on the BSP: */
	if (c->cpu_index == boot_cpu_data.cpu_index)
		boot_cpu_data.microcode = <new rev>;

to the end of ->apply_microcode() functions so that boot_cpu_data has
the correct revision too, in case something else queries it.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
