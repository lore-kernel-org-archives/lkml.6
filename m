Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268B4C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EB42083B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EB42083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933370AbeGJAqT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:46:19 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41155 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933132AbeGJAqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:46:12 -0400
Received: by mail-qt0-f193.google.com with SMTP id e19-v6so2793325qtp.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 17:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rL6yKWn/ghYDtxoPy6kAOb9PjswobXgvOOXINpa0bDM=;
        b=bewv9c+1zgdFcvJUuMtmnZZQsCggCGNfFPhKDEZx4IQ6QZwCxVhX/jPpfy3Hp7LDIL
         a5So+/S1W525JDWQ9RHisoMl9jl3yaL0cpLbnoofEqRhVIk611n3O40aYp0I0aTdR0P8
         /MhIy6kQ8hl6Aj5qTxSv2F3XvXtwN9E+Tg2mfPrFDoAbMUlThqXICmLwrYuH3itNGva/
         k7y6gfE03kOxJJTJllYooNiavQjP7XZtTijeKCPjS87N3VP7MP95sPu2R6iak8OiWGwq
         SCvhlweo5TFDD0mrWCMrOIl87BvVb3gDD1DLYPIzUeQHPEpK3phwzjWQ8y544wO9Sq7y
         Nphg==
X-Gm-Message-State: APt69E0Rb9AqZJobgJr88aYJNI584t+YAFfIugZ75NGNJlKHq7IezFeC
        qt8W3vpTFhBOgx1CRIe5RVHP/w==
X-Google-Smtp-Source: AAOMgpeydYGyGxb9J6YYTMdwbjfAcbMFx52LkUbiVGaJuFVd21S53Z9o2vfvOU6FKhmcDh2v1RU3Sw==
X-Received: by 2002:a0c:9208:: with SMTP id a8-v6mr19517967qva.47.1531183572041;
        Mon, 09 Jul 2018 17:46:12 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::1941])
        by smtp.gmail.com with ESMTPSA id l36-v6sm1816792qtk.12.2018.07.09.17.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 17:46:10 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Jarry <robin.jarry@6wind.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCHv2 0/7] HOSTFLAGS and HOSTLDFLAGS from the environment
Date:   Mon,  9 Jul 2018 17:45:55 -0700
Message-Id: <20180710004602.21599-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This is v2 of the series to set HOSTCFLAGS and HOSTLDFLAGS from the
environment. The changes are mostly minor fixups requested and also
include documentation of the new options.

Laura Abbott (7):
  tools: build: Fixup host c flags
  tools: build: Use HOSTLDFLAGS with fixdep
  treewide: Rename HOSTCFLAGS -> KBUILD_HOSTCFLAGS
  treewide: Rename HOSTCXXFLAGS to KBUILD_HOSTCXXFLAGS
  treewide: Rename HOSTLDFLAGS to KBUILD_HOSTLDFLAGS
  treewide: Rename HOST_LOADLIBES to KBUILD_HOSTLDLIBS
  Kbuild: Use HOST*FLAGS options from the command line

 Documentation/kbuild/kbuild.txt | 16 ++++++++++++++++
 Makefile                        | 17 +++++++++--------
 arch/alpha/boot/Makefile        |  2 +-
 net/bpfilter/Makefile           |  4 ++--
 samples/bpf/Makefile            | 22 +++++++++++-----------
 samples/seccomp/Makefile        |  6 +++---
 scripts/Kbuild.include          |  2 +-
 scripts/Makefile                |  4 ++--
 scripts/Makefile.host           | 24 ++++++++++++------------
 scripts/kconfig/Makefile        | 10 +++++-----
 tools/build/Build.include       |  2 +-
 tools/build/Makefile            |  2 +-
 tools/objtool/Makefile          |  4 ++--
 tools/perf/pmu-events/Build     |  2 +-
 14 files changed, 67 insertions(+), 50 deletions(-)

-- 
2.17.1

