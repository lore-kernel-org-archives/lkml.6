Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F48AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CAD20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9F7iiLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28CAD20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbeK3ALf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:11:35 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35775 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeK3ALf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:11:35 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so1845579edx.2;
        Thu, 29 Nov 2018 05:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9dPqh7sQWNVlicSeJTrzhY27+r1Wf9lpCmbyW/pZ7cM=;
        b=d9F7iiLgsIioXzeqIDqd5VQ8brg05ybh13BJlJTy5Ef/ISjI2/JXPWeH0EM0a9zSuo
         htFXmO2OdqDK5myWGXECnxVa0IxDmeRGjgM7E37Ykpdzf32p5T2GnG/s5x2M/75SOc69
         /KR/cCBfRzFMw1kUOLG6o4mZ2Q8asNG1lQFpBbWPG23xWZYJlNqSPf9rkH+Ui3hoOa7p
         sIbrnjrZ8SIhsuPkOedNbrUM0bOlj2LXWgYlL7oAMHHYOnFVARRz7kmlvY8Oom3byh3/
         y5EezvPDJMO2OJwQ5FKqiBIN/x3u63ihkiZM9LHB2Xbb0hDG4S8j0IKlElR7Rah7jNZ3
         i5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9dPqh7sQWNVlicSeJTrzhY27+r1Wf9lpCmbyW/pZ7cM=;
        b=Y9lXllKSnx9eNOhElqnOfbINywSk09onEUCwIlXymcmcwjYXyEQlIMp9uP2cor8Wuk
         rfep2KZEbtRKkgkoV3DPLkGAePaYjFf3SiFLcZQH/aaDLPNlwvWb5/fIQTvI2B+AdkW/
         gk4c/bbTXNegQBwfdmJOHVUIBlnXO8QoSDz/90p/q74WAzXPslD3pIAKi7/+LZiyXPEi
         bxDvbRty2yO+QecOpvUpSDJCfQC2k3JuSKLmbkhKuSqR2G81QZEjouWsmnJQcmVDx9qf
         kyN6rBdu9lKZxgUYpmvDGITb/2UiYJJf5RmPeKWtzZA357v7jfdROnZ5gs6Iq9zW8OUx
         bUhQ==
X-Gm-Message-State: AA+aEWZDHTXJuGbWEctTLLhXoimeKTwgFDkAtPcdThX511AbCCRWapGV
        6FmdOcrVeMI0VZDnhNb53a12HuLcr8bLXudqsmo=
X-Google-Smtp-Source: AFSGD/Ve7blfYp9yT9bjXbdNNdEO5q9YpBnREg1cXcDBxrhjFVVb8JS1Bx8AE8WBP7n8B7rw67pwQR7y5t/nJgfEDhY=
X-Received: by 2002:aa7:dd16:: with SMTP id i22mr1616616edv.182.1543496775606;
 Thu, 29 Nov 2018 05:06:15 -0800 (PST)
MIME-Version: 1.0
References: <20181125234315.28313-1-grygorii.strashko@ti.com> <20181126022711.GD32164@lunn.ch>
In-Reply-To: <20181126022711.GD32164@lunn.ch>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 29 Nov 2018 13:05:47 +0000
Message-ID: <CA+V-a8veO--4+hazkm=MAekbQrA+-JUNVjWKW13_0354iUwgKQ@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx packet size
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Mon, Nov 26, 2018 at 2:27 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, Nov 25, 2018 at 05:43:15PM -0600, Grygorii Strashko wrote:
> > For proper VLAN packets forwarding CPSW driver uses min tx packet size of
> > 64bytes (VLAN_ETH_ZLEN, excluding ETH_FCS) which was corrected by
> > commit 9421c9015047 ("net: ethernet: ti: cpsw: fix min eth packet size").
> >
> > Unfortunately, this breaks some industrial automation protocols, as
> > reported by TI customers [1], which can work only with min TX packet size
> > from 60 byte (ecluding FCS).
>
> Hi Grygorii
>
> excluding...
>
> > Hence, introduce module boot parameter "tx_packet_min" to allow configure
> > min TX packet size at boot time.
>
> Module parameters are generally not liked.
>
> What actually happens here with this lower limit? Does the hardware
> send runt packets? Does the protocol actually require runt packets?
>
Yes it does send runt packets,  and also get Rx align errors. you can
find the ethtool dump at [1].

[1] https://e2e.ti.com/support/processors/f/791/t/719557?Linux-AM5728-EtherCAT-packets-dropped

Cheers,
--Prabhakar Lad
