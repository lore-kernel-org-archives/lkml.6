Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FF2C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7AB2081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fB+lNBqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7AB2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbeLEC6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 21:58:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38150 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEC6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 21:58:51 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so9242996pfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 18:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JOUY7c2Uvay4l5W0HFTSaetsFBVms6zdryQecubImNA=;
        b=fB+lNBqqQ/hb5g+9Nbc7C4RTlzt93A3AoESpCI47+IfshGedEtaLtAZlOL2VvM0Rp9
         oDfvmisw+Wd2tftkp0zC1iLqvfClXK1PKP15Y9+/bSKFukiyaqRXmbwl1BzK57DCENII
         zdlCZWEBDAcgqjmXziT0kbOnNH9LgO5dfkL2r7A36tnUb8Y2E/yE/L6gV6/Co7xejpiP
         NGy80WyilN/BpJxphHUr/in3Sh6QLBmP09HzDEqFJtA7UV6HtDeLfL4euiNh0usLhTti
         fCfAsljfn/dwmDdVpG6U41lhKgLOPyrGDZ7hEweL+qAvT8VwsuQ3NN+8I5JXdgDNhtZ5
         6Uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JOUY7c2Uvay4l5W0HFTSaetsFBVms6zdryQecubImNA=;
        b=UwuYNAdHKQ/Ki9rkYi3bP7V9XNT3BkVyOBsMh2m6yIip7f7LdQY2UyGd+WQFZceQZ/
         AAIqOcy6KAnkE3BxUXfJupXVTyMdiLY0aadEGsxpxe2PuNouz43Oy661Ia2lPn8EAO83
         jlUKCwYeeHPHeU/ZI5HPVBbrXUjJe14wyDEJz7pGP+CaPh4upxc92pn1bhTzuxWztatP
         juKN6gvYhQUf293DNgL0Q6A98/jQTC5eveYSwR6fmv/E9cIY4g8Qw+S/V87Da9SvcdXG
         gbpkn/ZR670hh9SLptETwdRyZPsHIULnJDaaZHerhqo9nC+GABzS7m3fwAIuGIr41JLh
         ksUw==
X-Gm-Message-State: AA+aEWbYbvdXrOVgDnZAXZt55jsfoR4vfDnTWsBU40qHZiFiJX/nfvMJ
        aMX2ZO9qlKmhV1tSS74XhP/zCQdUydA=
X-Google-Smtp-Source: AFSGD/VAEyeKyZGWnIA7ksjgOwq9LKXPRt9zpX32Ujjl/iylu8HTrO9MxGHyJ4qTUg6fZMyeC6kjuQ==
X-Received: by 2002:aa7:8354:: with SMTP id z20mr22318844pfm.81.1543978729706;
        Tue, 04 Dec 2018 18:58:49 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o13sm27533895pfk.57.2018.12.04.18.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 18:58:48 -0800 (PST)
Subject: Re: [PATCH V8 0/3] blk-mq: refactor code of issue request directly
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1542251558-10517-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <88fe68c6-886c-1328-009a-9c7c5fa4ebc9@kernel.dk>
Date:   Tue, 4 Dec 2018 19:58:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542251558-10517-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/18 8:12 PM, Jianchao Wang wrote:
> Hi Jens
> 
> Please consider this patchset for 4.21.
> It refactors the code of issue request directly to unify the interface
> and make the code clearer and more readable.
> 
> The 1st patch refactors the code of issue request directly to unify the
> helper interface which could handle all the cases.
> 
> The 2nd patch make blk_mq_sched_insert_requests issue requests directly
> with 'bypass' false, then it needn't to handle the non-issued requests
> any more.
> 
> The 3rd patch replace and kill the blk_mq_request_issue_directly.

I'd love to get this queued up, the direct dispatch path is a mess and
it's even now been known to cause corruptions... I'm going to queue
up the direct dispatch fix shortly, and apply it to for-4.21/block
as well. Any chance you can respin this on top after that?

-- 
Jens Axboe

