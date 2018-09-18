Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDBCC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258F820858
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="urxuUr6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258F820858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbeIROIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:08:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42696 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbeIROIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:08:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id l5so1172152edw.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 01:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q3PFHSeF2ZiyM9FD04/4J2bcjKR34vXwlep+9znAvnI=;
        b=urxuUr6YEBuJqV6WBh34I/0w2yqSG65oS3u21FFjIReXEP9r7e6g4bDfOQpT+yRCUW
         h6t7602zls/ItMJFE4cNFdLc06qCH5rCLXjXIeOwUvs1jOkd7mJobFyc3IzvrcnfabkQ
         KSsKwuGKvRISTCKU3+xOX6AdpPfwaOmOQXF3bJs46iM5gE0E+UphtTsKINdEiStAXUXu
         csQQTcjSe+pMLNRbDkV82rT0470LcmwNoL4Z8QELn1G40Mj9krE/ES8eKd+uIQZLl186
         HHwbfUXyya71CTgQG4NtMomPiUczBbd61e9k5ARmy0ERjorG7vPDak4eQ9uuQIvCL+mq
         uKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q3PFHSeF2ZiyM9FD04/4J2bcjKR34vXwlep+9znAvnI=;
        b=fEm3FdftAJj8RpQEbYa5oBlWdrIZVzjV52FlqU2LihCxMIYIWsFIzQYWXpnD0V6Rks
         z5bEQtpfTncyOQTHaBf09LuuTG91pb0LOhV5gmzT/j/c5vVMsZXS7kWJt7dhHVNPMSwZ
         H1GoCIx5EICXiKp4miW0fOGwvniv/llnVOg3Fj14DHA+fgnBvplknjhqYPDFOsrZj/M4
         lN9m+aXGYXNaa6aieKn9KVp0S+fA5rnm/IS1R0hI7Aj+NGQQMszWK+k36KsD2k9bk9Cf
         dR8WklrtFrM5jqwxzJziL1RdN2K26asyxkq9wJR5i1uLKXBnaiqztD3dR9HiAYxtcltT
         vK9g==
X-Gm-Message-State: APzg51CsrXKFqK/WT2vGnDMl93HofZAdVtmA7WetVnjiiqO/EazZGeFS
        Lf80dUIV6M0RmGqG3Rb+wKI1lQ==
X-Google-Smtp-Source: ANB0Vda0QXgOJftNt0pgEZ2+pZu/hr3JEFtl/9+leHq/Vh+emjpiUlOZGRUcsFmqxogdtdYUfjR/ag==
X-Received: by 2002:aa7:c441:: with SMTP id n1-v6mr47560531edr.55.1537259839431;
        Tue, 18 Sep 2018 01:37:19 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id t17-v6sm7899374edb.27.2018.09.18.01.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 01:37:18 -0700 (PDT)
Subject: Re: [PATCH 0/4] lightnvm: pblk: fixes for read buffer
To:     javier@javigon.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1537257785-31630-1-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <4b97830b-61c9-302d-5882-1ac51a94ea16@lightnvm.io>
Date:   Tue, 18 Sep 2018 10:37:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537257785-31630-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/2018 10:03 AM, Javier González wrote:
> This patchet's main motivation is to account for a corner case in which
> the read constrains imposed by the device are not respected by pblk. In
> the process, it also refactors parts of the read ring buffer to simplify
> creation/deletion operations and improve readability.
> 
> Note that the checkpatch warnings on missing comments for memory
> barriers are false positives.
> 
> The code is also available in the for-4.20/pblk branch in the OCSSD github
> project.
> 
> Thanks,
> Javier
> 
> Javier González (4):
>    lightnvm: pblk: remove unused function
>    lightnvm: pblk: encapsulate rb pointer operations
>    lightnvm: pblk: move ring buffer alloc/free rb init
>    lightnvm: pblk: guarantee mw_cunits on read buffer
> 
>   drivers/lightnvm/pblk-init.c  |  21 +++------
>   drivers/lightnvm/pblk-rb.c    | 100 +++++++++++++++++++-----------------------
>   drivers/lightnvm/pblk-write.c |   7 +--
>   drivers/lightnvm/pblk.h       |  11 ++---
>   4 files changed, 57 insertions(+), 82 deletions(-)
> 

Applied for 4.20.
