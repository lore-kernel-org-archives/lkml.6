Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7BDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3EB621841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545248220;
	bh=JYLHZ5vV+ncjvHPhkH8Snh1TBZ40xX7IApN7JLldGco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bty+uNUwTCq4U+U3QaaYY4e5328UXPMb0hNzQEvED3H70KB8GOrIBAR4BP2GHs2Fe
	 aNbivossF8Y5x7vsYDV72ng1YF9PZGZcGL9EnXxfe9EBOzqNhf98Cmw8GDfFAFijry
	 9B7hmG38Me3aIlbpk9+gtRxW3btEqBVSgXiQIz78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeLSTg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:36:59 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35232 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbeLSTg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:36:58 -0500
Received: by mail-qt1-f196.google.com with SMTP id v11so23612766qtc.2;
        Wed, 19 Dec 2018 11:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nb/krCkYkipwbbjhtz1VO0hBalYD/mY6I6NOXTIsGYU=;
        b=TBRJwvLNp0Chy9DoHq+iGgubWhhX0bf7ikfLESW+nOXCKjAhg5rV5zb+dtLjhf1t1Y
         PEUmSOOOxJ39GU2hkOsIhwP5vcC0rRJNvYIdp3CkvNmeW20ly9wRBT2JEH5pE0Zgl6et
         Xz4aJW7UGx+f0yL3Tuu4J2CzOEVquxp7fsRxONZHl+a2MokniB4qgHy2s5n7GvQo6QSl
         Ayamqe9KIaSVv7JqBpkComwtVIYjnSAz4PDBLeuU9g163dVnsxewUahUqdUvmFgeMxlu
         eEYeaOOTckV9NYpkDIbQtr2Lsdqcl7SiM/4oLOSlStiqvR/VBHFMPEWhCPOMko1h4RLA
         c5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nb/krCkYkipwbbjhtz1VO0hBalYD/mY6I6NOXTIsGYU=;
        b=QzFPbMb9IdkHecVe54mgtXvSuuOrvnwx4a8wTtadkM15DoRd7sprOYAw3EjH6FVG2i
         E+TMttiSUGqycq4HRg8Uas+E5dMC6PIDMnAJNCHFW7RcXPAqbWxMDRGSrva0iLvm1FQF
         llRPMLvFTC1p7/fRz8PKr4zMvU1H4u3/16+wto5yHLYZQZ5f6+Ce75ZkQuQ/Cc44LpYg
         8i3CRiHGMrB7H35BFaRkgwXi6pY945EPYqngrPBGLusm99gVnli7Et5MnPzyEaidwnR1
         l9LOX0WUgzApQ9lVhx3Ute0ZqHZBHzY21MrUmykzIpqONuXhj0AyR7lB0o1Az+NVO02W
         g/ow==
X-Gm-Message-State: AA+aEWbF7K/y8iQ14uSselubKY/bSHFjBmF8ClXer33hU86OtFaA4Ooh
        rvBjlA1pwOl2/lOOZr1N5hs=
X-Google-Smtp-Source: AFSGD/Xn4G9fwOK3xtyE3Fj6U9R089Fe7zUDjpEUrxvrUMdQRWpD06aTRXlEhLBIv8LOGOSYMgmm6g==
X-Received: by 2002:ac8:28d2:: with SMTP id j18mr22911102qtj.191.1545248217553;
        Wed, 19 Dec 2018 11:36:57 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:d108])
        by smtp.gmail.com with ESMTPSA id q42sm3431463qkh.56.2018.12.19.11.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 11:36:56 -0800 (PST)
Date:   Wed, 19 Dec 2018 11:36:53 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     lizefan@huawei.com, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup/cpuset: Update stale generate_sched_domains()
 comments
Message-ID: <20181219193653.GA2509588@devbig004.ftw2.facebook.com>
References: <20181219133445.31982-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219133445.31982-1-juri.lelli@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 02:34:44PM +0100, Juri Lelli wrote:
> Commit fc560a26acce ("cpuset: replace cpuset->stack_list with
> cpuset_for_each_descendant_pre()") removed the local list (q)
> that was used to perform a top-down scan of all cpusets;
> however, comments mentioning it were not updated.
> 
> Update comments to reflect current implementation.
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Prolly better to route through scheduler tree together with the second
patch?

Thanks.

-- 
tejun
