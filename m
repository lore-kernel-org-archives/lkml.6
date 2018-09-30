Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7EBC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 12:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5942820833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 12:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW5UNdZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5942820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeI3TCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 15:02:35 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37221 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbeI3TCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 15:02:35 -0400
Received: by mail-lf1-f65.google.com with SMTP id a82-v6so7926269lfa.4;
        Sun, 30 Sep 2018 05:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rwM6siGlnXw0HunceZKOw9UWFhhGj2GaYu1P0MCM0e4=;
        b=DW5UNdZS1sOLZltMDSpYC1b1+h5yMIAwMkxZhfxFbDZRiubbQZf9xBPl3PXxMhdKYA
         MTb84hsZKaakGila+pVQUPxTIvPUfWyFc/w8DhQlXYext2NCkm5FUb7kpdWQBwHlX8Ep
         fdS+e1TNZL4sKHyoAunt06UQ2QFPfztiohwNyUmoJBHLcVZdtIj5jJjC6BYIgE7yCDRE
         KRQ3NPaByDNkC3NHm3Oi2E94sMwB45MLdlcQlM0cwaroPCs1x2D+mk9RJwmJyLkGrmOD
         gWny4nrm2fYG+C+ed/4mKgfscVkVSRGKfMLXAk0kofj0q+aJdwsYvH1qSRcTXtZgJkJR
         vaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=rwM6siGlnXw0HunceZKOw9UWFhhGj2GaYu1P0MCM0e4=;
        b=eb9hQmfjfOqiGnKFfeSo/6oOizEA8xMKrrx4BWelgBSKvpLcobAKPFkrnHp9Nfa/cS
         JYEwQjJ2C+0Tlg3PV74Arb4Ztfbsp0DJ33X7AieigL23Q8fLaTvKcfrwq0m+hmOcwsH7
         nfSHBe5Auzwq562QejytbbCeOY4SJYZUZX5kH35D9xQUuQtopnWvDR+BDdoSEE7N1jaW
         0KHW5fHOrgFMolAElhGT23QJPXcdJ1hJoM0wxMmIfnwLfBK7h10IEiN70Kj39CmIc4CI
         /Dev7LMlz6cnZ0lhkH+QWlDVmK8BWTGWfQPJLzvyp7yYtlFvtvHBMybrnTpWa9TzZqga
         fkiQ==
X-Gm-Message-State: ABuFfojGAvGxU4KiQD0JeraYFJrQQlvKG0XquxAkIyzAByJ2/emMNkzE
        FbRvvHS3Ls2TJ/X1uvjYeCJRPwWv
X-Google-Smtp-Source: ACcGV61w2HTe62FxhXH2v+z7L42ql06q0FnqbUrJDh3rW+jLIM8LWeWGdDGup2XAf9phQWF4pMARRw==
X-Received: by 2002:a19:18e3:: with SMTP id 96-v6mr3426951lfy.133.1538310583134;
        Sun, 30 Sep 2018 05:29:43 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id i186-v6sm2036148lfe.41.2018.09.30.05.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 05:29:42 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1g6aqz-0001sL-5I; Sun, 30 Sep 2018 14:29:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Karoly Pados <pados@pados.hu>,
        Loic Poulain <loic.poulain@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] USB: serial: gpio line-name fix and FT232R CBUS gpio support
Date:   Sun, 30 Sep 2018 14:27:01 +0200
Message-Id: <20180930122703.7115-1-johan@kernel.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out gpiolib still doesn't like having non-unique line names, so
drop the line names from the recently added FTX cbus gpio
implementation before adding support also for FT232R.

Linus, we finally got around to adding gpio support for FTDI devices;
see commit 

	ba93cc7da896 ("USB: serial: ftdi_sio: implement GPIO support for FT-X devices")
	
in my usb-next branch (and linux-next).

The gpiolib warnings and inability to use the legacy sysfs interface
prevents us from setting the line names however as someone is bound to
plugin more than one of these devices at some point. I think we
discussed this issue with the name space and hotpluggable devices a few
years ago, but looks like this topic may need to be revisited.

Thanks,
Johan


Johan Hovold (2):
  USB: serial: ftdi_sio: fix gpio name collisions
  USB: serial: ftdi_sio: add support for FT232R CBUS gpios

 drivers/usb/serial/ftdi_sio.c | 45 +++++++++++++++++++++++++++++------
 drivers/usb/serial/ftdi_sio.h |  3 ++-
 2 files changed, 40 insertions(+), 8 deletions(-)

-- 
2.19.0

