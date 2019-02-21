Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA464C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722EE2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHeu+mJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfBUEoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 23:44:06 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42119 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfBUEoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 23:44:06 -0500
Received: by mail-yw1-f68.google.com with SMTP id v201so10151353ywa.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 20:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sQCAaHlqbDX+k813H6leUq1oyhBh/3RZdlfTBRr/fwE=;
        b=MHeu+mJ8dVPXs6coXTfLX06c4cD3afe5wC2UIhHwp7X5IpaSEu/C0uRLll0G3Y8aIM
         vXzeLQ4II2Cmt5QGrzzCD+LDl8drOkwC2bjSrls9CqU30rRB7oEHv5KKdSp7UFTcAuhz
         vZSqbe/W34Zuk/bxfMWxjAgM04WogqjbSr6VJ0+/MCJH1Bplfu9vT/yGr+UcWvdGkS/X
         YreuW6qbWjqgHq69hEZsdFfvXDWHepZ7L6xn8+9S9rZekGrpWJ+rlInZLMpZhl7g9ivX
         LOodb1P/uwrZZ0DgPmEJZKdL/+suTfJdh1CldHu6fvsXeBKDFmOzRA+lmXGmitoPvfPL
         OZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sQCAaHlqbDX+k813H6leUq1oyhBh/3RZdlfTBRr/fwE=;
        b=JfWz2RVn3N0FPZRFPBpNKp/jBbUUY8v3f8qKckp5K+T7WbieDi0ppEHFHTbEddZXes
         ZxH6l21y3826zioISjAMm0ph9ptzCKT+dHcpaEFWAX9+BO9BrtNKG2DFV3LXTxm79ZeS
         jZOaV1uyw/ZrL8CnrjY2cq5sJ/MJsdy1uxlQ3Co0gy/vCReMMLy0mCkPE36hFsYhfqh7
         ldiQojVelEv0YpBDO+5m1DK72LrHvPKyIcIO1ymRD2hFml7nHHl8n+c7wEdvE6LSdUwj
         9SLEYlYMoY3IXDzlVf3ApQt5eC9wbDVGPQOMXo3rTBKjBmK4Qs5PE7BbkPrPnRbWr/BU
         2MBQ==
X-Gm-Message-State: AHQUAuaBVKSFrKIuOp9S5xghH2oLzsrCMNAQn4EpgkivCWsDYJFH932f
        9fIsKlOR1XOtmzyREopZXhl0lRJM/ygFqQF7qTiAeMk=
X-Google-Smtp-Source: AHgI3IYc0UfLQ4h4qq+upYFPF0cLQGC2I+aI2EbzZGX4Ecrs5oli9rpUtyOXkECEZwA3SdvG7tukVfD4YvTAy8NQ7zA=
X-Received: by 2002:a0d:c6c6:: with SMTP id i189mr30853456ywd.12.1550724245036;
 Wed, 20 Feb 2019 20:44:05 -0800 (PST)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Date:   Thu, 21 Feb 2019 12:43:36 +0800
Message-ID: <CANnei0Ef7gC6PdAbZA57oqYK1cCbLGid3G9QDkDeiFPbSEYsYQ@mail.gmail.com>
Subject: What are the new features of Linux Kernel 5.0-rc7?
To:     linux-kernel@vger.kernel.org
Cc:     Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon from Singapore,

What are the new features of Linux Kernel 5.0-rc7?

Thank you.

===BEGIN EMAIL SIGNATURE===

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

===END EMAIL SIGNATURE===
