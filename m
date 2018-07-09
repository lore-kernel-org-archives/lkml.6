Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F88C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716ED208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="qGQYFPQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716ED208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754611AbeGIGGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:06:15 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45975 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeGIGGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:06:13 -0400
Received: by mail-oi0-f65.google.com with SMTP id q11-v6so8138928oic.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 23:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vZMclvgaCIpPTGhPmbmWlv7OF88Q/gyove1aS0PJsTE=;
        b=qGQYFPQvjAmclkhyfKJLsldLxUZK8OncuuT1Rfo3i3+VP4UQw0xJ5tpQIPN0AV4UTU
         rD6zSGQ3l6Wat0tnN/PZy+/ZMB71GaMRQOSxYkj2QtNrcMJo1S8YrNUb7TaRUn8ytF9i
         86K753nfE9jDzHA9ec8/csBd9m5ShXLAUNQlNPxS+O9+64Z7WuhOQ7KdT5otzKu7qS/5
         52yA3sHZkw+mC9IsM7SMSjC6VGgjZnzuXcBTICY0P5UcF8o1Cer0O9QMmzha1r78vveL
         S37y7A0nWblROlm+TXE/AigHywpjR7mAibFqldPPEm6Tnzm4I9fjqW8WHanhX/oItP/Z
         zMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vZMclvgaCIpPTGhPmbmWlv7OF88Q/gyove1aS0PJsTE=;
        b=SGjEJSYgZTsM4J775sCvCTSarSiT7v6gdVOhmM74E0Aq0J+cHzs2ocSJ5/d+ak+MDa
         Xg3KCcfV8VQko8EzizsrK0/bOVzwcCKozRuWlmpuKr9af8fGUc87AevgfeL3VcqRR+or
         fZitmO4OfgCCGrnuJ//eJvrGrGFWfp+uuYhT6vQlzwoMNSZ+gHJdbscALwz5sRt5meM4
         RLIB7EFCNNpqYEoUoZglTb+KNLzaBQq0CuF3381+yVKZYM5C67C835C5dFONpE/ftWAe
         76pKt2oozZilZushYSTbpAiilx2WPS1yZ8w9Gh1+Jcn1lq2HPAPFm1sUacPf5UMYl5t7
         Sidg==
X-Gm-Message-State: APt69E20NnvzeHlLQHnNe/yAIVErurD1QGCxnkM54JB/ktHwz5qUiARC
        joW9hmuRdh/0/b6JXLyuwE2XcJqY4orIuKUPHiaZpw==
X-Google-Smtp-Source: AAOMgpdlc8gz/1vKw1Asi8kCL5P0a1DNWE5SlGaW5WoN6qlcj248IUf/RQe5sdoaeCs7c/hUTn2H/WdkT6jC4tKzE+E=
X-Received: by 2002:aca:3c45:: with SMTP id j66-v6mr19965506oia.118.1531116373119;
 Sun, 08 Jul 2018 23:06:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Sun, 8 Jul 2018 23:06:12 -0700 (PDT)
In-Reply-To: <2581eec7-ad1e-578b-d0cd-7076a4f88776@linux.ibm.com>
References: <20180706082911.13405-1-aneesh.kumar@linux.ibm.com>
 <20180706082911.13405-2-aneesh.kumar@linux.ibm.com> <CAPcyv4gjrsswcakSog7jxT+agH7NrBEvwxe9jT0ycU3RZV5sWA@mail.gmail.com>
 <CAOSf1CFuxga8BAbnvPdZvutgpAxmzgjiqxzHFuVTVLOkMwKO+A@mail.gmail.com>
 <CAPcyv4ihixEN9LV6TMqax3Qa2huiPnR-kFyhtO0H51GvGu2C2Q@mail.gmail.com> <2581eec7-ad1e-578b-d0cd-7076a4f88776@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 8 Jul 2018 23:06:12 -0700
Message-ID: <CAPcyv4hbPTYkvzOjM7zYXgZ_7NnW4UJ0sUxP-fbCx4mjHDy1FA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm/pmem: Add memblock based e820 platform driver
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Oliver <oohall@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 8, 2018 at 10:17 PM, Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
> On 07/07/2018 11:06 PM, Dan Williams wrote:
[..]
> What we need is the ability to run with fsdax on hypervisor other than KVM.

That sounds like a production use case? How can it be actual
persistent memory if the kernel is picking the physical address
backing the range?
