Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C137C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C896020855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWljDkE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C896020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeKIMoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:44:06 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36764 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeKIMoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:44:06 -0500
Received: by mail-yw1-f66.google.com with SMTP id h21-v6so702903ywa.3;
        Thu, 08 Nov 2018 19:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+Vb5r/ZxUkEwwgXqaevKlCQD89ZvLor7zBW+Jl84ucM=;
        b=EWljDkE/VB5y+6CJK4ZAOojWZE+9pD+hiV7qA6gkst+I99mJfYHtDMvllq2FWk9jpN
         vg1BpQJvqUGa4A8nY+Nu8F0Garvrl/c1obc/LDDPvDChW+74/1RnCgx4spc8x9Ord0yk
         PvnAXGytVl8AlkBoaHNYVxdR7c0iMTkJEjteFbb3cAqROnkfcNGin7qHJPrY60D+f++L
         wCZvorzn2S1npJKLf0p88/y2zHaMX143wYWUBcdVJ2hkQF6ExcNOyPICTePWZaThu9Vx
         cYXn0fm61hojPh+7AO8KRHf4kUnqaGepoQZobbdU6LaCoTEcB/fRVMrPGIj3trwmSUsO
         /kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+Vb5r/ZxUkEwwgXqaevKlCQD89ZvLor7zBW+Jl84ucM=;
        b=mH6gGPDpP4wN9FjLT7I1fn1aa8YQifHwWz9JotdWrZPLuRX1RXTpXaMIysUoT8NX1L
         buq3INy9+PhVXRUFHLqp2taPXovmM0FyBkh3imQ4ri4Oql3tpH38197OvTLrCtc/hNBd
         iLVJu5buAyntQn6dqBulZFZCU4MdYshqjbu1AVejy24gNx1JERmx7fuWkShL5ifuT/n+
         tF9W6sdAISLLvoIHuKFgHXe/nUg5eQsPK+LyXgvsoG2hIz8u6Q7INxQfExeEBZEV1iCU
         t8t8b7JiQmYGjbWq0NbBqOAT6FTzWJLR1SIiHAF/V++1s5EKnTNhp3Ds+gw/XKvys3Bm
         2S7w==
X-Gm-Message-State: AGRZ1gK2LDRAKSjuGHqkxbMiYpKrRpq+gpWbhSUoi9za84xA2c6XHnKi
        SusCUBRcR6rL0qAW34basoTAHej36X5gQtWrFsA=
X-Google-Smtp-Source: AJdET5dMzUo9IzRWqGBOQzg7vYuhBcRXSYFTChSzu4f93BSNiAC9Dmh5Nk5G6dtnOk+XIGjLgANP96q4ra5SAqxjoI0=
X-Received: by 2002:a81:29c7:: with SMTP id p190-v6mr6951927ywp.176.1541732729931;
 Thu, 08 Nov 2018 19:05:29 -0800 (PST)
MIME-Version: 1.0
References: <20181106230117.127616-1-salyzyn@android.com> <20181106230117.127616-2-salyzyn@android.com>
 <20181108200106.GB3663@redhat.com> <b057da99-adc6-b355-fb57-b314a29f298f@android.com>
In-Reply-To: <b057da99-adc6-b355-fb57-b314a29f298f@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 9 Nov 2018 05:05:17 +0200
Message-ID: <CAOQ4uxjVPKSaJ2oscvM7jtsDVabnq_qMPg7k4KQEyOLAVPojcg@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] overlayfs: override_creds=off option bypass creator_cred
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 11:28 PM Mark Salyzyn <salyzyn@android.com> wrote:
>
> On 11/08/2018 12:01 PM, Vivek Goyal wrote:
>
> On Tue, Nov 06, 2018 at 03:01:15PM -0800, Mark Salyzyn wrote:
>
> By default, all access to the upper, lower and work directories is the
> recorded mounter's MAC and DAC credentials.  The incoming accesses are
> checked against the caller's credentials.
>
> Ok, I am trying to think of scenarios where override_creds=3Doff can
> provide any privilege escalation. How about following.
>
> $ mkdir lower lower/foo upper upper/foo work merged
> $ touch lower/foo/bar.txt
> $ chmod 700 lower/foo/
>
> # Mount overlay with override_creds=3Doff
>
> $ mount -t overlay -o
> lowerdir=3Dlower,upperdir=3Dupper,workdir=3Dwork,override_creds=3Doff non=
e merged
>
> # Try to read lower/foo as unpriviliged user. Say "test"
> # su test
> # ls merged/foo/
> ls: cannot access 'merged/foo/': Operation not permitted
>
> # Now first try to do same operation as root and retry as test user.
> $ exit
> $ ls merged/foo
> bar.txt
> $ su test
> $ ls merged/foo
> bar.txt
>
> lower/foo/ is not readable by user "test". So it fails in first try. Late=
r
> "root" accesses it and it populates cache in overlayfs. When test retries=
,
> it gets these entries from cache.
>
> With override_creds=3Don this is not a problem because overlay provides
> this as functionality as long as mounter as access to lower/foo/.
>
> But with override_creds=3Doff, mounter is not providing any such
> functionality and we are exposing an issue where cache will make
> something available which is not normally available.
>
> I think it probably is a good idea to do something about it?
>
> Thanks
> Vivek
>
> Good stuff.
>
> That sounds like a bug in cache (!) to not recheck caller's credentials. =
Currently unsure how/where to force bypass of the cache (performance hit) a=
s it is wired in throughout the code without a clear off switch, or recheck=
ing of the credentials at access. This does need to be addressed to make th=
is 'feature' more useful/trusted for non-MAC controlled, use cases.
>
> This is not a problem in the Android usage case since DAC is simple and a=
ll can be read, execute bits might be controlled, the owners and perms are =
otherwise unremarkable in the affected arenas that are utilizing overlayfs.=
 Not using it for a generic r/w backing except in rooted debug scenarios by=
 developers, otherwise everything is r/o, MAC on the other hand is complex =
and heavily inspected. We do, however, want multi level security in that bo=
th DAC and MAC can be trusted and can protect each other from holes.
>
> Sounds like the caveats in the documentation need to be expanded if _no_ =
solution for this kind of access pattern becomes apparent.
>

I think maybe you could append the "behavior of the overlay is undefined" c=
lause
to the caveats to cover issues like the one raised by Vivek.

Mark,

I have some Android internals background, so I have a general
understanding of the
use case, but I can understand why people have a hard time connecting to th=
e
motivation, thinking "their security model must be flawed".

I am not sure if you are avoiding laying out the details of the model
because you
are not allowed to expose details or because you feel details may confuse u=
s.
If the latter, then I think that actually listing the details of the
overlays used in Android
and some concrete examples of access policies to those overlays could
benefit the
discussion on the feature.
To clarify, this only a suggestion. I have no objection to the patch.

Thanks,
Amir.
