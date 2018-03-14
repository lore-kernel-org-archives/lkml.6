Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1913331-1521038961-2-13858161942961113219
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521038960; b=FPwfBLo/ABS8QeE1PnBt1gL3XtYM/Vfitbz6AjwbL6hYjxb
    +UTIn9PCyepXm4UtkjQbTlceDkHVKM+h/TIdD1104acFMnoJj+DJTbinxYccWqlB
    AcS3INVsDMvN5vrFKG3VkZBVAzn23JeLKABv6L3JfNbsNhcgTEgDs0Kt3tE9uwKq
    +X2S1Cng65CDtefe6AvTOnnenWZqOPWKdCVbYloXoP3EW5NYQ/pw8S5OnKyf8M2/
    9obc45mh1sZyw00+1/dl81SNVpOI2ja5J8xfd/83z/mNzrKIDC1pXKTYd44o/5Oe
    A62RdwiU8whF4El93PHnUoQ3/mddvC3xHxpyF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521038960; bh=trN4PbolsC8QHKsT/zwNWyKWgCB6W763VaDj8F
    yIrI0=; b=rPIG37kiIgIKojfNqz4Y6ApB2oVxsOGfLttOmfUOa5Vc35L8HVaaha
    PnuLQ7zdbVqH4Mdn3J3I1NrVyZQHMGupXR+eUxDwHVZf7RH8E/l9Idh/VAHlT3Fr
    O4fsxycbSjw1uvoae+AxtFXy6Em/Em833RMDeQ88h9nm2Y4HhQvgolTt9jBVBt2O
    pYGuweNEjkC/CL/oOPoyh+nDFxIQ2t5a3HaHspcXTsm79YsgeXqmZQ2qFBbNiy27
    UazSF2qYdTw928nwQFqmCZ3uK4H5V/q/Sv6bASDKCM69+I/kc24lojz9BA0Dt8OS
    0SS8reGOe7je1aSL2T2FMF9rFEzudH4Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751687AbeCNOtS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 10:49:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751440AbeCNOtR (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 14 Mar 2018 10:49:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCFC21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AG47ELvJ5lXP08zyOcSNgiwNy8CsxlwuvSYCnybL0p/eqgDBaQXYOz92mzwD8VqeeQgyTtHAnhFbk3vwvo7nwjYAE1M=
MIME-Version: 1.0
In-Reply-To: <20180314052121.GB32276@hao-dev>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-10-git-send-email-hao.wu@intel.com> <CANk1AXSfXBXj_NH4Qcj6EDXEzAD_+T1sVudJdMbbgKK7hk13Mg@mail.gmail.com>
 <20180314052121.GB32276@hao-dev>
From: Alan Tull <atull@kernel.org>
Date: Wed, 14 Mar 2018 09:48:35 -0500
X-Gmail-Original-Message-ID: <CANk1AXS7vmdnZ1M3xLiF-8aLueFdYfvjfXb3hvFkBVoo+iF36g@mail.gmail.com>
Message-ID: <CANk1AXS7vmdnZ1M3xLiF-8aLueFdYfvjfXb3hvFkBVoo+iF36g@mail.gmail.com>
Subject: Re: [PATCH v4 09/24] fpga: dfl-pci: add enumeration for feature devices
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 12:21 AM, Wu Hao <hao.wu@intel.com> wrote:

>> > +
>> > +       drvdata->cdev = cdev;
>> > +
>> > +enum_info_free_exit:
>> > +       fpga_enum_info_free(info);
>>
>> This is the only place I saw fpga_enum_info_free being called.
>
> It doesn't need to keep the enumeration inforamtion data structure once
> the enumeration done, so in the driver, it always did fpga_enum_info_free
> once fpga_enumerate_feature_devs(info) returned in this function. so
> no need to consider it in other places per my understanding. : )
>
> Thanks
> Hao
>

Oh yes I see!  I was looking right at it and didn't see it!  Thanks
for the clarification.

Alan
