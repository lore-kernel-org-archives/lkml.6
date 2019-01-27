Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B31C282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 17:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C91214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 17:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fnPLff55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfA0RCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 12:02:39 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:38715 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfA0RCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 12:02:38 -0500
Received: by mail-lf1-f46.google.com with SMTP id a8so10158693lfk.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 09:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vHYj4UCs1O1PVgP7BsmKrishmWx1IwMh3aHb1qgyjPU=;
        b=fnPLff55YCGxS7Hdo9LoGR+BgIt78E80D0pjzwQRlWKjZ+VSZNfsroXP6lDO1McvVG
         cSb/B0CfG4diZpwb6djlXuVvUBDITlLAm3beVCl3IP9k1EV1lfRZ1+Rcrg99Tr5zEWbc
         RuzWnks54ZH/s07/iG1gGlGPCwg1LBtikrT7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vHYj4UCs1O1PVgP7BsmKrishmWx1IwMh3aHb1qgyjPU=;
        b=k/V/zsKJ8qf9cAXNd4fNaUBJ7MgqJGlu5zwMawIiw5VL+NfNmWRUAHmyrUs8FSB3Mt
         q+6nt64YKdaNKCnaMScT19In0WlzSrQPZLRJoehBFP1ra89B7uC+DBkMjH51LB5bNGOh
         faqADj/I+XAu0LKEPiGCdXcYOo8TnhxeESQaVW5eiDy8FVhc2wd0lkquRKrVFbW2QG19
         ceYt8zyVm7y1exb1sLeTk8xGJQw+y4v4CvOgg7rG3BkQ+kG4qJvrHgyTugZYSS3ZAzzp
         jOVtWVnPKzWY7gaSqMadweDdFsemo3R8lR01rC2DgWJrpW402FJe5WEl06j+9tK4RKiT
         FCmQ==
X-Gm-Message-State: AJcUukdKAcPnOShkDzTFs1E0eKaRXQ7n0YhO6q8oV7Uf5WZPeKqFXrXU
        Fp8coOmDnXsVCpJGwPMN+PtktOobUkQ=
X-Google-Smtp-Source: ALg8bN5xOVGT1JFXq1dUQubAqjSJxdhWIP5/nmdsc8LI1gC5fFchq87mmEksB+nTXojyyMhFvlZvSQ==
X-Received: by 2002:a19:6514:: with SMTP id z20mr5925512lfb.31.1548608555492;
        Sun, 27 Jan 2019 09:02:35 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id f29sm2505729lfa.46.2019.01.27.09.02.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 09:02:34 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id q2-v6so12198855lji.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 09:02:34 -0800 (PST)
X-Received: by 2002:a2e:8045:: with SMTP id p5-v6mr14209334ljg.87.1548608553816;
 Sun, 27 Jan 2019 09:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20190125.162151.302539235913379257.davem@davemloft.net>
In-Reply-To: <20190125.162151.302539235913379257.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Jan 2019 09:02:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgJQf+eS6MeEuUL59kSr-kiiYpzSUfErvO_yTQTNPtHwg@mail.gmail.com>
Message-ID: <CAHk-=wgJQf+eS6MeEuUL59kSr-kiiYpzSUfErvO_yTQTNPtHwg@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     David Miller <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 4:21 PM David Miller <davem@davemloft.net> wrote:
>
> This is a resend of the previous pull request with the qed changes
> reverted.

Thanks.

I'm trying to be a bit stricter about the rc pulls, even if I normally
don't even look at yours much.

So let's try to keep it to fixes only, or at least when you sneak in
new stuff, make them small enough that I don't go "Hmm.. That looks
odd.." ;)

                       Linus
