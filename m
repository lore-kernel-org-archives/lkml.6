Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD984C6787D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9CC2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="s2pF3XA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9CC2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJHJKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 05:10:17 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:56777 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725760AbeJHJKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 05:10:17 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 48475e72
        for <linux-kernel@vger.kernel.org>;
        Mon, 8 Oct 2018 02:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :from:date:message-id:subject:to:content-type; s=mail; bh=QLNmig
        m3zfxN0vaJTM/CQWFCCBM=; b=s2pF3XA0qeHCbV8ckHjtcudn5mdPMbRhtbZ1G7
        OS5jq3klY7cNb19t7+4IEi1TfLf0LCJ02ICdkfrBBgIQQAVWRSPAwONaiL0DXeXJ
        Yj32VkHhSyMrprvXxq0eIbCzvAMxaUBQuL7v2RPrdTIAx6HNQfhW6culp8aBjrHK
        kqTs+rvj9b2xxiA0hqmr3ZtRKVMAFXaOhAdZw5LVgbd4NmqtycFd44BNSJkVNffN
        uEbHAomZJBKD5AOKLgfVOHm3zIC+9bi/uQ+yHezv/WUKr/Nb9hEVyJijJ5wCPuQz
        fU5hUPHHPFXSDPkUHjyBne9rWqzsqcCmoxKEY+SDiv0Ibb2g==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d07cf7fd (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 8 Oct 2018 02:00:16 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id e21-v6so18093788otk.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 19:00:59 -0700 (PDT)
X-Gm-Message-State: ABuFfoi4UvjBuoUcLwg78Ah0DTxn0LEXMfbWxXQP/bNZPU8OqGNHhaax
        jDBtaZG4hrDnn5gJJKD1IzXdhu2qz3oO6r2+P74=
X-Google-Smtp-Source: ACcGV61xu6BMWyV1k3wHE7VMgiZtZeDUuUhV04ekFiPbg0mBmfZBhdnN467xlzn+ttplcqm7sI+QJIHeMXi5BdmWc1E=
X-Received: by 2002:a9d:1d47:: with SMTP id m65mr13333166otm.199.1538964059059;
 Sun, 07 Oct 2018 19:00:59 -0700 (PDT)
MIME-Version: 1.0
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 8 Oct 2018 04:00:47 +0200
X-Gmail-Original-Message-ID: <CAHmME9ofzanQTBD_WYBRW49d+gM77rCdh8Utdk4+PM9n_bmKwA@mail.gmail.com>
Message-ID: <CAHmME9ofzanQTBD_WYBRW49d+gM77rCdh8Utdk4+PM9n_bmKwA@mail.gmail.com>
Subject: list iterator spacing: clang-format vs checkpatch
To:     miguel.ojeda.sandonis@gmail.com, Joe Perches <joe@perches.com>,
        Andrew Lunn <andrew@lunn.ch>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe, Miguel, others,

The shiny new .clang-format file lists a number of nice iterators in
the ForEachMacros category, the consequence being that there is a
space between the iterator name and the opening parenthesis. This
strikes me as the right thing to do.

However, checkpatch.pl complains about it:

WARNING: space prohibited between function name and open parenthesis '('
#65: FILE: ratelimiter.c:65:
+               hlist_for_each_entry_safe (entry, temp, &table_v4[i], hash) {

It would seem that .clang-format is right and checkpatch.pl is wrong?

Thanks,
Jason
