Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4+0koDaAyoH5hHgV7hcaWpVXn0AXnFbX6+7c0vSFj8PTFtpCTgSDCichw+f2Kq/cY9RcJML
ARC-Seal: i=1; a=rsa-sha256; t=1523455330; cv=none;
        d=google.com; s=arc-20160816;
        b=rFoA3cBFDt+ISMPttIQJKtHYPiLLdFQfusFDnBPKbIQ99YJhmCeW/Nbf+cGdZlxRsH
         KPOqv+uYwjBUpZevCJ7PLeLulAeXtRlX8Bb0b6vzkk5oML7X7r1jBabuetn4c5KXUbhQ
         altm5B4170OyN26HUN/soi8DRu5O7iZmMRUmHqY6peo86V4uqIc+uPPHYra0smeStGwG
         mXrprHOCHtBftlm3oA/osILfZap/U7oeFmuzkMmWXBRyWO3HZPcs4SQ0VMSEnMjBNUWJ
         4q9QJAFftUAqELxMVflf65r/S5TjmhYLb9s8s/HIFXlIp7rggn9tGCsIc+5UIBQlQG/N
         j3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=/vHKNYl0mVxa/A9jLRX+qDhnKEWJr6bqKGlVD43yBfA=;
        b=NNz+gMRYy43DqzohMohsWMKBLtiaga6qx1Gtlv3zSk/4BB4D4Dk06v0TTqG9IjklwB
         7YRdF8378lxlyUtj4mqfRDDyOb9+iK+j3SjO14TiADmxabt6OQ4v/FohpGv2bShswqVv
         28mwffA6dNXxSK2dqBaDGRs7AVafdYXw2dcDydL+LJEMecwQaURLnygJZdamexmGySrc
         XOazVgq8jXwsIKfUs4MVwfKISZ3DmIesrZDR1XJIZWpKAr2hWVPc/EPxgQTPjGeZLyk+
         oGQ4VWl6tM3OzMq1vnrYZvorBLNNwKGqVnbPQ7yrGeYqriF+phXL7B0l+2nGuJob3ybS
         0LfA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nptkwAni;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=k9Oj22UE;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nptkwAni;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=k9Oj22UE;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CF2360386
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] PCI: quirk HT1100 & HT2000 and one HT2100 Root Ports for
 Extended Tags
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, sulrich@codeaurora.org, timur@codeaurora.org,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 open list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1522882209-9743-1-git-send-email-okaya@codeaurora.org>
 <20180410194144.GD54986@bhelgaas-glaptop.roam.corp.google.com>
 <20180410195008.GE54986@bhelgaas-glaptop.roam.corp.google.com>
 <1c94361d-7a8d-ad18-12e5-1612326a54db@codeaurora.org>
 <20180411135151.GB91792@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <ecdad8f4-6996-cfe0-d005-fbc67ba3cd79@codeaurora.org>
Date: Wed, 11 Apr 2018 10:02:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411135151.GB91792@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1597458696879800529?=
X-GMAIL-MSGID: =?utf-8?q?1597458696879800529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

+GregKH

On 4/11/2018 9:51 AM, Bjorn Helgaas wrote:
> On Tue, Apr 10, 2018 at 04:18:01PM -0400, Sinan Kaya wrote:
>> On 4/10/2018 3:50 PM, Bjorn Helgaas wrote:
>>> On Tue, Apr 10, 2018 at 02:41:44PM -0500, Bjorn Helgaas wrote:
>>>> On Wed, Apr 04, 2018 at 06:50:09PM -0400, Sinan Kaya wrote:
>>>>> Per PCIe r3.1, sec 2.2.6.2 and 7.8.4, a Requester may not use 8-bit Tags
>>>>> unless its Extended Tag Field Enable is set, but all Receivers/Completers
>>>>> must handle 8-bit Tags correctly regardless of their Extended Tag Field
>>>>> Enable.
>>>>>
>>>>> Some devices do not handle 8-bit Tags as Completers, so add a quirk for
>>>>> them.  If we find such a device, we disable Extended Tags for the entire
>>>>> hierarchy to make peer-to-peer DMA possible.
>>>>>
>>>>> The Broadcom HT1100/HT2000/HT2100 seems to have issues with handling 8-bit
>>>>> tags.  Mark it as broken.
>>>>>
>>>>> Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=196197
>>>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>>> Applied to pci/enumeration for v4.18, thanks!
>>> Actually, this is a really annoying issue and I think the fix is
>>> appropriate for v4.17, so I moved it to my for-linus branch.
>>>
>>
>> I agree. It causes boot issues on some AMD Opteron machines. It should
>> probably be back-ported too. 
> 
> We started enabling extended tags with 60db3a4d8cc9 ("PCI: Enable PCIe
> Extended Tags if supported"), which appeared in v4.11.
> 
> So I added these stable tags:
> 
>   CC: stable@vger.kernel.org      # v4.11: 62ce94a7a5a5 PCI: Mark Broadcom HT2100 Root Port Extended Tags as broken
>   CC: stable@vger.kernel.org      # v4.11
> 
> I'm not sure I'm using the stable request correctly, but my intent is:
> 
>   - 62ce94a7a5a5 appeared in v4.14, so cherry-pick 62ce94a7a5a5 to
>     v4.11 through v4.13
>   - cherry-pick *this* patch on top of 62ce94a7a5a5 to v4.11 and later
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
