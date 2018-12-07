Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E313C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C486C20850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="giRLzh+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C486C20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbeLGJKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:10:40 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43703 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeLGJKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:10:40 -0500
Received: by mail-lj1-f193.google.com with SMTP id 83-v6so2889715ljf.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 01:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+DxaORDqREPrIrufQKDgo4sQK5jkAJjTwVWk+yg6px8=;
        b=giRLzh+N5VWYVr52a+/8qmD7q/nMeSkXxPHKJj0WXPwP6c0ak9am9RaAC1brLdcFAh
         zU3d9S2lLoEEvdxKpUoy9AIy+h6YHuynEGMAS6xij8mUKnKEi2SdYB+dpc8thImjSIku
         3ZS/E+9lY0xqljs814Hd1S3tTFSgZ6ZLivIvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+DxaORDqREPrIrufQKDgo4sQK5jkAJjTwVWk+yg6px8=;
        b=Smc/lLmxfc+OirbamALDZX5PmCbgDAS+NfjP/tXByOMbfT4LU+/FnmsAvTuV1laJ1c
         KrWdTcsOlqzsCDt6K2idw1oD4+klUjlaHSDdNQ3rV8UTt+leYNfuRLre1P8gyeBBDCbq
         IjMtztqUVL9tfv5gB4AnFXBUuz+vtv98gDDLd4eXEJjv5VykM3KTKPgbthGDIoThJR9L
         DmJwwKTDyAFQDCooFDQsvWOqKkiB6c7HaYkyG+eEJHYDMlT95eUudaN3a8pir9bsjqJ6
         MfVfv3kl4A+cqK6SQIfA8rLJrdVfpNSbQdlPpyVas0gHMKWqQ/gDOZZ2EcjvM8d4c1b8
         cRYg==
X-Gm-Message-State: AA+aEWZXfNLlW8uJ/gpb9B6mI6Sl/bqNnA9h10+X4x/ukEauGvqYDG81
        AJxM/E70mRkdxoaNcovuCQ0+kyZTVnRhU3x5UiNFQQ==
X-Google-Smtp-Source: AFSGD/XxnC4kXr0YpxUSk/hJVRNt7P4anqULl8R4SSpR/nK/vQEk+cInFHHNWOZqnPQc4FU4B83MLteZLouB6yhCohQ=
X-Received: by 2002:a2e:92ca:: with SMTP id k10-v6mr831688ljh.63.1544173838196;
 Fri, 07 Dec 2018 01:10:38 -0800 (PST)
MIME-Version: 1.0
References: <20181206143011.174892052@linuxfoundation.org>
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 7 Dec 2018 14:40:26 +0530
Message-ID: <CA+G9fYtzxd9a=OVr=Uwcouqikpe2EB_WJyuBhO7BX96mYWJ1NQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/101] 4.9.144-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mike.kravetz@oracle.com
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Eric Munson <emunson@mgebm.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 at 20:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.144 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Dec  8 14:29:43 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.144-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> Mike Kravetz <mike.kravetz@oracle.com>
>     hugetlbfs: check for pgoff value overflow
>
> Mike Kravetz <mike.kravetz@oracle.com>
>     hugetlbfs: fix offset overflow in hugetlbfs mmap
>
> Mike Kravetz <mike.kravetz@oracle.com>
>     mm/hugetlb.c: don't call region_abort if region_chg fails

Results from Linaro=E2=80=99s test farm.
Regressions detected on arm32 and i386.

truncate_above_4GB (2M: 32): FAIL mmap() offset 4GB: Invalid argument

test case link:
https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/truncate_abo=
ve_4GB.c

Full test log links,
https://lkft.validation.linaro.org/scheduler/job/537897#L1373

Summary
------------------------------------------------------------------------

kernel: 4.9.144-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: cf137e4b43737b5c238350d3e22f031c616dd9f9
git describe: v4.9.143-102-gcf137e4b4373
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.143-102-gcf137e4b4373

Regressions (compared to build v4.9.143)
------------------------------------------------------------------------

qemu_arm:
  libhugetlbfs:
    * truncate_above_4GB-2M-32

qemu_i386:
  libhugetlbfs:
    * truncate_above_4GB-4M-32

x15 - arm:
  libhugetlbfs:
    * truncate_above_4GB-2M-32

Test description:
----------------------
https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/truncate_abo=
ve_4GB.c

/*
* Test rationale:
*
* At one stage, a misconversion of hugetlb_vmtruncate_list to a
* prio_tree meant that on 32-bit machines, truncates at or above 4GB
* could truncate lower pages, resulting in BUG_ON()s.
*
* WARNING: The offsets and addresses used within are specifically
* calculated to trigger the bug as it existed. Don't mess with them
* unless you *really* know what you're doing.
*
* The kernel bug in question was fixed with commit
* 856fc29505556cf263f3dcda2533cf3766c14ab6.
*/

--=20
Linaro LKFT
https://lkft.linaro.org
