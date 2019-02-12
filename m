Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF69C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0583218D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpA7h6ZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfBLKUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:20:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46386 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfBLKUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:20:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id o6so1066400pls.13;
        Tue, 12 Feb 2019 02:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8TrihA3fFD8SCmljFjZseCPcdqTX+6RNR1hDHLAg3NY=;
        b=qpA7h6ZHttjfIpQvFPZamuiG9XOhBVti1a92RN/yB86W/ezq9B38odaoh2oDFTGQw9
         aMO41RQw0iNBg3GlXw0zgaN71IRdatuhzdu+mruqXCZPiBPu6LRONIRkfhAnk8olGyVr
         SbES7Pt0HAvnGNG6a6A3ejgLekpuTLuPh7TWdDEZ/l1/r0LxoNaronVObKIEbe2iw8aR
         Df9/d5qVPxIIv8czJGHhnLY4LFVRIBK5wRelYuh06VMwVNVco+JG6kTbjtAUwsEseacX
         KwULeF+1aaO+A+uOGFnjyYOVQztbnt/P//C1FtYi0LM6yAvwkp5CiHZEX9LSutiZ66+r
         dvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8TrihA3fFD8SCmljFjZseCPcdqTX+6RNR1hDHLAg3NY=;
        b=gnDh5xcDc/ofhK3CrAwvOZrYxiFKESndUTwPcKZ4jtc6AUhRA6XVLlhCZECyT+7qcl
         JVJr3Olqp7+oDz04uI08zG8DDBDKo+vRzElmNyajNAQseUmq1A+YXD/i1eNU1zSljLCk
         Nbbs2caMjOLPN01DmjuN/M8jEmnLEMWRyXVVRWGtooqBB7F3j8GnpLOlMRgI5oLdAve4
         IDtN6f+WD4ChUlvWK58hDYraZl3dLy8h1tDYQtWOI+ZNmebj3G7lrkGbgidqhGSoS97E
         q9s36y0vYxK9NRntExxzBY7+UaxGttLBJMGqaK8x0jKzlpZym4zj32G6wnOcAUPJxw2L
         SIBA==
X-Gm-Message-State: AHQUAuafQv7p7TYRVrUAtBVotEcinQgMfCai+DKPOZhwdHmGTE1qZltg
        8HbDJ2Hhd923LutOtDetKFo3buBMT/66sMVAVrE=
X-Google-Smtp-Source: AHgI3IbuJ6ALZBaqyBr+f7J7q++3mVxBf8qSWBa9xtDFGI4KJTQidt3EcmCMs6oprH+Gy87762Z9smcT6mg43JEhFQM=
X-Received: by 2002:a17:902:bc88:: with SMTP id bb8mr3323071plb.12.1549966804153;
 Tue, 12 Feb 2019 02:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20190212100825.9113-1-anders.roxell@linaro.org>
 <20190212100825.9113-2-anders.roxell@linaro.org> <CAKv+Gu_y++P259Bi92kJr0XHxw8Tvpag74vvFiPQf34DmJq3uw@mail.gmail.com>
In-Reply-To: <CAKv+Gu_y++P259Bi92kJr0XHxw8Tvpag74vvFiPQf34DmJq3uw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Feb 2019 12:19:53 +0200
Message-ID: <CAHp75Vd161xYcOgESiA2Ex5gzM39_CSSH11HsVzOyyA+g0rYTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi: fix build error redeclaration of enumerator
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 12:16 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On Tue, 12 Feb 2019 at 11:09, Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > Commit a893ea15d764 ("tpm: move tpm_chip definition to
> > include/linux/tpm.h") introduced a build error when both ima and efi is
> > enabled. What happens is that both headers (ima.h and efi.h) defines the
> > same 'NONE' constant, and it broke when they started getting included
> > from the same file.

> I'd argue that we should apply both patches. 'NONE' is far too
> generic, so it requires a subsystem prefix if it has a special meaning
> inside a subsystem.

I was about to say the same thing.

-- 
With Best Regards,
Andy Shevchenko
