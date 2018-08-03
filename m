Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B3FC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD6C21728
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="NXNYzLCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD6C21728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeHCE2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 00:28:25 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:32916 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbeHCE2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 00:28:25 -0400
Received: by mail-qt0-f195.google.com with SMTP id c15-v6so4717428qtp.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 19:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=1G4eOUfxeN8HC+zRnsJjowY8zBBS4TEHM4rRY1o88dc=;
        b=NXNYzLCGXyPy7apuKlaNVy0EVLpvPjjaQ7T0rp2QDyyrDEdByqXouQpiOn8Hkt+KJQ
         7uhqpirFDv51mWFd0cYQKFwzHCwxJk5G+rbpSOtlcmprCantFgv994N5RDWYQ+2+QGSU
         LBsAhBYr6ZbEl3QInFWln4REMe2k5gQ04Es2ldZjTQ1AeV49AM/qR57WJQUtrVFam3PE
         dlsYCoKR2f0n/yWENg8JKlJpRXA7/Z6rKgA5QBnSofyl7DLP8qlOr7EI2S02ZkdSrp/G
         NNJzJ6HBhqZmc/IpWUrI1QHyPmFM+fCQg4oUbX+nYD2vyydW+XhE9X0pylTQZe8Buhkg
         Y3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=1G4eOUfxeN8HC+zRnsJjowY8zBBS4TEHM4rRY1o88dc=;
        b=mRaiVb2qxSWLWNHloa8HwDSbmUmG7FtLLV9p7IB94JI0AGKichUE1bQvYcgwSfF7nE
         sSV3krmkajecp3H8v7mH57LTbXRmnESYbdsLJUPz/HWN71qzgQGDJYV/eIcg7KLRDq6b
         ETuZT3FBNv6/yUk3VwjBNo62Z+Dwh1IeecT1g+Buf3LHnoxJE4KHkg80FaizGrmAIlLL
         8LCJlv9Nv8imJKmSHdXNXItNpTgEGoTVjbIDSyf8CnscmvscwrhNTYMnHpkcZu/VINmp
         nOlK3nALTM/EcCJ+tdmuhVhQLMSYFHndgChhXfAuySEdkV7hJx+HCSo7KCPCsAAjjhzZ
         IpvA==
X-Gm-Message-State: AOUpUlGYbepmVWm/FS09BxuFKc0HdCJHLYDwp/PhWklmtePVWSRwA7tY
        DZC1AAfn+yASGTgGjiq3aky4ZQ==
X-Google-Smtp-Source: AAOMgpenCCRb2EVAhsb86OR6/5dLTVvuZxZuuLe448AlggksPfnqeuepyIMD2SmyNqnsQyRpmJldCQ==
X-Received: by 2002:ac8:435c:: with SMTP id a28-v6mr2004541qtn.412.1533263663687;
        Thu, 02 Aug 2018 19:34:23 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id o80-v6sm3692009qki.19.2018.08.02.19.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 19:34:23 -0700 (PDT)
Date:   Thu, 2 Aug 2018 19:34:20 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the net-next tree
Message-ID: <20180802193420.340a84fe@cakuba.netronome.com>
In-Reply-To: <20180803121430.25899c83@canb.auug.org.au>
References: <20180803121430.25899c83@canb.auug.org.au>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2018 12:14:30 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the net-next tree, today's linux-next build (perf) failed
> like this:
> 
> In file included from btf.c:10:0:
> btf.h:25:24: error: redundant redeclaration of 'btf__type_by_id' [-Werror=redundant-decls]
>  const struct btf_type *btf__type_by_id(const struct btf *btf, __u32 type_id);
>                         ^~~~~~~~~~~~~~~
> btf.h:20:24: note: previous declaration of 'btf__type_by_id' was here
>  const struct btf_type *btf__type_by_id(const struct btf *btf, __u32 id);
>                         ^~~~~~~~~~~~~~~
> btf.c:405:24: error: redefinition of 'btf__type_by_id'
>  const struct btf_type *btf__type_by_id(const struct btf *btf,
>                         ^~~~~~~~~~~~~~~
> btf.c:197:24: note: previous definition of 'btf__type_by_id' was here
>  const struct btf_type *btf__type_by_id(const struct btf *btf, __u32 type_id)
>                         ^~~~~~~~~~~~~~~
> btf.c:40:20: error: 'btf_name_by_offset' defined but not used [-Werror=unused-function]
>  static const char *btf_name_by_offset(const struct btf *btf, __u32 offset)
>                     ^~~~~~~~~~~~~~~~~~
> mv: cannot stat 'perf/.libbpf.o.tmp': No such file or directory
> tools/build/Makefile.build:96: recipe for target 'perf/libbpf.o' failed
> In file included from libbpf.c:52:0:
> btf.h:25:24: error: redundant redeclaration of 'btf__type_by_id' [-Werror=redundant-decls]
>  const struct btf_type *btf__type_by_id(const struct btf *btf, __u32 type_id);
>                         ^~~~~~~~~~~~~~~
> btf.h:20:24: note: previous declaration of 'btf__type_by_id' was here
>  const struct btf_type *btf__type_by_id(const struct btf *btf, __u32 id);
>                         ^~~~~~~~~~~~~~~
> mv: cannot stat 'perf/.libbpf.o.tmp': No such file or directory
> tools/build/Makefile.build:96: recipe for target 'perf/libbpf.o' failed
> 
> Caused by commit
> 
>   89b1698c93a9 ("Merge ra.kernel.org:/pub/scm/linux/kernel/git/davem/net")
> 
> Some of the lines in tools/lib/bpf/btf.[ch] were duplicated (they existed
> on both sides of the merge).
> 
> I have used the net-next tree from next-20180802 for today.

I just noticed that too, fix out:

http://patchwork.ozlabs.org/patch/953018/
