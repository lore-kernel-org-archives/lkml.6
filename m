Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7882FC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4ED2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544568713;
	bh=EocnfZn8ja2uZ8G0caUenn982bCT4+rmB/82Tz4D5DY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EnB23tT7uEKdFiASJqKoXC8NwDoba1JgoB25C/hkeUF83huRw+3sAmfVeGDhEXtHj
	 NKNFJCpsnU2FF1yzup2vHoJvJK+b0VVT5lhMDFshFU8x/7bdrmmbLoB+HHL1XURZRP
	 uywJ3MF0WhfLQjRZiQjTmojcXlW7fETFmfY0xV3w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4ED2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeLKWvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:51:52 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34723 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLKWvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:51:52 -0500
Received: by mail-ot1-f67.google.com with SMTP id t5so15823646otk.1;
        Tue, 11 Dec 2018 14:51:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EocnfZn8ja2uZ8G0caUenn982bCT4+rmB/82Tz4D5DY=;
        b=uaY2ttYkiDjb+MNEWbBqHtXRtYQ+BgPjMXrBg7g6l8cWwdhFSMb3J3LSytYTeaba73
         iGUDF61R0gHCaOlYuBFjfZwSd6gStWEng/dHSyJbNBIddlCBigsfg9yDgYKK3SNU39fo
         2bs5Rk6TXzlGnsg7RH+uXqSD+kr9vdGab4dvv753TiKqfkXPhUUOzTh4ooNLmSh7cgub
         j1rbnrlhUJCKQ9fkfapvftMgGb5shMFpEMh/u6XI0EASATQK+zPhQcZxBjH0JkkJIbLT
         ix0TkNvGcTmhIPNNsQxIimi6aCHSi6df0EAUXKtLvu9SicPdmND2oTkx+1p0idA15hoE
         nlpA==
X-Gm-Message-State: AA+aEWbfgHzOXlAEi4vC6awYso1gJgyJHU6HFPcWa7yjIxHh+lr9VSnj
        rVMQhs59qUSdPHd96/xsIfbrMOPkI9+poI15YJcU5A==
X-Google-Smtp-Source: AFSGD/XjDXx2/txEZXocnz2w0CygNQc60vEaQXwPijSZA5n4mSm7/qUgnPBLN9rZjynyrhuSIDQ3tJ6JvGDsm5Zdm2Q=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr11796373otf.124.1544568711146;
 Tue, 11 Dec 2018 14:51:51 -0800 (PST)
MIME-Version: 1.0
References: <20181210181315.5023-1-okaya@kernel.org> <20181210181315.5023-2-okaya@kernel.org>
 <20181211170957.GA335@infradead.org> <342c5dd9-cb3d-d714-c87f-814a942cf395@kernel.org>
 <CAJZ5v0ia+eotSZgjbitt7TAT0ECSmTAz1XJhS3Auz5w5Z61SZA@mail.gmail.com>
 <a9c7cbe1-eef3-40ad-de62-8194df12ca20@kernel.org> <CAJZ5v0g5t4sx6mY=mCPWOdZLbhEAXo5Ah1TZw9jZNJQ-+cgWsw@mail.gmail.com>
 <6644defb-9199-6467-6e3e-8ce552b56f87@kernel.org>
In-Reply-To: <6644defb-9199-6467-6e3e-8ce552b56f87@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Dec 2018 23:51:39 +0100
Message-ID: <CAJZ5v0i+rgLL+KrRs69URbGhUxDK9eUEuLifDWuL2mgpkAv_1g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ACPI / OSL: Allow PCI to be disabled
To:     okaya@kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:22 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 12/11/2018 5:16 PM, Rafael J. Wysocki wrote:
> >> AFAIK, ACPI spec says that AML code running on non-existing op-regions to be
> >> discarded last time I checked.
> > I guess you mean "disregarded"?
> >
>
> I have seen Linux complain about reads/writes to non-existing I2C opregions
> before as a read/write failure for every single AML transaction. I was under the
> impression that we didn't care.
>
> > So the spec appears to expect the OS to silently ignore the failures
> > in those cases, so why should an error be returned?
> >
>
> I can certainly return success for this case when CONFIG_PCI is not present.
>
> >> I know Linux is noisy about these.

Well, users running kernels with CONFIG_PCI unset on platforms
expecting PCI support to be present in the OS may want to know that I
suppose, so that would be a good reason to return an error, but
perhaps just once rather than on every access (maybe unless debugging
is enabled?).
