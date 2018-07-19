Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB51ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DFA2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtvSLHJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DFA2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbeGSQdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:33:44 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:39847 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731661AbeGSQdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:33:44 -0400
Received: by mail-io0-f195.google.com with SMTP id o22-v6so6400394ioh.6;
        Thu, 19 Jul 2018 08:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rJdMZXwu3uCJ+o7UcwwH3hruC86qsd3iAj2cY0XoJmI=;
        b=PtvSLHJqRPBadKRLjFU3eRQCtleYkxUKgFeo4y+98OrwKqCiSDf35VrA3iVFSa9w/+
         a+2nLX2xzwKy+lUWGY2dK3WGncimPKBRtOUd/nb6BqeUFXSyRH0kPxJaiyPuxjRVAeI6
         ugEQVWq3REzzkWcEbj47Igb7NtHVQH0vJMCK6enYzdtqsBOPMLWeoGgNZqYO4EVuLW2b
         Q3+cKEtYZrkBD44he8MaBdQEOgrBtXUM7CY7BivIBJ27vPL5w/xwlyR6Stu3Ps62UV+j
         vVnIW/KwBKxi0pC6C12Y+KhUarYr+rlIaZGKk+g7LHd3X2g8duQesfvqLX6CZ09ad/U6
         3kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rJdMZXwu3uCJ+o7UcwwH3hruC86qsd3iAj2cY0XoJmI=;
        b=K0NR1S/ABwUli9MR41HK7AkxkPWO1znoFAPajad/f0mlZLmZgaLqnkCKVX7Q6YjAhR
         qCAGju8ib+1ZaurF6CXX0XE3jeZgUz5qDoYTtpiYf7P5qrVdUQ6sDAJo65Prr+1wFUCq
         7tuH+btoCMYF4HhW1JPYYujjsL5uDBUSjTGf97qiS4x3VZKMb9i22zwzyMFOgepJGWl1
         ZMo9PzC6tTVbdMze5z1twKrXpGypvqVtNMinTwFTOvhRJx5tDINkfmSd6X8DCjQ54QM8
         bIzOsLIBwC/tRLHQ3hPMjPDTXpN5F6ZW5owt/D+U6onUEAS7pdsu8Ya1bTZu1zcjzmpC
         yVvQ==
X-Gm-Message-State: AOUpUlEHU3V7uSxY8/nla5LjE6d3tT0ffpa1F40fhMqWZp12xUDVGXtU
        2HyCzvQwDnIgudF+BQw28MA=
X-Google-Smtp-Source: AAOMgpfQShzMH1z8AYqWflG7LXUBjX6HsQbxz/AM2vZVHkcN8KHzI2572f5dNioK8pZfemE5C0xkLw==
X-Received: by 2002:a6b:8851:: with SMTP id k78-v6mr9507308iod.290.1532015397396;
        Thu, 19 Jul 2018 08:49:57 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id x6-v6sm1038034ith.1.2018.07.19.08.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 08:49:56 -0700 (PDT)
Subject: Re: [PATCH v3] PCI: Check for PCIe downtraining conditions
To:     Tal Gilboa <talgi@mellanox.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
References: <20180604155523.14906-1-mr.nuke.me@gmail.com>
 <20180716211706.GB12391@bhelgaas-glaptop.roam.corp.google.com>
 <628346bc-b455-05f2-2051-35a807076ea0@mellanox.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <25e4f647-f830-e1cc-bffc-0cc894885667@gmail.com>
Date:   Thu, 19 Jul 2018 10:49:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <628346bc-b455-05f2-2051-35a807076ea0@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/18/2018 08:38 AM, Tal Gilboa wrote:
> On 7/16/2018 5:17 PM, Bjorn Helgaas wrote:
>> [+cc maintainers of drivers that already use pcie_print_link_status()
>> and GPU folks]
[snip]
>>
>>> +    /* Multi-function PCIe share the same link/status. */
>>> +    if ((PCI_FUNC(dev->devfn) != 0) || dev->is_virtfn)
>>> +        return;
>>> +
>>> +    pcie_print_link_status(dev);
>>> +}
> 
> Is this function called by default for every PCIe device? What about 
> VFs? We make an exception for them on our driver since a VF doesn't have 
> access to the needed information in order to provide a meaningful message.

I'm assuming VF means virtual function. pcie_print_link_status() doesn't 
care if it's passed a virtual function. It will try to do its job. 
That's why I bail out three lines above, with 'dev->is_virtfn' check.

Alex
