Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0155C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCDB2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCDB2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeJBH5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:57:10 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37724 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeJBH5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:57:10 -0400
Received: by mail-io1-f65.google.com with SMTP id v14-v6so329592iob.4;
        Mon, 01 Oct 2018 18:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JhvkxYRIyW+zSR4mBhJzQ8LdVgdzqZqmnTl/gTHImSo=;
        b=ukMybh7xTfytnmPNS3P9wRIJW5t16Px9XHinfhN3/L/qURBWojpwCpta1KZSndt3Sa
         Io8AYTbq51JefW/R52VltBA3WRJBttjINAPa1nKZ5vG78dkwqIi7CRk2/ZG1CkgYQgJd
         vKrDq9NNLztpioXM9hmiGmLHip3kb4tNiehbaXbRna0TNdAkE2DbH8/2vZ+sknZgqPk5
         Zp5JWRNAgoj9HIITjEu8+X6NUaOL0B9jZuOycLuklhavZHvJKxkfNDe39XhWg3PbUvQ7
         tGap8vpFPT+rPZSQNz+XTqkmk6lmHP0c/2dwr5lNenbEqhRPpNVDJxWFBFHCglOnX8UW
         vMnw==
X-Gm-Message-State: ABuFfogW4iFPoQTqsG+gnZSt5/5846xByFRdW6QGg5TczIBvG2Z7ISQ7
        i3EYlmH8q2ZWlRphhzjeZSz5x4R6AmI=
X-Google-Smtp-Source: ACcGV61dW/CvoD/BVPIjqWl5MixjHvt+oFqJt0PfJt5Z5zO9Y9vQa8GY1K5Lt28hatfztZcSjgo5Dg==
X-Received: by 2002:a62:6003:: with SMTP id u3-v6mr14076967pfb.114.1538442994209;
        Mon, 01 Oct 2018 18:16:34 -0700 (PDT)
Received: from asus.site ([2601:647:4601:42b4:3842:3e31:3bb6:cf62])
        by smtp.gmail.com with ESMTPSA id k63-v6sm19004882pga.36.2018.10.01.18.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 18:16:33 -0700 (PDT)
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Boaz Harrosh <ooo@electrozaur.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20180930205448.26205-1-natechancellor@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <10b12992-3570-4646-374b-82cbd7276839@acm.org>
Date:   Mon, 1 Oct 2018 18:16:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180930205448.26205-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/18 1:54 PM, Nathan Chancellor wrote:
> diff --git a/include/scsi/osd_types.h b/include/scsi/osd_types.h
> index 48e8a165e136..6b6fdcafa6cc 100644
> --- a/include/scsi/osd_types.h
> +++ b/include/scsi/osd_types.h
> @@ -28,7 +28,7 @@ struct osd_obj_id {
>   	osd_id id;
>   };
>   
> -static const struct __weak osd_obj_id osd_root_object = {0, 0};
> +static const struct osd_obj_id osd_root_object = {0, 0};

Structure definitions should occur in .c files instead of in header 
files especially if the header file is included from multiple source 
files. Please consider moving the definition of osd_root_object into a 
.c file. Additionally, zero initializers should be left out to minimize 
the size of object files.

Boaz, the most recent osd patch that is neither trivial nor treewide 
refactoring is six years old (51976a8c85ce ("[SCSI] osd_uld: Add osdname 
& systemid sysfs at scsi_osd class"). That suggests that nobody is using 
this driver anymore. Can this driver be removed from the kernel tree?

Thanks,

Bart.
