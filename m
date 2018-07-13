Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF05ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BA9205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCAR4sKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BA9205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbeGMOhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729769AbeGMOhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:37:09 -0400
Received: from mail-qt0-f172.google.com (mail-qt0-f172.google.com [209.85.216.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7E1B205C9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 14:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531491737;
        bh=J7Op8NmDBa9J/bdy0KwpZSwamFXXWQOkgXy3QXUQl3I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rCAR4sKeTXwLLvBK6l6CsfrHtI8rI30SK+TJzoI5p+PLV3pY3Qatmu5NV+Oh6fAvQ
         mItB2+w8pcp2KJb1xza/yw9o8EowY+ULFLPiqDcUXi6azJDSnYbQI55eC0J3ZDENYW
         BsvpJi2oB0q6o/PjFpG7agvXGtqit+QyKz0YQeDY=
Received: by mail-qt0-f172.google.com with SMTP id c5-v6so27177128qth.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 07:22:17 -0700 (PDT)
X-Gm-Message-State: AOUpUlHOfXVT5HO6yTT4SDHNWyNTii45kXdG4srJfVdLC+83nV/G+/gW
        oMXGmaN0UUfSUiS1DrbmgfZE5iXbQZVqBoOVPwU=
X-Google-Smtp-Source: AAOMgpcx0gVMgXvkqj1M8KfEnXX5DthEkH/cTVk6j/4Rs+F7mm/ilK1Xtfy5SlYCDBEQZxSvUMTkcxthiklZmvREWjE=
X-Received: by 2002:aed:3cae:: with SMTP id d43-v6mr5986133qtf.379.1531491736934;
 Fri, 13 Jul 2018 07:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180707031548.GA6594@chelsio.com>
In-Reply-To: <20180707031548.GA6594@chelsio.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Fri, 13 Jul 2018 10:22:05 -0400
X-Gmail-Original-Message-ID: <CA+5PVA4gUKgGVHea_myoVW=Mz+XMSh-CEDFhk=VHiiQLY7iQ_Q@mail.gmail.com>
Message-ID: <CA+5PVA4gUKgGVHea_myoVW=Mz+XMSh-CEDFhk=VHiiQLY7iQ_Q@mail.gmail.com>
Subject: Re: pull request: linux-firmware: update cxgb4 firmware
To:     Ganesh Goudar <ganeshgr@chelsio.com>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        nirranjan@chelsio.com, indranil@chelsio.com,
        Arjun V <arjun@chelsio.com>, venkatesh@chelsio.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 11:55 PM Ganesh Goudar <ganeshgr@chelsio.com> wrote:
>
> Hi,
>
> Kindly pull the new firmware from the following URL.
> git://git.chelsio.net/pub/git/linux-firmware.git for-upstream
>
> Thanks
> Ganesh
>
> The following changes since commit d1147327232ec4616a66ab898df84f9700c816c1:
>
>   Merge branch 'for-upstreaming-v1.7.2-vsw' of https://github.com/felix-cavium/linux-firmware (2018-06-06 13:23:36 -0400)
>
> are available in the git repository at:
>
>
>   git://git.chelsio.net/pub/git/linux-firmware.git for-upstream
>
> for you to fetch changes up to 6213586dc3bc830cb27ce726a3002bb312bfa567:
>
>   cxgb4: update firmware to revision 1.20.8.0 (2018-07-06 09:59:41 -0700)
>
> ----------------------------------------------------------------
> Ganesh Goudar (1):
>       cxgb4: update firmware to revision 1.20.8.0

Pulled and pushed out.

josh

>  WHENCE                  |  12 ++++++------
>  cxgb4/t4fw-1.19.1.0.bin | Bin 553984 -> 0 bytes
>  cxgb4/t4fw-1.20.8.0.bin | Bin 0 -> 559616 bytes
>  cxgb4/t4fw.bin          |   2 +-
>  cxgb4/t5fw-1.19.1.0.bin | Bin 651776 -> 0 bytes
>  cxgb4/t5fw-1.20.8.0.bin | Bin 0 -> 646144 bytes
>  cxgb4/t5fw.bin          |   2 +-
>  cxgb4/t6fw-1.19.1.0.bin | Bin 698368 -> 0 bytes
>  cxgb4/t6fw-1.20.8.0.bin | Bin 0 -> 692736 bytes
>  cxgb4/t6fw.bin          |   2 +-
>  10 files changed, 9 insertions(+), 9 deletions(-)
>  delete mode 100644 cxgb4/t4fw-1.19.1.0.bin
>  create mode 100644 cxgb4/t4fw-1.20.8.0.bin
>  delete mode 100644 cxgb4/t5fw-1.19.1.0.bin
>  create mode 100644 cxgb4/t5fw-1.20.8.0.bin
>  delete mode 100644 cxgb4/t6fw-1.19.1.0.bin
>  create mode 100644 cxgb4/t6fw-1.20.8.0.bin
