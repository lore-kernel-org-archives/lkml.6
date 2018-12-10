Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D198BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9578820880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPAtn6RY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9578820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeLJLjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:39:07 -0500
Received: from mail-yw1-f52.google.com ([209.85.161.52]:37963 "EHLO
        mail-yw1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLJLjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:39:06 -0500
Received: by mail-yw1-f52.google.com with SMTP id i20so3804987ywc.5;
        Mon, 10 Dec 2018 03:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f38DMY0IibjUTxAclnXIo44YcMrVeKVR9pHDqcV0xaM=;
        b=qPAtn6RYLR2KXhA1hGuCrZA/2NS+LFxWCQANdR47m9rGeSpnBY85lxYBB8b/s5ZSiX
         tS/hLHw5LZOXcIdPFyMsgn/X/+rTvYO6FbGQ4/mEV+NrrOEd+z8ZvqhY12sVXdFqRHwp
         hkvYataR2oCOTy5SU7ux6EcftljoxxuCoYLkCqDre4WUrFZa0fcAtKevX4tTDkRX/Mzn
         CodoUEdF1byeDXUOolL3tb/jqM0rDptyRF+ydR88yGzs8ZgkZJDa4AdwkjHbqdsIAIDI
         WWukiQEDnzXBWl4VVQrS3+sbPIc8iyXvdA6+2J/uTapKZo5XYSugHMUwsMmqCE4IMF4V
         YbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f38DMY0IibjUTxAclnXIo44YcMrVeKVR9pHDqcV0xaM=;
        b=MVhS25azJjjH7jvgZCT5nfrvINMdqEnFmNgRw5QnXMx9q8OP2Y3Wav3JQf41scFUud
         sUI/UE/2n0w/DXtvqlEJ9tlZaJejRTivJ9ztgvrPQ83J3wFAxfPzOHP00Y+Ufjrme5r3
         80SgPRUY5IP1DJaj700WPxdDLoXGHmaHKrBnCtYeiZbbREyIJ0rniKIhSbrZwjBTKNO3
         4+lqza7ppSund2YZOwMaoYArtJbTKgxuqAtJJ2R5tL9sSOyLXThejXW6Np9WNeEnJvNo
         laqLoQAcKpMAq375h7EJ1DlnB8qmUGr3fjMJgjiY+j/CMwa/diqg5u/chJMMaXPZh3Me
         8/CQ==
X-Gm-Message-State: AA+aEWbGXF12jit9pNm+oMo1KfXa/lqLIDvv20xQeAkMq+M4t5+E3WA9
        6Gl5aq4i7rmYyZKQ/aePgV/pRvR6GALPya3zqfQ=
X-Google-Smtp-Source: AFSGD/VFpjJgiSyFlVPmtLO/m1NlvQ8JduDVNFfgnsXUIdlDgpGO+M1f1dqD+oH1x+7Rkl5c2ySzxEjcZsok6kXUpGU=
X-Received: by 2002:a81:202:: with SMTP id 2mr11956509ywc.291.1544441945805;
 Mon, 10 Dec 2018 03:39:05 -0800 (PST)
MIME-Version: 1.0
References: <20181210123633.4a0e4409@canb.auug.org.au>
In-Reply-To: <20181210123633.4a0e4409@canb.auug.org.au>
From:   Or Gerlitz <gerlitz.or@gmail.com>
Date:   Mon, 10 Dec 2018 13:38:54 +0200
Message-ID: <CAJ3xEMhyNMpiBVb6Q+RkxyxgacUMXnBs7-7f0OvuzXK1-TJvqQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Linux Netdev List <netdev@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Paul Blakey <paulb@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 3:38 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the net-next tree got a conflict in:
>
>   net/sched/cls_flower.c
>
> between commit:
>
>   35cc3cefc4de ("net/sched: cls_flower: Reject duplicated rules also under skip_sw")
>
> from the net tree and commit:
>
>   5c72299fba9d ("net: sched: cls_flower: Classify packets using port ranges")
>
> from the net-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This

[..]

The fix LGTM, thanks for addressing this.

Or.
