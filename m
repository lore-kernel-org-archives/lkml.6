Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC53C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677B920870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eb5X8p/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677B920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732507AbeGaQvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:51:32 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:44732 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732393AbeGaQva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:51:30 -0400
Received: by mail-oi0-f44.google.com with SMTP id s198-v6so28581091oih.11;
        Tue, 31 Jul 2018 08:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1t1++1cAKJxVbqQe5CKwgjcwIXiKfuwg4JUapYmVcUA=;
        b=Eb5X8p/Jserc2TqJgjxOstjaKQygQk8amfyGyk2BK7BOgVl8DsEpVWar6MG+j2MLH6
         aLHGnb5rYwv+AZ8hepp0rHJrp/4hrjFLLF904VY1NGnCWATktZH/7OoclfIO15D5m8/a
         A4p+gaBhgw8ZudHu/ij/gdFvCCN9zse+Ru7eW36wU/Auo+tP2wW6V4on+fXLtOyYPzm+
         y6QlITmCo5onhdiolqk6TZHdykD+SfVkp8eL0yb6qKK2npBXmoq+NHS6Uwnb2fXVNGMZ
         CdNC51TOFQ/mBL42ZMzFDil8kA+tR3TNpWgE8ROw2q+x4r6bBnC/spAGUzA9bx1k3Iqx
         BSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1t1++1cAKJxVbqQe5CKwgjcwIXiKfuwg4JUapYmVcUA=;
        b=T1vQ9xuwshHnVfQ+dnKxTnTcT8JS/s6l9xOG9Hu2P9OBV7uILyav0xluRnpt8BNzsZ
         UytvNQGTs3qk1UGMSFLpClSnX2ZNFiH6Nq/tGOKKl2T5uE8uBeTnkElgQaO3YTpCGW+I
         UatTvU6KUp0QHxO8pnChdVpTtYkWOdevJKJwfFNonBCpsS5Tf0xJRRiJ0SBEelLzLCpw
         mKASMOerfzJjdjkgk4KW2h1dLAtYKEYWLT4KtzcE1+Sm6+edsTo7kjoQTWSaTWBxQvfa
         cfpAjTxNOicJYFUCIB7/uzzAs/ZHBVseyqh1V3pmdjDMmHExhyBRqbdlVjEZEP4rACBX
         gP8g==
X-Gm-Message-State: AOUpUlETJUCQQOz16oRGzo7msj3LgOUwSIKXC7tKaMShxJ2308AzjRhO
        cD98FKas0uIjuf0pUKB26cBljZxHR9c=
X-Google-Smtp-Source: AAOMgpeXSwSL7Dohw7P3RromKY10SbYFO7E3hcaVD2lmek3HEoHMXbQ7TDYqpdIUNpBKY83wl1xPCw==
X-Received: by 2002:aca:7203:: with SMTP id p3-v6mr21093747oic.194.1533049843664;
        Tue, 31 Jul 2018 08:10:43 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id s65-v6sm12139118oia.46.2018.07.31.08.10.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 08:10:43 -0700 (PDT)
Subject: Re: [PATCH v5] PCI: Check for PCIe downtraining conditions
To:     Tal Gilboa <talgi@mellanox.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "alex_gagniuc@dellteam.com" <alex_gagniuc@dellteam.com>,
        "austin_bolen@dell.com" <austin_bolen@dell.com>,
        "shyam_iyer@dell.com" <shyam_iyer@dell.com>,
        "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
        "ariel.elior@cavium.com" <ariel.elior@cavium.com>,
        "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "mike.marciniszyn@intel.com" <mike.marciniszyn@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
 <20180723200339.23943-1-mr.nuke.me@gmail.com>
 <20180723140143.1a46902f@cakuba.netronome.com>
 <b9a6b3b8-56cf-8bb5-2568-071ccd8a4f28@mellanox.com>
 <fc04618a-3b3b-58bd-edd5-cbde11638d7b@mellanox.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <1b914780-e342-6aee-ffb2-ef81ac3ddd29@gmail.com>
Date:   Tue, 31 Jul 2018 10:10:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fc04618a-3b3b-58bd-edd5-cbde11638d7b@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2018 01:40 AM, Tal Gilboa wrote:
[snip]
>>>> @@ -2240,6 +2258,9 @@ static void pci_init_capabilities(struct 
>>>> pci_dev *dev)
>>>>       /* Advanced Error Reporting */
>>>>       pci_aer_init(dev);
>>>> +    /* Check link and detect downtrain errors */
>>>> +    pcie_check_upstream_link(dev);
>>
>> This is called for every PCIe device right? Won't there be a 
>> duplicated print in case a device loads with lower PCIe bandwidth than 
>> needed?
> 
> Alex, can you comment on this please?

Of course I can.

There's one print at probe() time, which happens if bandwidth < max. I 
would think that's fine. There is a way to duplicate it, and that is if 
the driver also calls print_link_status(). A few driver maintainers who 
call it have indicated they'd be fine with removing it from the driver, 
and leaving it in the core PCI.

Should the device come back at low speed, go away, then come back at 
full speed we'd still only see one print from the first probe. Again, if 
driver doesn't also call the function.
There's the corner case where the device come up at < max, goes away, 
then comes back faster, but still < max. There will be two prints, but 
they won't be true duplicates -- each one will indicate different BW.

Alex

>>>> +
>>>>       if (pci_probe_reset_function(dev) == 0)
>>>>           dev->reset_fn = 1;
>>>>   }
>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>> index abd5d5e17aee..15bfab8f7a1b 100644
>>>> --- a/include/linux/pci.h
>>>> +++ b/include/linux/pci.h
>>>> @@ -1088,6 +1088,7 @@ int pcie_set_mps(struct pci_dev *dev, int mps);
>>>>   u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev 
>>>> **limiting_dev,
>>>>                    enum pci_bus_speed *speed,
>>>>                    enum pcie_link_width *width);
>>>> +void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
>>>>   void pcie_print_link_status(struct pci_dev *dev);
>>>>   int pcie_flr(struct pci_dev *dev);
>>>>   int __pci_reset_function_locked(struct pci_dev *dev);
>>>
