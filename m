Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06095C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C088720645
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YtL+EwUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C088720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389730AbeKVHiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:38:51 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35847 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbeKVHiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:38:51 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so6098164ljk.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 13:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2FLqCXOyFZi+3IhFGBNL24MV4Nu1yl0RsBN0XLphHCA=;
        b=YtL+EwUx/sW9MqyuXyqlwr9f/WRewx10L/SakkpynaIhg73Fc2NokWs1hPhXj0qWl7
         dXsEdmjIvApz0gM4KLKNRXDRtOTC+9qIgEd4ZjGS25GZRNrhCG/irqWXZiu1klNjwZ58
         1pWyzg3S1ZJ/luc+dGIxuPuB9ksn+UN/7IK/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FLqCXOyFZi+3IhFGBNL24MV4Nu1yl0RsBN0XLphHCA=;
        b=lhWd9L9EPIUsKmTllekf9BB2Zk/ksGWDozVj/Ct4iadMkohF5RBvGpdbympIefmRJI
         oS9VxCpJ1TncJMyE7Wgf/qbibVf86/zY+2jgIkDu9OjykXGD3r0Bkpgmp8EYRTe/2haF
         jPPMpfoJ6WWz7cv6pIxNaTbO54XRYtNLOopHJjGvTs9A5WoSd68sq+MVSLQaZxKAjtC5
         1RwDMBj6j9bC/PEMi1OjYrESZZgHyNWzZkrv5+1CSs/6IR5E5kVTe7y1r3hvmlU37f0L
         XS8126pXCwoHiFhrT+dPXDP1PVO5bVEMkLQjZpDcmSwJxAkRDsfegPVp1NIvw3+pCcp7
         Ap/A==
X-Gm-Message-State: AA+aEWbko/see9RL4N8wllXTlNK8IhXcCYW0pmW8dONPtyRoy5Yaw/xx
        PKr5JMRoWHkE2X8V+rULJQ5OXGo6VbKsmA==
X-Google-Smtp-Source: AFSGD/Vg/vynrvNH+dH594K0jaVMN8q8QcsLfHO3CJCNvbeRPiAA0NSsgaCb5SP/Lh/8kRM79gJX5w==
X-Received: by 2002:a2e:868c:: with SMTP id l12-v6mr5675342lji.90.1542834170594;
        Wed, 21 Nov 2018 13:02:50 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id d15-v6sm6826008lja.38.2018.11.21.13.02.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 13:02:49 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id e26so5029093lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 13:02:49 -0800 (PST)
X-Received: by 2002:a19:7013:: with SMTP id h19mr5179995lfc.147.1542834168575;
 Wed, 21 Nov 2018 13:02:48 -0800 (PST)
MIME-Version: 1.0
References: <0693f05ac4b041ee2f988dfec31ebc81f4f28f17.1542830344.git.tim.c.chen@linux.intel.com>
 <nycvar.YFH.7.76.1811212149080.21108@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1811212149080.21108@cbobk.fhfr.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Nov 2018 13:02:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgMYsVJML+4hGU2JP8oYui-D51agYf=o8Z0VLZQYxMfZA@mail.gmail.com>
Message-ID: <CAHk-=wgMYsVJML+4hGU2JP8oYui-D51agYf=o8Z0VLZQYxMfZA@mail.gmail.com>
Subject: Re: [PATCH] x86/speculation: Revert turning on STIBP all the time
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, thomas.lendacky@amd.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>, dave.hansen@intel.com,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        "Van De Ven, Arjan" <arjan@linux.intel.com>, jcm@redhat.com,
        longman9394@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        david.c.stewart@intel.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 12:51 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> For -rc, I don't think we need to do this at this moment, given the
> prctl+seccomp fixup is basically ready, do we?

Agreed.

               Linus
