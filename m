Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EC2ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4CB2089F
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bRfDWEzL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N2OcVf6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4CB2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387722AbeGOCtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 22:49:41 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:43782 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731950AbeGOCtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 22:49:41 -0400
Received: by mail-yw0-f195.google.com with SMTP id l189-v6so13096230ywb.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 19:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=3fDa4j+SDTFFlhn2uvFQ50UxzOoKMDpIS2nMAAeqbtE=;
        b=bRfDWEzLNhkL+6DVXKchRIlh2EU5wj9fGvXk+oFnkplUHaFDR7j4MPRYzpzOD35rAy
         xEqeSbdHZlAASl+WSFlI20tnBlreTMLVAweEOXO9bfdtTmbhcGEITh4OmTEApVrX0EaO
         1fOUsWUrQYVTVBm3UD6Ch2WW8WDQePe9dXYbTRtugL4YgEV6uPxHr+bxlus+kdjZ98xn
         06numCgz1HYRMppkqfmDSUYShGc9KBN+VweQOKRxeC/JMEWtWri9oU5Ss5621tWglZ0O
         3exqB1q0vS9uKGGe2vKsg7QQAsyHCBXxbx+IEH8GiBAoux5AzaWcerQiI/sbSoaPetYL
         BFuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=3fDa4j+SDTFFlhn2uvFQ50UxzOoKMDpIS2nMAAeqbtE=;
        b=N2OcVf6ANxxrOHZc1brwPCoYxbtnrWV/haWuXA4PY20dFrziIUjPZPG98oIiRLfgZv
         DyXwWA7ZYf2//zYRFgbokcNndDg8g403YDAxRKMWSKGrpNLPtS0swohJRU26riF7Ni7c
         2Fj1J7JFcndFOemblZssED5jxZW5tXmCMOxkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=3fDa4j+SDTFFlhn2uvFQ50UxzOoKMDpIS2nMAAeqbtE=;
        b=DZJ1iqm/taoUtSUcG1I+E4PZko6/Z1EuTiWEY7Hw/Voy6wjFUrnu7A1L++3bexG6fd
         Y3Gs68ngWBZKKMjsd6T0t9r7KeDh9RZwKzBvcjAb5JnWdcHRh3EFc9Rw0hmH16Map2fa
         hm1FYrnr8p5qQmkmsvd81GkU33TcHc/D5mOPw3vKWKLdcagM1+s2wuo8WGQSvBEFqtEd
         jnWoTYrZNJZzaDIp+2YvY0POa2b6fb2/nB7J0WXbCAAZJERS9oKgAhTnLx3cRjKtFcIn
         xkO7OXNKi9ieX/dVvMh9npeFX+Tl7Ia1NcfYZwWR+FK3S2LpxYX1OJLxGX9Wi1s+ag6n
         fHAQ==
X-Gm-Message-State: AOUpUlEAxvryeAIqBl8D68RnyziD+DkMqSpzb0cbj3XlJAhCOJf0NLj7
        aBtr62MqWc/y/2rw878YPx6QFp+9ppyykrs4g9EY+w==
X-Google-Smtp-Source: AAOMgper9SlNjFlJfWdq7S+t+m2R6UfZQpW+exmsepi8DQcOMwl/BoxVTl8piNzSD7PnsBvCikRu1LDAeX1vIB0V0Uw=
X-Received: by 2002:a81:2706:: with SMTP id n6-v6mr5751365ywn.88.1531621709190;
 Sat, 14 Jul 2018 19:28:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Sat, 14 Jul 2018 19:28:28
 -0700 (PDT)
In-Reply-To: <1531505163-20227-7-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com> <1531505163-20227-7-git-send-email-zohar@linux.vnet.ibm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 14 Jul 2018 19:28:28 -0700
X-Google-Sender-Auth: CA-9b3v1u3fpwvXfbJgSDcFey5E
Message-ID: <CAGXu5jL8_nbUKKNO-PCyGwOdQ+vjPZ7_17FKNH1fssgtfjk=Rw@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] ima: add build time policy
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

On Fri, Jul 13, 2018 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> IMA by default does not measure, appraise or audit files, but can be
> enabled at runtime by specifying a builtin policy on the boot command line
> or by loading a custom policy.
>
> This patch defines a build time policy, which verifies kernel modules,
> firmware, kexec image, and/or the IMA policy signatures.  This build time
> policy is automatically enabled at runtime and persists after loading a
> custom policy.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
