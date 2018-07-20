Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0479CECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B107A20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEFOwmDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B107A20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbeGTLFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:05:10 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41568 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbeGTLFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:05:09 -0400
Received: by mail-oi0-f68.google.com with SMTP id k12-v6so20409437oiw.8;
        Fri, 20 Jul 2018 03:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eoQOWcYjPyrQL46BBZRMuAPHgOx+/WdSaZT5yDOAx/0=;
        b=pEFOwmDUYpDGU+KuSdsiHhUeoo2LKO4fL4/keerfuvoPMZitLNfu+EZjnU8ZIVehFk
         XTwpaTn0swLy8EuHc+8NvKWn5s96W/E7FQrBpOSk5o1QLQOae6IAtKqa5vKnOq3jzJJi
         H8EhgSjA0R5O8bHR1JOKO1VPpLFN58gbdA9Tup/IyX6ynd92mHRCpwGkG06bpGnNUbEg
         59jmUILy3CrfGYM3iks30nBL0WGr21C2oh6YTWcO1JXCwc8QJPi+s7/qhoptEoxjjjJA
         6GXyepVlWk/p6G50f585KgcjY7xap3Jz8N1tjUp4M8W5ThmxQ5/7lbY5nKjTQm3bjMoS
         EGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eoQOWcYjPyrQL46BBZRMuAPHgOx+/WdSaZT5yDOAx/0=;
        b=e+/AF02HG3KgJS8cUy3cpFJpBs7N5szhtWrNrJgbUI3ia56VArijq2YDOhuQjYFhCH
         bkomNrVJoakId4jBtgNK87kp26vG3p0+7ymFHviiXHqg1vctg08GJ/8s0KrTZaQ7mzn4
         hfx2ICk1gX7edcKy0n8x/j6NKuwdWzVUzUb42qjU2Zn3DfcB8fmKI+RJo74itoiWm0d1
         LaVEfVS0Pkru+aIJuzqun9rMSLjP3+7rRvH7NmHl7HjLhpRXc2JIP7DuUesSeBfp1uPF
         /3HIbWviRnwLERnMz+JE/ssDth88pY+ngBMKAw7o7wDeVy/9AK+7wtjo/M8g7XrWQftD
         X5vg==
X-Gm-Message-State: AOUpUlFoZ9WuRdKh/uJ2oTffdgDq6Oj2llxnEwtGjAPcrzbzdtB2Pzl+
        8+kEw+OqoPB701vFdiWaGUUBxw1DIlywOeJiOi4=
X-Google-Smtp-Source: AAOMgpfNLjB6WOzcSYwqXEecnreCyky5unVAr6OjYnXejSlKUVO8R0zVjYEKs71u+2alVoUvTQyefKfh4bI666Nve2I=
X-Received: by 2002:aca:ad4f:: with SMTP id w76-v6mr1487902oie.233.1532081856269;
 Fri, 20 Jul 2018 03:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
 <1530598891-21370-3-git-send-email-wanpengli@tencent.com> <20180719162826.GB11749@flask>
 <CANRm+CxztUxixUNtsfZC3D1Zeo8QJsTefc565CkMBqWyXVfuzw@mail.gmail.com> <20180720095135.GA8330@flask>
In-Reply-To: <20180720095135.GA8330@flask>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Fri, 20 Jul 2018 18:17:40 +0800
Message-ID: <CANRm+Cwic4kV6sWUvDMVb7PRn0kjCW7xLMyN-G7Px+ciDZb9qQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] KVM: X86: Implement PV IPIs in linux guest
To:     Radim Krcmar <rkrcmar@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 at 17:51, Radim Krcmar <rkrcmar@redhat.com> wrote:
>
> 2018-07-20 11:33+0800, Wanpeng Li:
> > On Fri, 20 Jul 2018 at 00:28, Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redh=
at.com> wrote:
> > > 2018-07-03 14:21+0800, Wanpeng Li:
> > > But because it is very similar to x2apic, I'd really need some real
> > > performance data to see if this benefits a real workload.
> >
> > Thanks for your review, Radim! :) I will find another real benchmark
> > instead of the micro one to evaluate the performance.
>
> Analyzing the cpu bitmap for every IPI request on a non-small guest (at
> least 32 VCPUs, ideally >256) during various workloads could also
> provide some insight regardless of workload/benchmark result -- we want
> to know how many VM exits we would save.

I will try ebizzy benchmark, just complete the patchset w/ __uint128
which Paolo just suggested. In addition, I remember aliyun posted the
performance number for their online real workload "message oriented
middleware" from 800 k/s vmexits w/ PV IPIs to 150 k/s vmexits w/ PV
IPIs.

Regards,
Wanpeng Li
