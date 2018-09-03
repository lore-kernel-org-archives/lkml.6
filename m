Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DE2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805AA20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feKPHvDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805AA20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeICF7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 01:59:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36693 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725762AbeICF7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 01:59:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so7950059pfo.3;
        Sun, 02 Sep 2018 18:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TV4SM7IqmlBzN7qvgegJ7dLIjMx5YvtO3FBPOCRmnRY=;
        b=feKPHvDWzM5WUMrzUQhy3FhzQmWBjOk6YUtCIj5DrXQFQYJoabcpDZYDt0r4qwnHPC
         OFQaiZsvuRf9zu9TQ6FBJSeZla/U/Qv2Xd9VijUFbXiBgmzvQNeHGT2/rx3DJpvEjuYB
         xgRteFhhOXxi9cfqt1Zx+k7hh+PlhSj6TVcaUTir0OPbUKFTEgx/y0PfazjanRQl6Jis
         iDpZTKnPbUTJjfyHqZGla2FMizVVULQuTNttJpGTynrSRv50l69cxzswlKamlMlQNu/a
         SO41e3aJBoCVB8dyh8qj5q0FX6M9ItLu/l/ViLhc9gBo5R3AmJTR7B0sJ6oGJ5wqVqVT
         44hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TV4SM7IqmlBzN7qvgegJ7dLIjMx5YvtO3FBPOCRmnRY=;
        b=FMvXaMZuUXRUGUXI1sON6EBXZaKg+oL5sJ08joemKQ96PJGGEPEdjw8tfQz6MLxCwF
         /xvo7Zvs3kH+Evsy5Kaky1gceErjoPTjE8YjIyV0rgGjc190gxAxz99kP89kb/Xv+OkE
         wRUZAhWE4TIEoOmea4vOPKCytxnbKwhcxsFNmrXKbwVtG4IHTXJrCOtU3CObQ5R/E/jl
         39GSDGhFsqNDE895YuhaSWaNj0Qk7D5qrclrkKHXZM5Gu63GsRcmL1uI5vkp/0MRJ6OR
         Uq4q+yGm2VBxB9/wFhxBb3DrXDVjq0QHbBkbgEatAaBFg+lMJIUe/dDHudXoo9g3J/ys
         lbOQ==
X-Gm-Message-State: APzg51CgO8oRm1G73ABIW+0IahUn8r9SVmGyIFo1CDyIGeKbNro8fF4B
        B30hX1wVUZK6ZTWr/Yl7cfXlSKE8
X-Google-Smtp-Source: ANB0VdaQQJRODzG6YHQt0NhxykP1S7WKqDWKx55zDLvBxUIw+vyqlMKIcezpUvZO8FD5u9lIjDS1QQ==
X-Received: by 2002:a62:205d:: with SMTP id g90-v6mr27480894pfg.253.1535938870541;
        Sun, 02 Sep 2018 18:41:10 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.58? ([2402:f000:1:1501:200:5efe:a66f:473a])
        by smtp.gmail.com with ESMTPSA id j13-v6sm19220589pgq.56.2018.09.02.18.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 18:41:10 -0700 (PDT)
Subject: Re: [PATCH] infiniband: core: mad: Fix a sleep-in-atomic-context bug
 in ib_mad_recv_done()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, leon@kernel.org, ira.weiny@intel.com,
        pravin.shedge4linux@gmail.com, hal@mellanox.com,
        parav@mellanox.com, haakon.bugge@oracle.com,
        bart.vanassche@sandisk.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180901120659.32509-1-baijiaju1990@gmail.com>
 <20180902203229.GA13946@ziepe.ca>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <c8aef2dd-5fa7-f619-d6ce-8b67087ed738@gmail.com>
Date:   Mon, 3 Sep 2018 09:41:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180902203229.GA13946@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/3 4:32, Jason Gunthorpe wrote:
> On Sat, Sep 01, 2018 at 08:06:59PM +0800, Jia-Ju Bai wrote:
>> The driver may sleep with holding a spinlock.
>>
>> The function call paths (from bottom to top) in Linux-4.16 are:
>>
>> [FUNC] alloc_mad_private(GFP_KERNEL)
>> drivers/infiniband/core/mad.c, 2264:
>> 	alloc_mad_private in ib_mad_recv_done
>> drivers/infiniband/core/cq.c, 45:
>> 	[FUNC_PTR]ib_mad_recv_done in __ib_process_cq
>> drivers/infiniband/core/cq.c, 77:
>> 	__ib_process_cq in ib_process_cq_direct
>> drivers/infiniband/ulp/srp/ib_srp.c, 2010:
>> 	ib_process_cq_direct in __srp_get_tx_iu
>> drivers/infiniband/ulp/srp/ib_srp.c, 2353:
>> 	__srp_get_tx_iu in srp_queuecommand
>> drivers/infiniband/ulp/srp/ib_srp.c, 2352:
>> 	_raw_spin_lock_irqsave in srp_queuecommand
>>
>> [FUNC] alloc_mad_private(GFP_KERNEL)
>> drivers/infiniband/core/mad.c, 2264:
>> 	alloc_mad_private in ib_mad_recv_done
>> drivers/infiniband/core/cq.c, 45:
>> 	[FUNC_PTR]ib_mad_recv_done in __ib_process_cq
>> drivers/infiniband/core/cq.c, 77:
>> 	__ib_process_cq in ib_process_cq_direct
> This trace doesn't seem right, the CQ used by SRP will never have
> ib_mad_recv_done as a function pointer.

Okay, sorry for this false positive.


Best wishes,
Jia-Ju Bai
