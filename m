Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755089AbeD3UsU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 16:48:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53050 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754871AbeD3UsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 16:48:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7394D60271
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038
 (issued 65284 msec ago)
To: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
Cc: Dave Young <dyoung@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Vivek Goyal <vgoyal@redhat.com>
References: <8770820b-85a0-172b-7230-3a44524e6c9f@molgen.mpg.de>
 <20180427192207.GG8199@bhelgaas-glaptop.roam.corp.google.com>
 <b62c2a8e-fe14-6d7d-147c-0ce3b0c0ab2f@codeaurora.org>
 <20180427211255.GI8199@bhelgaas-glaptop.roam.corp.google.com>
 <20180428005620.GB1675@dhcp-128-65.nay.redhat.com>
 <20180428011845.GC1675@dhcp-128-65.nay.redhat.com>
 <3ebc908fb196168bf0373875ffc5679e@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <d8d134dc-9757-97cd-7a24-cbb21611d6c6@codeaurora.org>
Date: Mon, 30 Apr 2018 16:48:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3ebc908fb196168bf0373875ffc5679e@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

On 4/28/2018 9:03 AM, okaya@codeaurora.org wrote:
>> Hmm, if it is the remove() method then kexec does not use it.  kexec use
>> the shutdown() method instead.  I missed this details when I replied.
> 
> Portdrv hooks up remove handler to shutdown. That's why remove is getting called.

What should we do about this?

Since there is an actual HW errata involved, should we quirk this root port and
not wait as if remove/shutdown doesn't exist?

Paul,
You might want to file a bugzilla so that we can keep our debug efforts out of this
list.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
