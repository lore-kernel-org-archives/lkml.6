Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A2296C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAE1208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QsmtF/nb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAE1208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754609AbeFNIyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:54:31 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41199 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbeFNIy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:54:28 -0400
Received: by mail-lf0-f67.google.com with SMTP id d24-v6so8173495lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LPRnoUPEW/a4jnkOUBLsUbYcREeZ1Qh3ZcYi9Av43G8=;
        b=QsmtF/nbuNSLrSwv841PpqQGZ7YEcMObyfhBvS0rI/H5OyX64ZoorENBgb3wq4yy5F
         YjaVHSv8y7Y7zvAlH9SpMm6TF5PRqDBIMh1P2kJm6TGY4BYNNpjW1M3yTev4crRJ6WzA
         pyhvY5d/+1N+LbAIdvkbMSh+dAWqRMN17jU8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LPRnoUPEW/a4jnkOUBLsUbYcREeZ1Qh3ZcYi9Av43G8=;
        b=XpNuZBJ4W4iViC8AEMOGnLp9c+KpvmPl6k5AQOk29zR9YVVBtDcXYEaXSqKdvJ2jmy
         sHNfIiZHEDumJApYOd5/tKxgXvTt838uky19mjK2YHJgsQ/GKuOaynSXXvhvdXl04ZzR
         +0TMYdttzxLlo/d8ucxF2OJLiKimc4XRj3pXEoF7d7avj3FSuri0bUKMqm3R9qL3/FsF
         PJgfNqMO9P9r+MhjmWtQvIjLS9+/xOaqNr+OTCkkc+qYy31Gx0WvSGDhgyYb2asvYUw5
         aLOlmT7IZ+YyIb32xQGo0adCUCqKYUxeJBCpwVqZK2ohPgXEWUC+ppOTpmXIp3L/cbOj
         rrng==
X-Gm-Message-State: APt69E0GJ0IdWx5pE26503L38MBJsZFop9KUZPsOTGklMvTCV9NnBTiU
        k7FUIWIGgB4i+9PzRcjUWRdBcJhMao+CGoKOxdDNJw==
X-Google-Smtp-Source: ADUXVKLknfKM8YLl4yaR7o5G4FlmQ+Oq9KN7s6fEJZKgiMyTgHgj4Ta/IGDYDAXPtkHvROP1ntDBSntSX/MQR85DrfA=
X-Received: by 2002:a19:e910:: with SMTP id g16-v6mr5177706lfh.44.1528966466934;
 Thu, 14 Jun 2018 01:54:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ee14:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 01:54:25
 -0700 (PDT)
In-Reply-To: <20180614063448.GB6021@kroah.com>
References: <20180612164816.587001852@linuxfoundation.org> <CADtBP2D4a2OdLsAgZ8sRFBhkh2jArviaYNzYrS7wqdmogyc=Mg@mail.gmail.com>
 <20180613210044.GA15146@kroah.com> <CABdQkv9uNjf7ARKBJ-sE_RVruMA5U9bTNo-EL_+7Rv8ZVJGY3w@mail.gmail.com>
 <CADtBP2DZ0ceTtwaG7AdXV3xa16mQ6nu=gaqUYj7JSOLBdVD8cg@mail.gmail.com> <20180614063448.GB6021@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 14 Jun 2018 14:24:25 +0530
Message-ID: <CA+G9fYut-A0L9iWJbzbSfmc=gjmQ17iabcPfXxqDKocwpYYTOQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/24] 4.4.137-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rafael Tinoco <rafael.tinoco@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 June 2018 at 12:04, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> On Wed, Jun 13, 2018 at 10:48:50PM -0300, Rafael Tinoco wrote:
>> On 13 June 2018 at 18:08, Rafael David Tinoco
>> <rafaeldtinoco@kernelpath.com> wrote:
>> > On Wed, Jun 13, 2018 at 6:00 PM, Greg Kroah-Hartman
>> > <gregkh@linuxfoundation.org> wrote:
>> >> On Wed, Jun 13, 2018 at 05:47:49PM -0300, Rafael Tinoco wrote:
>> >>> Results from Linaro=E2=80=99s test farm.
>> >>> Regressions detected.
>> >>>
>> >>> NOTE:
>> >>>
>> >>> 1) LTP vma03 test (cve-2011-2496) broken on v4.4-137-rc1 because of:
>> >>>
>> >>>      6ea1dc96a03a mmap: relax file size limit for regular files
>> >>>      bd2f9ce5bacb mmap: introduce sane default mmap limits
>> >>>
>> >>>    discussion:
>> >>>
>> >>>      https://github.com/linux-test-project/ltp/issues/341
>> >>>
>> >>>    mainline commit (v4.13-rc7):
>> >>>
>> >>>      0cc3b0ec23ce Clarify (and fix) MAX_LFS_FILESIZE macros
>> >>>
>> >>>    should be backported to 4.4.138-rc2 and fixes the issue.
>> >>
>> >> Really?  That commit says it fixes c2a9737f45e2 ("vfs,mm: fix a dead
>> >> loop in truncate_inode_pages_range()") which is not in 4.4.y at all.
>> >>
>> >> Did you test this out?
>> >
>> > Yes, the LTP contains the tests (last comment is the final test for
>> > arm32, right before Jan tests i686).
>> >
>> > Fixing MAX_LFS_FILESIZE fixes the new limit for mmap() brought by
>> > those 2 commits (file_mmap_size_max()).
>> > offset tested by the LTP test is 0xfffffffe000.
>> > file_mmap_size_max gives: 0xFFFFFFFF000 as max value, but only after
>> > the mentioned patch.
>> >
>> > Original intent for this fix was other though.
>>
>> To clarify this a bit further.
>>
>> The LTP CVE test is breaking in the first call to mmap(), even before
>> trying to remap and test the security issue. That start happening in
>> this round because of those mmap() changes and the offset used in the
>> LTP test. Linus changed limit checks and made them to be related to
>> MAX_LFS_FILESIZE. Unfortunately, in 4.4 stable, we were missing the
>> fix for MAX_LFS_FILESIZE (which before commit 0cc3b0ec23ce was less
>> than the REAL 32 bit limit).
>>
>> Commit 0cc3b0ec23ce was made because an user noticed the FS limit not
>> being what it should be. In our case, the 4.4 stable kernel, we are
>> facing this 32 bit lower limit (than the real 32 bit real limit),
>> because of the LTP CVE test, so we need this fix to have the real 32
>> bit limit set for that macro (mmap limits did not use that macro
>> before).
>>
>> I have tested in arm32 and Jan Stancek, who first responded to LTP
>> issue, has tested this in i686 and both worked after that patch was
>> included to v4.4-137-rc1 (my last test was even with 4.4.138-rc1).
>>
>> Hope that helps a bit.
>
> Ok, thanks, it didn't apply cleanly but I've fixed it up now.

On the latest 4.4.138-rc1,
LTP "cve-2011-2496" test still fails on arm32 beagleboard x15 and qemu_arm.

Summary
------------------------------------------------------------------------
kernel: 4.4.138-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 7d690c56754ef7be647fbcf7bcdceebd59926b3f
git describe: v4.4.137-15-g7d690c56754e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.137-15-g7d690c56754e

On the side note,
Kernel selftests version upgrade to 4.17.

- Naresh
