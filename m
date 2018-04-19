Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbeDSQpt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:45:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39110 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753573AbeDSQpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:45:47 -0400
Date: Thu, 19 Apr 2018 18:45:28 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com
Subject: Re: [RFC PATCH v2 3/4] acpi: apei: Do not panic() when correctable
 errors are marked as fatal.
Message-ID: <20180419164528.GD5635@pd.tnic>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180416215903.7318-4-mr.nuke.me@gmail.com>
 <20180418175415.GJ4795@pd.tnic>
 <bdc1d19b-3cc1-3f90-d276-414aaacdbd3a@gmail.com>
 <20180419154006.GE3600@pd.tnic>
 <977608e6-9f5d-c523-a78a-993ac5bfd55f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <977608e6-9f5d-c523-a78a-993ac5bfd55f@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 11:26:57AM -0500, Alex G. wrote:
> At a very high level, I'm working with Dell on improving server
> reliability, with a focus on NVME hotplug and surprise removal. One of
> the features we don't support is surprise removal of NVME drives;
> hotplug is supported with 'prepare to remove'. This is one of the
> reasons NVME is not on feature parity with SAS and SATA.

Ok, first question: is surprise removal something purely mechanical or
do you need firmware support for it? In the sense that you need to tell
the firmware that you will be removing the drive.

I'm sceptical, though, as it has "surprise" in the name so I'm guessing
the firmware doesn't know about it, the drive physically disappears and
the FW starts spewing PCIe errors...

> I'm not sure if this is the example you're looking for, but
> take an r740xd server, and slowly unplug an Intel NVME drives at an
> angle. You're likely to crash the machine.

No no, that's actually a great example!

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
