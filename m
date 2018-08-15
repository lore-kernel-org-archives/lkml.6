Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AC0C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BAF2098B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gBSD2aqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BAF2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeHOEMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:12:15 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45241 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeHOEMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:12:13 -0400
Received: by mail-yw1-f68.google.com with SMTP id 139-v6so17706736ywg.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 18:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=hvdKw9HtQf0As5kROyJJKcmQjUHkZ0oa/8pNGXV8O34=;
        b=gBSD2aqCltE8ckH00uhrIJkYnQb/J82ME0LGRRLPSEzQxUCX74CPpyw4+A8Iq0JKcb
         r0lA6sIWrsjYtZpCg/qX0Oo82PzpXx6oe5T2LD7rzb8enS7B72RhVxGYRSslm1dFh5LB
         A4eWyxJoB4qfIZoyekpgddoh4Kjuo682c8rV0SQO42DvxY8XqQd8QgzPzYjNhb5xwPcJ
         u3mmgDI8ggjVonbZhR700ny7JdKt0Cb9TlahYM73nnHAch0MyVO27DrToydGoJ3SmY1B
         R/bpuiydwe/OQpodX3/LmiDRgi6BH6Q3OTmEtq/9jpvo62BlUF042lsz43Sj7Z7JTG3a
         TxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=hvdKw9HtQf0As5kROyJJKcmQjUHkZ0oa/8pNGXV8O34=;
        b=UQ/COuM/BZhxldUTaSqBO2Ox+iCA/ahYEUlwDrWRNiFdmee7YoTc5Nhv4kZ5p1gInH
         08L+gi5iEduKVHT1k94D7YXztvb2NcgC8n+618uQ9Ncgwq9DqRmxfaybiULfxFwhRpCK
         owK8J25Ps0RB6IJE8f2MNh41WUVI2/ncVq818HzyPXhAFgr9XMZA+4qtmEDq4bl8/mVf
         4VSW3ECrYAOhmP9iXRX9jyU8ODlo9481FOG2hhJ4Q0xv9X3RvDrBNXbVQPHWY6rTNrMK
         ukYgC7JlwxL/mKpV29pobrwFjwNIbUh+N0W+JsYKR6xqAAHPj46WsaJ0b9Yuw8kGOPbo
         aULg==
X-Gm-Message-State: AOUpUlEbUtHKgMajcWy0dtm/yR6C6X2tg9ahm8HwP3yBxfqTffOWXm17
        X9JbOM0usW2Ub3ztTh7odzDcFgFHXt7FL8ekrRQoU1B1
X-Google-Smtp-Source: AA+uWPwncGg59DQ0zJ3n2rfGdwZ6z5hCMJuCW5nj2OkI2D3xFZuem/ELzx6Rxi2/r6PiWIxF2MNM18bu5xukM0Ii4vI=
X-Received: by 2002:a5b:607:: with SMTP id d7-v6mr14039070ybq.281.1534296142443;
 Tue, 14 Aug 2018 18:22:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3995:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 18:22:21
 -0700 (PDT)
In-Reply-To: <20180815012054.GA70201@joelaf.mtv.corp.google.com>
References: <20180815012054.GA70201@joelaf.mtv.corp.google.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 14 Aug 2018 18:22:21 -0700
Message-ID: <CAJWu+orb35w6O5B9KyHdYtwc2RbaR9d72HW-i5Bsup72QP8Oag@mail.gmail.com>
Subject: Re: samples don't build on v4.18
To:     LKML <linux-kernel@vger.kernel.org>, wangnan0@huawei.com,
        "open list:BPF (Safe dynamic programs and tools)" 
        <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        acme@kernel.org, Chenbo Feng <fengc@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to add the patch author, doing so now. thanks

On Tue, Aug 14, 2018 at 6:20 PM, Joel Fernandes <joelaf@google.com> wrote:
>
> Hi,
> When building BPF samples on v4.18, I get the following errors:
>
> $ cd samples/bpf/
> $ make
>
> Auto-detecting system features:
> ...                        libelf: [ OFF ]
> ...                           bpf: [ OFF ]
>
> No libelf found
> Makefile:213: recipe for target 'elfdep' failed
> -----------
>
> I bissected it down to commit 5f9380572b4bb24f60cd492b1
>
> Author: Jakub Kicinski <jakub.kicinski@netronome.com>
> Date:   Thu May 10 10:24:39 2018 -0700
>
>     samples: bpf: compile and link against full libbpf
> ---------
>
> Checking out a kernel before this commit makes the samples build. Also I do
> have libelf on my system.
>
> Any thoughts on this issue?
>
> thank you,
>
> - Joel
