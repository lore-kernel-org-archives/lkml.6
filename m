Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeEVR5r (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:57:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:35196 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751291AbeEVR5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:57:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="60810705"
Date: Tue, 22 May 2018 10:57:42 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Alex G." <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, alex_gagniuc@dellteam.com,
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
Message-ID: <20180522175742.GA3543@agluck-desk>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com>
 <20180521135003.32459-2-mr.nuke.me@gmail.com>
 <CAJZ5v0hKfgTOJb47NjeOP1BBPXPjWqdfu_TXVwWMzOHicEx0Xw@mail.gmail.com>
 <53d0ba88-6929-a7cf-6c3e-4ca389f7249a@gmail.com>
 <20180522135015.GF5512@pd.tnic>
 <0b758a1c-90e3-6f76-4f83-1e22c8fc9cd6@gmail.com>
 <20180522145426.GG5512@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522145426.GG5512@pd.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 04:54:26PM +0200, Borislav Petkov wrote:
> I especially don't want to have the case where a PCIe error is *really*
> fatal and then we noodle in some handlers debating about the severity
> because it got marked as recoverable intermittently and end up causing
> data corruption on the storage device. Here's a real no-no for ya.

All that we have is a message from the BIOS that this is a "fatal"
error.  When did we start trusting the BIOS to give us accurate
information?

PCIe fatal means that the link or the device is broken. But that
seems a poor reason to take down a large server that may have
dozens of devices (some of them set up specifically to handle
errors ... e.g. mirrored disks on separate controllers, or NIC
devices that have been "bonded" together).

So, as long as the action for a "fatal" error is to mark a link
down and offline the device, that seems a pretty reasonable course
of action.

The argument gets a lot more marginal if you simply reset the
link and re-enable the device to "fix" it. That might be enough,
but I don't think the OS has enough data to make the call.

-Tony

P.S. I deliberately put "fatal" in quotes above because to
quote "The Princess Bride" -- "that word, I do not think it
means what you think it means". :-)
