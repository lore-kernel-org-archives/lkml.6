Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F311C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26084217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J/1pEAYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfACUxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:53:21 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43655 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfACUxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:53:21 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so24062811lff.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 12:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mDNrvkxxd60+K6Wwm2FMQyhVxIavAJa512uq74mBQUA=;
        b=J/1pEAYoYy9n0QcxVBradL1P4NBR4Jn93gvg2ZoKIsLfcKzQNhdGEdt+zIdkExkT4U
         RZVoplZvjmjAGPwWdavkBNqpu/uKd8V/OAiQ9xuw9KgQGFT6MLJsAYFo7iFkup6ZZK8n
         fa5kPQ/5SRAGEbEPGmtu7hxgWJdXxLNh+ffis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDNrvkxxd60+K6Wwm2FMQyhVxIavAJa512uq74mBQUA=;
        b=FffWk9dNGaoBICcEnzXfQG5ZFk0KvX+nsr3i2YxSCbvKv9MJlVLSfTQ4gbLKnmImPI
         XTTYuugpnjlc9q5jEvVNOvyJqVWeImpNv7Rkxx+0HLzw6G8g0K77FO9z5uU5zMPcc36+
         PUcTHYGCGQnWNWQdu290fkgOMwNzRT6Dhn+fLLk2nduFJP5DjQrbiRXjJMBjOSuJtOjy
         E0DBpbP/bo1qjP4pK62n04LvHHxmV7EvhYxam5yL+5cjd5VUTkARu014F4KN+svl1kBp
         KYqL34IT9FV7C0ngPyYPB0KfnYotttUl8C57X8m+ilrsXGFQYkHcU+y2O8nNP06Jc6e/
         mVHQ==
X-Gm-Message-State: AA+aEWY9u7SGm2dSntUrTjYgsJ7siH521ruIBE/XWe6Zt4QUPdaHZ0b8
        8GlerSzTe18NL3Sa58ZlKtNLskHe+lA=
X-Google-Smtp-Source: AFSGD/VkKYgh2QoubQIafcix+aCPBO7QihQ6/iMYgzg9PlHfYM2xHytsgjDVKMcjtxqMgQyi3XW3Wg==
X-Received: by 2002:a19:f510:: with SMTP id j16mr23003204lfb.35.1546548797748;
        Thu, 03 Jan 2019 12:53:17 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id h203sm10886171lfe.44.2019.01.03.12.53.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 12:53:17 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id s5-v6so30783335ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 12:53:16 -0800 (PST)
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr20707080ljj.120.1546548796500;
 Thu, 03 Jan 2019 12:53:16 -0800 (PST)
MIME-Version: 1.0
References: <02d3ecd37f9390e7b8a7be8ec0e1cafb7fdbed26.camel@netapp.com>
 <CAHk-=whZkaZn1UQLad6v9vmfx8+BB3m8cvT0wcKdtg=k=FDbGw@mail.gmail.com>
 <87bm4yl4th.fsf@notabene.neil.brown.name> <55e9d0eb47662f2d6c308eba8b9a84fbba978ac8.camel@hammerspace.com>
In-Reply-To: <55e9d0eb47662f2d6c308eba8b9a84fbba978ac8.camel@hammerspace.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Jan 2019 12:53:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=whVxZ54i9uhXkWoaP+K1y4wu0J5z7d_mZ=-Zcpi5UhZww@mail.gmail.com>
Message-ID: <CAHk-=whVxZ54i9uhXkWoaP+K1y4wu0J5z7d_mZ=-Zcpi5UhZww@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS client updates for 4.21
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "neilb@suse.com" <neilb@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 10:10 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> The values being compared are in cred_fscmp() are all of type kuid_t or
> kgid_t so that means they have already been mapped from the user
> namespace into the kernel uid/gid space.

Ok, "everything happens in init_ns" is I guess a very valid argument.

It might be good to perhaps show that in the name (and maybe even a
comment), but as long as it's only really used for nfs I guess it
isn't a big deal.

Thanks,

             Linus
