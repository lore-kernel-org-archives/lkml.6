Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F7CC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A2E260D8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooui1QiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A2E260D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965092AbeFYU0q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 16:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754284AbeFYU0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 16:26:44 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18E92260C7;
        Mon, 25 Jun 2018 20:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529958403;
        bh=/bygV1AXstOrCrSKfrlXUKysAMhFMywTJd7zKk1Aluc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ooui1QiKDdlDwxBPKxLHCJIWr6EwOLKglaXB41yeqExjuKhFHcaoEcKVDRnNvAyEG
         Qx5FtbRjgzcANUFLao2oTLl102Fxk6WQVVapBs2e1p4L6EPAZmHhRCkcSxOpXsU9aO
         T9LlJAhz/SgWzr+FM3s3IdBV/TP0oZ9e/Ii0QyEE=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 664C51401E5; Mon, 25 Jun 2018 17:26:40 -0300 (-03)
Date:   Mon, 25 Jun 2018 17:26:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Leblond <eric@regit.org>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>, stable@vger.kernel.org,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/19] perf/urgent fixes for 4.18
Message-ID: <20180625202640.GA20477@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 25, 2018 at 02:40:26PM -0300, Arnaldo Carvalho de Melo escreveu:
> Test results:
 
> The first ones are container (docker) based builds of tools/perf with
> and without libelf support.  Where clang is available, it is also used
> to build perf with/without libelf, and building with LIBCLANGLLVM=1
> (built-in clang) with gcc and clang when clang and its devel libraries
> are installed.
 
> The objtool and samples/bpf/ builds are disabled now that I'm switching from
> using the sources in a local volume to fetching them from a http server to
> build it inside the container, to make it easier to build in a container cluster.
> Those will come back later.
 
> Several are cross builds, the ones with -x-ARCH and the android one, and those
> may not have all the features built, due to lack of multi-arch devel packages,
> available and being used so far on just a few, like
> debian:experimental-x-{arm64,mipsel}.
 
>   # dm
>    1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
>    2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
>    3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
>    4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
>    5 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
>    6 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
>    7 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
>    8 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>    9 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>   10 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
>   11 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
>   12 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
>   13 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
>   14 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
>   15 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
>   16 debian:experimental           : Ok   gcc (Debian 7.3.0-19) 7.3.0
>   17 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 7.3.0-19) 7.3.0
>   18 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 7.3.0-19) 7.3.0
>   19 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 7.3.0-18) 7.3.0
>   20 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 7.3.0-19) 7.3.0
>   21 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
>   22 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
>   23 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
>   24 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
>   <stopped due to a power outage>

Ok, just for completeness sake:

  # dm from fedora:24
  25 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  26 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  27 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  28 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  29 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
  30 fedora:28                     : Ok   gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
  31 fedora:rawhide                : Ok   gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
  32 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 6.4.0-r1 p1.3) 6.4.0
  33 mageia:5                      : Ok   gcc (GCC) 4.9.2
  34 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  35 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  36 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  37 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  38 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.3.1 20180323 [gcc-7-branch revision 258812]
  39 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18.0.7)
  40 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28.0.1)
  41 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  42 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  43 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.4-2017.05) 5.4.1 20170404
  44 ubuntu:15.04                  : Ok   gcc (Ubuntu 4.9.2-10ubuntu13) 4.9.2
  45 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  46 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  47 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  48 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  49 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  52 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  53 ubuntu:17.04                  : Ok   gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  54 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  55 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
