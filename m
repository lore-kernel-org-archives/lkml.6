Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F7EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4989D2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqrAVmzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4989D2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937276AbeFSFKu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:10:50 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40867 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937149AbeFSFKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:10:48 -0400
Received: by mail-lf0-f65.google.com with SMTP id q11-v6so28082264lfc.7;
        Mon, 18 Jun 2018 22:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jqocPKbejn3H5TqRBx3+C5cjB1foqlL7jjDbJHAdG1o=;
        b=mqrAVmznmBq86tFa1GD6ou3HEf+dmS6sCHIQeVlNmuzjaYjWsE1VrJI55tO36ood5S
         ndO7jubUq1pMqkyYQ8J+R+Uz1f7m6l+yInXhG6BsHyncEGJcBvWDby0Zhz2CnP4TxgP6
         bRZ+J3ZTifZ811kWNN8GeBXi2YE399zN257skmBoSywXZABA1czkwCPIwscewTi46SyS
         v9T4UB0W2bG2eOXZsXVyqtJuEGtx2Ibzzf8qpknvK3AejyUGrh8VhQOZMDwTpv5GbK3T
         qwklYMcDGbLXdfRFtXul0lDvK/8CTEuWvl+afPC30ArEIk7Ghw4ppGKmZc5J0Po/iEn8
         5Y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jqocPKbejn3H5TqRBx3+C5cjB1foqlL7jjDbJHAdG1o=;
        b=tovlYyEE4lm3Tl45Ko4dO69ZNaA1jlDrqZCA8tCJ3NGr+q0bv4KVaBh9oRFKcZNhdw
         ONRHikqaa2P1wU2o2Qu2dM3Q9TOycrQBdd8K4LSR2ZnKehaVlio8GEYlQ8JAdAN9LT/g
         20lOfO2Yxqe6b+hR2WE6izCsvMUnpEGICCFDIZtMi38GbYEMUPna6LCW75spznfYOZ2H
         Vf5UAeOPoEcDY0Y7ouImd3nJHnEhzc72iUnIuDPUtd5gKcm/LpKHVMFGkz9iAM1Qz8PF
         IFvKGbrUgWE+K+9QZ2P+y/r8FhmiHoeMrI6hkeJGY07gcxfN8x40VaUNnUvw7k/qVyZL
         vfiA==
X-Gm-Message-State: APt69E3fPCaOhT7OF/tJcOIVDiUIaGZQQNtXzLkhrCKkF/moivRb8Z5E
        MbAfd2v+t2qodI5wkhDAIgJEuWxEgt/aaeMRJtU=
X-Google-Smtp-Source: ADUXVKLzkjm7CpR/0EvzeY96ZPPnfKNOxU2TQGpsYlOBBHU/qPHimAGDSr5vKaZLWwHFpE28OJaAPv4xQV1bTeiXW9w=
X-Received: by 2002:a19:1647:: with SMTP id m68-v6mr9494588lfi.131.1529385047226;
 Mon, 18 Jun 2018 22:10:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b43:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 22:10:46
 -0700 (PDT)
In-Reply-To: <20180613232347.GA3851@p8tul1-build.aus.stglabs.ibm.com>
References: <20180611194204.GA18687@jordon-HP-15-Notebook-PC> <20180613232347.GA3851@p8tul1-build.aus.stglabs.ibm.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 19 Jun 2018 10:40:46 +0530
Message-ID: <CAFqt6zb-fDRdH1_k7QwW_YEErKYPYFNpJFrK7N82P0PLiKnRtA@mail.gmail.com>
Subject: Re: [PATCH] scsi: cxlflash: Change return type for fault handler
To:     "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>, manoj@linux.vnet.ibm.com,
        ukrishn@linux.vnet.ibm.com, jejb@linux.vnet.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        brajeswar.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 4:53 AM, Matthew R. Ochs
<mrochs@linux.vnet.ibm.com> wrote:
> On Tue, Jun 12, 2018 at 01:12:04AM +0530, Souptick Joarder wrote:
>> Use new return type vm_fault_t for fault handler. For
>> now, this is just documenting that the function returns
>> a VM_FAULT value rather than an errno. Once all instances
>> are converted, vm_fault_t will become a distinct type.
>>
>> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>
> This looks fine to me.
>
> FYI that there is another handler for this driver in a series
> destined for 4.18 and currently in next/master.
>
> Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
>

Matthew, is this patch queued for 4.19 ?
