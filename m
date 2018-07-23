Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B37ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7718020854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAqEi/8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7718020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388963AbeGWSEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:04:00 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37516 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388942AbeGWSD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:03:58 -0400
Received: by mail-oi0-f68.google.com with SMTP id k81-v6so2403914oib.4;
        Mon, 23 Jul 2018 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D+sPknzTnh8p9rjdFHLos7RutGV/VUPhE8o26cr/wSw=;
        b=VAqEi/8NrJm68Pcu+/fYfufNMP0BC4r1U1kT7xR4yNUIw1tOERPfdSbSzpEa+j4TC9
         t3U4tK7HfJ0341yhhFYM4ipudNu3WjA4XqJsDHZor5YlwECjxpYk7249Xn7KAGuDM+Jd
         MVuJlyqbonyFIrm7sX9qVkeygcsP7EiagWNSwllATBRVs2sgZBigroLXLTBCBv4b5npf
         pLmltM3w+Z2n+vf2BRUSGQ7/kxP+iVdopjs8Ov1CzDjH6BSytwCGONJhCXWO1Kq3yr1C
         /hawVu9oWoQZLtLIwYsZNzS6f5eAAgUP/GeLBbuQsSfWsfNzjo08tGYLViRnjaDJtFmo
         6adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D+sPknzTnh8p9rjdFHLos7RutGV/VUPhE8o26cr/wSw=;
        b=ugy22e8tAnAYL5awxgD3z4mXECALEuO0LSQRZKNuCdI6u6ZNEMWOPrCknqYZFfHHU9
         MDF00JgKCbha5+krAiET9SFAAEg7lpYPozkfeB4f4JqcLNQPkbzxu0mJqMhnz0PUVtPV
         PingSiRG4xloSa9lys7p+JFRPBGPtabZmWkUyID4fSyCITGSg5KkYZvJAdSffUoV9opG
         /UwKPPOtlB3rxY57pYQi9hqZzUae8uGXTV59tMDtNGccLTfcrviZ7TGqyvo9duOoE16q
         qr+e4LyWc9ZjSslWNmF2B3PNy6zPqCwB779LF1EiP3ucW6vZxEovX7UpXNDUuTTm7GYq
         xmWg==
X-Gm-Message-State: AOUpUlEDi0O3Fcc6ZP/SI9Vo7LdsAp1SywVFQsT0QgWS4LYLMN6JiPTJ
        EtzvvYshXM58xvFMfHDnbT8=
X-Google-Smtp-Source: AAOMgpf6xZrnvNGmAA3z1+TeAPTsT5+jteLZhVua9ZB7Nv+PXqebYU8yh0MlF3uRXHe7BL2z1/Rm3A==
X-Received: by 2002:aca:bf07:: with SMTP id p7-v6mr10055762oif.285.1532365310113;
        Mon, 23 Jul 2018 10:01:50 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id m203-v6sm24756187oig.42.2018.07.23.10.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 10:01:49 -0700 (PDT)
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
 <25e4f647-f830-e1cc-bffc-0cc894885667@gmail.com>
 <9d752b75-eab2-6fd1-f9da-09985966436c@mellanox.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <757729fb-1eb5-e1fa-899b-5cef0cc3106c@gmail.com>
Date:   Mon, 23 Jul 2018 12:01:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9d752b75-eab2-6fd1-f9da-09985966436c@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 12:21 AM, Tal Gilboa wrote:
> On 7/19/2018 6:49 PM, Alex G. wrote:
>>
>>
>> On 07/18/2018 08:38 AM, Tal Gilboa wrote:
>>> On 7/16/2018 5:17 PM, Bjorn Helgaas wrote:
>>>> [+cc maintainers of drivers that already use pcie_print_link_status()
>>>> and GPU folks]
>> [snip]
>>>>
>>>>> +    /* Multi-function PCIe share the same link/status. */
>>>>> +    if ((PCI_FUNC(dev->devfn) != 0) || dev->is_virtfn)
>>>>> +        return;
>>>>> +
>>>>> +    pcie_print_link_status(dev);
>>>>> +}
>>>
>>> Is this function called by default for every PCIe device? What about 
>>> VFs? We make an exception for them on our driver since a VF doesn't 
>>> have access to the needed information in order to provide a 
>>> meaningful message.
>>
>> I'm assuming VF means virtual function. pcie_print_link_status() 
>> doesn't care if it's passed a virtual function. It will try to do its 
>> job. That's why I bail out three lines above, with 'dev->is_virtfn' 
>> check.
>>
>> Alex
> 
> That's the point - we don't want to call pcie_print_link_status() for 
> virtual functions. We make the distinction in our driver. If you want to 
> change the code to call this function by default it shouldn't affect the 
> current usage.

I'm not understanding very well what you're asking. I understand you 
want to avoid printing this message on virtual functions, and that's 
already taken care of. I'm also not changing current behavior.  Let's 
get v2 out and start the discussion again based on that.

Alex
