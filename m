Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD5BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5FC20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YfPCGbTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5FC20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeIAA02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:26:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37775 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeIAA01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:26:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id h69-v6so6003257pfd.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 13:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4opANQdSOR1YBQ2HptujUEqJpJcFQfDZPJWhmlJDjvY=;
        b=YfPCGbTpOH1x/zXEwZdcF+nHzpr+rdRPaHA6WJ08QdPXVFPAwvbr5TL0jtm7O0AeV7
         WBM/94tD4YTJRzG+YJW/ILK+xZ+qO+b8t6K+xhsXM2v53UYb186GbN6Su0qtCmAGHe4c
         +cZG3Y0tfWH3YI3u4tqHPAIweGKhel9TOz/GDiFMiweP8YmfiiAaM2H+/5T9X8gJjv9z
         +C4wZHc97jBbwdqwuMUw8F7HsdVw+wm6ekzTixURzqAWFFyEwf5fqZSG2tvYbB6mzrS1
         WFUjeUsFufMu1/SeNZBfAL3vbu5lbhFjF8+t0nvc1knPtEkkwO/EhR+uFZkcDIcSsGg4
         F8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4opANQdSOR1YBQ2HptujUEqJpJcFQfDZPJWhmlJDjvY=;
        b=jmgHd6/BckMcgde5NclM7Xi2+ThbAtT17aZHUkLzXbf9VNlOYJKx94aTXkXY2xuFti
         EAkdRSI4++Cc7+OsXnxH/2/kEtxZs/pcgafcW8xwbNsKX57q4eFk6aL5nGqrK4ayjZcC
         9veJWQLsfX9CCN5ONr533BM5XE8xFO86hwdEt6ewtIoHyuOE/lFfSuxIhfmhNmXGSnuP
         B3iicc6UCLEf0BGVTdtiJZJMWe6v3x7aS80o46HuLG4XwE2JHaI4+MOKuCHrKxf7R6dr
         u/EeWXOTuKhNs9JnvJQh6KtkCy9uXl6wI5T+cb9R2jXBZtuhxacauNOSPnsCQtiLsIgW
         9TVw==
X-Gm-Message-State: APzg51Bxx+HlilIFU0rHCLXhffO08MqZjaFpz3SdnEdKmiVSf0v7Abf+
        W+oS4kBDxvnrf6yk/vjevpOIiw==
X-Google-Smtp-Source: ANB0VdZBhRg5FyZpzKO72M3/SEno9S7CpIDdCEs7gg5F7roMmQUG+slw2Dyug/g1OCOQ9ZtOhsbizQ==
X-Received: by 2002:a62:4fd9:: with SMTP id f86-v6mr17707795pfj.110.1535746642188;
        Fri, 31 Aug 2018 13:17:22 -0700 (PDT)
Received: from hackmann.mtv.corp.google.com ([2620:0:1000:1601:82f7:8f1:8c08:a97a])
        by smtp.gmail.com with ESMTPSA id r1-v6sm28724100pfi.17.2018.08.31.13.17.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:17:21 -0700 (PDT)
Subject: Re: [PATCH] staging: android: ion: fix ION_IOC_{MAP,SHARE}
 use-after-free
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Hackmann <ghackmann@android.com>
Cc:     linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        devel@driverdev.osuosl.org, kernel-team@android.com,
        stable@vger.kernel.org
References: <20180831200627.59712-1-ghackmann@google.com>
 <20180831201232.GA23559@kroah.com>
From:   Greg Hackmann <ghackmann@google.com>
Message-ID: <c41f1a53-7aa1-e0e3-58eb-8c1f3d34e14d@google.com>
Date:   Fri, 31 Aug 2018 13:17:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180831201232.GA23559@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018 01:12 PM, Greg Kroah-Hartman wrote:
> On Fri, Aug 31, 2018 at 01:06:27PM -0700, Greg Hackmann wrote:
>> The ION_IOC_{MAP,SHARE} ioctls drop and reacquire client->lock several
>> times while operating on one of the client's ion_handles.  This creates
>> windows where userspace can call ION_IOC_FREE on the same client with
>> the same handle, and effectively make the kernel drop its own reference.
>> For example:
>>
>> - thread A: ION_IOC_ALLOC creates an ion_handle with refcount 1
>> - thread A: starts ION_IOC_MAP and increments the refcount to 2
>> - thread B: ION_IOC_FREE decrements the refcount to 1
>> - thread B: ION_IOC_FREE decrements the refcount to 0 and frees the
>>             handle
>> - thread A: continues ION_IOC_MAP with a dangling ion_handle * to
>>             freed memory
>>
>> Fix this by holding client->lock for the duration of
>> ION_IOC_{MAP,SHARE}, preventing the concurrent ION_IOC_FREE.  Also
>> remove ion_handle_get_by_id(), since there's literally no way to use it
>> safely.
>>
>> This patch is applied on top of 4.9.y.  Kernels 4.12 and later are
>> unaffected, since all the underlying ion_handle infrastructure has been
>> ripped out.
> 
> Does 4.4.y or older also need this?  If so, can you send backports, as
> this one does not apply there.
> 
> thanks,
> 
> greg k-h
> 

Yes, 4.4.y and older will need this.  If there are no objections to this
patch, I'll send backports ASAP.
