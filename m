Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60323C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4BD20896
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="qtHoxWfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4BD20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeIZCJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:09:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33594 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeIZCJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:09:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id y18-v6so9035683pge.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=l4Zg7Bn+PFdYPbzgbnfoIQMb2CUcvks2lejJUWTxrFw=;
        b=qtHoxWfOKYLSQe0CHf58RW+9Phkc4SsWNwUiRc2cIvuwEeknsD0tsAPXOBnHNiGRBO
         5q0kdicZf+RnCFqd3+JgLC6euUf6osTne14eBEUhwjWcdgw+aUvkFdRA+aHytMnNXkzw
         hlgIvQiNvCJRQHqAnxv6RMbiVdsCsEeoUGnDcljgokoa5t5ijiHQBEcZlsmx3+ukSK2N
         9sn/bKX0FYMLsPA49nYfH2scbctoXqLNNKlNmvfWY9bzyjkHUiDcFhWHlt3CFNUbZZlc
         fR5OL+tbE0Ah1MDFc25uKECZX3TWZriyB7CGOSSw3Y4Vnj5OzhAI8pf3nPaUpbBF9U/s
         OQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=l4Zg7Bn+PFdYPbzgbnfoIQMb2CUcvks2lejJUWTxrFw=;
        b=KmjNARtzaFFBwzRve41R1GjsmOshQeBIwUetqcY0gn9rDy7OvZFomr6UqSXrr+ekc/
         pXLMu0GKS8yyyxmdhgJ+lZ/arSMGlVq8/H6APxnFEdNeDiN7idoUSSaO464/00MG9ouY
         atp1qgqNeeRIkaNr79fiF4cx0X6CV0SfUvzxtb4RbpwgBR6QNe8/gWix/KP2RVl2auCX
         1WsbXolWng2+cHzFjks9G8OR9F26ojlC7dHvTqVSVjfJsA3kVaTHM1m6vP127dIb53pF
         JnRnjC/DYyYiq83LqnygVYLQRvpQCeIL4sKsSQen99/GW/bOlsN4SBf7MW8PgUNeW2b1
         qvMA==
X-Gm-Message-State: ABuFfogPIsWHWmcH9FAweoow2NsfQG/R2vsb5puJT+P83hBJI0zjB7F7
        r4+D8PjZAte3Dih9B/fZsXLxPQ==
X-Google-Smtp-Source: ACcGV617v99mi2MobGRZzVWwMxPwKN3IRaT/L52+9YZ6mMWyRtywR+vUcLW3wT8RAFTksO4Tv1lweg==
X-Received: by 2002:a63:da57:: with SMTP id l23-v6mr2426383pgj.179.1537905610331;
        Tue, 25 Sep 2018 13:00:10 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:b47d:360c:bc0b:19be? ([2601:646:c200:7429:b47d:360c:bc0b:19be])
        by smtp.gmail.com with ESMTPSA id j187-v6sm5351688pfg.108.2018.09.25.13.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 13:00:09 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next v6 02/23] zinc: introduce minimal cryptography library
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <CAHmME9qLzFHPm2aaEKOmjBA95-c3CZuT+kQiuksLRRWQ_ad2sw@mail.gmail.com>
Date:   Tue, 25 Sep 2018 13:00:08 -0700
Cc:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1BA7DB23-7BB6-46BA-A3E2-D65BC3CAF11C@amacapital.net>
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-3-Jason@zx2c4.com> <2b5f2df2f1278c118a913259a44efdf589719293.camel@perches.com> <CAHmME9qLzFHPm2aaEKOmjBA95-c3CZuT+kQiuksLRRWQ_ad2sw@mail.gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 25, 2018, at 12:43 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>=20
>> On Tue, Sep 25, 2018 at 8:33 PM Joe Perches <joe@perches.com> wrote:
>> I think the -Dpr_fmt is especially odd and not
>> really acceptable as it not used anywhere else
>> in the kernel.
>=20
> There are about 2000 cases in the kernel of the same '#define
> pr_fmt...' being pasted into the top of the file, which seems a bit
> cumbersome. Rather than having to paste that into each and every file
> that I pr_err from, why can't I just do this from the makefile, since
> I want that same pr_fmt to copy the whole directory?

Because people like to be able to just read the C file to figure out what it=
 does. Or we could adopt the Makefile approach kernel-wide, since this use o=
f it seems reasonable.=
