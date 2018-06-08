Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mi0XBJXaGVsdfgAAmS7hNA
	; Fri, 08 Jun 2018 01:23:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E9B1A6089E; Fri,  8 Jun 2018 01:23:32 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDMQqsLc"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7A116605A2;
	Fri,  8 Jun 2018 01:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A116605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbeFHBXa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 21:23:30 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33319 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752315AbeFHBX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 21:23:29 -0400
Received: by mail-pg0-f68.google.com with SMTP id e11-v6so5591507pgq.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 18:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=njv/hsO6UiHVRwWZHXN1seI10T9Ax93MJg1nK6h0kU8=;
        b=NDMQqsLcK9toDjljBLcQ23tOMmi780XItHVYmufxl2jOfZMjIFir4zCPrr5BkBfKdS
         LbUn74t9vA4tPdX6P5HcDYZQWgkrEzgqX9/dmx8MOtaTPRaAweIh6uBEI77QI/gqx3sO
         rMPUUASCde9RJYY756uRaPbfysCw9Y7fkMSxRUXFEAxz7m4Zr/9/kOOZ3pslrbGCJSLI
         eEd3oOB8nGVFwerAtxEeAVJE8BzFhmMV4NxByqDC/HpWvDaR7zHVnT0d3xpvpl+g4399
         mUyimKvcwH1HZv1GAcFLyLgNNewJdJVTB+d2KJzILYpcN909DJaCRDhXYwHTD/1WMaKC
         osKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=njv/hsO6UiHVRwWZHXN1seI10T9Ax93MJg1nK6h0kU8=;
        b=HTjNZuzEny9h7ShVHInmQTTm6XW23i0XqtBuqv/1YPZ/iQMmsFVgKYyZMRG9JehlGD
         NdxDkIICwuR2mgi8cRq0UDqFa8QNJNF9bH85Pvw2Xv+gnubooCbFOQGMP4NO8UMVfLtP
         YfhhGW5iybJrqDkyokjhJplmSy3fPTXNrFssMDVDaK4ucye1n0gA1aWBNxZL5r3feRSH
         AeEIbUXmOH6UJUdyBJve2UmUvM4e8KsLcI5Ib/AJ2jvz+lFrv+7EaN/Cmtz9hrCKqYyv
         UhB3TcFUEbRIFVQN/PZ85pvNQV590c9w7REJQNMZEzQO97be/Qd5U6nwIriPAXiDz110
         UUBw==
X-Gm-Message-State: APt69E3wsoPFSayb2aYBXSlTVB0UGPWhBN7N80jO3KU4w5EqCjPu58Z7
        JJ1v1KVzeaJ64gvKt5V72K8=
X-Google-Smtp-Source: ADUXVKIZ0QrmuKFAKGFTAC3N3Y2Oi0mkFos2Ltj2B2B0egDhsFxV1mahEEswsaWVlPqPe6tf0lGv7g==
X-Received: by 2002:aa7:8254:: with SMTP id e20-v6mr3910674pfn.140.1528421008840;
        Thu, 07 Jun 2018 18:23:28 -0700 (PDT)
Received: from [0.0.0.0] (67.216.217.169.16clouds.com. [67.216.217.169])
        by smtp.gmail.com with ESMTPSA id q68-v6sm97802771pfb.182.2018.06.07.18.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 18:23:28 -0700 (PDT)
Subject: Re: [PATCH v2] mm/ksm: ignore STABLE_FLAG of rmap_item->address in
 rmap_walk_ksm
To: Andrew Morton <akpm@linux-foundation.org>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jia.he@hxt-semitech.com,
        Hugh Dickins <hughd@google.com>
References: <20180503124415.3f9d38aa@p-imbrenda.boeblingen.de.ibm.com>
 <1525403506-6750-1-git-send-email-hejianet@gmail.com>
 <20180509163101.02f23de1842a822c61fc68ff@linux-foundation.org>
 <2cd6b39b-1496-bbd5-9e31-5e3dcb31feda@arm.com>
 <6c417ab1-a808-72ea-9618-3d76ec203684@arm.com>
 <20180524133805.6e9bfd4bf48de065ce1d7611@linux-foundation.org>
 <20180607151344.a22a1e7182a2142e6d24e4de@linux-foundation.org>
From: Jia He <hejianet@gmail.com>
Message-ID: <f92a05ac-6f9d-a152-fb4c-52bfb15bdffb@gmail.com>
Date: Fri, 8 Jun 2018 09:23:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607151344.a22a1e7182a2142e6d24e4de@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

On 6/8/2018 6:13 AM, Andrew Morton Wrote:
> On Thu, 24 May 2018 13:38:05 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>>>
>>> Jia, Andrew,
>>>
>>> What is the status of this patch ?
>>>
>>
>> I have it scheduled for 4.18-rc1, with a cc:stable for backporting.
>>
>> I'd normally put such a fix into 4.17-rcX but I'd like to give Hugh
>> time to review it and to generally give it a bit more time for review
>> and test.
>>
>> Have you tested it yourself?
> 
> I'll take your silence as a no.
Sorry if you asked the previous question to me.
I've tested by myself in arm64 server (QDF2400,46 cpus,96G mem)
Without this patch, the WARN_ON is very easy for reproducing.
After this patch, I have run the same benchmarch for a whole day without any
WARN_ONs

Hope it helpful.

Cheers,
Jia
