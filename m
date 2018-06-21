Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D62C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCB6208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjgXt+hs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCB6208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933344AbeFUMIm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:08:42 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33688 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932862AbeFUMIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:08:41 -0400
Received: by mail-ot0-f195.google.com with SMTP id h6-v6so3296831otj.0;
        Thu, 21 Jun 2018 05:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5KyQsGcoiybSnh99wWmMSLoH4N8vclmQSLrVsgJNx/Y=;
        b=JjgXt+hsbj++BqM83P3/l3ud+T+83a+C4/sOwEMymieF/CAChC/WMdcQt6lld9a1KZ
         gMwj2ZfX4RqcQhmw9J///sFXeuaYhMooD63T2QtaQ0tDRyzEiqh/hzEMJuBT0dEnbiKw
         dOee/tlFaBx/jtBjQMRQr98ZTRqaP6H8E9YKieeMJDmITcd+7nmVxmKiST/gg0V/iJch
         rRzCRnLjPhsQvg1aEeyOZCYBLjUS6IOxhP6eDD1N7lbkfRksvt1USndIedVeqSpdmL8U
         1uwsd+qCWZz7jAOSTg7ywjhvI/Jp6HEbvHdFHL4CPeWr3k8gzM417EzMjLVjuepbD3KY
         BryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5KyQsGcoiybSnh99wWmMSLoH4N8vclmQSLrVsgJNx/Y=;
        b=Dv+DpjlfDAIIs8RFLFcVNghZMzHTGWLP2f8NjnIIIS4Z8jIS9vjkn/Ci6/fF+sj2WD
         TNbgXr04KIk2W/A37bdcmlyaLFtnWOaObAA5WLGghiCDNckBfCLPa1hPqB1h78vkyDmH
         TKk4XGY07xgSNElOSWQdxZ3xb4E5VRVQQiFQWB5MjR6vJGQrvSm4LijX9sfYTMNrzrS5
         Pj+8o23wSkng9+Zg7kIj6R6Nqy9vypNAD9WO95GhRRA6PU8hYJ/gylnGtVgGpG0AML4m
         fCK27T0Tmcbjqyq52AtdSjQDy5cTkDR7PNedeSsRJuSxin4FVZvfg/OwxoSi3fb/86cf
         qy1Q==
X-Gm-Message-State: APt69E01qzjJjeiFdAMZTNZM+Nd/2cYjNizTEfHg9MX13tMbsjxjL52j
        5iYPEXnH8eeVie05LochKSJjWegLfS3Kal9cw6U=
X-Google-Smtp-Source: ADUXVKIks3NNfBGKEylUzitqK74y4315ZMuU8amP6cpqdZY7IJJOKx1hBjffoPUNFo4WVRuoA8AlQ80pPH2TUVt5FrM=
X-Received: by 2002:a9d:3e4c:: with SMTP id h12-v6mr14711509otg.150.1529582920534;
 Thu, 21 Jun 2018 05:08:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 05:08:40
 -0700 (PDT)
In-Reply-To: <20180621085332.GA21807@amd>
References: <cover.1529486870.git.yu.c.chen@intel.com> <20180621085332.GA21807@amd>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Jun 2018 14:08:40 +0200
X-Google-Sender-Auth: B8vO3kAuesdq0Bu9M6NRjKApMLc
Message-ID: <CAJZ5v0izS8CNzhsd_bjB40xTkZxaxh13NtHsJi9LYXEr84MoMA@mail.gmail.com>
Subject: Re: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 10:53 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> As security becomes more and more important, we add the in-kernel
>> encryption support for hibernation.
> ...
>> There was a discussion on the mailing list on whether this key should
>> be derived in kernel or in user space. And it turns out to be generating
>> the key by user space is more acceptable[1]. So this patch set is divided
>> into two parts:
>> 1. The hibernation snapshot encryption in kernel space,
>> 2. the key derivation implementation in user space.
>
> uswsusp was created so that this kind of stuff could be kept in
> userspace. You get graphical progress bar (etc) too. As you already
> have userspace component for key derivation, I see no advantages to
> uswsusp.
>
> If you have some, please explain.

Not having to transfer plain text kernel memory to user space is one IMO.

Besides, the user space part of what you are calling uswsusp has not
been actively maintained for years now and honestly I don't know how
many users of it there are.
