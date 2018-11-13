Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0CDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29F4216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJTk7Q+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29F4216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbeKNG1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 01:27:06 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41103 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbeKNG1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 01:27:06 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so12318475otk.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 12:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o76oz03Md1bcJeOgRVzYE6RWZcKj4CcMg4wxPculGAk=;
        b=pJTk7Q+mY0QnOtfW0xY/F4nQciQ977RUvVPc2FLlrLF+ILPMhEAM6QBohW/Af+kD/L
         kOCbKLTQssQzif0dWZMQj9rIsOgIrk6CYdJZI5r2cJ92AJgCfNxvU65owYaKzJMWrRd2
         oi8vPm6+y75dYvvbUKPns8Aqg3tOMB/VBQ8BuL70ZvyUWjYV7PqLJf7xtgQjLSzavfwO
         oSUKt2MIz0jIyCaBvhis6Qx1CFLGGms1+FxIg0f+L2XLzdUNiyBPaSRHKPJKGEU1hunm
         BRo2KocFGsSZ5dSO15yF02GAZtSiXmOrJiHNNgv/AVJkfqjrO2Jds0hhgcsWl36aS1dJ
         OESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o76oz03Md1bcJeOgRVzYE6RWZcKj4CcMg4wxPculGAk=;
        b=uasxwx0hYtR9W+H6vnqhR39QQ+u0Wmm5O2W5hF3qQl8OsP0p1R7Z1uQxcccQEEqnT+
         noDOESYDRarMAKVi9REWtmiUNxRSiTNpy8wBm0xLItMI9Rc7znUNvZ28CaYFjXhDwmLG
         rr8ugkH8ynWKdnmuqYodg+bt8HoEsfMCA1I+sIc25NhhEloseMY8YdYzoJqq8l+oz7k1
         tlsnafdIWii7ekySPeEFU7KoKPxp6Be3rmKOfD+hZLqGup7bN1kZiFP+vjud+GNATH7P
         8HmM5rmOT1Amj6MWV3BhuYkONMsGnevg5IoeFQjwzmLvWXvcz01nyLm1zQqgfgrkrNRq
         2sQw==
X-Gm-Message-State: AGRZ1gLX+7/IfPEsQGwlB7O0s4KSYzL+j2imqC9tFeq1zBa5+1JMVb+c
        +/UGe712t0e3VFa8wlS7C7PFYqenT9ZHLQHbXUYSMQ==
X-Google-Smtp-Source: AJdET5cs9b0zkSg+dvQx2h14t0+2Fpx/xYuseDkbMS55gScJV9z7HjGA5LRzZLqMl7Z9UzKpLndAaYAWMSWXtbj+sl0=
X-Received: by 2002:a9d:7059:: with SMTP id x25mr4278532otj.35.1542140838418;
 Tue, 13 Nov 2018 12:27:18 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez0ZprqUYGZFxcrY6U3Dnwt77q1NJXzzpsn1XNkRuXVppw@mail.gmail.com>
 <d43da6ad1a3c164aa03e0f22f065591a@natalenko.name> <20181113175930.3g65rlhbaimstq7g@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
In-Reply-To: <20181113175930.3g65rlhbaimstq7g@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 13 Nov 2018 21:26:51 +0100
Message-ID: <CAG48ez29kArZTU=MgsVxWbuTZZ+sCrxeQ3FkDKpmQnj_MZ5hTg@mail.gmail.com>
Subject: Re: [PATCH V3] KSM: allow dedup all tasks memory
To:     pasha.tatashin@soleen.com
Cc:     oleksandr@natalenko.name, linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, timofey.titovets@synesis.ru,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Gruss <daniel@gruss.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc Daniel Gruss

On Tue, Nov 13, 2018 at 6:59 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
> On 18-11-13 15:23:50, Oleksandr Natalenko wrote:
> > Hi.
> >
> > > Yep. However, so far, it requires an application to explicitly opt in
> > > to this behavior, so it's not all that bad. Your patch would remove
> > > the requirement for application opt-in, which, in my opinion, makes
> > > this way worse and reduces the number of applications for which this
> > > is acceptable.
> >
> > The default is to maintain the old behaviour, so unless the explicit
> > decision is made by the administrator, no extra risk is imposed.
>
> The new interface would be more tolerable if it honored MADV_UNMERGEABLE:
>
> KSM default on: merge everything except when MADV_UNMERGEABLE is
> excplicitly set.
>
> KSM default off: merge only when MADV_MERGEABLE is set.
>
> The proposed change won't honor MADV_UNMERGEABLE, meaning that
> application programmers won't have a way to prevent sensitive data to be
> every merged. So, I think, we should keep allow an explicit opt-out
> option for applications.
>
> >
> > > As far as I know, basically nobody is using KSM at this point. There
> > > are blog posts from several cloud providers about these security risks
> > > that explicitly state that they're not using memory deduplication.
> >
> > I tend to disagree here. Based on both what my company does and what UKSM
> > users do, memory dedup is a desired option (note "option" word here, not the
> > default choice).
>
> Lightweight containers is a use case for KSM: when many VMs share the
> same small kernel. KSM is used in production by large cloud vendors.

Wait, what? Can you name specific ones? Nowadays, enabling KSM for
untrusted VMs seems like a terrible idea to me, security-wise.

Google says at <https://cloud.google.com/blog/products/gcp/7-ways-we-harden-our-kvm-hypervisor-at-google-cloud-security-in-plaintext>:
"Compute Engine and Container Engine are not vulnerable to this kind
of attack, since they do not use KSM."

An AWS employee says at
<https://forums.aws.amazon.com/thread.jspa?threadID=238519&tstart=0&messageID=739485#739485>:
"memory de-duplication is not enabled by Amazon EC2's hypervisor"

In my opinion, KSM is fundamentally insecure for systems hosting
multiple VMs that don't trust each other. I don't think anyone writes
cryptographic software under the assumption that an attacker will be
given the ability to query whether a given page of data exists
anywhere else on the system.
