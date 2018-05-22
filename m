Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeEVSKu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:10:50 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:38269 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751902AbeEVSKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:10:48 -0400
X-Google-Smtp-Source: AB8JxZoDWtuWjzyzmAWd9GpK9TTWBfDu2/rTrtzawmvNNREgxpVGiPyJ4xZB2V66D5sIcm5Ik7fp1ZX+aAGRS2LLPMg=
MIME-Version: 1.0
In-Reply-To: <20180522175742.GA3543@agluck-desk>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com> <20180521135003.32459-2-mr.nuke.me@gmail.com>
 <CAJZ5v0hKfgTOJb47NjeOP1BBPXPjWqdfu_TXVwWMzOHicEx0Xw@mail.gmail.com>
 <53d0ba88-6929-a7cf-6c3e-4ca389f7249a@gmail.com> <20180522135015.GF5512@pd.tnic>
 <0b758a1c-90e3-6f76-4f83-1e22c8fc9cd6@gmail.com> <20180522145426.GG5512@pd.tnic>
 <20180522175742.GA3543@agluck-desk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 May 2018 20:10:47 +0200
X-Google-Sender-Auth: jOTbGn1e_7DgZndDln0LdtwB-a0
Message-ID: <CAJZ5v0j1E-kg3RPcasSJn=uZj9uaZcL4Zw9tp4mJgnsbWcPWbw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] acpi: apei: Rename ghes_severity() to ghes_cper_severity()
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, "Alex G." <mr.nuke.me@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 7:57 PM, Luck, Tony <tony.luck@intel.com> wrote:
> On Tue, May 22, 2018 at 04:54:26PM +0200, Borislav Petkov wrote:
>> I especially don't want to have the case where a PCIe error is *really*
>> fatal and then we noodle in some handlers debating about the severity
>> because it got marked as recoverable intermittently and end up causing
>> data corruption on the storage device. Here's a real no-no for ya.
>
> All that we have is a message from the BIOS that this is a "fatal"
> error.  When did we start trusting the BIOS to give us accurate
> information?

Some time ago, actually.

This is about changing the existing behavior which has been to treat
"fatal" errors reported by the BIOS as good enough reasons for a panic
for quite a while AFAICS.

> PCIe fatal means that the link or the device is broken.

And that may really mean that the component in question is on fire.
We just don't know.

> But that seems a poor reason to take down a large server that may have
> dozens of devices (some of them set up specifically to handle
> errors ... e.g. mirrored disks on separate controllers, or NIC
> devices that have been "bonded" together).
>
> So, as long as the action for a "fatal" error is to mark a link
> down and offline the device, that seems a pretty reasonable course
> of action.
>
> The argument gets a lot more marginal if you simply reset the
> link and re-enable the device to "fix" it. That might be enough,
> but I don't think the OS has enough data to make the call.

Again, that's about changing the existing behavior or the existing policy even.

What exactly has changed to make us consider this now?

Thanks,
Rafael
