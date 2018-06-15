Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCDFC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF492208E5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSE3zWOB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ocallahan-org.20150623.gappssmtp.com header.i=@ocallahan-org.20150623.gappssmtp.com header.b="jNX4CpIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF492208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ocallahan.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966155AbeFOReq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:34:46 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40381 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965916AbeFOReo (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:34:44 -0400
Received: by mail-lf0-f65.google.com with SMTP id q11-v6so15743033lfc.7
        for <Linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 10:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jNSMR4jKCe5vKwrCl3MoVcLAW8SWBGV0SaUDPRWevNQ=;
        b=oSE3zWOB7LTrB2JroHrDyEuW3lDX8n4DZK+XFKjklfk+0GJ5lUk/pUgPfrRDyucL1q
         XQ+mPy/Dn2j+Rvg4ETQJQYuZsvxGeMx5fEnTY+/9/XLxgPIu2D0VfPfVWOgzxlK82AMg
         fvw0rHg3ulU8r2DPDk6GHnU2d+f46qjye9bolkyl9TR2JnB8SHFdTsaq2P2VdK+06oCA
         xrvGF75gfNitMoO8Pw9j7Ive0No0WQlUIljyE61/YPxn4zyvvDq4QcrhJsSGmQzfU9wU
         W0D4fPfmq+/3E26QvBZy7/F6dOz6fcqkRald9GQO8O+BKQsoc2LCeb+D9PQXB4x+mSXL
         EBQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ocallahan-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:reply-to:sender:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jNSMR4jKCe5vKwrCl3MoVcLAW8SWBGV0SaUDPRWevNQ=;
        b=jNX4CpIuylRbjQUfO8rNz8LIIIHLbpFxlT2dj7smC3lIo4QrDA5uAihWldFEeVs15J
         w0YHCTYzMDLnU2LWtNEIAQiczOtDrHpgxDgu293ev1CC1/BfRLMLzO/Ksk5DgWEwUHGl
         OuT3AksNoqlpbCNUD/R6DvfXtx+7D6iqCjujIopx0dCERK8/JarMhFUSvUZ7QxcQ34Tw
         gPgROO3Kwj0WbA4EArMCdlpxACzfQYsSfrq2R9TAEOnyIIO9YgR6jtOIFSCXugkXHjAz
         RN7SeUQWj5iJiOw7Jyk1/4bpBNUGE65hiQYl+nOVbDPWRG6T+jm6+/R16Y3+zU1zevLu
         jOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:in-reply-to
         :references:from:date:message-id:subject:to:cc;
        bh=jNSMR4jKCe5vKwrCl3MoVcLAW8SWBGV0SaUDPRWevNQ=;
        b=puJuWusWEGDwQ0WSwTpMMmoYsTubGanNseEwJ+B77974E6X5lOJz+J6a6VhqrlHoji
         CxWjjx1PBYz8oL3ezDs9yt1gpYMN+Kou7ZFZCuYo3leEE2zTMkNCLKdUJWv6uvRFWll4
         9iSPYnwOsbDw1blaa85nqFMLr0QmxkWWx30Hiepe27o9xpUUwdNiOI7T+TXTQEN2VYi2
         5GfEscc0pp082GJLxKjqPgSwSnekmtt+8yK9C7Xw+tg0ZpIixfZI/AMEnRqDGDJhiFCv
         PKczpzCzD5zDhcquNfHkNbqctqSYXzHJzoV1K7NGquVNOFBFTOaXDCfKH3kkf9s/XsHS
         zA5A==
X-Gm-Message-State: APt69E04TX6MagAiT+ScytrixVcnSzIWLxqwMgJWhl6w+xrfidvpAdDw
        Gy5bTjnxgj9QbAL9TJkT5K3LYLHH5wPRm9deY+s=
X-Google-Smtp-Source: ADUXVKImhDBkq4NOKq+M0eOB5baMwtV3emIQNnjqp9r2scawQNnkY6RzszeqzyIJg5DV5UVQ0lGnabW+6ImqN3msqeM=
X-Received: by 2002:a19:f71a:: with SMTP id z26-v6mr1677498lfe.137.1529084083243;
 Fri, 15 Jun 2018 10:34:43 -0700 (PDT)
MIME-Version: 1.0
Reply-To: robert@ocallahan.org
Received: by 2002:a2e:2991:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 10:34:42
 -0700 (PDT)
In-Reply-To: <CAP045ApFKUqUUf76GtWyxpYWdWe1RxYkPm1R2kUxaQyc4Fhucg@mail.gmail.com>
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
 <CAP045Aq_FEc_pEeRL86uXbOLBeW7aPvTqtnaq+Mbi-2=vp2BNA@mail.gmail.com>
 <1a442b37-7a97-86f0-11e3-58d940ecfbc9@linux.intel.com> <CAP045ApFKUqUUf76GtWyxpYWdWe1RxYkPm1R2kUxaQyc4Fhucg@mail.gmail.com>
From:   "Robert O'Callahan" <robert@ocallahan.org>
Date:   Fri, 15 Jun 2018 10:34:42 -0700
X-Google-Sender-Auth: 6KFBjjsvobhNeNDFnxkuLr-ce_s
Message-ID: <CAOp6jLadgwdiW+1BNFFhNSBD-i1ACju4PeuozxvD26Mrekwd9w@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] perf: Drop leaked kernel samples
To:     Kyle Huey <me@kylehuey.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, acme@kernel.org,
        jolsa@kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        open list <Linux-kernel@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Will Deacon <will.deacon@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 10:16 AM, Kyle Huey <me@kylehuey.com> wrote:
>
> If you want a sysctl for your own reasons that's fine. But we don't
> want a sysctl. We want to work without any further configuration.

Also toggling a sysctl would require root privileges, but rr does not
currently need to run as root. Thus rr users would have to either
permanently change their system configuration (and every extra
configuration step is a pain), or run rr as root so rr can toggle the
sysctl itself. Running rr as root is highly undesirable.

Rob
-- 
Su ot deraeppa sah dna Rehtaf eht htiw saw hcihw, efil lanrete eht uoy
ot mialcorp ew dna, ti ot yfitset dna ti nees evah ew; deraeppa efil
eht. Efil fo Drow eht gninrecnoc mialcorp ew siht - dehcuot evah sdnah
ruo dna ta dekool evah ew hcihw, seye ruo htiw nees evah ew hcihw,
draeh evah ew hcihw, gninnigeb eht morf saw hcihw taht.
