Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11384C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCC52086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="FVCq2GVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfBAQ1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:27:31 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36455 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfBAQ1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:27:31 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so8164227qtn.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 08:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=pRZZUXZSg38Qd8VtFnk8T/+H5PX1R+wzPWTP9J58cD4=;
        b=FVCq2GVALJVyqDZESFxw1tB1TyVrTn5fkFkzbCwujuj1vjlvC3PfkKeKzt4XF2ayBv
         qGcnHO+YOEQg0Xw6O4GiUibnmZwac+yONQiMqphYBf5ivoc+tTQh3Z/9X5KDUN6N4LH4
         3LbtA4yCBzurBgPaBI/XhKwJRA1OuMY/NAUHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=pRZZUXZSg38Qd8VtFnk8T/+H5PX1R+wzPWTP9J58cD4=;
        b=E3qdsnCvK8T20IC2zYJT9ek+RDmtYwJ2olr8Rewtbq+AsdKzU1t4Y7o8umPtB2qrQf
         Af64iq4YOcaPUbC5LPx3zOJniiQT7hvHCSlRXbNfAzE8xxRBHeG/fb+hqI50JTfDKyFa
         Jg9vhW9g8EpuWpG3hHFdu1396cPNzQs/dIIV3VreEXCMukaR37s5JhgSJXArv7adhUgL
         gzm3nfR/BdiCXBKFZQHA+BbjQfOc1XEQeKJO8fVc2NSm8uyqbnTf+7H6ZlpbSwT58quN
         pM/IGvHwViDE7GDUOoILphTg/wGorCOxRFLtFS/U2wjKxNkbeqO/0IFzJ2LM4keMXEEC
         QHrw==
X-Gm-Message-State: AJcUuke2vwdhosj6fY9fSP7ceAjao4snhXMFhT8FNYJnSdW/iQfPaiKJ
        5QH5WC5R8WHPy8JbmTAxQY7yBQ==
X-Google-Smtp-Source: ALg8bN7kNUccr6m3zqVRmxVu3bfCD48UEaHJCmv1cB9xha0ohdqelSY7sj4cwist1U2CykREXQXqfA==
X-Received: by 2002:ac8:326a:: with SMTP id y39mr40062978qta.175.1549038450670;
        Fri, 01 Feb 2019 08:27:30 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id a20sm7656595qkj.28.2019.02.01.08.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 08:27:29 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Fri, 1 Feb 2019 11:27:28 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     Jiri Olsa <jolsa@redhat.com>
cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, eranian@google.com,
        vincent.weaver@maine.edu,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
In-Reply-To: <20190201074353.GA8778@krava>
Message-ID: <alpine.DEB.2.21.1902011125290.25915@macbook-air>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com> <20190130183648.GA24233@krava> <20190131082711.GC24233@krava> <20190201074353.GA8778@krava>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019, Jiri Olsa wrote:

> with attached patch I did not trigger the fuzzer crash
> for over a day now, could you guys try?

I've just started fuzzing with the patch applied.  Often it takes a few 
hours to trigger the bug.

Added question about this bug.  It appeared that the crash was triggered 
by the BTS driver over-writing kernel memory.  The data being written, was 
this user controllable?  Meaning, is this a security issue being fixed, or 
just a crashing issue?

Vince Weaver
vincent.weaver@maine.edu




