Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D78C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 03:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94ECC20841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 03:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyVkgGrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94ECC20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeIAHuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 03:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbeIAHuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 03:50:19 -0400
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32C4920845
        for <linux-kernel@vger.kernel.org>; Sat,  1 Sep 2018 03:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535773192;
        bh=AAlUFWExg+GuQIMnAgl9hzfjFpVMUPdigaM+LBsspFI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=oyVkgGrcXeS5BOwjBoDfdAfHEM8imZm2tXPWqLFasLIn9cJ4oPc5c3s4i9ugvFmG9
         RQ+SPa8dYpPjukb3Q9jQ/yyzJ2ufDs953Ez5eAylGE07DFiNYeAh6rBZk7Hub/gdKF
         wWLcOXin+w78CPJ6lbLMUlHDSG6fItgEwbSwA2Nw=
Received: by mail-wm0-f46.google.com with SMTP id f21-v6so6796941wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 20:39:52 -0700 (PDT)
X-Gm-Message-State: APzg51CHvUevmA3NR8Mm8WHiikGkqmuZD/BectJs04j8jUnYMS7OXMTB
        1zWS2pAKN85qgtbRW2B8Ufq84Apb1QkJMEfypDCPLA==
X-Google-Smtp-Source: ANB0VdbFUUbTFUyKhhRLJUu+uOkywhiihr1lvfpfm3f3QQA7Z+lzmka5uDz0Lf+BhU6lAenZONXgj0FGDC4+usiFnlc=
X-Received: by 2002:a1c:ef0f:: with SMTP id n15-v6mr2035274wmh.116.1535773190659;
 Fri, 31 Aug 2018 20:39:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:9045:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 20:39:30
 -0700 (PDT)
In-Reply-To: <20180901015935.CCF0B18E20A9@virtux64.softrans.com.au>
References: <20180901015935.CCF0B18E20A9@virtux64.softrans.com.au>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 31 Aug 2018 20:39:30 -0700
X-Gmail-Original-Message-ID: <CALCETrU4PzskO9pE6G4EkXNRRX3Mu7Vvjv1P8XgrfRMdgGDZSg@mail.gmail.com>
Message-ID: <CALCETrU4PzskO9pE6G4EkXNRRX3Mu7Vvjv1P8XgrfRMdgGDZSg@mail.gmail.com>
Subject: Re: [PATCH v3] x86/vdso: Handle clock_gettime(CLOCK_TAI) in vDSO
To:     Matt Rickard <matt@softrans.com.au>,
        Florian Weimer <fweimer@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000007c59390574c70f69"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007c59390574c70f69
Content-Type: text/plain; charset="UTF-8"

(Hi, Florian!)

On Fri, Aug 31, 2018 at 6:59 PM, Matt Rickard <matt@softrans.com.au> wrote:
> Process clock_gettime(CLOCK_TAI) in vDSO.
> This makes the call about as fast as CLOCK_REALTIME and CLOCK_MONOTONIC:
>
>   nanoseconds
>  before after clockname
>    ---- ----- ---------
>     233    87 CLOCK_TAI
>      96    93 CLOCK_REALTIME
>      88    87 CLOCK_MONOTONIC

Are you sure you did this right?  With the clocksource set to TSC
(which is the only reasonable choice unless KVM has seriously cleaned
up its act), with retpolines enabled, I get 24ns for CLOCK_MONOTONIC
without your patch and 32ns with your patch.  And there is indeed a
retpoline in the disassembled output:

  e5:   e8 07 00 00 00          callq  f1 <__vdso_clock_gettime+0x31>
  ea:   f3 90                   pause
  ec:   0f ae e8                lfence
  ef:   eb f9                   jmp    ea <__vdso_clock_gettime+0x2a>
  f1:   48 89 04 24             mov    %rax,(%rsp)
  f5:   c3                      retq

You're probably going to have to set -fno-jump-tables or do something
clever like adding a whole array of (seconds, nsec) in gtod and
indexing that array by the clock id.

Meanwhile, I wrote the following trivial patch to add a
__vdso_clock_gettime_monotonic export.  It runs in 21ns, and I suspect
that the speedup is even a bit bigger when cache-cold because it
avoids some branches.  What do you all think?  Florian, do you think
glibc would be willing to add some magic to turn
clock_gettime(CLOCK_MONOTONIC, t) into
__vdso_clock_gettime_monotonic(t) when CLOCK_MONOTONIC is a constant?

--0000000000007c59390574c70f69
Content-Type: text/x-patch; charset="US-ASCII"; name="vclock_gettime_monotonic.patch"
Content-Disposition: attachment; filename="vclock_gettime_monotonic.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jlivghyt0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L3Zkc28vdmNsb2NrX2dldHRpbWUuYyBiL2FyY2gv
eDg2L2VudHJ5L3Zkc28vdmNsb2NrX2dldHRpbWUuYwppbmRleCA5MWVkMWJiMmEzYmIuLjRmMjJl
OWNiOTdhNSAxMDA2NDQKLS0tIGEvYXJjaC94ODYvZW50cnkvdmRzby92Y2xvY2tfZ2V0dGltZS5j
CisrKyBiL2FyY2gveDg2L2VudHJ5L3Zkc28vdmNsb2NrX2dldHRpbWUuYwpAQCAtMzE5LDYgKzMx
OSwxNCBAQCBub3RyYWNlIGludCBfX3Zkc29fY2xvY2tfZ2V0dGltZShjbG9ja2lkX3QgY2xvY2ss
IHN0cnVjdCB0aW1lc3BlYyAqdHMpCiBpbnQgY2xvY2tfZ2V0dGltZShjbG9ja2lkX3QsIHN0cnVj
dCB0aW1lc3BlYyAqKQogCV9fYXR0cmlidXRlX18oKHdlYWssIGFsaWFzKCJfX3Zkc29fY2xvY2tf
Z2V0dGltZSIpKSk7CiAKK25vdHJhY2UgaW50IF9fdmRzb19jbG9ja19nZXR0aW1lX21vbm90b25p
YyhzdHJ1Y3QgdGltZXNwZWMgKnRzKQoreworCWlmIChsaWtlbHkoZG9fbW9ub3RvbmljKHRzKSAh
PSBWQ0xPQ0tfTk9ORSkpCisJCXJldHVybiAwOworCisJcmV0dXJuIHZkc29fZmFsbGJhY2tfZ2V0
dGltZShDTE9DS19NT05PVE9OSUMsIHRzKTsKK30KKwogbm90cmFjZSBpbnQgX192ZHNvX2dldHRp
bWVvZmRheShzdHJ1Y3QgdGltZXZhbCAqdHYsIHN0cnVjdCB0aW1lem9uZSAqdHopCiB7CiAJaWYg
KGxpa2VseSh0diAhPSBOVUxMKSkgewpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvZW50cnkvdmRzby92
ZHNvLmxkcy5TIGIvYXJjaC94ODYvZW50cnkvdmRzby92ZHNvLmxkcy5TCmluZGV4IGQzYTJkY2U0
Y2ZhOS4uMjhlMjNjYmMwMmM5IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9lbnRyeS92ZHNvL3Zkc28u
bGRzLlMKKysrIGIvYXJjaC94ODYvZW50cnkvdmRzby92ZHNvLmxkcy5TCkBAIC0xNSw2ICsxNSwx
MSBAQAogICogVGhpcyBjb250cm9scyB3aGF0IHVzZXJsYW5kIHN5bWJvbHMgd2UgZXhwb3J0IGZy
b20gdGhlIHZEU08uCiAgKi8KIFZFUlNJT04geworCUxJTlVYXzQuMTkgeworCWdsb2JhbDoKKwkJ
X192ZHNvX2Nsb2NrX2dldHRpbWVfbW9ub3RvbmljOworCX07CisKIAlMSU5VWF8yLjYgewogCWds
b2JhbDoKIAkJY2xvY2tfZ2V0dGltZTsK
--0000000000007c59390574c70f69--
