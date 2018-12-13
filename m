Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B55C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC8B20880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544718492;
	bh=BI966aFaj0DfXReiODJw4nqzaFnzoF11ygQdS85S7jY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=WOBOQ8g322hNnL7lAM+dYn6CUeTyxPnf9jJhl1n315pBT7evm85B80GMwz3j94/JU
	 3+MP9DNijRecoFiI0NXRr3vxgS0I2uyhClF8ZcGCEMJM284tWxwKxeU3gfU2R/kP9v
	 fzpwzj+JGquRnIpKGJMMR0nhxZ7MDwt+bBfFnVxI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC8B20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbeLMQ2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:28:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbeLMQ2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:28:11 -0500
Received: from [10.80.45.159] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C4662086D;
        Thu, 13 Dec 2018 16:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544718490;
        bh=BI966aFaj0DfXReiODJw4nqzaFnzoF11ygQdS85S7jY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=i0WKkaMQKnKnxqLrZe1LeDHJfM7qFuexKYha17c0h8rQIWhk3LgvFBildgDINjZjR
         mlXd/IwdDEdRin0JgN9ZFemr9J1ZzbR1asWUx6uMJhHnDTq0Wawq9RxGFs9Zi5UC1D
         l+L/h35CzRv/NteUFW8AZQOLlYGgQ8Soi+spanHw=
Subject: Re: [PATCH v7 2/5] ACPI / OSL: Stub out
 acpi_os_read_pci_configuration when CONFIG_PCI is unset
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181213044833.23952-1-okaya@kernel.org>
 <20181213044833.23952-3-okaya@kernel.org>
 <CAJZ5v0iZa_m8zL+BKrpMNRhPF=6k__jCtiKSk6ZBFDc3pXMi1g@mail.gmail.com>
 <a24b13db-049d-5027-4c49-81cdc0782c2a@kernel.org>
 <CAJZ5v0jHMa=7+L0MhGtD4f0At=CystTb2kEbedQuzzB4WWaDGw@mail.gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <67f817ff-4e81-d971-c92f-897d8f6343b8@kernel.org>
Date:   Thu, 13 Dec 2018 11:28:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jHMa=7+L0MhGtD4f0At=CystTb2kEbedQuzzB4WWaDGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/2018 11:20 AM, Rafael J. Wysocki wrote:
> On Thu, Dec 13, 2018 at 5:04 PM Sinan Kaya <okaya@kernel.org> wrote:
>>
>> On 12/13/2018 6:15 AM, Rafael J. Wysocki wrote:
>>> On Thu, Dec 13, 2018 at 5:49 AM Sinan Kaya <okaya@kernel.org> wrote:
>>>>
>>>> Getting ready to allow CONFIG_PCI to be disabled with ACPI enabled. Stub
>>>> out acpi_os_read_pci_configuration function that depend on PCI.
>>>
>>> Why don't you merge this with the next patch?  Is there any particular
>>> reason why they should be separate?
>>>
>>
>> I could. I thought it would be easier to review small pieces.
>>
>> Let me know your preference.
> 
> IMO it would be better to merge them.
> 

OK. I'll  merge and post a new version tonight.
