Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EABAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1240321582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="soqoRib2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1240321582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mena.vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbeKOHfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 02:35:18 -0500
Received: from mail-vs1-f41.google.com ([209.85.217.41]:40849 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeKOHfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 02:35:17 -0500
Received: by mail-vs1-f41.google.com with SMTP id p193so10107772vsd.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 13:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1vFwOV6VNGy7lBStJB4N2vsro8zVb+cmVMTeeOFaWo=;
        b=soqoRib2DMkStpFKMw+LS1gQDPTUz/apbGR2LCBlw7SYmXnCXN5l0aQcQTwCHF/ul8
         pnup1qM4LdCrJI3fE97Sv6xPn9r36qwUYybkLTfbL8evcaYrC6TkMtBkSWzCcEohJMVN
         fUmKeHUlP4KvhSf7NYTtVGk4yIybxojL4jSAdKYQdE4ymPf5r2nBSergmBycAB1yIr03
         BFC4By75lQEdGwxZjkMu9yNO/N1COtETEjQqmpwzhEFPpNwnmibXTmcwQaJB0F+HXhTM
         mqrYmHUY4L7RDlv8FUS1AIAMnNX9HwNSQYxkNpSBD8yFkda0fbrEl+s9aNZNO1W8sUz2
         XTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1vFwOV6VNGy7lBStJB4N2vsro8zVb+cmVMTeeOFaWo=;
        b=g2H2eFj0uuGM29coxhp9fYN0fsyKOnJb+Kv2nhsq1jzu4ecKoIRFfz0CEUsNdaWE8R
         rsSBr+Xw/LnRRx0XPJ/vnsuQRKfo+Q+CTdoGwAjY45E8HkyMAvPSy1Lsp3uYEJ9roPfB
         9pVlC47HIQ2DE7wCPcyOS1g8lJ3j8PEngSMq53sL17qInjAL5IiARkLR2ld11YVt48dD
         mQ2duOB3Tzf2SqUwl+14jjzjYWKy1o/9nH2vLfSia3QWRT52TSd20Aj6R5DFq72smssy
         N0jccIJK2pYg4aoWJuVUfufn18wja+gabWuwBEv+7b4ame/27X1uanOK/n8QWJvnKQzo
         PV1A==
X-Gm-Message-State: AGRZ1gK62c+tc3WtdYnsUUKpRm0+47QJOpe7XZvQqO093IlB2EaeKMCe
        ogIpy63CT1x1Y92UgaYwUg6pyTPQfg7iqFCOxemYxg==
X-Google-Smtp-Source: AJdET5eMF9we8mF74FnHwnEuKTXUkURS6GhIBgsR2F4+pGwb0bRSZj3GGtFPDX/kis7HhQMi9EbiKrvONl9CQ0Pjn9I=
X-Received: by 2002:a67:3b88:: with SMTP id l8mr1592104vsi.47.1542231021787;
 Wed, 14 Nov 2018 13:30:21 -0800 (PST)
MIME-Version: 1.0
References: <CANBxJ=EQOt1t=PkLsMvtfB2SbiLMPeGvFxB7SJXf7m3OkcionQ@mail.gmail.com>
 <20181114180807.6crs7awhvo26ldbr@hawk.localdomain> <CADYN=9Jh10guVNFfhS8XH+RwZAouLJQu7Svg4+Tz3rQDexzDkg@mail.gmail.com>
 <CANBxJ=G4xdF8ZOR4zyoX1edNa=jYxk1xrzoi+7Xgcqt9qDoM2w@mail.gmail.com>
In-Reply-To: <CANBxJ=G4xdF8ZOR4zyoX1edNa=jYxk1xrzoi+7Xgcqt9qDoM2w@mail.gmail.com>
From:   Ahmed Soliman <ahmedsoliman@mena.vt.edu>
Date:   Wed, 14 Nov 2018 23:29:59 +0200
Message-ID: <CANBxJ=EB8izWM8iLd49Uvd1z1O-gLvkGmiKNHjfHifFohj2xbg@mail.gmail.com>
Subject: Re: KVM selftests are failing
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Andrew Jones <drjones@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,
On Wed, Nov 14, 2018 at 9:23 PM Ahmed Soliman <ahmedsoliman@mena.vt.edu> wrote:
> I don't do a make clean normally, but I will do it this time when
> bisecting, also I only use shallow
>  clones so it will also take some time pulling. Also to note, The arch
> I am using is Haswell, I am not
> sure if that should make any difference though.

I started bisecting from commit 783e9e51266ebb7f78c606a53cb0fa41bb7c31a0
which introduces kvm selftests. I started from complete clean kernel build and
run, but unfortunately, I got the Assert there too.

Just in case it might help identifying the issue, this is the output
of my lscpu:
    Architecture:        x86_64
    CPU op-mode(s):      32-bit, 64-bit
    Byte Order:          Little Endian
    CPU(s):              4
    On-line CPU(s) list: 0-3
    Thread(s) per core:  2
    Core(s) per socket:  2
    Socket(s):           1
    NUMA node(s):        1
    Vendor ID:           GenuineIntel
    CPU family:          6
    Model:               69
    Model name:          Intel(R) Core(TM) i7-4500U CPU @ 1.80GHz
    Stepping:            1
    CPU MHz:             897.938
    CPU max MHz:         3000.0000
    CPU min MHz:         800.0000
    BogoMIPS:            4788.69
    Virtualization:      VT-x
    L1d cache:           32K
    L1i cache:           32K
    L2 cache:            256K
    L3 cache:            4096K
    NUMA node0 CPU(s):   0-3
    Flags:           fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
                     cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
                     pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon
                     pebs bts rep_good nopl xtopology nonstop_tsc cpuid
                     aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2
                     ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
                     popcnt aes xsave avx f16c rdrand lahf_lm abm cpuid_fault
                     epb invpcid_single pti tpr_shadow vnmi flexpriority ept
                     vpid fsgsbase tsc_adjust bmi1 avx2 s mep bmi2 erms invpcid
                     xsaveopt dtherm ida arat pln pts


> > What would be the difference in CONFIG_* fragments that you both have enabled?
>
> Here is my config file:
> https://pastebin.com/fCNV2z8c

Kind regard,
