Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DDFC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BAC2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWi2EduC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BAC2150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbeIZX2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:28:22 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46975 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbeIZX2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:28:22 -0400
Received: by mail-qk1-f196.google.com with SMTP id q12-v6so7810752qkl.13;
        Wed, 26 Sep 2018 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uOWTyn7tPTIAXPN4GbtXZ7gDVDvcNqwVWcy2zhQT+UM=;
        b=NWi2EduC3xTT3ThVNpwyHEvEw2aUeSD5afw4ld990iLe4fJmgs7X4aIGrcMKbqeSlY
         EnjALV8oQGEbD4GA0Lzw6AiCxUFrAHuT+ys9EIElJqnFzFp/U0/3tSSDB4ZZveSeaWwx
         8aTwbn6UUk6Yetn2lvsW6jV5xAq8Vcu9hrzfvEaCfg5Ul7VGRbQWUoVG2PiNuvCRWtzV
         ozevNjSIJLl8T/QkV0ZAFyDpqX7OqhKRz52pWPV1Xzf2KqsyEciyKKu2s0sxe+MYusTF
         fqJUNL8W24nWAxko25meS9nozMOdJgB1JQAYxdtYrSWoD4CxSHSHnloqsuZWD/L+bO0T
         7l2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOWTyn7tPTIAXPN4GbtXZ7gDVDvcNqwVWcy2zhQT+UM=;
        b=mfANITEiNDQ6YlbClnAYQ9j4DsPf9/C4cJOH3iwtnkUf6xXELozH+K33OcSllgegJX
         zvB90tv6t+TMt9sFy9SXsDCwlLiwrNHKx49+JFzF/dIcmgBEiN+6unHWoWyX6x/mCKkS
         6Tr2G+AWLTd7bzct1bPYyafwBBY+WEZ8EYvrxMan+6ezU/6PzflCSSEpgzleZfOHZllc
         slEdb+KgJd5yIsDYYg3zdhh2Zqabd3fQVTW0YoQ0SFjYjOlB31SWhYb/8wLwr6z/ElTX
         2AhkoHpqBfPuDvXCtLauea0qs6/j0VMWVmKaVhcS9xNw0fp0W1L882jXJnv3wlnW+7Jl
         JWvA==
X-Gm-Message-State: ABuFfogSuNzXYOWDK0VSlJ536WxSAZ0NqNCkA/cSNt/j4WJXoUaQ+IMi
        XQ1FB1RwtkMh+9CHoZOQ+P8tOjYqzSZYgPh49ds=
X-Google-Smtp-Source: ACcGV63X5YfogPbSHD6+jkEcH2AEOY7LAf3EhPfDp8bWbIN1iAuVlgAN6i2pkzhG7MPp2/jJJREC61osJA5PnwDg8Po=
X-Received: by 2002:a37:4712:: with SMTP id u18-v6mr4985320qka.301.1537982066261;
 Wed, 26 Sep 2018 10:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180903180415.31575-1-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75Vesn4TrdF8tWLkU7nCRGp_o8fEK6gxpTkwM7E7zQo0qKg@mail.gmail.com> <04398317-a3b8-9387-e532-fcf26da9220e@linux.intel.com>
In-Reply-To: <04398317-a3b8-9387-e532-fcf26da9220e@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 20:14:15 +0300
Message-ID: <CAHp75Veeh3udVrWvdhAgPygcdWvBY6-=MBMy87=AUh4N-8ZRbQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] platform/x86: intel_pmc_core: Show Latency Tolerance info
To:     rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 5:15 PM Bhardwaj, Rajneesh
<rajneesh.bhardwaj@linux.intel.com> wrote:
> On 26-Sep-18 7:18 PM, Andy Shevchenko wrote:
> > On Mon, Sep 3, 2018 at 9:06 PM Rajneesh Bhardwaj
> > <rajneesh.bhardwaj@linux.intel.com> wrote:

> >> +       {"IP 16 : LTR_SCC",                     SPT_PMC_LTR_SCC},
> >> +       {"IP 17 : LTR_ISH",                     SPT_PMC_LTR_ISH},

> > Before no map has this fancy "IP xx :" prefixes. Please, remove.

>   The users of the driver often ask for IP Numbers while performing
> LTR_IGNORE operation so this is deliberately added. Please consider it.

You may enumerate during printing.

-- 
With Best Regards,
Andy Shevchenko
