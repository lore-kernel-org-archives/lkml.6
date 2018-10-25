Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29135C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46A220824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2cKojgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46A220824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeJZHEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:04:06 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42776 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeJZHEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:04:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id j46-v6so11879684qtc.9;
        Thu, 25 Oct 2018 15:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nrc3g8DrXcNnoBqjIfieJXpj2mZykUYiyJS5+x7yUHg=;
        b=e2cKojgZbpqbEyXmP2xp0DPUq/gs50bGCYpa43s5dvePDQexhu3M7Vm1wPIiE71vKZ
         qNVwVl2BfDO71jbfXWoyyB7nXpL0we2B0JqxiF9dSQcoqYoHK6akEgtmgUH9ZuqG+7c3
         YRT+uqDBnRYy3jg45YRHvuIVyHUXI74kkxQhSNqtDUJ+sDmZTT3OeDhhNzdTB3abkhbb
         YVYTBz7okzIY+5l47+/sy142m1BKprwsY2R2NISPxDPC+yt5RFK+JApOJvW8u2nZf/QT
         CnaqTbUzDxUMGxEFt1fsRziTuAHNrRVdeWVLK27Gl1LgN0r0zsAM8VSxYdOABtUdVtXk
         j4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nrc3g8DrXcNnoBqjIfieJXpj2mZykUYiyJS5+x7yUHg=;
        b=AnOkOMYrXG+pruNBclUYOA1RuLQ+tgjVpWNZffTikE/SusG+3lJLbsYfZ1A31xtwP1
         pWfKgUg+08m64ArbP+Vr7EYfOEFkzI8z8vuY+u5X7frarIDolkUE39WaxvqCg4ynP0Jl
         AoRxTlzIg9uHBa9ny9P2ZqEqLeO0io1IoI89pXINMPTaJv333l05aVqSBpHZcJhxZNrz
         diUqXSS3zVlsNvLOTu+V0NxKJ9CAWev3kvPU+rTrT02yg2M+g3aeU5Wl8qn0+E8a6REU
         zEVUvKLiD6An4juKc5AaczcbK6kaWSsqIu5P0b/Fcpdzvj7ytQGScNlmQtOpTGhupO1P
         mvaw==
X-Gm-Message-State: AGRZ1gJ3dBeBDdxVB0XDrDlroNjRJte202B9h3Z4z3Tsts/7mFmcXbsR
        IVQs3/K9/nFp8t+R6PYA0w8=
X-Google-Smtp-Source: AJdET5fLHOJsvYZ47yl9O3m8dJCgonNiWMJCU+pqHItOglGT5OnyHsQP/GtiO2kdL47tErbcmlmo+Q==
X-Received: by 2002:a0c:8ae3:: with SMTP id 32mr1046617qvw.27.1540506576975;
        Thu, 25 Oct 2018 15:29:36 -0700 (PDT)
Received: from renatolg ([186.220.20.163])
        by smtp.gmail.com with ESMTPSA id k1-v6sm6247688qte.76.2018.10.25.15.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 15:29:36 -0700 (PDT)
Date:   Thu, 25 Oct 2018 19:29:31 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        alexandru.Ardelean@analog.com, stefan.popa@analog.com,
        giuliano.belinassi@usp.br
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 0/2] staging: iio: ad7780: correct driver read
Message-ID: <cover.1540506298.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this series is to correct two issues in the driver's raw
read function.

Changelog:
* v2
	- separated original patch into two patches
	  (https://marc.info/?l=linux-iio&m=154047435605492)

Renato Lui Geh (2):
  staging: iio: ad7780: update voltage on read
  staging: iio: ad7780: fix offset read value

 drivers/staging/iio/adc/ad7780.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.19.1

