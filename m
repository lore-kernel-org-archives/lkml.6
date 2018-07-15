Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FABECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888D3208A5
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ALJzaEHY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iEdUTZj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888D3208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbeGOCfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 22:35:34 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35628 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731978AbeGOCfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 22:35:34 -0400
Received: by mail-yw0-f196.google.com with SMTP id t18-v6so13107802ywg.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 19:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lf7EjxEathMQDSEh30vNcuL6Ar5Z2/NAVW3HpMOerOE=;
        b=ALJzaEHYGw9eimvzN4vuphWMbbvzVyAlS0QCBm4MqIX31GlmGfeRTNLugVmzANuLSE
         5Lh5PdLG44rp4wWFQY8AB+YC27kuojrTvXNSR/0ucdN0mi3lHnC+tcFKw6W6SDiF2VbF
         BcE5NxKfW54dyrTvTGPeq3nnKz7TAy+jjvJkI7+2BrbcYJYJHG2HWzIPuwM7HnMu5I7h
         IhjEJpQWyUj+ZiHuEK11+OUg33IWNVH3Lqu0CnDK2FHLpVNvUhTpg1n27rHwgRmw+P48
         VELXEVV9CUbhx3W11qYNWr+W4Ds5/WzH+Sw5SD0yuCtCjHKsz7DQC8URtsV8t9/kM9jh
         vMWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lf7EjxEathMQDSEh30vNcuL6Ar5Z2/NAVW3HpMOerOE=;
        b=iEdUTZj9w7g61fbkcry9B/7uJDbOW+wcBQsANyUhrbO1DOFs24n0aQd9NCNf4QcPI6
         v1Ey/6zfpAoYZWgJf4oDFNWrPHMcbInE88fdbj2O0WRoYQMz8a49Ml4pdrRSNi2Nk+aE
         ejwT0HN6tWTvVZskOo/GuKZD1CrSQ87IzEK5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=lf7EjxEathMQDSEh30vNcuL6Ar5Z2/NAVW3HpMOerOE=;
        b=Yqolv3N3HbhqnB5eHK1borNOli5fRLGtk6/1pAccmJN5ZAYf/MC2E7xHJJlgZbEfeF
         AzMgaLC15RsRU+LeVR8IH5nH83k89Tq/d0DEnI6LcR/oa+9NDs5XJPhq/SrOWLRLmkGA
         NnLo6MAZzuwKnzq807VZeQX9LrfcJIWMCtwcroTiQi5NMUXxzlxzH2Kjj0ae6LnRPttc
         y68TyrDrM2IFmTAb4N6M9kNaenylUGU3PHgy2xEFWKmJyiWxPhFCwTymJebRqbTqycZL
         vTUvCAexL7Ub/bP8EbNadTREx8yAYodSTtVfzGX+scb4Gj9iJTygQuI+OXwEPHUO1Q48
         Pzug==
X-Gm-Message-State: AOUpUlEOhrzRyeD3gNccoLFcxxpGrWizirPc04zeOjE2bc8V7n2ghaBx
        o02gzvtSN8qeV08s3SiLimVrrUeGmRLJMHuDdpa7FA==
X-Google-Smtp-Source: AAOMgpebYsaA8Ealqz9haRsCRl0spqGkBO+iQamP+nvDI3HLXW/4P8mapXtURbTi72cbL98wsYRH9mZxK8dXkAYQXgQ=
X-Received: by 2002:a0d:d287:: with SMTP id u129-v6mr5934419ywd.95.1531620864884;
 Sat, 14 Jul 2018 19:14:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Sat, 14 Jul 2018 19:14:24
 -0700 (PDT)
In-Reply-To: <1531505163-20227-3-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com> <1531505163-20227-3-git-send-email-zohar@linux.vnet.ibm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 14 Jul 2018 19:14:24 -0700
X-Google-Sender-Auth: 6iMaYXYn0t83wT0y65eTVTpQa4o
Message-ID: <CAGXu5j+bRE7-Jq4Q+jcVOyZ3e1hy6kbpF5ctdmdQxuV+ri82hQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] kexec: add call to LSM hook in original kexec_load syscall
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 11:05 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> In order for LSMs and IMA-appraisal to differentiate between kexec_load
> and kexec_file_load syscalls, both the original and new syscalls must
> call an LSM hook.  This patch adds a call to security_kernel_load_data()
> in the original kexec_load syscall.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Kees Cook <keescook@chromium.org>
> Acked-by: Serge Hallyn <serge@hallyn.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
