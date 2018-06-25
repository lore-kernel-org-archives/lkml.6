Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030ECC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01DE2620C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DSwVpy7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01DE2620C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932616AbeFYWlE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:41:04 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45575 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754551AbeFYWk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:40:59 -0400
Received: by mail-oi0-f65.google.com with SMTP id 188-v6so14083558oid.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v7gsdRJHMHZ0qJzG/sa03VJYQh7eFitNZlue94uW47M=;
        b=DSwVpy7IMsurMgskQoKtPDi0GqSEAYCrfQNBGtUzOjf2wNd/HkwpL/1t4gMIGgLUxU
         VgeJUzATHsEHspeDIlGjRj1YV1ObrNtT5qHdX7CT8uR+nMs7NC/L9KXN6mAdk5ha+Mz0
         9c7VSA685U10kV/v5dFuxDFlfKHuRXc1RVdx74syBLgTyxxTIaYh4hTFtayqWX3B/oSW
         aPTFaPvDQA6VWTp4mXDNb1sLQCBmMQnBhUuBSnfiFo01S1zxbEfprBOtuQsl2Dxs4QHV
         pr3obs8wtsPhI336XSttFC6NLwcip/Z06HrBDn195z5MSnH7wxX5GOUQuUn7zKzuagA7
         AkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v7gsdRJHMHZ0qJzG/sa03VJYQh7eFitNZlue94uW47M=;
        b=l3GFGEPgHxYdUJycEUrXAs9Zsi1XdSZUPMj8XkRtHCuN+1cnn7cnvipe43oS47XmhR
         0HmEfAviBv1beoFBXzlTAaryhXw6ib+gd0Vk2EGOPpUxsOvuGzzoa4Sf/rjAxRqpycV+
         JvlppvkTQFTVv6WVZK4d42Ah+6LWiummp2aF0vs91FlRYQwuIEqdF7jp348kH9SEsoXX
         4IO4kJXYqtxmHnRUzXjavubws+CxoruBM1TiqyuePg4Ml6SQYLsJeMkAu+vBYf58eEl9
         KKBcsLZcjOpVEl52Ajg9WqOLYWGOr44ZT7Fd2N54cfCKLGnhu3+o+Woge6aCPwOMLqKX
         QjCA==
X-Gm-Message-State: APt69E3CHuuBPOVFSwWUr7C9BaAdF8G12CwFAzdLM1T+h5nN8A5XPAtw
        aZO4ndpWxqw+2Ia93ohKYqjo5zKqDcgwJD3PsJTNKA==
X-Google-Smtp-Source: AAOMgpc3jFpztcEM8MzoC+Mpu5G9P3l+wQcxou4Vkko9SJR2Dx8dwXn+Ji92FHuFxAIeuLuVJoTJi6xXGVEe2532Bn0=
X-Received: by 2002:aca:5bd5:: with SMTP id p204-v6mr8479093oib.91.1529966458338;
 Mon, 25 Jun 2018 15:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180625163425.216965-1-jannh@google.com> <CAHC9VhTipjBx9CF4FdTbc2a8bSqKqWiHfi9Krv=Lu74Yvquyrg@mail.gmail.com>
In-Reply-To: <CAHC9VhTipjBx9CF4FdTbc2a8bSqKqWiHfi9Krv=Lu74Yvquyrg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 26 Jun 2018 00:40:46 +0200
Message-ID: <CAG48ez1v3J_VYnrP1RRCf936pvakphGQzvZZWw6tojiHA-BAxw@mail.gmail.com>
Subject: Re: [PATCH] selinux: move user accesses in selinuxfs out of locked regions
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        security@kernel.org, kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 12:36 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Jun 25, 2018 at 12:34 PM Jann Horn <jannh@google.com> wrote:
> > If a user is accessing a file in selinuxfs with a pointer to a userspace
> > buffer that is backed by e.g. a userfaultfd, the userspace access can
> > stall indefinitely, which can block fsi->mutex if it is held.
> >
> > For sel_read_policy(), remove the locking, since this method doesn't seem
> > to access anything that requires locking.
>
> Forgive me, I'm thinking about this quickly so I could be very wrong
> here, but isn't the mutex needed to prevent problems in multi-threaded
> apps hitting the same fd at the same time?

sel_read_policy() operates on a read-only copy of the policy, accessed
via ->private_data, allocated using vmalloc in sel_open_policy() via
security_read_policy(). As far as I can tell, nothing can write to
that read-only copy of the policy. None of the handlers in
sel_policy_ops write - they just mmap as readonly (in which case
you're already reading without locks, by the way) or read.
