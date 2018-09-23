Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3F2C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 18:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F35120989
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 18:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcmiOcUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F35120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeIXAnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 20:43:23 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:37778 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbeIXAnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 20:43:23 -0400
Received: by mail-lj1-f173.google.com with SMTP id v9-v6so16308874ljk.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 11:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=jV13WN40moJo+7dx5WbRhksBE01RemgWzgwzy0Wlmnc=;
        b=vcmiOcUqZl/CHMVs4dBOJ2I/yYFYu/DWQyXHlR67Bu98om5+U0AouqIhtJVXfPZ7MP
         emfTlUx4n9ulMFtiHVBsQ0BMuzZ+461S8LEWJem7rCW8TkE+NDdM06IAUzjLVpeAsw+Z
         b9G3WM8Im/aI8L5dg3kCWlEIP8l1FAlo+rRK052i1smR4ljvz+ecOjnfD6k9ERlHky3I
         1o/47/2w+yize1Z5cH5FE9FExXNXdG41ZqfxSAqOlN0k2FapQictcDDtTrxGI3dJiyeb
         inABPUjuHFWYvmq7mtqYaFrvjd5+lBdWbNN6JJ+3v0A0JB+hOtF0ZPItpWWKgjZTcw8Z
         oXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=jV13WN40moJo+7dx5WbRhksBE01RemgWzgwzy0Wlmnc=;
        b=EQ5k79t8ln4alEHx8w9qUvamTMgeaqZJwKTn3PpIvIvAAFl0+Qdunp/IjrZUxF/Nhh
         /AK/2792YG9TXzoejft8E4l6y4BVCYS+n2VxTUif2NMfogr+XYcmdtpEQk0XY2Op4BPZ
         wSQiS/JbtCbf4+4CnNaWMmaqelGfHdNC/n/Nm7LMia86J4xmwWvayTY3XB/CCYOa254j
         e46T8vzSuIctLb4ydiJZX5XztDaRqiCFG04b5Jie4wTxbWdvEWK2l+YjOtWfGxUweuHT
         k2ZjxZHbmkMgm9G9iEV9Yrq7gRUFIzw4NtmShfF1z1KmdyJmKy76PJwGfDDGbJJ/Ht46
         fwmA==
X-Gm-Message-State: ABuFfoh2sFJp+piLgVwhhrntxR3zreFXYTH5/+fOW7q9zR0lz9OpeY3X
        7gJzuRnIJhSmc1WSfOU146YCiBTUKeHDAMi/FUM=
X-Google-Smtp-Source: ACcGV61MaOokujfDCrJII2v1Hhh6tf9BktqYS2SRxCE8/XEgbvYZUIYPZWc9SiuTJDCCMgcNd+OCyYvGGhkGeHsrPcA=
X-Received: by 2002:a2e:4794:: with SMTP id u142-v6mr7278399lja.57.1537728296935;
 Sun, 23 Sep 2018 11:44:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:278e:0:0:0:0:0 with HTTP; Sun, 23 Sep 2018 11:44:55
 -0700 (PDT)
In-Reply-To: <20180921231545.GC2966@thunk.org>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net> <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net> <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
 <87zhwbj8xe.fsf@redhat.com> <CAMjeLr-mWag=iO=CoNHeK9pkCu4y6vZUp03_zpJOG+e=n85j+g@mail.gmail.com>
 <20180921231545.GC2966@thunk.org>
From:   "\\0xDynamite" <dreamingforward@gmail.com>
Date:   Sun, 23 Sep 2018 13:44:55 -0500
Message-ID: <CAMjeLr_c+jdWDacX+KO_zxZHw09yRN3vAusNriXE3P2F5hsM=A@mail.gmail.com>
Subject: Re: Code of Conduct: Let's revamp it.
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "\\0xDynamite" <dreamingforward@gmail.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Edward Cree <ec429@cantab.net>,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> For example....
>
>> >* Showing empathy towards other community members
>>
>> Your pussy hurts?  Maybe you should have just accepted that your a boy!
>>
>> I think Linus is perfectly fine in conduct.   I mean, this bullshit
>> pressure comes from corporations and other wierd places (<subtext>all
>> seeing eye</subtext>) that want to "help".
>
> There are people commenting from all sides that are wanting to "help".
> But I hope that it is obvious that the above text is *not* *helpful*.
> Mark, please stop.

General Tso,

The problem with your criticism is that it assumes that all input is
legitimate while you advocate eliminating (or downgrading) some of it.

Make up your mind:  do you want all-inclusiveness or selective-inclusiveness?

Mark
