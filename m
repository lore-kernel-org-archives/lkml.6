Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C5DECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83054214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb7GJKNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83054214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeJRSLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 14:11:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35915 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbeJRSLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 14:11:02 -0400
Received: by mail-ot1-f65.google.com with SMTP id x4so27784791otg.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 03:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:cc;
        bh=OdplwgK40horBM6IE9DxerkAkgJ1obrTZYENNry3okw=;
        b=nb7GJKNLWaI0wY1z93cbY7AH1foo1luXaSeBIXN5VPTRn5Np9NkW42fbteKVGaRWI9
         SGvxkgvBwj0GMAQavSiIB6NDvvpsn+Pz3Rzkmv1gogSimF+FotZkLuLLCB0JEj/RRQEE
         diEhUAyRJjeFhJZJiW8i38hVKqXFLrpJb8KhcCxQ5zRS3huzODSdz3FCDJm+plndkizV
         otaUI823Im9IKkm6DGNeDC+S/cY2M12A8GqlIFMi8V8ZUgWzIUIyvgXz1cdbRVMLeVU0
         SzK22bKj4HiNSK8teuKQl42bn6DcI4Rb1Dzp+rcyYhvRG0g1l4tiJCdPt4zfcQknDRuN
         4i5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:cc;
        bh=OdplwgK40horBM6IE9DxerkAkgJ1obrTZYENNry3okw=;
        b=JCT8+ZDonpWo0DaRdFrlMbPstZaBuYw7PWlBSzZrfHwa41oYsLS4N7zaduuvNeKG1q
         SvdGDDoypNGgd6MuBtFwiMcLpTBpGLX8/6nv+METEqAUOxE7HVo62640p356Ro+E3Znh
         INuIbilLcmPHrGoCCJkVQfS4hyPxIFrYCwoa+4jJAxesUfp+yWbdwzoA9W/vC5zu3rc8
         80i0b4NvZ3cwG1rneOC/Brt7RNHZOgYgAPLrO+EL/Zs0morez8vLyuSKQ4M6S2sZ8DU7
         npwdl1J2fGaAzTxf0YOomEpA51rzIJv2A/3rdsGE7XTO1xVc+bqoAbmXzsjYW8ZZwb5/
         nbrw==
X-Gm-Message-State: ABuFfogGETFNot4KIM3RFERJLgyz7xzODsfqvHq/Dw0PSnX8qACVn7VL
        29Tp4cswbc9onCIdvxNWH4oEeHkhqvfs9FrFYiI=
X-Received: by 2002:a9d:4617:: with SMTP id y23mt19234967ote.300.1539857444868;
 Thu, 18 Oct 2018 03:10:44 -0700 (PDT)
MIME-Version: 1.0
From:   Philipp K <philipp97kl@gmail.com>
Date:   Thu, 18 Oct 2018 12:10:28 +0200
Message-ID: <CAGZ+4_+Sa9z-71_o4qPS7GMRWe8u32nqyCERjFQ_64Y4YrhvfA@mail.gmail.com>
Subject: [RFC: sound/i2c/cs8427] clang warns about cast to signed char
Cc:     kernelnewbies@kernelnewbies.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried compiling the cs8247 sound module with clang and hit the
following warning:

sound/i2c/cs8427.c:141:31: warning: implicit conversion from 'int' to
'char' changes value from 160 to -96 [-Wconstant-conversion]
        data[0] = CS8427_REG_AUTOINC | CS8427_REG_CORU_DATABUF;
                ~ ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~

data is a char array, and CS8427_REG_AUTOINC is defined as 0x80 (dec
128) which is too big for a (signed) char.

Looking at other code in the same file, we usually use unsigned chars.

So is there a reason for data being signed in this case? Otherwise we
could just change data to unsigned char and be on the safe side.

If you want I can send in a patch.

Regards,
Philipp
