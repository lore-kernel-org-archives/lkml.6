Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19ABC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F7D2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/u642o0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F7D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbeIRSiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:38:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40907 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbeIRSiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:38:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id s13-v6so1001331pfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 06:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=Q1c1Wa2kdYXudbIuhJcShlVaoPYzs6v27rWsjdAfcv0=;
        b=a/u642o0HU8F3utqUo3LZuyWFgMxpLHFfe10zd5FW2rB8sIBgId7IoCj+nV7aYOBtg
         mBQJYO//PJ+hChKVjdGauR1Tp/2w7c+AT86CMiUhIPlfkJ3Fm9hcM1nYm6W/ld680aVu
         hoq6HwvBEFq4lxneu+GhLb+MeU3kaoqicOy/hhrKCiFnUje9pOdVuumEkFY/dWod4dCU
         UHRpwLQaLhKWZIJaukYDGp2YzZLzTM6mauIDSuWsU6Dj3+mQJ6cAn73y4zZsUSJQpcki
         GiS85jr/sntD/NTQVhWkaT3rI4XvI/aF84+tWHa4cLzZecilGnulkJZUM99A0E06dUhp
         gY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Q1c1Wa2kdYXudbIuhJcShlVaoPYzs6v27rWsjdAfcv0=;
        b=n4Xfwur2uo0kV8CQQ218CeNPkU8BgG086Xq0hMzwtJKRMmpKzTIKdsIqrDFgTv8oo1
         afsseGtmM6LnIV8sItDCB193FqyKR8XUHHfHYvuJmquSYC+M7YiqzDcF2I0M1sQhXRnH
         nNaN/W8qtII9D3IKtq4QY/zD8Pxoo9n6G51MJeZoUGs1OLUhXEN3zYFqgugq5RTwZv/G
         LLIf0bF+d2ikIBMWH8oWHWMw0BN1ufAZyiWNgiXm2LQIhbkKqs8waPXvyFC3Nb1Csmw5
         hFmFabXsrMdjP5Cej96LZCtWsdmf8lkJYWV93OTWjdjCJEjFElP3LqZwcyzCSByV1SPb
         8Asw==
X-Gm-Message-State: APzg51CnkjeMkeysbxr2YNwfcLKJDORmLDFyb6SATU4C9Aaz74qy/zN2
        0eyfnK7tO/sheCW0u+3Y/6o=
X-Google-Smtp-Source: ANB0VdYiArn5sK/H1g26R1j0jNRAV5SHkwZzxvPwBivXktgQvLHfNfMbfkc0QkHN7XRg9XrVc9TrgQ==
X-Received: by 2002:a63:9246:: with SMTP id s6-v6mr25861340pgn.141.1537275933197;
        Tue, 18 Sep 2018 06:05:33 -0700 (PDT)
Received: from localhost (27-32-189-129.static.tpgi.com.au. [27.32.189.129])
        by smtp.gmail.com with ESMTPSA id w72-v6sm42984114pfa.26.2018.09.18.06.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 06:05:32 -0700 (PDT)
From:   Andrew Worsley <amworsley@gmail.com>
To:     Artem Bityutskiy <dedekind1@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org (open list:UNSORTED BLOCK IMAGES (UBI)),
        linux-kernel@vger.kernel.org (open list)
Subject: Round up the average EC for recovered EB to defer their reuse
Date:   Tue, 18 Sep 2018 23:05:20 +1000
Message-Id: <20180918130521.22880-1-amworsley@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We suggest rounding up the EC(Erase Count) for recovered EB(Erase Blocks) so
they are less likely than averaged to be re-used. The EBs which have lost their
EC header page and need to be reset are likely to be more worn than average
so it is better to use a larger than average number rather than less than
average number.

        Andrew Worsley
