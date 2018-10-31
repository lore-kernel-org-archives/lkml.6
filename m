Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CC8C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B383020685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ysz4Sgkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B383020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbeJaUOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 16:14:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33491 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeJaUOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 16:14:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id y140-v6so985151wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 04:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7vQvy5KLwqrDn7EUCo/8EmVFC5IwBb3hk8HLIvk7rnU=;
        b=ysz4SgkdjfFcFixMYBOz5KUEUklcvWIU6ajJ1JuDQjuxGeymuXouKrClLdFTJCDI61
         fqQSsVykHVcvdsVQc5FI3mkEYM7p94y2qFM2bvikJUsuSGyhcLSX3aLlGDimBYFn+Ivo
         wOvUZ5hAFaJ0vlZlRogMCZ+SSuZ4EBnwU+ltDRI2SilKMXmLE184joVL1K4jk6OhMoSg
         xRn2asexGTKWstpdyKmWXpyBcD6gpLcLmxUwKgazLBcmXlyi2lvpJDb2zH2aph7pEY8s
         OF1Lr1sK+9h71iO4dD5TjRd8iQFXX3bWqMtjEycWpuyY6bZ+oZBStRH57IVc39d+mbKj
         sdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7vQvy5KLwqrDn7EUCo/8EmVFC5IwBb3hk8HLIvk7rnU=;
        b=ZZmHPaWxBix/R7Q7L7VJPyQg9jSCaxdZLFnavXT8kL5eOroTfDPsYccp/dgZKAkkm5
         Uc9u8Kx+go/kLbUjIxjyunvm9I4/BOsnrGx8uWHS9ZTuCpamDwXSG2+2c8KefNnQ47ZE
         2r4L1qQbD3Ntlea4YVCMA4G7cI5+augk1Rvtrontiy41wVuuuLyBQMY4MpavMv+Q+Nxl
         WSntREE4qDBZ+Up73YUQFN7DnsZ6EpAW+JKWhDr/MBQJYkiePNmvZBX7AxW6GZvIMb8d
         8IXecc6+6ACHhZznEAeJvQ1jSsXvMyCORcNqm7DkNyoRr0vxCrrMnI3iLeGCOXf5V4r3
         74jA==
X-Gm-Message-State: AGRZ1gIqo4cEA3ZN8eSyuwCDpv+ymhy2lR75KFDEgfr7asSbiP7oUfL1
        y37MS76NFfXuthToVfWS2zJatCyoCCW5YdUaqpC1DQ==
X-Google-Smtp-Source: AJdET5faAzyy+wMLbmtf7+Merb3jsa/FDSCEvJNlc6neDZoPDcplqXrtuTRrCPNaLqPYj9XNn8U4DJuj4ZT15nu0/BU=
X-Received: by 2002:a1c:cf08:: with SMTP id f8-v6mr2003559wmg.56.1540984581673;
 Wed, 31 Oct 2018 04:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <1540982130-28248-1-git-send-email-vincentc@andestech.com>
In-Reply-To: <1540982130-28248-1-git-send-email-vincentc@andestech.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 31 Oct 2018 16:46:10 +0530
Message-ID: <CAAhSdy0Y_jdc=2Lf8epof_+7HigCfhDxMNe8EF0fHfncqhs-zA@mail.gmail.com>
Subject: Re: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
To:     vincentc@andestech.com
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong@andestech.com>, Arnd Bergmann <arnd@arndb.de>,
        alankao@andestech.com, greentime@andestech.com,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, deanbo422@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 4:06 PM Vincent Chen <vincentc@andestech.com> wrote:
>
>   RISC-V permits each vendor to develop respective extension ISA based
> on RISC-V standard ISA. This means that these vendor-specific features
> may be compatible to their compiler and CPU. Therefore, each vendor may
> be considered a sub-architecture of RISC-V. Currently, vendors do not
> have the appropriate examples to add these specific features to the
> kernel. In this RFC set, we propose an infrastructure that vendor can
> easily hook their specific features into kernel. The first commit is
> the main body of this infrastructure. In the second commit, we provide
> a solution that allows dma_map_ops() to work without cache coherent
> agent support. Cache coherent agent is unsupported for low-end CPUs in
> the AndeStar RISC-V series. In order for Linux to run on these CPUs, we
> need this solution to overcome the limitation of cache coherent agent
> support. Hence, it also can be used as an example for the first commit.
>
>   I am glad to discuss any ideas, so if you have any idea, please give
> me some feedback.
>

I agree that we need a place for vendor-specific ISA extensions and
having vendor-specific directories is also good.

What I don't support is the approach of having compile time selection
of vendor-specific ISA extension.

We should have runtime probing for compatible vendor-specific ISA
extension. Also, it should be possible to link multiple vendor-specific
SA extensions to same kernel image. This way we can have a single
kernel image (along with various vendor-specific ISA extensions) which
works on variety of targets/hosts.

As an example or runtime probing you can look at how IRQCHIP or
CLOCKSOURCE drivers are probed. The vendor-specific ISA extension
hooks should called in similar fashion.

Regards,
Anup
