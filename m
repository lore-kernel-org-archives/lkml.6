Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED20C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B4A25A43
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="d4SWjT/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B4A25A43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753273AbeF0G6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 02:58:49 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53722 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752537AbeF0G6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 02:58:47 -0400
Received: by mail-it0-f65.google.com with SMTP id a195-v6so5947666itd.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 23:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=OIDx7Ajq83ssy7biP6aSeyVvyPtgnUNjKCe1dV6aXH0=;
        b=d4SWjT/kVvocV6D5cPjF6zy7LmDJ0RmEK1VhDSu0IvoikpugX8meeAQ9bqogrhu1yP
         DiyA8FXSKJBJ/7yDaxabldbEyYopzi0rzYK8dJ5pchdPMpOLlqYQvIpUt/VkaT1dguNA
         8XO50OvokpH37YnxfGQESU+s8Udncd19KuThQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=OIDx7Ajq83ssy7biP6aSeyVvyPtgnUNjKCe1dV6aXH0=;
        b=tY0+biv46Oka6gNnthHzFcrkHrShqlnaqmTV9EJ0DWfDVW8oS2KjMkD3lBvbGJuMAW
         0gnlS7xCaz7wC1eNpJUlEXkuEKiVkdGfiwZlumz1LOloIeRKi2QtQ3aCYIjZqgt9yAkB
         R9c0mpiFgKsLjRBZFqPQ0zHf9sfiXPjiZEnnfzFqPs6iCrxNruQAHDQydzwZRFXYP0gE
         /OTAqz+6qswIo2HIhDXbtxVIs0L7QJOfG0Zc6+ajcBqVc8XlXhGi+dKxcXF9T3VTOaDM
         ZF6P9By0MG9cGS74xGe3Ho9167A0rcGK2wlwfHafDi+ZZTdrBC/P4597DTHVh23jYwlL
         nWEg==
X-Gm-Message-State: APt69E3PX9MlASxoB9EG8sHPhV5kzKufw+obHMxf+CiUt+POL+0Z37Ph
        EZeLWS1rKfQJdrMUtkWab3edE/bvjlzaaB3RY++xrg==
X-Google-Smtp-Source: ADUXVKLoz8o/tCCtBaayJFJ6SpA1Tj3McQcZmOeMTB4+aH3VLnp8Bz54udYA3J7jX09j6kTYTHaLv77gqatqdf+SCrQ=
X-Received: by 2002:a24:cf45:: with SMTP id y66-v6mr3888481itf.2.1530082726401;
 Tue, 26 Jun 2018 23:58:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e48b:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 23:58:45
 -0700 (PDT)
X-Originating-IP: [212.51.149.109]
In-Reply-To: <bc3429d4-44e3-29dc-3588-209ba30fb2eb@lechnology.com>
References: <20180525193623.15533-1-david@lechnology.com> <8840212b-fd46-e700-58a1-cb1b882c5771@tronnes.org>
 <d5297fc5-94f2-edcd-5a11-95d7a9dca78d@lechnology.com> <ecd75b89-14a6-12f7-0ec4-222b1f984e49@tronnes.org>
 <5a2bc4e7-c6cd-b270-61d3-61bfa5d9e90d@tronnes.org> <CAKMK7uF-hBjqnRG28fX7NXOJDc5YEWhq+G6s0M8usA+TXM1BKw@mail.gmail.com>
 <bc3429d4-44e3-29dc-3588-209ba30fb2eb@lechnology.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 27 Jun 2018 08:58:45 +0200
X-Google-Sender-Auth: wUpl1SvUXWOzu6M-QSPt-8VMg78
Message-ID: <CAKMK7uG5OdbiRFL26SzJ-+b0G64pfKftwtvG4CYGKpAt+rD5UQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] drm/tinydrm: new dirver for ILI9341 displays
To:     David Lechner <david@lechnology.com>
Cc:     =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Nitin Patil <nitin@mindsensors.com>, limor@ladyada.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 8:16 PM, David Lechner <david@lechnology.com> wrote:
> On 06/20/2018 04:07 AM, Daniel Vetter wrote:
>
>> I acked and forwarded the account request, sorry for the delay. Next
>> time around, poking maintainers on irc helps if this stuff is stuck.
>> -Daniel
>
>
> The account was supposedly setup, but I am not able to use it for some
> reason. Are there any particular nicks I should ping on IRC?

#freedesktop on freenode is the channel where fd.o admins hang out.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
