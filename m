Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AABDC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBB921A03
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KeyV1tz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBB921A03
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754362AbeFUSWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:22:36 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33944 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754079AbeFUSWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:22:35 -0400
Received: by mail-qt0-f193.google.com with SMTP id d3-v6so3745881qto.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 11:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kde/2oixCkRzPJp00EQZShlKp9ZghVd/FRFdQcip/kA=;
        b=KeyV1tz2UsrYYtRnY5JHLXEsbPNSD9cREHJf1R0RQaYOHXgYGL1RlEIEu3C8NgUnW+
         p1i47XjHPFDVAuP5GqZuLqR1wq2v7E5o22rG8qU1U1WUI+xfMFiqYg35vlscqQowZVeO
         ykENgMjCB32L0do69hoZnUBcvy1is6XcPefC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kde/2oixCkRzPJp00EQZShlKp9ZghVd/FRFdQcip/kA=;
        b=LWng3UvINYk0xgxPECWNCuzyxsMZO3AhjwqkLH0vlDyF3nJcAUrb4D36f09kpJ2ld7
         taLlZzs+Hijilwd8eQimmXPfgcNU+A75qdqLGEOizQSwhCirJT82/SraK6BzJlHdGWtT
         nkllslF0V6pn6KvsG1RWEeYPE9L0Uz0MgVvBIc/EzEo2G0maL9KgKxahIp/bx2EUtvYy
         2QxkNVpWTdEox7pFHORsFitbPKywKkdCPbdODIOSGuJKKSUR0h7HGy/UmL2Qwf/Is6lO
         mmnhQMIo2TAx8Ufux2oqz+6cCqi9jBWs2ixYpu2rGue//kzvjJzJXspbMkWt+sPnPc15
         JCew==
X-Gm-Message-State: APt69E1mFXyhzr28FH3Ik60gHMJgYDJ8TakQFMQJcvJt6klwiyrddYfI
        +OwJhB44zwQilspDbkK/EOtJVnxVAiI=
X-Google-Smtp-Source: ADUXVKLERJfvrEWLOEK2XL/FnbzjMD5CWk81SwRmMZ4b/Wiuh4wBhjyMQA/SbA6t5roN+L363Q3sNw==
X-Received: by 2002:a0c:c206:: with SMTP id l6-v6mr23537425qvh.17.1529605354096;
        Thu, 21 Jun 2018 11:22:34 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d66-v6sm3645211qke.70.2018.06.21.11.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 11:22:33 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Improve Broadcom PAXC support
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <45945371-3cd7-102d-bb47-69a60435542b@broadcom.com>
 <20180621164821.GA14519@e107981-ln.cambridge.arm.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <e573bad0-05b1-c00f-8815-6ebe26218f05@broadcom.com>
Date:   Thu, 21 Jun 2018 11:22:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621164821.GA14519@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

On 6/21/2018 9:48 AM, Lorenzo Pieralisi wrote:
> On Wed, Jun 20, 2018 at 10:26:28AM -0700, Ray Jui wrote:
>> Hi Lorenzo/Bjorn,
>>
>> Could you please help to review this patch series when you have time?
>>
>> I believe I have addressed major comment in v1 from Bjorn and answered all
>> questions from Lorenzo.
> 
> I will have a look next week, sorry for the delay.

Thanks a lot. Much appreciated!

Ray

> 
> Thanks,
> Lorenzo
> 
>> Thanks,
>>
>> Ray
>>
>> On 6/11/2018 5:21 PM, Ray Jui wrote:
>>> This patch series improves the Broadcom PAXC support by 1) adding more
>>> quirks for specific versions of PAXC controllers; 2) adding logic to
>>> reject internally unconfigured physical functions from the embedded
>>> network processor acting as endpoint; 3) reducing verbose print level
>>> in the outbound/inbound mapping code
>>>
>>> This patch series is based off v4.17 and is available on GIHUB:
>>> repo: https://github.com/Broadcom/arm64-linux.git
>>> branch: sr-paxc-v2
>>>
>>> Changes since v1:
>>>   - consolidate 2 PAXC related patch series into 1
>>>   - change the way how the capability list corruption is handled, per
>>> recommendation from Bjorn. Now handle and fix up the corruption at
>>> the config register read
>>>   - rebase to v4.17
>>>
>>> Ray Jui (5):
>>>    PCI: iproc: Activate PAXC bridge quirk for more devices
>>>    PCI: iproc: Fix up corrupted PAXC root complex config registers
>>>    PCI: iproc: Disable MSI parsing in certain PAXC blocks
>>>    PCI: iproc: Reject unconfigured physical functions from PAXC
>>>    PCI: iproc: Reduce inbound/outbound mapping print level
>>>
>>>   drivers/pci/host/pcie-iproc.c | 159 +++++++++++++++++++++++++++++++++++-------
>>>   drivers/pci/host/pcie-iproc.h |   8 +++
>>>   drivers/pci/quirks.c          |   3 +
>>>   3 files changed, 144 insertions(+), 26 deletions(-)
>>>
