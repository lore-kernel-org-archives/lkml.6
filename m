Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA09C6780C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805422098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLYmmmy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805422098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbeJLDCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:02:50 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45610 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJLDCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:02:50 -0400
Received: by mail-ot1-f68.google.com with SMTP id u22so10063138ota.12;
        Thu, 11 Oct 2018 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QXdy+05wAUhFfxAqeji1hrXwDrX5JLqRj5sDiSeCRo=;
        b=DLYmmmy/Te0ZbKuKy14SyPc4BZ6063601FbpJMAmpHIBVPZ1UZO4aWvCUFMobKmbWs
         K1+S2fX3BZykv6q5x4ndfuqTPYFDmrGtBicLIBaKDrg45pSTfjDYX4j9kZrUbz89kEUK
         zitv0X0LJkqtX7SsGnGQIr/OCx27TCZmHvgF74QnhDJqjQ6hHDCnPyzhdAWqMZOEA4fO
         RDCJQjQ06qdVOFHm4OqiPs2EJEFXAy1oekmUrVeZ66BnKNi0FMYiML5hJtRJjBLfc6JX
         6L0T7yRzH013Xoj4XdDASccYW3/bDmaCFiN+M3O5J1asZJoTxu3FDuP1gaM2cjQ5XkSo
         bjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QXdy+05wAUhFfxAqeji1hrXwDrX5JLqRj5sDiSeCRo=;
        b=N8LEOq6kTUsyVkejvbuK0vhSqjg48w+PN/e4t5jPneyLnIOd27nlvAGMA45gLRTGJa
         TdHnBhDPpNvsYqyxlNXt1ww9MatHvNGcf5BJZjk+HSV2VjIJ7+RWOs6FRcOFmMFiSQEo
         GofnfZw/UYLeOkLU/PdoMhrzQZpM/GW4lDsQutjZn9PT3nVMiJid53DGQE37tZOfV2+4
         0ZSgWrPq8C3uKtaSygQKXfOrwsB+cD4dR5dWMkaOIX0E8p0FcJioPmiSZ7VcUMqRWwg2
         jw+eD4MlXeRpQH0nUUYrEckBBQnDOqjDtVHy2oS1HMIYY5PaJMlx85oiqiIaPIeyga//
         ajwg==
X-Gm-Message-State: ABuFfogECbKFuYzrEsxpDbn9wejLWijACM/Ab6R3nOa4I5vJqZzAqXaz
        HIIrYFLz+wCnwySgR1vmM8gTgUlCgIuUPvKrH78=
X-Google-Smtp-Source: ACcGV60v/XDskRs37ZF7FbImLyROAXwnfqXbcix27kR716xnZn6O1uYs8xRV9vkiF3n5EK7ww/yp54cNjx1Gl10huSA=
X-Received: by 2002:a9d:1ea5:: with SMTP id n34mr1857225otn.160.1539286450260;
 Thu, 11 Oct 2018 12:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181011152508.885515042@linuxfoundation.org> <20181011152510.156825448@linuxfoundation.org>
In-Reply-To: <20181011152510.156825448@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 11 Oct 2018 20:33:34 +0100
Message-ID: <CADVatmO4qd2D7j9AuVWX29ODMd9xV7-ndMSv+dfFatT60h+mzQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 29/45] cgroup/cpuset: remove circular dependency deadlock
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, prsood@codeaurora.org,
        Tejun Heo <tj@kernel.org>, amit.pundir@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Oct 11, 2018 at 4:54 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Prateek Sood <prsood@codeaurora.org>
>
> commit aa24163b2ee5c92120e32e99b5a93143a0f4258e upstream.

This has been already reverted in upstream.
bdfbbda90aeb ("Revert "cgroup/cpuset: remove circular dependency deadlock"")

Might be better to add e8b3f8db7aad ("workqueue/hotplug: simplify
workqueue_offline_cpu()") instead which is mentioned in the revert
commit.

-- 
Regards
Sudip
