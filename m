Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30724C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0F0240E5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvWTh8bw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0F0240E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933669AbeGDK2a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:28:30 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35351 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933113AbeGDK22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:28:28 -0400
Received: by mail-oi0-f66.google.com with SMTP id i12-v6so9806371oik.2;
        Wed, 04 Jul 2018 03:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=GgnLvvZQGRT52S3podpSwchRYSD56gHdAX5KhpKT2Hg=;
        b=pvWTh8bwxbpDdJKkQRiW3C+bNO6ZuPFu6Nuq2pz+p/U9qjerRWeRWXRSzW5VXpmBfh
         W/PlauoN6pnaURpl6HNyakz8pEELjPynecOLViXQpK93dLzjw+Le61EzBVc6UuVcovC7
         ttYG/5bd4FX5RSxBhwQGNJHUZrJNX0p6AMB+Mmgg9/8706xm9FM16ZCr9P+izbu+ZO+d
         N8IXqLkD/jJ8sMYPxjHW2Hnz+/+6aYz3sQr0hU19d0NiMsofAUR4V3b03rq9tTkpwUEF
         yRIgASax/pZvXr/v05hiD5xrNAxT3j4iwnqlUEvxuVSHrUQZAR2JMpS9vC4eyp9jLWb6
         VNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=GgnLvvZQGRT52S3podpSwchRYSD56gHdAX5KhpKT2Hg=;
        b=a9F0bGRHdXjqtBIeLCr/teFEt7edKOtwt/B/cOWDsug5gWiOHe1Q2e8DnC4usuafa4
         HDCYkb1R+xQzO1j8O4sYlltq3S5Qm4JO++lcNitZHy0AAFaxJIDJaYq9oDrCT708KWfS
         LT+Fn8PF537Dc9DCcEI4syD0Ae6oKEZIg5PUKI0NDBNuD5IRtgkP67b+plXQJQ0vtpst
         vauvH/QC27RXyD5XwKHe/hAd1bRCAGc2MO6ILkUIPgusRf6fF7+aDf+AHvTJHE1CaGng
         GWVsOJemmlQ3qxjybzKhMdRA2H1oZsq298HhHGoRgc43om6mnGB2nIPEZcHWNjVRgDZU
         hp0A==
X-Gm-Message-State: APt69E3Hq9hX6PUXhCjf6zQ/WAUnnZf/qs5vXtvg6uNVuHr5V9nanMJe
        KhUaMh4pk3g2HE27WCtCN3a8L00QbWSOzCf/W8g=
X-Google-Smtp-Source: AAOMgpcYSc4pLmUQzzA+UswcY+zEkhtPb3b1yHR09GOY0M6VDf8a5N65G2rxe+s71ZLj+04a4vSoMAbU7xgm+2REyz4=
X-Received: by 2002:aca:ad4f:: with SMTP id w76-v6mr1585420oie.233.1530700107790;
 Wed, 04 Jul 2018 03:28:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 03:28:27 -0700 (PDT)
In-Reply-To: <CAHp75VeuoTM=RoUgk0qWyiRJYk2AncVhxKDvms_2Hv0yE=g8uQ@mail.gmail.com>
References: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com>
 <CAHp75VfPvCD7xpp73jbya4ONN=wxpVGNpOfNeqZYjfyirms0PA@mail.gmail.com>
 <CABe79T7EeyzKS97zeQ5akoSaZX0=hMgHxw4XkLCQW15eRR=14Q@mail.gmail.com>
 <CAHp75Vef97XB-M=+xUxsGqzgPrADcUmLTLRdWE+PcVxtTQLN4g@mail.gmail.com>
 <8518137d-c859-657e-844f-51720f6ef8dd@arm.com> <alpine.DEB.2.20.1807041205290.8629@fox.voss.local>
 <CAHp75VeuoTM=RoUgk0qWyiRJYk2AncVhxKDvms_2Hv0yE=g8uQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Jul 2018 12:28:27 +0200
X-Google-Sender-Auth: yeBg6glKyVAKoKMFTPqD3KlgKZs
Message-ID: <CAJZ5v0i1qO+jBWjypEcwJAkajSedqHJA4iyHiazNz7QT62mKLQ@mail.gmail.com>
Subject: Re: [RFC PATCH] ACPI: bus: match of_device_id using acpi device
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        "Voss, Dr. Nikolaus" <Nikolaus.Dr.Voss@loewensteinmedical.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nv@vosn.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 12:24 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Jul 4, 2018 at 1:17 PM, Nikolaus Voss
> <nikolaus.voss@loewensteinmedical.de> wrote:
>> On Wed, 4 Jul 2018, Sudeep Holla wrote:
>>> On 04/07/18 10:32, Andy Shevchenko wrote:
>>>> On Wed, Jul 4, 2018 at 6:37 AM, Srinath Mannam
>>>> <srinath.mannam@broadcom.com> wrote:
>
>>> +1 on NACK for this and anything else that abuse PRP0001 as a short cut
>>> approach.
>> This is no abuse but exactly what PRP0001 is meant for. The basic idea of
>> PRP0001 is to reuse DT "compatible" strings in ACPI namespace, see
>> Documentation/acpi/enumeration.txt. Reusing also means getting access to the
>> of_device_id.
>
> The idea was for almost DIY and / or manufacturer to develop a
> prototype without modifying match code and faking ACPI IDs.
> That's why the target of PRP0001 is almost sensors connected to I2C and SPI.
>
> That's why I agreed on your patch to help with this. But! The proper
> solution for the devices (device manufacturer) is to allocate an ACPI
> ID and provide a corresponding table to the driver.
>
> This is my understanding of that exercise. Rafael can correct me.

You are right.

>> Allocating an ACPI id for an already existing DT driver is redundant, isn't
>> it?
>
> It is not.

Again, right.

Thanks,
Rafael
