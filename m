Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507C0ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13AF320825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z549WAB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13AF320825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeKHXV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:21:28 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:39234 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeKHXV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:21:28 -0500
Received: by mail-pl1-f178.google.com with SMTP id b5-v6so9566580pla.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wznYTGFkGz2AdNLHraktMTRMurFAVCPD0Mq146J1u5w=;
        b=Z549WAB9J1fQpiUXszZQbYqT3ogj0Q6vSxt6NQ2AuWF1Nh/mV1drlqjwmxCLem/zdD
         AdDz1vawlLbNGvGCjRQCleqgSswduM8hBhcR/sOWsf5+RHMu6TD8rq0UZJFm0vA+aJ9Q
         IrFYtF4SP/UZ7jlbMfuKhNjXeAjcYhzykJoaHAHtzzOVYQAANnOGihDrD0eaj/FdKtcZ
         hfzemU9QPkvq6bM5K+EgES2uLOvkxW0Un99OJ7cYaaalo82ihmF1Nb6dr58wRRwkZWWu
         OBWZ/cAsGK1mVzuxa2u02QWOZ2SKe6vKvhPfxrAYzaazfT0igoaCLan577qD/65zx22y
         HuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wznYTGFkGz2AdNLHraktMTRMurFAVCPD0Mq146J1u5w=;
        b=hMhfZFhphaO24TjEIn7V0IF+dA7kf+cybaWll+KVI0JVmR7XLUXaH3gQrqUkc42W9q
         BKvLRsnPGCqi2Mx/vT7s6MUfB1HNmDP3V7GgD0pJ309hqNEtQCDYhzJMqyBSw5y6E7uT
         EJO4ubEPgEqGO/1g8Ek/rMnPd8Pg2COoKVI+RM6wSsjAp9tcnGVAm71m6a/A2JXJoCr4
         XjbKU3+PY/PptpUwIL5c2cOvgNzIZBrHTIYC1NMVVjCrgI7vlQN2DOMcMQFGgnGyl3A/
         xw/ZnTxlibHijeu3Veo4h8vz1NLm3psRQA1YoMLbY9dw/wyxJ7euCW6f8894kHbIiRxo
         95zg==
X-Gm-Message-State: AGRZ1gK0ptE3hNr3aposC/D6BzKNUv4AR5AJ/xJSnOljkJI1MWgJfGzi
        YNc+ecPON6Zx2E0BZxhcvac=
X-Google-Smtp-Source: AJdET5fsBGPRq5gaCZ7UfRTPDRsMbPDkxmhSjHtNgZomxpRZqGGs6Dlu7RInEQ4lDrVhe/ix7QYkVA==
X-Received: by 2002:a17:902:20c5:: with SMTP id v5-v6mr4651056plg.156.1541684754187;
        Thu, 08 Nov 2018 05:45:54 -0800 (PST)
Received: from localhost.localdomain ([218.209.14.71])
        by smtp.gmail.com with ESMTPSA id q15-v6sm3831480pff.49.2018.11.08.05.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 05:45:53 -0800 (PST)
From:   Jongseok Kim <ks77sj@gmail.com>
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jongseok Kim <ks77sj@gmail.com>
Subject: Re: [PATCH] z3fold: fix wrong handling of headless pages
Date:   Thu,  8 Nov 2018 22:45:40 +0900
Message-Id: <20181108134540.12756-1-ks77sj@gmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
In-Reply-To: <CAMJBoFP3C5NffHf2bPaY-W2qXPLs6z+Ker+Z+Sq_3MHV5xekHQ@mail.gmail.com>
References: <CAMJBoFP3C5NffHf2bPaY-W2qXPLs6z+Ker+Z+Sq_3MHV5xekHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, you are right.
I think that's the best way to deal it.
Thank you.

Best regards,
Jongseok

> Den tors 8 nov. 2018 kl 13:34 skrev ±Ë¡æºÆ <ks77sj@gmail.com>:
> >
> > Hi Vitaly,
> > thank you for the reply.
> >
> > I agree your a new solution is more comprehensive and drop my patch is simple way.
> > But, I think it's not fair.
> > If my previous patch was not wrong, is (my patch -> your patch) the right way?

> I could apply the new patch on top of yours but that would effectively
> revert most of your changes.
> Would it be ok for you if I add you to Signed-off-by for the new patch instead?

> ~Vitaly


> > I'm sorry I sent reply twice.
> >
> > Best regards,
> > Jongseok
> >
> >
> > > On 6/11/2018 4:48 PM, Vitaly Wool wrote:
> > > Hi Jongseok,
> >
> > > thank you for your work, we've now got a more comprehensive solution:
> > > https://lkml.org/lkml/2018/11/5/726
> >
> > > Would you please confirm that it works for you? Also, would you be
> > >okay with dropping your patch in favor of the new one?
> >
> > > ~Vitaly
