Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ADDC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526A3214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="wZUGcj+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfAJWjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:39:22 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45822 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfAJWjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:39:22 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so11168809ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HerCI6x72aK/unfghompPS+3GXnGXLRR1SYSYzM94fo=;
        b=wZUGcj+oNT6/4EijTtqAfspYYeOHZbiGuRAnweKufniuFJhXEepvH5lVQSoqfGgw9U
         9r3p97Kbe61UvWf1YKC8O8O19uHyeKVfO38M9e9D9/3KWsj9Mua8FY/jm5rS4Z56n/WX
         vmeGxTLlWSK5ckg8nQXltl8ujvlN9/sZj9q0pEBvd17fCZX8R6gSCKPZZRDsTw3BSh9i
         lkumzl8FkiG21g5m6ZY6pPcV6dikkAbMsDDf/E1HTjOjmw0GNhX5xQBc2GKPBD984+Bn
         6sGKpxrvFYNKfiCzT8k//Ve9nE/RNUPUW11qaramEKGOt4/AKrU+gIVBdXf7Oec9eMsD
         eJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HerCI6x72aK/unfghompPS+3GXnGXLRR1SYSYzM94fo=;
        b=CucHO5xXOPolRxZpIaIAHH8NgUC54AH3hgZZJqPm5Ym6ZQrxrID4yNsh1LcD1S7dKO
         mHg62e+5UItquqqBchZmGWeC4IJ/OluMKYSvoYic8J9HFiglg38XS/SQHMHvhDmwr+xV
         AuLXJnZcZRQ1waR1vr9gMifkQn4WasMu59x+EIwx8dqzyxiFSHYn7a2B3MZYGTYc8agD
         gWxTfiozElgUeNPhhkvneMm6vtEHh6ylFqVwd7MYhHMeMpMhDb84MBizzYI+uW3DEdmj
         nAFkY3xHyLCR162OYptbb4S4kBdjhdzP/kgtc9i+Zy6z3Ta+WWopm/emCFWvbqO9ZThX
         kYyw==
X-Gm-Message-State: AJcUukfFldKVOHBxfwEnIGAQyXpm39hW8MrKUos4LKzLCWeQaqXYkQWh
        VuNFTJfri1S3VrXS5iAbEItLLOTYo29G3AP16x0M12HVXg==
X-Google-Smtp-Source: ALg8bN6NH+DRolYzMBkgJOOmCwBMw0d+ECJQ38/tlUHbfcTh6fk9vzfJIDjSOpesKUVXWmZ48Dmo1ext5d2OvLeT26E=
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr6056687ljh.174.1547159959961;
 Thu, 10 Jan 2019 14:39:19 -0800 (PST)
MIME-Version: 1.0
References: <20190108213504.GA32901@beast> <alpine.LRH.2.21.1901110733060.7043@namei.org>
 <CAHC9VhSma5JCGf6Fi9NS1841kuWAKm4h9d7qW94yJNEO5t8oHg@mail.gmail.com> <alpine.LRH.2.21.1901110858130.11115@namei.org>
In-Reply-To: <alpine.LRH.2.21.1901110858130.11115@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Jan 2019 17:39:08 -0500
Message-ID: <CAHC9VhSrj857SxvLx45O22pYbEf0SvWk+ZERTFJaoQkK6mcxmw@mail.gmail.com>
Subject: Re: [GIT PULL] blob-stacking updates for security-next
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 5:00 PM James Morris <jmorris@namei.org> wrote:
> On Thu, 10 Jan 2019, Paul Moore wrote:
>
> > > Please test!
> >
> > While not exhaustive by any stretch of the imagination, you might want
> > to throw the audit-testsuite at it too.
> >
> > * https://github.com/linux-audit/audit-testsuite
>
> I'm seeing lots of failures with vanilla -rc1, probably much to do with my
> kconfig:

FWIW, v5.0-rc1 passes on my test system.  What userspace/distro are you running?

> It would be good to have a defconfig to merge like with the SELinux
> testsuite.

Yeah, the audit-testsuite is still pretty rough, there are lots of
things it needs.

-- 
paul moore
www.paul-moore.com
