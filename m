Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD34C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB76214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnaP2mua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB76214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeJQNaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 09:30:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39988 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeJQNaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 09:30:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id d2-v6so28082173wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 22:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=uSKvAknHpPppy5viD8Cb3sTgmjk1y1xnIqOi8utLB8g=;
        b=jnaP2muaZf1O3dcAa9uvFWA5AanxkDVVz8OLQn1VXZs9b2+IscwIS9UNvRkpm1HBx0
         F634pQptdStUaCP7GN+sBLL5/x2Oq5DPO2E61pJxKyiSftofPMzFFViEOkUoWvF2Y1W/
         a+669JstJ336oXP1aWItVtVmH1prEJqqF5taYI3qIPjiw/DghR42m79870y5ToA47E8C
         wfknUOiH7uXNlBSsaieEuXCj0AbAOX6v/s2NTGF83VZccWHsGJJkG40MsjLKlK3pk/HL
         dw0nUIG68igBjdxnLmsEumxDyFBEUyXXCXoUHRRE1uvooOkfq6/cosHwy9EdzaMoq9R7
         Ko6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uSKvAknHpPppy5viD8Cb3sTgmjk1y1xnIqOi8utLB8g=;
        b=grmP41WVqKq9fqDR35RVEcGCWREr7HnNfKaS0Ekww59PP1RpJlWM8uG97/IubLDig3
         MPULn4x1ia2m6ObMISypiyuIF13gQscJLHZyepUGltmQ6c6cYV88dbkHB7VogVWACiU8
         H3VXP7hJ6bkxYy/cezLgHYDqoedumTywX8pdQiOhmIaU3KDA0n1CQ4JQaJ+9NFTOE46v
         jd5qTF30wWqHvFeSzfAtGceIo2cCr8k0UoZ4BZkj1SOlzyUUnGUc/7Cfnnfc48ji6Zgv
         Fs+QNaGNvzOHsLHFeSR6R4VcmZMfW7mfbVU5se0+9bIDmANnZYzebd/G8eNn8ZDx2bRI
         uNLQ==
X-Gm-Message-State: ABuFfohsM/71t/UOzXbCfUNcLWQN0I/+hIIrsEsNlKYxzxUP2Y2o7c2I
        XcHXTKf7pL0sa5APYage6XVSV6asRQwTVkq4IM7O2h/rX5U=
X-Google-Smtp-Source: ACcGV61w1CZp4Oc8Bu9LpDUwpRftMPSTr/zbl4nFS4qsx9Un1mCL7mEZKlvspI6N03LeytVrZ1aQjPHwHGXo5slFd8w=
X-Received: by 2002:a05:6000:124e:: with SMTP id j14mr20450326wrx.315.1539754586555;
 Tue, 16 Oct 2018 22:36:26 -0700 (PDT)
MIME-Version: 1.0
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 16 Oct 2018 22:36:15 -0700
Message-ID: <CAHQ1cqGzq5k5xVzngJo03eKn03hg43AMQ6r2p129dic9wbm=jw@mail.gmail.com>
Subject: Fate of ihex2fw tool
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Chris Healy <cphealy@gmail.com>,
        Kaptain Kernel <andrew.smirnov@gmail.com>,
        Kyle McMartin <kyle@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Marek <mmarek@suse.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

Since commit 5620a0d1aacd554ebebcff373e31107bb1ef7769 ("firmware:
delete in-kernel firmware"):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.19-rc7&id=5620a0d1aacd554ebebcff373e31107bb1ef7769

firmware/ihex2fw.c is gone from the source tree and with it ihex2fw
tool used to generate sruct ihxed_binrec {} filled images (.ihex ->
.fw) consumed by request_ihex_frimware().

I tried looking for that too in
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
but couldn't find it there.

Is there a  new/different source tree it can be found nowadays?
Or is there another established tool that can do .ihex -> .fw
conversion that is expected to be used instead of ihex2bin?

Thanks,
Andrey Smirnov
