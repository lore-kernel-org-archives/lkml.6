Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB9CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE502416F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cx3hs69b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE502416F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934529AbeGCSdb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:33:31 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46388 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934468AbeGCSd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:33:28 -0400
Received: by mail-pf0-f194.google.com with SMTP id l123-v6so1410250pfl.13;
        Tue, 03 Jul 2018 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8X1uayyAFipE4HM/RPbIZWZXtHjfwUF9ZI6ftAaq2Ws=;
        b=cx3hs69b6xKhOHdrva9UM16fQ/kbEba2O8QJ9tFqHMQTPibNFQfKOiXEit4eatQ8wx
         gXoGxNklSwdJUHI1djAnJTX/HtTscK6wvTmYmbjF7fhSr91N/2/4ovux82LoIjwPtzoP
         0UcuqXEugll3uksHkhjW8nD9KKUMNZ83CO5gKTFm8crRnkCA4px8M4+DSDusuAAMcMag
         sWUmQQQrLAXsEskXPTyCmwkMZaSpKLg1UgGQ2+YZTPf4ed7iuURw22dIN3zr++vEayYz
         fQ8Z8myTdREJmjtpjIbr23B87lUiOQF/V0YK3OG/MHFqEWbr/L1mwRKJWSqMXg6C7AL4
         tsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8X1uayyAFipE4HM/RPbIZWZXtHjfwUF9ZI6ftAaq2Ws=;
        b=Cugp8glDlh9c2twGEVNbY2mtUcMHV2UUYO1SWw41dJPi96PTCCbMX3loHVcmCxAsi4
         6ekA+io2nRJNl89Id6PG95lYu0i5EKJ5QFceNtOYoOli5U0n0KtGb2RdCvvzwmFeN6jx
         VFjlnju1ejVCp8cRuC3ENiJ3oSHZI/G4e6NLKjkwY9S6qcyokJHWehMBijoWPnLx/+Y3
         RLK+DMlQNIYeew2+hJ7yYZr3aVemFqSpkDfMrNGJ6qALeBvVkaTXybeUrNzhSXY8qfyA
         2ghK6AwQPIqfSX9ze9EPQCV7oXFp+DZSB/tt2MgmvqH/zgfFVJMRnnFHQ1OeMI78aLcm
         odeg==
X-Gm-Message-State: APt69E2oRPFFwviPj3hET3ecJtFu+Csp6b3KQ979xsjWyCvZhveANClS
        m3NgGRX6YBSYJ4mUTIBiAhg=
X-Google-Smtp-Source: ADUXVKJbSN9m/56EXgvlOaH65nRs6JG0UhQkYBsuFW1ab6Qj/NLBA14mfrV99lIHh/XMG3vgggQotA==
X-Received: by 2002:a65:6186:: with SMTP id c6-v6mr26334611pgv.360.1530642808147;
        Tue, 03 Jul 2018 11:33:28 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id d18-v6sm3307778pfn.118.2018.07.03.11.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 11:33:27 -0700 (PDT)
Date:   Tue, 3 Jul 2018 11:33:25 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/32] VFS: Implement a filesystem superblock
 creation/configuration context [ver #8]
Message-ID: <20180703183325.GA210265@gmail.com>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <152720678933.9073.11201500538963619904.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152720678933.9073.11201500538963619904.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.10+35 (c786a508) (2018-06-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 01:06:29AM +0100, David Howells wrote:
> +/**
> + * sget_fc - Find or create a superblock
> + * @fc:	Filesystem context.
> + * @test: Comparison callback
> + * @set: Setup callback
> + *
> + * Find or create a superblock using the parameters stored in the filesystem
> + * context and the two callback functions.
> + *
> + * If an extant superblock is matched, then that will be returned with an
> + * elevated reference count that the caller must transfer or discard.
> + *
> + * If no match is made, a new superblock will be allocated and basic
> + * initialisation will be performed (s_type, s_fs_info and s_id will be set and
> + * the set() callback will be invoked), the superblock will be published and it
> + * will be returned in a partially constructed state with SB_BORN and SB_ACTIVE
> + * as yet unset.
> + */
> +struct super_block *sget_fc(struct fs_context *fc,
> +			    int (*test)(struct super_block *, struct fs_context *),
> +			    int (*set)(struct super_block *, struct fs_context *))
> +{
> +	struct super_block *s = NULL;
> +	struct super_block *old;
> +	int err;
> +
> +	if (!(fc->sb_flags & SB_KERNMOUNT) &&
> +	    fc->purpose != FS_CONTEXT_FOR_SUBMOUNT) {
> +		/* Don't allow mounting unless the caller has CAP_SYS_ADMIN
> +		 * over the namespace.
> +		 */
> +		if (!(fc->fs_type->fs_flags & FS_USERNS_MOUNT) &&
> +		    !capable(CAP_SYS_ADMIN))
> +			return ERR_PTR(-EPERM);
> +		else if (!ns_capable(fc->user_ns, CAP_SYS_ADMIN))
> +			return ERR_PTR(-EPERM);
> +	}
> +
> +retry:
> +	spin_lock(&sb_lock);
> +	if (test) {
> +		hlist_for_each_entry(old, &fc->fs_type->fs_supers, s_instances) {
> +			if (!test(old, fc))
> +				continue;
> +			if (fc->user_ns != old->s_user_ns) {
> +				spin_unlock(&sb_lock);
> +				if (s) {
> +					up_write(&s->s_umount);
> +					destroy_unused_super(s);
> +				}

->s_umount is released once here and again in destroy_unused_super().

> +				return ERR_PTR(-EBUSY);
> +			}
> +			if (!grab_super(old))
> +				goto retry;
> +			if (s) {
> +				up_write(&s->s_umount);
> +				destroy_unused_super(s);

Same bug here.

> +		up_write(&s->s_umount);
> +		destroy_unused_super(s);

And here.

- Eric
