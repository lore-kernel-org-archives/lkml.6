Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeEKQUH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 12:20:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58154 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751859AbeEKQUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 12:20:05 -0400
Date: Fri, 11 May 2018 18:19:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org
Subject: Re: [RFC PATCH v4 2/3] acpi: apei: Rename ghes_severity() to
 ghes_cper_severity()
Message-ID: <20180511161933.GG12705@pd.tnic>
References: <20180430212836.7807-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-2-mr.nuke.me@gmail.com>
 <20180511153947.GC12705@pd.tnic>
 <56d445b2-ace3-6ee2-9699-f2a684518de9@gmail.com>
 <20180511155833.GE12705@pd.tnic>
 <f70e209d-00ec-1969-16de-09d6142668da@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f70e209d-00ec-1969-16de-09d6142668da@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 11:12:24AM -0500, Alex G. wrote:
> Because the GHES structure uses CPER values, but all the code is written
> to use GHES_SEV_ values. GHES_SEV_ is a made up enum, specifically for
> linux.

Again, what does that even matter?

They're defines in both cases. The *actual* value means shit.

Ah, I see it:

	...
		sec_sev = ghes_sec_pcie_severity(gdata);

	worst_sev = max(worst_sev, sec_sev);


Yeah, no, you can't do that. No apples and oranges comparisons.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
