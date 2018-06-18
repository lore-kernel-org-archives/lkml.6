Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AC8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C0F208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pms6wj3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C0F208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934623AbeFRQhP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:37:15 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46856 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755306AbeFRQhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:37:13 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so9315756pld.13;
        Mon, 18 Jun 2018 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AAwVr97IXUAADIcsBUErozuSYjldtJhwtlCzpdzWZ0s=;
        b=pms6wj3gkF3wxBjAP4ri38iNaQfjtUZw/tKlr5qIWfV89+iGHtlXygaBxoXcIMji5s
         dTapCtNSQ8bKFS3rI4tXrmzVTQA9PfE4MJgezCJocWn37ClA5fKUydN4zAJJesnvDRkT
         Xtxk+ozZhhNkMoBvPRH6dEQtB4qzkjr7BGQF6/7vc+KztXK4+bvHaQC/mgAlnTtw5i2a
         LHEwYmeMbCpd9Z/9FwJx28twkwP9160DAatCdwckRCI+Ty6A1cmcLXD57+BO5MhgIANY
         Mn3/4GBedFxxCZCrOqwnP/T+3QobLzkt0R8vecbJkXibDLDjBk3xhxKL2skraDRJTa01
         /tQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AAwVr97IXUAADIcsBUErozuSYjldtJhwtlCzpdzWZ0s=;
        b=Ftz2am5+YULr7/KeX3ZB8+cx+3aGqcTijsrzL6nZtDjTgLKkW3CaqyJylJNFe5PNAz
         P7VkFceB1E8lu2OWbeCa6TbClpnRrbQGWxlsoN6kA+4xIs01jc/6zBGSgaRiba/eeZys
         7WdPx3bOseYLT/cpIFVp+Myz1F0rYmEMWeGJ4gAJvk05DdGnZr1l+7QIxcnqkFKwSkgJ
         yB1lpdseGvuAAwEsbDJMG8q/E7qsQ0RPZbcB6vCLyDgxrWqpyw4CsiAsvOvB9fQ+GKF4
         lnw7wzduoL5zBEPgSmKRQ0vX5W9//o/3DCV4YtzRqAIq8CgfNuBtzNco9kyHVKjYyNJC
         PkNQ==
X-Gm-Message-State: APt69E0MfFrJW2F9le2nzWsj1R/0zIZM+XeIdsKWN2CEgFYS5Cw6W4bZ
        v/NLDqP+vx2XaP7DZnVGi+I=
X-Google-Smtp-Source: ADUXVKK3OCUgeSFamENntedryKKiyXOBBw6E3EyxqCN2+E39WgX8vRalWh8OmLsicfn7EuY+kS2dtw==
X-Received: by 2002:a17:902:7686:: with SMTP id m6-v6mr15024420pll.340.1529339832994;
        Mon, 18 Jun 2018 09:37:12 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id g80-v6sm33460704pfd.21.2018.06.18.09.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 09:37:11 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ARM: dts: HR2: Fix interrupt types for i2c and PCIe
Date:   Mon, 18 Jun 2018 09:37:10 -0700
Message-Id: <20180618163710.27207-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180611224714.7007-4-f.fainelli@gmail.com>
References: <20180611224714.7007-1-f.fainelli@gmail.com> <20180611224714.7007-4-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2018 15:47:14 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The i2c and PCIe controllers had an incorrect type which should have
> been set to IRQ_TYPE_LEVEL_HIGH, fix that.
> 
> Fixes: b9099ec754b5 ("ARM: dts: Add Broadcom Hurricane 2 DTS include file")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/fixes, thanks!
--
Florian
