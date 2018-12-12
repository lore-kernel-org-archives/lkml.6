Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D687BC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2E120839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QobLlQf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2E120839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeLLM2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:28:05 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:36552 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727155AbeLLM2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:28:05 -0500
Received: by mail-lf1-f52.google.com with SMTP id a16so13391575lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 04:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=aT9nxty3TM86li7NiJ79pWPOjhxTxj/YelOjTEDq83w=;
        b=QobLlQf9oYvejh/veq9vhaZmcML3aC6xyCQhCxKYfYXHwkQ+bNxM7kgVtliSwAErcP
         axq8C3y/YYX/Z47j25CPopwyC6qj8A4fXf67dG66+iOBe7FgvLDR+Kv6QDQLZ4KUNELT
         6HjU7d4SiKwdZx/JIa1EtbjQxfo8GrroZhu84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aT9nxty3TM86li7NiJ79pWPOjhxTxj/YelOjTEDq83w=;
        b=dsGwHRTL/GRvYKOu2SF/ZNC4X8+zg0at4ku/vBw3nIRx1llo0E1becwInONgPHOqaa
         bxbFQ1htcNX7W3fdycKBlZG3oG3Gm4L8EjBhtpmnfB0W+mx+C0BV0Om/RyXOdCMO9BKW
         49OTBS/a98b33AvvFI0a/oxRwZ6BOSY/N/R/eMLo9rYfXc//HvbCZ5F2BQyKBr1zGjtS
         H9IzzojOuO0kxosSuSWgIkifH74Z7mGZ1+4fyX2cwjmBwGlvsZOC8jWyJHrNoYuagXQq
         3ZvTgJHnf6qxPTT7bDjyNPfPoh5WNMty/iYi3Q+D/QdiTIJaYXNTVcN0KtO6cjN6QKgr
         4lmQ==
X-Gm-Message-State: AA+aEWZyZ5UELggHnXfzeULdMF/sLOnbkLVLSd8Dh6VSZnsIv0wUmWE2
        Muvok5HiqGl8p5JW12AVVKG6oQ==
X-Google-Smtp-Source: AFSGD/VU6amgqRzpZG3A6RG4hwYSFTHnoZk+EsH31/yYQBl1iZP3YkcJaDjk5o44zXXBQBmBw0GbKA==
X-Received: by 2002:ac2:4215:: with SMTP id y21mr11573166lfh.6.1544617683123;
        Wed, 12 Dec 2018 04:28:03 -0800 (PST)
Received: from jax.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t19-v6sm3258901lje.23.2018.12.12.04.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 04:28:02 -0800 (PST)
Date:   Wed, 12 Dec 2018 13:28:00 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm-soc <arm@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: [GIT PULL] tee driver fix for v4.21
Message-ID: <20181212122800.GA29450@jax.ideon.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this tee driver fix for a possible double list_del() in the
OP-TEE driver while uninitializing.

Thanks,
Jens

The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-subsys-fix-for-4.21

for you to fetch changes up to b2d102bd0146d9eb1fa630ca0cd19a15ef2f74c8:

  tee: optee: avoid possible double list_del() (2018-12-11 14:38:21 +0100)

----------------------------------------------------------------
Avoid possible double list_del in supplicant comms

A fix for the OP-TEE driver to avoid possible double list_del during
tee-supplicant communication while the system is shutting down.

----------------------------------------------------------------
Zhizhou Zhang (1):
      tee: optee: avoid possible double list_del()

 drivers/tee/optee/supp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)
