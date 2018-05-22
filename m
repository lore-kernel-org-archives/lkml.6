Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751726AbeEVSph (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:45:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:58433 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751319AbeEVSpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:45:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="60823261"
Date: Tue, 22 May 2018 11:45:33 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Borislav Petkov <bp@alien8.de>, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] acpi: apei: Rename ghes_severity() to
 ghes_cper_severity()
Message-ID: <20180522184532.GA4360@agluck-desk>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com>
 <20180521135003.32459-2-mr.nuke.me@gmail.com>
 <CAJZ5v0hKfgTOJb47NjeOP1BBPXPjWqdfu_TXVwWMzOHicEx0Xw@mail.gmail.com>
 <53d0ba88-6929-a7cf-6c3e-4ca389f7249a@gmail.com>
 <20180522135015.GF5512@pd.tnic>
 <0b758a1c-90e3-6f76-4f83-1e22c8fc9cd6@gmail.com>
 <20180522145426.GG5512@pd.tnic>
 <20180522175742.GA3543@agluck-desk>
 <CAJZ5v0j1E-kg3RPcasSJn=uZj9uaZcL4Zw9tp4mJgnsbWcPWbw@mail.gmail.com>
 <5dc58180-d3c0-a9f0-282f-4be433c94052@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc58180-d3c0-a9f0-282f-4be433c94052@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 01:19:34PM -0500, Alex G. wrote:
> Firmware started passing "fatal" GHES headers with the explicit intent of
> crashing an OS. At the same time, we've learnt how to handle these errors in
> a number of cases. With DPC (coming soon to firmware-first) the error is
> contained, and a non-issue.

Perhaps DPC is the change that you need to emphasize as to
why things are different now, so we can change the default
Linux behavior.

With the h/w guaranteeing that corrupt data is contained, we
should be safe to disregard BIOS indications of "fatal" problems
that could be anything and might show up in unknown ways some
time later if we keep running.

-Tony
