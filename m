Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7EBC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 20:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018EB24CE9
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 20:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izC7DbMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018EB24CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbeFWUh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 16:37:28 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:34898 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeFWUh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 16:37:27 -0400
Received: by mail-pl0-f42.google.com with SMTP id k1-v6so5003710plt.2;
        Sat, 23 Jun 2018 13:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OPWYmpQ9KCus67Fm6HzJSn1ZQ1kbG8ry3qi92+/uXC8=;
        b=izC7DbMPQXGXfdI0KOo8UES8aRouVehxTVGbAvXoEMSeulrkbGKDeGsvX9FNIOQ+NZ
         +9WPKMhpkie0NbXfw8OYoTkbaIAQjaBAExzVz1SlVlD6jA8CQP38gbNvzIhtZSVvrivt
         sJ6TEEXgWSjvx4e4Yo0pNpArIGcoHVQ9+fplGuoyFGQfdcPaco0Pr3xGPU9vpPpzSX1m
         mjGKvZA3LkAJ/ga03fwcK3Vrcbpg9+mVzJIF2fBuTmT9JIOPhkiuPr3j3PNKIGWqvYL5
         s5DmEhJhPGQ12qrw0SOistUy9R3BuAmknRP5iSLj75ZdEMCjRszGqRDOXg0WOROvIPE4
         Lcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OPWYmpQ9KCus67Fm6HzJSn1ZQ1kbG8ry3qi92+/uXC8=;
        b=gMg2nlI7tfYY/d2kXxtbtrBLIj+u/vw1s3lhPFfViba+lRkAKjelE3XbkWPnrCEqH2
         sXsRPXbHyMLTT+vLGuJZb44aCrBuy9Aww/R+BmMX+rG5+J9dOZ3sRloiQaKfqljzNt/Q
         QgLdUsa3+IRhMwisYq0QVI8BKHtOwNlT0zBCL7dWOvPCikRDunmV2olMk31WmX+wtveC
         AK5yHswOJaugZJ79kxvFg/sjVCHEeDGYEsqtf6CabLTI4DO/2Sr6oJibhuAS5q3CYAFe
         zx0svuiTt65dM//dmN0otMmd5AEIDmaLOrO+BLCbtL+aXVyZ4T9qgf5JKbB4eBZlsP/C
         UeQw==
X-Gm-Message-State: APt69E3TP44GjegQFNBgnlMviE46epbQLRaViez4390XJoWcHUoYm02R
        Ej9e9A0Sn/yJYl+gXVzhlcE+2OR3q7dHLeQupdGL0Kpz
X-Google-Smtp-Source: ADUXVKI+Dtp6cv4VmPLTDeWpFZX43wI0yVhqCVsXp14FV2bpCQGvrYhUGqDymCMRA65O++CHMVWujSILgqUnnuAosTI=
X-Received: by 2002:a17:902:7009:: with SMTP id y9-v6mr6541079plk.217.1529786246352;
 Sat, 23 Jun 2018 13:37:26 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 23 Jun 2018 15:37:13 -0500
Message-ID: <CAH2r5msa5N3JmjV1Wueyf_h6V7vGbpWywjd5uHXaspOWW5QdJw@mail.gmail.com>
Subject: Sparse errors in 4.18-rc in slab.h
To:     sparse@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting many of these sparse warnings in 4.18-rc1

./include/linux/slab.h:631:13: error: undefined identifier
'__builtin_mul_overflow'

They are a little distracting (I missed a more important sparse
warning due to large number of those from slab.h).  Any ideas how to
silence it?

-- 
Thanks,

Steve
