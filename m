Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3813ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4263206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Jq/7slyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4263206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbeGSTIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 15:08:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34847 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731832AbeGSTIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 15:08:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6-v6so4506737pgv.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 11:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=JoNFk9pLsAWd0bL+riE0+6p0w/U0+5DsWYJcrUXOvaw=;
        b=Jq/7slyo+ylMtGyKd4Z9ed1lqemHmN6l4WNpyjlVhs+Co4wi0CwiYI5VyGW6i2sucC
         Pyaa696QeYXhA9Ztw42hPBbAktWbUqwuIWzSIMb0JTznTzJ+iIIuwAnjVSKkIZuWmram
         XqSSr6+N26HRPVhjSic54TGZmhVSy8B8hBqX2tywwPLon3rklMyyeYCiaVKyzVnIAaLL
         dJ132KyXX4AJBK2VxipYPY7WIu59zaItVF5LS4bbgcntClv0V7r3YQlvHxVMsPx95t4T
         D5dsjp4lkUMEfeMoexI9zLDqDzqA/ak7Vpr/2+5qvb6laFJ2iBjInIYoYex6v1X2bFIE
         yQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=JoNFk9pLsAWd0bL+riE0+6p0w/U0+5DsWYJcrUXOvaw=;
        b=BDPH60IKmLLil1hATA6h6dtvDGPQjywvNTE5XKBMntzDjk18PAAzhRHvAjhEO+QzkV
         wTYkAMc1WvfzW9CPdzJrF1sId44cqN80aXjcE5N/+NZ+iffJU2nohEdqWZLmzdqvN5iw
         B17FfFcBN5LJ099wOsxtfrzdFTqcF80hJD7/BlUuxYu4JJZoU7pPK05JkZ2EKexmiVXV
         zp0XD4Nw0JrjRJyXstlYXiJfHJoYeLNXOQR0lE+oypz+pTJxirA1vtGjpsDg0QA4INFs
         tA2bUyLYPBTWcAFcGsN4W7o1PF3VnkSou8BTSFoHwiIdWobOIQQttbupoukgePkAUfkM
         hXrA==
X-Gm-Message-State: AOUpUlF3TIbFgvayY/Rr+K/HrLEfyDgB1y/Kk+B9JSL6aPAMX95627Ok
        2Vk1Y+gB/k/1wtkFOC/1zhdCt+02Nhc=
X-Google-Smtp-Source: AAOMgpc1gX5Pte9rTBCnl0eIKN0pcNMw9Aq7Oc15WJ6UYyX22ZEOHSlT1uIzKZJ+IdKzIzKMq0g4pw==
X-Received: by 2002:a65:41c6:: with SMTP id b6-v6mr10881762pgq.174.1532024641126;
        Thu, 19 Jul 2018 11:24:01 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-231-89-118.hsd1.ca.comcast.net. [73.231.89.118])
        by smtp.gmail.com with ESMTPSA id q78-v6sm22635815pfi.185.2018.07.19.11.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 11:24:00 -0700 (PDT)
Date:   Thu, 19 Jul 2018 11:23:57 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Taeung Song <treeze.taeung@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tools/bpftool: ignore build products
Message-ID: <20180719112357.4fd6c6ce@cakuba.netronome.com>
In-Reply-To: <20180719121005.12018-1-treeze.taeung@gmail.com>
References: <20180719121005.12018-1-treeze.taeung@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018 21:10:04 +0900, Taeung Song wrote:
> For untracked things of tools/bpf, add this.
> 
> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
> ---
>  tools/bpf/.gitignore         | 5 +++++
>  tools/bpf/bpftool/.gitignore | 1 +
>  2 files changed, 6 insertions(+)
>  create mode 100644 tools/bpf/.gitignore
> 
> diff --git a/tools/bpf/.gitignore b/tools/bpf/.gitignore
> new file mode 100644
> index 000000000000..dfe2bd5a4b95
> --- /dev/null
> +++ b/tools/bpf/.gitignore
> @@ -0,0 +1,5 @@
> +FEATURE-DUMP.bpf
> +bpf_asm
> +bpf_dbg
> +bpf_exp.yacc.*
> +bpf_jit_disasm
> diff --git a/tools/bpf/bpftool/.gitignore b/tools/bpf/bpftool/.gitignore
> index d7e678c2d396..103cc5b5b446 100644
> --- a/tools/bpf/bpftool/.gitignore
> +++ b/tools/bpf/bpftool/.gitignore
> @@ -1,3 +1,4 @@
>  *.d
>  bpftool
> +bpftool*.8
>  FEATURE-DUMP.bpftool

This patch is going to be merged to the bpf-next tree, I presume, and
there is more man pages there:

$ make -C tools/bpf/bpftool/ doc 
make: Entering directory 'linux/tools/bpf/bpftool'
  DESCEND  Documentation
make[1]: Entering directory '/linux/tools/bpf/bpftool/Documentation'
  GEN      bpftool-perf.8
  GEN      bpftool-map.8
  GEN      bpftool.8
  GEN      bpftool-prog.8
  GEN      bpftool-cgroup.8
  GEN      bpf-helpers.rst
Parsed description of 80 helper function(s)
  GEN      bpf-helpers.7
make[1]: Leaving directory 'linux/tools/bpf/bpftool/Documentation'
make: Leaving directory 'linux/tools/bpf/bpftool'
$ git status 
On branch work
Your branch is ahead of 'pending' by 10 commits.
  (use "git push" to publish your local commits)

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	tools/bpf/bpftool/Documentation/bpf-helpers.7
	tools/bpf/bpftool/Documentation/bpf-helpers.rst
	tools/bpf/bpftool/Documentation/bpftool-cgroup.8
	tools/bpf/bpftool/Documentation/bpftool-map.8
	tools/bpf/bpftool/Documentation/bpftool-perf.8
	tools/bpf/bpftool/Documentation/bpftool-prog.8
	tools/bpf/bpftool/Documentation/bpftool.8

nothing added to commit but untracked files present (use "git add" to track)


See the bpf-helpers.* files?  Those are all auto-generated.

If you respin for -next please split the series and put [PATCH bpf-next
v4] as prefix of first patch, and [PATCH bpf v4] as prefix for the
second, as one of them is an improvement, and second a bug fix.

Thank you!!
