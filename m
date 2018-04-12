Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx48Z9viuz+i2+75RyQLzfBakKciA0Ad880QBZnmU6XzZNDVI8ToKaWkTwq+pqPAq9XdvjJq7
ARC-Seal: i=1; a=rsa-sha256; t=1523497320; cv=none;
        d=google.com; s=arc-20160816;
        b=TbkXSp5zdyzpcR563of5cguweJ19AdlK/MTlJO/sDvjMyxmY6FY0mTHYMEMfRA8RlC
         VOgC/kEE6nvvMBmBmTWxVLwOvQKJiuEfF27kApTR/mnDqDRTPtOrkuSkHxBZp1MKH/4v
         8xzdyX066yDq5FqUoSPajmEfQ+a2gi2CwyrpDWn4j3q8yZXDulJ+Yt9+EywjWsQwKD3a
         BKLzxscPQC1fIgYDPFUjd7/drkg9bZ1Rtg40SWCWhQefkt33FpeMZKiwdOEEhNXcQoxA
         QTVtPrSvjs4RDtoJNOhTCGiqADfeDiCV7CJa2OWSDcR3b6Et2omxUcMfljW4fR8gYOrU
         GvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=OAWu8zFPkO7ByLt31CKNVDhAcQ6m0g76C83HpCvjpuc=;
        b=Ca7sTXtuqN/85C6ucR4asPmvqX7bYIDozd8+eBbVJP7sP1LMHRCgFOG1Rw7d92ky2C
         srhoVhgD0O0xv8WPO5kH6zQqYg74Ag4UJgRsN3Gscgk9nMfQWnnsbmSo8CUhtdr5ppt7
         xqD8fmm4F0NoKVhaVkrLyI3AqRCZ0S1EGtvYCvuKJgX9X13OKha4+4IAbFnQzhhAS8mb
         4emJLqrInWUVERjWMErvHxatprPQoncwW8GHz0Oyu/Xs3uUaF6ZEXZPL1bDwJXCsJzbC
         8MMOkm7K/Pisqq/cTibPWa1WDlplkPpsE6M0qJZmFZDahzwVPCwPRZMZ3kaLwNMUwEQK
         1UyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cer+lou3;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cer+lou3;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cer+lou3;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cer+lou3;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B85360290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v13 6/6] PCI/DPC: Do not do recovery for hotplug enabled
 system
To: Bjorn Helgaas <helgaas@kernel.org>, Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
 Timur Tabi <timur@codeaurora.org>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-7-git-send-email-poza@codeaurora.org>
 <20180410210349.GG54986@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <13efe2e8-74c8-acb4-ec58-f79b14a1f182@codeaurora.org>
Date: Wed, 11 Apr 2018 21:41:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180410210349.GG54986@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027488013564?=
X-GMAIL-MSGID: =?utf-8?q?1597502726000952499?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/10/2018 5:03 PM, Bjorn Helgaas wrote:
>> DPC and AER should attempt recovery in the same way, except the
>> cases where system is with hotplug enabled.
> What's the connection with hotplug?  I see from the patch that for
> hotplug bridges you remove the tree below the bridge, and otherwise
> you just reset the secondary link (I think).
> 
> The changelog should explain why we need the difference.
> 
> I'm a little skeptical to begin with, because I'm not sure why we
> should handle a DPC event differently just because a bridge has the
> *capability* of hotplug.  Even if a hotplug bridge reports a DPC
> event, that doesn't necessarily mean a hotplug has occurred.
> 

Let's do a recap on what we have discussed about this until now.

There are two conflicting error recovery mechanisms for PCIe. 

If a system supports both hotplug and DPC, endpoint can be removed and inserted safely.
DPC driver shuts down the driver on link down. When link comes back up,
hotplug driver takes over and initiates an enumeration process. 
Keith mentioned the stop and re-enumerate design was chosen because 
someone could remove a drive and insert an unrelated drive back to the
system.  We can't really save and restore state as we do in the AER path. 

Now, let's assume a system without hotplug capability.
Second mechanism is to go through DPC/AER path and do an automatic link
down recovery via DPC retrain/secondary bus reset including register save and
restore.  Second mechanism is more suitable for handling "surprise link down"
event. The goal is to retrain the link and continue driver operation. 

The goal of this patch to separate these two cases from each other as
the DPC driver needs to work on both contexts. Current DPC code doesn't handle
the second use case.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
