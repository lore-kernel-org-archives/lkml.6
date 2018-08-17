Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCCBC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0CC21869
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5heN+Sv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0CC21869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeHQKQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 06:16:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44263 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeHQKQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 06:16:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so5592368ljq.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 00:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=we/4ch4Vb4KoSKiSXnxc0F/6PssePDdAk0zzVPDpt3w=;
        b=B5heN+SvT3Z/jG8pgvVoqjdPVDMC/+WDxpGVdxNK84m8/Hq2+VT2eAqMV9MPw/oarH
         7SLoimkN+uxfFkGJmIzTMnaOXjQcfiTgSrU0fXXJ94TkCwSukMptDRQJ073ic2ggtnpe
         6tpArPxdhwyIj1ZmJzpjgh+xktDuL0CS6PvCIesWxYlrcPkLsYNPRFdNX7vnYKGioqJC
         eIZG4SJnPAGv8wwiRVRBdHPLnBbK/MoRHI69pgKNo8/1pqW/3gxcunamZkETePOosNX0
         tNoeIAYWszHKUJbpnzL0Cj4BUalND0YX7RZ1ZsrCrnMM6hvJ8ekZNmFfqClhM4+U2Tg2
         ozVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=we/4ch4Vb4KoSKiSXnxc0F/6PssePDdAk0zzVPDpt3w=;
        b=FiGVUj16h10gBVEvmmTVi90ZjbUqMKBhvVViwfMkwvOIbeGraqiAmowh1Mtv/o6AJr
         s2sx27MRJg9plk8ltkZvSbe2OMsITegjrbbBKOUM/rbbwCF2/rQpQHj0UloFyDEpJKT0
         WE3utHed4Z2tXP/mylFVVmm36vQg51GT12xH4uvCuWmS7ICWPoUpb6yatBw5Y1SH33a+
         164eDYjh636qKbuECDqj3BWvolXWB9HULBT1FHMabeHi8uhlJzwY9Piu24YQ52Nrwt+M
         r987g9V7ZCf7kcmJU2zNjX1p2On8egWk/AN+XmOenc8PnJ/A6GoHsXIfGpkelli5gzv4
         BQUQ==
X-Gm-Message-State: AOUpUlH/5/rZa7jPn30bKkJvDFF+fOnlznCdLV2E1O8ueJoC0TYzZDN9
        eqkVNIdkYqFgVq4d0jv8FEk4AZI8ezptfWbicazoZHWL2V8=
X-Google-Smtp-Source: AA+uWPzjx9jUUi1p35Ua4yim/upKKoQOuc8lpxMfY7q3Xwitj+zPddu3DHIuo3wWmr9TpwoVPKxPYVrZEbotNpLBw+I=
X-Received: by 2002:a2e:944:: with SMTP id 65-v6mr9545950ljj.30.1534490041989;
 Fri, 17 Aug 2018 00:14:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:5051:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 00:14:01
 -0700 (PDT)
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <CA+55aFwPw5bHRFReMCs9dtHjJDcgFMLgK8P1QNsV4NRgPYFkew@mail.gmail.com>
References: <CA+icZUW9Cg0G41ZSwjUBaJ+F9qCc23GGMp8aCgfNQejstKJmmQ@mail.gmail.com>
 <CA+55aFwPw5bHRFReMCs9dtHjJDcgFMLgK8P1QNsV4NRgPYFkew@mail.gmail.com>
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 17 Aug 2018 09:14:01 +0200
Message-ID: <CA+icZUUTvEriXQgC720Nxc5yXmO5LatFKn-Vq8pxU79PMTYwmw@mail.gmail.com>
Subject: Re: Merge branch 'l1tf-final' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 7:14 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Aug 16, 2018 at 12:37 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>
>> I am here on Linux v4.18 and tried first to merge the l1tf-final Git-branch.
>> Unfortunately, this is no more available in the tip Git-tree.
>
> Right. That branch - for obvious reasons - was never really available
> on a public site. I had it as a bundle over secure email, and just
> faked it all.
>
>> How can I get the history and subjects of all commits in your tree to
>> cherry-pick the single commits?
>
> Just do "git fetch" of my upstream.  Not merging it (so no pull), just
> fetching everything I have.
>
> You don't want just the l1tf branch anyway, since there's three or
> four subsequent fixes there too..
>
>                  Linus

Thanks Linus.

I looked at the patchset of Linux 4.18.2-rc1 [1].
Some of those patches are not in your tree.

- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=linux-4.18.y
