Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8786C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849B820651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="PvbGYbSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394401AbfAPQ5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:57:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46390 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731103AbfAPQ5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:57:22 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so3261852ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=/b0v7wMED6S2JCUnbVx3eM4FOrf0dlwvVWgbT1szyBA=;
        b=PvbGYbSwU5VdLGgnibAq7RKMg9J41210TUPrwOauOUc7dJ7z0xKrIB2DzuoNRxidvo
         im7tN5kzkTH4fsvT0g8w1O9E1BbArtZTxHiH5K8Dx0pAR1GgNMkiCB2gS3c0tk2LCock
         4d7Z4n4qLpfupn2ErH9GVPbYxbcrEjyuiJtlDUC4O5r9NJUeLNfyb4PTQHtGhFIXDqPz
         J+hV5zVdTbXVpkG0IHXTUVCiUXvg+yupVEJp7yG6+55/g0qoBxJ5GFha90qeIPgczZ99
         mXmKvH2z3SpN0R7o94mN3o2yt1fgM7V+5fWpJYIMcxX2PinUR/claUNFCjZgkMRIeIg1
         sF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=/b0v7wMED6S2JCUnbVx3eM4FOrf0dlwvVWgbT1szyBA=;
        b=RSyUiSroeBTN8SoCiGRqr8Ugr06O/BYBwke/H+x8gqWi1lkxZh6iEivRq06Au+QOs8
         5CWMopAOZiadJGbHkaxMLK1C7YkJ0k5VdrLGR7wGfVcCMRZZacY6deurqub6T/JL+SNg
         SI1wbxVDT6FaC4uR1UTQVIHlkfizQ48zIW7r1wY5FOiB1AUMiT4gRXofFFzYqRFpu6pf
         Yw1Q8WLA3XrGMzqjMMFlvSF2AiVCi6AGm/VbSZ1/5hkMI0Q7vdmocGDMQiUsKM876VAd
         LLyTrY1lRDbROKrBybbsciK3oZrxkfWEp/K4eEzGvbhLSqskhW1EEAdYPS7ZamAB3Xy5
         35aw==
X-Gm-Message-State: AJcUukcVW1dvwm1RO4/PY1hrQgrZdcWPXo2W5bDWF5PGje1/Gv1ckggd
        1mZod41DIiE5Tge++IEXu8v59w==
X-Google-Smtp-Source: ALg8bN6ZSbTqndK9gqTYv4XyitS/ORXT1eZkWJvhcqju1csw3TGNeimlJd7WTMjaHH5RDUJcdwFhvQ==
X-Received: by 2002:a17:902:622:: with SMTP id 31mr10594571plg.171.1547657841177;
        Wed, 16 Jan 2019 08:57:21 -0800 (PST)
Received: from [25.170.158.113] ([172.56.31.87])
        by smtp.gmail.com with ESMTPSA id p6sm10199431pfn.53.2019.01.16.08.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 08:57:20 -0800 (PST)
Date:   Wed, 16 Jan 2019 18:57:10 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190116164219.GD5446@kroah.com>
References: <20190116131903.8515-1-christian@brauner.io> <20190116155450.GA3508@kroah.com> <EB0D154D-A8CD-4CDB-B66F-C20945722AE2@brauner.io> <20190116164219.GD5446@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] selftests: add binderfs selftests
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        arve@android.com, maco@android.com, tkjos@google.com
From:   Christian Brauner <christian@brauner.io>
Message-ID: <CA19B5F8-FEE9-4159-BA01-9C51B4DF97FA@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 16, 2019 6:42:20 PM GMT+02:00, Greg KH <gregkh@linuxfoundation=
=2Eorg> wrote:
>On Wed, Jan 16, 2019 at 06:21:12PM +0200, Christian Brauner wrote:
>> On January 16, 2019 5:54:50 PM GMT+02:00, Greg KH
><gregkh@linuxfoundation=2Eorg> wrote:
>> >On Wed, Jan 16, 2019 at 02:19:03PM +0100, Christian Brauner wrote:
>> >> This adds the promised selftest for binderfs=2E It will verify the
>> >following
>> >> things:
>> >> - binderfs mounting works
>> >> - binder device allocation works
>> >> - performing a binder ioctl() request through a binderfs device
>works
>> >> - binder device removal works
>> >> - binder-control removal fails
>> >> - binderfs unmounting works
>> >>=20
>> >> Cc: Todd Kjos <tkjos@google=2Ecom>
>> >> Signed-off-by: Christian Brauner <christian=2Ebrauner@ubuntu=2Ecom>
>> >> ---
>> >>  tools/testing/selftests/Makefile              |   1 +
>> >>  =2E=2E=2E/selftests/filesystems/binderfs/=2Egitignore |   1 +
>> >>  =2E=2E=2E/selftests/filesystems/binderfs/Makefile   |   6 +
>> >>  =2E=2E=2E/filesystems/binderfs/binderfs_test=2Ec      | 120
>> >++++++++++++++++++
>> >>  =2E=2E=2E/selftests/filesystems/binderfs/config     |   3 +
>> >>  5 files changed, 131 insertions(+)
>> >>  create mode 100644
>> >tools/testing/selftests/filesystems/binderfs/=2Egitignore
>> >>  create mode 100644
>> >tools/testing/selftests/filesystems/binderfs/Makefile
>> >>  create mode 100644
>> >tools/testing/selftests/filesystems/binderfs/binderfs_test=2Ec
>> >>  create mode 100644
>> >tools/testing/selftests/filesystems/binderfs/config
>> >>=20
>> >> diff --git a/tools/testing/selftests/Makefile
>> >b/tools/testing/selftests/Makefile
>> >> index 1a2bd15c5b6e=2E=2E400ee81a3043 100644
>> >> --- a/tools/testing/selftests/Makefile
>> >> +++ b/tools/testing/selftests/Makefile
>> >> @@ -10,6 +10,7 @@ TARGETS +=3D drivers/dma-buf
>> >>  TARGETS +=3D efivarfs
>> >>  TARGETS +=3D exec
>> >>  TARGETS +=3D filesystems
>> >> +TARGETS +=3D filesystems/binderfs
>> >>  TARGETS +=3D firmware
>> >>  TARGETS +=3D ftrace
>> >>  TARGETS +=3D futex
>> >> diff --git
>a/tools/testing/selftests/filesystems/binderfs/=2Egitignore
>> >b/tools/testing/selftests/filesystems/binderfs/=2Egitignore
>> >> new file mode 100644
>> >> index 000000000000=2E=2E8a5d9bf63dd4
>> >> --- /dev/null
>> >> +++ b/tools/testing/selftests/filesystems/binderfs/=2Egitignore
>> >> @@ -0,0 +1 @@
>> >> +binderfs_test
>> >> diff --git a/tools/testing/selftests/filesystems/binderfs/Makefile
>> >b/tools/testing/selftests/filesystems/binderfs/Makefile
>> >> new file mode 100644
>> >> index 000000000000=2E=2E58cb659b56b4
>> >> --- /dev/null
>> >> +++ b/tools/testing/selftests/filesystems/binderfs/Makefile
>> >> @@ -0,0 +1,6 @@
>> >> +# SPDX-License-Identifier: GPL-2=2E0
>> >> +
>> >> +CFLAGS +=3D -I=2E=2E/=2E=2E/=2E=2E/=2E=2E/=2E=2E/usr/include/
>> >> +TEST_GEN_PROGS :=3D binderfs_test
>> >> +
>> >> +include =2E=2E/=2E=2E/lib=2Emk
>> >> diff --git
>> >a/tools/testing/selftests/filesystems/binderfs/binderfs_test=2Ec
>> >b/tools/testing/selftests/filesystems/binderfs/binderfs_test=2Ec
>> >> new file mode 100644
>> >> index 000000000000=2E=2Eca4d9b616e84
>> >> --- /dev/null
>> >> +++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test=2Ec
>> >> @@ -0,0 +1,120 @@
>> >> +// SPDX-License-Identifier: GPL-2=2E0
>> >> +
>> >> +#define _GNU_SOURCE
>> >> +#include <errno=2Eh>
>> >> +#include <fcntl=2Eh>
>> >> +#include <sched=2Eh>
>> >> +#include <stdio=2Eh>
>> >> +#include <stdlib=2Eh>
>> >> +#include <string=2Eh>
>> >> +#include <sys/ioctl=2Eh>
>> >> +#include <sys/mount=2Eh>
>> >> +#include <sys/stat=2Eh>
>> >> +#include <sys/types=2Eh>
>> >> +#include <unistd=2Eh>
>> >> +#include <linux/android/binder=2Eh>
>> >> +#include <linux/android/binderfs=2Eh>
>> >> +#include "=2E=2E/=2E=2E/kselftest=2Eh"
>> >> +
>> >> +int main(int argc, char *argv[])
>> >> +{
>> >> +	int fd, ret, saved_errno;
>> >> +	size_t len;
>> >> +	struct binderfs_device device =3D { 0 };
>> >> +	struct binder_version version =3D { 0 };
>> >> +
>> >> +	ret =3D unshare(CLONE_NEWNS);
>> >> +	if (ret < 0)
>> >> +		ksft_exit_fail_msg("%s - Failed to unshare mount namespace\n",
>> >> +				   strerror(errno));
>> >> +
>> >> +	ret =3D mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
>> >> +	if (ret < 0)
>> >> +		ksft_exit_fail_msg("%s - Failed to mount / as private\n",
>> >> +				   strerror(errno));
>> >> +
>> >> +	ret =3D mkdir("/dev/binderfs", 0755);
>> >> +	if (ret < 0 && errno !=3D EEXIST)
>> >> +		ksft_exit_fail_msg(
>> >> +			"%s - Failed to create binderfs mountpoint\n",
>> >> +			strerror(errno));
>> >> +
>> >> +	ret =3D mount(NULL, "/dev/binderfs", "binder", 0, 0);
>> >> +	if (ret < 0)
>> >> +		ksft_exit_fail_msg("%s - Failed to mount binderfs\n",
>> >> +				   strerror(errno));
>> >
>> >Can you check first to see if the kernel under test really even has
>> >binderfs in it?  If not, you need to just
>>=20
>> Hm, I thought that's what the "config" file was for?
>> E=2Eg=2E a conditional compile or is this just a hint to the
>> user what's needed to run the test?
>
>I do not know=2E  What happens if you try to run this test on a kernel
>without that config option?  Does it not work as the framework
>correctly
>detects this?

I did test and it worked fine but let me check by setting up a clean vm an=
d retry=2E

>
>And new kernel self tests should cc: the ksefltest mailing list and the
>maintainer of that subsystem so that they can review the test for
>things
>like this=2E

Thanks, missed them in my Cc list=2E

Christian

