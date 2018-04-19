Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeDSPqT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:46:19 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46167 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752332AbeDSPqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:46:17 -0400
X-Google-Smtp-Source: AIpwx4/8cKw+H7ijQgfFghFSdpy/5h8Ht+JT2nCUzG6NGEK+eKfbA2SeoYboKL/cfDyiBJRblXTS1w==
Subject: Re: [RFC PATCH v2 2/4] acpi: apei: Split GHES handlers outside of
 ghes_do_proc
To: Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180416215903.7318-3-mr.nuke.me@gmail.com> <20180418175201.GI4795@pd.tnic>
 <5f26275c-5896-c552-69c4-78e5aaaa6558@gmail.com>
 <20180419143018.GC3600@pd.tnic>
 <8f467611-16a1-8fe7-ea12-e2e29023e4e8@gmail.com>
 <20180419152933.GD3600@pd.tnic>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <b9887ae1-8d7e-cfff-3933-d9358283a3c4@gmail.com>
Date: Thu, 19 Apr 2018 10:46:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180419152933.GD3600@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/19/2018 10:29 AM, Borislav Petkov wrote:
> On Thu, Apr 19, 2018 at 09:57:08AM -0500, Alex G. wrote:
>> And that was the motivation behind my splitting it in this patch.
> 
> By "split" I don't mean add a function pointer which gets selected and
> then called - if the function becomes too long, you simply split the
> function body properly.

The bulk of the function is the if/else mapping from UUID to error
handler. I don't see how that can be easily split up, hence why I
originally resorted to the mapping. As you said, we'll keep it simple at
first.

>> You don't need the entire GHES structure -- wide context. Individual
>> handlers should not be able to access the entire ghes.
> 
> But you remove the @ghes argument in patch 1. So what are we even
> talking about?

You could say, by convention, handlers shouldn't access ghes directly,
but that is not obvious when @ghes is in scope. The reason I bring it up
is that, if [1/4] ends up being unneeded, then I will drop it from the
series.

Alex
