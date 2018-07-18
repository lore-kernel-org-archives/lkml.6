Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63483ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8A5206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEZ+ArV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8A5206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbeGRMYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:24:10 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:39056 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730512AbeGRMYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:24:09 -0400
Received: by mail-wm0-f41.google.com with SMTP id h20-v6so2527774wmb.4;
        Wed, 18 Jul 2018 04:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1bZwF29+FCtSLHKvq7m3Z0VRLy2FqbqoFGTM6Gwocrk=;
        b=AEZ+ArV85f4GvInPIJYUmnW61CER6Ya9+Wge97el2iHHPIqIoy+qjcPYjJl7HSKNKZ
         5g95hzSOkeHBfWdmij4rG44LK+Gymi/jOJ7DPNxztRpiG2X1XbaYd/HKUsjJT+m5Cbqi
         HCmz/0fo65sX0RuRoEgBJCphQ4i+wOeJnbSnuRLvc7leKrdjOZdLS1JpIiiYkfTQKi+H
         BZnO7B858biE06pQzGBdA+w6n6WOIK3s6lkYh4Bv1wixs3ypHXGUuRIvzsQA6Q08sYJZ
         denAk0wsRR0CwHN2NSs/p0o2vu/xcu1ROuileBvWMvW8WMfRS+uo4HgenpBhXhQYnlSe
         A/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1bZwF29+FCtSLHKvq7m3Z0VRLy2FqbqoFGTM6Gwocrk=;
        b=SwZQHUm9ERNmwWNYIrORfP4Dx2mZ52+a3ulpTx6kompCjJSeC1iDjVEqvZL3J8POCW
         7vJVJTTAeeDpSviKrcV/jo6VxidNlbYunOVeWoRPu0+vd/h2G3ZKC6L0G9C9S3joo3xH
         1zmsfQOEGojVIOFk/dHT4j4U0PywZBMBhamh3id7grTBAvs1pnxjftAuBpkZzafvThfe
         rQ0lW+76KZ3krGq9UoM6XUSpDsdsOFvrRGbZWFRkO/MZ1gYQoIwL15FBRmixr1ZMfpll
         5YbUuOHHtzhyHawhrFpeGNl6O+ggzJNVmx7n77F86U1PDqbcXEKPL4NysGm2/L9sSFzg
         ogug==
X-Gm-Message-State: AOUpUlGpMnK5BRcdcjPrCqFPcor7Mt/475P5RX/EOqwIVNYfd9dM9teE
        GgoRt2mmabPHSBwvJkuajlTobjY4Bl86KHe40fk=
X-Google-Smtp-Source: AAOMgpfcVqNYjKGgTu4rmcduPpLocVK2F+nJuv1xlVVb6gBPx5t/Uyju7z6dhht6lNjL3W7PqJAhOR0SJOaafN5CNT4=
X-Received: by 2002:a1c:9c56:: with SMTP id f83-v6mr1313204wme.135.1531914396484;
 Wed, 18 Jul 2018 04:46:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 04:46:35
 -0700 (PDT)
From:   =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Date:   Wed, 18 Jul 2018 13:46:35 +0200
Message-ID: <CAJKOXPftCn+qcJtG6bBjUMa2ZX=_YAoHkoYH69-+jSam4-z86Q@mail.gmail.com>
Subject: [BUG BISECT] "Support fs_context" causes systemd issues (linux-next)
To:     David Howells <dhowells@redhat.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        fenghua.yu@intel.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On recent linux-next, the commit f8076f3b0996 ("kernfs, sysfs, cgroup,
intel_rdt: Support fs_context") causes weird behavior of two of
systemd units: systemd-timesyncd.service and systemd-resolved.service
fail to start.

Logs:

Jul 18 09:51:33 odroidu3 systemd[376]: systemd-timesyncd.service:
Failed to set up mount namespacing: Invalid argument
Jul 18 09:51:33 odroidu3 systemd[376]: systemd-timesyncd.service:
Failed at step NAMESPACE spawning /usr/lib/systemd/systemd-timesyncd:
Invalid argument
Jul 18 09:51:33 odroidu3 systemd[1]: systemd-timesyncd.service: Main
process exited, code=exited, status=226/NAMESPACE
Jul 18 09:51:33 odroidu3 systemd[1]: systemd-timesyncd.service: Failed
with result 'exit-code'.

The configuration:

1. exynos_defconfig
2. ARMv7, octa-core (Cortex-A7+A15), Exynos5422 SoC, Odroid XU3 family
3. ARMv7, quad-core, Exynos4412 SoC, Odroid U3
4. The board boots from TFTP with NFS root (NFSv4)
5. Arch ARM Linux
6. Systemd: v236

Example of boot (logs):
https://krzk.eu/#/builders/21/builds/767/steps/10/logs/serial0


Bisect log:
git bisect start
# good: [30b06abfb92bfd5f9b63ea6a2ffb0bd905d1a6da] Merge tag
'pinctrl-v4.18-3' of
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
git bisect good 30b06abfb92bfd5f9b63ea6a2ffb0bd905d1a6da
# bad: [1dcbe5f2c615337cb7d4e13fab198ab716180733] Add linux-next
specific files for 20180717
git bisect bad 1dcbe5f2c615337cb7d4e13fab198ab716180733
# bad: [209dba6cb2664f6ac48282d666f2b4787286311a] Merge
remote-tracking branch 'crypto/master'
git bisect bad 209dba6cb2664f6ac48282d666f2b4787286311a
# good: [5bd2314d41ad09c497bb72ad3cf94f65913a7da1] Merge
remote-tracking branch 'overlayfs/overlayfs-next'
git bisect good 5bd2314d41ad09c497bb72ad3cf94f65913a7da1
# skip: [dc989d2ce2c2bc4b5cdc92a9d2c8a5c857448475] tools: bpftool:
don't pass FEATURES_DUMP to libbpf
git bisect skip dc989d2ce2c2bc4b5cdc92a9d2c8a5c857448475
# good: [a1bf74dc6e66f91325cc8d35231e151a24a1f9ff] net/mlx5e: Add
channel events counter
git bisect good a1bf74dc6e66f91325cc8d35231e151a24a1f9ff
# bad: [460b2b7ca7db36621315032f5fc4ca85e0b64589] Merge
remote-tracking branch 'rdma/for-next'
git bisect bad 460b2b7ca7db36621315032f5fc4ca85e0b64589
# bad: [a9d11c1d00c560d86855b24f84457a191e70ca4a] Merge
remote-tracking branch 'jc_docs/docs-next'
git bisect bad a9d11c1d00c560d86855b24f84457a191e70ca4a
# bad: [82ffa5de1706a23797d2409e09917bfd56222d32] Merge
remote-tracking branch 'printk/for-next'
git bisect bad 82ffa5de1706a23797d2409e09917bfd56222d32
# good: [e339dd8d8b045399e918c6737b2cc435b21a451e] xfs: use sync
buffer I/O for sync delwri queue submission
git bisect good e339dd8d8b045399e918c6737b2cc435b21a451e
# bad: [ee12a8e0dfcd34069fe1781f2e9d0d8c5fd4e1db] afs: Add fsinfo support
git bisect bad ee12a8e0dfcd34069fe1781f2e9d0d8c5fd4e1db
# good: [96e6c5ff548b9e18ef84b326b5c4c9e59a01e44b] proc: Add
fs_context support to procfs
git bisect good 96e6c5ff548b9e18ef84b326b5c4c9e59a01e44b
# bad: [1ead04847d5b772c53b6d46f0670c83c8a081456] vfs: Implement
fsopen() to prepare for a mount
git bisect bad 1ead04847d5b772c53b6d46f0670c83c8a081456
# bad: [a32434fa30a7f4390aa409726fa08ed4ac802078] hugetlbfs: Convert
to fs_context
git bisect bad a32434fa30a7f4390aa409726fa08ed4ac802078
# good: [6e705c4c287ed7f7bf4fe04c7884e29dd5a9a33d] cpuset: Use fs_context
git bisect good 6e705c4c287ed7f7bf4fe04c7884e29dd5a9a33d
# bad: [f8076f3b0996b70f62b32d9c52649ea9bab2d6cd] kernfs, sysfs,
cgroup, intel_rdt: Support fs_context
git bisect bad f8076f3b0996b70f62b32d9c52649ea9bab2d6cd
# first bad commit: [f8076f3b0996b70f62b32d9c52649ea9bab2d6cd] kernfs,
sysfs, cgroup, intel_rdt: Support fs_context

Any hints how to debug this issue?

Best regards,
Krzysztof
