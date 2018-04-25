Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754439AbeDYOBk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:01:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56092 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753405AbeDYOBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:01:38 -0400
Date: Wed, 25 Apr 2018 16:01:08 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH v2 3/4] acpi: apei: Do not panic() when correctable
 errors are marked as fatal.
Message-ID: <20180425140108.GA2597@pd.tnic>
References: <20180418175415.GJ4795@pd.tnic>
 <bdc1d19b-3cc1-3f90-d276-414aaacdbd3a@gmail.com>
 <20180419154006.GE3600@pd.tnic>
 <977608e6-9f5d-c523-a78a-993ac5bfd55f@gmail.com>
 <20180419164528.GD5635@pd.tnic>
 <ffe6b459-c80a-d3c0-451d-0d21ae63da54@gmail.com>
 <20180419190323.GF5635@pd.tnic>
 <dba07329-2f85-2bde-85ea-5bdf26fb8df2@gmail.com>
 <20180422104849.GA32754@pd.tnic>
 <70c43399-e8e5-5061-b5a5-451deb5f02fa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70c43399-e8e5-5061-b5a5-451deb5f02fa@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 11:19:25PM -0500, Alex G. wrote:
> That tells you what FFS said about the error.

I betcha those status and command values have a human-readable counterparts.

Btw, what do you abbreviate with "FFS"?

> It's immediately obvious if there's a glaring FFS bug and if we get bogus
> data. If you distrust firmware as much as I do, then you will find great
> value in having such info in the logs. It's probably not too useful to a
> casual user, but then neither is a majority of the system log.

No no, you're missing the point - I *want* all data in the error log
which helps debug a hardware issue. I just want it humanly readable so
that I don't have to jot down the values and go scour the manuals to map
what it actually means.

> You're missing the timing and assuming you will get the hotplug interrupt.
> In this example, you have 22ms between the link down and presence detect
> state change. This is a fairly fast removal.
> 
> Hotplug dependencies aside (you can have the kernel run without PCIe hotplug
> support), I don't think you want to just linger in NMI for dozens of
> milliseconds waiting for presence detect confirmation.

No, I don't mean that. I mean something like deferred processing: you
get an error, you notice it is a device which supports physical removal
so you exit the NMI handler and process the error in normal, process
context which allows you to query the device and say, "Hey device, are
you still there?"

If it is not, you drop all the hw I/O errors reported for it.

Hmmm?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
