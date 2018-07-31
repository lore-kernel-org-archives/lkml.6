Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23081C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32AD20857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32AD20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbeGaKoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:44:07 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35142 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbeGaKoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:44:07 -0400
Received: by mail-qt0-f195.google.com with SMTP id a5-v6so15109822qtp.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 02:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6e840QDhpL8BACW2BQuiFPh8nL03m7KLe9q38igx9zc=;
        b=bpcbbN7iD9NT9Fv9fGwFvUVvPCM7YToDwlaAKarVVx/KvnT3RVFshtrYbXkFWeMzx0
         oqdIJDaFiU/njk2BCQv04jm5uLg1e2fbudceBftBviSGf2GwGdYx2T9O+4SJAx82zaps
         Odec0jPorbJPBJPdWtlAK5cjhk44+mzaJLYGXx8txlwbInmQqvd7ro5Vsp2AE5DppVua
         LqAmTXWufZEomzXg8b5uI5ZjDPZTYeWJmjIeupJux0IA/goIbZMMcGzzGAXBNLVNjBnn
         P4kCQktOPeSl8HLzQ/u9yfBg64Kx6+u2xY66WukbuhGQ2lDDB4X1zt+I+0pJEZ5bdnjC
         qDuA==
X-Gm-Message-State: AOUpUlG3gI9ZbaTpSJxnRVZjcpxiXxKmiwvRbb2QJvcKa7Kxm5Kng/Tq
        lwJbr10nagUN2vSa8VMP3elY5w==
X-Google-Smtp-Source: AAOMgpdT3CEPevbqrmSsGeacoEmMuAQzx6OJy9VwVZkq7iPosiSVkeev8VER/c/ns7Sr1eriEWDjzA==
X-Received: by 2002:ac8:29a4:: with SMTP id 33-v6mr20588149qts.354.1533027887442;
        Tue, 31 Jul 2018 02:04:47 -0700 (PDT)
Received: from dwysocha.rdu.csb (75-26-10-140.lightspeed.rlghnc.sbcglobal.net. [75.26.10.140])
        by smtp.gmail.com with ESMTPSA id l10-v6sm6956815qkk.49.2018.07.31.02.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 02:04:46 -0700 (PDT)
Message-ID: <1533027885.3710.2.camel@redhat.com>
Subject: Re: linux-next: build warning after merge of the nfs-anna tree
From:   David Wysochanski <dwysocha@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 31 Jul 2018 05:04:45 -0400
In-Reply-To: <20180730185200.0d836ca7@canb.auug.org.au>
References: <20180730185200.0d836ca7@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-30 at 18:52 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the nfs-anna tree, today's linux-next build (powerpc
> ppc44x_defconfig, sparc defconfig) produced this warning:
> 
> net/sunrpc/stats.c: In function 'rpc_clnt_show_stats':
> /home/sfr/next/next/net/sunrpc/stats.c:258:32: warning: excess elements in struct initializer
>    struct rpc_iostats stats = { 0 };
>         

Apologies I did not see this before submission.

The below fixup compiles without warning for me on ppc64le.

   struct rpc_iostats stats = {};


>                         ^
> 
> Introduced by commit
> 
>   c3b588a2d5be ("sunrpc: Change rpc_print_iostats to rpc_clnt_show_stats and handle rpc_clnt clones")
> 
