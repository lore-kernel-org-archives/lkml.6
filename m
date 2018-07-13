Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00880ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0976205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iqm6CcXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0976205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbeGMOfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:35:33 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37840 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbeGMOfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:35:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id v9-v6so14339278ljk.4;
        Fri, 13 Jul 2018 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Np6NhRUaEsDLzElNLyTxhaAmkhOTvkgfophVfxrGguQ=;
        b=Iqm6CcXYyV5V0SMZWWip2WgNuHwJ/+7/2WoWZUMnn/ycY/UWBK6iI6Ldpm7RY2k/25
         LGC+C7+d6QAOAvrvbWUheyJoPk0qI4CUU+glMo/cv7CoAzBOmR6gp+7jtHv/dDHCWxBu
         4GQCa5aQ8m9xlhW7LfavhXZ/NfsWAg3YdZLQpx4QmAFVbG3ypSI07YgHIhyQDsJIdh8B
         YAKsYjUPf5l6zV4HZYpEd0Ga3TSBrebUx7jHioMukdR3Niz60roRMueOunXg8JeVWmT3
         1+Wy3ew8s+GT6osNb1P6cEK6tHjemc3lpRWQ7ajb43mI2fI6D+ZJ+Qf0d2KtpyNPIiG4
         BZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Np6NhRUaEsDLzElNLyTxhaAmkhOTvkgfophVfxrGguQ=;
        b=JbKzAiYqsgoT6/XS75Fw761IkS+q2/FJ3WBV+QDbDdnzd3+ZSq/mHCskvUEYGFncqw
         RBZpEfltD8v9DnmSOcm5moY9pqhPVNC8ZdpIp5SlWSOxLmNYVW/eM7jAoaIrhPPoMy6R
         CJZ63Eku3EbGpKg7X/yd6+T+NZpLPF4D4sQSsXxLXUnj5RbTCH/t+AG2xMSHzaKFcgjZ
         A893U7L/DIOH/wP45jyy06HRmBpIwx1p3+Lw1Xmb6DYcBI8Xr+lw3vqtIYLcc5sQJrDD
         e4EKa1he39XoVddYAjKoVA+D54CFN0S4PhJMg6XMhUmWIcx2gLgkRrF10MmxaNWYnN8N
         q80g==
X-Gm-Message-State: AOUpUlFyHE/06vbqVm5FgVS+RrRBj5XznKz7AQdqRuo7grJfEY3pi4BH
        cgAimdl9rzQwaaSu+s9Bj15Ycp7SBjEw7SzDKrc=
X-Google-Smtp-Source: AAOMgpcessiZ5AWiKELe/ciTnuh5mFGoog1RZsQ9LBaeCiwK6DJjjIW79ELMYJkzVRQ1gYXrG4xtgr868cQ7eWGZ2Bk=
X-Received: by 2002:a2e:40c6:: with SMTP id r67-v6mr3563643lje.41.1531491640532;
 Fri, 13 Jul 2018 07:20:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 07:20:39
 -0700 (PDT)
In-Reply-To: <b5de0a86-b3cd-9e45-ac39-9c4eb7611016@suse.de>
References: <20180622134907.227131-1-arnd@arndb.de> <b5de0a86-b3cd-9e45-ac39-9c4eb7611016@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 Jul 2018 16:20:39 +0200
X-Google-Sender-Auth: zIqbbJDbUYnSNkLWXuu4ySGyOEQ
Message-ID: <CAK8P3a3FULT7uakRyZ4Nfq3E-ij+Gkn06=XP4Rn2m9u4Wd2OWA@mail.gmail.com>
Subject: Re: [PATCH] [v2] bcache: stop using the deprecated get_seconds()
To:     Coly Li <colyli@suse.de>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Michael Lyle <mlyle@lyle.org>,
        Tang Junhui <tang.junhui@zte.com.cn>,
        Hannes Reinecke <hare@suse.com>, linux-bcache@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 10:12 AM, Coly Li <colyli@suse.de> wrote:
> On 2018/6/22 9:48 PM, Arnd Bergmann wrote:
>> The get_seconds function is deprecated now since it returns a 32-bit
>> value that will eventually overflow, and we are replacing it throughout
>> the kernel with ktime_get_seconds() or ktime_get_real_seconds() that
>> return a time64_t.
>>
>> bcache uses get_seconds() to read the current system time and store it in
>> the superblock as well as in uuid_entry structures that are user visible.
>>
>> Unfortunately, the two structures in are still limited to 32 bits, so this
>> won't fix any real problems but will still overflow in year 2106. Let's
>> at least document that properly, in case we get an updated format in the
>> future it can be fixed. We still have a long time before the overflow
>> and checking the tools at https://github.com/koverstreet/bcache-tools
>> reveals no access to any of them.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Added to 4.19 for-next.

I noticed this isn't part of linux-next (yet). Did it get dropped?

      Arnd
