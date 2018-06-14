Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 19478C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12DC208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hX0aFH8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12DC208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935893AbeFNBte (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 21:49:34 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38732 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935796AbeFNBtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 21:49:32 -0400
Received: by mail-wr0-f195.google.com with SMTP id e18-v6so4643702wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 18:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v8hCz8jlIfMPGHzVYHSwjQTQx8qic5cDl0iMeW9Jhvw=;
        b=hX0aFH8+zunofQSa4qsjuabOpcRFyL6xiO05ZT3xOOwG43qAd/LhZjoXQF5GazgJvE
         1LDxVUHF/MVJ5hqgNAE/qlhp95zzXMYwTrKlp3uLTbcyK5uSvnTa3Ol9hptARj9GqvuM
         q1sBAy3t9tyHALvi4GiR9/SGXG7vQmY9CoaHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v8hCz8jlIfMPGHzVYHSwjQTQx8qic5cDl0iMeW9Jhvw=;
        b=FkKPlW21bMBwRE1H4hB+yjfYmkYJlBd/gXPCVpjGahvy0MVPG7IygSot+SfFsJHhRX
         dORu8cUtuyEo4HOxDhklswb70pjq5KvhjLRI5PyJ/dutfIc72rDPV8dW9VsG6I4q7UcT
         qmmOwVt4h1TaS3ir5n/7kJoQYyqEgQIWZEzjxinK/x6XxQb+oZBZvEJzf8ch94T/Vm8Y
         CCnYfiAPp5YmlDma4YSEuMYPuPL1eDmx6mgYYdz8rSDKGEu12z2kiP2tE1+FfUl56Aqc
         XwvszWgSPYLoKlS1I4EUcwyL3VEfZlLRues1e7J91mwtGtpuGYtlGdjgN22RS7b81Pk5
         Y3uw==
X-Gm-Message-State: APt69E3UuP70irBAWslEx6Tq0ARTIIAbp7UNPIuYUV5LQ8antEtQMlWT
        HzKmb1UouV76bx4rjTyn12DYtJH0ShQn+5KeYS9+dQ==
X-Google-Smtp-Source: ADUXVKITfFU3wHNzone6jc+o142TRE8caiSV+XS8Tbe6+BFCAusVEDsOFzGlkvsl9PtXkS+QiXe3gFV3d2wJqcwKJpg=
X-Received: by 2002:adf:b782:: with SMTP id s2-v6mr321049wre.247.1528940971477;
 Wed, 13 Jun 2018 18:49:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c389:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 18:48:50
 -0700 (PDT)
In-Reply-To: <CABdQkv9uNjf7ARKBJ-sE_RVruMA5U9bTNo-EL_+7Rv8ZVJGY3w@mail.gmail.com>
References: <20180612164816.587001852@linuxfoundation.org> <CADtBP2D4a2OdLsAgZ8sRFBhkh2jArviaYNzYrS7wqdmogyc=Mg@mail.gmail.com>
 <20180613210044.GA15146@kroah.com> <CABdQkv9uNjf7ARKBJ-sE_RVruMA5U9bTNo-EL_+7Rv8ZVJGY3w@mail.gmail.com>
From:   Rafael Tinoco <rafael.tinoco@linaro.org>
Date:   Wed, 13 Jun 2018 22:48:50 -0300
Message-ID: <CADtBP2DZ0ceTtwaG7AdXV3xa16mQ6nu=gaqUYj7JSOLBdVD8cg@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/24] 4.4.137-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net, ltp@lists.linux.it,
        Rafael Tinoco <rafael.tinoco@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 June 2018 at 18:08, Rafael David Tinoco
<rafaeldtinoco@kernelpath.com> wrote:
> On Wed, Jun 13, 2018 at 6:00 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Wed, Jun 13, 2018 at 05:47:49PM -0300, Rafael Tinoco wrote:
>>> Results from Linaro=E2=80=99s test farm.
>>> Regressions detected.
>>>
>>> NOTE:
>>>
>>> 1) LTP vma03 test (cve-2011-2496) broken on v4.4-137-rc1 because of:
>>>
>>>      6ea1dc96a03a mmap: relax file size limit for regular files
>>>      bd2f9ce5bacb mmap: introduce sane default mmap limits
>>>
>>>    discussion:
>>>
>>>      https://github.com/linux-test-project/ltp/issues/341
>>>
>>>    mainline commit (v4.13-rc7):
>>>
>>>      0cc3b0ec23ce Clarify (and fix) MAX_LFS_FILESIZE macros
>>>
>>>    should be backported to 4.4.138-rc2 and fixes the issue.
>>
>> Really?  That commit says it fixes c2a9737f45e2 ("vfs,mm: fix a dead
>> loop in truncate_inode_pages_range()") which is not in 4.4.y at all.
>>
>> Did you test this out?
>
> Yes, the LTP contains the tests (last comment is the final test for
> arm32, right before Jan tests i686).
>
> Fixing MAX_LFS_FILESIZE fixes the new limit for mmap() brought by
> those 2 commits (file_mmap_size_max()).
> offset tested by the LTP test is 0xfffffffe000.
> file_mmap_size_max gives: 0xFFFFFFFF000 as max value, but only after
> the mentioned patch.
>
> Original intent for this fix was other though.

To clarify this a bit further.

The LTP CVE test is breaking in the first call to mmap(), even before
trying to remap and test the security issue. That start happening in
this round because of those mmap() changes and the offset used in the
LTP test. Linus changed limit checks and made them to be related to
MAX_LFS_FILESIZE. Unfortunately, in 4.4 stable, we were missing the
fix for MAX_LFS_FILESIZE (which before commit 0cc3b0ec23ce was less
than the REAL 32 bit limit).

Commit 0cc3b0ec23ce was made because an user noticed the FS limit not
being what it should be. In our case, the 4.4 stable kernel, we are
facing this 32 bit lower limit (than the real 32 bit real limit),
because of the LTP CVE test, so we need this fix to have the real 32
bit limit set for that macro (mmap limits did not use that macro
before).

I have tested in arm32 and Jan Stancek, who first responded to LTP
issue, has tested this in i686 and both worked after that patch was
included to v4.4-137-rc1 (my last test was even with 4.4.138-rc1).

Hope that helps a bit.
