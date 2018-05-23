Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3514204-1527043227-2-4181828045676453513
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527043226; b=EhyZCy1c6svQXv776LChoklePDQ6SpVAU1wqAGZ7SJ8RI+p1Vs
    1SBMrr3NSjZROESNzLf83rU/KjycMdZv/SCEvi3iRxuZf4GJjoOGTO1qJ7upI7+O
    sdklMlNMg1md/rqeWn5w2CMYJXSW47AEkHz61A356GYNWBwtrAt4xSsQCRSX86sq
    sU48/Z094j7NFI61SrzJ7A8fdV/hhFec5xDv/GITUqRs/49c1Fb/CUZVZcV8iEpN
    l3GtNLoYubssvfn3EIDlp4swzXPuj/4cWicjU/PZ3T6VZmqYnxCyN8PRYfnJY9fG
    tLpMJbbzEXQH1TnFDNPlhiTYoAfUYX37M+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527043226;
    bh=wU5w+V/hfyYrFElt/bgsxbg7wIyBfuAQUWEWFL0I9ws=; b=djwRGk4lM/2t
    gVi8UwH8ONXGUUFO7QReHMCf0Jx8+sPnEDYDmqGcmz/WwMDfSopOnL7GzerSFBOf
    VFedEFLnoyo2mqbdxZQwzX1Rgb0loGg74zxsX5gWPop9L2CvKk5GvVusOgXANT0G
    Ae8WsiP57SjyDwOzOHvXB60GyhOVZb8v2qGcfpf4Qc5uvc9VlteLE41DEaVxfKFk
    Hmnz2ApZyuaZrnbeCEpsuQkBjL8pQJjMGhmkY71ZvHHf/OhiGIrywy/0WfPeWufW
    PeBcUaLctlcagVvlmyEy7S4ksUI3ERwLiDEfn+KhGGcSw2CzImui6+X40Jt8k+UA
    D4GH4vFEnw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org
    header.i=@codeaurora.org header.b=hl8IqcLK x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org
    header.i=@codeaurora.org header.b=hl8IqcLK x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codeaurora.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org
      header.i=@codeaurora.org header.b=hl8IqcLK x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org
      header.i=@codeaurora.org header.b=hl8IqcLK x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codeaurora.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKcW7Y666/OeggJSsZbZL3WnMTchRiptaj888Jb0zGWrRhjz60hmmjIWLSU/9cl9jCtsRwZWMOYVqXm4CrCENc+YFGp1d+TgHoJ9j85i7k0mtEpvDaHF
    7f9p/XIlR4VaBgTRbLM3z1HQFdnt/X1KqT+ij+L97uPHfOiERGC8C77EK4P63WZYKOjH6lMhB3lSukUuxz6QRh8rznjM8XYdOkUEdguW3jk/AGj2fjRxgBOo
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=DMhwYKAlxMvDqtI1WAAA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753798AbeEWCkW (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 22:40:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33260 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbeEWCkU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 May 2018 22:40:20 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F69C601E8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] PCI/portdrv: do not disable device on remove()
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, ryan@finnie.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1527011883-21320-1-git-send-email-okaya@codeaurora.org>
 <20180523022431.GA15069@wunner.de>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <8c91a923-1a3a-55fb-e812-62dd69d99975@codeaurora.org>
Date: Tue, 22 May 2018 22:40:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523022431.GA15069@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/22/2018 10:24 PM, Lukas Wunner wrote:
> On Tue, May 22, 2018 at 01:58:00PM -0400, Sinan Kaya wrote:
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -409,7 +409,6 @@ void pcie_port_device_remove(struct pci_dev *dev)
>>  {
>>  	device_for_each_child(&dev->dev, NULL, remove_iter);
>>  	pci_free_irq_vectors(dev);
>> -	pci_disable_device(dev);
>>  }
> 
> Shutdown aside, pci_disable_device() is also not called in the ->remove
> path with this patch, right?  Seems wrong.  E.g. when unbinding the driver
> from the root port device, or when unplugging a port (happens all the time
> with Thunderbolt).

Agreed. I'll spin another version where I skip disable on shutdown path only.

> 
> Thanks,
> 
> Lukas
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
