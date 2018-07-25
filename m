Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43343C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08FF20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oofteiJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08FF20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbeGYWZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:25:39 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35739 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730357AbeGYWZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:25:39 -0400
Received: by mail-oi0-f65.google.com with SMTP id i12-v6so16474580oik.2;
        Wed, 25 Jul 2018 14:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Es0czL5E75BKCHYy1xyR78B3sa+q0YTkVFLqEagPYbo=;
        b=oofteiJ4tXfFBlCnrYZADIF8p38rqy9M78Uuak2t7GgXW8+m6QAyG9kGDHQHt7mx/l
         PhQSaK5J1RIqGcvr2MVmb3vAdmerU2sbPX4CCB1ffo6JcMSR9am1HFcunAiSI5n82SFq
         fHavAzBHeXiR8NeOFnQutECGI8bZQbVZNnRcO4ZV00htMpZNTp72Zby1OL7Vkd9XD8KT
         87L1YDhW6dX9NAm6vDovcs1Nax8C+PacIF8OI9gHHzb7YELWFyqZLmycvgZuFohkjHU4
         nxOvPnCR2kCqwHboISx2x3NPXMDiy+D83Gz4mr9XINccdTu084PdcPbw7Il5+BzlhaTJ
         8qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Es0czL5E75BKCHYy1xyR78B3sa+q0YTkVFLqEagPYbo=;
        b=UUgDIfZeiVl+fgp0G9YPiV8Lky/krSz7b77jh6lQnO3+Zghys2Pnon73inQv6iOZ+E
         Pwi5e5dYhgDJNMLhT2ykG+X/QT7CBGpY6JTXOQQ5eSjxBOuoP3CEepybQIdp0QW+bJGJ
         Vs2g5rw0oSkZACY0csuWYQeAQLzzJiFc7Cd6FsUpNBDNYF8uBamKD5nh+7Ig1MRVIamz
         dYU/0YZi++Kmd58DzBmEAyO+Dbd+SgINVVfUJnnzrB7nlcpaIXMwS4kJzntUvyTtZxoI
         gxw4OXwDsJNMGitDHISs1FMTG3yLBJWLd2hjDo/d6NbHoGEKKvVVFmGqHPlcFS9GWQpM
         2CFw==
X-Gm-Message-State: AOUpUlF5TSAACcJSeuJRWdmMJ04AsvhyfUf47ejtTdOjq1F8qFob9TpG
        3h0urPoabfL+C/XBWsjGAoszojlcq2IQJJEijPg=
X-Google-Smtp-Source: AAOMgpdYT8xeOg/0IlmeMs23h6mJrp6kp37nYTtat7WV8JjL/+LkL0OCuXalXz4pJIE4o+E2tl3x/XAT6qcy4NCVtMI=
X-Received: by 2002:aca:cd41:: with SMTP id d62-v6mr4674077oig.207.1532553129518;
 Wed, 25 Jul 2018 14:12:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:42c1:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 14:12:08
 -0700 (PDT)
In-Reply-To: <153254834342.92573.16877025672192312745.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153254834342.92573.16877025672192312745.stgit@bhelgaas-glaptop.roam.corp.google.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 25 Jul 2018 14:12:08 -0700
Message-ID: <CAKgT0UewV82FKVMkW975+upccaRJF4i6oQYzNh5jC02wcGmhXQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v1 1/4] igb: Remove unnecessary include
 of <linux/pci-aspm.h>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Johannes Berg <johannes.berg@intel.com>, linuxwifi@intel.com,
        Netdev <netdev@vger.kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, LKML <linux-kernel@vger.kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 12:52 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> The igb driver doesn't need anything provided by pci-aspm.h, so remove
> the unnecessary include of it.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Looks good to me.

Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>

> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index f707709969ac..c77fda05f683 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -22,7 +22,6 @@
>  #include <linux/if.h>
>  #include <linux/if_vlan.h>
>  #include <linux/pci.h>
> -#include <linux/pci-aspm.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/ip.h>
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
