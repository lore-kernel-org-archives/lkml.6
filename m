Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABA2C10F02
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DC3218DE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lPFHHgru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfBRD5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 22:57:46 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46646 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfBRD5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 22:57:46 -0500
Received: by mail-vs1-f66.google.com with SMTP id n10so8826472vso.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 19:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UOsM3VCVgb9jvwPmcWRSvBagRCh9VlWAv72+Ih2qte0=;
        b=lPFHHgruNQsGLwdT6TH5+K5HkaAvs54hgg8I+9lpT8zJJT90R+8fGdQhpnSnLdoT/1
         /zu/zyHI3Oqk8te3MqN0NvqNRNOFQVN8eM0Z03NZ62Uq5DZ7cuCZg6PzAXI2L+6bAd6c
         +pi/uIn8MrUihRld/jD2bcWL1eBT1XuclwbFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UOsM3VCVgb9jvwPmcWRSvBagRCh9VlWAv72+Ih2qte0=;
        b=QwmdKZQR52ZdpmSBruDciy5pzmkMQpD8maj5Fdnpu8i8PwEcShrCvAAlNwuak96LyS
         2ymqyINDMVTnjOKbcWe46k34hawOmxnfvkxoJ17ATSY2o2S1WZzEeDvOxqN03/soohLp
         XeOKNk6jIF9479uaL9NBKDJqw3lNbBttGWidj2QNz3SmdnOAqznBzz4kSPOlJLcNqgFS
         hZttJjmNVlnfDfrR4sdR5EqJ842sb6ilFZQzkDhJgLm+J6cqAcEz6i0bXNgf003ze5Vo
         2DVZEVJHnrLVEmXyiuMVAa6mv5frc8YwVNXhtmwR3p1HK/u0Qrs7+/qKTdMok9rMIJI4
         DwAg==
X-Gm-Message-State: AHQUAuZkkF7Its8d1i18QMQ08jexT3ISTKNyewUv2yjw/ZYKbx0xcXVf
        s0SlJxqmNseigJT86jeFZuhfqrRRfPo=
X-Google-Smtp-Source: AHgI3IZNj7Y0l/Fz1Y3f1F9iT908O6BodGgzoLFtSJ69bfU4XT2/+5XxICB9/nOqQaZEpH1L2TFsxA==
X-Received: by 2002:a67:5e86:: with SMTP id s128mr11211995vsb.90.1550462264726;
        Sun, 17 Feb 2019 19:57:44 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id n206sm10962767vkn.36.2019.02.17.19.57.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 19:57:43 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id z18so8850093vso.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 19:57:42 -0800 (PST)
X-Received: by 2002:a67:6f44:: with SMTP id k65mr10275404vsc.222.1550462262332;
 Sun, 17 Feb 2019 19:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20190212182318.GA16669@beast> <5260689d-9016-bdf4-6070-13d2c88ac8a8@schaufler-ca.com>
 <4ed50852-abfb-773b-01e4-b4ac83e32ed3@I-love.SAKURA.ne.jp> <CAHC9VhSy8iVUtN1Wt+cy-2RmJQhy34=0zKrUj+RQNEvNuD7y0w@mail.gmail.com>
In-Reply-To: <CAHC9VhSy8iVUtN1Wt+cy-2RmJQhy34=0zKrUj+RQNEvNuD7y0w@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 17 Feb 2019 19:57:28 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+_Xd_On1WsMV18dbjGEg6NGBcSAj4RSp=LX2ALisuXPw@mail.gmail.com>
Message-ID: <CAGXu5j+_Xd_On1WsMV18dbjGEg6NGBcSAj4RSp=LX2ALisuXPw@mail.gmail.com>
Subject: Re: [PATCH v2] LSM: Ignore "security=" when "lsm=" is specified
To:     Paul Moore <paul@paul-moore.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        SELinux <selinux@vger.kernel.org>,
        Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 6:46 PM Paul Moore <paul@paul-moore.com> wrote:
> My main concern is that "selinux={0|1}" continues to work as it has
> for years.  It doesn't look like this affects that, but I can't say
> I've dug into these changes very far.

Yup, no worries; it does. :)

-- 
Kees Cook
