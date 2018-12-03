Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90D1C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEF920864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcA5SClf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AEF920864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeLCX2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:28:10 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:47057 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCX2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:28:09 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so7239056ply.13;
        Mon, 03 Dec 2018 15:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=90mpTy6OIEDyBwxEjIIVh8r4GI2FCyjYZ7w+yFVs5K8=;
        b=ZcA5SClfyjxrRiamd0Vtenqzj4xwLZLc5I4j8HEPZQp1n3t3wGairW5ZiC0zqYnqQW
         H7Z6RwH9QjtaLI8zp18dzmQ5SKKpfnWFYSVCbiqkDzlqVmE6La4yUFYokn+UGAv4YBC7
         kmMIIRTwJlA6eK51v+1XJWJUJdGiKAQ2Qs7LOthp+OSPgALPPdjJiL3ODfULhI/2e4UX
         n5HubaC8IEREV0/gaH9s+QAixSPH0IEmtTtZCt1sq0IVu43skUvG5K+pVFsQW/Ai23Se
         q/ROM0RoZ/UYKFnNjHUZrLHztfAB95FbPJLy8VHvdBswDPtDzX5Mm4q8YtP18SvBgtb0
         U/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=90mpTy6OIEDyBwxEjIIVh8r4GI2FCyjYZ7w+yFVs5K8=;
        b=MyvaBfnNHmhqdeOk+LTYNgJ/70neAXA9/nIJrYWr7prVeB6i+EywjJxOH3QyHwUw8r
         Xcd3mLXQpB3lYH8RXXm6ugjfvXdkAmLdO7xCYN/qf+wZXM7GGav4/KKUIMOhZbYJ3wsB
         898EseQrIb/vV+C2aIdkzNNxK8dzbQZG5H2geE9TR3Cpgm0yqk565nCxg9cCG2OnUlmK
         llIyJJqgsfjDki9oHv0GaErlvjIOdjaVHOWDC3HyB2b82cFBhVA6KMvgqfb2mcJJ/aVv
         SZEQhmQbfyT6trHhU5IzuRfafqjti2wMu5g2zf+AZVnhB5pkVhInAbixKY9LfzkTPa04
         XQpQ==
X-Gm-Message-State: AA+aEWYv6bJtDLkSGWKrDDhfBNBlRelq5r/5YctCZEgjWbPC9gRDFkwR
        9SiasO46dGltg5eAbnHEhD8=
X-Google-Smtp-Source: AFSGD/VhTHe5JXxE6wDdnwVoqSvUVBkHafqHfWYifvECp+pb8Czh0UJVjDdnq+RXGIV6phrVx3bLvw==
X-Received: by 2002:a17:902:d905:: with SMTP id c5mr17319635plz.43.1543879689048;
        Mon, 03 Dec 2018 15:28:09 -0800 (PST)
Received: from [192.168.11.4] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id q5sm23236509pfi.165.2018.12.03.15.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 15:28:08 -0800 (PST)
Subject: Re: [PATCH memory-model 0/3] Updates to the formal memory model
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr
References: <20181203230411.GA27476@linux.ibm.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <802d5c17-74fd-86a1-efba-5ee2825a0c3c@gmail.com>
Date:   Tue, 4 Dec 2018 08:28:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181203230411.GA27476@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/03 15:04:11 -0800, Paul E. McKenney wrote:
> Hello, Ingo!
> 
> This series contains updates to the Linux kernel's formal memory model
> in tools/memory-model.  These patches are ready for inclusion into -tip.
> 
> 1.	Model smp_mb__after_unlock_lock(), courtesy of Andrea Parri.
> 
> 2.	Add scripts to check github litmus tests.
> 
> 3.	Make scripts take "-j" abbreviation for "--jobs".
> 
> There is another series in preparation to model SRCU, but this series
> requires hot-off-the presses changes to the herd tool that have not yet
> been released.  This SRCU series is therefore targeting the merge window
> after the upcoming one.  People wishing to experiment with the prototype
> SRCU model may obtain it from my -rcu tree at branch "dev", and use
> a bleeding-edge herd7 built from https://github.com/herd/herdtools7/,
> version 7.51+2(dev), which is (commit 10403b24070c) or later.

On the master branch of herdtools7, SRCU support was added in version
7.51+4(dev), which is commit 6ec9da1f4d58, or later.

        Thanks, Akira

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  .gitignore                 |    1 
>  README                     |    2 
>  linux-kernel.bell          |    3 
>  linux-kernel.cat           |    4 -
>  linux-kernel.def           |    1 
>  scripts/README             |   70 ++++++++++++++++++++++
>  scripts/checkalllitmus.sh  |   53 +++++++----------
>  scripts/checkghlitmus.sh   |   65 ++++++++++++++++++++
>  scripts/checklitmus.sh     |   74 +++--------------------
>  scripts/checklitmushist.sh |   60 +++++++++++++++++++
>  scripts/cmplitmushist.sh   |   87 +++++++++++++++++++++++++++
>  scripts/initlitmushist.sh  |   68 +++++++++++++++++++++
>  scripts/judgelitmus.sh     |   78 +++++++++++++++++++++++++
>  scripts/newlitmushist.sh   |   61 +++++++++++++++++++
>  scripts/parseargs.sh       |  140 ++++++++++++++++++++++++++++++++++++++++++++-
>  scripts/runlitmushist.sh   |   87 +++++++++++++++++++++++++++
>  16 files changed, 757 insertions(+), 97 deletions(-)
> 

