Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DE7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68EF20672
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68EF20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeKUSLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:11:50 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38014 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeKUSLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:11:50 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so3922111lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 23:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3KMozNGj1coHe+3WTAxZcek8Y2kN6Qos9qrVM9zI6c0=;
        b=Tc5UoYjC69asu8yN1q8P4E1D/j3UskNelWyQziOEh8wjZLN74RZnnBuULES6vkn9JT
         79X+adwDa/eRne+fPA1F7o19MGjl5zyO0yz1aYa3K70q3PklKALz+Vn2YPM8DG+IBHPC
         /i6Av1VXWYMT6LHlEoJxCYTUP44h6Pwwa83KHxOR+z4oxcT6lp3IjW2WL4vgckebtqpQ
         iDVN9hQJdHtjwWFJQbNgcLTLuIYkdYgQ6aEgKAqgxm9G8rAs6HwuXitsL9/GPovJ8x8b
         VWN+50eDIXNjiS/h1NHYWWkmpkxq/0/KWjXCA2R005PIVDvNQrDsayIbsQl5OVOp6O3C
         kdAQ==
X-Gm-Message-State: AA+aEWYhT2XJSro021hTARkC/YiutC4dWix5PqPqxaD+lKqK1M3yLlzI
        EFXsVwloVYItJg9HgwuUec4dBeVk6mlXXDIXkIcmyg==
X-Google-Smtp-Source: AJdET5dBG7wzjDlt1ONnNhgnHVqkTXYoHiDldR0zYMy9xq/Fo5ofldPk/+tynu5Rq5X9cWFAeZQ5MA8XcJrRRj2X6jk=
X-Received: by 2002:a2e:8449:: with SMTP id u9-v6mr3528609ljh.121.1542785905298;
 Tue, 20 Nov 2018 23:38:25 -0800 (PST)
MIME-Version: 1.0
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com> <4AE2DC15AC0B8543882A74EA0D43DBEC03560F84@BPXM09GP.gisp.nec.co.jp>
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03560F84@BPXM09GP.gisp.nec.co.jp>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Wed, 21 Nov 2018 13:07:57 +0530
Message-ID: <CACi5LpPestnsByi29X9uOaP04J3LgG4BSj_ODKEDG8S9sLkEsg@mail.gmail.com>
Subject: Re: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
To:     Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Baoquan He <bhe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Anderson <anderson@redhat.com>,
        James Morse <james.morse@arm.com>,
        Omar Sandoval <osandov@fb.com>, x86@kernel.org,
        kexec mailing list <kexec@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kazu,

On Tue, Nov 20, 2018 at 2:47 AM Kazuhito Hagio <k-hagio@ab.jp.nec.com> wrote:
>
> On 11/15/2018 4:47 PM, Bhupesh Sharma wrote:
> > Adding 'page_offset_base' to the vmcoreinfo can be specially useful for
> > live-debugging of a running kernel via user-space utilities
> > like makedumpfile (see [1]).
>
> I agree.
>
> > Recently, I saw an issue with the 'makedumpfile' utility (see [2] for
> > details), whose live debugging feature is broken with newer kernels
> > (I tested the same with 4.19-rc8+ kernel), as KCORE_REMAP segments were
> > added to kcore, thus leading to an additional sections in the same, and
> > makedumpfile is not longer able to determine the start of direct
> > mapping of all physical memory, as it relies on traversing the PT_LOAD
> > segments inside kcore and using the last PT_LOAD segment
> > to determine the start of direct mapping.
>
> Actually, the KCORE_REMAP segments were already removed from kcore by
> commit bf904d2762ee ("x86/pti/64: Remove the SYSCALL64 entry trampoline")
> and kcore's program headers got back to the previous ones, but this
> fact shows that they are changeable.
>
> So I think that if we have this NUMBER(page_offset_base) in vmcoreinfo
> for x86_64, user-space tools (especially makedumpfile) would become
> more stable against changes in kcore and vmcore, rather than depending
> on their PT_LOAD values.

Thanks a lot for your review.

Hi x86 maintainers,

Ping, any comments on this patch. Since it is a useful addition to the
kernel-userspace ABI (as suggested by the user-space utility
maintainer as well), can we consider including this in the kernel?

Thanks,
Bhupesh
