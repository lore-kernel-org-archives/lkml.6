Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6820AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B7A2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FQ2WA9uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbfAGXWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:22:05 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32779 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfAGXWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:22:05 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so1852736ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 15:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y3L4dBpk8uNJYeoX6KeItdPRo2Nm7RZAS4jSGNgPT6o=;
        b=FQ2WA9uoVEBkJNZYUmOOEMlYa+HWOoh8HUZBZ3Qc+7/hpkiWfW0MucLK3y2WyDCyoC
         FVbtMmDHcwapDcaqBOZLnZV9hEc196zb44XNhxwXwREDO1VJtdFl5yMcfwoTiWBFEOPD
         IqDzPecvbEPrEESPox+HWoEKRt+vk+prRwkAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3L4dBpk8uNJYeoX6KeItdPRo2Nm7RZAS4jSGNgPT6o=;
        b=Ml1SDZ17UY9qScNp4DB8eGHJVZtY08BgMb/bOZWhr0eMbc9aEoowVjKlhlo4md0nkX
         O+OrDmg6VyNnsf0EihluShTz7StIiCy4i/PR0uNxI/nWK9fvxGli8EHLhxOwHhgQcEOO
         W6qM6GQE9SFTbX4m+u8MMEGOWfONy0iHH72lgqYfGmq3ZM8QQCPj9luh1V3Vq7x64Xlm
         nU8adsTIej4GeLtt4taLvDp73A4vS9NAJhRTRDPjmYnVvRdLhTgV7+ywKvyVhFbEtKsQ
         lDb7+3GyBE7jzfT6bbmlhGf6mhVsjFc7lBEPH0lZ4zW5RaTGHAI3Zk35ZJREG9gg1YZC
         00jQ==
X-Gm-Message-State: AJcUukcO+CcM45KYKtXZu4piyTxZRvl+LSUBzII7TZ/ZcuadNrcfaPhx
        tw+qTOPAWWtcwjdyZ7DYbvCA2yhODpw=
X-Google-Smtp-Source: ALg8bN6O4qfUpT6XKUi/lYVIblcj4Du7nQiUUyKwZTIgV3uQSCi2Of3WuE78tfxQ6Wpl+5XqswCc/w==
X-Received: by 2002:a2e:131a:: with SMTP id 26-v6mr12200352ljt.107.1546903322779;
        Mon, 07 Jan 2019 15:22:02 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id c14sm13033569lfb.40.2019.01.07.15.22.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 15:22:01 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id y11so1588350lfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 15:22:01 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr34038625lfc.124.1546903321266;
 Mon, 07 Jan 2019 15:22:01 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgKYnrL3LjhVkH2Fp+ecmWhLqezT9zmR6CzfcpwcJX0qA@mail.gmail.com>
 <20190107192648.GA10789@roeck-us.net>
In-Reply-To: <20190107192648.GA10789@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Jan 2019 15:21:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjt6oKtYuJ-EOGSO1m8vBdPa+g2_6WZ6MKCwfu4afoSrw@mail.gmail.com>
Message-ID: <CAHk-=wjt6oKtYuJ-EOGSO1m8vBdPa+g2_6WZ6MKCwfu4afoSrw@mail.gmail.com>
Subject: Re: Linux 5.0-rc1 (test results)
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 11:26 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Bisect points to commit 4cf58924951ef ("mm: treewide: remove unused address
> argument from pte_alloc functions"). Interesting - wasn't that supposed
> to be automatic ?
>
> csky does use the the removed address argument, so I won't even try to
> provide a patch. Copying csky maintainer instead.

Hmm. Interesting. The csky code seems to have some odd "poison pte
contents with ones if the address has the high bit set".

Which makes little or no sense. The "high bit set" case is for kernel
page tables, but that's exactly the "pte_alloc_one()" vs
"pte_alloc_one_kernel()" distinction.

So testing the address seems entirely wrong.

But there's other strangeness in there too. For example,
pte_alloc_one_kernel() will just write directly to the page. And
pte_alloc_one() will do a "kmap_atomic()" on the page it allocates,
except since it uses GFP_KERNEL, that's entirely pointless.

Is the alloc_pages() in pte_alloc_one() perhaps meant to use
GFP_HIGHUSER instead? Is this perhaps some copy-paste issue?

So I *think* the removal of the 'address' use in csky should be
simple, but yes, this needs a csky maintainer to look at.

Thanks,

                Linus
