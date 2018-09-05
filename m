Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC72C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C5220869
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqwgFis8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C5220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeIEVfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:35:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbeIEVfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:35:54 -0400
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C76802087F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Sep 2018 17:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536167090;
        bh=PXAN4s2C0+ss57I+gCNZA69qCfLKCD/7jnNdkdnvKEM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qqwgFis8dA7ueLJ/Vf7ypzJ0zEbd3Siy/cra99ztzzG/x2AJJKa9EHKz2bGDYGz6N
         EE5Z92GiYhc1llwPVbQfzUmQnTu43tRn6fGJb65478mNScNM6epitkDwoC3vM9qYuW
         D8JV93OG3dnRXzaTJabFLTL8WprZHzfYha2Y9WrU=
Received: by mail-wm0-f54.google.com with SMTP id j25-v6so14485135wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 10:04:49 -0700 (PDT)
X-Gm-Message-State: APzg51A9ocYHLxjxE5XQWJfB6k9o9WEW6gGsm2vLP6nddmxW+tnzHQs9
        ucY1leQUMXRvITjcNu9Zcj6rVaoojbQF8Uv+dujRYA==
X-Google-Smtp-Source: ANB0Vdazu2bIRLAGvaRFJO3kddzH0TDzQrgTKKF09VbOObPbmJhOVbibCG0hWQ5aKsR9DNFuS8y4XAYhrHAFTsc1XJU=
X-Received: by 2002:a1c:cb4d:: with SMTP id b74-v6mr889128wmg.123.1536167088138;
 Wed, 05 Sep 2018 10:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com> <1536163184-26356-8-git-send-email-rppt@linux.vnet.ibm.com>
In-Reply-To: <1536163184-26356-8-git-send-email-rppt@linux.vnet.ibm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 5 Sep 2018 12:04:36 -0500
X-Gmail-Original-Message-ID: <CABGGiswdb1x-=vqrgxZ9i2dnLdsgtXq4+5H9Y1JRd90YVMW69A@mail.gmail.com>
Message-ID: <CABGGiswdb1x-=vqrgxZ9i2dnLdsgtXq4+5H9Y1JRd90YVMW69A@mail.gmail.com>
Subject: Re: [RFC PATCH 07/29] memblock: remove _virt from APIs returning
 virtual address
To:     rppt@linux.vnet.ibm.com
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        davem@davemloft.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mingo@redhat.com, Michael Ellerman <mpe@ellerman.id.au>,
        mhocko@suse.com, paul.burton@mips.com,
        Thomas Gleixner <tglx@linutronix.de>, tony.luck@intel.com,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 11:00 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
>
> The conversion is done using
>
> sed -i 's@memblock_virt_alloc@memblock_alloc@g' \
>         $(git grep -l memblock_virt_alloc)

What's the reason to do this? It seems like a lot of churn even if a
mechanical change.

Rob
