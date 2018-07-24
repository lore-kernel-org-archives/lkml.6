Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3D8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BE420856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t53D7gJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BE420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbeGXOr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:47:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50997 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388338AbeGXOrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:47:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so2600445wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vtCU8jr+dN2osL2yViaZuBs4gpKQC7bo/qBdq9bpafE=;
        b=t53D7gJQZPTZqMdFZiJZfwkL+iOn+vmlWCw+oDAjfzyOmWNmSqEqgj97ZGQ8xy3yBf
         nk4qcoV1lRA3VBM6i5KZW15dx4PeMh7mOQpHrkgEjaIR17wjjk1HiX9XJav54wNrVtcL
         4aVAZAfFy+OLByPJowEbpG6y9d0dxaUx8oJmzBgy0T1Exqp0PEnFAm1Dfp+Rp5hdHEq/
         /cYm7C8Bk+H81ieGAFT7swNd5xU05BKemKUFb0DkNXAQUA/DGMeUlg2whvNDhbXi/WOy
         LUZyS/IjwmrvPxxYSb1lVMF5hiw++z3CDrqoF0muaS6+KAXBjuwu1beKna3Dgn+kqqe0
         kDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vtCU8jr+dN2osL2yViaZuBs4gpKQC7bo/qBdq9bpafE=;
        b=fQFyDXJE8BJlXfw6iGVP396zFEaf31MonQ0Iw2QdQd+qjFOIdBCTplsgvXRzyAEMqM
         /kfKTAaak1A5mCNa8DdRob4eu7j2MqlcHQHpVepwcTraEufTJQJzdNaHxxlL8VLpd460
         J1UjnivJ5/fLi2/5z4Ys39p+A/1W/yzgP7CYZdUWwsqP12OytOJsHkDC5LgoWfl4LedG
         /wjcJx2d4QzpXhPDvY84K6gkZ1zoE2PlXH+0NNobTb3if+OL2dinlGmiqjIr9pfDPHqG
         7Eee9qBhPTpLuRicaXUA1f4VGXJXOe1/lgSJ1eNr/E5HV4AeJb4tn1Qn9yQrWKk7TxYn
         Mf7g==
X-Gm-Message-State: AOUpUlHYJLJxuvh+sN7jDmTSWH4+lvBy0p+YAfgku08iSp/UYv3+7/Dd
        eLAAsgFpJrvAg3W4i6ULKlQ=
X-Google-Smtp-Source: AAOMgpfLm5gSald6u9Gm7jgXH8BskC6DCflVmU5b2jEsIa4bN832ahHPh9Zjo8RvkuM5WDX2nnGxAw==
X-Received: by 2002:a1c:4887:: with SMTP id v129-v6mr1900139wma.129.1532439651560;
        Tue, 24 Jul 2018 06:40:51 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n14-v6sm1757416wmc.14.2018.07.24.06.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 06:40:50 -0700 (PDT)
Date:   Tue, 24 Jul 2018 15:40:48 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, aryabinin@virtuozzo.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        parri.andrea@gmail.com, peter@hurleysoftware.com,
        tglx@linutronix.de, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv4 01/12] atomic/tty: Fix up atomic abuse in ldsem
Message-ID: <20180724134048.GA30682@gmail.com>
References: <20180716113017.3909-1-mark.rutland@arm.com>
 <20180716113017.3909-2-mark.rutland@arm.com>
 <20180724071518.GA7300@gmail.com>
 <20180724092036.GN2494@hirez.programming.kicks-ass.net>
 <20180724092324.vnfowffsla4kja5c@lakrids.cambridge.arm.com>
 <20180724111313.GA14212@gmail.com>
 <20180724130515.ung6ox2p4rgzn746@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724130515.ung6ox2p4rgzn746@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Rutland <mark.rutland@arm.com> wrote:

> > Ok, then these bits will have to wait until Greg's tree goes upstream
> > in about two weeks.
> 
> Ok.
> 
> > Which patches can I apply as a preparatory step?
> 
> Patches 2-6 can be applied now.

Ok, will apply those.

> I guess I should rebase and resend the remaining bits once Greg's tree
> goes upstream?

Yeah, easiest would be to do that once Greg's and tip:locking/core changes (with 
patches 2-6) both got merged by Linus.

Thanks,

	Ingo
