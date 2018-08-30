Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B9CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103B920834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl/bSKU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103B920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeH3VfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:35:25 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33148 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeH3VfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:35:25 -0400
Received: by mail-oi0-f65.google.com with SMTP id 8-v6so16908479oip.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 10:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rUF7qrTCd8u8YDsm2r7+oPMJL5I/sUwYgTeSWmQawb4=;
        b=Yl/bSKU/Jv3Yek4sCF1/gwyJHzPW8cEA+CDhK7cE6SHrAKVDr0RZZoTijHCV429/jg
         MrbctNLyok1Y15jS8ei/Xcb/ilT+0X4FEos5ML2PWiR2XoGRK9SjPByEjTzaLu8UWo2c
         PhkdSwdSUkZ2tRBCdPeanuLuz6zFiW81rp1N0WuZnOcU+GiH+1MIkBLsaQGi0UPqkdR5
         dOXQuna858PAe/bE8PjCoe/73LtYgXZ72cYJZ2/4Dx3HO70elDztGl7FgdnfFahdLQhH
         HZ8wlEacqZuVFaD88JHjHN1YIUO95yUds1xpNiG+k541ZdqNIupmD+4hu+VoGfKVvtTO
         gMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rUF7qrTCd8u8YDsm2r7+oPMJL5I/sUwYgTeSWmQawb4=;
        b=LMvFRwqduYHTzE0pREyaF4fr896TsCvkmosG9vbaZPkE48MP5UDLyE268sro8wHrCf
         sc30cap1Xu/DG9lTqlPkMn21aivYBgsVpoFTNwcchjTrQT+W/OOJUYmYEB0fPNjegUr5
         49/ff910+jE3LLGx/hv0u8+4iSqoL3huDBw+ELU23DWvv8FcxvF3WW1y3Ga/ypLCHtzi
         cGadWw7f/qiD+1D9Ue1+5WlNT53qJ0n2B80oBFk1EEsKr5Vq4tietDMpithWbrWY2wou
         rG/HUwz8OmerOPcAMnX8hRmAN/fc6Ioirzea5x+quQ4+qEyxcpxRYgqN789VJvwphr6j
         Ns4A==
X-Gm-Message-State: APzg51BKLJfoRQAU2BPLcxh1xcUJnb4FwgUL8oGl0x+ITL554swqBlUK
        9PCe8TPwY2NdMais31SILD2RcbDxStOKrUyiAujHzw==
X-Google-Smtp-Source: ANB0VdZcbt4kLrvDZEpTHzo8Y5S52Ab7FfY/urDImetq3yBWt17IyLcZHyuT0AxKpwFD5YXUr06AFrpH6gC5/hcT/lE=
X-Received: by 2002:aca:d8d4:: with SMTP id p203-v6mr3674761oig.107.1535650332925;
 Thu, 30 Aug 2018 10:32:12 -0700 (PDT)
MIME-Version: 1.0
From:   Ray Clinton <mr.ray.clinton@gmail.com>
Date:   Thu, 30 Aug 2018 13:32:09 -0400
Message-ID: <CAPMnawtav+8OX4+iPA+RDBXJZ7OR==noksxxtNLzzTTCPcb-NQ@mail.gmail.com>
Subject: [PATCH 0/4] staging: comedi: Correct multiline dereference as per TODO
To:     Greg Kroah-Hartman <greg@kroah.com>
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been working on the correcting the checkpatch.pl failures found in
staging/drivers/staging/comedi of 4.18.0 and have a few patches to submit
for review.

The files that I changed are:

drivers/dt3000.c
drivers/ni_labpc_common.c
drivers/ni_mio_common.c
drivers/dt3000.c

While there were a few warnings/checks checkpatch.pl brings up the only
one that the Internet told me was ok to work on were dereferences that
happened over multiple lines. For each of the files above that was the issue
and it was always due to the author trying to stay within the 80 character
line width limitation. I did my best to remove the warning while keeping the
code readable.

**PLEASE**: any feedback on what I could do better in the patches, in the
emails, anything, would be much appreciated.

Thanks so much!

Ray

---

 drivers/staging/comedi/drivers/dt3000.c          | 6 +++---
 drivers/staging/comedi/drivers/ni_labpc_common.c | 8 ++++----
 drivers/staging/comedi/drivers/ni_mio_common.c   | 6 +++---
 drivers/staging/comedi/drivers/rtd520.c          | 6 +++---
 4 files changed, 13 insertions(+), 13 deletions(-)
