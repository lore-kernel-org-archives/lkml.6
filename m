Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbeDSP34 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:29:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35906 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752831AbeDSP3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:29:54 -0400
Date: Thu, 19 Apr 2018 17:29:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com
Subject: Re: [RFC PATCH v2 2/4] acpi: apei: Split GHES handlers outside of
 ghes_do_proc
Message-ID: <20180419152933.GD3600@pd.tnic>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180416215903.7318-3-mr.nuke.me@gmail.com>
 <20180418175201.GI4795@pd.tnic>
 <5f26275c-5896-c552-69c4-78e5aaaa6558@gmail.com>
 <20180419143018.GC3600@pd.tnic>
 <8f467611-16a1-8fe7-ea12-e2e29023e4e8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f467611-16a1-8fe7-ea12-e2e29023e4e8@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 09:57:08AM -0500, Alex G. wrote:
> And that was the motivation behind my splitting it in this patch.

By "split" I don't mean add a function pointer which gets selected and
then called - if the function becomes too long, you simply split the
function body properly.

> You don't need the entire GHES structure -- wide context. Individual
> handlers should not be able to access the entire ghes.

But you remove the @ghes argument in patch 1. So what are we even
talking about?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
