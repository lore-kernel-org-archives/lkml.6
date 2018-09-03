Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A36C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F2320856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evd4ongI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F2320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbeICJIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 05:08:05 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55571 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeICJIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 05:08:04 -0400
Received: by mail-it0-f67.google.com with SMTP id d10-v6so13940606itj.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 21:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=RW+baRy/dlTZq43tGI5/Z5iaXT053A2ps7XgM4gRPa8=;
        b=evd4ongIT+6dx5ApfMtzb1g3kkOItAhH38U/zUVXUptyHpOVayvlVgBpxUK7lgFEGP
         B52+hpTtlPwLha8Te+AQvDEfKPvW+M79LndTynXg2sVxB08D7+3+k5dB7PTcLw7lbf3c
         IZ7DQmTp3s8OnIIvCSDrnXbfpgWc2LR5gYK5v9jDKa8mGwqGv1Rib1bo1gv/BrlC5btL
         suy8QSqfO20wSBjGllGrragA+L5SCbT6ZVJPCCy7Jwzi2iVYsNA5GYrZYG7nKjOnQVM0
         JmTqbHFP4oe+tPv8KKFpaVfKaCG5zdfXCPRidSAPlINhDJVYqGQA2l1aUqYkxgeXEmCK
         Jvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=RW+baRy/dlTZq43tGI5/Z5iaXT053A2ps7XgM4gRPa8=;
        b=DPKSBwlqSqUAg+B4Bmka+f7LUmy/BG/yPvlSyaaYEmfQU4HxX6+sPr0fRZdYpeECBC
         UgWYBFLfsZKzg6PbNikjc7/kfNEPP0E9IBTQXt6n+rbRh2m256cBPH3LxyCXO6WfOVNd
         5TV3V1tR2x3NiHnhy4y0g3+79DWCKUBmcsOlVqZiLwiwa/s7FtFvH3VwXsep/eCRXOPj
         wQ/Ytv+8TxhELvqLaAqDFZtKvr3BvVEi0MgORqNB8hW7SrKmCTicrcgjz7wybOM+3KQZ
         7PtC6vTeBHJFBhb3/IkuqDXKLBsMbqiwkgcLA/yX1xCVsyElc+AwqwIboipS0L7z47Mh
         +xkQ==
X-Gm-Message-State: APzg51DH349DBlL2t7oBXHUTVVbEd3OGILHw+MalCJasKDefQldXGyCs
        LV+2x/vc7zSkqADHtO0TyNk+cOkGYgZ/nkNoyc0=
X-Google-Smtp-Source: ANB0VdZ6cqPEBSoo44sQ+SXvXmuD4sQMaMr68XcUbQm6I4FN6ncPT08LuTZZHvIARjwBNwY5HQv2snbEJI/lIDIA8h0=
X-Received: by 2002:a24:85c6:: with SMTP id r189-v6mr4311767itd.83.1535950178385;
 Sun, 02 Sep 2018 21:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <1535943028-60049-1-git-send-email-mine260309@gmail.com>
In-Reply-To: <1535943028-60049-1-git-send-email-mine260309@gmail.com>
From:   Lei YU <mine260309@gmail.com>
Date:   Mon, 3 Sep 2018 12:49:26 +0800
Message-ID: <CAARXrtm=tyvtnu+XgeOHFX=+rLSovqoHR-9PFCLWOzXY0+ACgw@mail.gmail.com>
Subject: Re: [PATCH v2] perf: Fix clean error
To:     Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just find out that da15fc2fa9c07b23db8f5e479bd8a9f0d741ca07 (introduced in
v4.19-rc1) already fixes the issue by specifying -j1 on make clean.
So this commit is not needed anymore, though I think it does fix the root
cause.

But if we do want parallel clean, we could revert that and merge this commi=
t.

On Mon, Sep 3, 2018 at 10:50 AM Lei YU <mine260309@gmail.com> wrote:
>
> When make perf with -O, it gets error when make clean with below log:
>
>  $ make -C tools/perf O=3D<output/dir> # OK
>  $ make -C tools/perf O=3D<output/dir> clean # Got below error
>
>     find: cannot delete =E2=80=98<output/dir>/builtin-script.o=E2=80=99: =
No such file or directory
>     find: cannot delete =E2=80=98<output/dir>/.subcmd-config.o.cmd=E2=80=
=99: No such file or directory
>     ...
>     Makefile:38: recipe for target 'clean' failed
>     make[2]: *** [clean] Error 1
>     make[1]: *** [fixdep-clean] Error 2
>     Makefile:90: recipe for target 'clean' failed
>     make: *** [clean] Error 2
>
> It happens because both fixdep-clean and libsubcmd-clean will delete
> files by `find`, where libsubcmd-clean uses `| xargs $(RM)` and
> fixdep-clean uses `-delete`.
> When a file is find by fixdep-clean, and tries to delete it, it's found
> that the file does not exist because it is deleted by libsubcmd-clean.
>
> This commit changes the delete method of fixdep-clean to use
> `| xargs $(RM)` as well, where RM is defined as `rm -f` so it does not
> return error when file does not exist.
>
> Signed-off-by: Lei YU <mine260309@gmail.com>
>
> ---
> v2: Fix missing "make clean" in commit message
> ---
>  tools/build/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/build/Makefile b/tools/build/Makefile
> index 5edf65e..ae38db2 100644
> --- a/tools/build/Makefile
> +++ b/tools/build/Makefile
> @@ -18,6 +18,7 @@ $(call allow-override,LD,$(CROSS_COMPILE)ld)
>  HOSTCC ?=3D gcc
>  HOSTLD ?=3D ld
>  HOSTAR ?=3D ar
> +RM =3D rm -f
>
>  export HOSTCC HOSTLD HOSTAR
>
> @@ -36,7 +37,7 @@ all: $(OUTPUT)fixdep
>
>  clean:
>         $(call QUIET_CLEAN, fixdep)
> -       $(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name=
 '\.*.cmd' -delete -o -name '\.*.d' -delete
> +       $(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -o -name '\.*.cm=
d' -o -name '\.*.d' | xargs $(RM)
>         $(Q)rm -f $(OUTPUT)fixdep
>
>  $(OUTPUT)fixdep-in.o: FORCE
> --
> 2.7.4
>
