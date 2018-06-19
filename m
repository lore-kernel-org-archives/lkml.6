Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8475BC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F8A2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrjE6eoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F8A2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbeFSWUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:20:34 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36866 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeFSWUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:20:31 -0400
Received: by mail-ot0-f196.google.com with SMTP id 101-v6so1505890oth.4;
        Tue, 19 Jun 2018 15:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f/Wcmh59EFi9Tk5Yq+sGuzyYaBJptFCOOLX9okkvuFA=;
        b=SrjE6eoPUbkDTlCees/3YIDfz7L4+boo6Q5XcVecJBZGpS9UjVcTuhzPZmeEAU6tzo
         /GKiw9QFc7O8qNJNQa5f6av79i/9DVYyl7fyHRI2aWB4fTPFAM7YbBbVfoyl6LFZr+EU
         xxcTPeDtIKRv641z6UTUGVRr5rE1WqWGtuoPNfrYcOdiLjpioeyLnDmTU3rXoN2svoPN
         yGpVXHUJbt2H4L03ff9Sw1asK0/LFiLYDyykAFiOUuvgXLA/dSP4eAVFJOAkTod8i7YB
         2q70Hdbb+On6zIzKDrZEjuZORVV5MAZZvezhXuz4ixv743hC5HS/eM5N1yjLTRSS1nHK
         56YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f/Wcmh59EFi9Tk5Yq+sGuzyYaBJptFCOOLX9okkvuFA=;
        b=tjc43Ei3MSqlUVxmqQe7StITCX9huqjmWxbbDGoQUpoWtzXXrOjnsP/5H/fBdxd13t
         b48MtCE4GRnIG2JXPvjdsaHycML2oxjH5Cmqnjl+a4r87VBNNIaf6vZOTjejNRwNvpDx
         ss3wnPZ7qlEPGaMlKI/VafIBwSeKGnj6Tj5sv5Tpxd1hEdoT1iWKqLia8S7CQl4mdeIL
         uBKTS3u4HALiY/FOTHAAvAowvP59wMJUdw4YAzWrtKgHnEd0IA9JkILhlsYXeIkXnTRy
         kYvrWZgLL2UymKK75DNDIQngpa0dPMXg6bHBq3AmHA4MWmsYOaE+VDvUZFiI4HzJ04OH
         rlvg==
X-Gm-Message-State: APt69E2FXpqUHgwfVvV2nqPxEHM2cshLBqBU51eUyafhOXosILl6GD2w
        bfDL5DRC5kwC4Jh0tCy6PD0=
X-Google-Smtp-Source: ADUXVKLrnilJdusM6PAOwBme4INWrnwXBYbqtQCaXUYusXLmddUuiOcZ+6XA7q/6sYz+o14ezw7rCA==
X-Received: by 2002:a9d:5550:: with SMTP id h16-v6mr10667587oti.24.1529446830372;
        Tue, 19 Jun 2018 15:20:30 -0700 (PDT)
Received: from nuclearis2_1.gtech (c-98-201-114-184.hsd1.tx.comcast.net. [98.201.114.184])
        by smtp.gmail.com with ESMTPSA id u14-v6sm450042otf.26.2018.06.19.15.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 15:20:29 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Expose PCIe AER stats via sysfs
To:     Bjorn Helgaas <helgaas@kernel.org>, Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com
References: <20180522222805.80314-1-rajatja@google.com>
 <20180523175808.28030-1-rajatja@google.com>
 <20180619221651.GH33049@bhelgaas-glaptop.roam.corp.google.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <c6a5f1ca-a3da-4dd8-1178-a017d6d771c6@gmail.com>
Date:   Tue, 19 Jun 2018 17:20:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180619221651.GH33049@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/19/2018 05:16 PM, Bjorn Helgaas wrote:
> On Wed, May 23, 2018 at 10:58:03AM -0700, Rajat Jain wrote:
>> This patchset exposes the AER stats via the sysfs attributes.
>>
>> Patchset v2 has minor changes to v1 based on the review comments,
>> no functional change.
>> Primarily:
>>  * Fix license header
>>  * Use tabs instead of spaces
>>  * Remove use on unlikely() etc
>>  * Move documentation to Documentation/ABI/
>>
>> Rajat Jain (5):
>>   PCI/AER: Define and allocate aer_stats structure for AER capable
>>     devices
>>   PCI/AER: Add sysfs stats for AER capable devices
>>   PCI/AER: Add sysfs attributes to provide breakdown of AERs
>>   PCI/AER: Add sysfs attributes for rootport cumulative stats
>>   Documentation/ABI: Add details of PCI AER statistics
>>
>>  .../testing/sysfs-bus-pci-devices-aer_stats   | 103 ++++++++++
>>  Documentation/PCI/pcieaer-howto.txt           |   5 +
>>  drivers/pci/pci-sysfs.c                       |   3 +
>>  drivers/pci/pci.h                             |   4 +-
>>  drivers/pci/pcie/aer/Makefile                 |   2 +-
>>  drivers/pci/pcie/aer/aerdrv.h                 |  15 ++
>>  drivers/pci/pcie/aer/aerdrv_core.c            |  11 +
>>  drivers/pci/pcie/aer/aerdrv_errprint.c        |   7 +-
>>  drivers/pci/pcie/aer/aerdrv_stats.c           | 192 ++++++++++++++++++
>>  drivers/pci/probe.c                           |   1 +
>>  include/linux/pci.h                           |   3 +
>>  11 files changed, 342 insertions(+), 4 deletions(-)
>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
>>  create mode 100644 drivers/pci/pcie/aer/aerdrv_stats.c
> 
> I broke this by putting all the AER code in one file in v4.18-rc1,

I see the next phoronix headline:

"Linux maintainer breaks things and watches in amusement as contributors
rush to the fix"

;)
Alex

> sorry!  Would you mind rebasing these on top of that?
> 
> Since everything AER-related is now in aer.c, I'd suggest putting the
> stats code there, too.
> 
