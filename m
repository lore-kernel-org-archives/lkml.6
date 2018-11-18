Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12127C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C282520815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="CwOGSQDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C282520815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeKSI5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 03:57:48 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36774 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeKSI5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 03:57:47 -0500
Received: by mail-qk1-f196.google.com with SMTP id o125so45872234qkf.3;
        Sun, 18 Nov 2018 14:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIIvTxU2MkHgyj+ZBaobYKKbUlr2NRzlxPGpHAJcvzM=;
        b=CwOGSQDQh1wkmD18Owykx1BF6LuiqNJut/Q1+s6yfPtfQpbCImzrXx2ZMUp8RQt7VN
         lAah5qfULcUaJn6r0AV9GzKJ4EOfKOnHq8IaS+zhfIZITwpceinDC+OSaW3Mm+fmFg/F
         yWC5MGKJ1kl7i70a66GVHt5lbt17eTq3NxSjIkMrbOe7bfYrB3SlAg3vSHviRZAiayJf
         JNBC92v+8vRk/WC13gqASKcSSx9DQ90nyqH+eYHSyb9R0eioy3mWtkKsyh0eCiFA8E8i
         rj7sdCl2Mx56T+esRXI4wUkgwR9doYr1CB9OPP6iWW7Is7CgwwjOmsb1YhBa06+GW2xp
         HrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIIvTxU2MkHgyj+ZBaobYKKbUlr2NRzlxPGpHAJcvzM=;
        b=t+Nj+T5BbZKcXrKYmNGcM1GgnDQqf35gINrP6odFBve7IoaM99hEjN9ZCmiM1VwLka
         6sXS3pYtacPGV4nCIcc7iQ299hcEL5QHVXDOv7K2Rm8p6CbSKGz153FyKSymhGnBhgWN
         wQYTOw/ZUV0XYgRRNYXyTe3F5qK4Q+h6Q+w5LkmAIcvhQpcbHxAPXq/0jNpk0vkZHxmo
         s69u4lUMrrUzRwzRikKedQle8Wzsb71NB0zubRUuTKjiQ0IFhhQ9JKQQuWp0cKaS6sKG
         AUB/OTnq0tuYwckDoT/FbjyQPkilOg3kEQKeMEjG++DQ5dTWvYAMDDpOGzSp6VNF8c2p
         rb5Q==
X-Gm-Message-State: AGRZ1gJbfODxfb7jIZLuBW3OwHWj1poVWekbyoXXhBK5EkIfZ1fU7PkO
        ULJfReMObPS3S3EkAUqAPg/NvXAF75O/yJAtiY8=
X-Google-Smtp-Source: AJdET5cY4b9AOwbtLwZKHhhpTQUnzpgfe8yipmgOvpylPvHT+144bXDBjR3k1yaQHK9riNcdBWmCPw5Wff31xfePl+0=
X-Received: by 2002:a0c:e010:: with SMTP id j16mr19205169qvk.111.1542580572909;
 Sun, 18 Nov 2018 14:36:12 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wg-9FUGU=grF4gKDq1sm1m39Jbs3A_iyLbSSntU47ncwg@mail.gmail.com>
 <nycvar.YFH.7.76.1811182222230.21108@cbobk.fhfr.pm> <CAHk-=whH2daKsZTqVPb-G9mJ1g15XMse7j-9YqN+yBYk7M9=Dw@mail.gmail.com>
 <nycvar.YFH.7.76.1811182309540.21108@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1811182309540.21108@cbobk.fhfr.pm>
From:   Tony Luck <tony.luck@intel.com>
Date:   Sun, 18 Nov 2018 14:36:02 -0800
Message-ID: <CA+8MBbKqeAFjoqq4G-A8pjDdHoVvXqG1Jv+Q4DTu2ZgZ1Gxvjg@mail.gmail.com>
Subject: Re: STIBP by default.. Revert?
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, jpoimboe@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>, dwmw@amazon.co.uk,
        Andi Kleen <ak@linux.intel.com>, tim.c.chen@linux.intel.com,
        casey.schaufler@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86-ML <x86@kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 2:19 PM Jiri Kosina <jikos@kernel.org> wrote:
> Which gets us back to Tim's fixup patch. Do you still prefer the revert,
> given the existence of that? I think that if Tim's fixup makes it through
> (it's currently missing SECCOMP handling, but that is trivial to add on
> top), it might be the best compromise. We'd also have have to make IBPB
> obey it to be consistent (and get even a few more % of performance back),
> but that's easy as well.

+1 for Tim's patch.  That make us more consistent with how we handled
L1TF (giving the system owner a control knob to decide whether they
want this level of fixup, based on their own analysis of their vulnerability).

-Tony
