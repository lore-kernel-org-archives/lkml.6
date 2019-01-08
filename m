Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930BAC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A4820700
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546929833;
	bh=kREqi7YCXUYbeN5roq7vFxqOk6FRj+c/mFT6NJGc2EU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sRRfXE9ootcO0ZzxJLP+Ng+nJuttCd2YK7o0eXDt3VSE3L937ndiIAzw/i/eCG0Jb
	 vuPQk4KMOCtdF+Ke8nAXmIyl0S0rZvtM9ItDyEnDqUGJHqmyX6AtB5E2F/1Wl+5OWU
	 kDNe8hGBB7+ywO855G7Bqcwf9iI7NfMClY0MXV10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfAHGnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 01:43:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51906 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAHGnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 01:43:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so2994913wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 22:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NACb/6+4H08shuXDntTNDNOohdCJIiK5En7HWo96elY=;
        b=MBKa7qRnJqTZkvPYIWyl0zdjnUejnCLiC04MF8cGUIMJWe3nJMJk/CWSLTAlCF+ixK
         i4izJeynU4VAeLvN/mN04xxSAl5EBkipWeNd3NGKrkgityjhtIwRfWR33LaHFr12GYht
         LnmruDlXPP353IkurtHc+3lr+qwc07T0C4LbmfLZnRc4WuIp2gCo70XbTNWdNXspFNIK
         fQwVLKc1668FaX74IO4NUuQlE4LyunW8WrfckEx4O+oz2Lr6Pt+WCJ4DPmzRGldxyJhA
         5mUsIdOh3L+Bo3+1u5sPu9B1mKa5ot1p3a+0Sii49NMP43l9fl26Ey+11SF/iNFSGA+k
         ut5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NACb/6+4H08shuXDntTNDNOohdCJIiK5En7HWo96elY=;
        b=SjGJn8ghJPyDW8ajgO2I2AtUqN6z4hWRAc8tSSSLSDnO9cwduhm3LWVXTMiUxbN1BY
         pzH3MpsqVCkgWtloNDBXksZtwOlO6rznXMWWTZLOAJyM/lZaxXjslc7j4ievZeymXRoT
         N7feg/7mhnwSEXQu0YGRx/jQDJNofuDUAW6rJ1MXe+pEZ8O4B8yT7W12YPRS5Sn3AYIw
         mk46Wwm9v3MX7gMicNkrysJTi+L0RYEoUUPkmEqtoCdTIdvpIPZKCe073AG/2deKwmxU
         b0nuMK/232yx7d875ms3146jcEBtszvrNt59JnwTuSeSYJvV1O/rPdjMsgtiMB9J9TSe
         Un/w==
X-Gm-Message-State: AJcUukcO22QQRnpGyXFxQEpATaLsI7L+4mfBgt4a+lvLalSms/Gvtv2j
        vVWFNEGm43B5y+giALw8kqDmrDvg
X-Google-Smtp-Source: ALg8bN5gSo5QnqHmQWaQX2YNK2RjYECC3mRfWf53fB/NZ31+1uz2I2N17wjpzri9yTmllIIeTYAh8Q==
X-Received: by 2002:a1c:848c:: with SMTP id g134mr626114wmd.93.1546929830029;
        Mon, 07 Jan 2019 22:43:50 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c10sm48768776wrw.49.2019.01.07.22.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 22:43:49 -0800 (PST)
Date:   Tue, 8 Jan 2019 07:43:47 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] samples/seccomp: fix 32-bit build
Message-ID: <20190108064347.GA102319@gmail.com>
References: <20190107231631.1849-1-tycho@tycho.ws>
 <CAGXu5jK1pY-RqB_J5_obMDaWav8cJHjXQkpz0B4cHM=A8Ztq7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jK1pY-RqB_J5_obMDaWav8cJHjXQkpz0B4cHM=A8Ztq7w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kees Cook <keescook@chromium.org> wrote:

> On Mon, Jan 7, 2019 at 3:16 PM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > Both the .o and the actual executable need to be built with -m32 in order
> > to link correctly.
> >
> > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> > Reported-by: Ingo Molnar <mingo@kernel.org>
> > Fixes: fec7b6690541 ("samples: add an example of seccomp user trap")
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> > ---
> > I guess x86 can pick this up directly? Not sure where it should go
> > exactly.
> 
> Ingo, can you snag this? (It's a more direct path, otherwise I can
> take it via seccomp, which will go through my tree then James's
> tree...)

Sure - applied it to x86/urgent.

Thanks,

	Ingo
