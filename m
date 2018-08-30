Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB22EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 23:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D22B2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 23:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="NHX4AcEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D22B2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeHaDIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 23:08:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34259 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeHaDIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 23:08:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id u1-v6so7552183eds.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 16:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6xrneNq/HkvlMjgb348sXaXH7GDpZyZ8B7HqHjo0ppk=;
        b=NHX4AcExtl7BwQZC3UuRclRqoP31cT4zWBs64F3xh7/jb2ZoBt4uJXB7oGFz13ope+
         u1ZW5FNyVS0GMJgqxqYDklHxJleh1doUDN3CAQVeXzuhysjM/I0B96NsVBfUk0268IVo
         ieIUMnXZ3W4kPFc6JeAF0iXemiJlRPQ8Xsra87o6W8etz27VdHbrAwGUAUKPNPX1CuTf
         bgWq1MRycU085qfydTe7V9gVDjkYYIrDWs2iPpiqQqdIcnYL9oQJjtBFhk49yG3ZB47N
         6Uwt2zT0kLgSHZMd0x3wMdllgqAP9xhmU56BIsgNWiNd9QpPNN1LmsrHNQRao2WESGXT
         Ns8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6xrneNq/HkvlMjgb348sXaXH7GDpZyZ8B7HqHjo0ppk=;
        b=hU9lOa85shFgkZEkSGTyPhwkCKJlfj4c2C+awYMhJwhwc1vbSXgcAD4bfWtc6bz1XP
         M5opH4/Bj4z8rN4xhsJOYxoeXLaIpEmrevb1jBP6Z7LOO/0H6Fwct5/aeJZYXyOH7zXb
         4XNsOQgYlPP7x6MtFoH3bPsMKt2paGwdSZoUn0XStW60SHsqpmdqZ+vUTZlfAgKKgl5U
         Xe92zuhYGdcmxaWhiisXB0MBKDjFAyIKxzLLd2YKVu8lCjrrDLfGdzMXufKmcp9BbBDK
         JRgMWUSC9nWMLFO8UydLvil23hTCJVF40LRBYa5ABzMXc22O/TdtX9lBWQgqjfFMqRlL
         koAg==
X-Gm-Message-State: APzg51BrjmC4Y84hFkElbXRHsTWX6Rv63ASV5qGzWCReNS58CWVNXNaF
        XTvkgaagz4PHwpeLvMEaQe8+rLdl8NA=
X-Google-Smtp-Source: ANB0VdbxXQRIJTzkwdvG72JpBCAs99NQj0MT7e7Oi/66E/rIAwzFeQgCzG/QqWK6r3nHZyKz76HNHw==
X-Received: by 2002:a50:f002:: with SMTP id r2-v6mr14821945edl.91.1535670263978;
        Thu, 30 Aug 2018 16:04:23 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w41-v6sm3591211edd.92.2018.08.30.16.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 16:04:23 -0700 (PDT)
Message-ID: <1535670261.23560.77.camel@arista.com>
Subject: Re: [PATCH 05/23] selftest: vm: add unlikely() to BUG_ON()
From:   Dmitry Safonov <dima@arista.com>
To:     Igor Stoppa <igor.stoppa@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Igor Stoppa <igor.stoppa@huawei.com>, Shuah Khan <shuah@kernel.org>
Date:   Fri, 31 Aug 2018 00:04:21 +0100
In-Reply-To: <1535669872.23560.73.camel@arista.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
         <20180830223429.30051-6-igor.stoppa@huawei.com>
         <1535669872.23560.73.camel@arista.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-30 at 23:57 +0100, Dmitry Safonov wrote:
> Hi Igor,
> 
> On Fri, 2018-08-31 at 01:34 +0300, Igor Stoppa wrote:
> > BUG_ON() is unlikely() to BUG()
> 
> This selftest runs in userspace..
> So, we should define the macro somehow, as i.e:
> rseq/rseq.h:#define rseq_unlikely(x)    __builtin_expect(!!(x), 0)
> 
> Otherwise,
> [selftests]$ make vm/map_populate
> cc     vm/map_populate.c   -o vm/map_populate
> vm/map_populate.c: In function ‘parent_f’:
> vm/map_populate.c:26:7: warning: implicit declaration of function
> ‘unlikely’; did you mean ‘unlinkat’? [-Wimplicit-function-
> declaration]
>    if (unlikely(condition)) {     \
>        ^
> vm/map_populate.c:38:2: note: in expansion of macro ‘BUG_ON’
>   BUG_ON(ret <= 0, "read(sock)");
>   ^~~~~~
> /tmp/cc7evGVG.o: In function `parent_f':
> map_populate.c:(.text+0x3d): undefined reference to `unlikely'
> map_populate.c:(.text+0xbb): undefined reference to `unlikely'
> map_populate.c:(.text+0x135): undefined reference to `unlikely'
> map_populate.c:(.text+0x1b0): undefined reference to `unlikely'
> 
> Not sure if we care for this at all for userspace test.
> I don't mind as it runs each time by kbuild robot and cumulatively
> may
> save something. But it's better be at least compile-tested.

JFI, there are a plenty of definitions for unlikely():
[linux]$ git grep 'define unlikely' tools
+rseq_unlikely() from tools/testing/selftests/rseq/rseq.h

Probably, the one from "tools/include/linux/compiler.h" can be used in
tools directory.

-- 
            Dima
