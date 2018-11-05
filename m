Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6240DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1210720819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4FHZzQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1210720819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbeKEWVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:21:30 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43206 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbeKEWVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:21:30 -0500
Received: by mail-io1-f66.google.com with SMTP id t81-v6so6387942iod.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 05:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F/Diglfu0cQmJoOlBIfw4Hdym/CCC9zalshDPd0545s=;
        b=Q4FHZzQdKyyikvZCZKU1/LafoWhC46kSE+D3QmpUmC/Z6kNornBJB8g3/Iu+Bq7hZI
         ZT7dp0+ET3uMwrTPDJZapJjnq0jVPc9RKHAcSoXAv3fV2lrNtebi6VfBADuB6t0tyk3/
         aH1m7Hyyw3fkF8Nqor30cVQ3zjwGzvhJvoTDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F/Diglfu0cQmJoOlBIfw4Hdym/CCC9zalshDPd0545s=;
        b=lfCN1DzGM0bjh3w76anYggd2hMd0HajX2CcS2cLdgEfTZwsPYrwl9S2G2vwgCYJlx7
         Utqceqdcyld8D7yXaSuJxBX1LyYcTjmLx2b0TOLMqmT3mNIhPtPyWTLXabRFSS4xV29S
         jE2/dWBKZPw6vX8eCazA+xrhWbhKnknF+ExDMrdVsm4eFwjDC40W8C+WCle2yYQ6Lsk0
         iLVr64DYqqIUPqCmZudeqmjA3GAIbpHCft17Q75jP2te3mvE3jFU968nAA/k+zuKmjwO
         PSgQmTj5+7NXE9fb5twufV6vjpHKsxs02eVBKlQ8J8zcbgefprx4hLddow8amKN9MUQe
         8wJg==
X-Gm-Message-State: AGRZ1gLvDwIdHga3YbCy90/t6+7Xu6q5MzDUwdESglBVs6+leodEXP0K
        p6uWX0iPolq7KFypA6vtwwGJ47QFHe81C7Ri1nykAg==
X-Google-Smtp-Source: AJdET5cv0rmNhekNrtu/WusiP9vtrngMz5lzXmLdzvieOkr+Cu0LfIWYdgaJBDxYab599DMdXm45puEDZq2a8CPnSIU=
X-Received: by 2002:a6b:37c2:: with SMTP id e185-v6mr17889726ioa.173.1541422910859;
 Mon, 05 Nov 2018 05:01:50 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 05:01:50 -0800 (PST)
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F485D622C@ORSMSX114.amr.corp.intel.com>
References: <1540304307-2806-1-git-send-email-longman@redhat.com> <FFF73D592F13FD46B8700F0A279B802F485D622C@ORSMSX114.amr.corp.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Nov 2018 14:01:50 +0100
Message-ID: <CAKv+Gu-JrZ+7VMbFt0u5_QWGJPJ=Dm+9FjbsKFEeHwfAwj_2wQ@mail.gmail.com>
Subject: Re: [PATCH] efi: Fix debugobjects warning on efi_rts_work
To:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Cc:     Waiman Long <longman@redhat.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 October 2018 at 18:43, Prakhya, Sai Praneeth
<sai.praneeth.prakhya@intel.com> wrote:
>
>
>> -----Original Message-----
>> From: Waiman Long [mailto:longman@redhat.com]
>> Sent: Tuesday, October 23, 2018 7:18 AM
>> To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org; Prakhya, Sai
>> Praneeth <sai.praneeth.prakhya@intel.com>; Waiman Long
>> <longman@redhat.com>
>> Subject: [PATCH] efi: Fix debugobjects warning on efi_rts_work
>>
>> The commit 9dbbedaa6171 ("efi: Make efi_rts_work accessible to efi page fault
>> handler") converted efi_rts_work from an auto variable to a global variable.
>> However, when submitting the work, INIT_WORK_ONSTACK() was still used
>> causing the following complaint from debugobjects:
>>
>> ODEBUG: object 00000000ed27b500 is NOT on stack 00000000c7d38760, but
>> annotated.
>>
>> Change the macro to just INIT_WORK() to eliminate the warning.
>>
>> Fixes: 9dbbedaa6171 ("efi: Make efi_rts_work accessible to efi page fault
>> handler")
>
> Thanks for fixing this :)
> Looks good to me.
>
> Regards,
> Sai

Thanks

Queued in efi/urgent (with Sai's ack)
