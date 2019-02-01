Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2540C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC6D21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v4osqDLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbfBARjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:39:12 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40443 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfBARjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:39:11 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so6700366oth.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 09:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q6eGdR/xa572X12OFk0Sj77FbEadZDBfSU+uAkxjJng=;
        b=v4osqDLy5AjjRqEVka7fJ0VsaCO37tSifjcgX/3wrkz+rpbcuYmf+872eeEm0rBJZg
         fVJ3z/nhs6b5mr1v29sK6UtekgWB2z43EZaTmw8fgGo160zrBMzpqO42v9pWl8lBZ1yA
         3yWxxWlDGxO9oPAYisIPxa8skstK4IPzQrxp2WfPiDjVX78gGQ8ElE3lVrVOgSIkujs8
         xZ9dJSScxmgnmnXwF1jFuudQF03aPi3itm5ki0BGStv338XrVf+T4wYeqZbswfKyOtzL
         EbBC6Or46HJmBS888bb6gRhkPZCbQddg0sLfHz8eIgnbDQQ+Ms9nMEXyTnPUFhwtkJiR
         SfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6eGdR/xa572X12OFk0Sj77FbEadZDBfSU+uAkxjJng=;
        b=TTtI1Oo2mjPRBE0O6WF9vkd7uvTnmN5i/G6FOi91GzQd/U6663PJelqbOJmZPYQzxv
         oW25zs8YZGu529Gttq20unKMcKu8UsUe5UqT5dyrpcQkoKkHQ9MMDNC+JYbxJ0WkHFJ8
         evRcMYxgd5fTLA1YVq1fvXvbLpg4AEIn3OgsORoGpdnrSRKIevrLH8br+I7WexW8Pfc6
         hSdbrwawcuAmsT8Uk8dVaAVBVjaAad4BsBc/EvFAP6NJyWXKSzy5rPJHxlSmZvijORVH
         ZwUBJqDkcZxHG+t8rc9cRa/aNNZQMgHK0A78BMDJh324UcqL+59BIugF16o4NsZmi4SU
         hiiA==
X-Gm-Message-State: AJcUukdUYC+U45Jih1LtDJpnwTNXh74QaNoNyfoVQoBl9QENg+llK13U
        1T2tqVaGI8SKc3dfChdMhboqiuTLAW4sezdn6EhdtA==
X-Google-Smtp-Source: ALg8bN4HShL98q10h4fYiXj45YQz+tYARVFLDLvXcOFI8tYaP7iGio8REmi2lhz88bLmX0yUFv8eyEX2q88WzW6v0WI=
X-Received: by 2002:a9d:638f:: with SMTP id w15mr28173066otk.230.1549042750594;
 Fri, 01 Feb 2019 09:39:10 -0800 (PST)
MIME-Version: 1.0
References: <20190129113159.567154026@linuxfoundation.org> <20190129113207.223846678@linuxfoundation.org>
 <CAG48ez2KSRFkRCHdvOhZSsNkdWw=jq8yu9OvUPswsA3i6mq73g@mail.gmail.com>
 <20190201140852.GA20335@kroah.com> <20190201144531.GB9864@kroah.com>
In-Reply-To: <20190201144531.GB9864@kroah.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 1 Feb 2019 18:38:44 +0100
Message-ID: <CAG48ez2NvXwWbQvznDRyftT24NuaTVEh7TTNcu8Xj_aUCzGWxg@mail.gmail.com>
Subject: Re: [PATCH 4.19 095/103] bpf: prevent out of bounds speculation on
 pointer arithmetic
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 3:45 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Feb 01, 2019 at 03:08:52PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Feb 01, 2019 at 03:00:18PM +0100, Jann Horn wrote:
> > > On Tue, Jan 29, 2019 at 12:47 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > 4.19-stable review patch.  If anyone has any objections, please let me know.
> > > >
> > > > ------------------
> > > >
> > > > [ commit 979d63d50c0c0f7bc537bf821e056cc9fe5abd38 upstream ]
> > > >
> > > > Jann reported that the original commit back in b2157399cc98
> > > > ("bpf: prevent out-of-bounds speculation") was not sufficient
> > > > to stop CPU from speculating out of bounds memory access:
> > > > While b2157399cc98 only focussed on masking array map access
> > > > for unprivileged users for tail calls and data access such
> > > > that the user provided index gets sanitized from BPF program
> > > > and syscall side, there is still a more generic form affected
> > > > from BPF programs that applies to most maps that hold user
> > > > data in relation to dynamic map access when dealing with
> > > > unknown scalars or "slow" known scalars as access offset, for
> > > > example:
> > >
> > > Is this also going into 4.14 and 4.9? I don't see anything related in
> > > the stable queue or in stable-rc.
> >
> > Ah, the original submitter did not send backported patches, but you are
> > right, it should go further back.  I'll see how hard it would be to do
> > the backport, thanks for letting me know.
>
> Ok, no, there's no way I can do this backport.  It didn't apply cleanly,
> and trying to take the patches prior to this resulted in a huge mess.
>
> So, it would be wonderful if someone who knows the bpf code stack could
> do this and send it in.

Daniel, Alexei: Can one of you do the backports to older stable kernels?

Given that the 4.19 and 4.20 stable kernels are out, I'm going to
derestrict the entry in our bugtracker now.
