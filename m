Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E1B01C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98803208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelpath-com.20150623.gappssmtp.com header.i=@kernelpath-com.20150623.gappssmtp.com header.b="LukpWYAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98803208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelpath.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935913AbeFMVIt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:08:49 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43444 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935626AbeFMVIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:08:47 -0400
Received: by mail-oi0-f68.google.com with SMTP id t133-v6so3679683oif.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 14:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelpath-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XInWjTEXY6lSwOD2hn35BWY7vGEOirwFxc4+TXOroqU=;
        b=LukpWYAOcBU3E0PhMFDpSJABE9tXmmEDylHgrysElHAS1I9ZrTzz2tydmp/C7ZhFfe
         mqC0d9rBK+nu9JY+up6XYV0EP4SYTkH4sbGvERULtJHHIFSbmgK/42wppCQRmaJsYSsN
         xxqGGcYMoe6xXBUziwY7/qg6op5jlCdabUKsa3mdRBFc7MooEUCWJmBNtLVPXdeKWYEA
         subZ9PDPhXVJSrC+GAkDzedq01/eFk5Yw6SN00XyQKExldU6AaDeNFKxxAARxm/39mak
         UzQSeOXo7nLAdZI0Gs6OSGg51muIlC8/qor1fOyp8Yoob1MhExuiMNRnBNlZ0bWurxFy
         02PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XInWjTEXY6lSwOD2hn35BWY7vGEOirwFxc4+TXOroqU=;
        b=EqiK13lB5QO7NKl98UJ6dIKzl5wA554/7WFMcqvWiPKef74ZOdoIWyJ2jlPxWsqacg
         FLyDy/Dglv4xp4N15ihvu289Nb01/XyhtTR7qpLaiGu2MrCHPX0qy1ljaMlGSQdPiKvF
         nIA8LCKC3JE1BJRbYm37C4MlEMInEg3BXKhIUGYMmKLL/ph8o+R79pfHC9HN7VdJhbaR
         lCuoU64WbQMHXiwGQUCRvofOuhJfgJzB02S3aU54wD8HSKIFyUIECbniF8H4RuNm/R3A
         DugsXfWnFOyqHLq2zZuLk1IcjfGvCIncjKNmSAy9N0t9MVNcJDcUZL1TyPKrwAFzZ7jk
         rsYQ==
X-Gm-Message-State: APt69E0wO+4lA8qFcW74OEj/runrcOfTul74P9FX3V9GAI/D5Wdu5bYO
        UWATmaoVMIaU+qm/NJh7h/AD5oCbXBaAQOroluTi8A==
X-Google-Smtp-Source: ADUXVKKIE3MmBaIUYdw/Ix0Stqhd4BC83p+8b0flwEBhCovQpq97LDbjI19IsHiB0QlNzmEwT6Etf/CjF1kRPs83JJ8=
X-Received: by 2002:aca:cc4a:: with SMTP id c71-v6mr5737262oig.152.1528924126905;
 Wed, 13 Jun 2018 14:08:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:a:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 14:08:16 -0700 (PDT)
X-Originating-IP: [168.194.163.8]
In-Reply-To: <20180613210044.GA15146@kroah.com>
References: <20180612164816.587001852@linuxfoundation.org> <CADtBP2D4a2OdLsAgZ8sRFBhkh2jArviaYNzYrS7wqdmogyc=Mg@mail.gmail.com>
 <20180613210044.GA15146@kroah.com>
From:   Rafael David Tinoco <rafaeldtinoco@kernelpath.com>
Date:   Wed, 13 Jun 2018 18:08:16 -0300
Message-ID: <CABdQkv9uNjf7ARKBJ-sE_RVruMA5U9bTNo-EL_+7Rv8ZVJGY3w@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/24] 4.4.137-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rafael Tinoco <rafael.tinoco@linaro.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 6:00 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Jun 13, 2018 at 05:47:49PM -0300, Rafael Tinoco wrote:
>> Results from Linaro=E2=80=99s test farm.
>> Regressions detected.
>>
>> NOTE:
>>
>> 1) LTP vma03 test (cve-2011-2496) broken on v4.4-137-rc1 because of:
>>
>>      6ea1dc96a03a mmap: relax file size limit for regular files
>>      bd2f9ce5bacb mmap: introduce sane default mmap limits
>>
>>    discussion:
>>
>>      https://github.com/linux-test-project/ltp/issues/341
>>
>>    mainline commit (v4.13-rc7):
>>
>>      0cc3b0ec23ce Clarify (and fix) MAX_LFS_FILESIZE macros
>>
>>    should be backported to 4.4.138-rc2 and fixes the issue.
>
> Really?  That commit says it fixes c2a9737f45e2 ("vfs,mm: fix a dead
> loop in truncate_inode_pages_range()") which is not in 4.4.y at all.
>
> Did you test this out?

Yes, the LTP contains the tests (last comment is the final test for
arm32, right before Jan tests i686).

Fixing MAX_LFS_FILESIZE fixes the new limit for mmap() brought by
those 2 commits (file_mmap_size_max()).
offset tested by the LTP test is 0xfffffffe000.
file_mmap_size_max gives: 0xFFFFFFFF000 as max value, but only after
the mentioned patch.

Original intent for this fix was other though.

> thanks,
>
> greg k-h
