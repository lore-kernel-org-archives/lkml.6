Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F209C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAA820894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4NHciWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAA820894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389208AbeHAOfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:35:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45440 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730355AbeHAOfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:35:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id f12-v6so10075865wrv.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 05:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wp4MRKtGBvimo/r6PLg7g+lX2TFTv07oL2qBcwZy5S4=;
        b=M4NHciWLM7fQ8/s+ALHFoDKlBNH5wDpiEDUiVbSH2+/MPNHdXZ3V8KApf7oaMX1V/L
         t+Y6N2k/UT3C1mtLKXetDh1fY96jNbVCf7rrTISyqy2Gir2g5i0+884gga9brjX4wNeK
         o2+7lQqa5TEmb/9dwVFJ0RIhzjoIHFxjxUhvzoXccdUbpSMSYts9Z3NbKUngsSXSWAFk
         aC91vjAm2m7vahXLKtEu4wr34OlUlDotqHzo1s7bd5fXTHPtwMQFa4jOQXHZmFTlD1Vf
         o/C+svOgvcU3cpwBAKxdz3akyTTHKV87xZEVPnPuIVHF6tfYbkeFTidJrK/MK6pUSgtV
         Ywzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wp4MRKtGBvimo/r6PLg7g+lX2TFTv07oL2qBcwZy5S4=;
        b=bdaLo6jTknM86Wx8HuDwLNv19K3GJT7Z9XFV74iBA5AwWXOfRf68+n4EeSd37bMcjS
         /ZL7u438krNjuGyvn4sI6n8VTg3tTbtfSNxn/0nT6Twg0HOJ8zLZ5l5HgkaoLj8KPj3E
         YJvAh6vNv36iLCSlMhukwySiU3R5sRg2U3fOt4wIhess+CVTIe5ihdXWaxeY+4xPyYBG
         ID0d1sF3eWNWJgU601dJ8IDvVOtyHFHCc35O1Cear4kFwKrFjE/d3Ho0RxOFFRPkkLcy
         Fqadrszpy/7GTQgPhe03q6TkTcJCHrRO+rLP5UQCPhhh9aD85GLqULwu2HsGIqGYb2q1
         Blbw==
X-Gm-Message-State: AOUpUlELP09kfm8cYLfIZzkS772AtEwSgCvGE+FiWFQY5KyeBGLtitRC
        3/cS0sgFuoSqmbVBoxKg+9qVb8qmGP+OTxTpi+qkenx62Ow=
X-Google-Smtp-Source: AAOMgpfppHPjHtKfaSO7Zu3K5Z7MxcK9Q1ZnDoSxRtbA7nmHQxdBIiVgpU6qowAD76Gr/2sI017BruI0ZUOiTcgo5E4=
X-Received: by 2002:adf:f210:: with SMTP id p16-v6mr24419991wro.184.1533127784805;
 Wed, 01 Aug 2018 05:49:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:8487:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 05:49:24 -0700 (PDT)
From:   Mathieu Tarral <mathieu.tarral@gmail.com>
Date:   Wed, 1 Aug 2018 15:49:24 +0300
Message-ID: <CAPXUdKFpFw2GAQ+mUHKz1oN+DRn6VvxB-AbUGD+YAXreAf-MQQ@mail.gmail.com>
Subject: pthread_sigmask call is hanging in the kernel
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

while developing a patch to perform introspection on KVM[1], i'm facing a bug
where a call to pthread_sigmask(), coming from the libvirt client library,
hangs for no obvious reason[2].

I come to ask for help and guidance on this mailing list, as i don't know how
to proceed further. In fact:
- the bug can only be triggered on a bare metal server in public cloud, i was
  unable to reproduce it anywhere else, including a VM.
- given that the server is in public cloud, debugging with KGDB is impossible
  since it requires 2 computers with a serial cable (as i understood)

After a few discussions on the Libvirt mailing list, they suggested the bug was
due to a memory corruption.  it's a possibility, but very unlickely as I would
have seen unexpected crashes everywhere else.

The kernel i'm using is a modified Debian Stretch kernel.

The next step for me is to understand where the call is blocked in the kernel,
and I would like to ask you what are my solutions to get a kernel backtrace of
my process in this situation ?

[1]: https://github.com/KVM-VMI/kvm-vmi
[2]: https://gist.github.com/Wenzel/6dc9e32558a7ffd51d1c0d89177532fc

Thank you for your time,
Best regards
-- 
Mathieu Tarral
