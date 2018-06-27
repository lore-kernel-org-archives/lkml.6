Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C90FC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFDA255C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="c1BKz7AP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XPY0YVPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DFDA255C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755075AbeF0VxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 17:53:12 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33212 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752434AbeF0VxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 17:53:10 -0400
Received: by mail-yw0-f193.google.com with SMTP id u124-v6so1251570ywg.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6N87UKwkonvMAYI5Y2xpjfhUtlRTKGbyu8tbYZvuAgg=;
        b=c1BKz7AP0vLbIJZF0DFSdAcoHH1o2Otk7ftNt5+rdDoicoRxTNbzdj05iu7/qikJOk
         0PxfVkX4kZPxg+mXeklKzHZ/N/HHklWpQNG/nWWsuOldjx9WzDg8cUsT0z8UKy+b39Wc
         816DPFBI60mP1Mhub0jyDPu+QWn+7c+0h6VaRhZRTHa5nvIABjt4iZ6t6HgoM2cRLC2c
         cYfdB136zLCx6sS1yMIIeU4ZzRMhIwWUNS0mBCpQCdnmRTG+5hY2Elk2gVh9gmsFCEAl
         xlNJ0Asx/AF7r4DER8I6agoFhwSwwBKYf9MabytIwagqCCHZOcLq7Bx9/yrK0pc1V6Tg
         szDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6N87UKwkonvMAYI5Y2xpjfhUtlRTKGbyu8tbYZvuAgg=;
        b=XPY0YVPjxEeiPvht6QUB+EGScRL8rL+e+a7jIYkx9Yknitm7GC9e6sDB3poI0lsW83
         wS4CDVWOtBaOhUfm2N6CwtLGPemJDtVvbccB6YQecF/mT7RQ3rCkJosrkesU7a/stUzK
         6k+VrCsopDF+RWMCu/UvHf5VOlnimL9UgKIYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6N87UKwkonvMAYI5Y2xpjfhUtlRTKGbyu8tbYZvuAgg=;
        b=neTIFJCxzrJaFN+yZmBh+t49FMdwcAHA4tnIofx8quUt5bE17nbLsu5zbp/rNqY9LA
         Qs+oyTnsVaN11yMd/vwQB3FFKlOEQP9dVNinYNBjcZRDgcQA55q7UffmOScQzYDRR8iP
         nW3qEoF9x62ll/EltWNIMVPAfFWcIa7VPloFN8MH6j2b97vZenAnEFBpVBVXCu6ITz4g
         glo2FnItp4YzlIGlC7XALPtXe/mUrxEbmLY2CD+KFDyBWYoPJFFLNmKpMsRHfppqMZPV
         PJf7klWr+fj1ENV+iowwX/IDUCDWAL26/HFIiT474Up7504GHcrjgTE/fyjm0iwPjTXs
         6Sfw==
X-Gm-Message-State: APt69E3IuCZMD6xsnAGniiWzNmnidldEgtMNAdNWbhFhE2Z/nnlNXi7o
        VpJrQXQ7uq3WdHEnUc3WQzwk4XOkl59XMixCq2EwzG2J
X-Google-Smtp-Source: AAOMgpdwzHFtERQ+1pQ1sXl690IFIfZwWxC2TdMD4W7hRNFaIHZaaNxCz6bsokVsanEd+W7VkFz6Sy9BuHJAstslj+8=
X-Received: by 2002:a0d:d105:: with SMTP id t5-v6mr3882599ywd.53.1530136389872;
 Wed, 27 Jun 2018 14:53:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 14:53:09
 -0700 (PDT)
In-Reply-To: <20180627215227.GA13549@redhat.com>
References: <20180618175033.GA2627@beast> <CAGXu5j+Su3fObnuzntQ7Tp8W6jfMt1hc=h-3Xhidgx--Nau1Ew@mail.gmail.com>
 <20180627215227.GA13549@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 27 Jun 2018 14:53:09 -0700
X-Google-Sender-Auth: h983SKwBvT44wTFfgU0zAf-jK64
Message-ID: <CAGXu5jL896qy0OmztQ0Re9Z4-a7ry4jL1RMkgGncs1K85eW-Kw@mail.gmail.com>
Subject: Re: dm: writecache: Use 2-factor allocator arguments
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, dm-devel@redhat.com,
        Dan Williams <dan.j.williams@intel.com>,
        Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 2:52 PM, Mike Snitzer <snitzer@redhat.com> wrote:
> On Wed, Jun 27 2018 at  5:48pm -0400,
> Kees Cook <keescook@chromium.org> wrote:
>
>> On Mon, Jun 18, 2018 at 10:50 AM, Kees Cook <keescook@chromium.org> wrote:
>> > This adjusts the allocator calls to use the 2-factor argument style, as
>> > already done treewide for better defense against allocator overflows.
>> > Additionally adjusts style nit to avoid assignments in test expressions.
>> >
>> > Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> Friendly ping -- I'd like to make sure this makes it into 4.18. All
>> other 2-factor allocations have been fixed in the kernel.
>
> Yeap, I'll be sending it to Linus this week.  Already staged and ready
> to go, please see:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-4.18&id=50a7d3ba7c9ac5e0b7e03fc7f420180989361dbf

Ah! Thank you very much! :)

-Kees

-- 
Kees Cook
Pixel Security
