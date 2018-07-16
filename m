Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E82ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474822089B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H+Q0w2GV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474822089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbeGPS1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:27:09 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36686 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeGPS1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:27:09 -0400
Received: by mail-lf0-f65.google.com with SMTP id b22-v6so20466288lfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 10:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dSK8Ko8X1jFQ30IlBrvK+fBm91H6k/rFkhFCOWPvMs8=;
        b=H+Q0w2GVLtM3RbzMdPNhZF65H/1paPH3dP+Qq9gxbHDgnTDNkyEERzM6yi+Gw1guHW
         KYnbpwH01nkFPSk3W/iE47yeTCMAg8oG3qbpQlcRUQfm1qD7wGvNmUGxHIbROWxVFkw/
         1CUFcLC4Tv310SndLfKIZdfsVzLfaqCaKe8yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dSK8Ko8X1jFQ30IlBrvK+fBm91H6k/rFkhFCOWPvMs8=;
        b=Z9nj+umiw3NgY01Ny7I1jYL+vc04pwcnPfMTJW7bTSbiTvg7lGVNwX2Vmx4kufKEEy
         bXqlkEFa1XiMs/EotnlqngoPqTXQndS3PMuYVrdXOCF+VkUfiqZ3t2N9IRYpoIvF6wwE
         FQHC/4MvoY4NAe8a1LKzERFQU/wqFCloWPIhc+C9iY5TIoUKWaQALLlKSKjjx9zMCCWg
         xtYhK8WqYyvqIZqF2htuJC4+6ehcHZ4XEbDtFxLblNxDyq9zat22MP63fRIRhU9bB8S7
         OZjBULvEifvoVbh7KXwwqOORpjjNjaz0vmxyK8z8K9Im+cjN2yn0n2GEFVPCilixu84Z
         rWLA==
X-Gm-Message-State: AOUpUlF8lMqvGF+rCHyrU+wqpx/DtjDyzyECKWk9QybplZbflDRAkUE2
        Xf/Dq1TXmqLg+8VVW0wZ/wcMkxZcRGOLWNx3w3dllQ==
X-Google-Smtp-Source: AAOMgpdhxgdBWVO5NB7ZEUXjhDg4VO+Dcj3KA5VRWOui3CluoyVl5888o5+acHSNsdqWPg5MIN0zaOj7uI9mLwz+V1g=
X-Received: by 2002:a19:8f8f:: with SMTP id s15-v6mr12584008lfk.96.1531763916673;
 Mon, 16 Jul 2018 10:58:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 10:58:35
 -0700 (PDT)
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 16 Jul 2018 23:28:35 +0530
Message-ID: <CA+G9fYtVSorLiG5cZdqtipy4XO1zr1HUZ4gH7tf_07m-B4HS1w@mail.gmail.com>
Subject: Re: [PATCH 4.17 00/67] 4.17.7-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 July 2018 at 13:04, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.17.7 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Jul 18 07:34:11 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.17.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
Regressions detected.

LTP syscalls failed test cases on all devices arm64, arm32 and x86_64,
 - creat08
 - open10

Reported this bug internally on upstream Linux mainline week back.
Now this bug happening on 4.17, 4.14, 4.9 and 4.4

creat08 and open10 failed with this error,
TFAIL  : testdir.B.3132/setgid: Incorrect modes, setgid bit should be set

Test case description:
/*
 * NAME
 * creat08.c - Verifies that the group ID and setgid bit are
 *    set correctly when a new file is created.
 *    (ported from SPIE, section2/iosuite/creat5.c,
 *     by Airong Zhang <zhanga@us.ibm.com>)
 * CALLS
 * creat
 *
 * ALGORITHM
 * Create two directories, one with the group ID of this process
 * and the setgid bit not set, and the other with a group ID
 * other than that of this process and with the setgid bit set.
 * In each directory, create a file with and without the setgid
 * bit set in the creation modes. Verify that the modes and group
 * ID are correct on each of the 4 files.
 * As root, create a file with the setgid bit on in the
 * directory with the setgid bit.
 * This tests the SVID3 create group semantics.
 */

Block2 testing:
/*--------------------------------------------------------------*/
/* Block2: Create two files in testdir.B, one with the setgid   */
/*         bit set in the creation modes and the other without. */
/*    Both should inherit the group ID of the parent       */
/*    directory, group2.                                   */
/*--------------------------------------------------------------*/


Test results comparison on mainline versions,
https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-syscalls-tes=
ts/creat08
https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-syscalls-tes=
ts/open10

Test results comparison on 4.17 versions,
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/tests/ltp-syscal=
ls-tests/creat08
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/tests/ltp-syscal=
ls-tests/open10

Bug report link,
https://bugs.linaro.org/show_bug.cgi?id=3D3940

Summary
------------------------------------------------------------------------

kernel: 4.17.7-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.17.y
git commit: bc0bd9e05fa1e213c689620eb4cba825c03dcc4a
git describe: v4.17.6-68-gbc0bd9e05fa1
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/bu=
ild/v4.17.6-68-gbc0bd9e05fa1

Regressions (compared to build v4.17.6-67-g3b02b1fd1975)
------------------------------------------------------------------------

LTP syscalls failed test cases on all devices,

 - creat08
 - open10

--=20
Linaro LKFT
https://lkft.linaro.org
