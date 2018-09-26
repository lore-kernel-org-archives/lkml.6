Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD06C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0867D204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DjaltoWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0867D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeIZQAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:00:47 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:39443 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeIZQAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:00:46 -0400
Received: by mail-wr1-f44.google.com with SMTP id s14-v6so26283963wrw.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 02:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=orsfef6aqNRCUJDcozo/1rkqRO2pjQkavkjTroh7ZSk=;
        b=DjaltoWI7EvFibHJ7od0BWma4skvQtKdvIOONZPiTo0sNLrjF+3nKfTLAIZX58FoIM
         vHH5TxWTE4QZxIJWS1XLgnUbtFgH6dEs7e/VY1I444bvXc8hNA3OSsKk7lkWGTWzSmfj
         h4ay5OlnboHanYb0Na4AcyKPoyolal17ldxMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=orsfef6aqNRCUJDcozo/1rkqRO2pjQkavkjTroh7ZSk=;
        b=DHcmEvQ6xlocbEQfurZ2Tg2+2feAiU0Gi3WgUJoxv9eQ0glAU01WPO+grns2jjp6H+
         +l5fxivE45tjfn+LOQve4J1Y5DtfMNB//PQVRPlraOsR6PA2xoMB3LO8mgw/PJ5oB50p
         xYEMxu9FU45KA5uZExUNuwzoB0CluHcQg8k91dDSJ9M7AerX01QxLdDwY2Jez0pvlvn4
         zRBRSx3V5JtzkAEOslTWFRkvI52vPsN+Mb7wZ7FJH3KMcXQXvWu2Lp3NpqytYb8ZbIgE
         kN1dDwxe/PITBqd2oqvh3FCQGD3ppUyg+CpQJz1QIlXLbIoT59W0XMf3MRWuG+CxI5tM
         CJ3w==
X-Gm-Message-State: ABuFfoiEFOYBmWMHzrwPzEtoyKh6AdFJhsKq+JjFUA9hSMuNYSGMB8B6
        nbJmXHgk46WjkmY1b17DikO7eIMdC4xcMYHoK4FNqg==
X-Google-Smtp-Source: ACcGV623NFGT47RuHwZm8LyhvQGwHr/mMJqRWoZVO4x5z5P1icIMmn2ycisMa4pVty9NMdxWwtwqPc0GmitpxuOxLNg=
X-Received: by 2002:adf:b71d:: with SMTP id l29-v6mr3878782wre.115.1537955317334;
 Wed, 26 Sep 2018 02:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180924113114.334025954@linuxfoundation.org> <20180925090733.GB21224@kroah.com>
 <20180926002857.ajqqxi2qcfcwsg7g@xps.therub.org> <CADtBP2Do8u9Em2kUeb9nuux+kD=sjUpQ2XLetYO3vrdPxiYNKA@mail.gmail.com>
 <20180926053029.GA3800@kroah.com>
In-Reply-To: <20180926053029.GA3800@kroah.com>
From:   Rafael Tinoco <rafael.tinoco@linaro.org>
Date:   Wed, 26 Sep 2018 06:48:01 -0300
Message-ID: <CADtBP2AfuwT7udZ88MYksXxOqPe6dYi7LTCJa85zp7v2VX2uyw@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/173] 4.14.72-stable review
To:     gregkh@linuxfoundation.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org,
        s-anna@ti.com, loic.pallardy@st.com, arnaud.pouliquen@st.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Do you think we could drop this patch, for now, in a possible -rc3 for
> > v4.14.72 ? Dragonboards aren't being tested, because of this, since
> > v4.14.70. Hopefully it isn't too late for this release =).
>
> I can't "drop" it as it is already in a released kernel, 4.14.71 and
> 4.18.9.  I can revert it though, and will do so for the next round of
> releases after this one.

Yes, bad wording, sorry. That it was I meant and tested. Thank you.
