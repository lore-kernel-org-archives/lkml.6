Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6F0C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C05B217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Y79DJ4AF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfBESrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:47:45 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43878 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfBESrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:47:45 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so1754247pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 10:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=2YJtRzmHx3/IZ/qlTNwQhUQ+uerwcPMa+P9/mHaImtE=;
        b=Y79DJ4AFJPVGzfnf+3orgY8ot8Q86n/5pVFLfAOI0E37AOdHDbpUlmKjtm3ggyB+8i
         1imP/hj8DX4x7UVg29MhCOLTKXDnQhEZH55KIyK8t1OQ51cXZXmlezFzjbAtX9fKOsbU
         tqajoYKEtyAtZG+8XRmVSoMoVfymIPFXNpaDB8LoXZ/rWJqKqJMYx/1/8PfYTgmNLHg2
         RIdVV2Q+XXGrf4YXrkKkC5ZluEkSPYmNGMSkfwLn3FuluiE3DqCGAn52Rrl91jncnelu
         d0BnOOveQQ+PJO/qJPxAMI5o6zinpO6046pSLWNzV89rIlPmhS61xqCAV/+q09G+OJRq
         RT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=2YJtRzmHx3/IZ/qlTNwQhUQ+uerwcPMa+P9/mHaImtE=;
        b=SvMzJ6xUphyetwpOYtChMIkKiEB5IzU+heiLr9KkIwAbQ2wgz+vws0Z/z16dGmu7jh
         +ch3ErWtFlfwkho2/zRO5bam695c20eiff+zLdh1RMwT7ecAvwqW+yibcFA1EGAkOvMt
         V5fWXEb3lQ4uTvLBdK68Gv+MS0dRzZL5fbvqyVBHjpbYjwVNy3MRQWrng7k3sMaDzmQ/
         Wc4CUjWvFhG4E17bBn9JVHFsr2Ghiohn0aZ8elS7LJEgAitVKAbQ0AGtHc6+EVS+luJD
         NRGx8+zudwbB4RGMUdaf/B/2lU/CUobh5pa5h5eARC+xoEaavmV1fU7FPxw/Nsvn0yUS
         BAtA==
X-Gm-Message-State: AHQUAubap3BgukeKWQS1V+IGQ4vjFw6QEBEcBSa3UsiyqkUfUtn8/O6s
        7i7cdWH9kqxARDlrUS2hg7qd0g==
X-Google-Smtp-Source: AHgI3IbICVfOZ0szL8UA7YoqCM23L10QUs54mIp/WGZVvK80xfmh4rhZJU63AucRWabKV0Y1P/aUaA==
X-Received: by 2002:a62:d148:: with SMTP id t8mr6581098pfl.52.1549392464595;
        Tue, 05 Feb 2019 10:47:44 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id r12sm4375270pgv.83.2019.02.05.10.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 10:47:43 -0800 (PST)
Date:   Tue, 05 Feb 2019 10:47:43 -0800 (PST)
X-Google-Original-Date: Tue, 05 Feb 2019 10:22:55 PST (-0800)
Subject:     Re: linux-next: Fixes tag needs some work in the origin tree
In-Reply-To: <20190203083310.12b97619@canb.auug.org.au>
CC:     schwab@suse.de, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-d27cd6f4-522a-4666-a046-1803f6ee37c9@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Feb 2019 13:33:10 PST (-0800), Stephen Rothwell wrote:
> [Just a reminder for the future.]
>
> Hi all,
>
> In commit
>
>   2bb10639f12c ("RISC-V: fix bad use of of_node_put")
>
> Fixes tag
>
>   Fixes: 94f9bf118f ("RISC-V: Fix of_node_* refcount")
>
> has these problem(s):
>
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").

Thanks.  Is there a script I should be running to pre-check these?
