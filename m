Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63B4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B4320817
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUD64ZHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B4320817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbeKNQqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 11:46:34 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34454 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeKNQqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 11:46:34 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so10705934lfc.1;
        Tue, 13 Nov 2018 22:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iIqzHgz958JmqxqUtpCRXXRyZrOqSOFiHL9o4ou7gXw=;
        b=IUD64ZHgyo8co4GdYkl1JzGKfcjLGjFxXFQdWAjJAmljZOzs5p2bZFmRpdMHjBYxsC
         wLVbYTfkqYrO2o5rIeyt8lk3JYLDa8q1qCuDLrp9hFLD1n9h5IxJ0zdPIeglRom3/ft/
         k6csBU2ib02jqkwxvcaTJX04lPsvTzCpbqUqW4SXxibRJb0DZxuwIkN9dzSQ7inZzn4n
         dgM2YdBWa0/VNd8D5wl0dG+sHD8/RevTvbdd3IZknb7xXT2/APBhphoFStmGRHEl3dqh
         HZEP3xu2gOOVW9KWpoi6kgjMqFWXTcYupdOXAHgiXxwWWzLBq8q5QOlL9vlXdbytH1ny
         LKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iIqzHgz958JmqxqUtpCRXXRyZrOqSOFiHL9o4ou7gXw=;
        b=q3tF/PWFgQwt8WdYycLLAQ6Zxk6pjgYDA2o8+vvLIxNWJ4Zr1VtYAKNgl3GbuU6LT5
         1cx3lXUfMg3/OY35ki+1rOt7GpkOhf+8eEQSvHGlA3N4ZwybPmrAcSF7aWq4Kcs7Wxnp
         JS6obKW8MkXSSszi3Sq1crg9x0VG/txh4jJAr3uEasz8dBDYnhbySgGO2a6ap9VFKQnI
         cdkUPCZT0jodq/RkhVm8XEmn7DsGcXTBEFCJytEm0ldXf+TAPcxwWSw7VF8nLGiDMmzZ
         Rw88kvo1w0Sxnb3lwODymP5HEytP+qDysWVA4LMKUo0j9AJxaGGa/kJaBe3LRchP4KFG
         tjlA==
X-Gm-Message-State: AGRZ1gIIAx9AKT0Jim2zdNtVxmMc36kl8jteHshBE8q+6/D74c4IAHbt
        21PWeUIpugOmZwodsARxTnQGjdeuzRRqeNVLWo6zgw==
X-Google-Smtp-Source: AJdET5crsW0f77DwdrRzkKn47yrR6FlMDrek8+/bjVvaA5HD31eIdDLwDj9GjID5zQjMnt6z1zlqNtK+o2evxjGqLGo=
X-Received: by 2002:a19:a502:: with SMTP id o2mr331755lfe.92.1542177879560;
 Tue, 13 Nov 2018 22:44:39 -0800 (PST)
MIME-Version: 1.0
References: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org>
From:   Allen <allen.lkml@gmail.com>
Date:   Wed, 14 Nov 2018 12:14:27 +0530
Message-ID: <CAOMdWSJ1NiMTThftBysvsntPdRBHN7gq_w19gtzi6KmBKAdz+Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] sparc: system call table generation support
To:     firoz.khan@linaro.org
Cc:     David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
        geert@linux-m68k.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pombredanne@nexb.com, Thomas Gleixner <tglx@linutronix.de>,
        kstewart@linuxfoundation.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Changes since v2:
>  - changed from generic-y to generated-y in Kbuild.
>  - added io_pgetevents entry in the syscall.tbl.
>  - updated the compat system call table.
>
> Changes since v1:
>  - optimized/updated the syscall table generation
>    scripts.
>  - fixed all mixed indentation issues in syscall.tbl.
>  - added "comments" in syscall.tbl.
>
> Firoz Khan (4):
>   sparc: move __IGNORE* entries to non uapi header
>   sparc: add __NR_syscalls along with NR_syscalls
>   sparc: add system call table generation support
>   sparc: generate uapi header and system call table files

Tested and looks fine.

Tested-by: Allen Pais <allen.lkml@gmail.com>

>  arch/sparc/Makefile                      |   3 +
>  arch/sparc/include/asm/Kbuild            |   4 +-
>  arch/sparc/include/asm/unistd.h          |  18 ++
>  arch/sparc/include/uapi/asm/Kbuild       |   2 +
>  arch/sparc/include/uapi/asm/unistd.h     | 426 +------------------------------
>  arch/sparc/kernel/syscalls/Makefile      |  55 ++++
>  arch/sparc/kernel/syscalls/syscall.tbl   | 409 +++++++++++++++++++++++++++++
>  arch/sparc/kernel/syscalls/syscallhdr.sh |  36 +++
>  arch/sparc/kernel/syscalls/syscalltbl.sh |  36 +++
>  arch/sparc/kernel/systbls_32.S           |  81 +-----
>  arch/sparc/kernel/systbls_64.S           | 157 +-----------
>  11 files changed, 572 insertions(+), 655 deletions(-)
>  create mode 100644 arch/sparc/kernel/syscalls/Makefile
>  create mode 100644 arch/sparc/kernel/syscalls/syscall.tbl
>  create mode 100644 arch/sparc/kernel/syscalls/syscallhdr.sh
>  create mode 100644 arch/sparc/kernel/syscalls/syscalltbl.sh
>
> --
> 1.9.1
>


-- 
       - Allen
