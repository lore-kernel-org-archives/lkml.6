Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEB2ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 07:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3508B2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 07:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIvUmBkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3508B2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbeKDQvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 11:51:46 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:45345 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbeKDQvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 11:51:46 -0500
Received: by mail-lj1-f172.google.com with SMTP id j4-v6so5204375ljc.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 00:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EuzfH48LPnqMiTlylZdLUD872+BuH575vmkXf/c6ghM=;
        b=hIvUmBkMDLWMCjGXCbL3y++uvTtTLR+ilcNBCzJNbfYoNyN08mvAbXQEMZRilKqhSi
         ahwbdUXm2UXwkBwOXqR+nASBNJtUzWpQ3WAftXVGFNLb/xz0WXRA1M2aWFbm7yo9ecrf
         HxAzQmoRhoPpTh1AEGwwazyw84Q+cQKreMaFnHX/IpI0lx1qjBxb1eOZyNiehinEiG/t
         BO+FLKppRanv2yyXDsaVHc4UqYNvGDeMAVdfRVQfbLH7s3jJHr3NsvmaPvh7QXmhKac0
         lzcWeFJ2nKNGWmfr+I/rBscA9qfCwuJ+FoanjmOLpyxn2zeu9yQQQ55MFea83TsE+z3d
         4dDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EuzfH48LPnqMiTlylZdLUD872+BuH575vmkXf/c6ghM=;
        b=D+4IBUABgOerBYTspMfi61dWUdqkN+e7zNLwxRfL/LANbYI1yvk4YxYkKbKm38b/ha
         fpPw8sx8Z4SPHZqG3UcxrNeyHSCJFn3WJ0bztBmYp5yH2A8ammpyUR8EDmRGxWeBUl0S
         oexIxoRO/UlQx9IJmdqkTbS9vc8M1H+7AZlhEoJmI6Mm/twKeeXv0jfSJnDTzkBkAqRO
         Mb0xWqmwbAppVnL7JRKL56tPVkC/W5BmrMoifE6I0AZLL8XypIBVAg58OMh9ArAWnO/T
         3PnrEVikf3lliXzwB0mxq/dK7ju7n1dXxV2ohTbWSNDnAQEnxrRtIWjyzmmfaH0aTNmt
         IBFQ==
X-Gm-Message-State: AGRZ1gKt/txINMqHyvTlTFnWlKP6cBDQWHkdL0NZd0qGuCiCtWqY8tqH
        HY1jbCsPUHKeEOOekm2gvLqg/+u9xTemblWV8b54eSuz
X-Google-Smtp-Source: AJdET5dp30rGawpmpbo27DLQbAMQZKKUWRqHUX7aHukXBwblXkgcFf3VoAGx2qzO2uX/NHVtFz/+N4rF1/JFFkhcpnk=
X-Received: by 2002:a2e:8989:: with SMTP id c9-v6mr11538929lji.124.1541317065168;
 Sun, 04 Nov 2018 00:37:45 -0700 (PDT)
MIME-Version: 1.0
From:   Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date:   Sun, 4 Nov 2018 10:37:34 +0300
Message-ID: <CAE5jQCeFs0_NS9AZwfw+U60jKU5RRPD56THEhCq_jLJkiFy0=A@mail.gmail.com>
Subject: OCFS2: [ocfs2_rename:1688 ERROR: status = -39] with four syscalls on
 fresh FS image
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000027fbae0579d1d805"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000027fbae0579d1d805
Content-Type: text/plain; charset="UTF-8"

Hello,

When fuzzing OCFS2, I got an ERROR message in dmesg output with
several syscalls on completely fresh, uncrafted FS image. From this
https://oss.oracle.com/pipermail/ocfs2-devel/2012-August/008683.html
it looks like ERROR messages are indicating some unexpected conditions
in the driver code, is it right? If so, here it how to reproduce it
with kvm-xfstests:

1) Checkout latest torvalds/master (tested with commit 71e56028), copy
x86_64-config-4.14 from fstests to .config, `make olddefconfig`,
enable CONFIG_FS then OCFS2 and compile
2) Create fresh OCFS2 image:
$ fallocate -l 256M ocfs2
$ mkfs.ocfs2 -L test --fs-features=local ./ocfs2
$ mv ocfs2 /tmp/kvm-xfstests-$USER/ # mkfs.ocfs2 seems to not operate
on tmpfs that can be mounted on /tmp
3) gcc --static ocfs2.c -o /tmp/kvm-xfstests-$USER/repro
4) Inside the ./kvm-xfstests shell
root@kvm-xfstests:~# mount /vtmp
root@kvm-xfstests:~# mount /vtmp/ocfs2 /mnt
[   17.168634] JBD2: Ignoring recovery information on journal
[   17.173903] ocfs2: Mounting device (7,0) on (node local, slot 0)
with ordered data mode.
root@kvm-xfstests:~# /vtmp/repro
[   20.597145] (repro,368,1):ocfs2_rename:1688 ERROR: status = -39
root@kvm-xfstests:~#

Best regards
Anatoly

--00000000000027fbae0579d1d805
Content-Type: text/x-csrc; charset="US-ASCII"; name="ocfs2.c"
Content-Disposition: attachment; filename="ocfs2.c"
Content-Transfer-Encoding: base64
Content-ID: <f_jo2k5up20>
X-Attachment-Id: f_jo2k5up20

I2luY2x1ZGUgPHN5cy9zdGF0Lmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPHVu
aXN0ZC5oPgojaW5jbHVkZSA8c3RkaW8uaD4KCmludCBtYWluKCkKewogIG1rZGlyKCIvbW50L3h5
eiIsIDB4NzAwKTsKICBta2RpcigiL21udC9hYmMiLCAweDcwMCk7CiAgc3ltbGluaygiL21udCIs
ICIvbW50L3h5ei8xIik7CiAgcmVuYW1lKCIvbW50L2FiYyIsICIvbW50L3h5eiIpOwp9Cg==
--00000000000027fbae0579d1d805--
