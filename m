Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B786FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87997214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyL6yuHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfAISmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:42:00 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42646 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfAISmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:42:00 -0500
Received: by mail-qt1-f194.google.com with SMTP id d19so9438945qtq.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 10:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PstFsCPAqqedesTo9GwtxuZDMF8mvt7Hi5C97RWLB7I=;
        b=VyL6yuHo75f723uDeMAPPeY+L+3gBnSfdHRet7nOy8B6lK5Hz5DZqAWUlRM0Rm7zDc
         Pe18WCDi5UAibQPbxO1n2DFeoqeQ7Duud/Mjn9EkXi00RBhXhFW3QMaT5GwKUwZlCVh6
         3o49JmYfwDpAd1IJharANfRfs+ygbWcXEvdu1Qa0NKp8VeVrAzPs3EgEqUBpBwMsj4bK
         3EM03M/ljkBGqaMQf0mBadZeWSfbuNxjYTd5Obn+zfXaAKPS/TeAsxZmYA7gfDTh7/JC
         m33izpLp688w5MvT9wHb7xzpQr0lYKNM9ogLs9v27z5O/fjG65W857hyWscjrbsyu/Gq
         aDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PstFsCPAqqedesTo9GwtxuZDMF8mvt7Hi5C97RWLB7I=;
        b=rga524T42u5RhWrk5s5I14DqWhZ/k/ZhPeEHOwD4yAIVKpm1crWgN9JJqc/MrB1mlZ
         xG1FPt+hpcZ5TYopHv/ESChv8ewEyhKxtQ487d+prtDgIosYJQTmE6cYb61ZfHt01QPh
         iv19CxdnR5KoC4ChaPgMhYqqZGxT2LFUkiaEzGrlo7oCt3961xjC83OVAdmyhgPl8FaG
         DP2C7zOe+KhN4iuZn3AjZbfvh/NswqhdCpTsLWv1Nl8+NLawQc1fsaYTnAEikjMrejN4
         xf914pp/h3LiVecQ7vPAHUmGZh89JGmBTd7k9R3EhrUTU8xBwIeTxt0PphMi0ONDnnpH
         sc2A==
X-Gm-Message-State: AJcUukej91esZfWMLoAUXBbBE8UUnwCWmCSJ8uNfbCVU/CwVYfjywrpZ
        wpb8g9wth/iZlNQNIdbfJ97ElHPgQviE4Tzy3Zs=
X-Google-Smtp-Source: ALg8bN5Xgs7V0Koq//qikDP6Vnkx67OQeyQZBFJSHr8tYz2aF1woQy8qQmU/eMQW2I88ciq0dJp7HJ2NeIeKzzDN27w=
X-Received: by 2002:ac8:6151:: with SMTP id d17mr6693295qtm.194.1547059319276;
 Wed, 09 Jan 2019 10:41:59 -0800 (PST)
MIME-Version: 1.0
References: <20181220134046.7916-1-vkuznets@redhat.com> <20181220161722.GD31403@zn.tnic>
 <51dcb13a-4751-47f5-1e01-f6731a2c6f3c@intel.com> <20521afe-09af-7acf-6f32-3f6e9a971091@intel.com>
 <20190109113915.GB15665@zn.tnic> <87bm4qoww4.fsf@vitty.brq.redhat.com> <20190109121445.GC15665@zn.tnic>
In-Reply-To: <20190109121445.GC15665@zn.tnic>
From:   Tony Luck <tony.luck@gmail.com>
Date:   Wed, 9 Jan 2019 10:41:47 -0800
Message-ID: <CA+8MBbLh2JyWg=AF-cftrCfDB8QgRwJ2sKV-S24Jqtu_y1qZrg@mail.gmail.com>
Subject: Re: [PATCH] x86/intel_rdt: use rdmsr_safe() to workaround AWS host issue
To:     Borislav Petkov <bp@alien8.de>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <Babu.Moger@amd.com>, X86-ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Jan_H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        David Duncan <davdunc@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 5:00 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Jan 09, 2019 at 01:09:31PM +0100, Vitaly Kuznetsov wrote:
> > Hm, why is that? In theory, hypervisors can pass through or emulate the
> > required MSRs...
>
> ...and when the theory becomes reality we'll remove the check.

In practice that may be a long time coming. We don't have many CLOSIDs, or
bits in a cache mask, at the h/w level. If you start trying to
subdivide those resources
to pass a subset to a guest, then you'll quickly find that you have no
flexibility in the
guest to do anything useful.  It would only work if you limited to
two, or perhaps three
guests.

-Tony
