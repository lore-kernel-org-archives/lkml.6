Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F75C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4FD20823
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4FD20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electrozaur.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeKAKkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:40:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34990 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeKAKkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 06:40:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id z16-v6so610550wrv.2;
        Wed, 31 Oct 2018 18:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=HHzLiT9Ap/pSWhAU06QyHqArkXsKnNg8xqdtbNQegjg=;
        b=R+2G4XRwCUhshLN8UQ3mMSk8hQrmRqfUXhBdyhYhi6RfV8z0nlM/1gBC8lCvT0K93F
         QqvxCArYzOTVEgJr4/yUuQWXHcy/9ZLM//K+VXGFD1Jo8P+ZYSpHTgvPUN9xhPykPfs/
         Ts2nWf7NQZKQ4aEjDd9KNtyDg87LgP3qzF4UYSiCph6BOiUt297yLf+LD1eNg9NBWJVn
         ivbdnFQCCltozY88PzjDul9z/t4eQHUpFvPsTQeWF8s7cL0LwuCUkyp9HqedjEqz6Rut
         p12v+H1KXoNHpcBEjdn9L1HxpBqLU87scda/afUfuGqSVB7KCU6DQH/nJPYO3vPmgg7f
         bXRw==
X-Gm-Message-State: AGRZ1gJZRMQGdWeuXNLjVmEJGx4wxIBJjiV1AvC4/96QfEyQ6ohTiaCk
        cwKcu3Bzwa/AVprgpFUpBf77DBb0
X-Google-Smtp-Source: AJdET5dtPg85tgFU64HSRT0ImpeWj89ToqKEH0ZomYoOEhk0Da1e8k8td9QuWxi0joTzUaNjMryCcg==
X-Received: by 2002:a5d:53cd:: with SMTP id a13-v6mr4621480wrw.71.1541036396878;
        Wed, 31 Oct 2018 18:39:56 -0700 (PDT)
Received: from [10.0.0.5] ([207.232.55.62])
        by smtp.gmail.com with ESMTPSA id t17sm18039716wrx.9.2018.10.31.18.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 18:39:55 -0700 (PDT)
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20180930205448.26205-1-natechancellor@gmail.com>
 <10b12992-3570-4646-374b-82cbd7276839@acm.org>
 <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
 <1538503063.193396.6.camel@acm.org>
 <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
 <1538521591.193396.8.camel@acm.org> <20181025213144.GB24709@flashbox>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From:   Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <1c58c82f-5cfa-f483-097a-5b82904e5e9a@electrozaur.com>
Date:   Thu, 1 Nov 2018 03:39:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20181025213144.GB24709@flashbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/18 00:31, Nathan Chancellor wrote:
> On Tue, Oct 02, 2018 at 04:06:31PM -0700, Bart Van Assche wrote:
<>
> 
> Hi Bart,
> 
> I'm sorry if I didn't follow the conclusion of this conversation properly
> but this is the below diff you were initially looking for, correct?
> 
> If so, Boaz and Nick, do you have any objections if this is v2? I'd like
> to get this patch accepted so the warning can be fixed for everyone.
> 

ACK on both the original and below code they will all work just fine.

I do like the original "just remove the _weak thingy". But this one
will work as well.

The "with extern" version suggested before is more cumbersome because it will
need an EXPORT_SYMBOL() but will also work.

The all use of osd_root_object is just. A properly C-types pointer to couple
of ZEROS. but since the Interface needs a pointer, those zeros need storage
somewhere. It does not matter where. (The value of the pointer is not used
only its content)

Do you need that I send a proper patch? Actually the original first patch
is the version I like. (And again all 3 approaches will work)

Thanks
Boaz

> Thanks,
> Nathan
> 
> ================================================================================
> 
> diff --git a/drivers/scsi/osd/osd_initiator.c b/drivers/scsi/osd/osd_initiator.c
> index e19fa883376f..4250f739beb3 100644
> --- a/drivers/scsi/osd/osd_initiator.c
> +++ b/drivers/scsi/osd/osd_initiator.c
> @@ -58,6 +58,8 @@
> 
>  enum { OSD_REQ_RETRIES = 1 };
> 
> +static const struct osd_obj_id osd_root_object;
> +
>  MODULE_AUTHOR("Boaz Harrosh <ooo@electrozaur.com>");
>  MODULE_DESCRIPTION("open-osd initiator library libosd.ko");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/scsi/osd/osd_uld.c b/drivers/scsi/osd/osd_uld.c
> index eaf36ccf58db..770c758baaa9 100644
> --- a/drivers/scsi/osd/osd_uld.c
> +++ b/drivers/scsi/osd/osd_uld.c
> @@ -73,6 +73,7 @@
> 
>  static const char osd_name[] = "osd";
>  static const char *osd_version_string = "open-osd 0.2.1";
> +static const struct osd_obj_id osd_root_object;
> 
>  MODULE_AUTHOR("Boaz Harrosh <ooo@electrozaur.com>");
>  MODULE_DESCRIPTION("open-osd Upper-Layer-Driver osd.ko");
> diff --git a/include/scsi/osd_types.h b/include/scsi/osd_types.h
> index 48e8a165e136..eb31357ec8b3 100644
> --- a/include/scsi/osd_types.h
> +++ b/include/scsi/osd_types.h
> @@ -28,8 +28,6 @@ struct osd_obj_id {
>         osd_id id;
>  };
> 
> -static const struct __weak osd_obj_id osd_root_object = {0, 0};
> -
>  struct osd_attr {
>         u32 attr_page;
>         u32 attr_id;
> 

