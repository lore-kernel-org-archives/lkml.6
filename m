Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2419AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2ABF2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rI1fRodW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2ABF2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732828AbeJBUbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:31:18 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41340 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732099AbeJBUbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:31:17 -0400
Received: by mail-yb1-f196.google.com with SMTP id e16-v6so750274ybk.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 06:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P1xkz4Z+AMruGKU8nUTbQDJ6FhutDBtd3maC/mIdUsY=;
        b=rI1fRodW9xrlFxWEpfuabcZ5c/eLvuUs5pHYTbt2yukPlgPKG9AZJ0z5vo5R0LvCIp
         shaaGtFoaeWremkumwrZNp7Xx3m/9dQHeXyawD7mlnHjUVdbtlE5ihOVmF5SBQyn2LsR
         NXmQ7RoglL5dOOCUVeof6d22d5OmJmFDfqBoMYkrp7uT2UpjWkqv6Ixjzb47v1oEQ7G0
         Cs6Pq4WigfPxQihzk95QUVpLR6Gd/jh576GWugmHTnjmEJIpPwBTf+Uk7z/MqYzpPL+j
         /Z2jdxTNvXA/IF7ZrSH6wGDz+eZwPi+YBsLsDKOOnvcTrFIMOdyvrOLMyY0W1H8Ujoy0
         SeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1xkz4Z+AMruGKU8nUTbQDJ6FhutDBtd3maC/mIdUsY=;
        b=HllY/03Rbs10HI6U2tGGTpbanhhy17YOzpdUYDaE+w2I8itoZ33a6FDnRjiJAXNNI8
         PnyRsFNDL3P9vhm9qC6/svT5VKRUKDhkq1qzY76PWc4hhCvmJvI/bbcTuyZWhB6FnxVI
         Co7bL6jCVpgweABy1Oe5IN2NVZ52JS7Q1VyamqPCoJ1naDXpRnhK6g27BcJSYmzVCN+x
         E55YFxkAJERpUssMdGbM6ACVDmLYY1WRFlx/FP6rWUhKqFz5VvB1gPF6fU3a3pkuNMfI
         +BaQgiDwtlbet56c3ZGLKnDo3Qmmo7hYpu/CztZJsjXvs2ma77yA8H/ePvQQ7WQEkLtN
         kVUw==
X-Gm-Message-State: ABuFfojSpkta0bmeOdP7AO2tk/+tlOI2cTGhPNa+5VMzmpbO/zh8JlL8
        DIntfFP2qA0wRRL65Y/Ef8EuXF+VDIN3zgizxXoHV8I=
X-Google-Smtp-Source: ACcGV60bchbaYrGY0T0gXz824hWNjEM4t5magWJqdpvNoBh9RzBcJ0nFsqOvT5aXFQurBxhNxLCIp5wAxJln2gcs69M=
X-Received: by 2002:a25:4155:: with SMTP id o82-v6mr8372606yba.310.1538488069565;
 Tue, 02 Oct 2018 06:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181002102602.53320db6@canb.auug.org.au>
In-Reply-To: <20181002102602.53320db6@canb.auug.org.au>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 2 Oct 2018 08:47:37 -0500
Message-ID: <CAErSpo52h3KEFvEw+dEGiy53uvD=956K8QT5RQFLk=ArDJ9EUw@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the pci tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-next list <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        poza@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 7:26 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Bjorn,
>
> After merging the pci tree, today's linux-next build (powerpc
> ppc64_defconfig) produced these warning:
>
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_io_slot_reset':
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:11102:6: warning: unused variable 'err' [-Wunused-variable]
>   int err;
>       ^~~
> drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_pci_error_slot_reset':
> drivers/net/ethernet/intel/i40e/i40e_main.c:14230:6: warning: unused variable 'err' [-Wunused-variable]
>   int err;
>       ^~~
>
> also from the x86_64 allmodconfig build:
>
> drivers/dma/ioat/init.c: In function 'ioat_pcie_error_slot_reset':
> drivers/dma/ioat/init.c:1255:6: warning: unused variable 'err' [-Wunused-variable]
>   int err;
>       ^~~
> drivers/net/ethernet/sfc/efx.c: In function 'efx_io_slot_reset':
> drivers/net/ethernet/sfc/efx.c:3824:6: warning: unused variable 'rc' [-Wunused-variable]
>   int rc;
>       ^~
> drivers/net/ethernet/sfc/falcon/efx.c: In function 'ef4_io_slot_reset':
> drivers/net/ethernet/sfc/falcon/efx.c:3163:6: warning: unused variable 'rc' [-Wunused-variable]
>   int rc;
>       ^~

Fixed the above, thanks!

> Introduced by commit
>
>   6dcde3e574b2 ("XXX PCI/AER: Remove pci_cleanup_aer_uncorrect_error_status() calls")
> (good subject prefix there :-))

Yeah, that's a note to self to update something in the changelog.

Bjorn
