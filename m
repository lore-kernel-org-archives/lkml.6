Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A27C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D81821872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=microgate-com.20150623.gappssmtp.com header.i=@microgate-com.20150623.gappssmtp.com header.b="z8/jTKN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfADN5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 08:57:41 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33672 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfADN5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 08:57:40 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so17568478pgu.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 05:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=microgate-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6GatY1qq8uBZxaDgnriLSD2x+9I6S2u1c27WomB6MA4=;
        b=z8/jTKN08wleF34QuwSxj9MSML6pWwmatGFzhpqwVA2tVRB7Xqq2amh4jDJKa6Oz2s
         t7fojPD50Lzcdj9SoEUsQsXIl/FWFfDon9xF0fNnYXzVlvZioLzRB4p9eotH5mQ5AdL6
         UDZoeICyKW8NpyIHb5NFafjNyVh5yChUsyx0TepZ5PWQ2spCma6dfAOC5lYJdRfZnovE
         QkweX3Ru0cWtI0yuDGEriff9scev+sRhrrK9AnyDSj2v97miXtzsic8DnBAKEerjUlng
         LzhlmDScz6S9BkFxACTdGO5aBgegOJ4FMjMO4BMOw65HpvyVmb+YnnVeQ2WC7QJ32Ga/
         hzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6GatY1qq8uBZxaDgnriLSD2x+9I6S2u1c27WomB6MA4=;
        b=RTmw2q7eue/fj3v4PEpBsxGRpjfUXndY3tnMROqOc0h5QyJhqBtSrgXeFqIZ8EXnXg
         gC8wdt5AOL+0jYSmMfSPUtp6Edf9Tv2FafAESczbYXwTMqTdqQCso1Mpb2dL56sJp7YV
         TigLCHW4YCDQPUbjhExHgaud9SY193zRXdnglCX3ivpHkNjeCDAAujFX9QVeijiv6qth
         aZ2JIL5hsVMoehaoSEuP+vaGp2ZRfgq0qs5ZTPFH1s0RgUSTbvmALSWWgr42qXdoiymN
         V5Zw3m5dkQB6+oxxIo/pJAJzcNlDzZbAl+gypo5UWoGy/cLortPaKhA5If/5kP0mN2aX
         H0WQ==
X-Gm-Message-State: AJcUukeOh1Aay+TSHdBHigWsY3To0uBQGrjmd3uJTodJk/iLOAMt+GLH
        zTHIil42WaIYi1lE5PXqnIYYew==
X-Google-Smtp-Source: ALg8bN6ETH/c2+tgMRB0hU0/Wx290/8H3fJjMQLQ8NqYYyL683GmSPZUOB+WQEa+WOqPdyxLSerFqQ==
X-Received: by 2002:a63:9749:: with SMTP id d9mr20406220pgo.415.1546610259383;
        Fri, 04 Jan 2019 05:57:39 -0800 (PST)
Received: from [192.168.1.77] (c.208.53.119.160.static.broadstripe.net. [208.53.119.160])
        by smtp.gmail.com with ESMTPSA id x19sm101426273pfk.14.2019.01.04.05.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 05:57:38 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] tty/n_hdlc: fix sleep in !TASK_RUNNING state warning
From:   Paul Fulghum <paulkf@microgate.com>
In-Reply-To: <0a70193b-488a-7607-4ad5-05ec6018587e@i-love.sakura.ne.jp>
Date:   Fri, 4 Jan 2019 05:57:37 -0800
Cc:     Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <348A9E34-49C4-4A08-BBA2-46D677F50534@microgate.com>
References: <000000000000449587057e1e6f8b@google.com>
 <49b3b189-a51f-6a97-0e1f-bc3f2c305299@I-love.SAKURA.ne.jp>
 <FEBFE826-8D27-4A0B-86A5-BA559921CADC@microgate.com>
 <cf9b7323-da1c-20cd-4d50-1080fbe52467@i-love.sakura.ne.jp>
 <ba6de468-d36d-cd33-9a13-520102b676c6@suse.cz>
 <98eec651-d1ab-48e5-309b-7e748981cfdd@i-love.sakura.ne.jp>
 <434841F9-C2DF-4D73-9AFB-3BFADF325086@microgate.com>
 <0a70193b-488a-7607-4ad5-05ec6018587e@i-love.sakura.ne.jp>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 4, 2019, at 2:23 AM, Tetsuo Handa =
<penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>=20
> But why not to clarify what are appropriate sanity checks?
> ...
> want a cleanup for scripts/checkpatch.pl .


These are good goals. I avoid purely cosmetic patches. I do not object =
to cosmetic patches from others that do not change behavior.

The checks that concern you deal with changing tty line disciplines. =
Dealing with line discipline changes has been an ongoing issue since =
n_hdlc was derived from other line disciplines 20 years ago, with major =
overhauls along the way. It is complex: driver layers shifting during =
operation while dealing properly with opens, closes, hangups, and =
sleeping operations. Patches have been added to the latest unreleased =
kernel to address line discipline changes, it is still evolving.

Why are the existing line discipline checks in n_hdlc where they are? =
Becasue that=E2=80=99s how they evolved from where they started to =
accomodate these changes. There are not many and their function is =
known: has the line discipline changed at that point? I know that is not =
satisfying but coming up with a definitive comment saying a check is =
absolutely required in one place and not in another requires more =
insight into the long history of a moving target than I have. Without =
that insight I would not alter existing checks in code that is not =
causing problems.=
