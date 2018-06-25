Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262C0C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB51525951
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BcRfNiNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB51525951
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755271AbeFYMkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:40:23 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36747 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753456AbeFYMkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:40:21 -0400
Received: by mail-pg0-f67.google.com with SMTP id m5-v6so6011676pgd.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 05:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I6I1Xdja27lprqUfXNY4jTSrTq1PzSBNCimJ6lQV66U=;
        b=BcRfNiNcUydP3RnAH9WzRe/Ipif6kY8Oa4zO7DEysNbXed669nQBnHNpsfmWO2160Y
         YPmz08eR/QErjqn1TnPeExeHNPCkkDTOGkvEnsS4rfCJOU34cQF7BKuxv8nqfnqNFsC4
         o+o8N6wBy/kcngaZgl9g4kiAQCMrAk2Cv8y7En7x6ApFySAENyYZX0e8ffCE7+fD5XA3
         won8Avasm0xGUUfxI+hexDPh02TuV5GzY8hdifT0wg7Xr598OT1g3NXMCYp45zASnSOI
         8E8JBrMRH+AQBwUG91e/1aIaEpNqO9XQ5wmWd8d+z9VBDkquOYqCWbKaLgFUD31gjpyo
         OCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I6I1Xdja27lprqUfXNY4jTSrTq1PzSBNCimJ6lQV66U=;
        b=LylmVx7wMgxoXLBRtitlrKzEDoEY5m6BQRbKs72CTgyYK5tTetWJPOGRXXwZunX9V0
         VleSCer32IjZ0vlLXOx+mvxDNtX6jMci0HGWNv0WehDTAZwiLPH6znylsMbUQDjRENK2
         gTid7NyJVShPJpmsWuJH3bruzdzSjrdOTuIfcEEUdZ49nH+3HhHMNDdLrGOwTfpoCv1E
         GoY6/TcZeqwkCuCSwrFVklHPzBYHFH88N0q8wiEDD+U0F77jSdByvFVZM0SgMAC2S1NN
         lInXjVVURvlSfPF8hS+OK615yStYgquC+f9Jafv9Lt3D9dgKdBwe98yjjHSxo+hT7kcJ
         ihkg==
X-Gm-Message-State: APt69E0vSL8SdYkFXhEcxiUniAaPyyhwoOlM6aMvOE0jB6fGFVpe5MDu
        r2meYHAD/EMhyy9O7aEX8srufgd3KYYPVPwlQZLz6A==
X-Google-Smtp-Source: ADUXVKIsoS1ORLR1JrU0JsP25cMxR+vSS9xFVNLcGB6Syfu08sti8pZYyaLIMWHHujj3IFl8xPSkOpT3c7xo2D1s+/4=
X-Received: by 2002:a65:490d:: with SMTP id p13-v6mr10229295pgs.84.1529930420968;
 Mon, 25 Jun 2018 05:40:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Mon, 25 Jun 2018 05:40:00
 -0700 (PDT)
In-Reply-To: <20180621081704.GA677@jagdpanzerIV>
References: <20180620125540.228766-1-dvyukov@gmail.com> <CAHp75VdR_gDBk7v9WDN1fHc=1q=j2mx3CkTz83SZZWm=pbnczA@mail.gmail.com>
 <CACT4Y+bjdmgdeRLM5kBaf6-vunFwFRD0_zCZX=A-rY+XEEfnEA@mail.gmail.com> <20180621081704.GA677@jagdpanzerIV>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 25 Jun 2018 14:40:00 +0200
Message-ID: <CACT4Y+ZZVOjec2dvRCU9p7MHkbYyjqk7FMr4Yu3ahVyL_g0YGQ@mail.gmail.com>
Subject: Re: [PATCH] arch/x86: get rid of KERN_CONT in show_fault_oops()
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dmitry Vyukov <dvyukov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 10:17 AM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> On (06/21/18 09:59), Dmitry Vyukov wrote:
>> >
>> >> +       printk(KERN_ALERT "BUG: unable to handle kernel %s at %px\n",
>> >> +               (address < PAGE_SIZE ? "NULL pointer dereference" :
>> >> +               "paging request"), (void *) address);
>> >
>> > Perhaps pr_alert() ?
>>
>> It's the same, right? Make sense.
>
> Right.
>
> In printk(KERN_<LEVEL> ...) people tend to forget KERN_<LEVEL> sometimes,
> so, I think, in general we want to see more pr_foo() and less printk().

Mailed v2 with pr_alert().

Since nobody else commented on single pr_alert() with ternary operator
vs if + 2 pr_alert()'s, I left it intact for now.
