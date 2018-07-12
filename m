Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AD3EAB18B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF53208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aP3OnuFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF53208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbeGLSRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:17:00 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54842 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732208AbeGLSQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:16:59 -0400
Received: by mail-it0-f68.google.com with SMTP id s7-v6so8063801itb.4;
        Thu, 12 Jul 2018 11:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gH/7xbbvaNGX9vSnYeWTYXoV+8anNYt8k/9JV13LWrA=;
        b=aP3OnuFxtS8gQffe2pC3eqiZ7z0eItch81qDVpZjg9/UPfW9K2D3O/sfV0ezG0v1oW
         udfMJQfxoVRcASmTyJSkk0Eq5kamfClANPjGXyxnlvMpECwZuT1H9FmkrJhvRgc1Wxuj
         Qc9lnyN7u3B6T/pZ/pg/fLlO41M63sDiZabW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gH/7xbbvaNGX9vSnYeWTYXoV+8anNYt8k/9JV13LWrA=;
        b=pilxRdtSiFbU+2o25PmRlaqOOzJsf27Sl4dEPnRgCjvO9k4N5aPHZEfx59sg2bpoBv
         TWZoyIfnLm4hB4OhAew/9NciUKDLN1YI9kugJz3oXIKN/iaQdhwgtGm9YAXOcuqKiRe3
         g0rWWm+oeaXIHy0VSAUYueCwu13R2D2SMIny73GeGALYVdY1QIMtKIlGLZYzijhvJX5J
         c3eLXpFX0dQXUd/GgoYMdwQmouPmQdpxbC7Bo+WdO6YYqsXGCG7+9WOaB44nQhgAfKUN
         OENxSmfdi2+8p52Z57qV0RQRYoagqZ8uH6Ss+vi7ntLNB5N9a6xWw0HEkTm/rINW6o7f
         V1dA==
X-Gm-Message-State: AOUpUlGAZ/uzPeEAAadHs0Sp+MtWOytU5FcOdL3tXCOt4L4C4P8AYB8c
        38enULhEAT9YoCMD0dfODAzp59LwIrxVKZXNxXU=
X-Google-Smtp-Source: AAOMgpdBH3YGZAwkCx//upzHm4xPP9SGLrSwDEqDNieXZkPsWYnGUwXqVfAo0RXv6XPlj+UxbaXyckLKc3Snc13fKGs=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr2172832itb.16.1531418779203;
 Thu, 12 Jul 2018 11:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <62275711-e01d-7dbe-06f1-bf094b618195@redhat.com>
 <20180710142740.GQ14284@dhcp22.suse.cz> <a2794bcc-9193-cbca-3a54-47420a2ab52c@redhat.com>
 <20180711102139.GG20050@dhcp22.suse.cz> <9f24c043-1fca-ee86-d609-873a7a8f7a64@redhat.com>
 <1531330947.3260.13.camel@HansenPartnership.com> <18c5cbfe-403b-bb2b-1d11-19d324ec6234@redhat.com>
 <1531336913.3260.18.camel@HansenPartnership.com> <4d49a270-23c9-529f-f544-65508b6b53cc@redhat.com>
 <1531411494.18255.6.camel@HansenPartnership.com> <20180712164932.GA3475@bombadil.infradead.org>
 <1531416080.18255.8.camel@HansenPartnership.com>
In-Reply-To: <1531416080.18255.8.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Jul 2018 11:06:08 -0700
Message-ID: <CA+55aFzfQz7c8pcMfLDaRNReNF2HaKJGoWpgB6caQjNAyjg-hA@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] fs/dcache: Track & limit # of negative dentries
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>
Content-Type: multipart/mixed; boundary="00000000000056798e0570d138d2"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000056798e0570d138d2
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 12, 2018 at 10:21 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Thu, 2018-07-12 at 09:49 -0700, Matthew Wilcox wrote:
> >
> > I don't know that it does work.  Or that it works well.
>
> I'm not claiming the general heuristics are perfect (in fact I know we
> still have a lot of problems with dirty reclaim and writeback).

I think this whole "this is about running out of memory" approach is wrong.

We *should* handle that well. Or well enough in practice, at least.

Do we? Maybe not. Should the dcache be the one area to be policed and
worked around? Probably not.

But there may be other reasons to just limit negative dentries.

What does the attached program do to people? It's written to be
intentionally annoying to the dcache.

               Linus

--00000000000056798e0570d138d2
Content-Type: text/x-csrc; charset="US-ASCII"; name="t.c"
Content-Disposition: attachment; filename="t.c"
Content-Transfer-Encoding: base64
Content-ID: <f_jjiv6g8e0>
X-Attachment-Id: f_jjiv6g8e0

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHVuaXN0ZC5o
PgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgoKc3RhdGljIHZvaWQgZGll
KGNvbnN0IGNoYXIgKm1zZykKewoJZnB1dHMobXNnLCBzdGRlcnIpOwoJZXhpdCgxKTsKfQoKLyoK
ICogVXNlIGEgImxvbmdpc2giIGZpbGVuYW1lIHRvIG1ha2UgbW9yZSB0cm91YmxlIGZvciB0aGUg
ZGNhY2hlLgogKgogKiBUaGUgaW5saW5lIGxlbmd0aCBpcyAzMi00MCBieXRlcyBkZXBlbmRpbmcg
b24ga2VybmVsIGNvbmZpZywKICogc28gbWFrZSBpdCBsYXJnZXIgdGhhbiB0aGF0LgogKi8KaW50
IG1haW4odm9pZCkKewoJaW50IGk7CgljaGFyIGJ1ZmZlcls2NF07CgoJbWVtc2V0KGJ1ZmZlciwg
J2EnLCBzaXplb2YoYnVmZmVyKSk7CglidWZmZXJbNjNdID0gMDsKCglmb3IgKGkgPSAwOyBpIDwg
MTAwMDAwMDAwOyBpKyspIHsKCQlzbnByaW50ZihidWZmZXIrNDAsIHNpemVvZihidWZmZXIpLTQw
LCAiLSUwOGQiLCBpKTsKCQlpZiAob3BlbihidWZmZXIsIE9fUkRPTkxZKSA+PSAwKQoJCQlkaWUo
IllvdSdyZSBtaXNzaW5nIHRoZSBwb2ludFxuIik7Cgl9CglyZXR1cm4gMDsKfQo=
--00000000000056798e0570d138d2--
