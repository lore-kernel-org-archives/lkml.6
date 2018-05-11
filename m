Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeEKPpz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:45:55 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:42919 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeEKPpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:45:52 -0400
X-Google-Smtp-Source: AB8JxZqzIvEEeA7WRAVB3b0QePEcy3BSsQIsKEiqV5jp9Z6x3Ypmf4tJp8SdAUPZD3oQFzTQW58kKA==
Subject: Re: [RFC PATCH v4 2/3] acpi: apei: Rename ghes_severity() to
 ghes_cper_severity()
To: Borislav Petkov <bp@alien8.de>
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
References: <20180430212836.7807-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-2-mr.nuke.me@gmail.com> <20180511153947.GC12705@pd.tnic>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <56d445b2-ace3-6ee2-9699-f2a684518de9@gmail.com>
Date: Fri, 11 May 2018 10:45:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180511153947.GC12705@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/11/2018 10:39 AM, Borislav Petkov wrote:
> On Mon, Apr 30, 2018 at 04:33:51PM -0500, Alexandru Gagniuc wrote:
>> ghes_severity() is a misnomer in this case, as it implies the severity
>> of the entire GHES structure. Instead, it maps one CPER value to a
>> monotonically increasing number.
> 
> ... as opposed to CPER severity which is something else or what is this
> formulation trying to express?
> 

CPER madness goes like this:
	0 - Recoverable
	1 - Fatal
	2 - Corrected
	3 - None

As you can see, the numbering was created by crackmonkeys. GHES_* is an
internal enum that goes up in order of severity, as you'd expect.

If you're confused, you're not alone. I've seen several commit messages
that get this terminology wrong.

Alex
