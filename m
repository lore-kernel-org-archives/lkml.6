Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3497624-1521619470-2-15576156287401052258
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521619468; b=oFR4qRQUAJGfFkc/eALYhDGqfQyEk3HpK57188qLO8Ru2G5
    cuQ0SrJ+smSKcV7H3nKTnOZSPxKQBRPROwvk6Q5VbfIuqJj/SA4zlMXjoTjHY8oK
    gt/DeRpb1sHoSn1+Uh/cAMwaS8n60/ATya6ZiAXYs++0dnFW6+iGQ43xWXXAPCYE
    OqFm4C0acTjvnOpd2kyVh8ErEvfhWTutBPGjG28icuY8QrRIK5IDVPlRG8BYV4pZ
    4Sq/A/R8NWWoNlFe3gA1EjX/0g4O1KQkup6gLVNBKRDrBDo4RAoOKgX7FbIGIjfC
    66sbwE8bjUlkWDSbO/9g30XFoay1RWWBLdC2THg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521619468; bh=dk3sNsssVuFfZqnQNry9GgReqATE5uId6Int5a
    EKCMY=; b=FoUSTzenoSlibD1FEo7o7hVx9iKjYW0yP5+3Gl9ySCpSJ2X0A2QAQQ
    UlpCnD/6R9bIWhYY1oRnR0epJjY+5s/geTJDQA6IPbLFt6Yp9RJFz5HcDGEcZza3
    Zvyp27qKEwk9kbjSvuV/Weu0BoA7FycdngASSq/HJgpAkiibPMaLimOlDBVbuklQ
    9T+CKNHNjH1M6ClIx3jgy3+LkWTIncakRFG6bb336n5seRYICIpdMjvK6UE/ZYx7
    j2RSoGELTkbOa29s1fi9dU/jsYlXMEJbvePiay7uhJP/6TS2yA2F3a5CaIzdHbFm
    vptKnS29Y3o0IAuf6/hooq1LramJDc5w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b=XiKmBycD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brainfault.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZD+ZZ7bP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=brainfault.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b=XiKmBycD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brainfault.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZD+ZZ7bP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=brainfault.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeCUIEZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 04:04:25 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41573 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeCUIEV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 04:04:21 -0400
X-Google-Smtp-Source: AG47ELuFkBY/MEL140LQgcK4x8iDZ6fcutzbGBKZZyuO7nZMOkHpg0PgsE5eEwGNzZMFBMq3FTi+dpkfozLMcEPaVrg=
MIME-Version: 1.0
In-Reply-To: <20180318224744.GL5626@tuxbook-pro>
References: <1515590217-24256-1-git-send-email-anup@brainfault.org> <20180318224744.GL5626@tuxbook-pro>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 21 Mar 2018 13:34:18 +0530
Message-ID: <CAAhSdy2JcXTkbtO95yjp4eYQ7cTwS62hh_U1qk3k7taN2ySWgw@mail.gmail.com>
Subject: Re: [PATCH RESEND] rpmsg: virtio_rpmsg_bus: fix rpmsg_probe() for
 virtio-mmio transport
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 4:17 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Wed 10 Jan 05:16 PST 2018, Anup Patel wrote:
>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> [..]
>> @@ -924,9 +925,16 @@ static int rpmsg_probe(struct virtio_device *vdev)
>>                                    total_buf_space, &vrp->bufs_dma,
>>                                    GFP_KERNEL);
>>       if (!bufs_va) {
>> -             err = -ENOMEM;
>> -             goto vqs_del;
>> -     }
>> +             bufs_va = dma_alloc_coherent(vdev->dev.parent,
>> +                                          total_buf_space, &vrp->bufs_dma,
>> +                                          GFP_KERNEL);
>> +             if (!bufs_va) {
>> +                     err = -ENOMEM;
>> +                     goto vqs_del;
>> +             } else
>> +                     vrp->bufs_dev = vdev->dev.parent;
>> +     } else
>> +             vrp->bufs_dev = vdev->dev.parent->parent;
>
> I really don't fancy the idea of us allocating on behalf of our
> grandparent here, as you show it's not certain that our grandparent is
> what someone originally expected it to be.
>
> With the purpose of being able to control these allocations there is an
> ongoing discussion related to this, which I believe will result in this
> being changed to at least vdev->dev.parent..
>
>
> I do expect that this discussion will be brought up during Linaro
> Connect the coming week.
>

Currently, rpmsg_probe() is broken for virtio-mmio transport
hence I send this patch as a stable fix.

In general, I am fine if we are eventually going towards
vdev->dev.parent usage.

Regards,
Anup
