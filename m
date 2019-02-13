Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11602C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1723222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="t9YtLza2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732539AbfBMBT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 20:19:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42115 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729726AbfBMBT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 20:19:58 -0500
Received: by mail-lj1-f194.google.com with SMTP id l7-v6so525674ljg.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 17:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xnkDfVf4SGI03SpmRWdCoG+y4nfPwJ06HT5slCJLq5o=;
        b=t9YtLza2Am2n0S7+cStjWAlW/WTre/vvAIwMRhk9xGtBVno1IZ1M53Ib74ZcWJttDC
         ksvM/pqrMSbVRca3SgM8KaAypn22GBpxgvYCk4GQb9Btpbo2Lsfrwpnerd2l8u3AkuKg
         v/jTUIRmBkPEd54aThr4aVLKDzdVTd/v7Pd/TllsS6Y7aCpnGfb2WgCyShA3EpY8wnsc
         aAbfbMTY05fiHu6B+VKnZB/sasFO1hieksdeTIpZVp2193Luvuf594Zyp2nwJtOrWkKp
         6+EAr1cgE559riK135nD+BsMconbncHV4zkKcSoSCC4BcUnlk1kOEwWJLtEuNjEOjU+g
         RJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xnkDfVf4SGI03SpmRWdCoG+y4nfPwJ06HT5slCJLq5o=;
        b=TN2lLqJeaF7CJHRZjS+ToPv+71/JccfX/4PTD7dXXxHP5Zj/YPlDPzVTSqRQfe5toJ
         enrmzYEqI2cz+PFFljp9FxgEhwYe2YBM2kc57IAIJe4SOmhVwIEHwRqp4OX6V2RJmoMO
         hsq/TON5Q7MUW02sqa7GWcQ9/RrGYX6e429feeuJ1I5fP+RkO6s6t/pI90u44MJTss3i
         BuBKOul/pUdHe3Hpt6wuNHh9s61TSKTRpwhIfWeIvObfq7eXvsBRUnh/QHBGfFDzjpWC
         QX7EnB0QXJoctj4GX5h/v8B7q0AK25Z6DOx3AFatvPncD0tJgQ0Y8x1YNDOLlmM7uxwg
         0q9w==
X-Gm-Message-State: AHQUAuZ71YqXWnYDpe84U5UOAYTN7w1hklRhc7OqOgURwA7a1vBAEoTF
        kJcuDb09XC6T+vYLIWgD5P3VT/y9tOTpX85/2opR
X-Google-Smtp-Source: AHgI3IbKuT/WH2fhcS62whmr3HnE9sFuLzTqra1KKdpHoPoglAyV5YW4rGnh3Gv+Im34vy5POE3GmH6BkvGW0ZP9bD0=
X-Received: by 2002:a2e:9bc6:: with SMTP id w6-v6mr3819652ljj.196.1550020795515;
 Tue, 12 Feb 2019 17:19:55 -0800 (PST)
MIME-Version: 1.0
References: <20190212204600.GA24049@embeddedor>
In-Reply-To: <20190212204600.GA24049@embeddedor>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Feb 2019 20:19:44 -0500
Message-ID: <CAHC9VhQfru298ZbEDwEqj0+YRAYoAGhAVHEtSo3KBW1kKLputw@mail.gmail.com>
Subject: Re: [PATCH] audit: mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 3:46 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warning:
>
> kernel/auditfilter.c: In function =E2=80=98audit_krule_to_data=E2=80=99:
> kernel/auditfilter.c:668:7: warning: this statement may fall through [-Wi=
mplicit-fallthrough=3D]
>     if (krule->pflags & AUDIT_LOGINUID_LEGACY && !f->val) {
>        ^
> kernel/auditfilter.c:674:3: note: here
>    default:
>    ^~~~~~~
>
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>
> Notice that, in this particular case, the code comment is modified
> in accordance with what GCC is expecting to find.
>
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  kernel/auditfilter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into audit/next, thanks.

--=20
paul moore
www.paul-moore.com
