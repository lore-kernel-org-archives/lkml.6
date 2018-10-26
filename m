Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875E6ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9DA2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW5wfNi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9DA2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeJ0DmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:42:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34752 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbeJ0DmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:42:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id z2-v6so2472141qts.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lbOtJ+IXTmF0J4dzVxEShHiifrkDS0lzDb1R83v1wrE=;
        b=HW5wfNi31M6tS0Cpdyd9A3yrqmghKzZHmymENyM6pWIbGiyVUNDtWlJ9g1/tP6+KF+
         4RQopEqZaz1KamdvkcxbcWo9HAK4fd9NXRd+pN+ZYrNK2p1EijPQ48YBC6t3X0lLSDrM
         Q1xFqzuXAl1kz/BoncfwGpsoH2mSFwMHXO/NKfwk/DXok73d6p7lbImeQtHGO+E8rfg/
         9OegMV/IrhQcUFHGCAiJVl1iotLGTQ5IUiV0VSDhec8+5+rKqetZF5W4+plhhssXijkv
         UV5Y+HOIBeR3rPuOos+KqWf8CkyHop9GdjxMbeM0p1aVsNinU1u/F3N9H9GPpOe4i7fr
         hsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lbOtJ+IXTmF0J4dzVxEShHiifrkDS0lzDb1R83v1wrE=;
        b=uAu2nWGQmZdBtbHxY47w08CVFOZIULzLUKVRzgsqpfSpbT0YXf6gV0IbwlHhN6oS+v
         XI7L0wxubMGQL8PUeOCzyI3dV6dxeJR+FR5mtRxztPQtoHEYXjAdZYANbYywPOFvzjfN
         5eR9liOyTZxmosJYST5mHRfwclIDpbpmijZPPQqJZL21ehKmSMXwFSwSZiWx3Mhw/GuD
         ab9EX+nU4TZqAB8zy/uRefF064ZMDSCgtToBLWGQdP5+LETK7lZcV9Vq2RQkiqqq7lrX
         hAs/dibSzzPJyXlD5Xw55e5rMaRinL6cEU3aQDligXVZk5CLXGnSzFWtsqAl27UA55Z7
         5Yew==
X-Gm-Message-State: AGRZ1gIjkibj21dU3CYXZWATi3k/yCDJPgFQ4gL0FS8ytSE0dpYVnRt2
        g6CcEIhepBQIS8x8PjhRKCw=
X-Google-Smtp-Source: AJdET5fFUaYLkNHJ4hQzPeFh2nHMKjgU8b1DLPNPIHpGnJEsaZ+RbcRdr4K1RDDpApB9cMoPrRPf0w==
X-Received: by 2002:a0c:98a6:: with SMTP id f35mr4291203qvd.224.1540580633136;
        Fri, 26 Oct 2018 12:03:53 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id u13-v6sm10677197qtu.90.2018.10.26.12.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 12:03:52 -0700 (PDT)
Date:   Fri, 26 Oct 2018 16:03:48 -0300
From:   Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [RESEND PATCH 0/2] staging: vboxvideo: Remove chekpatch issues
Message-ID: <cover.1540580493.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans the following checkpatch.pl issues:

CHECK: Prefer kernel type 'u32' over 'uint32_t'
CHECK: Avoid using bool structure members because of possible alignment issues

Shayenne da Luz Moura (2):
  staging: vboxvideo: Change uint32_t to u32
  staging: vboxvideo: Use unsigned int instead bool

 drivers/staging/vboxvideo/vbox_drv.h        | 14 +++++++-------
 drivers/staging/vboxvideo/vbox_mode.c       |  2 +-
 drivers/staging/vboxvideo/vboxvideo_guest.h |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.19.1

