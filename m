Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C544FC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFC32089F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgL7OiG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFC32089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbeKHUfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:35:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33834 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeKHUfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:35:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so20777665wre.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 03:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=21/4/ggPooJBoqx7f1/Am/XwczAjY6XK2zNZPq4Anro=;
        b=lgL7OiG5Ld7TUh0UPGUKHZOK58+wEx9L6W6a+phNrf87V0s7xUJlW8SWFuH8ik14Su
         dUzzI01I4M+K2Hfv3w9oxcJoFo+1bfvOCoCZ+Gd0rzE2Bq2sQ9kYN0BUQLMc1UdbfjJ3
         p2S3uDz1/PNKrKMvt2McXLjDU5zA70hSaSmpcdvubC9Mh4tRUy3PW7B4GSEGZItjNMeX
         H8Mpu4wqo/SNzlW4SFQc+vQG3/ClRgP1SjQuodQYqy9/CsG0RAZZbb9W1N+nh8kyRCqe
         5JEfDfyKPyg+kXUQYJG3KnzYb4seWzikFXhOBmO4Hc1ZHg2dgVXSLloeqSv34P3mZhXT
         +NZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=21/4/ggPooJBoqx7f1/Am/XwczAjY6XK2zNZPq4Anro=;
        b=kOF2VMc1+0AXfa26RN7hvB8afh7jcSGAD1CDYxurFZZ3BkTbpFWZ+OtVo3Do8zjO0S
         FPpSyu68lmiMQSVWZaKwg3Rm6v3/ERQJu1BWBhszu4zFOmum2Yg8emskqQKWlvu9sfRt
         LS5FcT2Gan3Hm2iXB0DveF0I0Bp0N1NtCjmYaCjQX8amarhSKJjjlPKl8AQzSZ7GRutq
         RlgOOygxNTaIx/FxyYubwQMXJFJnpfFPxpGOMG0p0UFOFnjxX/14KOHQ+4HMmkFl3Xgf
         1DR1Cwn2RrVWxfwVMvMD9iCCPh9p7jrkIlVWDjWvki+a1NJAKA30pZFRlzKaUPCvTDOU
         kKLg==
X-Gm-Message-State: AGRZ1gLXXWKCKEhtamsvEtegMs5dKC0O84H6Lz9ItCz3ybbrf9iF85o/
        jAWvyzk035q3aCIJOnAqAJkbbKTL
X-Google-Smtp-Source: AJdET5dVBxpR8dUuMXqxabGVVnn+4YnPY0JmY6hsTAgol0/6JATbwN5vHLsgVi3vEcjl5zt9cnXwwQ==
X-Received: by 2002:a5d:4b8b:: with SMTP id b11-v6mr3878878wrt.72.1541674813879;
        Thu, 08 Nov 2018 03:00:13 -0800 (PST)
Received: from gmail.com (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id c18-v6sm2011369wrr.74.2018.11.08.03.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 03:00:13 -0800 (PST)
Date:   Thu, 8 Nov 2018 12:00:04 +0100
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "ndesaulniers@google.com" <ndesaulniers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Compiler Attributes for v4.20-rc2
Message-ID: <20181108110004.GA14625@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A small patch for compiler-gcc.h and a trivial one for compiler_attributes.h.

The non-trivial one was in yesterday's linux-next without apparent problems.

Cheers,
Miguel

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v4.20-rc2

for you to fetch changes up to 24efee412c75843755da0ddd7bbc2db2ce9129f5:

  Compiler Attributes: improve explanation of header (2018-11-08 11:33:52 +0100)

----------------------------------------------------------------
Small improvements to Compiler Attributes:

  - Define asm_volatile_goto for non-gcc compilers
    From Nick Desaulniers

  - Improve the explanation of compiler_attributes.h

----------------------------------------------------------------
Miguel Ojeda (1):
      Compiler Attributes: improve explanation of header

ndesaulniers@google.com (1):
      include/linux/compiler*.h: define asm_volatile_goto

 include/linux/compiler_attributes.h | 14 +++++++++-----
 include/linux/compiler_types.h      |  4 ++++
 2 files changed, 13 insertions(+), 5 deletions(-)
