Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B1EC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300AB216E6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ia/YK4bD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300AB216E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeHHSMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:12:12 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33051 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeHHSML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:12:11 -0400
Received: by mail-pl0-f68.google.com with SMTP id b90-v6so1226946plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jSjyTX8iBANBmotfzyKb0EnTyza540f7m4hbaCig8QA=;
        b=Ia/YK4bDrXaZYV+9agbJ6qHrEfulTCJJtEuYslr+wRKmIDB9nf7qNn5/lSECjXLa3s
         nmuJvDNdjXVzTTtMBiMVxkPega+0sI7q/kNks/pJBYHIpTEoEsZgoeaP2Q41716/924y
         lROjT8ItaZBYBPLAM7EN1As59XvxLZKEARXcEGk61qTKX+kqY7sXo52BrH7KN40S+/PR
         GcSLyqRK2zKNHb0++AsFLfYcJRXhKwZe+5cEyWTZ1MBAppd2fsOl3vtrv2V6kKuECATs
         5A8fYtSyCS95fSmFvjcusWt18i2oxvB4hYo6EcrbkCd+/nZbOSM5rXroW/SD1zcGea4Y
         6DFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jSjyTX8iBANBmotfzyKb0EnTyza540f7m4hbaCig8QA=;
        b=NVplQ8H5/K+weXPNWoXpecrzj4iVmm/pP3UzbGZjwnlPFq8J2jAYajfJ64E4jNs0OU
         0zI0M+N5hbgpdanIM3SaA1QJHVZOZl3sX0E/U/ahUB0C9Z1pC78HGkX/1qh4EYljPctu
         TDbpKLjQEn4XziXUoHzcQg8bj4gUzmXIMNMqEhaPtmlEZIyik/+SU4xYTsXQOM84uPtl
         YhmAGI7NxCJvoWZ6cUJgU9kASsOde+bkoP0Gd5eZKCIPbCqGLgPcDmI7ObaqC6tpZJai
         xGMnt9XaQV0A2IsHgGBb8Q77jMWGrMGsAyNySyY3kvQhHuihioJwmetZs/Y6/Zl9PG2f
         Jf8A==
X-Gm-Message-State: AOUpUlFkCIQ8C83hmiv0IwoeJGqgzaImXesrmUcxUPnt450204dEEE5b
        o8iMhj53xA37vpxCij0J2kypKy6usFKLUSk7EdM5wg==
X-Google-Smtp-Source: AA+uWPx3gZcX+uwHSPV/2lhhtaI0Gz0941kRbEsnm2FoaySb0OImwN5ixGlQ92mWoGpC5tE3KzEKg3vBFE0W4b6aX5U=
X-Received: by 2002:a17:902:740b:: with SMTP id g11-v6mr3122696pll.85.1533743514551;
 Wed, 08 Aug 2018 08:51:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 8 Aug 2018 08:51:34
 -0700 (PDT)
In-Reply-To: <20180726221527.GA9426@nautica>
References: <20180726081049.10527-1-tomasbortoli@gmail.com>
 <20180726081727.GA6699@nautica> <CACT4Y+ark+0EYSZaOX-qDKpOkyfLgSO9CkidZzx=xkUuhpr65A@mail.gmail.com>
 <20180726094849.GA18334@nautica> <abbeafa2-9008-5749-aee5-b4a115d71af7@gmail.com>
 <20180726142109.GA4235@nautica> <baa7368f-e149-ef3d-cf10-4fcd16dce0e6@gmail.com>
 <20180726221527.GA9426@nautica>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 8 Aug 2018 17:51:34 +0200
Message-ID: <CACT4Y+Z+Q__-cMaQ-85H38Rs5AeFGitXoE8-Bv4pNsvat+G+xQ@mail.gmail.com>
Subject: Re: [PATCH] 9p: fix NULL pointer dereferences
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>,
        David Miller <davem@davemloft.net>,
        v9fs-developer@lists.sourceforge.net,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 12:15 AM, Dominique Martinet
<asmadeus@codewreck.org> wrote:
> Tomas Bortoli wrote on Thu, Jul 26, 2018:
>> > If we want to preserve the current behaviour for trans=fd (and I don't
>> > see why not) we just have to patch all the transports that use the
>> > device, that is all .create functions but p9_fd_create()
>> >
>> > Basically exactly what you did, just for a few more functions - I
>> > apparently was a little bit too optimistic thinking we could share
>> > this check.
>>
>> Does v9fs_mount() knows the transport ahead? Because in that case it'd
>> be possible to check if addr!=NULL && trans!=fd then return error
>>
>> Otherwise, patching all the .create, ok.
>
> 9p option parsing is all over the place, split in fs/9p/v9fs,
> net/9p/client and net/9p/trans_*... Which is actually somewhat of a
> problem because that means we can't warn on unused option as each parser
> does not know the full subset of options used, so if someone makes a
> typo they're on their own to figure it out :/
>
>
> If you want to factor it in, v9fs_mount does not know which transport is
> used, but p9_client_create does know - although the functions/structs
> are all static so you need to check clnt->trans_mod->name with strcmp
> and I'm honestly not sure that's better than checking in each function..
>
> But, as usual I'm happy as long as it works, so pick your poison :)

So let's proceed with checking in each transport function?
