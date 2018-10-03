Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB693C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBE72082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wq0qkVIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBE72082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeJDCRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:17:07 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35147 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbeJDCRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:17:07 -0400
Received: by mail-oi1-f196.google.com with SMTP id 22-v6so4525817oiz.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 12:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=emBY4lqvt6Nu1ueMxP0AlDqpdlBjsmsn5K2CfTLsJPA=;
        b=Wq0qkVIvza82rD11m2xzUVkwIx/BT1oJiPNwWVbB9ArLu0TRRKlEQDvg9Oq4rGn1Rg
         U+DAjEqKpxij0xmvpmlb5YMLGCKiVtckeis3SEnz7pKRJAofoq7bAwsybTj6iFFSR8SM
         /b9ABlyeO5bTuOZeihhEkxgBeigG93Pfz45dPvbmY9RbBuo7hA58sdJP0EB9Momrklb7
         zLcx3a2f9euj9Eyz0kCcMm2TyHIcIkB8WpjsObIdpsnKLjl73KwosIFbZ50oFhBqaqLj
         nmvoeGOnK/dVP1qWouvqtQ7j34kHBdR7trzA4X8lNK/dPPVr/tzycRbSKSKnU+3VdNHf
         PXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emBY4lqvt6Nu1ueMxP0AlDqpdlBjsmsn5K2CfTLsJPA=;
        b=el/JDcc3MKzugE6/OcEcl5ihFwKUKORFQFO3t8tmVyRT7/H9V/aPJmA1F9HSmJ850/
         8D+1xneF2O4EzpQ6K7tmtGU1vNUlkh5HaW1McGz9zasCld/W8yIIMsK1uHsTtXg4u8d2
         nIxcztZDNVDcfERXau2+gK1ZEbIWh8CkEaCtbYR5Ekox07vj+0qLNPCQscb7cE3XGa0A
         yUr6WlIAqnAStATyMja6afWJ8zeR1wHP6Rm3G4tgLdlgNyRm7U7X5NYodafrt0ss9xoA
         clxSoRKTi5d3SJmzXdaFRshn5y7gAT6azIbRU3RhiwUpj27rRmoyty7377fS+R0i59rl
         kkqQ==
X-Gm-Message-State: ABuFfoihBNq11fm+jqpx0/fa4tNcAqJXxIMhsvqeJn496OTlQB8ouOPL
        p/ItMf96lT0t5gfp4AJOG3WKc6mHJwdxzfRFmv/lUw==
X-Google-Smtp-Source: ACcGV61BUP/ShUFFV/eljIHpXHhERg0ZpX9MsRY2KVwNaoxpdFKjPTVHtrVzXX5BYXD8cEI/gXGdkjQU+zTgMhMog48=
X-Received: by 2002:aca:3b45:: with SMTP id i66-v6mr1478082oia.312.1538594842724;
 Wed, 03 Oct 2018 12:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181002102054.13245-1-laurent@vivier.eu> <20181002102054.13245-2-laurent@vivier.eu>
 <87o9cbo96j.fsf@xmission.com>
In-Reply-To: <87o9cbo96j.fsf@xmission.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 3 Oct 2018 21:26:56 +0200
Message-ID: <CAG48ez3OrkmBUyL6pS=bSHL-NzdPP8z-tD6hSDYDGyL_R25XDg@mail.gmail.com>
Subject: Re: [RFC v2 v2 1/1] ns: add binfmt_misc to the mount namespace
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Laurent Vivier <laurent@vivier.eu>,
        kernel list <linux-kernel@vger.kernel.org>, dima@arista.com,
        Andrei Vagin <avagin@openvz.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 8:07 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Laurent Vivier <laurent@vivier.eu> writes:
> > This patch allows to have a different binftm_misc configuration
> > in each container we mount binfmt_misc filesystem with mount namespace
> > enabled.
> >
> > A container started without the CLONE_NEWNS will use the host binfmt_misc
> > configuration, otherwise the container starts with an empty binfmt_misc
> > interpreters list.
> >
> > For instance, using "unshare" we can start a chroot of an another
> > architecture and configure the binfmt_misc interpreted without being root
> > to run the binaries in this chroot.
>
> A couple of things.
> As has already been mentioned on your previous version anything that
> comes through the filesystem interface needs to lookup up the local
> binfmt context not through current but through file->f_dentry->d_sb.
> AKA the superblock of the mounted filesystem.

Something else: bm_register_write() currently calls into open_exec(),
which uses the credentials of current. That's not really allowed in
this context - but so far, it's not a big deal because only
init-namespace root can reach this code. Before you expose this stuff
to unprivileged userspace, this needs to get fixed; perhaps by
wrapping the open_exec() call in override_creds(file->f_cred) and
revert_creds().
