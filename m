Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFEBC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0559420684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="2MjOynBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0559420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeJCMXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:23:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32888 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeJCMXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:23:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id e4-v6so4618400wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 22:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5IzN2R0b3fgX4LTca8jf3J3eYSg2AdZODTPbmmS80Q=;
        b=2MjOynBLTduMQnaavvY8b6/cEF8UMICLYw1uA/OK8j/EfXTlXm73GzcpPHBTIKbpJZ
         Tbqbn1wOM+10GZLBBHWy2oyLLTTx7C0sQp6NbT8LIJlGuPWpHXQqTtWWsz3+HcvRbQAK
         FNcF9tPznE5Av8KMYgd9t8Tjvr2auUUw6OFTu3fVFJo1JQPzxhT2x4bs34dcKP8l8c2N
         ZS6/Uxqic6nY+tCr+AngbAZMVxtrP5LxiSIx6JUCPT0khmkxiqSZQsgmrHYw4cepR09F
         VpVM5pu2Sn0mcN2jhYhkrU4DhS7yOyz1IEWB3C8bhQ4VWmwwZ898NjxPIfd+00Ffrx8u
         2/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5IzN2R0b3fgX4LTca8jf3J3eYSg2AdZODTPbmmS80Q=;
        b=uZAbi63mxZpoNmbG5Mcdb+QXwxohosscYvDb2ATGA5+Qcw6+fQ0PQwMDP/vRpFUcYa
         Przj75nSKf5GS2Yyt9bmMMYvRDU1ktvAarmFXl2AqoKJzYgVffgKg4XWX3wT2/zmpIcv
         9pbOKVqpHi338zAefajrnFp/Fz/qWOyvH/k63SDTHW4Yo6t4mJmhBoNEJhniWxL76CaN
         /NHYVJr4yXNxnxrcWNwJrwpmaUjtmzxN4w1jqLXL04UOoNN1MisUVK9qb/+UftqZ4FN4
         lHR1Vs5j/7MsJUXBi3hXB1orRRv7geOKjaRD53krUV08DkWBopgdqF5YiRwI0BaqQwTE
         ozeg==
X-Gm-Message-State: ABuFfogVxq7VBj6e19zOtoUt1HXtu4EJTrwp1mQSh1HPaXxK1ZdCzzBy
        n7LMQ9KHWlAq/yOqMS9oR0tZnguVdvH326Euykcziw==
X-Google-Smtp-Source: ACcGV60sqBd5C+thKvoH8gI4nz87zASM28tDuVb+oVscSQukIZiXNUtSi+WwS0G3dxZqZESwGLDTrjxSGghBNLdeqks=
X-Received: by 2002:a5d:610a:: with SMTP id v10-v6mr12787049wrt.308.1538544987362;
 Tue, 02 Oct 2018 22:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180921150351.20898-1-yu-cheng.yu@intel.com> <20180921150351.20898-25-yu-cheng.yu@intel.com>
 <20181003045611.GB22724@asgard.redhat.com>
In-Reply-To: <20181003045611.GB22724@asgard.redhat.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 2 Oct 2018 22:36:15 -0700
Message-ID: <CALCETrU-Ny-uC1NqRedQwNKe2MMhsFEqZ08TtHJwbLfCACMmLw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 24/27] mm/mmap: Create a guard area between VMAs
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 9:55 PM Eugene Syromiatnikov <esyr@redhat.com> wrote:
>
> On Fri, Sep 21, 2018 at 08:03:48AM -0700, Yu-cheng Yu wrote:
> > Create a guard area between VMAs, to detect memory corruption.
>
> Do I understand correctly that with this patch a user space program
> no longer be able to place two mappings back to back? If it is so,
> it will likely break a lot of things; for example, it's a common ring
> buffer implementations technique, to map buffer memory twice back
> to back in order to avoid special handling of items wrapping its end.

I haven't checked what the patch actually does, but it shouldn't have
any affect on MAP_FIXED or the new no-replace MAP_FIXED variant.

--Andy
