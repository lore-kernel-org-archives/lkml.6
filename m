Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C562ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B3620652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCOIbhBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B3620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbeGTJTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:19:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33890 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeGTJTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:19:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so10495533wrt.1;
        Fri, 20 Jul 2018 01:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xSYlFBSloTykeHYzvxcZa+d4szbtRZcY+3o4aecslwI=;
        b=vCOIbhBAIUNWO+UqHJU38pI7UX6MhNy4f/8zZ13SJSUzB/B0Tm86x5mtHlJ8+orBql
         pVkTtpPx1RlR2DMnnE0wXRzuVxGo+ggNWimn6XwDs2I/uD+fP2Kk7+PDqjlOzk9+phXS
         OsVRU2Y7X2M7wVHVz4qUMfSIgM1bO3QRpYusSGSCXL4VgWi83O4e0b9SHeqo6vBlizDZ
         nlPnVmia026duur7lspJqJeuPn8CSrHCdhcy8ZWJXb74OJyt3NSNCwHUZxOaKIU12LUU
         kmjWGehokC/r7Xl3FKTlbutNc4LihvPo7m5MmomlaGUYkJYOv0D/90LxDYd7OV6xImV5
         8tSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xSYlFBSloTykeHYzvxcZa+d4szbtRZcY+3o4aecslwI=;
        b=SKditE7ljwyVv1yZKH5tUbHQt6FNYHWb+tkqrDQY9fz6v9hkJpLcpV45rn2G8Cbbh6
         qX/9FWHBIzNIag028tf4a/SrvkCA98uIdnrgUpdWbIU9dORgnEC5Ie0NY5U3J5ZqeuNv
         APHOBSllVmU3sWybARK1L6sWyGhnqG1LAmXZPctfG63b6j6BnwdOPLoiZkmYJSAxoYbK
         0YJerJxYx2Sz8Me/PHl8k2zc2uwiZG4epmdR6b2C53+4/VlDPuMRVP3pvIRwL6wSVS6l
         RODJ3SOgabuMBRzLUA4D/XThLsczA+QkRXHv5R9YNRONxvJjxnlrCg0zT3dCW/Ymp2OB
         T1PQ==
X-Gm-Message-State: AOUpUlHGrQByHgs8FkcqO2WyAo1oarfoBcHJJ47yd6/bzjiZI9PHO2hS
        OYeSFFX62SEu55w3YaVWAC0=
X-Google-Smtp-Source: AAOMgpfAC+WhSB9NHEcgeUpoo0EwbBHp94yJ8OjjXbvjW5vm8A+cxazJJnikSrhYhPMVg1qUJQbM7Q==
X-Received: by 2002:adf:ea0a:: with SMTP id q10-v6mr775432wrm.224.1532075541095;
        Fri, 20 Jul 2018 01:32:21 -0700 (PDT)
Received: from [192.168.10.150] (dynamic-adsl-78-12-156-57.clienti.tiscali.it. [78.12.156.57])
        by smtp.googlemail.com with ESMTPSA id b11-v6sm1038981wrv.82.2018.07.20.01.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 01:32:20 -0700 (PDT)
Subject: Re: [PATCH V2 0/4] Fix kvm misconceives NVDIMM pages as reserved mmio
To:     "Zhang,Yi" <yi.z.zhang@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, jack@suse.cz, hch@lst.de,
        yu.c.zhang@intel.com, dave.jiang@intel.com
Cc:     linux-mm@kvack.org, rkrcmar@redhat.com, yi.z.zhang@intel.com
References: <cover.1531241281.git.yi.z.zhang@linux.intel.com>
 <c4e1c527-a372-bd6a-a101-5a8e9026e7c1@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <25569674-2d8f-8b54-4ba7-478b57067325@redhat.com>
Date:   Fri, 20 Jul 2018 10:32:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <c4e1c527-a372-bd6a-a101-5a8e9026e7c1@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2018 16:11, Zhang,Yi wrote:
> Added Jiang,Dave,
> 
> Ping for further review, comments.

I need an Acked-by from the MM people to merge this.  Jan, Dan?

Paolo

> 
> Thanks All
> 
> Regards
> Yi.
> 
> 
> On 2018年07月11日 01:01, Zhang Yi wrote:
>> For device specific memory space, when we move these area of pfn to
>> memory zone, we will set the page reserved flag at that time, some of
>> these reserved for device mmio, and some of these are not, such as
>> NVDIMM pmem.
>>
>> Now, we map these dev_dax or fs_dax pages to kvm for DIMM/NVDIMM
>> backend, since these pages are reserved. the check of
>> kvm_is_reserved_pfn() misconceives those pages as MMIO. Therefor, we
>> introduce 2 page map types, MEMORY_DEVICE_FS_DAX/MEMORY_DEVICE_DEV_DAX,
>> to indentify these pages are from NVDIMM pmem. and let kvm treat these
>> as normal pages.
>>
>> Without this patch, Many operations will be missed due to this
>> mistreatment to pmem pages. For example, a page may not have chance to
>> be unpinned for KVM guest(in kvm_release_pfn_clean); not able to be
>> marked as dirty/accessed(in kvm_set_pfn_dirty/accessed) etc.
>>
>> V1:
>> https://lkml.org/lkml/2018/7/4/91
>>
>> V2:
>> *Add documentation for MEMORY_DEVICE_DEV_DAX memory type in comment block
>> *Add is_dax_page() in mm.h to differentiate the pages is from DAX device.
>> *Remove the function kvm_is_nd_pfn().
>>
>> Zhang Yi (4):
>>   kvm: remove redundant reserved page check
>>   mm: introduce memory type MEMORY_DEVICE_DEV_DAX
>>   mm: add a function to differentiate the pages is from DAX device
>>     memory
>>   kvm: add a check if pfn is from NVDIMM pmem.
>>
>>  drivers/dax/pmem.c       |  1 +
>>  include/linux/memremap.h |  9 +++++++++
>>  include/linux/mm.h       | 12 ++++++++++++
>>  virt/kvm/kvm_main.c      | 16 ++++++++--------
>>  4 files changed, 30 insertions(+), 8 deletions(-)
>>
> 
> 

