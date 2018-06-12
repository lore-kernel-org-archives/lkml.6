Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6EB29C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFAD2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="M/NRHvrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFAD2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933994AbeFLVYQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:24:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55528 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933173AbeFLVYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:24:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id v16-v6so1179503wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 14:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A65GuVh3Xf/UIsGvCEfFhd/waTry7eJAr1W3EBVir68=;
        b=M/NRHvrMTbAcYDNRsXLFnyc7hmLOFvK8ip5nieC8O49w1V9zGdVqeHlILwEeFWPY8N
         A5ADtzbc9MFHfQd5ef6pifODvt8r/N0gFbCGzVrNf6M5rK4fmHC+1HD5BbBQSHCeDspA
         k6oQ18An/lw2VbcOJcWJw9/m+6qHH3f9GmMo1sITgJREbYgkz98UFTBGvCDN6Ancvmww
         Lc1dqc1LuYvDzSoc51HsIrq7tVGvkKvIhMo8+067wjDGPUNf7wUwxm8PX0IGAoJrH9vQ
         9n4AHOG0qpB4uVbJTfIPxfWObhwGW8GevECP0+1wHNNdel6cYixYdFFcBE5UXLm2mm3u
         DYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A65GuVh3Xf/UIsGvCEfFhd/waTry7eJAr1W3EBVir68=;
        b=fma1Y0GaYb1pG3WLZfHYgNuNZz9rUQ51y411ybLVBEo1otekQlSYFL224l6228BxY5
         PM0q5VOXcMwLhtm1c0kjmLCJsVfphYe81xWd7ILauY1B/e24UrwjD0axQdZ5jIjmH7a4
         vxZBVzO8m8Bbk+4qNeEC8tf1BfLOHdBjzlCzFVqKzKhZLUKMF2RlFPWGNRrF4Nzfzlcm
         sXfVkqbK4eC6TLrIWcPSqcf25oStGcCMeZGaLmdZJJfTg03xyU7MbY2SInhCZO1Fvr5t
         Hctk3/LUpKzZv7+clZLYh5V1mIRdMkH7GO7aTwRNEnKlVTFk+lgd9101PpP55i4Rl+um
         yTZQ==
X-Gm-Message-State: APt69E17mYVHitDY0fd94nkXy1ZXrcfWlNXGGsBd2I3mktvGVyJQNagm
        duAVxl2KLXkYEO0I11uwNvbXXIw2gRg=
X-Google-Smtp-Source: ADUXVKIzcrEUE8O3gd2/7C6MPdnP1FBbHF2UYfQvh9VSCrfwfFS5+nB3fKwXlkRJgdbhQ2e/+/pKUQ==
X-Received: by 2002:a1c:58d1:: with SMTP id m200-v6mr1767919wmb.160.1528838653788;
        Tue, 12 Jun 2018 14:24:13 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f13-v6sm506213eds.15.2018.06.12.14.24.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 14:24:13 -0700 (PDT)
Message-ID: <1528838651.26829.69.camel@arista.com>
Subject: Re: [RFC] x86/vdso: Align vdso after searching for free area
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasiliy Khoruzhick <vasilykh@arista.com>, x86@kernel.org
Date:   Tue, 12 Jun 2018 22:24:11 +0100
In-Reply-To: <20180612204948.4752-1-dima@arista.com>
References: <20180612204948.4752-1-dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-12 at 21:49 +0100, Dmitry Safonov wrote:
> There is errata for AMD family 15h CPUs [1] and since
> commit dfb09f9b7ab03 ("x86, amd: Avoid cache aliasing penalties on
> AMD
> family 15h") bits [14:12] are being cleared for shared libraries.
> Also per-boot ASLR applies over upper bits by OR directly over the
> address.
> 
> As we need special alignment and lower bits values to be set, it
> makes
> only a little sense to call get_unmapped_area() after calculating the
> address. It also can lead to random crashes if get_unmapped_area()
> actually changes/aligns the address, which we observed on 15h CPU.
> Usually it's not a problem as there isn't many mappings (except
> possibly
> ld.so, uprobes?) and result address is the same before/after
> get_unmapped_area().
> 
> Move align_vdso_addr() after get_unmapped_area() to make sure that
> errata for AMD 15h is always applied.

Alternative dirty-hacky idea:
specify some (struct file*) to get_unmapped_area() for vdso vma, then
mapping would be automatically aligned. Dirty as hell as relies on
get_unmapped_area() realization details.

-- 
            Dima
