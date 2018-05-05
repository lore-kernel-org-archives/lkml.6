Return-Path: <suzuki.poulose@arm.com>
X-Cyrus-Session-Id: sloti22d1t05-1630782-1525513814-2-9379711879535637224
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='217.140.101.70', Host='foss.arm.com', Country='US', FromHeader='com',
  MailFrom='com'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: suzuki.poulose@arm.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525513813; b=O2KmWL3u6/b69jomTn4nB6Bezt6zeXYSxT8UG3jOESAJLGeatf
    xUEOE2rM9skuyvSBtYEXIkRrSvNNwmAn+Ag4symz1+p8PhSpT8GwhMwENU7gGWbD
    wqJC4/RtYXkpUr4Hu76Q7TKA8GJC1sGbgdD6NeMCajpKxm4M67sHz62AdmumrN54
    pQqz8NYJUbRWpTzLMAol1w8IEg0aQsmXlKqo4gXy5MS2waeL7IhXzXfECWMZghQL
    FmEPHekIWDSDdThx9d6VNMyvCyR1xHNGom7lalWw0KCZCC6a6Y4maMvFI55NrDjh
    KYoN5m415eM8QC36E0k1b6GCQJ6gN9iKvdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding; s=fm2; t=1525513813; bh=r6CYVDLl2MJH
    3gdy3q6xCfIqy80wpz93hoMFNEFxeiM=; b=FT9lOr1w/pEz4FEAwiQlHtASIM5r
    KFzbL4BBWFlc8oxpJrOXPk+ksJ7qcePRa4Qy+xbpuTJP7ACm/wQw5QYydC5x0F5D
    e1jXI36ZrLpcMxt1iDI2hEuryIufOOllbnXtmsdgv9r+TfpQAjmzsVZZ66NewWBu
    cJ7zUSJ5nj95Li0nOXguDv8dylMnfBJSdjaMM6dFDVocx6ZM5KoyRdfY9OWCb4Xd
    /hB8RSyk7DD2F6xNtknXKUr7ZAgbF5IvmHwZIiia9fJjzGD9LDk32yYPXPWNqWLp
    QSHFEnN8+8Vw42CoCpw/uvnbh3qJT/iLlshDB4WQBy+8qLV0tM8g1FzMNg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=arm.com;
    iprev=pass policy.iprev=217.140.101.70
    (foss.arm.com,usa-sjc-mx-foss1.foss.arm.com);
    spf=pass smtp.mailfrom=suzuki.poulose@arm.com smtp.helo=foss.arm.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=foss.arm.com
    x-ptr-lookup=foss.arm.com,usa-sjc-mx-foss1.foss.arm.com;
    x-return-mx=pass smtp.domain=arm.com smtp.result=pass
    smtp_is_org_domain=yes header.domain=arm.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=arm.com;
    iprev=pass policy.iprev=217.140.101.70
      (foss.arm.com,usa-sjc-mx-foss1.foss.arm.com);
    spf=pass smtp.mailfrom=suzuki.poulose@arm.com smtp.helo=foss.arm.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=foss.arm.com
      x-ptr-lookup=foss.arm.com,usa-sjc-mx-foss1.foss.arm.com;
    x-return-mx=pass smtp.domain=arm.com smtp.result=pass
      smtp_is_org_domain=yes header.domain=arm.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJakl2O6ZmyNLuYY9QcIXgacT6AvHuqhIOhjep7CSf0B5fd7BwAzozhpJ9aylfLZ998Q3tJQrhM6ZJg875j8Q0c2JblE1eAmOrPqqckt/xmi4qJqOD2k
    fybccn8MwEsQYswe3I3P3tC3d32gRvg66TD/VAelJD08RXBwISjQtHn7FD46xHjwH0qaoj5vcmpySA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=J46x2Qp87nEU+ZW81O/1bg==:117
    a=J46x2Qp87nEU+ZW81O/1bg==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=kz8oyBsBoGQ5IBaYZDIA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Subject: Re: [PATCH] [stable] arm64: Add work around for Arm Cortex-A55
 Erratum 1024718
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
 will.deacon@arm.com
References: <1525170364-21032-1-git-send-email-suzuki.poulose@arm.com>
 <20180504221508.GD20328@kroah.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <39eef51c-3b6b-3c32-c6ee-15bae1d4b13b@arm.com>
Date: Sat, 5 May 2018 10:49:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504221508.GD20328@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On 05/04/2018 11:15 PM, Greg KH wrote:
> On Tue, May 01, 2018 at 11:26:04AM +0100, Suzuki K Poulose wrote:
>> commit ece1397cbc89c51914fae1aec729539cfd8bd62b upstream
>>

...

>>
>> Note: The upstream commit is on top of a reworked capability
>> infrastructure for arm64 heterogeneous systems, which allows
>> handling this later in the boot process. This backport
>> is based on the original version of the patch [0]. Folded the 3
>> patches into this single commit, removing the unncessary bits.
>>
>> [0] https://lkml.kernel.org/r/20180116102323.3470-1-suzuki.poulose@arm.com
>>
>> Cc: stable@vger.kernel.org # v4.3 to v4.16
> 
> This only would apply to the 4.16.y tree.  Can you provide working
> backports to 4.14.y, 4.9.y, and 4.4.y so I can queue them up there as
> well?


Sure, I will send them soon.

Cheers
Suzuki
