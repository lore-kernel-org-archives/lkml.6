Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CF5C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 04:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B57521711
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 04:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfT7FtJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B57521711
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeHCGEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 02:04:11 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40336 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbeHCGEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 02:04:11 -0400
Received: by mail-oi0-f65.google.com with SMTP id w126-v6so7537601oie.7;
        Thu, 02 Aug 2018 21:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z0WojwAho9zVnqxXZlVAoq28/pzttXCvEcktqIzxO5g=;
        b=YfT7FtJPk8btYxSAD8LpaI2InxfYEdQx53pJSRhNpXK2FhAuRJUNCM71LmwKKguXMd
         4rKvA3ilVYtlXlrVYvFStU2ZNhNMqYpIlH/cERmKxeiK9DnuKpEAaP0U3P01t5/iIMqf
         tU+A0woFky+0JdQ25z7u1Qmrl9fE/w2cRjbU9Tkyj0ukosfLs0Wr4TJU/u+HQXnx6YLq
         fQTMsRbLPQ/3cVFDH4cR/TkGLUVDxBHd4jVkuIUv0BSJG5naOFUZy09/wzDPOTE1epOR
         fKSVWbTbzw9/cgWLObfsOVcLLk5IXiawGt1tiqFPVT4gq6V92g+ktsDbADHRbBdnTbIs
         EjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0WojwAho9zVnqxXZlVAoq28/pzttXCvEcktqIzxO5g=;
        b=KfKksmGRcz9o0lto1/eDRO7o4lvM6yYA+ntcMW8iJzYKC3WUbCi01LZu/fstIcEooc
         vmWMDnfq1iWohIelvoxfOliv+irvkcMBRkizuuUzDgVG1neCN9q0M7lt4Z0Yhpxyw46X
         uIa+NwguvLe9gFPhfDG6BGq7csAQPzDAj1u0FzItJMDSt+C5KKrZ3z00BbEYIbvNitwq
         BA9uQCtY8VQXeYWnCJxB0HYyZJZsddxgsNJyBcAah9Hk4s4JeU4k7KeVRPLKmbKGZMBC
         T8kBR73rjLAZ1l7/nGoht+QREGY+LZK5cb65FTvh3SIF/Vs2lDdZktx78tnGWmUdYLg/
         ddJQ==
X-Gm-Message-State: AOUpUlGVfis0eNtSH/fcWmldQq83tQ+LAsxqMQF8lYi2K6JSEVhPCOiF
        MvqHfvHjN8WAUi9gyL/lvhHrG8X25730cuUizXk=
X-Google-Smtp-Source: AA+uWPz7ywignb94u5i5oa0zf1ecuAyZLdg6KFtpbNoThDnws4kdCfFb3CQCII7c/XgpXnUyOrc9A+6JbwLVob8puSQ=
X-Received: by 2002:aca:ad4f:: with SMTP id w76-v6mr1671594oie.233.1533269391541;
 Thu, 02 Aug 2018 21:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <1532327996-17619-1-git-send-email-wanpengli@tencent.com>
 <1532327996-17619-5-git-send-email-wanpengli@tencent.com> <cdf73aa6-d532-f522-2738-078b4acc19eb@redhat.com>
In-Reply-To: <cdf73aa6-d532-f522-2738-078b4acc19eb@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Fri, 3 Aug 2018 12:09:55 +0800
Message-ID: <CANRm+Czkx0BTYh_6=WLVE8bUS2NkNuB0-F_Jb=TADHUb6p5Dvg@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] KVM: X86: Implement PV IPIs send hypercall
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2018 at 21:04, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 23/07/2018 08:39, Wanpeng Li wrote:
> > +Returns 0 if successfully delivery the IPIs and 1 if discarded.
>
> I'm changing this to
>
> "Returns the number of CPUs to which the IPIs were delivered successfully"
>
> with an obvious change to x86.c.

Thanks Paolo!

Regards,
Wanpeng Li
