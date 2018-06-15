Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8275BC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2936C208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SN2d/mxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2936C208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966078AbeFOQpF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:45:05 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38891 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964992AbeFOQpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:45:03 -0400
Received: by mail-oi0-f66.google.com with SMTP id d5-v6so9356721oib.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 09:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MEFaJhiXyNan8nBVc3ywGNwatyQN9rFssV/TKLDuqis=;
        b=SN2d/mxJ2goYBb70AhMmblYACvAkaFLsSlBc2ZhM5cyb+JhB9gJAwQV8Kz8NOdUlrI
         o1degSL5cPf5wJOETaOEV2bCVBfIyEqiSxGjclXdfxDsaOsgdPy2Ae4MupYWRyoPJqJ7
         uFAmzybxDYx4ODqQxNLO0QlWmhhaTdx+bwtlqaZl1iD5MJjO7Y0W3szVk8s0nNsyClFR
         BH2Ipu0pzuLlwy9W+jF/Sn1YehLQ6kp6Pwo+rnO9+nX2Fbqae7VuPLm6iIBQfHq6YMvO
         zkx6FWcl+sAlJaTeRshwrgsjsrVQcYVHvYEjXbVIIV5HKSPQ9wDc/Uu8unw7Bi9ArpKj
         pURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MEFaJhiXyNan8nBVc3ywGNwatyQN9rFssV/TKLDuqis=;
        b=EJv8r2WiMpHLnKJZCkOuHyXiDRJIIGsWZ5V96PgLiD58gtDRlain2LNdjnrqE+DUXm
         IcXam2WQgCwMNFvn66HHejPS3T8LQNvd64PunJXhoIm/JSzOFN9+Cvim9+oZSiDcp6sv
         9d1O8/XVLYfo7aiF06O17lg+q/yYpAOz+LvGsKpDZR7XFr700F97rO9Y0qbR8oteDHBH
         k6P9XgYCqJt04ihpnUjnF0WAp3cGFbek3yQZBHZ18Y7Ud35fzKX9qXaRh1nTboGTDypf
         3NzPOun/tNzbAjRW80mqA/IXkY7BZyuq/kKuePriZ6WTCh9hgTn7CvnxCqioMVQ7OPe8
         hjaw==
X-Gm-Message-State: APt69E0plGWWF/1x0YR/irdQW3IHgcZ3x3Lz91RqmI+ShVqGyWqquTuD
        gh4Bzco7JEA2FzjDBdVunBDcWPCiUcT+eVpjAh0YoA==
X-Google-Smtp-Source: ADUXVKLBAlbs3rze3jgXzRNYgEIXnR0XfjQtCHZSOKBCwoPpYtRRQjd3pEG9GqMtTJiPVQMIbG+HUwDsnOOTcBCWE1Y=
X-Received: by 2002:aca:6b03:: with SMTP id g3-v6mr1211431oic.219.1529081102715;
 Fri, 15 Jun 2018 09:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180615152335.208202-1-jannh@google.com> <20180615164009.GD30522@ZenIV.linux.org.uk>
In-Reply-To: <20180615164009.GD30522@ZenIV.linux.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 15 Jun 2018 18:44:51 +0200
Message-ID: <CAG48ez2Fku77S+FM2w5n8J_utOhO0EW_RFbMib=t5Nmwc9pwfQ@mail.gmail.com>
Subject: Re: [PATCH] sg, bsg: mitigate read/write abuse, block uaccess in release
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     axboe@kernel.dk, fujita.tomonori@lab.ntt.co.jp,
        dgilbert@interlog.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 6:40 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Jun 15, 2018 at 05:23:35PM +0200, Jann Horn wrote:
>
> > I've mostly copypasted ib_safe_file_access() over as
> > scsi_safe_file_access() because I couldn't find a good common header -
> > please tell me if you know a better way.
> > The duplicate pr_err_once() calls are so that each of them fires once;
> > otherwise, this would probably have to be a macro.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
>
> WTF do you mean, in ->release()?  That makes no sense whatsoever -
> what kind of copy_{to,from}_user() would be possible in there?

bsg_release -> bsg_put_device -> bsg_complete_all_commands ->
blk_complete_sgv4_hdr_rq -> bsg_scsi_complete_rq -> copy_to_user.
I don't think that was intentional.

Basically, the sense buffer is copied to a userspace address supplied
in the previous ->write() when you ->read() the reply. But when you
->release() the file without reading the reply, they have to clean it
up, and for that, they reuse the same code they use for ->read() - so
the sense buffer is written to userspace on ->release().
