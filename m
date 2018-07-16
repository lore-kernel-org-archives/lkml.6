Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF12ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889A62089B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g/p4Mo95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889A62089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeGPRrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:47:52 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39107 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbeGPRrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:47:52 -0400
Received: by mail-it0-f67.google.com with SMTP id 198-v6so14264674ite.4;
        Mon, 16 Jul 2018 10:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fIUtEFXFTJ0xYi3aXzc4dKxqfjZdILXfXhisdTkdp1E=;
        b=g/p4Mo958tulryV/jeaqE4MPdVxo0ZeOkOg5/uXv9CRcErB6/hiQrZ6Hvz43zIVH9B
         9dBFeoUkFSYZPFEqogsbUfFCukGVRPw1WTXQZXuVkJWHfPk5XTvoyW6f7kkV1pNuu6EM
         cua6tXSKBxd33+f5m/naSYrNLhDLax6+3qR6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fIUtEFXFTJ0xYi3aXzc4dKxqfjZdILXfXhisdTkdp1E=;
        b=Kf5QH9m+qAV6g8scDST1wDBqL4T69WesKpHF4b6Aau7B3EubfzDPDZpjejNgtAWPmn
         B8iF0HVAFETJZvgyamg8SO720etmaIAXvzGSwYz6lbo1hBnCPcaQaJvESYGsQZUrkTJ7
         g9XrAYxhPjKhhCwEvs5MZhqV+BVWDT3Myt7sEnevDLnwdomb5c3jeygk5JBes/afNuqp
         lz59AiKqPSXDznbvOTbFRMfeQ+7q1hSMFhSf/ttHCw/H0FHYpNxpnqrf/tF+hyp01SCz
         VpWOSK/SXnOWRi6MPmAO4Tc5WtIXqx/m+69nw9a0TzlBok54taFzhb3TVwxR/0IHX7HN
         B+8g==
X-Gm-Message-State: AOUpUlGv6AsIcFLLj/rHhS6Rt1Xg6Rlryv1+pWz9+wvqJkPKxdMHn5y1
        rB11C6OKTcvk9zrXs7tCz75yrNkGhYivKYKwcjM=
X-Google-Smtp-Source: AAOMgpdcL1iV3Gy82x7YfrDQL5u9/zowMvJDKINnS0bPkJoGmQ/L1Kh1UlWq9BJYoZyv62Dpw77tr9COUaZMDE9JsRY=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr13123920itm.113.1531761570532;
 Mon, 16 Jul 2018 10:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180716165154.58794-1-jannh@google.com> <CA+55aFy21E78DTF-3+1P3bTtX_89-nFUSpYHUELT0WCOZ-ccjw@mail.gmail.com>
 <CAG48ez3HEcp-hE=JF4T+7wjLju_NtLXqh8fvroEPBmx1P2D9Hw@mail.gmail.com>
In-Reply-To: <CAG48ez3HEcp-hE=JF4T+7wjLju_NtLXqh8fvroEPBmx1P2D9Hw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Jul 2018 10:19:19 -0700
Message-ID: <CA+55aFxeJxC0SNv9o4RYZkwmRA15SBg0cw=kHgO-omAjg2RDgQ@mail.gmail.com>
Subject: Re: [PATCH v4] bsg: mitigate read/write abuse, block uaccess in release
To:     Jann Horn <jannh@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        linux-block <linux-block@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Doug Gilbert <dgilbert@interlog.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 9:58 AM Jann Horn <jannh@google.com> wrote:
>
> I thought Christoph wanted this one for stable. Maybe I misunderstood.

If we can remove it in mainline, we should remove it in stable too.
There's no situation where compatibility would matter in stable but
not in mainline.

            Linus
