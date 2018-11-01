Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FB7C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484F920657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="PLv11++/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484F920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeKBFCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:02:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45799 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbeKBFCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:02:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id d135so12234843qkc.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mmgk75cJXidoCv81Y0dtxwSajKQaiOFFFRwydPMkARo=;
        b=PLv11++/ta02IYIVD0fVsnb5zSTVpZ4JZTmG3MF/DVX0h8wn0faXk5MFj13VPjD879
         /h469xctayJxNs0YI730bUAKK+yeonEjbGhoxiGX4cfJBh5ITd2sLqAC/0TSDmfNcBJQ
         czj+TTryLTcY0jhcAcXVBrmfV/SduqO2SCgq+GYyflq6HL23woiKdRVnYU6T5jjm9jH6
         RelGMQb48nvUXPXEJbMCm0haTDdD2FSoO/7IVr7KOUtK3pYzH0rz7A5y28xJ6eYXXqut
         rakfXSW5YzTn6hrGyK8O99dDKvVwiKtUO06IfniVyRUtEwrOf3TkwO0UmcSWKNxImanO
         FVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mmgk75cJXidoCv81Y0dtxwSajKQaiOFFFRwydPMkARo=;
        b=ljqVRBwOPDfJ5UXTwhm5iwP3J2ehpTDcO7i9QjLzlIJrHnHYac+cJ0/m1x1O76ChMz
         Ejvq/aYdc+ZKlvRL6+2ZBC5fMvNtubqIVlYPZJ6ja5bu3rLmj5xEzKr6Vf6T50orky61
         SsTORQoZD9YoSFtjNFzzpXAe2S5PwYy3ts4IWC45VSpnXQ0Vd5wvsbJzlde7wmpjuRTb
         Ph0Mu0Gc/7MWHdBgSICcvcdJ7ijcPHmFmWMn4le3nfccGam2nso5yfTQiIT/dzoacvIo
         rmzedOi1sJK50p88jhqsNcEfUc9PcRw0VIPh+fbYyhj0zk1FY4oa59gyIjmv9Qt1iRh0
         EPYg==
X-Gm-Message-State: AGRZ1gLlvIteU6AqZzxtSw6yCZZPiHwkhqBMz7OPTxNSBmmr3ry8bTcF
        gDrmd7t+Qf52PoyLoKhy5A8UKxaWuENQxA==
X-Google-Smtp-Source: AJdET5dmO567iKGoHZiut3bo28Pcx7isvSnaq1tRSvCHruwj2Nu4fPwzNXKO8KTiXXGR6NPrjRn5mw==
X-Received: by 2002:aed:2741:: with SMTP id n59-v6mr8108882qtd.380.1541102298047;
        Thu, 01 Nov 2018 12:58:18 -0700 (PDT)
Received: from cisco ([173.38.117.87])
        by smtp.gmail.com with ESMTPSA id v3-v6sm21693005qth.74.2018.11.01.12.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 12:58:16 -0700 (PDT)
Date:   Thu, 1 Nov 2018 13:58:14 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v8 1/2] seccomp: add a return code to trap to userspace
Message-ID: <20181101195814.GH2180@cisco>
References: <20181029224031.29809-1-tycho@tycho.ws>
 <20181029224031.29809-2-tycho@tycho.ws>
 <20181101135633.GB23232@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101135633.GB23232@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 02:56:34PM +0100, Oleg Nesterov wrote:
> On 10/29, Tycho Andersen wrote:
> >
> > +static int seccomp_notify_release(struct inode *inode, struct file *file)
> > +{
> > +	struct seccomp_filter *filter = file->private_data;
> > +	struct seccomp_knotif *knotif;
> > +
> > +	mutex_lock(&filter->notify_lock);
> > +
> > +	/*
> > +	 * If this file is being closed because e.g. the task who owned it
> > +	 * died, let's wake everyone up who was waiting on us.
> > +	 */
> > +	list_for_each_entry(knotif, &filter->notif->notifications, list) {
> > +		if (knotif->state == SECCOMP_NOTIFY_REPLIED)
> > +			continue;
> > +
> > +		knotif->state = SECCOMP_NOTIFY_REPLIED;
> > +		knotif->error = -ENOSYS;
> > +		knotif->val = 0;
> > +
> > +		complete(&knotif->ready);
> > +	}
> > +
> > +	wake_up_all(&filter->notif->wqh);
> 
> Why? __fput() is not possible if there is another user of this file sleeping
> in seccomp_notify_poll().

Yes, I was just trying to be extra defensive. But I can drop it.

> > +	kfree(filter->notif);
> 
> Hmm, this looks wrong... we can't kfree ->notif if its ->notifications list
> is not empty, otherwise seccomp_do_user_notification()->list_del(&n.list)
> can write to the freed memory.
> 
> I think _release() should do list_for_each_entry_safe() + list_del_init()
> and seccomp_do_user_notification() should use list_del_init() too.
> 
> Or, simpler, seccomp_do_user_notification() should do
> 
> 	if (!match->notif)
> 		goto out;
> 
> instead of "goto remove_list".

Yes, and we need another such check in this case after we re-acquire
the lock from the signal send. Thanks for catching this!

Tycho
