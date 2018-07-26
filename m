Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8ADC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6442064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCP1zEGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6442064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbeGZKoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:44:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40680 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbeGZKoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:44:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id x5-v6so790013pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 02:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NoFDYHcbVaj1tOogJjEarKpuJ6WsCYKtNVsiPLendDE=;
        b=dCP1zEGyeRmSFbFI9AF+c5WGm/d92Tz1IAf/WSxy5IhpJL+Y+QrThk04eBRVnGV6A8
         BsqWZKhpLeh6x/XzRwV1/QBZOS6D2nUvVC6/rGrGyg3lcvHhOMMxwbFPV6UO6lo1MUsK
         IOT2Y1kquu8E8BCvtFkC/qbBI92rVpI/x+yjY86VchMJN/BUgT8P9UaXc9xq73RPHAnD
         3I6uzAppTD1zp0kcLDTPnxhpCeepttRFsfO+Rghl6Y1wP2S/B30hwefGIJXzUNvFy1yf
         N3zAZ0ueZY5haxpaUstN9+vP+bP8O1+1WFfahNAKPg0GH4N50VJU7qUB8JJ+PHSynAhh
         /P4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NoFDYHcbVaj1tOogJjEarKpuJ6WsCYKtNVsiPLendDE=;
        b=uLFCpzU4D3WQcvI8E74o3oo+t+DgosK+9Yforf+DaK+RxImJ9kW7ZJTKBVMlFT56zU
         zqm/uclFyNsVXEdZ0sKnlGBnjWOk1+Kdsd1smlDed8BjhWdcs3zlXT+66+Q/euOonpw2
         7lCHakKRDRh3n0NOUy5LESqpX+BmwjsejKta0+tIlpF+s1PcGTIRaiqfq2w6m6oejqrc
         nx7ektJLgn2Nslm4bomBmd68T31NOfwIELM8pYBPkfKdk2oi1Ys5z3wWNZu+Cu8KM+jW
         tlOwdDeGNQ762MIF+mLMj/uA3IYQJvWx9rNiAmoNeaadNCd6by/zNojD/Zk9UQ4kKzHi
         c4Dw==
X-Gm-Message-State: AOUpUlHLeN/VYNVyTw6dmbSvUaSb4a0YzZThg/+QXzD/zxuusVTj29Pc
        bl7t5huxvTah94wkykk/hp72T8PPWRSufkT9tV1cQQ==
X-Google-Smtp-Source: AAOMgpek9Cfc14F9+ueY08vVdqyLkP+qjF+/1InIqKfIdzlTljYO4ywforKm9SkGJ+93tQi9AAL/HQ7dZb8LbsawC3E=
X-Received: by 2002:a62:3184:: with SMTP id x126-v6mr1314811pfx.49.1532597299881;
 Thu, 26 Jul 2018 02:28:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Thu, 26 Jul 2018 02:27:59
 -0700 (PDT)
In-Reply-To: <20180726081727.GA6699@nautica>
References: <20180726081049.10527-1-tomasbortoli@gmail.com> <20180726081727.GA6699@nautica>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 26 Jul 2018 11:27:59 +0200
Message-ID: <CACT4Y+ark+0EYSZaOX-qDKpOkyfLgSO9CkidZzx=xkUuhpr65A@mail.gmail.com>
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

On Thu, Jul 26, 2018 at 10:17 AM, Dominique Martinet
<asmadeus@codewreck.org> wrote:
> Tomas Bortoli wrote on Thu, Jul 26, 2018:
>> In p9_fd_create_tcp() and p9_fd_create_unix() it is possible to get
>> a NULL value in the addr parameter. Return -EINVAL in such cases.
>
> Let's refuse that at much higher level, like v9fs_mount() in
> fs/9p/vfs_super.c
>
> I can't think of any valid reason for dev_name to be NULL, it's the
> target IP or virtio handle.

But I think trans=fd allows NULL addr today, no?
