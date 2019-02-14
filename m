Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A07EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0361E21928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QCR+ODqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437626AbfBNR5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:57:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39229 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404197AbfBNR5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:57:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id g80so6028252ljg.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2h1/LfmGb7XwFC9p5d9SiH+OPQDRcxnwkOP4FBfWeGM=;
        b=QCR+ODqbQO8vDwOBlDMtOx3e2qsBK7pJfp1uhfGCER1xneqi5QibSSLPwfLcUWB3Fj
         tWDgs1Rj9oKVVamkXXrCPKsvOlcVk+mMEVHIDQpgUFQR1UCSL78dO442tZFwklGAWG3w
         ed9CTj6n0PBpP5WjMikdluHWVRzt7QdAboK+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2h1/LfmGb7XwFC9p5d9SiH+OPQDRcxnwkOP4FBfWeGM=;
        b=hwZ/eqwvv/pwAFJ+dALK/XZs2LUodJ1teXpH8DPRFimpLjkNkgs58qJkQMCvfIhMyA
         TXrKKehubR/1nJUyNXyvewFV5kF1dZPcaYb8qTqrxSdssWYs6XfDiPS/LAiSXBb+X0YB
         MFlKDQ8rynbRMhjI4vELvMcZp7MW0e6nuRO7+pPEDh5e0LdPbQze5lQq9yvNAWbWwbQX
         yAAOFiZHkNVwOLV5yOjMja9qtuxJmbNLSOcbVkPJqu3tZ44edXXbzzmCsLyG5tMHAl0N
         PUALWSn8m8LWPwZKv4sKBhbkrJdAGsRgpXijzQ6xQC2K9kIFNm7ZaimdMZXFFySC0HW+
         NkOg==
X-Gm-Message-State: AHQUAub419oVNgj7y18rZHbVpLveXMz6XMxfc1kktYcQNyqubokIoIYM
        umtQuIzZahOa1StpdmeOIoxLO+V1G+Q=
X-Google-Smtp-Source: AHgI3IZLiWqfFmfiSGvBh2InQpLcwSAc0ECojSAfOGNvR765HDT5vPo6Hs2k2ALpqGxBe9ZBB0eUug==
X-Received: by 2002:a2e:5d54:: with SMTP id r81mr2309878ljb.183.1550167024360;
        Thu, 14 Feb 2019 09:57:04 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id m191sm597159lfe.92.2019.02.14.09.57.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 09:57:02 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id q128so6008420ljb.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:57:02 -0800 (PST)
X-Received: by 2002:a2e:89d9:: with SMTP id c25mr3319314ljk.105.1550167022244;
 Thu, 14 Feb 2019 09:57:02 -0800 (PST)
MIME-Version: 1.0
References: <CAN1fySViLgrLAHHfTHMef-Bkh73kUHKP-ava6TbgALeSE4LfFw@mail.gmail.com>
 <CAFLxGvwpuxKF4UWdsULwQWo7kgVLMNHC=77dN+w-A0a6avrAXA@mail.gmail.com>
In-Reply-To: <CAFLxGvwpuxKF4UWdsULwQWo7kgVLMNHC=77dN+w-A0a6avrAXA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Feb 2019 09:56:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjtH5ombebghG-SDNGppJF4a5bZAUqndtZ3tauWjgw5_w@mail.gmail.com>
Message-ID: <CAHk-=wjtH5ombebghG-SDNGppJF4a5bZAUqndtZ3tauWjgw5_w@mail.gmail.com>
Subject: Re: Userspace regression in LTS and stable kernels
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Samuel Dionne-Riel <samuel@dionne-riel.com>,
        LKML <linux-kernel@vger.kernel.org>, graham@grahamc.com,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 3:37 PM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> Your shebang line exceeds BINPRM_BUF_SIZE.
> Before the said commit the kernel silently truncated the shebang line
> (and corrupted it),
> now it tells the user that the line is too long.

It doesn't matter if it "corrupted" things by truncating it. All that
matters is "it used to work, now it doesn't"

Yes, maybe it never *should* have worked. And yes, it's sad that
people apparently had cases that depended on this odd behavior, but
there we are.

I see that Kees has a patch to fix it up.

            Linus
