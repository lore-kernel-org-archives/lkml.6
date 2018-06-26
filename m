Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111C2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71F3268EA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jewM3daz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71F3268EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935407AbeFZMr4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:47:56 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51448 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935341AbeFZMrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:47:52 -0400
Received: by mail-it0-f65.google.com with SMTP id 128-v6so2114938itf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 05:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PT1XIj0WBeJ5DCWbGQC8il7OaNsRxYvPefALlLLBAlM=;
        b=jewM3dazMVYE15hJMjHLaByrCjeLeTSk2dAjzJgT3BpP6M6oJ9tp9yZW16DMih9DSq
         hABl+fFPZcGrbLRLnOeqxteyFtVTHn84SDfnEN1qArqrxB/h3FdVhlvUFlOEx6zKPyU7
         4KeaYrNg5uKiFveaUrbqch7/Tx7bp1DSVqB2q2NP2RBIk84zzxkgUtl8rf7ZDgN4H666
         Tf+OnRTpqxLsFn+jQxdK9dgjAEYFCDTbXlkvZJV64oytpvZch07LGFYwfJXNLRwHod4b
         LggXzXEw82dVm6XgFhpaW1MSMCLH7NHUXtWpQ8IcCWzp/YKSPI4LeLN0Mjl77lwzMUjC
         FYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PT1XIj0WBeJ5DCWbGQC8il7OaNsRxYvPefALlLLBAlM=;
        b=K7OY4CJLXXnwuWVcSHDEXU6ett4PdYSwy9Zqc9ufbStfyAKW8yJv/L3XEOh7UyTX91
         Pw/bYRP66yuMO1FFoGvAbZKBkUIO2qeG4r3kWa3xytp663L3QiGpQAMk3vZ2C8fN6YIi
         Y1o5eYFIqg0+q9ZkKksmzdy0QM0LwggHOSv1IYmDlckvskLcUmbVjZ4yihFQTKfV9aCF
         /t9Jtvg3WLD/uUbyO7JPItvxl5lPcl0Hs5F1P56IzzKnQHXDzmxrMVINJrHocg0rYsGm
         Tw/2ci3ljVRs7K9Lqbc5r9PPAEMONJjln+q2ADfWrhuEWi75g3SJZqBCCf39H9J7Pn1G
         pzmw==
X-Gm-Message-State: APt69E1J6784eG1krNFcyhh12DTCUQ2Ow+VaakgtEXpEBs0kbRcoBBZj
        tSww/S5QyZEuq4byBvx4aGFkhx4FCzGH8L+3Q6IMRQ==
X-Google-Smtp-Source: AAOMgpeFt9MYc+nUWUxqfPYxeX4Gst0QmKHGyId1gCbo5mZlebpGU2DGRL+oHyER7ziGGo/QFk8w6TmoHEgus7D0Nac=
X-Received: by 2002:a24:ca43:: with SMTP id k64-v6mr1396237itg.44.1530017271527;
 Tue, 26 Jun 2018 05:47:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:9082:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 05:47:50
 -0700 (PDT)
In-Reply-To: <cover.1529507994.git.andreyknvl@google.com>
References: <cover.1529507994.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 26 Jun 2018 14:47:50 +0200
Message-ID: <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-doc@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 5:24 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> arm64 has a feature called Top Byte Ignore, which allows to embed pointer
> tags into the top byte of each pointer. Userspace programs (such as
> HWASan, a memory debugging tool [1]) might use this feature and pass
> tagged user pointers to the kernel through syscalls or other interfaces.
>
> This patch makes a few of the kernel interfaces accept tagged user
> pointers. The kernel is already able to handle user faults with tagged
> pointers and has the untagged_addr macro, which this patchset reuses.
>
> We're not trying to cover all possible ways the kernel accepts user
> pointers in one patchset, so this one should be considered as a start.
>
> Thanks!
>
> [1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html

Hi!

Is there anything I should do to move forward with this?

I've received zero replies to this patch set (v3 and v4) over the last month.

Thanks!
