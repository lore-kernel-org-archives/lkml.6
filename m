Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA23ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC2821476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC2821476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeJSWBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:01:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45468 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJSWBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:01:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id s3-v6so2585788pga.12;
        Fri, 19 Oct 2018 06:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i5893Vb2bNNwa08SabL4dWx6LZdBaSWjbNuca66wvys=;
        b=gWeYPiZBFppfEGGdI99HyUg0gM35NBUPig+CMzazFvvaCXFldEl7oF2XzP7OqbIa04
         qxooGq/Au01A7OEpsD4NsWGuXKObviGvO4F9JMDl8+36lOEgYx2uMqDoU/Xc/Msiua/R
         Mb9unbV8g1Yoe+BWzEkFpnQSiMC5v8Rqd/r+rhccvt+r1G0uIMCRqF3nN1kJPdm2T62U
         /uRgtAW6sjAwKPcHLK8O8WzcdCaX7R4dwl5mmomroGSMw52NyGMBGCP+IhoxXRMFwtoP
         zkqcRyo8DSIaPWiGVvS3E31OdVvUcvWC2q/G9TpQnVxS1rH361xNxfBmWs4CxgWsY8em
         ACWw==
X-Gm-Message-State: ABuFfojp5vhW6MQhQKVtpNs1iQytw0mTr4RFoH6Jr4e49wMqWgf8oTvc
        aj3Cqre/OnHcxMaKlom6KIeRyn38TpVsbA==
X-Google-Smtp-Source: ACcGV61HNdv0KiYmJAxII0hvtkmKf4zzbwXWirpCziykv8gJGSoOnFdpOIQwZ9XItStM72LvRDF6Mw==
X-Received: by 2002:a63:2503:: with SMTP id l3-v6mr32488800pgl.69.1539957332177;
        Fri, 19 Oct 2018 06:55:32 -0700 (PDT)
Received: from asus.site ([2601:647:4601:42b4:3842:3e31:3bb6:cf62])
        by smtp.gmail.com with ESMTPSA id b8-v6sm33059pgm.68.2018.10.19.06.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 06:55:31 -0700 (PDT)
Subject: Re: -Wswitch Clang warnings in drivers/scsi
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20181004183047.GA1885@flashbox>
 <1538678069.230807.6.camel@acm.org> <20181004184540.GA17513@flashbox>
 <CAKwvOd=FrGZ-oh5Q9RGQD2GNORZrqwAZUzNYN+hTKkp5wrfrqw@mail.gmail.com>
 <20181005065754.GA18637@flashbox> <1539024429.64374.40.camel@acm.org>
 <20181019065104.GA27170@flashbox>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <da70bb3c-3474-7fa5-032c-2abad01deb9d@acm.org>
Date:   Fri, 19 Oct 2018 06:55:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181019065104.GA27170@flashbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 11:51 PM, Nathan Chancellor wrote:
> On Mon, Oct 08, 2018 at 11:47:09AM -0700, Bart Van Assche wrote:
>>  From the user space header <sys/ioctl.h>:
>>
>> extern int ioctl (int __fd, unsigned long int __request, ...) __THROW;
>>
>>  From the kernel header <linux/fs.h>:
>>
>> 	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
>> 	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
>>
>> Why has the second argument been declared as "unsigned long" in the glibc
>> headers and as "unsigned int" in the kernel headers? That's not clear to me.
>>
>> Bart.
>>
> 
> Hi Bart,
> 
> Sorry it took me so long to reply, somehow this email got lost in my
> inbox...
> 
> Unfortuntely, I am unsure why there is that discrepency between the
> headers. I tried to do some research but I didn't come up with much.
> 
> However, I did test changing the type of ioctl/compat_ioctl's cmd
> parameter to 'unsigned int' and came up with the following diff (rather
> large so sharing via a gist instead of pasting here):
> 
> https://gist.github.com/nathanchance/8febc92735f4228574cb0464520f0f6f
> 
> I'll obviously draft up a proper commit message before formally sending
> but I can address any major concerns before that happens. I checked
> every single ioctl for a negative value and there aren't any so I think
> this change makes sense to fix this warning.

Hi Nathan,

Since that change makes the SCSI code more consistent with the rest of 
the Linux kernel, I'm in favor of making that change.

Bart.

