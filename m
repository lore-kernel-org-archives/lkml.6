Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeEKP7A (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:59:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57380 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750876AbeEKP67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:58:59 -0400
Date: Fri, 11 May 2018 17:58:33 +0200
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
Message-ID: <20180511155833.GE12705@pd.tnic>
References: <20180430212836.7807-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-2-mr.nuke.me@gmail.com>
 <20180511153947.GC12705@pd.tnic>
 <56d445b2-ace3-6ee2-9699-f2a684518de9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56d445b2-ace3-6ee2-9699-f2a684518de9@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 10:45:49AM -0500, Alex G. wrote:
> 
> 
> On 05/11/2018 10:39 AM, Borislav Petkov wrote:
> > On Mon, Apr 30, 2018 at 04:33:51PM -0500, Alexandru Gagniuc wrote:
> >> ghes_severity() is a misnomer in this case, as it implies the severity
> >> of the entire GHES structure. Instead, it maps one CPER value to a
> >> monotonically increasing number.
> > 
> > ... as opposed to CPER severity which is something else or what is this
> > formulation trying to express?
> > 
> 
> CPER madness goes like this:

Let's slow down first. Why is it a "CPER madness"? Maybe this is clear
in your head but I'm not in it.

> 	0 - Recoverable
> 	1 - Fatal
> 	2 - Corrected
> 	3 - None

If you're quoting this:

enum {
        CPER_SEV_RECOVERABLE,
        CPER_SEV_FATAL,
        CPER_SEV_CORRECTED,
        CPER_SEV_INFORMATIONAL,
};

that last 3 is informational.

> As you can see, the numbering was created by crackmonkeys. GHES_* is an
> internal enum that goes up in order of severity, as you'd expect.

So what are you trying to tell me - that those CPER numbers are not
increasing?!

Why does that even matter?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
