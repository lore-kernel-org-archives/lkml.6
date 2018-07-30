Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7092BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260D020894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WboBz+bi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260D020894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbeG3ToJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:44:09 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:40154 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbeG3ToJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:44:09 -0400
Received: by mail-yw0-f195.google.com with SMTP id z143-v6so4714906ywa.7;
        Mon, 30 Jul 2018 11:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bcmzDygmGzmRfPe114L0/zYL4+ydIfyVDgGHoeXvqWI=;
        b=WboBz+biF9TN9se9aAMhuir7sBAMJI2lPv7fW6Hel6OMJuv2FCjQ6oL0SdaNYmfis6
         PwBOeJItpMAoHbuNqL+tSrMrGhNgoi09mV8Van+fsxGxvHbkYm30JH2YilaGEmz6fQv+
         GTRUUY6IkvXm0MwKdgl069lhl45I8gV9Mxq3ll85tOHs5CERaa3AKHF7+4Kc+wejHB8U
         HEdD9DGBrP8yG44csz9B7WlqUTi5NKWAm9wHZHol/bn+L07rN667pHr5WaGU6cQUt/Tw
         H44igUGMMGQ8mEyjD8Dt2qLLaRHFoDqR12ys/iUI3niDMPax5Fb2LMWJ99MJHLz2JsPF
         P/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bcmzDygmGzmRfPe114L0/zYL4+ydIfyVDgGHoeXvqWI=;
        b=gtF0Qizq2wB/bxchyYf6B2XtwBI1rt7/SeU06CEjUphndd+uI1J6Tz1UiFxqVTAcrt
         QepDNC+e1xzEIBmZA2OTUshLVO7XP1Qj66mvQcy2XcLeJ/JA8abSHLx5l7732+BLk9UB
         0FrwEP0os1J5DD0hqBYF2/JwPtQu7objCIJkfL35NpKbNJzi1YCgfH+35L1gCL4izt/K
         jX1JW25MOq/DH6MGc5vfquDMDFasB1jaz0o44ZHshxFHxRz81WZSuIWcJHox/ytHS9Ih
         EDO/D9K/hmN46KiVLaPZg3dymB3RJrR5k3QDyqLjPZRj3LyvYixhHuhqo6y13kVms3PQ
         GQZQ==
X-Gm-Message-State: AOUpUlFH8QfgI4XPP83cTIkpqchFgdleriAuNepRcOTiJYkY2lop7NaO
        QsEFmvNRPc2bMfNkEuzZqG0=
X-Google-Smtp-Source: AAOMgpfWYSW2jQQNBbWFnSLbYyMTPHXnkqPop12J1CTgwSnDsJ1mjGWbaxV8JWGR7m7FikTkb5J9XA==
X-Received: by 2002:a81:a20d:: with SMTP id z13-v6mr9615941ywg.412.1532974078226;
        Mon, 30 Jul 2018 11:07:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:4bfe])
        by smtp.gmail.com with ESMTPSA id g31-v6sm8039000ywk.84.2018.07.30.11.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 11:07:57 -0700 (PDT)
Date:   Mon, 30 Jul 2018 11:07:55 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/10] psi: pressure stall information for CPU, memory,
 and IO v2
Message-ID: <20180730180755.GM1206094@devbig004.ftw2.facebook.com>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180727220123.GB18879@amd>
 <20180730154035.GC4567@cmpxchg.org>
 <20180730173940.GB881@amd>
 <20180730175120.GJ1206094@devbig004.ftw2.facebook.com>
 <20180730175936.GA2416@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730175936.GA2416@amd>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 07:59:36PM +0200, Pavel Machek wrote:
> Its true I have no interest in psi. But I'm trying to use same kernel
> you are trying to "improve" and I was confused enough by seing
> "CONFIG_PSI". And yes, my association was "pounds per square inch" and
> "what is it doing here".

Read the help message.  If that's not enough, we sure can improve it.

> So I'm asking you to change the name.
> 
> USB is well known acronym, so it is okay to have CONFIG_USB. PSI is
> also well known -- but means something else.
> 
> And the code kind-of acknowledges that acronym is unknown, by having
> /proc/pressure.

Your momentary confusion isn't the only criterion.

Thanks.

-- 
tejun
