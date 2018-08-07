Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC48C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8F22172B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ABc7baqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8F22172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389956AbeHGV5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:57:25 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:38620 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389192AbeHGV5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:57:25 -0400
Received: by mail-pf1-f173.google.com with SMTP id x17-v6so9075028pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 12:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:cc:from:to;
        bh=q1/s7tTspEYOwI8405ndrJAUoK1yIMgOaKpAUd1Ek2M=;
        b=ABc7baqcvX09Rc7tj4VKGQu1q5ZWWf9I1bMRGVAnHMhA6sECzEN8YC/NJUrJahiJQx
         j2/2dbcA+FBXT5eSoioBHhUcr38QKZcdCnV3OW5GzA7v0CH6SipWL9ksCONMUPIR4m8w
         dq3faUESo3zCXYJ9bvmp92yTjG/wWj6ynVfdujrva/fDMWb8cem4EUuSN2e515OFQWGt
         OHkNQvtMbeDfyprOUC/3uxh4lfLqnbbib5C3+Wm+qP9tNyAykusop8TluRPf6kNen9cg
         z+IRIU38n2liaFj3Oc718cQ++jN0a/hrnx/PRICb8LsPVu95LiTnxFocIW0Bw3XTZQS8
         SoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:cc:from:to;
        bh=q1/s7tTspEYOwI8405ndrJAUoK1yIMgOaKpAUd1Ek2M=;
        b=ufIrr4AzqXVFqVJdIlarDLxW202P3a+QiKew0stMKUZv02Lw+EjMMbkbs9R57mNttK
         S9v2pJ5Wn9jOfDYub1ESTjXrGv2rD4k6demfW1X46+N+e5kuCjOyz93omP58u4bzbMiG
         bnawQZPgWxJXeZu+ZWpE9ZhgIVl3DUTNd20qR1oxl9DD6MdrBQ3dIcyQvQTrna4KnOqO
         aikNpagO0oACviaUIJuRMhT49BvCym8KwZZ6vWj9LC9Fi1WKckWvU4UEa69Bx8BaCigQ
         LNvbYD8JrHuCzmaFM7KAJjYA9+YaMD7S7Csn0+l/3DUsefRMbDO0Jvu5lQNONQiUIJkr
         gB/Q==
X-Gm-Message-State: AOUpUlE9+reMntQYztXepYSi+pHPTd3VGgUGxQTV0R+p3iJxk0dmx2aG
        gFSkVgjrnAsRjqx/1BaPF5F1Qg==
X-Google-Smtp-Source: AAOMgpeodRc9MJbFUCxdDoZ1BOG1/Dh1GDO2Fic48NuQ3NZMc7VYIlabZgub/zOsfOWF7UXmcgo5NQ==
X-Received: by 2002:a63:9802:: with SMTP id q2-v6mr19717940pgd.70.1533670889659;
        Tue, 07 Aug 2018 12:41:29 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id b64-v6sm3216569pfg.66.2018.08.07.12.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 12:41:28 -0700 (PDT)
Subject: [PATCH v2 0/2] spi-nor: add support for is25wp256
Date:   Tue,  7 Aug 2018 12:40:57 -0700
Message-Id: <20180807194059.26348-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     marek.vasut@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the is25wp256 flash chip, which is on our HiFive
Unleashed board.  Additionally it adds support for ISSI's special
unlocking scheme, which we need to unlock block protection on the whole
chip.

Changes since v1 [<20180804014947.24601-1-palmer@sifive.com>]:
* There are now two patches, as it's logically two separate changes.
* The chip is called is25wp256 instead of is25wp256d, with the
  corresponding commit text also renamed.
* The block size has been changed to match the other similar chips that
  are already supported.
* SPI_NOR_4B_OPCODES is no longer set, to match the other similar chips
  that are are already supported.

[PATCH v2 1/2] spi-nor: add support for ISSI's block unlocking scheme
[PATCH v2 2/2] spi-nor: add support for is25wp256
