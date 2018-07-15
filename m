Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113D0ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B353F208A5
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kv0YNG72";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oDc+0oLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B353F208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732909AbeGOCeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 22:34:50 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:37856 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731972AbeGOCeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 22:34:50 -0400
Received: by mail-yw0-f194.google.com with SMTP id w76-v6so13094229ywg.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 19:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=R4Rebggb6N2y72RxKVrGwrrusQgVLRNBH5D2ap4g8gw=;
        b=kv0YNG72wlgo3NmSnRJ34whoLlq6PNVtRvrN0Q3bbA71fUDoJSuEOQNa4V2P6QiQEe
         W0UPHGZ6KpTCHjeaTk8Z++QtDCHbT5FfyhaOGBqKwr7fMfE6IwsqSMsGFBo2vSEu3VPJ
         feaVl1vTkC5RCMep8c2Flc7c2zOar40eA+gW6vL8A/EGPw38kUCRGpwkId8r2ndpk2d/
         349fK4A91lEkZfDaGiK8IUMgtIVkVjZ1TsZIws/TlwepjhkQg1R6frhIVPAuLz1jJzCr
         NaMce4Lwx94AGeOVURar2GvjQvT4q6z7bTvdHI5HniDlDr4xxbDayrYfemHr+v+iFkvX
         tqHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=R4Rebggb6N2y72RxKVrGwrrusQgVLRNBH5D2ap4g8gw=;
        b=oDc+0oLMMK45hwnlmmfmR74m4XjTwcXOurexoe4v/PkYv23Q3DRuIwSh42p0t9HCaB
         9sD1gHI0Eav5HkSiTQ5wNhxSCesCrmxmUywM50TTuy7BtwQ2Zn78Dz42ZFJcOyJCcBuX
         j2eWMPU3IcFxbIHC9OsMYwTUm1mfwyRBJtuT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=R4Rebggb6N2y72RxKVrGwrrusQgVLRNBH5D2ap4g8gw=;
        b=WhUZSUIEmp7oE8lyGkaUnk5ZfkmAnXmNcbKLNCpd8snP+cDQrp+toh3B8FpvAH59sl
         I/iUMSqd8CBgTNssiBjGfA2qWZau3ArptOeyuRwa68Xkbe+9iQd3EvRufK93JZXLv718
         bnooq69ADUguzeq9p9lHzUZg+WMQEJpAnDpVr6qonzTRN4eqFc2D7WvrM9tN4acT4LgB
         i1/LyrFoNLAAVxrMovbfHCoqKJtF+nwGv8mXjCIw+CEnqpx+664ekdZdaKDZskM0cNrW
         kSlQFw2dOMsssXgVswlKKZ9mIGcGJLqJQeF7JL25B3je6nh1mOsxriEkjqhWDxRyYuew
         qgYw==
X-Gm-Message-State: AOUpUlE3oj42hSBGvH00wH+ILtjMWV+uQ7niB7Ha0FgnjGK2ODHNekla
        NH9v1vleJ7/uOLhQSOn+ZzxuUKzsyHdjWqRglN6d1/iF
X-Google-Smtp-Source: AAOMgpewtQzg6/17I81AH2lARcoybE8N4rqPQ2+SeNlEEhemI0k2W4KUrZy1qtNDES+LMkt0VWaD0g6JWs+TEFuRSJU=
X-Received: by 2002:a0d:fa42:: with SMTP id k63-v6mr6055138ywf.53.1531620820335;
 Sat, 14 Jul 2018 19:13:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Sat, 14 Jul 2018 19:13:39
 -0700 (PDT)
In-Reply-To: <1531505163-20227-2-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com> <1531505163-20227-2-git-send-email-zohar@linux.vnet.ibm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 14 Jul 2018 19:13:39 -0700
X-Google-Sender-Auth: xHzrJUFRM0LncA74oG7uK1sdxTU
Message-ID: <CAGXu5jKU-cdYCQePZAr_eEUEsaK92kABFF=UowhaO6yuWVXEVA@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] security: define new LSM hook named security_kernel_load_data
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 11:05 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Differentiate between the kernel reading a file specified by userspace
> from the kernel loading a buffer containing data provided by userspace.
> This patch defines a new LSM hook named security_kernel_load_data().
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
