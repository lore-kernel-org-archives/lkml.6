Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354E2C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA11204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="o2IPC9I8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA11204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeJZJUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 05:20:15 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:40013 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeJZJUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 05:20:15 -0400
Received: by mail-qt1-f181.google.com with SMTP id z9-v6so12185327qto.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 17:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=zTiUeMyWQxrOl0Lg+fdlflDp1Wi1dfv/1GT9s6EKWVM=;
        b=o2IPC9I8I7d9C+7igGSg/PbD2lJE0KxakEYJ3Jdj+7VxL7RJokPf0Wk5KLNe+nz93P
         k4ARr7mm8hL3rxt9gwdlc3bXyaCfQqjc1ka1MHP+mah0xhO6O5lG6P9dQ62Xm+rpEkOz
         rOC3qrQQgfdhrcxAKK6pQ/cXU732YoKRPGdZXCDZFRjHcWRqNsnC/mKbZsFsZ7FDTyid
         TcTI1z+FfS2xJMxZwP7nDLS09fsMp7zlb3v3r3M+lvVvoND6+njA/IRcF1U4FGznEn6V
         GYWg/wQGIW8O8XC8I/y3kie+pQrszPAT7HwBlk4YZ4K+eqhbBXvZqgwDL2WYMlPEXgTb
         ZAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zTiUeMyWQxrOl0Lg+fdlflDp1Wi1dfv/1GT9s6EKWVM=;
        b=lLFu8oyMl7EZ6FUHHgU0Uznjc6QS/TOYzjt84aL4426sd5tEsJGoxvn4TRjcshnBIN
         fgJ+ddoXg/8GiLIB0pTUqbwqnm6vIn/T/G2qAJuVyLb9/gk7FuRVfowXETxOPbpv9D5S
         NqTZ58RBUgKdcnSAPO9hBF649ipu6H8gwS/qgH3JW3vxc0IQBko3OEGYXUhMCfzV/gqQ
         UAjP+BmiGjEV3vCEbQ8TJ3Mneu/mehi1/mqElLp4CletnVoIoXIvNDL1yKj5NykUdlba
         92H8fpBZndtoWqfWW23YYxk1TIXmuH5y/q5kgc5tHMCPON+3uATLBCM0PTUpNjkCbCO2
         9x6A==
X-Gm-Message-State: AGRZ1gINTepi7AYsh9futQFcL+wSQ37WNetdin2ZY+0jvK4ZW3l2ZntR
        geuflwNXPwQY8kPMcWnj2r3Sfg==
X-Google-Smtp-Source: AJdET5eq/doiv+JylhnWXkt2Kv8djHNTRDV7v6kp/tgpQH2d/n06b/vrn8AnODmpw027+pUiDzrmCA==
X-Received: by 2002:ac8:1bf2:: with SMTP id m47-v6mr1342444qtk.239.1540514724184;
        Thu, 25 Oct 2018 17:45:24 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id y3-v6sm2371735qti.27.2018.10.25.17.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 17:45:23 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 0/6] staging:iio:ad2s90: Add scale info and improve error handling
Date:   Thu, 25 Oct 2018 21:45:06 -0300
Message-Id: <20181026004512.31012-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds scale info to ad2s90's single channel, improve
error handling in it's functions and fix a possible race condition
issue.

The goal with this patch set is to address the points discussed in the
mailing list in an effort to move ad2s90.c out of staging.

Matheus Tavares (5):
  staging:iio:ad2s90: Make read_raw return spi_read's error code
  staging:iio:ad2s90: Make probe handle spi_setup failure
  staging:iio:ad2s90: Remove always overwritten assignment
  staging:iio:ad2s90: Move device registration to the end of probe
  staging:iio:ad2s90: Check channel type at read_raw

Victor Colombo (1):
  staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to channel spec and
    read_raw

 drivers/staging/iio/resolver/ad2s90.c | 55 ++++++++++++++++++---------
 1 file changed, 37 insertions(+), 18 deletions(-)

-- 
2.18.0

