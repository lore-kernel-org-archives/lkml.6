Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AF6C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C17620020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciGW6Emb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C17620020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934880AbeFRQhX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:37:23 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37017 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934667AbeFRQhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:37:20 -0400
Received: by mail-pl0-f68.google.com with SMTP id 31-v6so9328578plc.4;
        Mon, 18 Jun 2018 09:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aHHyHZ44vfmsVCV3V+H+lKRkUSI/2JhJ7fMLmAkLN3k=;
        b=ciGW6EmbHkgIMhFpgsX3UDrZOQBbFDPayG11nUDTxZ6WK3KOIHW8WC1Miu4RZLqd5P
         rdM5q9jIFUIjjjtEUQ+ve2dsBIUMOVjdHnR6wrCjkVqlZFJBaYeJzwUrFdzEqtISXth7
         dFeFY0Eu7/aRBBxnBBFhjHxBW3Dw5yJAqwIYNttY90hlj8eJnamacGWGVl4aXpKfF9Ul
         wgeirRrWvTWN+MRXrmKuSjv7vJpIB6kLQaAfjwCuRdx1GXCVw3iQ5JbcG2msdaIfWs30
         I5bAySW9v+zeKMziWRkx4HKk384/iqmUbd+XOPeYhdVpxeNK0wZ4fwOtomsXT4ByGvA0
         QuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aHHyHZ44vfmsVCV3V+H+lKRkUSI/2JhJ7fMLmAkLN3k=;
        b=sv+83DiXYcw6e4dvA76e0Tu3ARddbGynvs+6BnaPYgHRwPaQ8Mp8EOE+zciHdaSO+/
         YviHdsvBGyW+OCsEcFCFjch1NuFNv1V06xpdxNfXW9YzQLgPF4YfT/H93KASfwycl2+i
         ZPcMWyCNOoaRZvTqXLCWlbB0G5WUsI81nCGmMDI8j/h1HhFET/zVh3O90V+5cQrQ/Mqj
         gLiaPAf+8xzBS5eXREOVCRhMn+R+Rv6UYJiWgb0NxZyGEu7x3O6XV5gZ3dVLxCWgdK7u
         U6/Qk5/5bkfI0ookip3lvY5ZpQvP9w/udoZYVIvi/7okvrYRpXkqfBDoTN2Gq6mrBOGu
         BFBg==
X-Gm-Message-State: APt69E0nDHNZcx/7SzCpj/+RUPD0nlxZjTK+bPzQByAn4RjoI11deGRn
        wcocuDVtPtSPZ2IhXo3TWDs=
X-Google-Smtp-Source: ADUXVKKujOOfOnE2zsLuEEqG0alF+pfubN+2QV/fO2B6c1CUiom/uWaKN7hnnhi2rrOidaF64+0CWw==
X-Received: by 2002:a17:902:7688:: with SMTP id m8-v6mr14719718pll.54.1529339839840;
        Mon, 18 Jun 2018 09:37:19 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id a11-v6sm19186157pgq.32.2018.06.18.09.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 09:37:18 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@infradead.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        Jon Mason <jonmason@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:BROADCOM BCM5301X ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: BCM5301x: Fix i2c controller interrupt type
Date:   Mon, 18 Jun 2018 09:37:17 -0700
Message-Id: <20180618163717.27294-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180611225340.12733-1-f.fainelli@gmail.com>
References: <20180611225340.12733-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2018 15:53:40 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The i2c controller should be using IRQ_TYPE_LEVEL_HIGH, fix that.
> 
> Fixes: bb097e3e0045 ("ARM: dts: BCM5301X: Add I2C support to the DT")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/fixes, thanks!
--
Florian
