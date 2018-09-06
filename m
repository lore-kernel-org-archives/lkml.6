Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A495EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512C020857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A6ovPMPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512C020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbeIFSta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:49:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45510 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbeIFSta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:49:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id u83-v6so9423734lje.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 07:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=BuMxjxZ+2MvmTLTZqSQIbnuGHXcgd8YbQtM3hlMRd4s=;
        b=A6ovPMPPdt0ecYJKpqTXVF9igCaWarjk+W36Hne7yYTavkVdiogx5O+RTxm2O/8kbc
         K/GlClVKpb13ahb94qGOvRoXrIc6NPyoF8wQe9Gpq7UGe1oF2Z/EYZYCsJ/9H80BwavZ
         Ras2Cn4ts1ppDdkzjq8eHBS71fr8zDm5/5WaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=BuMxjxZ+2MvmTLTZqSQIbnuGHXcgd8YbQtM3hlMRd4s=;
        b=bDk38eeDMTKAZ5+vb01MGDlnluzckR7XmLx+UjDKn31jku+Dncvz6+wETTLarI4Ki7
         bnoa0YgM1Dm2MW3f0P+IoHWRvOQ19GZdYA+eUntNsXxpmTOXi3uffQwUbFIb8Zn5dKI6
         OF9TjalAEzCLWrn3HjkCyLo2VsmgFCjOza7Ph3KkDl5yXJu2w1U7XolloWj5+ec/7M33
         1WKy3bK8zJ60y9m66a+l/QQ6Jy9MUzzenoK6lRKQZZdoVKxqVyMtwl5Y7KH4RnhdWlL/
         Jb/nUmSPJ/jhcEl6U6sclSBk5PqAn3GDkCGAWTXZynxtmlRHgE/2BOmycKWUDviA3JZ/
         aGSQ==
X-Gm-Message-State: APzg51ArxURq8SUmhxAPigReU2WymZDpaVxjnvxbiZ5y4gFCEzOtjqdB
        Bs82PNnIKx3V6Oi2pNq5Ktwk2rcrVrXzyZrNOEpuhQ==
X-Google-Smtp-Source: ANB0VdahyMxnmBj0lYLyiutT3PuIwLe7VAF1UN4nRRiGlJLJd/14jYlswhJOVq3uyaF2uPdfA2kVCcuIDvfOU3dVBjk=
X-Received: by 2002:a2e:934d:: with SMTP id m13-v6mr2058162ljh.45.1536243223976;
 Thu, 06 Sep 2018 07:13:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:8fd3:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 07:13:23 -0700 (PDT)
In-Reply-To: <20180906140413.GA5098@thunk.org>
References: <2e8e31f5-4db5-4907-2d09-f6444bc78ede@roeck-us.net> <20180906140413.GA5098@thunk.org>
From:   Matt Hart <matthew.hart@linaro.org>
Date:   Thu, 6 Sep 2018 15:13:23 +0100
Message-ID: <CAH+k93Fgk2yZ3OzBOL2uxSVuOqEJB5wS1Zfny8bDkbuQ3sM6Jw@mail.gmail.com>
Subject: Re: Widespread crashes in next-20180906
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        David Howells <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 September 2018 at 15:04, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Thu, Sep 06, 2018 at 06:45:15AM -0700, Guenter Roeck wrote:
>> Build results:
>>       total: 134 pass: 133 fail: 1

Do you build arm64? Because KernelCI is seeing build failures in arm64
defconfig for next-20180906
Clearly it's a module build problem for sunxi but I'm not sure who to
CC about this.

https://kernelci.org/build/next/branch/master/kernel/next-20180906/
https://storage.kernelci.org/next/master/next-20180906/arm64/defconfig/build.log

ERROR: "sun8i_tcon_top_de_config"
[drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
ERROR: "sun8i_tcon_top_set_hdmi_src"
[drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-tcon.ko]
undefined!
../scripts/Makefile.modpost:92: recipe for target '__modpost' failed
make[2]: *** [__modpost] Error 1
make[2]: Target '_modpost' not remade because of errors.
/home/buildslave/workspace/kernel-build/linux/Makefile:1223: recipe
for target 'modules' failed
make[1]: *** [modules] Error 2
make[1]: Target '_all' not remade because of errors.
Makefile:146: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2
make: Target '_all' not remade because of errors.

>> Failed builds:
>>       sparc32:allmodconfig
>> Qemu test results:
>>       total: 311 pass: 76 fail: 235
>> Failed builds:
>>       <pretty much everything trying to boot from disk>
>>
>> Error message is always something like
>>
>> Filesystem requires source device
>> VFS: Cannot open root device "hda" or unknown-block(3,0): error -2
>>
>> The only variance is the boot device. Logs in full glory are available
>> at https://kerneltests.org/builders/, in the "next" column.
>>
>> I did not run bisect, but the recent filesystem changes are a definite suspect.
>
> Yes, this is the vm_fault_t changes.  See the other thread on LKML.
> The guilty commit was: 83c0adddcc6e: fs: convert return type int to
> vm_fault_t
>
> This is the *second* time vm_fault_t patches have broken things.  The
> first time it went through the ext4 tree, and I NACK'ed it after
> running a 60 second smoke test showed it was broken.  The seocnd time
> the problem was supposedly fixed, but it went through the mm tree, and
> so I didn't have a chance regression test or stop it...
>
>                                                      - Ted
