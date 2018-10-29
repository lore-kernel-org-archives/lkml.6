Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B67C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272482082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="XPwjlw8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272482082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbeJ3DoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:44:14 -0400
Received: from mta-p3.oit.umn.edu ([134.84.196.203]:36506 "EHLO
        mta-p3.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeJ3DoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:44:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p3.oit.umn.edu (Postfix) with ESMTP id 4989A747;
        Mon, 29 Oct 2018 18:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1540839256; x=1542653657; bh=1YK0wjCQpX
        RLa+eDT43pdA6pzc+NAEWjb48yPZ+oNXs=; b=XPwjlw8pHNrXYPFzXcdoT7+fZW
        +nQA7FAqilh0S7nic0nsO2jmdubKn9bWtBke/GtMTeWqCAaBrBJz0kCZ9zhoaSLb
        Ma6iOKXh89JGb/mE8NClRX6tNwcQD9m4tUOb5Kppgs2QeKD1eg2OXbm61Au1gL1E
        +PzDEG88poXiafNiCZeJUHnj+XAWk+QyjHYfIacfPi9QloX/r5NpBJIDzxFNWEEw
        LENRQpR+fDSQkRx51+yGP2H/9bCIQdt4T4IIC/7cFSw+pctIoDIxdCHO4hHoaE5D
        Yfq0Zy8IP4btuuKrrrWzbNmUjTCG1w8vIba6Wj9mec4y0Da3ZubRIXsg1avg==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p3.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p3.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VPCh53mB-A3m; Mon, 29 Oct 2018 13:54:16 -0500 (CDT)
Received: from mail-it1-f175.google.com (mail-it1-f175.google.com [209.85.166.175])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p3.oit.umn.edu (Postfix) with ESMTPSA id 22A30125;
        Mon, 29 Oct 2018 13:54:16 -0500 (CDT)
Received: by mail-it1-f175.google.com with SMTP id e17so9227752itk.5;
        Mon, 29 Oct 2018 11:54:16 -0700 (PDT)
X-Gm-Message-State: AGRZ1gL+6YAB/vvtTJzRhEIUkh54L/gTum7k12R1sFBRuwrTgc2+U6Eh
        qniPKb7NeiVvca+61IsXsaKY05yMPTTlKpamg50=
X-Google-Smtp-Source: AJdET5er31X1QLHMX7q5WCQyNKq/e8zJMgkoCQJN+g6YTNMYo+zEtshEE59WtFgk/xXZQGgoeo0J8yQnlakf4mjx/Eg=
X-Received: by 2002:a24:4f82:: with SMTP id c124-v6mr11373764itb.108.1540839255865;
 Mon, 29 Oct 2018 11:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <1540051091-16604-1-git-send-email-wang6495@umn.edu> <F93F08E0-9D18-4C1A-8214-8AEAC829B317@gmail.com>
In-Reply-To: <F93F08E0-9D18-4C1A-8214-8AEAC829B317@gmail.com>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Mon, 29 Oct 2018 13:53:39 -0500
X-Gmail-Original-Message-ID: <CAAa=b7cbS0ycDF3sgXn6C9QpczLk5Sy5o-JCi66tTTGtkGoWbQ@mail.gmail.com>
Message-ID: <CAAa=b7cbS0ycDF3sgXn6C9QpczLk5Sy5o-JCi66tTTGtkGoWbQ@mail.gmail.com>
Subject: Re: [PATCH] net: socket: fix a missing-check bug
To:     f.fainelli@gmail.com
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S. Miller" <davem@davemloft.net>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Thanks for your response. The bug is found with the assistance of a
research prototype, which is now not available to the public.

Yes, this is a kind of time-of-check-to-time-of-use (TOCTTOU) bug.

BTW, could you please confirm this bug? Thanks!

Wenwen

On Sat, Oct 20, 2018 at 10:21 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Hi Wenwen,
>
> On October 20, 2018 8:58:10 AM PDT, Wenwen Wang <wang6495@umn.edu> wrote:
> >In ethtool_ioctl(), the ioctl command is firstly obtained from the
> >user-space buffer 'compat_rxnfc' through get_user() and saved to
> >'ethcmd'.
> >Then, 'ethcmd' is checked to see whether it is necessary to pre-process
> >the
> >ethool structure, because the structure ethtool_rxnfc is defined with
> >padding, as mentioned in the comment. If yes, a user-space buffer
> >'rxnfc'
> >is allocated through compat_alloc_user_space() and then the data in the
> >original buffer 'compat_rxnfc' is copied to 'rxnfc' through
> >copy_in_user(),
> >including the ioctl command. It is worth noting that after this copy,
> >there
> >is no check enforced on the copied ioctl command. That means it is
> >possible
> >that 'rxnfc->cmd' is different from 'ethcmd', because a malicious user
> >can
> >race to modify the ioctl command in 'compat_rxnfc' between these two
> >copies. Eventually, the ioctl command in 'rxnfc' will be used in
> >dev_ethtool(). This can cause undefined behavior of the kernel and
> >introduce potential security risk.
> >
> >This patch avoids the above issue by rewriting 'rxnfc->cmd' using
> >'ethcmd'
> >after copy_in_user().
> >
> >Signed-off-by: Wenwen Wang <wang6495@umn.edu>
>
> Assuming these issues are found with some kind of automated analysis, can you also add in your work flow to provide a Fixes: tag such that this could be backported to stable kernels?
>
> If this is found by a tool is this something that is open source and somehow available? I would also make it clear that these issues are typically named time TOCTOU which might be clearer for people who review those patches.
>
> Thanks!
> --
> Florian
