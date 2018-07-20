Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C2CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F24A20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrnwOS+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F24A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbeGTXS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 19:18:57 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:36750 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbeGTXS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 19:18:56 -0400
Received: by mail-lf1-f46.google.com with SMTP id b22-v6so2764698lfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 15:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jsbJUeNN4MCyPcE5ihhgctanfsFozuTtfhxpl7prLlI=;
        b=QrnwOS+UtxBE4nPNcNZLNSkeb7X9EXN3rOQYkvGg18lb30HDdr8oIoVhIRM14b14qd
         0067hXNCeNLZRp/5C+IsogWWLcrzFRnSrNrZqruDY4YPOpRlqi/AoGGIS7F8eFd7ohxM
         xPYfHbQuLH+U+j33m0nWAWiBGeBiRZdAEKhMBz5qbLhp3BkQO1aHKJGuiXH3/RnOiCKb
         k40+g9cmOrRBxIZQagJ6/W268p9ITF8+QkCb4/zwZkmx5EFLFNDLL4l9FutcWglEU2sK
         fu2/T2WoKZogBUIjVUzbcHX4kZDmC7pQIgxvcY2Sp27U729ISv3JLjHvQmkRKlvhf524
         Dm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jsbJUeNN4MCyPcE5ihhgctanfsFozuTtfhxpl7prLlI=;
        b=R5K6GyjX+iLYs0P5HihM+TzlgjvACHbLipZMlXtCAId19rgK8awrrCW79XBXy41QtY
         qSpqyluRe+2syiP0I2v2SfOD59sPO7yXq4wLvhacGQqvy7ya3C4RWmTlj3jsO1npyS6J
         fG4AFckZboTZBsO1uvus8P0TcgWJGKirbHD89bKV5PRz79wjDpnudZBLESa1FR92BPwv
         /t/7KsoS6aZDHUI+bzZHyLyEBSqgwTAj14jYgFl+HXda0+jz7BwpVSYWJ5LtPM0sDoeB
         m1+nFOgKDx4JEb9AVsbODC7EhR0LxkbnatH/nnzut+C/AsvaHmaVHRBUnM3w0WRkrFuK
         X74g==
X-Gm-Message-State: AOUpUlEXMeSO2HV0YG393a3h/lbrqR5atDYXQ5eArFw84Qmo39mAx2fC
        RrY3lV2jLjOKXnE280TQcW8qGIK99mMvTS9D83cp
X-Google-Smtp-Source: AAOMgpd0odTbmTo/cmCIcAqoeIiFISj/bTrwLM5CrR7wDDLZAT4Iozh2sOMBRTAS/Vlakr90Nj4tVRpWFCe+gJk2BC4=
X-Received: by 2002:a19:e955:: with SMTP id g82-v6mr2436668lfh.44.1532125718406;
 Fri, 20 Jul 2018 15:28:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:5518:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 15:28:38
 -0700 (PDT)
From:   Urja Rannikko <urjaman@gmail.com>
Date:   Sat, 21 Jul 2018 01:28:38 +0300
Message-ID: <CAPCnQJn8bC6TX5-xL1+yNGmSPOnpPxydAYMhFyCxqwofD6Zx1Q@mail.gmail.com>
Subject: RFC on OTi-2108 USB Data Link cable driver implementation
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This device presents itself as an USB CD Drive, and extends that
"metaphor" (kinda) to how it transfers data (= ethernet frames in our
case) between hosts. That is one SCSI vendor command (0xD8) over
bulk-only mass-storage is used to poll whether data is available and
another one (0xD9) is used to transfer the data. Yes, this is not good
but the hardware is what it is.

The question is, if i were to implement a driver for this, which is
the better option:
1) Make a driver that (ab)uses the kernel SCSI and usb mass storage
drivers to do the transfers.
or
2) Make a driver that contains a minimal set of usb mass storage bulk
transfer code to do what is needed for this device.

If you answer 1, I'd like to know the appropriate API layer to hook
into, and how to probe for the device and such...

Second case is in many ways much simpler (though I'm not sure if i
need to detach the mass storage driver from the device in some way),
but duplicates some amount of code.

Please CC me in any replies to this thread.

Extra context information:
I bought this device for cheap expecting it to work as an usb network
cable in linux. It doesn't, but if i have the spare cycles i might
just make it happen. I found a driver online for windows 7 that makes
it present the cable as a "virtual" network card, and I was able to
capture usb traces from that already. The usb ID is 0ea0:2108, though
the windows driver also supports some other OTi host-to-host chips
(like the apparently newer 2208) so maybe one day a linux driver might
too...

-- 
Urja Rannikko
