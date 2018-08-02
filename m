Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6B1C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7B32159F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Z75LJRwC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P33+FX1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7B32159F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbeHBXt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:49:56 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46586 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731925AbeHBXt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:49:56 -0400
Received: by mail-yw1-f68.google.com with SMTP id e23-v6so216812ywe.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 14:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=56IjTREqObYMyQTisoaqJLTbN3CTCDy9WMymtl99x34=;
        b=Z75LJRwCmgCvms+8KOBk2BT5T1D++fwWeQYC6+pgxB4pHpg/BHO6crhTSkGb3F/nyQ
         DoDxd/ZC1pdMc+Xb8UBH+BeDtBTNmSCMtHABsCmS1ipFMuo/xsxqmJNRrSlx8LiRjgze
         gapUL+vMnyCgN4ZKFDKSWfSRl2boowdZBDAnQsBOQyrTe3BcRvuXsLAnQuVqAcW6UEnt
         gAZga9sGmZdcGTCJco7fd7yNSDZ54u5uKeEtQ72fYy/8RzJZTlkLg4QYT9bCFJ9ND5NL
         ou7CwWIYW5SZc/zWZ0eVVhWfunXhGRfWO9wgzUT08nRCtSLYszcp/yDeSCwL4nYgt56i
         49Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=56IjTREqObYMyQTisoaqJLTbN3CTCDy9WMymtl99x34=;
        b=P33+FX1Tn/rigBqmEccnNjV1R8T+P21edXK+MyUrr2YuWmn99O2YZlnHwFq00v2afM
         dVhLZnNYr+Vl25fEp9BJiXE2g0jyl2/gHMG+59cA6wSI/IGkRxNrzkhpocLTElkzr0bJ
         46Ldej3sXtkOQQUXDQrpsVoFgiamyKzmR2HIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=56IjTREqObYMyQTisoaqJLTbN3CTCDy9WMymtl99x34=;
        b=bO2ggi3dqqwHpSB2dHSeDYAJ/QqFxBxdiZbbvFPhZsEtFoY7roDA7ih1/Fc5RZNiih
         jmaRKm92cyKV+8zS8eQFQoF9q1qa+e61ZFXeMr0utcicHr3SpFXW5qpWYro2qe34Y7Ph
         /mBYh5d1jnfn2V4Cbxcz+PRlqL2Lg4N9fbq71wXHg0gmdB3QcVpqkSQmJZLI4SJLggf4
         lC5gmGIHcZ5WKfNfqoXUDOUb9sZOo3rhy3GUjAOd3J8I/8nlaMcMtJ4DNHGbbBPixsyJ
         AU4XzXpkjQfTK3+NkhDCBf8sswTHMwcEdThIzImE9UCvbEJF2r3Rj87orxN3mdztcPvm
         sxog==
X-Gm-Message-State: AOUpUlFzIFptkMFvmPa1NunxkHQeSm4abj3IImhM8iyf/cWSmmf7obhX
        Ys3iajlkO5ABm8ljf4PtlpA4Wxu/u+li6HqJuIaoAw==
X-Google-Smtp-Source: AAOMgpemYEWQ7CJm0C2ocNnzf5+Hcu3/SQ0lfKsevGyVcxiUGUkDXq54Gw55po18cJOtCgs4zZXYGNegu082mgerDxk=
X-Received: by 2002:a0d:f002:: with SMTP id z2-v6mr808445ywe.116.1533247010510;
 Thu, 02 Aug 2018 14:56:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 14:56:49 -0700 (PDT)
In-Reply-To: <50e0f257-60d9-73c8-b4ac-a93c7bdccb57@kernel.dk>
References: <20180731195155.46664-1-keescook@chromium.org> <50e0f257-60d9-73c8-b4ac-a93c7bdccb57@kernel.dk>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 2 Aug 2018 14:56:49 -0700
X-Google-Sender-Auth: t0lpCkeC69c_SVxhh_fJMCus7sk
Message-ID: <CAGXu5jLKk_9rw5etROW4ucwK+ZR7YfC_zq+6AwtxK4=S3Y7sOw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] block: Consolidate scsi sense buffer usage
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Juergen Gross <jgross@suse.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vinod Koul <vinod.koul@intel.com>,
        David Kershner <david.kershner@unisys.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel <target-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 2:24 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 7/31/18 1:51 PM, Kees Cook wrote:
>> This is a follow-up to commit f7068114d45e ("sr: pass down correctly
>> sized SCSI sense buffer") which further cleans up and removes needless
>> sense character array buffers and "struct request_sense" usage in favor
>> of the common "struct scsi_sense_hdr".
>>
>> First, drop a bunch of unused sense buffers:
>>  [PATCH 1/9] ide-cd: Drop unused sense buffers
>>  [PATCH 2/9] scsi: cxlflash: Drop unused sense buffers
>>
>> Next, allow the sense buffer to be usable outside SCSI tree:
>>  [PATCH 3/9] scsi: build scsi_common.o for all scsi passthrough request users
>>  [PATCH 4/9] target: don't depend on SCSI
>>
>> Then move all request_sense usage to scsi_sense_hdr:
>>  [PATCH 5/9] block: Switch struct packet_command to use struct scsi_sense_hdr
>>
>> And do some further cleanups for scsi_sense_hdr now that we can:
>>  [PATCH 6/9] ide-cd: Remove redundant sense buffer
>>  [PATCH 7/9] cdrom: Use struct scsi_sense_hdr internally
>>
>> Finally add a build-time check to make sure we don't pass bad buffer sizes:
>>  [PATCH 8/9] libata-scsi: Move sense buffers onto stack
>>  [PATCH 9/9] scsi: Check sense buffer size at build time
>
> Thanks Kees, applied for 4.19. Note that I hand applied patch #5 and #9,
> since they did not apply directly to the block tree.

Thanks; I appreciate that. I think I was based on v4.18-rc2 or something.

-Kees

-- 
Kees Cook
Pixel Security
