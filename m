Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D81C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7297C2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ed5Qgup3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfAHB3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 20:29:39 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37334 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfAHB3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 20:29:39 -0500
Received: by mail-ua1-f67.google.com with SMTP id u19so776158uae.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 17:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aTdBtTEZCH/4iLJe/wIuUIn2iqxr4uAZKAK+z38oRWo=;
        b=ed5Qgup3bl3nLcXUfRsdaHxDIHgv0UGGfg13G694FdL30YmQZTKYrWx1Mxcpo0P7Nj
         rgF6F8IR0SRhpRCy7RIciGWGpNb74NNdQ5dvKg7E0ncvussiYxVlZazzYN9kx0wUWTK3
         qfDC6G91dqkfO630DzyjXfDSllYU4GhBEsJPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aTdBtTEZCH/4iLJe/wIuUIn2iqxr4uAZKAK+z38oRWo=;
        b=rxVTFr8z7mQygUGUmE6s2098TNCxwW/lo6xlXnQKhRfaEoxDXDLOo8qhvztPTB+pqv
         P9utTfOszHk7c6Cq1CiIvMhFbxsF+cMGzVEaldKCrhmP6MmlIffOVm/eBskFcDLM2kGn
         tw5YMy+ZpALDCgMOEIWiXDsNFBCeoAYnWR8Tcy9/2Dz+aVIKSlusoNiy4dIe7hB0p+r1
         yLN1xkOMHDH1xyat8fFxgz2Q9lJTRGlyouIo20n0uY40EhakxzU/sW5CAAa0QQpW8UwU
         j7ojYVBmvG/LZQ58GXgPIamy/JA3wfWnfhmgeR3iirqglNjZ/dqjQzGScZom4kvneXc4
         Bpkg==
X-Gm-Message-State: AJcUukccqeSJf9jxCvyIbI9aus2wRZTi9TGFYJbCyq4Zv6FD+RvloVMx
        XhiK7C/FSCB9S55LOT351wp3iyTdonw=
X-Google-Smtp-Source: ALg8bN4SRJdMqouTR39JEz3II2dBTRxcUTFafFYfuRyQ3U9KZv5jy05oM0p1105Phz2I828029VvGA==
X-Received: by 2002:ab0:6190:: with SMTP id h16mr24351309uan.94.1546910977406;
        Mon, 07 Jan 2019 17:29:37 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id q7sm16347968uao.16.2019.01.07.17.29.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 17:29:35 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id x28so1462179vsh.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 17:29:34 -0800 (PST)
X-Received: by 2002:a67:2c13:: with SMTP id s19mr24442833vss.172.1546910974212;
 Mon, 07 Jan 2019 17:29:34 -0800 (PST)
MIME-Version: 1.0
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
 <CAGXu5jLUJYM3nDDhFeBOKkTnyCR-tXAv-rteBJFMBn_J7kVkqA@mail.gmail.com>
 <alpine.LRH.2.21.1812120556040.11653@namei.org> <CAGXu5j+bx7nJBMdFYigYnJFRyCvz0NAxfiWF8yP9EhRESLnn+Q@mail.gmail.com>
In-Reply-To: <CAGXu5j+bx7nJBMdFYigYnJFRyCvz0NAxfiWF8yP9EhRESLnn+Q@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 7 Jan 2019 17:29:21 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJOGKAFrFF7HSPnqLpLz0no2Ae_z0TkWPeRt1WWqhqFOA@mail.gmail.com>
Message-ID: <CAGXu5jJOGKAFrFF7HSPnqLpLz0no2Ae_z0TkWPeRt1WWqhqFOA@mail.gmail.com>
Subject: Re: [PATCH v5 00/38] LSM: Module stacking for SARA and Landlock
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 1:19 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Dec 11, 2018 at 10:57 AM James Morris <jmorris@namei.org> wrote:
> >
> > On Tue, 4 Dec 2018, Kees Cook wrote:
> >
> > > On Mon, Nov 26, 2018 at 3:22 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > > v5: Include Kees Cook's rework of the lsm command
> > > >     line interface. Stacking is not conditional.
> > >
> > > Can you resend this series with corrected "From:" lines in the body, etc?
> > >
> > > Beyond that, I obviously like it. James, what's needed for this to move forward?
> >
> > If there are no outstanding issues, I plan to merge this for 4.21.
>
> Yeah, it looks good to me. (Excepting getting the authorship sorted.)

I didn't see this actually get merged? Was there something that needed
fixing? Should I send you a direct pull request for v5.1?

-- 
Kees Cook
