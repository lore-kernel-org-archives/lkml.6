Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC7FC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0D221566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f5U6MzSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0D221566
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbeHBWYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:24:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34172 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbeHBWYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:24:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so1971559pfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 13:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=07xsWrrDpYKD0OL79G8eDAc5Kuf5oduiGSpDO/vxjlE=;
        b=f5U6MzSg+ym51oDOF3Y/n3P2iaBznczjp2ZFhBrh7pYQFIpfxyA061TQ0GzZ1d2hNh
         wcHMhO9DIfOIZa3i+phpNlz4io8L9N5wrCjaMEcRQqWHKWRyxZnmteJCSYx7l9z2HAYZ
         pSChhlhQN7d4J678WVRkYIn69j8A+pRHhb6uzuzmyEPNxaQ6fsqi5yc9KKOKINYQU+KV
         d0wozRKFeTRjKhMJY8BxM6sM9C2TItXQQ2rbnkM1UZlG45025J8vJwPHVwCR4gRB5jlM
         eU8WQpm2ikVHqG7b+AwQJW1DPnP3B/IOKKPiWmi1Tu+3A183F91e1jm55Y9dWLbGkzcs
         PPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=07xsWrrDpYKD0OL79G8eDAc5Kuf5oduiGSpDO/vxjlE=;
        b=bHcxY5UPrRS1cwtzoVcUusUp/w2VDvVFnkvsOfi5DmqadJOvNc21SILi9BKmJBK/hD
         KETeTgoiCxEUux3pk70isBZnrRMePupk5wc+gpgI9j7uImk0Dm3CtDd1J7+jwYMOxEI0
         E3lbu96duPnY26U5bNqsC2bM701aCYpCZmnRn7JGnQcUjFHHDCm0pmfTL3k0HBsMOIjH
         oUUvc5+ED6Po74VLSmvMmOWJMQOupfjPW/VHbpp2aHXm0pv6/4c8E5oye6bFQ6vJdupL
         oGRSW9KZCf8UZ7VaWdpLxZhExsuyfbRYEqLTUUKWDTZhzp4WT7J11A+j4Wn+1Cs+ugzK
         ZbIA==
X-Gm-Message-State: AOUpUlEJO7/L3zG8+t65m9+iaNkedbtNpUmwmAdmUUyqOkG66mv64WdA
        OGWLYsvKF2o33PKKTIA70t8tsFsw2X72gYC2NmmJFA==
X-Google-Smtp-Source: AAOMgpeqJnkwVkqTYjnAU3l7N0f7OX+OMmELjMGSE/6aFO9keW5FQtpXwWPxsmmGQrujijMtQEPedV2nQ5HqhiNUoNE=
X-Received: by 2002:a62:106:: with SMTP id 6-v6mr1082304pfb.168.1533241891036;
 Thu, 02 Aug 2018 13:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180801182258.17834-1-ndesaulniers@google.com>
 <78c667f9-5c8b-3835-83eb-4b59e27e4f7e@bell.net> <CAKwvOdmdrA+UvAWyqe8sNJt5nxHXHsSwf5Yxih9HYgVL+kovxQ@mail.gmail.com>
 <fe7b57d8-b586-a390-31d2-2274f69db3c0@bell.net> <CAKwvOd=CLBFZRQ4HQb_+VCydDEvsbC2w2gD4hTwvp_jm1zqN9Q@mail.gmail.com>
 <54b2139b-53d2-01c5-f240-93a692cdbc59@bell.net> <CAKwvOdktvrZL8T_5K2VtQtgt_mscS7kzVXYVy0O7CSuGX53Y5A@mail.gmail.com>
 <536ef1b1-cfa2-f66d-4261-fb8405964632@bell.net>
In-Reply-To: <536ef1b1-cfa2-f66d-4261-fb8405964632@bell.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 2 Aug 2018 13:31:19 -0700
Message-ID: <CAKwvOdmwj76aESZNKhzfPmhfzGKvrfDut7oD5KAwA+VR-JukSg@mail.gmail.com>
Subject: Re: [PATCH] parisc: prefer _THIS_IP_ and _RET_IP_ statement expressions
To:     dave.anglin@bell.net
Cc:     deller@gmx.de, jejb@parisc-linux.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 5:49 PM John David Anglin <dave.anglin@bell.net> wrote:
>
> On 2018-08-01 6:18 PM, Nick Desaulniers wrote:
> >> What about the uses in the fs support, etc?
> > Sorry, I don't see it?
> I mean _THIS_IP_.

I don't understand, I'm referring to current_text_addr().  Maybe this
explains more what I'm trying to do:
https://lkml.org/lkml/2018/8/1/1689

If I understand your point correctly, is it that you're saying that
_THIS_IP_ should be implemented in terms of inline assembly (as in
what current_text_addr() is currently)?  If that's what you mean and
I'm understanding correctly, my point is that we should be preferring
the generic C implementation as that's what's being used in most
places currently, so if it was broken you'd likely already know about
it.  Unless unwinding is truly broken by the additional label, I don't
think we need an inline assembly implementation of current_text_addr()
for parisc (or any arch for that matter).  If we do, then it can be
localized to the parisc unwinding code, that way it can be
consolidated everywhere else for every other arch.

-- 
Thanks,
~Nick Desaulniers
