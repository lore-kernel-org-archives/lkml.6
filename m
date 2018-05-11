Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeEKQMd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 12:12:33 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34218 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbeEKQM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 12:12:28 -0400
X-Google-Smtp-Source: AB8JxZqfPLil9Qr3KAX22dBU25EH/efrZFPuVTefS0TNFJ6aP/E/uU88atvefrK1Hy7xXHwoCnIvHA==
Subject: Re: [RFC PATCH v4 3/3] acpi: apei: Do not panic() on PCIe errors
 reported through GHES
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
 <20180430213358.8319-3-mr.nuke.me@gmail.com> <20180511154039.GD12705@pd.tnic>
 <8e3c0cc6-9c5c-85ce-650c-8f498f5907da@gmail.com>
 <20180511160253.GF12705@pd.tnic>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <45b7be09-c9b3-8006-6ea0-36b4ff38607c@gmail.com>
Date: Fri, 11 May 2018 11:12:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180511160253.GF12705@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/11/2018 11:02 AM, Borislav Petkov wrote:
> On Fri, May 11, 2018 at 10:54:09AM -0500, Alex G. wrote:
>> That being clarified, should I replace "crackmonkey" with "broken" in
>> the commit message?
> 
> Keep your opinion *outside* of commit messages - their goal is to
> explain *why* the change is being made in strictly technical language so
> that when someone looks at git history, someone can know *why*.
> 
>> Borislav, I sense some confusion. AER is not a "reporting" driver. It
>> handles the errors. You can't leave these errors unhandled. They
>> propagate to the root complex and can cause fatal MCEs when not handled.
>> The window to handle the error is pretty large, so it's not a concern
>> when you're handling it.
> 
> I think *you* didn't get it: IS_ENABLED(CONFIG_ACPI_APEI_PCIEAER) is not
> enough of a check to confirm that there actually *is* an AER driver to
> handle the errors. If you really want to make sure the driver is loaded
> and functioning, then you need an explicit registering mechanism or some
> other way of checking it really is there and handling errors.

config ACPI_APEI_PCIEAER
	bool "APEI PCIe AER logging/recovering support"
	depends on ACPI_APEI && PCIEAER
	help
	  PCIe AER errors may be reported via APEI firmware first mode.
	  Turn on this option to enable the corresponding support.

PCIAER is not modularizable. QED

Alex
