Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A58C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3928C20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAyStXIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3928C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbeICXX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:23:59 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34135 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeICXX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:23:58 -0400
Received: by mail-qk1-f195.google.com with SMTP id d15-v6so924235qkc.1;
        Mon, 03 Sep 2018 12:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hlS8XGh3x013zvCvg60lUUWQcmYOelts13vbCnWoyyI=;
        b=OAyStXItgn5jQWxFn/tIGyNepkxL4uMpIqL2AR6N4lSjANM0YaTVoKkFXoKhzwfoXP
         Wg1CcwNxvkQ2ZVzA7Ogs2B7ISKguOyNT9GnSsC1fWGta8CsgOpx5xKeACaA//hzgHlIx
         xMgRHQpsEh8VXBKFxPKuqY3Tx++CXbuwp9pnhhMS43AyPPUJ7zxwxg2NnlXVG5PIfWLB
         WQIDeA/ElzGJXKtNTnMLZlG8IR9KAlhPcW3OlDpoNCdCQGBJtr7LAPFvDgmo6cZ2/rbp
         hMcLQEdNo/BdP3snHMszshrAJjxFsAaF/Ory1/3FiMYbQRSEn0sSoUOiZv4qUsUWygPT
         ns7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hlS8XGh3x013zvCvg60lUUWQcmYOelts13vbCnWoyyI=;
        b=WjeQLkGBieZ0d5GcrnHAIlL4szG/sB6u8PF1K9v7U6YhetsHfFc1UfUISBGnaRX54e
         R/aw1gezLJGMTv0pYId2RzQTIoSJkERwxkqXX4i9rJRFywLjWmbbfe0nSAI8uim1+5Xg
         kMYwoIpBRSleYD9kG9hGmgoHncmZj1fUAfrcaXaq0kFh30JPPdU+SbqOU7yzOnMCCk5A
         IeNt238gFewLvCeYWStC6EvKwLt1520CmV+Wssg0ouAOpatlTKlEc+Hoorb1JkL67QNJ
         V/mp3efxrvW+ZEgVHXw0sAc+ePvCVRQ4F1UVmglExTS5CPoVdzuKooaFFoFyMrT98GvJ
         AF+Q==
X-Gm-Message-State: APzg51D2x7VlVXZWgzSYcglwmvBKaWLU0U48v0d5UkkqnzKxdCxNhem8
        3UgXxA3f/+22hF1dk9uvnbjCtBt8V/NkAYEfHqM=
X-Google-Smtp-Source: ANB0VdZ24zbmd1aOJ5OhMntlZcuboRaFkTFYRMqRc2HB2e+5eUBrRuQ4ERiJEK/wSpqHh3L7DsD5JfoKmNpVZPHYwK0=
X-Received: by 2002:a37:58c3:: with SMTP id m186-v6mr12392038qkb.119.1536001347423;
 Mon, 03 Sep 2018 12:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com> <20180827185507.17087-10-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20180827185507.17087-10-jarkko.sakkinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Sep 2018 22:02:16 +0300
Message-ID: <CAHp75Vf39J8U3VnmxP+BBYi7rqzidxdD58Yx_fdnLXRro_QBgg@mail.gmail.com>
Subject: Re: [PATCH v13 09/13] x86/sgx: Enclave Page Cache (EPC) memory manager
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, suresh.b.siddha@intel.com,
        serge.ayoun@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 9:58 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> Add a Enclave Page Cache (EPC) memory manager that can be used to
> allocate and free EPC pages. The swapper thread ksgxswapd reclaims pages
> on the event when the number of free EPC pages goes below
> %SGX_NR_LOW_PAGES up until it reaches %SGX_NR_HIGH_PAGES.
>
> Pages are reclaimed in LRU fashion from a global list. The consumers
> take care of calling EBLOCK (block page from new accesses), ETRACK
> (restart counting the entering hardware threads) and EWB (write page to
> the regular memory) because executing these operations usually (if not
> always) requires to do some subsystem-internal locking operations.

> +                       list_del(&page->list);

Is this page will be completely gone? Otherwise it might be needed to
reinit list head here as well.

> +       WARN(ret < 0, "sgx: cannot free page, reclaim in-progress");
> +       WARN(ret > 0, "sgx: EREMOVE returned %d (0x%x)", ret, ret);

I'm not sure (though it's easy to check) that you need sgx: prefix
here. WARN() might take pr_fmt() if defined.

-- 
With Best Regards,
Andy Shevchenko
