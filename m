Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298C4C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5732075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XV05vfkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5732075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936879AbeFRUqJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:46:09 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33659 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935090AbeFRUqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:46:07 -0400
Received: by mail-ua0-f196.google.com with SMTP id m21-v6so11622322uan.0;
        Mon, 18 Jun 2018 13:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zBzrN5F9zdlIxMCfVP9gkdlxv9F88e44I8rwK1fQJPE=;
        b=XV05vfkgGTcvSkCgIGjFphe6IqR1O/8E6t1u3PCaxb2nR7SRuj1CTWBPZXAvgFSRw3
         q2ICTlGIMFSnQeAjjWG1IKyxE+k1eZ/0gcAvJC3pcpunV9eII4zm1eraN62MCBv0TSL7
         rkj/jHWhZlzzgt2PxvJZMMa3E0mNjsjsxDVPSNh0ZoDVIYIitES2wkcdJ9G/MapfRawU
         PSssOWUWM3s4FAr0jY6zDATe24k2yDAL2vUFhayDkg+JV8Th/kCvC/ehhhBbxco9UeMy
         xvAJRg28goXuTu7/Njk91brcoZK75uZt7PYbPqby6dxwxQWriQTFPBggUSYO27MiJJrk
         HKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zBzrN5F9zdlIxMCfVP9gkdlxv9F88e44I8rwK1fQJPE=;
        b=UacHmfSsboQGJfsbNOyuyuNPzmgFiSLIr/QlVjwB6RIbpaDHACOuQQ1OLrrjpeSun1
         GMnmfm7fvqP/VubQKNyVxkwysLtHbdtutGfRHOeDlIx1rMH8rOaHBBbjfSr7wYzz6rcp
         k3LUjZVU+l5pCQz30fzA2egElIb/0cohlYLeaTyZVP2js44/qG0+G9A9zBkOXhDpxKYK
         PdAtpeZqfAKnZdCYUCN14fWJeKdMp0IADxCyLFQiCqBv5SGt2qdRKhLp0wngogUKXg83
         Q+aHLHOE6ShDydKyzsWsLvBYGw3voUKZcDrTaxa16p/4ZvZ+KOhaegiY8BtWAFsf4Bqn
         JZ9w==
X-Gm-Message-State: APt69E28cyr1wm3CTytCOEQlDvABaxV2cZ5NQZOc1CUjE4aEfpuKfrkv
        2v1sN/i582LRf8M8KVNGB+ioGjFSnS53YcFGjlaIHg==
X-Google-Smtp-Source: ADUXVKIqsO6X17eGmqfYbOCPs5Bzr0nEjXACabUC4HYVKLelICn6D+krqd6m9rrkqLPptRdZk3fGwTK6AcpyopH76bU=
X-Received: by 2002:a9f:3613:: with SMTP id r19-v6mr9173895uad.49.1529354767171;
 Mon, 18 Jun 2018 13:46:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 13:46:06
 -0700 (PDT)
In-Reply-To: <1529354549.3092.36.camel@sipsolutions.net>
References: <20180618195618.17536-1-johannes@sipsolutions.net>
 <CAHp75VdY+PF0Edm_py+UiD3nz77HTQps_8uaRh+Sa3C+UKECKA@mail.gmail.com>
 <1529353683.3092.32.camel@sipsolutions.net> <CAHp75VesXgrh-XR-3bFMOF6eE0K=NyRvyY1tw1yOX44rJS9fag@mail.gmail.com>
 <1529354549.3092.36.camel@sipsolutions.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jun 2018 23:46:06 +0300
Message-ID: <CAHp75Vd5RHc+CzxR+V5ixgKy5BpmD6Tx3bYG-hsYpAHJdYDgbw@mail.gmail.com>
Subject: Re: [PATCH v3] bitfield: fix *_encode_bits()
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:42 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Mon, 2018-06-18 at 23:40 +0300, Andy Shevchenko wrote:
>
>> The idea is to print what was the input, expected output and actual result.
>> Then you would see what exactly is broken.
>
> Yeah, I guess we could. I did some of that work.
>
>> I dunno how much we may take away from this certain test case, though
>> it would be better for my opinion.
>
> TBH though, I'm not sure I want to do this (right now at least). I don't
> think we gain anything from it, it's so basic ... so to me it's just
> pointless extra code.

I'm not insisting I'm trying to specify rationale behind it.
We may add this later at some point.

-- 
With Best Regards,
Andy Shevchenko
