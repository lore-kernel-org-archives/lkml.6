Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BFEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E0C20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfAQQQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:16:04 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35833 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbfAQQQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:16:00 -0500
Received: by mail-io1-f65.google.com with SMTP id f4so8289373ion.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:16:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UW09jR3Mveve0o0eJuP8KVFDA8mbcGUIfd5CQdcZIws=;
        b=f475kLTKY2xcvvkez6Thm/MStl/V/Q7oz5Rk7DhgEtsKVimwferZygbBffVpwxOfWY
         v6BWhMbXSt4lPt/DXAxI4cKUC/MYYX8/GetREk0rmzk3HLg88TOWUmy8JJutIJ8ys1pj
         dWcumKi2rSMggbnIVaW4O7R/vSYzdG6Ccm32lYADfjnlADK/Ia0lN19wv8gxANprJ+23
         0Qlcpwdz7fB7Z49bEzfr//6XOJbdjzXpr1nHSQWHDe5sn7OlmEkGjiq6UXlY5EdIkU7q
         HTIxPWZ1/GUB4KvcgoHM2+TFVC8HHSFEr5kmCepCdOpFxfXJA3GTdfW2LECsXNr7XkLx
         Z2DQ==
X-Gm-Message-State: AJcUukcPD3Gmh1TaUUta8uwm7Wgm5lYQ0pXdxbnvCLNvmEL3X55UO2dO
        GN1j1k4NI7ZCbeW2ETnHkpYYwEWRZV5cthn0d1xmLQ==
X-Google-Smtp-Source: ALg8bN52KM8X0AF3Wx3aoXyIXVVHq97XuckimlopFRekQrSjx22en+lXPLUTy30tMoN/zEaeNx7wFEu+3pEjfONzN7c=
X-Received: by 2002:a5d:8889:: with SMTP id d9mr8587221ioo.68.1547741759718;
 Thu, 17 Jan 2019 08:15:59 -0800 (PST)
MIME-Version: 1.0
References: <20190108081247.2266-1-kasong@redhat.com> <20190108081247.2266-2-kasong@redhat.com>
 <21896.1547737461@warthog.procyon.org.uk>
In-Reply-To: <21896.1547737461@warthog.procyon.org.uk>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 18 Jan 2019 00:15:45 +0800
Message-ID: <CACPcB9e9ibefCgdMfKjAXV69BOoDWEmLe7K=hGG3UHW0WXeVLA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] KEYS, integrity: Link .platform keyring to .secondary_trusted_keys
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com,
        Mimi Zohar <zohar@linux.ibm.com>, bauerman@linux.ibm.com,
        Eric Biggers <ebiggers@google.com>, nayna@linux.ibm.com,
        Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:04 PM David Howells <dhowells@redhat.com> wrote:
>
> Kairui Song <kasong@redhat.com> wrote:
>
> > +extern const struct key* __init integrity_get_platform_keyring(void);
>
> This should really be in keys/system_keyring.h and probably shouldn't be
> exposed directly if it can be avoided.
>
> David

Thanks for the review, I've sent V3 of this patch series, the
implementation changed a bit, would you mind take a look of that patch
instead?
https://lore.kernel.org/lkml/20190116101654.7288-1-kasong@redhat.com/

-- 
Best Regards,
Kairui Song
