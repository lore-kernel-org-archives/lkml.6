Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E97C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114BC20821
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DBKkPFq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfA1H6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:58:51 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35103 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfA1H6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:58:51 -0500
Received: by mail-vs1-f66.google.com with SMTP id e7so9212023vsc.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 23:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jh2+iNxljW7Ev3ui+KtrF0KqiAMvse0LLhGqod/SUuo=;
        b=DBKkPFq+DrY0YGtAUTJ+PlMRwsaN/EU9p/Ej4IdfO8LEL0dfXIYpGrchKf9Kj+qdRs
         iSe3dttI2r7jhCtPVKv4qop85wx/1bmg226gpPtvc0ZRpQFA5thVe5gYTfKIcKspL5T2
         g+0eLM2w5JO5otyAyl2+H7zXqeWXLc8Xg0Ih8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jh2+iNxljW7Ev3ui+KtrF0KqiAMvse0LLhGqod/SUuo=;
        b=nFpS1mk9qZerlbDXnnp7xU0hXAzMhFb/zM2s2LePIptRGQkanOUoreQF30WAhrEym5
         0h0tfQyAY58eX/cS5s6AkEp6Nyq+bBfyBkBWJn8KqoHJx/tWFDQfT6t8xH6sF4hyDcux
         ++XWe+AYq68Ff8ApZe0X8wpR6IlNCWvGqURLxaFiqHFJGFO5ZwJcrOjEcmH2uEA+ti3E
         k2DiScWTjseBoy3J+XBC6+CWbioSS2vYbWDHeGk5u34v1JC92PIl8MN4MDmCfkPnBi6o
         WI1QpDMK0jUY8yVtX3MhgG9/1BzMcBFUv21GJ73kh/KgEnT4rMRP2kR8qv1hY+DKHURf
         2POw==
X-Gm-Message-State: AJcUukdgDljUriy36UgV9GgaTyNh4vxpcIJCsmvTwKOw4FB8PtD0D5sy
        Z9C1Tap3JvhZLgLRZ4510Y2sh8F4qTk=
X-Google-Smtp-Source: ALg8bN4/DfLdMRf2L2GTOWJq1BYyzEpf3xXC/9x+X16fCcY7HZ+rIEI/Vui6G2Yh2LtG75ssZdmvig==
X-Received: by 2002:a67:fa98:: with SMTP id f24mr9250065vsq.125.1548662329734;
        Sun, 27 Jan 2019 23:58:49 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id k77sm32573588vkd.17.2019.01.27.23.58.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 23:58:48 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id p74so9233093vsc.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 23:58:48 -0800 (PST)
X-Received: by 2002:a67:848a:: with SMTP id g132mr8259264vsd.222.1548662328194;
 Sun, 27 Jan 2019 23:58:48 -0800 (PST)
MIME-Version: 1.0
References: <20190127094357.GA9436@beast> <CAKwvOdnUzTXSBPayebsy8pJGjJjPS3oi3qE8nRPtAhtv_PJ4xw@mail.gmail.com>
 <CAGXu5jKDdutht_+hVhKan6cNZ+bS7e0gom5yXmcMgKE9KuZwYg@mail.gmail.com> <CAKwvOdkvV+1qVUTz7G+nfftdzUfTGL+RnQ_8rA_RAhRrpvRLBA@mail.gmail.com>
In-Reply-To: <CAKwvOdkvV+1qVUTz7G+nfftdzUfTGL+RnQ_8rA_RAhRrpvRLBA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 28 Jan 2019 20:58:36 +1300
X-Gmail-Original-Message-ID: <CAGXu5jL8GHE3XLLo36Ldej3Z6ZHg+kN5Jfq-Pepvu3hzNsf52A@mail.gmail.com>
Message-ID: <CAGXu5jL8GHE3XLLo36Ldej3Z6ZHg+kN5Jfq-Pepvu3hzNsf52A@mail.gmail.com>
Subject: Re: [PATCH] selftests/seccomp: Actually sleep for 1/10th second
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 8:37 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> So this test has been broken? If so, do you know for how long? Or
> who's monitoring them?  Either way, thanks for noticing and fixing.

No, it's been working fine. It just consumes 100% cpu during the
spin-wait. The intention was to sleep for a little bit to avoid a
tight loop. It was just resource-inefficient.

-- 
Kees Cook
