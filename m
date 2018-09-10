Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90108C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D69D20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="a+aWukWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D69D20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeIKCOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:14:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32927 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeIKCOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:14:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id s7-v6so11115464pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 14:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IwcdkSm81djM6XMMmQzGULl1ECGmI+7A3l600DGR7Y8=;
        b=a+aWukWUcxC4JEe0NofXl+frtPD2OggPIQkHWyQEIm0ZViqS8s5l8+NzYaoPaQvE3J
         ilixjlPioMftJbBK76T/foaMkcB6Pu4+wYOefRjUU869iqG0LNdN13jdYjfrckEz3mMb
         SUNDo6aRpEhBC5BnvhLA6zvOcJbw/MaUeeb3jDFzkU/+Jp3vn6rdB+nIGfjSfaXRan22
         vUNpsO/bXICiJRkFYaUdhfX+MvLzoKmoxl72vAcBtxv3As9wXwl9uKvsdWU2EOk3psjL
         pTDDF8zt8iXwKtMi3l5eGO9XqhhCegDJrhuqM1kfohlJB7UAa0z+Uvqc54Ba1MjQ0cLO
         Zdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IwcdkSm81djM6XMMmQzGULl1ECGmI+7A3l600DGR7Y8=;
        b=IVJF/l+M88EsHO5hYaZCTdZjA7/siNYUPPyrFh0hVzp94XsFBCrh44rG+BzrpVJT7B
         06yoze3ooh6GiHgzhBfX49ESBVVcs30Qe24LjBTFloFQkVBEYbyGeewL2eeQOYQ8nkKE
         ESU0LR+zqzviz58ozI98Lp8BWlbGNnP8JbTDJOZOa4M8InyvOIOcIyI8udRwjSP8wBBJ
         MnbHyLdqbwze1optOg/MPNroPXnaOWLMSkhycwL9KahmI3nwR1xbvA7ONws4PLI/Hhlk
         hh/d2dnMPYig9RhA2KeNf7RgS+ZD39wpN1hVErZiF2SM/tB5k49o9Y/qbPKKZ2FJq4Qt
         Swsw==
X-Gm-Message-State: APzg51BQS2kjADB/SIc8MMiJrNmyOP50sihmgNWHZ0/w3tOGamv4jMeu
        TwIpBZsjoKHryDb1AINZ8cqSiQ==
X-Google-Smtp-Source: ANB0VdacaekJfKjwQrrH65ASvY+w0Z6gzN7WsGRHgUXtA1b3/qjR4BIoakEQCHszlb8q3REfOiEM2w==
X-Received: by 2002:a62:cc41:: with SMTP id a62-v6mr25767789pfg.131.1536614285812;
        Mon, 10 Sep 2018 14:18:05 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:a1db:83d1:3cfc:8736? ([2601:646:c200:7429:a1db:83d1:3cfc:8736])
        by smtp.gmail.com with ESMTPSA id i65-v6sm38420755pfk.43.2018.09.10.14.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 14:18:04 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC][PATCH 1/8] x86/mm: clarify hardware vs. software "error_code"
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <6f75823d-ce8b-d483-6046-4efbe20d0410@linux.intel.com>
Date:   Mon, 10 Sep 2018 14:17:56 -0700
Cc:     linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        peterz@infradead.org, tglx@linutronix.de, x86@kernel.org,
        luto@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E480E807-701D-43C6-A0AF-DF7829A701BC@amacapital.net>
References: <20180907194852.3C351B82@viggo.jf.intel.com> <20180907194854.74729D71@viggo.jf.intel.com> <561334F6-9C13-424A-95ED-D377CE48DA46@amacapital.net> <6f75823d-ce8b-d483-6046-4efbe20d0410@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 10, 2018, at 1:07 PM, Dave Hansen <dave.hansen@linux.intel.com> wro=
te:
>=20
> On 09/07/2018 03:48 PM, Andy Lutomirski wrote:
>>>=20
>>> For part of the page fault handler, "error_code" does exactly
>>> match PFEC.  But, during later parts, it diverges and starts to
>>> mean something a bit different.
>>>=20
>>> Give it two names for its two jobs.
>> How hard would it be to just remove sw_error_code instead?  It seems
>> like it adds little value and much confusion.
>=20
> I think it would be really nice to have hw_error_code stand by itself
> and be limited in scope to just __do_page_fault() and then have
> FAULT_FLAG_* for everything else.
>=20
> But, I was a little scared off of that.  For one, I think we fill in
> signal info with error_code, which makes it nominally part of the ABI.
> So, I wanted to muck with it as little as possible in this set.
>=20
> But, if we just said that
> 1. hw_error_code goes out to userspace, always, and

Nope, it=E2=80=99s an info leak. If the address is in kernel land (and not v=
syscall), we must (and do, I believe) fake it.

> 2. We drive all kernel behavior off of FAULT_FLAG_*, not error_code,
>   I think we can get away with it.
>=20
>> I=E2=80=99m also unconvinced that the warning is terribly useful. We=E2=80=
=99re going
>> to oops when this happens anyway.
>=20
> One thing I wanted to get out of the warning was the contents of
> hw_error_code before we go screwing with it.  I also don't mind a nice,
> clarifying warning showing up just before an oops.  Maybe it could be a
> pr_warn/err() instead of a full warning?

Sure.=
