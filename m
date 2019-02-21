Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFEAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E5D20836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bV4Zx3hj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfBURiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:38:09 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:37566 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfBURiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:38:08 -0500
Received: by mail-vk1-f194.google.com with SMTP id 17so2891619vkf.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 09:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gytft9w1IdoIoEzrPyPSa9vNJDkOepHwFnxXQrUDXWI=;
        b=bV4Zx3hjTVxs3UQcNkN+TpgIT6Vfqla89/2H+MEnfU+lwvQvw/MQZfDXsHfzpH9EO5
         gkAFVmaF4VBHVx3jLw02J6ioWc/vdgEdgWSrc536FAXapCFB/Gn3aK9OQXmoTJOq5MzE
         GODlwj1masKNgaRJdBXgIa0JX4hmmJvDJPh3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gytft9w1IdoIoEzrPyPSa9vNJDkOepHwFnxXQrUDXWI=;
        b=i0JVpDgCrdWgKONzR/db4bP0YHyqeUcpv//XRB7sngOMJ6h1BOipZAzyCW0qnEPHPU
         xmvoqs1R1Mnl5WPLpbcPz/1I/5pQAmY17kVWE0WfYvIZmU5eaWyp8fKCVYAqbwgj4n0j
         vLCqxPS2AYNLFFYLnFuqaoom2rTJ9h7aaBKWP1vno6ekCytcVS6Q3pWBWufOpB6ZnPHY
         kybYqLwMYroeXPP5sYn+99RFXgUR+5N8Io7qiaCPYsRguYBooRwxwEi1W3Xe+AOvWluN
         GJswfC/tAjHuT58IJTJ7sMfX8erapAg3xDHAmNw0q8b2GcRg0nSRZdAmYnwoMaPJTa2j
         hYGg==
X-Gm-Message-State: AHQUAuaAznrmEyVsXMATZ2maA4eHxEE2O++XsXwNiuzJxN3qYC2cvMmA
        r5O2CIBehDHqUjYaJHuXpR63sLS1UGA=
X-Google-Smtp-Source: AHgI3IaKxmlrXAwyI7h+kJth/zAWQNGGl/Xoo2BB6Rz/0fjFLZMRlDEvOIl6LZqMmUfy+pqkwBU8jA==
X-Received: by 2002:a1f:ab03:: with SMTP id u3mr4252073vke.1.1550770687468;
        Thu, 21 Feb 2019 09:38:07 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id d134sm18999187vkf.18.2019.02.21.09.38.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 09:38:06 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id x140so7082564vke.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 09:38:06 -0800 (PST)
X-Received: by 2002:a1f:a5d3:: with SMTP id o202mr14829186vke.40.1550770685753;
 Thu, 21 Feb 2019 09:38:05 -0800 (PST)
MIME-Version: 1.0
References: <20190220180934.GA46255@beast> <20190221173307.GB7019@linux.intel.com>
In-Reply-To: <20190221173307.GB7019@linux.intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Feb 2019 09:37:52 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+rfR4T2Mo75bfp7L9RAPWQ7xchQTfW3JpDbHRMOocjbQ@mail.gmail.com>
Message-ID: <CAGXu5j+rfR4T2Mo75bfp7L9RAPWQ7xchQTfW3JpDbHRMOocjbQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/asm: Pin sensitive CR4 bits
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 9:33 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
> On Wed, Feb 20, 2019 at 10:09:34AM -0800, Kees Cook wrote:
> > +     if (WARN_ONCE((val & cr4_pin) != cr4_pin, "cr4 bypass attempt?!\n"))
>
> Printing what bits diverged would be helpful in the unlikely event that the
> WARN_ONCE triggers.  "cr4 bypass attempt" is probably only meaningful to
> people that are already familiar with the code, e.g.:
>
>         if (WARN_ONCE((val & cr4_pin) != cr4_pin,
>             "Attempt to unpin cr4 bits: %lx, cr4 bypass attack?!", ~val & cr4_pin))

Ah yeah, I like it. I'll send a v3. Thanks!

-- 
Kees Cook
