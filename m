Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADFCECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 03:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAAB20645
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 03:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Doy2PZp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FAAB20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJULeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 07:34:18 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52590 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbeJULeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 07:34:18 -0400
Received: by mail-it1-f196.google.com with SMTP id 134-v6so8430739itz.2;
        Sat, 20 Oct 2018 20:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=jzyKYx4AFihvqSKCOrGgDtZOZ5a6rH32a5Afi+e39ic=;
        b=Doy2PZp4y7SSYSF+UKFOZvDWLbmdopwhwb2YxgaZ1FVLCrQlcXx2/dOOqXZQ7939El
         HOwVjVchylZPdwq38l8WQnMAZKZ7D9nfg7V92tBQ2x0uH57YVvV+JKZxXE1KuCkpnNuT
         WiZxFQV/B2mEaMln9kiIWBbjVSatICld8LLXptxiAL0tfdOM2X6X3Kovz/B7Xt6nxgem
         baCLBNE9xKbUx7ok0r2hkWmIc8P/oT2hHGuomYECbL3/ssiMjs8w25kPPc8TEbrjionz
         9hCEuyao3DKyTmmQOwqLxE3jseK9U+8lr25lSv/9Bm5+U30bCOodrJM3oxVHccKGCjeY
         cSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=jzyKYx4AFihvqSKCOrGgDtZOZ5a6rH32a5Afi+e39ic=;
        b=lsG/7CsOmt0pHTthUPSgve9rcZzbVl3hA7R/XxeBK9wUDMC3sbomkSdtTe7elYdN5g
         H6gJDomcuLvy1iVLT3hlMvzRfLmiT5f+Tj0A37ZZSauamJRk3bF1EFXfHKH2GvmHhTZ7
         3zz0hTXNtmrRVULrrC1g6nRCKJKES+Oqtau5SV6S452nT/B+906WFgaX1XFsILHT2xJZ
         5HZGD7k831VVMBCPIySkLlZYZnbl7wYnyJri+0ealVhJCcBZIXbNf7FXbrrjbjJz+IIc
         HiBVLvpxcL6MbVodovpGJmLXipk7DVkmofr5LteHf3EZrh8dzUwVKAUC0nYBeZDKi01l
         78sA==
X-Gm-Message-State: ABuFfogffjXPd91EjhcBFi0qHOc8f2S7k2i73QDZASNpfK3K2BZ/1Nvb
        J9BKZu1wVpu6qgglzFmEGjY=
X-Google-Smtp-Source: ACcGV63EMDn7oUH073ffk6V0dWMxsX8BM1cu5ItVb0aoOIQC6pv4McOto/yTxNXGqhV0SDejUAnFIw==
X-Received: by 2002:a02:9609:: with SMTP id c9-v6mr165174jai.118.1540092093284;
        Sat, 20 Oct 2018 20:21:33 -0700 (PDT)
Received: from nexus5x-flo.lan (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id 72-v6sm803188iou.87.2018.10.20.20.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 20:21:32 -0700 (PDT)
Date:   Sat, 20 Oct 2018 20:21:19 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <1540051091-16604-1-git-send-email-wang6495@umn.edu>
References: <1540051091-16604-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] net: socket: fix a missing-check bug
To:     Wenwen Wang <wang6495@umn.edu>
CC:     Kangjie Lu <kjlu@umn.edu>, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <F93F08E0-9D18-4C1A-8214-8AEAC829B317@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wenwen,

On October 20, 2018 8:58:10 AM PDT, Wenwen Wang <wang6495@umn=2Eedu> wrote=
:
>In ethtool_ioctl(), the ioctl command is firstly obtained from the
>user-space buffer 'compat_rxnfc' through get_user() and saved to
>'ethcmd'=2E
>Then, 'ethcmd' is checked to see whether it is necessary to pre-process
>the
>ethool structure, because the structure ethtool_rxnfc is defined with
>padding, as mentioned in the comment=2E If yes, a user-space buffer
>'rxnfc'
>is allocated through compat_alloc_user_space() and then the data in the
>original buffer 'compat_rxnfc' is copied to 'rxnfc' through
>copy_in_user(),
>including the ioctl command=2E It is worth noting that after this copy,
>there
>is no check enforced on the copied ioctl command=2E That means it is
>possible
>that 'rxnfc->cmd' is different from 'ethcmd', because a malicious user
>can
>race to modify the ioctl command in 'compat_rxnfc' between these two
>copies=2E Eventually, the ioctl command in 'rxnfc' will be used in
>dev_ethtool()=2E This can cause undefined behavior of the kernel and
>introduce potential security risk=2E
>
>This patch avoids the above issue by rewriting 'rxnfc->cmd' using
>'ethcmd'
>after copy_in_user()=2E
>
>Signed-off-by: Wenwen Wang <wang6495@umn=2Eedu>

Assuming these issues are found with some kind of automated analysis, can =
you also add in your work flow to provide a Fixes: tag such that this could=
 be backported to stable kernels?

If this is found by a tool is this something that is open source and someh=
ow available? I would also make it clear that these issues are typically na=
med time TOCTOU which might be clearer for people who review those patches=
=2E

Thanks!
--=20
Florian
