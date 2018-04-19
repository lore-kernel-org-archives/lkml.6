Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753505AbeDSPrU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:47:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36814 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753073AbeDSPrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:47:16 -0400
Date: Thu, 19 Apr 2018 17:46:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com
Subject: Re: [RFC PATCH v2 4/4] acpi: apei: Warn when GHES marks correctable
 errors as "fatal"
Message-ID: <20180419154656.GF3600@pd.tnic>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180416215903.7318-5-mr.nuke.me@gmail.com>
 <20180418175452.GK4795@pd.tnic>
 <807002b1-ccb9-22c8-6563-ade7e44912ff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <807002b1-ccb9-22c8-6563-ade7e44912ff@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 10:11:03AM -0500, Alex G. wrote:
> There is value in this. From my observations, fw claims it will do
> everything through FFS, yet fails to fully handle the situation. It's
> rooted in FW's assumptions about OS behavior. Because the (old) versions
> of windows, esxi, and rhel used during development crash, fw assumes
> that _all_ OSes crash. The result in a surprising majority of cases is
> that FFS doesn't properly handle recurring errors, and fw is, in fact,
> broken.

So FW being broken is a social secret. But we don't care. We have tried,
nothing happens. No one moves. The crack monkeys which program it have
long moved to the next release and you hear crap like, "we don't support
linux" and other bullshit.

What we do now is to try to make the best of it - we either can handle
an error *without* firmware's help or we panic. If we can recover from
it, let's do that without screaming about something the user can't deal
with anyway.

All those FW_ERR printks cause nothing but expensive support calls, the
outcome of which is nothing. Just a lot of money down the drain.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
