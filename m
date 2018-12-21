Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB6DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E268421927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="r8K0LsTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390819AbeLUOGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:06:06 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39408 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389027AbeLUOGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:06:06 -0500
Received: by mail-vk1-f193.google.com with SMTP id s184so1176103vkd.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 06:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sWKARN8/VCXibTg+NNQexXIY2rqC24fDbGVY37avEas=;
        b=r8K0LsTXrL50PWWvc8H3HRzopFOoWXVhd4rX+i3LSpnfy8TvRq6M2V+xBF3jnhNuj2
         YmmKtiRezLDTZGiU+cfVEW7N62g1gpNBDyVxR4D0ezGU9R8cwfcyPFBJ8zf633RwJTyN
         wxhtFOcQ9RwEoAKViywMHDl0JZSPF8pr/Gub8DleEIo4cH5Zx6gM8DLUp/OwnDx3ZhAY
         ajdACTikjnw0hmq8RjYM4yW5svqeXCKR2tHgXTW9pqUoH/5ZFz9MBIJ/qwaOlf/g1qG+
         gu0alGrHLZXCMRdfEa4Yh0Lh71MXNjSSYo9MdAVRFKekHLsHABhj2sRixCV2gLRfMDy7
         KSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sWKARN8/VCXibTg+NNQexXIY2rqC24fDbGVY37avEas=;
        b=lr7LjG95BCFESSXu2uOoeg5veUKWYW1HnTcMEP50INckS43VujKNsOLyGa7G2vgpci
         wnevTqn01yi1A6R8Lml02Hw4J1ewqwKs9uXHaxKqrOwOyNYwUFLZi2VF6BnQmFFsSIms
         hrDzoULYWyoEg1jsahaOnd3igY7FQrz5NcrVATBgbVPgwnBsJpclNjs2l0nEMjNXb3jX
         nzu+JHYrCRT+dOwz3ueqcqhrhdT0L+QU1XSouusYUjpxrbZeAJ8yPPMxncuEqzE3D6tu
         /oJVtNCFQ+8XvW1Sihz6epv8eRIw6o4z5PJq7NDUXmu0dOUFUbjyYbTcmh5A3/OZUC/J
         /TPQ==
X-Gm-Message-State: AJcUukdWVnp1zlInwPm+8IVu5fR2HOCfkcnmuwac8LDJS+BE8QlVnAZ/
        MS5MycLHQ4GeVDXSMxLeZaoJtMFpXq7T4ExqqsOWdw==
X-Google-Smtp-Source: ALg8bN6hFgWDu3D1YmWAptStk/IVSD/UuC+h32t30mytGyaxfChiKMwXR/qqga7zA98CZLn4JRbS3NitrL+wRaBRCCk=
X-Received: by 2002:a1f:a702:: with SMTP id q2mr965502vke.43.1545401164447;
 Fri, 21 Dec 2018 06:06:04 -0800 (PST)
MIME-Version: 1.0
References: <20181207124803.10828-1-ahmedsoliman@mena.vt.edu>
 <1544708187.5826.1.camel@amazon.de> <CANBxJ=FP9GSfMES3e5dSct2qV0Z=uz7uPXufQNqoi5e+sWxvgQ@mail.gmail.com>
In-Reply-To: <CANBxJ=FP9GSfMES3e5dSct2qV0Z=uz7uPXufQNqoi5e+sWxvgQ@mail.gmail.com>
From:   Ahmed Soliman <ahmedsoliman@mena.vt.edu>
Date:   Fri, 21 Dec 2018 16:05:01 +0200
Message-ID: <CANBxJ=H7x_LZ1h=+HrbTcBd2Qt+RWz+c+0_JkUseZG6k-ozvuQ@mail.gmail.com>
Subject: Re: [PATCH V7 0/10] KVM: X86: Introducing ROE Protection Kernel Hardening
To:     jsteckli@amazon.de
Cc:     Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ahmed Soliman <ahmedsoliman0x666@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?6rmA7J246rK4?= <ovich00@gmail.com>, x86@kernel.org,
        Igor Stoppa <igor.stoppa@gmail.com>, hpa@zytor.com,
        Ingo Molnar <mingo@redhat.com>, nigel.edwards@hpe.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        kernel-hardening@lists.openwall.com, rkrcmar@redhat.com,
        linux-doc@vger.kernel.org,
        Boris Lukashev <blukashev@sempervictus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > I don't  understand why this path needs to be optimized. To me it seems, a straight-
> > forward userspace implementation with no additional code in the kernel achieves
> > the same feature. Can you elaborate?

I was doing some benchmarking to figure out the overhead introduced by
ROE, I think I can add more
details about the overhead I am talking about, first I will explain
the existing paths for a memory write
attempts:
[1] Normal memory write is done directly in guest kernel space.
[2] Writing into Fully ROE protected page (The write operation will fail).
[3] Writing into Partial ROE protected region (The write operation will fail).
[4] Writing into writable memory in a page that contains Partial ROE
protected region (The write operation is committed to memory).

Path [1] is the normal write... guest kernel will not have to switch
to guest and the performance was almost the same between host and
guest, Writing 1 MB (a byte at a time) took no more than 4
milliseconds. This will not be affected by whether ROE is done from
users pace or kernel space.

Path [2] will switch between guest's kernel to host kernel, then the
host kernel switches to user space to decide what should be done.  The
guest host ->host kernel -> host user space switch is done on ever
separate write attempt (which is approx 1000000 in this case) It took
~5000 milliseconds to fail the 1M write attempt. and as the above one
user space ROE will not affect this one that much and I am not aware
of any possible optimization, yet ideas are welcomed.

Path [3] will also switch between guest kernel to host kernel to host
users pace...However the time taken to attempt 1M write took ~5000
when the guest had less than 32 protected chunks system wide, as the
number of chunks increased, the time also increased in a linear
fashion till it reached 20 seconds took to do 1M write attempt when
the system had about separate 2048 protected chunks. For this
benchmark I allocated a page and protected every other byte :). I
think this can be optimized by replacing the linked list used to keep
track of chunks with maybe skip-list or Red Black tree. and It will be
available in the next patch set. as the previous cases user space VS
kernel space will not affect performance here at all.

Path [4] The guest kernel switches to host kernel and the write
operation is done in the host kernel (note we saved a switch from host
kernel to host user space)
The host kernel emulates the write operation and get back to guest
kernel. The writing speed was notably slow but on average twice the
speed at Path[3] (~2900 ms for less than 32 chunks and it went up to
11 seconds for 2048 chunks. Path [4] can be optimized the same way
path [3].

Note that the dominating factor here is how many switches are done, If
ROE was implemented in user-space, Path [4] which will be at least as
slow as Path [3] which is about 2x slower.

I hope it is less ambiguous now.

Thanks,

--
Ahmed.
Junior Researcher, IoT and Cyber Security lab, SmartCI, Alexandria
University, & CIS @  VMI
