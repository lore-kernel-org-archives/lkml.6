Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D73C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBADB2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvb/YqNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBADB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388052AbeKFEfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:35:41 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34410 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbeKFEfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:35:41 -0500
Received: by mail-qk1-f195.google.com with SMTP id a132so16887139qkg.1;
        Mon, 05 Nov 2018 11:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=H71BdfX3Eth0WEverzxdSWsLeCQ/VsuhCCtWA979mR0=;
        b=Gvb/YqNzWfcrH+jdhV6/VRVPsnhSO6dbSBo786+GfSrzS/eSTl5grb+K7NBzw1BLOP
         EeqKMtzh8XPSPf8+CWKN6kGGu7yx14NlrUuFsjPAO7dEBMNhTslJwpBxvNWhSbVkRWdY
         T5znw9fbkHZ0CgvsJXNi/CBj3rVpFb4srQwLgiP1YaH1m1TMgpyrvFuwsiXpQMikbSfJ
         NCtIvsVCc/0BQCEtMhoP5w3GbgTZzAEl5WvL/9QOERz4USOBkQTDlnjMejgH4mJCFtts
         5PoX3zeEVvhslYrhCSZKHmcZTdPfqTiW1SwuFHM8c8zhcLm7MGCBIolp2PzBN9TAQDJH
         TAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=H71BdfX3Eth0WEverzxdSWsLeCQ/VsuhCCtWA979mR0=;
        b=t/GYZKpQvtmWbavzNbRmTTNnY+IoUkhj3wBg20eaZ2alcaXWGqMUN9sq1aPzGbwk1A
         usdrmoZt/yM7cSx30vryqV3Q04YSub50Vd4J5mT5wvnB9UGmGW5HykXQi67gMa1HEPZe
         U1sQ2SG8wJj9Gm95msE5CFbYN/hRXiItsq2rBTVH1ubPR5oq1T/fDMmGK7hTcOU0sqhJ
         doiN6BIL/qpCPDQCVGg9qdZv/KNHbO5FVF3KVOZI2i626lg7xD69HqvQVcPRi5aq8mGc
         X+CCrwqGC0rDu49DaBjVpyAjIPpxaVT4UiJlcO13trRgwBOElyxJVi79HMUaok9m4vsM
         F/lg==
X-Gm-Message-State: AGRZ1gJb+MLUbrdz5diVZ1FHETZ5qY3oCfQjzd23a98iDYg8GQL59Esk
        ydyuXeqqj1mbXEI3hz09zNk=
X-Google-Smtp-Source: AJdET5fe4281rqtVk/m582/nb8fEn8DpXjhOF/og/1XZgU4oXOundFD5ViMYYzFqwAqzgGQdOKJZGw==
X-Received: by 2002:a37:17df:: with SMTP id 92mr22436807qkx.191.1541445273922;
        Mon, 05 Nov 2018 11:14:33 -0800 (PST)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id q14-v6sm9424743qtl.65.2018.11.05.11.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 11:14:33 -0800 (PST)
Date:   Mon, 5 Nov 2018 17:14:28 -0200
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        giuliano.belinassi@usp.br
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v4 0/2] staging: iio: ad7780: correct driver read
Message-ID: <cover.1541444377.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this series is to correct an issue in the driver's raw
read function and remove an unnecessary struct field.

Changelog:
*v2
	- separated original patch into two patches
	  (https://marc.info/?l=linux-iio&m=154047435605492)
*v3
	- reordered patches so that fixes go first
	- removed unnecessary initialization
	- removed unnecessary voltage field variable
	- dropped reading voltage on probe
	- returns -EINVAL error on null voltage
*v4
	- removed voltage reading from probe
	- fixed voltage error handling

Renato Lui Geh (2):
  staging: iio: ad7780: update voltage on read
  staging: iio: ad7780: remove unnecessary stashed voltage value

 drivers/staging/iio/adc/ad7780.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

-- 
2.19.1

