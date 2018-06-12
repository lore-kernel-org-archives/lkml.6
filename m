Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F2FE3C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A808E2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="xTpD9KVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A808E2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934269AbeFLVM2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:12:28 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33900 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933852AbeFLVM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:12:26 -0400
Received: by mail-lf0-f66.google.com with SMTP id o9-v6so624263lfk.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 14:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EJyhxvbi3HsrNfbsh3MGJpj5otQ1ywoDBTL8Ie3Co8c=;
        b=xTpD9KVPL5WjBiUhqqYtCG/jsP0ckivZETwZIVTy4XfLwTEm0nQ32osy/l27oUrwCR
         f5OdAbFbnh+a3PTEwx5wo7DAQorjLxiuP9W0YfVjrIC3xl26snIRyI/54XsRDlFPBzTd
         Ix3Ul7mEjxscOcSZNXsD2w9rBy6mHZNYHoAnq3bhIR/wlgKok0uTdn3yZ0lK34UvTFSe
         zpeRZjMA/9R/R4/0B6M02SuKDqMilUIi6h102HxlG30kpsEOyZiT0sbzIzi3eLaEyLud
         mOPMuOktiB03nQsOGiUHVv+fda+18OjSYcN8COF2UozwiyWCH/5qS92d50l6og7pcz/y
         x+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EJyhxvbi3HsrNfbsh3MGJpj5otQ1ywoDBTL8Ie3Co8c=;
        b=Dpr71Ug15bcWdQL8a173fsHRmAPssuXd+mrR6QC6niv49SKIMLKZgBErIWV4bYQNmZ
         olewqd5BNZzb3L44c4apzuiRnGO5DSpKuu/N7VfSsXP8kyEXupBVYC4gFub2hee76bo/
         0WZZu+rOnCAzpxHbcPzE40dLMPNtcHK4i74jF6sNbdD+IjHYqHO0/N9a4mldGGG13qz8
         wqZAT0qPMuVGpu07du4AX1g0WZjW5bNkrND581kFKLq91m0l9vnJdT33D0OCv+jnONG1
         W6Y1/N9DNr2/xqV0FjXSKETO2k2OwWw3N2IAiU1zlDT+obmXgWz07rCMNOnwlTTCg8tT
         D88A==
X-Gm-Message-State: APt69E3JtCAQQBrdyceIOdjbj5zGkMTVBfoAceKP4nZOQjNH8zzcTNEI
        cXqOczum1/1A8CX4g0ekWfI2b6YSXoLNyhxyCNc+
X-Google-Smtp-Source: ADUXVKK3MfTCvCs0p8R4P80DX8GuzMaa17EytEkwztsZAzVppemMLRIZFX2bmbKnvu004pfZvN/MfwM36NQqX3hw8iw=
X-Received: by 2002:a2e:9e57:: with SMTP id g23-v6mr1285759ljk.14.1528837944493;
 Tue, 12 Jun 2018 14:12:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a911:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 14:12:23
 -0700 (PDT)
X-Originating-IP: [108.20.156.165]
In-Reply-To: <alpine.LRH.2.21.1806130631400.13763@namei.org>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
 <fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com> <alpine.LRH.2.21.1806130631400.13763@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Jun 2018 17:12:23 -0400
Message-ID: <CAHC9VhTpsYDT5+CjdtiBmLMDEKV9fmGv+DyXVtUuja9d4i2ecg@mail.gmail.com>
Subject: Re: [-next PATCH] security: use octal not symbolic permissions
To:     James Morris <jmorris@namei.org>, Joe Perches <joe@perches.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 4:32 PM, James Morris <jmorris@namei.org> wrote:
> On Mon, 11 Jun 2018, Casey Schaufler wrote:
>
>> If you want to break this up by security module I would take
>> the Smack part as soon as James does the tree update. If James
>> wants to take the whole thing at once you can add my:
>>
>> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
>>
>> for the Smack changes.
>
> It's probably simplest for me to take them as one patch.

I would prefer if the SELinux changes were split into a separate
patch.  I'm guessing John would probably want the same for the
AppArmor patches, but take his work for it, not mine.

Joe, in general I really appreciate the fixes you send, but these
patches that cross a lot of subsystem boundaries (this isn't the first
one that does this) causes unnecessary conflicts in -next and during
the merge window.  Could you split your patches up from now on please?

-- 
paul moore
www.paul-moore.com
