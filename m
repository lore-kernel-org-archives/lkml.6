Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F85C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECB42085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNbdWJuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECB42085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbeKFAWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:22:06 -0500
Received: from mail-ua1-f41.google.com ([209.85.222.41]:42749 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbeKFAWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:22:06 -0500
Received: by mail-ua1-f41.google.com with SMTP id d21so3266937uap.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 07:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=OYIY3viVCF8vRikh06BNnK36L3xDHvAxFlHa4paMGwk=;
        b=JNbdWJuT110lq/LPIDECulFdJQWobV+AI5mn1yEoDlu7J9jbLjvcC09VytQjaTD1D2
         maq+hprkr3jhcoq7kz83MifOGWe0NIKIXV9C63mB7Ho7Lw4sGCJnSvUjQzQ6UGahxyH3
         uqEATZobInuvTFI7/Gh2GHtbI89xLK2CfST2uqGpkQ6lEVbxT8fs0sC0bk/7NawcIaTu
         2LkGsH3mCRciQyuqwmPAoIX5qmOt/BSb7HNOKnzbDxH8sr0XfgXaf69Mbud2CbB24+2H
         YoAb387uGu2opBnXnvkFWpJPKGwNoiaSLT5b+vrTANbRKOYFZdoIYFRnLGsG+pBvD3+D
         Ih6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OYIY3viVCF8vRikh06BNnK36L3xDHvAxFlHa4paMGwk=;
        b=m5zOxVqKK/PSFbJE4ZXj3JOiKLOlnA4jwALfucFLXUvvrrxzSAyxNT2CIDP54Ur0kl
         0/lLWUAZaw5IyASwEBKf9XhhlP4TFrr+oKr5dgw053C3kV5r/HUEJ0tWiZoEAn37xMSn
         VVNciVvuf+zcP7eZb6Fmd8JuV1tbgchIdXnIfu3PKVc46IpJgLykRwZ4g2TN1z4rgNoO
         X2s43XTIDs5MlxFZsveMNk1lsPToeu1GCmb2ZaEZbe27ltAYpgOF8JhiELo2RO1C5Ivx
         D2GS6hpHqOcRor2egfp+EkhszPBLoFisIMKWEti4c2nIedbij1WVFTF/JSioX5NNjOTN
         a7Kg==
X-Gm-Message-State: AGRZ1gIgQHgogDyeRBRJMam6gdoxqFX8n0o+nrwSRULfaeR5Fify9kBh
        Eyg9ILSXjBZBnmrf7Wz1/sCiPpFZ8uTNI4zZZGmIsA==
X-Google-Smtp-Source: AJdET5c020ARybs4AmbD9JlU8XGm7imVDmj70HPH9AQUwvxFz2fNa9mjJtspSyAskE3ne1MSGE0x0+JoXppWXiDfxuo=
X-Received: by 2002:ab0:1553:: with SMTP id p19mr6625692uae.47.1541430118298;
 Mon, 05 Nov 2018 07:01:58 -0800 (PST)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 5 Nov 2018 20:31:46 +0530
Message-ID: <CAOuPNLjuM5qq3go9ZFZcK0G5pQxTQb0DY36xu+8SL4vC4zJntw@mail.gmail.com>
Subject: Creating compressed backing_store as swapfile
To:     linux-mm@kvack.org, open list <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have one requirement:
I wanted to have a swapfile (64MB to 256MB) on my system.
But I wanted the data to be compressed and stored on the disk in my swapfile.
[Similar to zram, but compressed data should be moved to disk, instead of RAM].

Note: I wanted to optimize RAM space, so performance is not important
right now for our requirement.

So, what are the options available, to perform this in 4.x kernel version.
My Kernel: 4.9.x
Board: any - (arm64 mostly).

As I know, following are the choices:
1) ZRAM: But it compresses and store data in RAM itself
2) frontswap + zswap : Didn't explore much on this, not sure if this
is helpful for our case.
3) Manually creating swapfile: but how to compress it ?
4) Any other options ?


Thanks,
Pintu
