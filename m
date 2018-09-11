Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEE6C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971A620865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDX/Y+XY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971A620865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeILErU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:47:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37810 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeILErT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:47:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id a20-v6so315380edd.4;
        Tue, 11 Sep 2018 16:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LKYsj+fQQbEtJ3OIxqQEY8O2OHq/3jimPkAF5JtqiHs=;
        b=NDX/Y+XYzG6xS1QGha0vBBuZy/4z3VBCOXNnomi4Jl1aVYiv/XdzZzu82SpqP8BX+V
         Zk+hN6uIytcL8bnfokvxlu4pB69I066NMJNAEKaPMSW1iosKj2nOKGsxyTXgZXL/TG8b
         e13dRHKv6vhM8a2LeI0wXwgRtsZPpjhE69p5lyFLhXRqL7yDIa8vSByMPxTI8Ecb56eP
         wevsIG8xYEWYAD/bq6SZ/13e/EnN6yGRWGAIjBhXpfOvgK2Ev/kuV7qWpi14HB/PvPeh
         Jqx74ZY7Az1i10Sx1aEYHwXW+gYBZoRvtXshtmde/A8NEJtRMW4ooIl5Xw1EV8LMFlNe
         yglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LKYsj+fQQbEtJ3OIxqQEY8O2OHq/3jimPkAF5JtqiHs=;
        b=BPjiSWPL9msJmkzCh6t+ynv00cBGMlhWPNQkTNtRunHsyo3g1ZPP7lPbiSqTydHPs7
         BgoKqZj2puDrKKFprtlLwN3NQVdZlZbguP+aIGCvKuruObVdUfL367fQuVp8ZSblSpSX
         S1mzYrlpgEMEmeJ6wzxE/ySlN0g/UOfIpbHMfiHoxKJAxlF3ABa/NY2uVEP8C3vTUlQT
         avaF6K0zbmboHK9tybbOvx4sYpatKiX91MVWJvmyzCjCdnOi5s+nHoGOhqhgtWm+gEU+
         Jg+7x0M8H66h/tSJZsj2/MtQT9eDPz4ds7ZGtb4B0QGqYrFnWNXKnh1rnnXet75c3NIb
         TBvQ==
X-Gm-Message-State: APzg51CGg9BHPvAhjgmG5kiAhFtJqMblmBoOhFp283R+zQdVAXy1O3b8
        po15HB9zPQ7g8UzjU1dJ/2Y=
X-Google-Smtp-Source: ANB0VdYEYktCZdiU6NoebbmHclxY9wJVsw3S5gRAw5I1rtvbmYIhg8kTVEGvqkr8GCIlJIDO2206Tg==
X-Received: by 2002:a50:b2c6:: with SMTP id p64-v6mr30433840edd.293.1536709540820;
        Tue, 11 Sep 2018 16:45:40 -0700 (PDT)
Received: from darwi-kernel ([142.93.171.10])
        by smtp.gmail.com with ESMTPSA id c50-v6sm10809532edb.67.2018.09.11.16.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 16:45:39 -0700 (PDT)
Date:   Tue, 11 Sep 2018 23:45:38 +0000
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKM <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Subject: Re: [PATCH 01/10] procfs: add smack subdir to attrs
Message-ID: <20180911234538.GB12337@darwi-kernel>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <c43599b8-20f6-0cc6-28d7-abff4c0d0a0d@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c43599b8-20f6-0cc6-28d7-abff4c0d0a0d@schaufler-ca.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 09:41:32AM -0700, Casey Schaufler wrote:
> Back in 2007 I made what turned out to be a rather serious
> mistake in the implementation of the Smack security module.
> The SELinux module used an interface in /proc to manipulate
> the security context on processes. Rather than use a similar
> interface, I used the same interface. The AppArmor team did
> likewise. Now /proc/.../attr/current will tell you the
> security "context" of the process, but it will be different
> depending on the security module you're using.
>
> This patch provides a subdirectory in /proc/.../attr for
> Smack. Smack user space can use the "current" file in
> this subdirectory and never have to worry about getting
> SELinux attributes by mistake. Programs that use the
> old interface will continue to work (or fail, as the case
> may be) as before.
>

Did downstream distributions already merge the stacking patches on
their own?

Got a little-bit confused after reading the log above; I already see
this in in Ubuntu 18.04.1 LTS, v4.15.0-33-generic:

    $ tree /proc/self/attr/
    /proc/self/attr/
    ├── apparmor
    │   ├── current
    │   ├── exec
    │   └── prev
    ├── current
    ├── display_lsm
    ├── exec
    ├── fscreate
    ├── keycreate
    ├── prev
    ├── selinux
    │   ├── current
    │   ├── exec
    │   ├── fscreate
    │   ├── keycreate
    │   ├── prev
    │   └── sockcreate
    ├── smack
    │   └── current
    └── sockcreate

Thanks,

--
Darwi
http://darwish.chasingpointers.com
