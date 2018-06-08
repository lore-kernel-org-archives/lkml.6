Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id DQWICFalGls8BAAAmS7hNA
	; Fri, 08 Jun 2018 15:48:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0ECAA607DC; Fri,  8 Jun 2018 15:48:46 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CPfJZhZt"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4D154601B4;
	Fri,  8 Jun 2018 15:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D154601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752875AbeFHPsn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 11:48:43 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34926 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbeFHPsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 11:48:41 -0400
Received: by mail-io0-f193.google.com with SMTP id u4-v6so16436366iof.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 08:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7drFcm9K/BHSXCWnDt7eGQk+JPcSmws5dfGLtoxmQls=;
        b=CPfJZhZtHVaZcT4EI+itC7SZ0rYE3NHyD4G9niyp4sJn9RkJSPnntjgP/56CNIXh0J
         zrHe4Fe5x2WDHU15GxG7cshgCbMfuKqfl6nvTtlV5q2zCVKo2wDwkII8wmnoYnTDguuW
         qr3iPgO4z/mUlusowg1h12HreCjLicLbt8ykw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7drFcm9K/BHSXCWnDt7eGQk+JPcSmws5dfGLtoxmQls=;
        b=IxUz2bkdS8zwfSTVcOeAML0WZ6EcYVf7EX7npRB2EXEcZ1aqpjz71nrgrVqCV7CmD5
         9cUlFHQMH6/QUYY0RY2XT6XycYFmJqFCUUsDyPVNTf0F4NcnCvCTZ+YHNpfKQpmQbwqk
         gPFEctbp4C2mIrJgIzuu4kEf7IUgBxq44DHkOLEZwlvQFC6rFvpws/a1Mu4QjlgFTQX2
         A59mzyQH+b5HwFfsCfkalo6UmCPkBIcat+Le2+ZSOm8grTbCbCuPc3txi5Bj8ZiaV+hU
         OaYffX79tNVdHu42uQhEM4kzN8xNRvwtPLMI90obBJ/0z7mVw9Z5XMpDUCYYymR6EbHQ
         AqUw==
X-Gm-Message-State: APt69E3uZ5wJkYKsrhTVwPUB7h+BpC5wwwCuW7APGZlgyd+9APZ+cUlQ
        +aPlvsO1krEnb9LjgMiVLSrtd10lN1Z7UFVL9fs=
X-Google-Smtp-Source: ADUXVKIah4x4Jxa8OiYj/b7WF5w/OerIxVsFu5qJoSEZTEY5DIVFvfHfdl8Q4ziaxkCRXZBuAT8oA9HsF2eJLsefasQ=
X-Received: by 2002:a6b:f90b:: with SMTP id j11-v6mr4837638iog.238.1528472920970;
 Fri, 08 Jun 2018 08:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <5b1a9cac.E0zqScbTCJ5WgP6x%lkp@intel.com>
In-Reply-To: <5b1a9cac.E0zqScbTCJ5WgP6x%lkp@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 8 Jun 2018 08:48:29 -0700
Message-ID: <CA+55aFwHCJ-ra6GOz3bFXx21D1bOjN4L11Dybr5t2OHCAYCL5Q@mail.gmail.com>
Subject: Re: [linus:master] BUILD REGRESSION 68abbe729567cef128b2c2141f2ed2567f3b8372
To: kbuild test robot <lkp@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 8:12 AM kbuild test robot <lkp@intel.com> wrote:
>
> arch/sh/include/asm/io.h:246:32: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> arch/x86/net/bpf_jit_comp32.c:2449 do_jit() warn: potential off by one 'addrs[]' limit 'bpf_prog->len'
> drivers/acpi/battery.c:720:3-9: preceding lock on line 701
> drivers/gpu/drm/amd/amdkfd/Kconfig:8: unknown option "imply"
> drivers/gpu/drm/amd/amdkfd/Kconfig:9: syntax error
> .. lots of these ..

Hmm? Is the kbuild robot not feeling well? This looks odd.

                    Linus
