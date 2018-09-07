Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2240BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C742083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFObLetZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C742083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbeIGUGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:06:30 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34675 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbeIGUGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:06:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id f8-v6so12630822ljk.1;
        Fri, 07 Sep 2018 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LauoadOAIhIrUC5YZcJHX21MxI/Ye/Mk705vKy6fBw0=;
        b=EFObLetZP8icaiDvAVPaie/rZjnRUGJEhGc5j9+LAoC8G+78EHn2erwLtIDDOnYV4M
         SJWuZZcRr3jX5uVDH82tsCbSQcnNz2r3K2fWSCUSCHHKNN2Ir+laeqdIlBsqUm+FKQm9
         5yKR6D79OJuS7muSfewbY8wfc7rgN5+WpZ6Im+MMCLOVYHkc0Z1+B/s28OQFYDopwlhc
         0QZUR1irubaBils3saOBYWnPtUgGrOys85eurf/3fPmzENuJbmgEBiPydbxTdR5Yr4Nl
         qnrSjOAcm5hqTkYg3ibCouwAhTtUCC0iRb+eU4PuHQCPnHcEqL666LgoXl+B+jFVVZWb
         zeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LauoadOAIhIrUC5YZcJHX21MxI/Ye/Mk705vKy6fBw0=;
        b=XWypiNmrIBADw/Cz29NadhLJ6aOhX811PA6E8sO46ByqfrRYYvRPDLz+PejFaAtTpI
         Ns9wtONeT8WODt8V7tSAK7kp3X2D55aeg8sskbjPHOa2JMMnkG6DEA8iINstC0knkMtw
         wsi4rsrp55EvlfQ/q8WF+DlcHTdsXP1vmCd+Ip637bDcYkDCdEdLJkzS0XB3ZRR8Ed8h
         p0Tvvwyjr/VJC+hq8NA84iZe7ckmbHQlwX7cMqCAAe6umUS422wPYMbFybZWVmQ7iwkr
         5IKa25h5nY2nSmTE7TFGghOpwg/q8YE5tzVIXkoiUSL9FfR69gHon/I+CR10ToEV9mnl
         xiBQ==
X-Gm-Message-State: APzg51AsUPhHW5Lkx1/15TDpbQTBIDObXm6a74JPRlYTmsl7UJIwJO6P
        O8BrMFMYCW67TIO485PuQyLo9hCETm4=
X-Google-Smtp-Source: ANB0VdYV+Wvga+0nhPqx2zhJno1sKLHyZcnT+5rhgCmZO0V6f8TfMuprdLeiw0tvL/T0+toU5KZ5lA==
X-Received: by 2002:a2e:5d9d:: with SMTP id v29-v6mr5159913lje.137.1536333904913;
        Fri, 07 Sep 2018 08:25:04 -0700 (PDT)
Received: from [192.168.10.160] (91-156-179-220.elisa-laajakaista.fi. [91.156.179.220])
        by smtp.gmail.com with ESMTPSA id r21-v6sm1358244ljb.16.2018.09.07.08.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 08:25:04 -0700 (PDT)
Subject: Re: [PATCH] infiniband: nes: add unlikely() to assert()
To:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Faisal Latif <faisal.latif@intel.com>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Chien Tung <chien.tin.tung@intel.com>,
        Roland Dreier <rolandd@cisco.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180831192418.12346-1-igor.stoppa@huawei.com>
 <20180905060106.GI2977@mtr-leonro.mtl.com>
 <811a6feca9fdea2db59ac392a4711cd897f46cc7.camel@redhat.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <e7fac148-2347-1303-7725-41b7858a02e4@gmail.com>
Date:   Fri, 7 Sep 2018 18:25:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <811a6feca9fdea2db59ac392a4711cd897f46cc7.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/18 18:13, Doug Ledford wrote:

> This patch was part of a larger series on lkml.  In that context, I
> acked it so that the series could be applied by whomever took it (it
> didn't belong on rdma-list as a series since only one patch out of some
> large number touched rdma files).  Now it is being resent as not part of
> a series, but my ack was preserved.

Yes, apologies for the confusion (and maybe wrong process?).
The patchset as a whole didn't seem to gain traction, so I decided to 
fallback to the more tedious process of submitting them individually.

Since the specific patch was not altered, I assumed the ack was still 
valid - I am sorry if I did it wrongly

--
igor
