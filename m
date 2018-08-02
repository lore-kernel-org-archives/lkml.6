Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DC1C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C39F208A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQVeqJDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C39F208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbeHBFDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 01:03:17 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46193 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbeHBFDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 01:03:17 -0400
Received: by mail-qk0-f194.google.com with SMTP id 191-v6so581903qki.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 20:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/3p5KOdHKfZ1nklEnBoboZZ5wPZ46g77pla3ujt6Aq4=;
        b=HQVeqJDzKr2n2TnpFc/4vRt9AZsqZT2IfmA/s5Sng1jI1hZ4prVsjFl21Sc1miQckl
         SH0ElVkOjwHcpgp1W8QAjelC11NSl0ZLjSAUl1jXSIvt9CQQUBGo9pen4lAozsPtMtrP
         TLxYR8pswanpIZ82ugFF+fgOrdksx6Q5TLmXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/3p5KOdHKfZ1nklEnBoboZZ5wPZ46g77pla3ujt6Aq4=;
        b=ocTNC/7eRlNHzZL63KPHgAOWvmjV9egilMSUPmnYySWsgbbzjJ6rtwwdEBqxoQ8NUG
         xmmPsfOLGvesPO1YG0MIOqPqy1gYvHRGrHzBSO5z52EA7ZrykG4o125lQ1OqYGItReIv
         f1o585GC0uZn52kZWlG087XX2+FEaQkVPtu3N7IDZtFzmlr9vxsJJjsuPA2V7kyNyXU7
         QjHi7TeI2JAqX9OZQcX4BhGvWgXgdgGtxWeelBIs7MAyfec6euYCqRWMeCCOwx2Q0zgp
         ER4yD3VZrGS0vUc2lWzNgxyTUyCVAC6EbiwFThcFmyrTGBRXgJpK/ev9u40bpxEqBsFg
         GEog==
X-Gm-Message-State: AOUpUlHO1ZWoa35QW52Akb4ZpobXm9RstW7Rb+TDEIaGpCFidGjx3PFT
        ZZUmqWHs0zde02VRhRjuO5JTdg==
X-Google-Smtp-Source: AAOMgpcDBl8QVdxfeHl3vdA8I3jRs+z0ddsXu435P8pzRBGODUbzzGocvAuQczu04Cxw8XhJ+J2W/Q==
X-Received: by 2002:a37:c9:: with SMTP id t70-v6mr873348qkg.235.1533179658683;
        Wed, 01 Aug 2018 20:14:18 -0700 (PDT)
Received: from localhost ([168.194.163.63])
        by smtp.gmail.com with ESMTPSA id b7-v6sm274470qtj.97.2018.08.01.20.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 20:14:17 -0700 (PDT)
Date:   Thu, 2 Aug 2018 00:14:15 -0300
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Commit "new primitive: discard_new_inode()" introduces a problem
Message-ID: <20180802031415.xlqc25j3cq3w6zcd@mobile.celeiro.br>
References: <64a0f022-a32d-d4ee-7464-5c5ce0ebd222@virtuozzo.com>
 <20180801151937.GN30522@ZenIV.linux.org.uk>
 <96e3c195-aaca-9214-0dcd-5c2b970a72ae@virtuozzo.com>
 <20180801161151.GO30522@ZenIV.linux.org.uk>
 <20180801161648.GP30522@ZenIV.linux.org.uk>
 <31fa5f9e-6378-2345-777c-7deb6f9a2d19@virtuozzo.com>
 <20180801163408.GR30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801163408.GR30522@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 05:34:08PM +0100, Al Viro wrote:
> On Wed, Aug 01, 2018 at 07:19:35PM +0300, Kirill Tkhai wrote:
> > On 01.08.2018 19:16, Al Viro wrote:
> > > On Wed, Aug 01, 2018 at 05:11:51PM +0100, Al Viro wrote:
> > >> On Wed, Aug 01, 2018 at 06:43:56PM +0300, Kirill Tkhai wrote:
> > >>> #git status
> > >>> HEAD detached at 22dc9a168272
> > >>
> > >> Wait a sec - just that commit?  With discard_new_inode() not even
> > >> used anywhere?  Then any of those -ENOMEM is disguised ERR_PTR(-ESTALE)
> > >> from find_inode()/find_inode_fast(), i.e. an inode found by
> > >> iget5_locked() (your /etc is on ext4) with I_CREATING still set.
> > > 
> > > iget_locked(), that is.
> 
> OK, I see what's going on there.  See if this fixes the problem:
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 0e8e5de3c48a..b11f566bcd66 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1892,7 +1892,7 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
>  	spin_lock(&inode->i_lock);
>  	__d_instantiate(entry, inode);
>  	WARN_ON(!(inode->i_state & I_NEW));
> -	inode->i_state &= ~I_NEW;
> +	inode->i_state &= ~I_NEW & ~I_CREATING;
>  	smp_mb();
>  	wake_up_bit(&inode->i_state, __I_NEW);
>  	spin_unlock(&inode->i_lock);

It fixes the issue.

Results: https://bugs.linaro.org/show_bug.cgi?id=3957#c10

Tested-by: Rafael David Tinoco <rafael.tinoco@linaro.org>

Thank you!
