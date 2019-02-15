Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FCAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA802192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hQBKQmbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404075AbfBOQI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:08:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36032 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbfBOQIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:08:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so8845540ljk.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ypsT7ZOZRDuagRm10mReS6489i2oQSVteyE3IpLIN5U=;
        b=hQBKQmbigPO14JAcWErGOLh7Fe0r+oe8Z4wwj4o0IvdBXztGDovjxMnoEN2JF3HBaW
         OxnXO08ox2lh9+pFUCS+DLOS/q0bIywi0BQm5zlVygp12X8GJ/Pm2NCTx2gWEWvcuCi/
         RBiksUIvo2hmLyGHyJgpnMFKwXehb8Q5zWCFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypsT7ZOZRDuagRm10mReS6489i2oQSVteyE3IpLIN5U=;
        b=GHGq0VA8TRIJgsxpEbcM5lb01MMDEfVHZBtMwOy/r62Mo7izqqvbops7ymwaJdzgQc
         fFN+rJamxnBPgzsTCw4HJGiZ9HwOJvo8Nzbq1+MYvx0pPPFnrUeht/pvEILJ3d3mxepJ
         heSzcdMSOS6REOArnKpUCGJwQzvfAI0/e6qTAqyNK672WAwdG7SebzAinWVqTviJ+7c/
         lr4UVgmAddEyezUw9MTe/aaZcHZWzIa37SsXGNIsf81J4ZddoEgz4jvDwA0r2h3/ahEN
         0DH5aiBpdhc43JpXEURCuGSNdiNqRv/T7clCLke5rNTfz0Sb+i4E9OB9Z+1sjS/fhgHT
         11IA==
X-Gm-Message-State: AHQUAuYMNmI4LOBlxkW1Loi3NqMYBkt1QQAZ1/dudVFC4L6NpNOyHHzD
        g3WiBZsHR4cza6Et0CUry3O0LuD/rRI=
X-Google-Smtp-Source: AHgI3IYs/WcXSQXu+HKXVTTK6fyoDsKM8381g99yFlYmyG6Fu8wFrRPA4CjTPkt8C56vYJrcwZCWbw==
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr147154ljj.142.1550246930174;
        Fri, 15 Feb 2019 08:08:50 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id y134sm1409182lfa.20.2019.02.15.08.08.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 08:08:49 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id g2so7544689lfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:08:48 -0800 (PST)
X-Received: by 2002:a19:911c:: with SMTP id t28mr6173790lfd.78.1550246928534;
 Fri, 15 Feb 2019 08:08:48 -0800 (PST)
MIME-Version: 1.0
References: <20190215031758.GA18776@beast> <CAHk-=wg7DRUqWvbCS2dm=mpdSNJry92Fo0OHDVi67bi8BMqt4A@mail.gmail.com>
 <CAGXu5jLi+zcOoi+Ti=OyR3MfF8s_S35EEmT_DoCzYPepOcn+Ow@mail.gmail.com>
 <CAHk-=whBnu7TQTOoOiqSmDGpH0oxrFo9sDzJTZRFhFCv69BMrg@mail.gmail.com> <CAHk-=whiDx=2=U=0-uSaVVb4kC_Wz7y=cbFi+Ub+1hQEb7WyuQ@mail.gmail.com>
In-Reply-To: <CAHk-=whiDx=2=U=0-uSaVVb4kC_Wz7y=cbFi+Ub+1hQEb7WyuQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Feb 2019 08:08:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjzX73spBTB3AEbgppUzoGPb7iVphc3oJZ5evXmkZ2eRw@mail.gmail.com>
Message-ID: <CAHk-=wjzX73spBTB3AEbgppUzoGPb7iVphc3oJZ5evXmkZ2eRw@mail.gmail.com>
Subject: Re: [PATCH v3] exec: load_script: Do not exec truncated interpreter path
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 8:05 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And even that doesn't really fix it, because what it really wants is
> "strnchr()" (to stop at a NUL too). Which doesn't exist.

.. actually it does exist in the kernel, and I should read all my
emails before writing new ones, because you had a patch in one of your
later emails that looks fine to me and used it.

Although I think I'd prefer that inline  helper model instead to make
things more legible.

Would you be willing to make a frankenpatch that combines our two approaches?

                       Linus
