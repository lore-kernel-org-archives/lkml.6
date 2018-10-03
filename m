Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F34C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771362089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A149lB/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771362089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJCOMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:12:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45170 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeJCOMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:12:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5-v6so4840263wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 00:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UBd7KqCJrVaJByLkWqlFYoQhqRVegS/q+o0mhSsn9tE=;
        b=A149lB/m427MSvlQJ69Pijvko/XUMjsoSAw2N6Y1M4QtbovStWDX43IjlVeZGEk6hA
         U9R/Q5mFx6Qt0cs1z1SxkkNhV/WXhzr/BkJU19nvuwc0Rl8JtBiOliAnrqdwFAh8WwV0
         8k4x5Ob6c5ET+zZO6lD4fto2DmQa0vwvTGAHXn29qBDsiNi28nPyIQ/o3lHtcX1DtjGS
         CUCpCHkAxSekuy86rb91bMK+D8NLmfLQGB9kNst62wRJ8VluLCKkree7dUoHQZh8XrVa
         3uf2fLHH7siIZk7hxdXzgbfrw+0Y9asCt3vW+hMbxdFiJVTRE0norNYhImEtFF5HfFBV
         Hf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UBd7KqCJrVaJByLkWqlFYoQhqRVegS/q+o0mhSsn9tE=;
        b=A2DrSSOWq+dz0Dl4Ogr3RML9/fyJLsVRixV3s3KdAzUpb67lOLjDk5LQoc2qBZgd2O
         TkxN+5tY5ST3WHaYUwnYJ+w0m1KVKl3DXJftJ5fUGiPVi/sxqnQHMM9sXyVS1hv8aYob
         T1O1vAFzIwbc05nypJNzexnQ+JA/U5DCalGAL9WgiquI/zyftfs6hdox1oY1mtVlBssM
         90enUL8w1E0gkzLVqpgw4DXLVI6JOMCBVPeHMIAScH5czLj8kz2NZPynbtJKoMoAKuXf
         GPda3I+yo+z3lPkVjt85DNKg9RETIpgVJSsM8EYNfz7TurDg4XnARWTvyQ0QFvVfnh+d
         OuwQ==
X-Gm-Message-State: ABuFfoiM0OTMDOyIH05AaJz537EgTqIMh5vLfzOQI9uQao7y36EDSEpr
        VLE+ODrsjnQKiJuhJyRURTY=
X-Google-Smtp-Source: ACcGV61FvmYgWQPaytrxtFyK79a8YmDRkIO0qgOcGUv/oBNDX0ledGTjejRe1LQnrpA1V7tHvZEWhg==
X-Received: by 2002:a5d:6902:: with SMTP id t2-v6mr159251wru.323.1538551531747;
        Wed, 03 Oct 2018 00:25:31 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v16-v6sm333007wru.31.2018.10.03.00.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 00:25:31 -0700 (PDT)
Date:   Wed, 3 Oct 2018 09:25:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [Patch v2 4/4] x86/speculation: Add prctl to control indirect
 branch speculation per process
Message-ID: <20181003072528.GA98965@gmail.com>
References: <cover.1537920575.git.tim.c.chen@linux.intel.com>
 <ae3fb86f74de2001ddab477579afd813bca9baa9.1537920575.git.tim.c.chen@linux.intel.com>
 <20181002093530.GC122128@gmail.com>
 <20a42fd4-0026-c30e-1d82-4a345f6257cc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20a42fd4-0026-c30e-1d82-4a345f6257cc@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Tim Chen <tim.c.chen@linux.intel.com> wrote:

> Thanks for the corrections.  I'll update the patchset.

Please also go beyond the direct review feedback me and Thomas gave, and pro-actively look out 
for similar patterns of mistakes in these patches and in all future patches you send.

As Thomas's and my review made it abundantly clear, this patch series has a very high 
proportion of small, indefensible trivial quality problems.

If the root of the problem is that you are sending out patches too fast then please *read* your 
own code and changelogs more than once before sending it to lkml, fix trivial mistakes and 
coding style so that others don't have to waste time over trivialities.

If the root of the problem is that you don't have enough time to spend on these patches then 
you should perhaps delay your next series for another day or two, use more time to review the 
series, before sending it for an upstream merge.

I.e. please make a serious effort to improve patch and changelog quality in the future.

Thanks,

	Ingo
