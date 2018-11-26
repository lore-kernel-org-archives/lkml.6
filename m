Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56668C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C875E20659
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="s9B7TcFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C875E20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeK0Dcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:32:45 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46414 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeK0Dcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:32:45 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so17185985ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 08:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCb6Cs6h+3Q7l/bcyht4RJCurXTr9JqmSQD8zuWtS3M=;
        b=s9B7TcFtf3qJWmzKQK1XmrUmwCtm4LY/Dj88p3enGKkdMpbPF/QjbWyBgOX445jLH0
         0raYpStDoer+R5g3Yf3eOsRWZNxdfdRCAeyEUpHmXN7Po69b9CFlzCXYNGiZ7GwHnNDh
         8LLOHQUgObqRxVbEAznGAu3N3IfPRO8N6JRyGLJOmtMS8xWflGSapvvR+dWkUR13Ix3+
         uUVQyoPUrW0Msh8g6rcIY5vRBHUGexkhP818M4TLf3DKpUnM27JuQWw73OXx+KBwPiAh
         on0+ig5LiWzlCaKYndh0PJQr6mu3Ewu8EsvpjH0HdNPnT8vTE14rkdzRF+KbsxVTnx5Q
         jKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCb6Cs6h+3Q7l/bcyht4RJCurXTr9JqmSQD8zuWtS3M=;
        b=i1mR2v9Uj9Jn6KY7f02ITvpo28Mem1Ni1YEqh62Dz1ZenvtHQ+EgyB2CybHTpxb57h
         0cKMD4DY4cdw2g6ecAy3DZ2WquP1GJqTnEYE40o2PXY9p4T52zKM9TtcPUD6kcIubqeG
         J3CGXkMzFN2mfaG2ycmw0Q0plVadiAxOhDG7KaybQ4XKcAdo8dcLdX90GHXD1OABe9zI
         qGzIJO686glY+ytCFh2fzP+H41UFBi/hJdN8q+hGVEQu8Ae8JOElvZ0gQW4n8OvWL7Vd
         dELNyOV0MBAOUn/QHZj/+l678YVjlf7F78Tdw0TQ2+EFfGBpeiRw92ZeBu/R7SDoozOx
         56RA==
X-Gm-Message-State: AA+aEWauwHbMvCn9EeQm5iV6lHLkiPpH4JXRT+CJsksa444aYrU+oxVh
        k421jjgdnj1e8pWJPeKp/qkH//0y1uj6jYRLNHqI
X-Google-Smtp-Source: AFSGD/V+Kt4Em2mIeIwgpYAG+00aQBehKdL0+ScI17bWgOJy6Rd89DCn4f9d9zTwtftdAZkM0/wvYjrzvYLLUofPuRE=
X-Received: by 2002:a2e:8945:: with SMTP id b5-v6mr17586247ljk.55.1543250285732;
 Mon, 26 Nov 2018 08:38:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1518435853.git.rgb@redhat.com> <7289e57d94a0a13965e3dbd279cc8cd12dfb29a6.1518435853.git.rgb@redhat.com>
 <CAHC9VhRv_F=Gqs7EyTR2ZmLtJobyH9B8Cg-iiHE5hacTC-d=Pw@mail.gmail.com> <20181125171115.su4kuu44lazqw56n@madcap2.tricolour.ca>
In-Reply-To: <20181125171115.su4kuu44lazqw56n@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Nov 2018 11:37:54 -0500
Message-ID: <CAHC9VhRpYpkVN5fan91g96YuR9GjT=6TbV7vngtS1Crm72+Knw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] audit: remove arch_f pointer from struct audit_krule
To:     rgb@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 12:11 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-02-15 15:42, Paul Moore wrote:
> > On Mon, Feb 12, 2018 at 7:29 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > > The arch_f pointer was added to the struct audit_krule in commit:
> > > e54dc2431d740a79a6bd013babade99d71b1714f ("audit signal recipients")
> > >
> > > This is only used on addition and deletion of rules which isn't time
> > > critical and the arch field is likely to be one of the first fields,
> > > easily found iterating over the field type.  This isn't worth the
> > > additional complexity and storage.  Delete the field.
> > >
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  include/linux/audit.h |  1 -
> > >  kernel/auditfilter.c  | 12 ++++++++----
> > >  2 files changed, 8 insertions(+), 5 deletions(-)
> >
> > I haven't decided if I like the removal of arch_f or not, but I think
> > I might know where your oops/panic is coming from, thoughts below ...
>
> Have you decided yet if you like the removal of the arch_f pointer or
> not?  An updated v2 was provided the following day:
>         https://www.redhat.com/archives/linux-audit/2018-February/msg00059.html

I still think I'd like to keep it as-is for now.

-- 
paul moore
www.paul-moore.com
