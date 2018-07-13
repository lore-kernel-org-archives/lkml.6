Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0633EECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF8120864
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="P5usnKxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF8120864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbeGMUOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:14:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39041 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731131AbeGMUOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:14:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so5240082lji.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 12:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rb85pGJ8kCyjJAfDK2rQg3tZvyAuucE1ILGhK6chLss=;
        b=P5usnKxKiFDTOhCzr0BcjW3rRiT/huUG+q6N9onLrlHTRR6zs09tQ44SCWgFPgT+h3
         +cqKb8X/H88UeVCVQZ0MocgsL/dWXJ+xsXoqoeO70VPB9AAEi6GH3tclN+AM2h4/3uE1
         nT6n0FBXi7olUeuaKP8ahPRg5/APpOm1dy0Q+K9Tm6O9tJ8knuusjB3t0PwDxazZ9sBH
         uNqVqPoGQVtcTqXxMPmHcp+7WKyTUIV7TWnZMvOaD8G90Q2YMviWAckOVDr2xKOLWpNt
         wlCGZe24WI8OFag/jNFL6W98Az7JOj/dMG16Ji3MxzdgaeAPWtCCnvviT+qUBY2MrXqS
         YNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rb85pGJ8kCyjJAfDK2rQg3tZvyAuucE1ILGhK6chLss=;
        b=cN9I/SdlXhYdcRTzTzS/Q3DxGNLG94C/0OJRTYi5UQgnfj2jAbG2PCrrywAB8qXAFa
         09oOqksx2ols7EXnY/ASk+84slQBaUVl5mG+1/3Qp10BPyPgm9/PJENCEV79tVFeGdwf
         FgnBNLxvZSEVHy0/S78BGmE9JEsU8TU44//MKvkcCWyq84av0pFIyi36Jrn44JdmzOUq
         n9neTZzzI1Cyi2KFAg7rH2XDZkUdibi3aPpIrs7en5VMWOOP0yW0CYgkQGb08qFu7G2w
         Bn3icxLrtaVqazXPiecngBezob/LE8dZ2GDrIT7VJPIG3oAL//UpO6LN69okbVacyKP8
         978w==
X-Gm-Message-State: AOUpUlGvh+xX1NddXz0Dqf9ICia7oxn1VF9huI7pT/RXe1pkRigttwG/
        n2Cu/UXdT1X6s0neB+4i/C47ZolY3WSXnZMok/i7PA==
X-Google-Smtp-Source: AAOMgpcHz3g79wywsKDDfboeImX8J8WDjEW+KZb+qmbLAm6obpcZHT/40EPxaudEcGKaYuNOXiw53ZQHUz3/uzYsiwE=
X-Received: by 2002:a2e:5519:: with SMTP id j25-v6mr3975400ljb.124.1531511925354;
 Fri, 13 Jul 2018 12:58:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:fc1c:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 12:58:44
 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:200::5:e750]
In-Reply-To: <33f65453-5b6d-0684-8a91-7e9940846143@redhat.com>
References: <20180713150701.GA3049@arm.com> <20180713153033.20540-1-olof@lixom.net>
 <33f65453-5b6d-0684-8a91-7e9940846143@redhat.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 13 Jul 2018 12:58:44 -0700
Message-ID: <CAOesGMj6m8q1aRz0k3qPTo2-Fur66nSsBaVNxcDnrrmWbUxe-Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: build with baremetal linker target instead of
 Linux when available
To:     Laura Abbott <labbott@redhat.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Kocialkowski <contact@paulk.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 12:21 PM, Laura Abbott <labbott@redhat.com> wrote:
> On 07/13/2018 08:30 AM, Olof Johansson wrote:
>>
>> Not all toolchains have the baremetal elf targets, RedHat/Fedora ones
>> in particular. So, probe for whether it's available and use the previous
>> (linux) targets if it isn't.
>>
>
>
> For the Fedora toolchains:
>
> Tested-by: Laura Abbott <labbott@redhat.com>

Thanks!


-Olof
