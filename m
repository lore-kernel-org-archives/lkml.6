Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC16C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C217220844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEs/yOoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C217220844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389055AbeHAOEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:04:30 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36215 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387673AbeHAOEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:04:30 -0400
Received: by mail-vk0-f65.google.com with SMTP id y9-v6so9162255vky.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 05:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oeVuGa4BGDxve00crzyYJPA2nKVzWBX8b6Pc0xGrofo=;
        b=MEs/yOoh7VyN2WsWKI/QoUJ95Fx1poMV9njd7jJh7Uk9lXdlm2P+01dNO5malXIwYu
         KMTxM2kcBB7wNSQf9jBXPhTzPc2vYu0ACrtxseBFlrpvpKtmVoCuVZRa218IyblxP60v
         yoNVcd6718jM0nBPCPIhwhO1vjZ/GFpe96ad4Ghhnev85xoWL2NNSX5xEQCW4dxTlKDw
         aXZcJRRvZ3k0AxwcCSUWEqFYQauag/F7FknruC29EbfXnHhzmYliuJWREE8HK/BDkrxa
         TYgov3ImlBZFfTkP9PZrFK5Jlk5mkw3SgEZrjIhhrw2y61/QHAH3GPVZAIxQT3esWpLk
         7gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oeVuGa4BGDxve00crzyYJPA2nKVzWBX8b6Pc0xGrofo=;
        b=QmqBqBTSSxDXmBmyci4Zf2hzkjxmsI9dNMnvEyoOz06nzrWm0vMY4ev6yUEgFthl/M
         yh5VTWN4FY/2GC+T0OWgKjH3w4sA3IUZIK0R2RNX2w4v2emKfGR/7Z3J/pUZkxtUVfME
         nOhBNcnvxOI3lSN4W7neP8uavJzBkOt7mDKDE/fqm8BJR/sRhZ77UQSQ3TpTNKCiyWTG
         WkBoxEydv2pWiceEY2zvbgS3qvfGO6kCGBZWQ7IXJPU5tv5g5MXUHF7+DbKRBsOXQs9o
         iUCFIEvlTV/fKYBXrPvNvzHQy7vQXAWfNwmsGPvwgiJRCgxjJVQ4oOPmXdY46t8B5wvJ
         qoKA==
X-Gm-Message-State: AOUpUlERLB+PLRHkuW3G5gC1lqwQ99KHmk5w3ccWembs6bOBo2/r3fRW
        bD9a6Y3y0KQxdutcRuoCrSOgp7NXGZsYUwdStM0=
X-Google-Smtp-Source: AAOMgpcWHAQBAkPtt5Rlcyf3mp5hbFpgN0zARZPvtnRQw5NNGqlGiEvhVjjPdenD7w31yETmDXccSRatAc+PuH4L8ag=
X-Received: by 2002:a1f:b503:: with SMTP id e3-v6mr16690469vkf.97.1533125938622;
 Wed, 01 Aug 2018 05:18:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 05:18:58 -0700 (PDT)
In-Reply-To: <20180801115557.7086-1-vasilyev@ispras.ru>
References: <CAHp75VfktnjL+G0vjHNHr=8mbDXu+4BDogsnxrp_2Bo4em=r2Q@mail.gmail.com>
 <20180801115557.7086-1-vasilyev@ispras.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Aug 2018 15:18:58 +0300
Message-ID: <CAHp75VeSr-dDC+BvvTi1f2JBDL0UB31O=umatKE4y=0HQ4_8UQ@mail.gmail.com>
Subject: Re: [PATCH v5] staging: rts5208: add error handling into rtsx_probe
To:     Anton Vasilyev <vasilyev@ispras.ru>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Gaurav Pathak <gauravpathak129@gmail.com>,
        Hannes Reinecke <hare@suse.de>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 2:55 PM, Anton Vasilyev <vasilyev@ispras.ru> wrote:
> If rtsx_probe() fails to allocate dev->chip, then release_everything()
> will crash on uninitialized dev->cmnd_ready complete.
>
> Patch adds an error handling into rtsx_probe.
> Found by Linux Driver Verification project (linuxtesting.org).

Have you based your change on staging-next?

Seems not. You need to rebase and resend.

-- 
With Best Regards,
Andy Shevchenko
