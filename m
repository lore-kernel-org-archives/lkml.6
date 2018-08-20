Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4DEC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E93121581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0xUJ8tq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E93121581
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeHUBfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:35:47 -0400
Received: from mail-yw1-f41.google.com ([209.85.161.41]:36747 "EHLO
        mail-yw1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeHUBfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:35:46 -0400
Received: by mail-yw1-f41.google.com with SMTP id w202-v6so1333606yww.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 15:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zFbMYWiIwyuIKZlEWe68ephb74gxM4EVORgUHU0GLJE=;
        b=C0xUJ8tqzEflVKcJVzirM0OwWe13TcbLG5QDqJrmNo7hUVv9c1edZ+XhZypZPl580b
         6QXp+CyQlbzY4lZYWG56nk1sWFaNlfRN+q6ORPUqcPWh3rV3jv7SjOyFbaLUT0VSd/hR
         9aXp3fmZW0Z7fRjUli2xfVSZOwiW0GKg6SQ3ILclyN91d12YOUny7GLYrJpJg3XGJL/W
         c5ic7RafQgxv61kv1/mHE6SZMZsx8N9qX7/rL+hVZmD/V/IprhVRKvzpOPoJgZKctvlH
         7XP3CP95HpXSwPcYklmUYlg/HR7U7sQMnzKlG/pnhZbQXqFZDLdd5vc8r42l6M3aQTSJ
         CauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zFbMYWiIwyuIKZlEWe68ephb74gxM4EVORgUHU0GLJE=;
        b=ESEwJMyNznLqOS+1xFPiSxPpNnIOJJ8dZsFFslb5ucZET9yHdCO8dG/cwFRulMajjh
         OidC2C8AHcg29yG5hYXw4RZ+YhZw7rz1cut0639D3plcLzbK7E4mwVorVolqtqzrM/o2
         fgXwO++d9FWai/is6chfTgYsifYUIHxsnQEiZv5Ay8ZPIpARR07FaoWHNGOGwYaOCkaL
         MnHpJjXg6iA3CYar4Da8FBm0dQAantLmGdJzxftSm2eCc9BOTRdknTJ62iaW5GPw/Ex6
         ZCKZkyXuQdDxdZXNMxW/cBzGvAanNmvp/eyf3W0dHtgogJzHK/j+zouo74X2oOurFnDA
         TIGQ==
X-Gm-Message-State: APzg51BcpWQQYU0OhbOBV+qntkjIeAq5h5TTfkSNFlz+nDcPrB7ONpJE
        PkzNjlBvmDSsPoQOp1IQjMxFhJfTywsACKU6DLKlTQ==
X-Google-Smtp-Source: ANB0Vda4STQIwYtEywxhQMBpkYN/u0SJMxE2AoGATPJF2/11Gxqk2jTjlkJblCzB+HX+RCBLp6FcPDmJbNn+BdMARsE=
X-Received: by 2002:a81:7443:: with SMTP id p64-v6mr2652106ywc.407.1534803501249;
 Mon, 20 Aug 2018 15:18:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:aa31:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 15:18:20
 -0700 (PDT)
In-Reply-To: <1534801939.10027.24.camel@amazon.co.uk>
References: <20180820212556.GC2230@char.us.oracle.com> <CA+55aFxZCyVZc4ZpRyZ3uDyakRSOG_=2XvnwMo4oejpsieF9=A@mail.gmail.com>
 <1534801939.10027.24.camel@amazon.co.uk>
From:   Kees Cook <keescook@google.com>
Date:   Mon, 20 Aug 2018 15:18:20 -0700
Message-ID: <CAGXu5jLSPGe7W0qpUYoQr4C-Yy5FV8Q=hUKRYO9zSbeUNSZn0g@mail.gmail.com>
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
To:     "Woodhouse, David" <dwmw@amazon.co.uk>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "juerg.haefliger@hpe.com" <juerg.haefliger@hpe.com>,
        "deepa.srinivasan@oracle.com" <deepa.srinivasan@oracle.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
        "pradeep.vincent@oracle.com" <pradeep.vincent@oracle.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "khalid.aziz@oracle.com" <khalid.aziz@oracle.com>,
        "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
        "liran.alon@oracle.com" <liran.alon@oracle.com>,
        "jsteckli@os.inf.tu-dresden.de" <jsteckli@os.inf.tu-dresden.de>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "tyhicks@canonical.com" <tyhicks@canonical.com>,
        "john.haxby@oracle.com" <john.haxby@oracle.com>,
        "jcm@redhat.com" <jcm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 2:52 PM, Woodhouse, David <dwmw@amazon.co.uk> wrote:
> On Mon, 2018-08-20 at 14:48 -0700, Linus Torvalds wrote:
>>
>> Of course, after the long (and entirely unrelated) discussion about
>> the TLB flushing bug we had, I'm starting to worry about my own
>> competence, and maybe I'm missing something really fundamental, and
>> the XPFO patches do something else than what I think they do, or my
>> "hey, let's use our Meltdown code" idea has some fundamental weakness
>> that I'm missing.
>
> The interesting part is taking the user (and other) pages out of the
> kernel's 1:1 physmap.
>
> It's the *kernel* we don't want being able to access those pages,
> because of the multitude of unfixable cache load gadgets.

Right. And even before Meltdown, it was desirable to remove those from
the physmap to avoid SMAP (and in some cases SMEP) bypasses (as
detailed in the mentioned paper:
http://www.cs.columbia.edu/~vpk/papers/ret2dir.sec14.pdf).

-Kees

-- 
Kees Cook
Pixel Security
