Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F91BC46465
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626652146D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Wm+Af3yh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626652146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeKUHEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:04:20 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41963 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKUHET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:04:19 -0500
Received: by mail-io1-f65.google.com with SMTP id s22so2380419ioc.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 12:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/ACK9hgijau5NaerT7WtxrZntPBFEN6+Twpv5+vF4U0=;
        b=Wm+Af3yhjZD5Re609hy0AJfHfUtTJAKhDYnss1QPEh2iUwN9c+jebP87dhwRWmwZhy
         n7H2xV+mjeCzMaMcpX7IdNF/LNxa2Eu0JYCa2OyskjKxMt+vowarNRPbOrsR8hjybtnc
         gRbJxgDLAWH+mrNs6XPQMDyl+MW5Lyck9PJlcSv4K15JL9FrLnxhwqHzAc2jSRWBs+7D
         ll9UZ2JZAaBt0+4GasEUux4hoG5bhWAt+KYBxYbr5JNnzkV0lKJfaN42YlvGWGandnNr
         QULx1RXOTKl6jxkQi9u5XlvMq2TbZhToibm166PE+BjXpmsJfzhRec6aqqVFgqih5H0S
         zH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/ACK9hgijau5NaerT7WtxrZntPBFEN6+Twpv5+vF4U0=;
        b=f2lxKpJsHwtyHwxh5sSa5ia2ZJU/mO670vaJthkNF10GjxYkI4b2R5OQikk5xVZcGZ
         9JONqa2EME1Fb4hojpYLaLRHhECvnWHTWbqkSq1lfkMhG9Z2fFgLCNaMmErcFSHeRoOG
         Gjkk1tchyC3fF8shyNfxTgd/G6b0TXqU/Pa8N2gxmC42kbfET4n2JocYBJib5FASwpfT
         Qav0aMcYSdW7WokppiJaFZfE+A42eTtaF0921gWK1+SIr4ZXvxGuit3mZLkrZcnEXK2G
         FmuQBVIaRpQuLw+7xiCScXsZrQqwrBSR6DCW5hwPTPWk5SwqbWnAXnv3ZpMLeDErJ9Ze
         Kn8g==
X-Gm-Message-State: AA+aEWY+kUB7FItOXJNHkwYCZS1OtCeQEqyfZOIQ5YI69bBiOwSSnLQr
        mNTUelOSajctJebLSfzRayWHVg==
X-Google-Smtp-Source: AFSGD/VcGQahrKSuDHW1NjBLCI8qOkb7l6t87+H/o5FUiMQu9cBN6G8Yvf+jqYCXIR0n4FBTPdpDjg==
X-Received: by 2002:a5e:db0d:: with SMTP id q13mr2796473iop.81.1542746000498;
        Tue, 20 Nov 2018 12:33:20 -0800 (PST)
Received: from ?IPv6:2600:100e:b040:b126:ec78:48dd:44e2:e165? ([2600:100e:b040:b126:ec78:48dd:44e2:e165])
        by smtp.gmail.com with ESMTPSA id y1sm5971806itb.29.2018.11.20.12.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 12:33:19 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next 1/2] mm/memfd: make F_SEAL_FUTURE_WRITE seal more robust
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <20181121070658.011d576d@canb.auug.org.au>
Date:   Tue, 20 Nov 2018 13:33:18 -0700
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        marcandre.lureau@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <469B80CB-D982-4802-A81D-95AC493D7E87@amacapital.net>
References: <20181120052137.74317-1-joel@joelfernandes.org> <CALCETrXgBENat=5=7EuU-ttQ-YSXT+ifjLGc=hpJ=unRgSsndw@mail.gmail.com> <20181120183926.GA124387@google.com> <20181121070658.011d576d@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 20, 2018, at 1:07 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote=
:
>=20
> Hi Joel,
>=20
>> On Tue, 20 Nov 2018 10:39:26 -0800 Joel Fernandes <joel@joelfernandes.org=
> wrote:
>>=20
>>> On Tue, Nov 20, 2018 at 07:13:17AM -0800, Andy Lutomirski wrote:
>>> On Mon, Nov 19, 2018 at 9:21 PM Joel Fernandes (Google)
>>> <joel@joelfernandes.org> wrote: =20
>>>>=20
>>>> A better way to do F_SEAL_FUTURE_WRITE seal was discussed [1] last week=

>>>> where we don't need to modify core VFS structures to get the same
>>>> behavior of the seal. This solves several side-effects pointed out by
>>>> Andy [2].
>>>>=20
>>>> [1] https://lore.kernel.org/lkml/20181111173650.GA256781@google.com/
>>>> [2] https://lore.kernel.org/lkml/69CE06CC-E47C-4992-848A-66EB23EE6C74@a=
macapital.net/
>>>>=20
>>>> Suggested-by: Andy Lutomirski <luto@kernel.org>
>>>> Fixes: 5e653c2923fd ("mm: Add an F_SEAL_FUTURE_WRITE seal to memfd") =20=

>>>=20
>>> What tree is that commit in?  Can we not just fold this in? =20
>>=20
>> It is in linux-next. Could we keep both commits so we have the history?
>=20
> Well, its in Andrew's mmotm, so its up to him.
>=20
>=20

Unless mmotm is more magical than I think, the commit hash in your fixed tag=
 is already nonsense. mmotm gets rebased all the time, and is only barely a g=
it tree.=
