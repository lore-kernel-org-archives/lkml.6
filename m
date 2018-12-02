Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0640C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38652081C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLtT1c+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38652081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbeLBVmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:42:54 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:45632 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeLBVmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:42:54 -0500
Received: by mail-wr1-f43.google.com with SMTP id v6so10129520wrr.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 13:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ZRKm8PSbYu7M2RgBgtyq4qrZVphMIr5N9CX7gxrn80A=;
        b=bLtT1c+HN8nHlBIWk9jR58efyh5YcNMM0ZSGmlfCVS5x54/DtEe8AEUpAm5XMkNROT
         hBRQExYdkjl6+8dyA7DBhgCdtQygrNKepaZ4Z29Emj60RHTBQ3+UK4uB47R0iAFEXoTT
         0SHaM3Twv42PBDcSo9NbsapzagdSf0HsAfdfc0n7BbJ27idyuuY+HyM9f+dFjWV80tEk
         R49TSZO+MwtSsbijnlEdQnu9ImIwn3V1VH6ws3Okoc0REt/Iincc65Z/pBOOpmAUEr6P
         TT4NEaSsnxLejjf1Md1prpWY9TQbxkqlGB59d357/Ahrg4mIDAdTOU21EUxvTnQNUnAz
         CrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ZRKm8PSbYu7M2RgBgtyq4qrZVphMIr5N9CX7gxrn80A=;
        b=CWySN+UWXUhzP5kD/RtXtBLZMM1GM3ehT0/wBgOTU2gHUiCVJBIvqjEYeR5UQMvw4A
         RKKLiAH0ObT5FRaCfk81zgOdOl7b8JBg/+47T8yoviExb+JXj4XnlYkJSf5tJ9sJyUSq
         7muZlvziQVqLbrW2Qv+b9s/XumMyqV2bji04/4jITSB1FDlR2xJTi0ulskDCNc/qzTAE
         vsQbW7gQylqupHjUUAChKTPZq74L4OB9nFV+rogmLwz/teVcU3OwZ5bAgzUvYdft68Y/
         /dAHOoX0w95zBkyIyOWC3vIYg6gguOC6K+dR84m+hVfbiT8NTHJP35gvzwwxn25jNhKu
         cVfg==
X-Gm-Message-State: AA+aEWbBDALtGDmPxx5lwjCmAwtwTNKF4dDERx2TKjJ9kdcfgjapqdbZ
        vlx2pmsR5RVZLlgScmKJr9TTfh+CARd0u4FJbddeeNVi
X-Google-Smtp-Source: AFSGD/W+gv6zVvE5skaQen989GwqsLQC4WbZ0SCwHJOmQE/DGJrheWPm9vhhaqklCKuOyL6YY1Sid3S3iLJaD1pVbUs=
X-Received: by 2002:adf:b102:: with SMTP id l2mr11340498wra.296.1543786971294;
 Sun, 02 Dec 2018 13:42:51 -0800 (PST)
MIME-Version: 1.0
References: <CAK+_RLnYbyDrqRbm6-AyRmG4=iFrqqL_UrzHuhPO1_jD1F9WSQ@mail.gmail.com>
In-Reply-To: <CAK+_RLnYbyDrqRbm6-AyRmG4=iFrqqL_UrzHuhPO1_jD1F9WSQ@mail.gmail.com>
From:   Tigran Aivazian <aivazian.tigran@gmail.com>
Date:   Sun, 2 Dec 2018 21:42:40 +0000
Message-ID: <CAK+_RLk=WL1SxtNF7YRw5eLGjcCc9o2dcHodgFw7SoFPSm25Xw@mail.gmail.com>
Subject: Re: [patch set 4.19.6] BFS updates
To:     torvalds@linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

just wanted to add: although the subject says "4.19.6" the patches
apply perfectly to the top of "torvalds/linux" tree from github.
On Sun, 2 Dec 2018 at 21:01, Tigran Aivazian <aivazian.tigran@gmail.com> wrote:
>
> Hi Linus,
>
> I attached two incremental patches for BFS:
>
> 1. Make inode bitmap allocation static (applies on top of 4.19.6)
> 2. Strengthen the superblock sanity checking code (applies on top of 1. above)
>
> Kind regards,
> Tigran
