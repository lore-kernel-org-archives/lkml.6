Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2748774-1523735671-2-14869786595820968946
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='dk',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523735671; b=XMEv5bqrmRtYqcPqsYE6SnulxdG+R/l+cpcAW8I6ruhZQCfPPG
    jrDcsxtH9mc6vs6W76A5hL6ekRGKa1UsmE/lCJJ7xUfE1xcq03dtDGYi2DHdrHwa
    XcwLZY7eAGsjAET3IfzoVOH3M992jvMsXsCO6wW3cwQ9YJzzNxfdb/g8Iiv1XOXr
    plZYiuRGmkRhx4gbsc7zz+QxQheSVyqD71ffPINaVJQImo4/lPzN4L1E6O7D2ErQ
    l8g6q8naZ6sLPgeYPNWAHbZSdUcRN2WmhXCtYWR+hqV1Y7xt3ybz391pZP3CkrHB
    CbEGvrSuP62Mf6hqPfGzlfM++DNOxT0s9vKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523735671;
    bh=T4z0x3KEuT7kpaHO87Kd7+dwsRIMQD6HF8lZMaHfWzM=; b=X3mAK8KywXEl
    dK7APxJAtaSFd79tI3E7n35V95gzsRSMeEVj+DoIdUaW5idrJlyyurUIwdGb3EIW
    EYmyQMPMe9LdfPdWeNAZiNvJ+AX1J54uiL6MqlyXM28g128lfLzQyE+f4UbLEqS5
    KuzUalJsrbhGe2nhpT2ip2cPFYWlDmVL4KAuzHdBCQbEeaa88WE7jvMWh/pJZVsr
    /YdatmXGrpV+8Iz0d9Ac/5OFCb9ttqo6EaJCCwKIk9uZDe480NWeUN7l4hAEjxRt
    4EaN/Td8sPyLW+NY2lKjITQpsDkslMAxNsn/DI6q+bVgIcVodR22N27Ka7lCuydh
    oRIxz5gvUw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b=nGsbbGZ8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HBovkc8t;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b=nGsbbGZ8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HBovkc8t;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCTC+JBYp0frUgC9dL/xb7KOhl5G9lkALggXUfI6IELn8rxDoDbBx6yQG1GdMmiuOj/QHSeywVR06IBuGADrA6l9Q8cCujJz2Swcqd8t1h3ePvRI0TB2
    XisnC3iwkKtmlfk563GPKKWPaAqpXtLSt3BDg34uZK2o4yRqyn8jEZcMvQ1DWNo4S/OIDdIYA4ld5WfSDQlMhVHT9TIaDL+XVblX4cx3+Id1/ryr6H+Qe5DP
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=E7IBzyH0t4LPFwAEzkUA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeDNTyR (ORCPT <rfc822;greg@kroah.com>);
        Sat, 14 Apr 2018 15:54:17 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42743 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbeDNTyQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 14 Apr 2018 15:54:16 -0400
X-Google-Smtp-Source: AIpwx49xOEVPnlctykXjV1CZnV9vrq5gOpDVUqeBbibUY8bgbeyLm/RYZ2p4xvYksiIeUnKNL26Z2Q==
Subject: Re: [PATCH v2] block: do not use interruptible wait anywhere
To: Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        linux-block@vger.kernel.org
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <13e67e1243ebd96f3f56a150d47444ada47ebde0.camel@wdc.com>
 <20180412181158.8884-1-alan.christopher.jenkins@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9111da3e-1b16-3e73-fa3a-940f5a43c545@kernel.dk>
Date: Sat, 14 Apr 2018 13:54:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180412181158.8884-1-alan.christopher.jenkins@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/12/18 12:11 PM, Alan Jenkins wrote:
> When blk_queue_enter() waits for a queue to unfreeze, or unset the
> PREEMPT_ONLY flag, do not allow it to be interrupted by a signal.
> 
> The PREEMPT_ONLY flag was introduced later in commit 3a0a529971ec
> ("block, scsi: Make SCSI quiesce and resume work reliably").  Note the SCSI
> device is resumed asynchronously, i.e. after un-freezing userspace tasks.
> 
> So that commit exposed the bug as a regression in v4.15.  A mysterious
> SIGBUS (or -EIO) sometimes happened during the time the device was being
> resumed.  Most frequently, there was no kernel log message, and we saw Xorg
> or Xwayland killed by SIGBUS.[1]
> 
> [1] E.g. https://bugzilla.redhat.com/show_bug.cgi?id=1553979
> 
> Without this fix, I get an IO error in this test:
> 
> # dd if=/dev/sda of=/dev/null iflag=direct & \
>   while killall -SIGUSR1 dd; do sleep 0.1; done & \
>   echo mem > /sys/power/state ; \
>   sleep 5; killall dd  # stop after 5 seconds
> 
> The interruptible wait was added to blk_queue_enter in
> commit 3ef28e83ab15 ("block: generic request_queue reference counting").
> Before then, the interruptible wait was only in blk-mq, but I don't think
> it could ever have been correct.

Applied, thanks.

Still want that test in blktests, though!

-- 
Jens Axboe
