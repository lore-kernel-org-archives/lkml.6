Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF470C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C079D21773
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZCeFZorK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfBQWQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 17:16:02 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38274 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfBQWQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 17:16:01 -0500
Received: by mail-vs1-f67.google.com with SMTP id t7so8571051vsq.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 14:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PjHkEiAHgyCptBIPeBD7i1m3I3cu+ZyBHKVX7yI20WQ=;
        b=ZCeFZorKQHJuvIxZqvLwQweRNFz7SsjrYI/F6WAcyepZrljHEzsGdE1sa4oIVq7H0I
         JVPW8Ov1LByRHgZd1WUdMrwJOXc49a18jlYCTN3ft4SFz/8ru5W4au8MauloUsb0A3rr
         mxk4E4LEKNmnYL3b5IAOSV67Lbv8fVmGMqR6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PjHkEiAHgyCptBIPeBD7i1m3I3cu+ZyBHKVX7yI20WQ=;
        b=E/W/f4oohVRCUwEblH1yDvgnJMAGHK5dQuLTcZtGAuKVFPxfErQYlcIWmoxx7O3bJb
         T2B5O1jKzLVxnydhCqOizlwltBYZ96+R7H9yMw+vP++abm2qpSrbV24alGzkRLBtFYFs
         DDC0uDwHxyWCd8ntnLsDJTips1ow7KgvUi7JDQJd1YrR3IBZUH516Whbb3eSc/jZ6kEg
         2UPwfHhrBR+SAaM/oLxNnJywAnx/7xl8hNLNXrNKrg/ayNMNpChBo3N6gxXE24TDje9h
         pn04GOne4biq6TtdBznzn7bDIfzjJoPOAydnz2iIDwg62Barj+jmXv/rgec5QPCnN8hE
         u3Kg==
X-Gm-Message-State: AHQUAubNIfNFapr4tOZQuI4cgFKfLtssGXBVkg1lOsaGbIcufS5aEdm/
        NcNnHSxWWcK51LlvZm/EmTFOMqbGiWU=
X-Google-Smtp-Source: AHgI3IYnMcU6+WrVOJ6kM9KyxayWjH31kGLlt0REjezXDQekKHCE/UOqXTsMfnMrbn1EJdEFBzyVwQ==
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr4314445vsq.215.1550441759824;
        Sun, 17 Feb 2019 14:15:59 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id t133sm10787247vsc.8.2019.02.17.14.15.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 14:15:58 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id t13so8575941vsk.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 14:15:58 -0800 (PST)
X-Received: by 2002:a67:6f44:: with SMTP id k65mr9831152vsc.222.1550441757864;
 Sun, 17 Feb 2019 14:15:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549540487.git.efremov@ispras.ru> <CAGXu5jJ8DaoXk4Vt-K_Tgvpe4=wgHZ3Z1Y=D8JzRHU9n=bvgtA@mail.gmail.com>
 <67ff280b6867b9a594ee16b2ad83bb7f@ispras.ru>
In-Reply-To: <67ff280b6867b9a594ee16b2ad83bb7f@ispras.ru>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 17 Feb 2019 14:15:45 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+VMU3LT77KkyoAwuVAemfM0mayvBcy3Y0K_a7UDBL=ow@mail.gmail.com>
Message-ID: <CAGXu5j+VMU3LT77KkyoAwuVAemfM0mayvBcy3Y0K_a7UDBL=ow@mail.gmail.com>
Subject: Re: [PATCH 00/10] LSM documentation update
To:     efremov <efremov@ispras.ru>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Paris <eparis@parisplace.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 10:04 AM efremov <efremov@ispras.ru> wrote:
>
> Kees Cook =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2019-02-11 22:28:
> > On Thu, Feb 7, 2019 at 4:45 AM Denis Efremov <efremov@ispras.ru> wrote:
> >>
> >> Recent "New LSM Hooks" discussion has led me to the
> >> thought that it might be a good idea to slightly
> >> update the current documentation. The patchset adds
> >> nothing new to the documentation, only fixes the old
> >> description of hooks to reflect their current state.
>
> >
> > Do these fixes silence any warnings during the documentation build?
> > (i.e. how did you verify the results beyond eyeballing the changes)
> >
> > -Kees
>
> This LSM documentation is not used during the documentation build.
> At least I can't find it in the resulting build directory and at
> the online documentation on the kernel. Most of the fixes are pretty
> obvious and can be checked by comparing an lsm hook declaration and
> its description in the LSM comment from lsm_hooks.h I tried to be
> exhaustive in the commits description and in every case to reference
> the original commit where the interface was changed without
> documentation update.

I'll send an official patch that'll hook this up. I've been meaning to
do it for a while, but there were several things that needed cleaning
up (and you've snagged most of them). So with this patch, you'll be
able to check the output for "make htmldocs" for lsm_hooks.h errors:

diff --git a/Documentation/security/LSM.rst b/Documentation/security/LSM.rs=
t
index 8b9ee597e9d0..31d92bc5fdd2 100644
--- a/Documentation/security/LSM.rst
+++ b/Documentation/security/LSM.rst
@@ -11,4 +11,7 @@ that end users and distros can make a more informed
decision about which
 LSMs suit their requirements.

 For extensive documentation on the available LSM hook interfaces, please
-see ``include/linux/lsm_hooks.h``.
+see ``include/linux/lsm_hooks.h`` and associated structures:
+
+.. kernel-doc:: include/linux/lsm_hooks.h
+   :internal:


--=20
Kees Cook
