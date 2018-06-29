Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977C1C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486AD27A7D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="nN+VuIzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486AD27A7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967542AbeF2AXQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 20:23:16 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42128 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934116AbeF2AXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 20:23:15 -0400
Received: by mail-lf0-f66.google.com with SMTP id u202-v6so5513041lff.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 17:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=poJidiszCBRirUJNXfXCf1Ah3zwYRAU9HpEcfUG9lY0=;
        b=nN+VuIzh6F5wwQTl08UL16ZeW8aYaTMsMWNf39si+FkIofqBVP03NN1mlBV4V2PgI8
         k3oBinKZEarwhPDKWfT9NKOxKZF/0UiFYdCqm/J6l4C3+aTx9/4v9dMYwS7+P4eC/Nnv
         GueG1KsKGADEZHjx8sZQpMVM3PZk0x66VfQM0VXg3zO8ak4/jlSRUgZP90kzT+FgknGu
         iG2pc67Nl5UgXM8e+iCDQYutJzl+avMmAK5QYyWTROlP+TNf1RI6bsg+OMMSgjDm/MkV
         zzdU/PjwbMrIofTfn88ORNNt64OCmIYgW1pCbtR8e5tFJthBfErHokg/OSp23bhDfvJs
         DRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=poJidiszCBRirUJNXfXCf1Ah3zwYRAU9HpEcfUG9lY0=;
        b=lOOHiBMFGctIw7Ny3rUhxw9Z76fI5SjCiwuHGz/DDEiC37ZI2q8DbyDe28eb/zYRRJ
         IjvqT7p/S7iu01Ygk6wzAgRbCC8kegR6saQ+Y9bKmB5SVFRU4ebEBvimpmmMGpeLPKB2
         GcHmyQsxTQnTqN/Ik0wslXcRB253Oum4CQlB8hV0lYmRFlRpl8s9pdW6KUyd2BUFzbu8
         DyxafloiphrJrT4v16S5HpQnssUKRbqnFN6U/XV17URhEu1cHPqRc+k6QTrNgH0nq9HO
         9XlNCXPk2NRZlXaKZ7W2Ms79cFWBLXENZaKg4L5BF6rYFZiEmFBFbastWQrQ8BS81FuO
         LQAQ==
X-Gm-Message-State: APt69E3YFnYwtohBiz9zcqUsQGPJoldGKOzoMWljh4w6lkqTGGMCRkWA
        GeZgoSTqvpnGOVK7GqQqDnHYuYcWewof1bnAavVx
X-Google-Smtp-Source: AAOMgpceTfiRRTYt5qFQxmQu4CzJ0TnOEyHeJ8yaBowozXQDISc5slaUB9XlTEv6rTjbOCqso7mtVEZCVfVdEeUSWQQ=
X-Received: by 2002:a19:a892:: with SMTP id r140-v6mr8053105lfe.39.1530231793937;
 Thu, 28 Jun 2018 17:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180625163425.216965-1-jannh@google.com> <9d5d0cb7-5875-0814-835b-097db650b6a1@tycho.nsa.gov>
In-Reply-To: <9d5d0cb7-5875-0814-835b-097db650b6a1@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 28 Jun 2018 20:23:02 -0400
Message-ID: <CAHC9VhQ7ep3HSw8iqWBsiW0hhZ-drVtk7bW1rA1uAyUrbm3PqA@mail.gmail.com>
Subject: Re: [PATCH] selinux: move user accesses in selinuxfs out of locked regions
To:     Stephen Smalley <sds@tycho.nsa.gov>, jannh@google.com
Cc:     Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        security@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 8:15 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 06/25/2018 12:34 PM, Jann Horn wrote:
> > If a user is accessing a file in selinuxfs with a pointer to a userspace
> > buffer that is backed by e.g. a userfaultfd, the userspace access can
> > stall indefinitely, which can block fsi->mutex if it is held.
> >
> > For sel_read_policy(), remove the locking, since this method doesn't seem
> > to access anything that requires locking.
> >
> > For sel_read_bool(), move the user access below the locked region.
> >
> > For sel_write_bool() and sel_commit_bools_write(), move the user access
> > up above the locked region.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Only question I have is wrt the Fixes line, i.e. was this an issue until userfaultfd was introduced, and if not,
> do we need it to be back-ported any further than the commit which introduced it.

Considering we are talking about v2.6.12 I have to wonder if anyone is
bothering with backports for kernels that old.  Even the RHEL-5.x
based systems are at least on v2.6.18.

Regardless, I think this is fine to merge as-is; thanks everyone.

> Otherwise, you can add my
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

-- 
paul moore
www.paul-moore.com
