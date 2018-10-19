Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0118ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF4E21470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKEXJD1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF4E21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeJTBwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:52:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35272 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbeJTBwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:52:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id f8-v6so16180377plb.2;
        Fri, 19 Oct 2018 10:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HmnD9Dsm4rfbF9RC2IJmzYfmyKuI/iriI9K0KNb1CXk=;
        b=WKEXJD1sJpImCIYu/qLHSp1To99R/U20l95BmfFUCjYCRRs8iBsdIB/JT/PqfbPmVy
         1tPFqJv0/qK4E6GPrwsVC7V0RukPHwfSBKF3qYQ+ZBsRhhpfDdPctUxozLIhtWnNVpgq
         vGBDsbq1hPLbdeV1bXEyUniQ+WQ0oq2dzWbSOQvqy1K/v/Ut+xfb2YpBvjhzWwrgvsyS
         tkQKWP2xae3C0WnSwD7j9zjcxMASHvqD4tqsHP7nrP2gN20pXTxi2Ed1AXJKIH+yTQbU
         tFcwjZjVG9vHGx6DgCsLd7Kz8Q2gGisxUr0qnZs0QIoLofS6jrnkpHZl6mkwxNkXWJ48
         vULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HmnD9Dsm4rfbF9RC2IJmzYfmyKuI/iriI9K0KNb1CXk=;
        b=YhLwFNsHLMEEgqf7mNUOoJKqL2K+d9xKtUH7m86/cZCU1GKsZabI2fSzve5giEuFRw
         BJD+dSgdKmiuhanmlUtmEmfR//uyEpdurSII//EBOflQbkWCyWUa6l3WaLh5rF+s6P3g
         vNxJg+N25gBnZuZdUqJNulGAZACNzybfApD/oIwfKPfUIylKQHkmEs2+sNmPoegEt05q
         SrKxX7NCdEFpnvfN8uX/DT/dobTrIHRgNKJaYCBecrAwNTbL9t+UPYrq2/yVZQAKEctF
         byIVWcFBP5JbNovxXLZsM/g5CYE4KkivetikNdSV7lSVW4R0vrhUtrbfh3ZGsq6VpXNh
         R7cQ==
X-Gm-Message-State: ABuFfoizfrpQkJzreEV9T49AwD0mFIqYTbs48DEFzm2mG+rJRbzutEHJ
        hw+v1vyWWWc6Ai43WOvT6yU=
X-Google-Smtp-Source: ACcGV61Kx+bF8hv1eF3G5I65Pl0/RwCMqsLB9cdi/2p1ThQ94Ezou2q2EKZRT0VfiFORtQwrbxtMvQ==
X-Received: by 2002:a17:902:b611:: with SMTP id b17-v6mr34995981pls.217.1539971111745;
        Fri, 19 Oct 2018 10:45:11 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u79-v6sm37802422pfd.117.2018.10.19.10.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 10:45:10 -0700 (PDT)
Date:   Fri, 19 Oct 2018 10:45:08 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] Input updates for v4.19-rc8
Message-ID: <20181019174508.GA47209@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Just an addition to elan
touchpad driver ACPI table.

Changelog:
---------

Mikhail Nikiforov (1):
      Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15IGM

Diffstat:
--------

 drivers/input/mouse/elan_i2c_core.c | 1 +
 1 file changed, 1 insertion(+)

Thanks.


-- 
Dmitry
