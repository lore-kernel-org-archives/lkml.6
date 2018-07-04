Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E2CC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E8A208E9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="M3JAvCIW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kCzkeLUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E8A208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeGDQwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:52:38 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34940 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbeGDQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:52:36 -0400
Received: by mail-yw0-f196.google.com with SMTP id t18-v6so2117645ywg.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 09:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rnr3r3bnvBwy7O5yFM+DVVe/0EDnKkyK9pRWngXA3rU=;
        b=M3JAvCIW1c4RAsDqH5N/m8Fjd5LmaQ4gbcnBbMKjJeg5v/82vpjxs0cS0YQaJR4Kyw
         1lAxqKtjAj6Ul7zfRfAVv1m+2/WEVBwE3hLTXAKwhZUMnaEI9Q/ErEj5elvpTyYxwuw9
         H4vlmjhYd3e8Q8voDUjaulRRB47LddgUetmG/HiWqfUGIUbFVZuTGPGKxN/I/o3v1mlK
         nlGmkFRK8QGtOvi4DE+aOAy7VIfHdtW9iA/yl6u5q7ZYLodptGYW3DrtqXlLFcfhrb48
         UeYbvzATyXd0m2rZIBo7dGb+ADKFLrLcYp3jhmwa0p2p0ePDgdCQY5k8Ji2zdTH0hqQF
         w4IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rnr3r3bnvBwy7O5yFM+DVVe/0EDnKkyK9pRWngXA3rU=;
        b=kCzkeLUuXyMb/3clOqQN3BGYq65tFJ6P2JgiUROamv4efod6qlHAIBW+XqVafmPJER
         DrVVkBc3a/52yjtd7L8Q3QyGJFCH9MNXARZgkIof67eGLFOX5kv06OCt4R7mNw56jynV
         2iNK8x9qWwp8qlYOGFC8bmpf35xWrz2bDplPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rnr3r3bnvBwy7O5yFM+DVVe/0EDnKkyK9pRWngXA3rU=;
        b=LZu57ghArGY8aBCsCKW9Ah4IpK5IFMd9obcAL7UapukC9XnBvUrWlbpUzDw9qvArgE
         PCjPOhC0xDIbShwhjfDZCHAegSSHE3pFwr4Zeb+fyn41Y1VY78EvxTUntA+Ef/0J3LYY
         NYWVaAJkrfIc7dPQCgTga2sU0vvRtclqeVwzmViFJc4w4d+x4rMq+tN0dghwQpyHdQmJ
         skKqanQuIGQjV1N6mDzbZzRUXORbzLnxGYr6MhBvK3NZac27bQM46aqEm1KAxRVslk17
         sGl8l7TfU4AsyrpmMr/9hRLYK54aPCrky/K7UIiMViXc7n3crA60R7K7xhqf9/4fB9tk
         t9Jg==
X-Gm-Message-State: APt69E2Ph0+4XbDJlwnfY9N/vq4dLoAPBaMWFqUImT6cQW3xEBtWFHFV
        utSse+5p7fQFdjWU4ZBqd00YNlu3wVGhsKfFlQt1og==
X-Google-Smtp-Source: AAOMgpffmdlU1RxpPLadLZHqnjUFrLPUj7cJs4ncShQZKo5uHEyNHbo0JOcpSKd5iyuz+E7Z/s5K9pjvyTLLtXQ0424=
X-Received: by 2002:a81:4a05:: with SMTP id x5-v6mr1352293ywa.116.1530723156031;
 Wed, 04 Jul 2018 09:52:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 09:52:35 -0700 (PDT)
In-Reply-To: <b1bfe507-3dda-fccb-5355-26f6cce9fa6a@suse.cz>
References: <1530646988-25546-1-git-send-email-crecklin@redhat.com> <b1bfe507-3dda-fccb-5355-26f6cce9fa6a@suse.cz>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 4 Jul 2018 09:52:35 -0700
X-Google-Sender-Auth: az72PxcyLWzRILUYE2JUtFYGyzI
Message-ID: <CAGXu5jJa=jEZmRQa6TYuOFORHs_nYvQAO3Q3Hv5vz4tsHd00nQ@mail.gmail.com>
Subject: Re: [PATCH v7] add param that allows bootline control of hardened usercopy
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Chris von Recklinghausen <crecklin@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 6:43 AM, Vlastimil Babka <vbabka@suse.cz> wrote:
> On 07/03/2018 09:43 PM, Chris von Recklinghausen wrote:
>
> Subject: [PATCH v7] add param that allows bootline control of hardened
> usercopy
>
> s/bootline/boot time/ ?
>
>> v1->v2:
>>       remove CONFIG_HUC_DEFAULT_OFF
>>       default is now enabled, boot param disables
>>       move check to __check_object_size so as to not break optimization of
>>               __builtin_constant_p()
>
> Sorry for late and drive-by suggestion, but I think the change above is
> kind of a waste because there's a function call overhead only to return
> immediately.
>
> Something like this should work and keep benefits of both the built-in
> check and avoiding function call?
>
> static __always_inline void check_object_size(const void *ptr, unsigned
> long n, bool to_user)
> {
>         if (!__builtin_constant_p(n) &&
>                         static_branch_likely(&bypass_usercopy_checks))
>                 __check_object_size(ptr, n, to_user);
> }

This produces less efficient code in the general case, and I'd like to
keep the general case (hardening enabled) as fast as possible.

-Kees

-- 
Kees Cook
Pixel Security
