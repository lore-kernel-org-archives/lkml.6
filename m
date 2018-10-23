Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61FFC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD4C2064C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Ma/wuWyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD4C2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeJWJVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:21:10 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:41776 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJWJVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:21:10 -0400
Received: by mail-lj1-f170.google.com with SMTP id u21-v6so38711234lja.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 18:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=hq9B2rufu1bXdNovl34RkaSn6IXranAAA5n6s0tr8ws=;
        b=Ma/wuWyW6tyC2d716pTpGzF0kyYBchybdlqytYtWcF4uxT/Ffa/T46pGz1hb3nOO35
         kEN5PmK9S9jPXyyJTNpn7m0qile4xS6zFStQOTPjYGNrCslP0xCZIpUQFRu2U/qPkfQP
         81Uw71mhw8iPT+3M5NUp3xsp9lYdgSQKVQwraSsA2XB2HaNkVfuyM4VbCPuzZfC/zjx5
         IcUZfU11ec4mCHo8Iu5PW9pfcMNBqAWEIn72Dzh162H8ieAYIz5O9p6FJQagi30yoi8D
         bJuS7qe8OtgCSX08fgFBbcA7PjooYg7fw9GGoGgdeXfqTMRRIEgEFDx60EBzb86LnBzB
         Ql9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hq9B2rufu1bXdNovl34RkaSn6IXranAAA5n6s0tr8ws=;
        b=qYUPExjEJg5O5ryv8p31rxC/yyKzB6BNDbw7sWrvyP85g5EEdFITzOc/bAZgdEFR2r
         p1XEqoqBzcDxcfgIL1eGIhnAih+/rBKaWg1UZlTqWakUHjkSPA8WX0igTbg4VVrToHm4
         E2IxnpP3bIOCcNOMS2XEIir3AOQ2P16SlujVHLF0Rw+xM9jLjjCyBBeYyBzBB/hVCkZm
         BoOaEts+IPOeIRaoKa+bgeBewnt2omTz8v943rrpe7b5ha9ZgVXsWwFmYoduMLD/JxuL
         hhdFGuMC1MsB1GNRnHEm1lgJs4o2sP/gk3KeIslSK6GhsQcUwbQgDto6S6c4GklxBjoZ
         ACUw==
X-Gm-Message-State: AGRZ1gLB9FUWuemcWc0QE/RwWuopPIlcprnlXGKIivWTE3veKMnuveEm
        ctUM5oc6gFHLIGdS9k5aFE6spSRf9/62N0qNcwvcOwA=
X-Google-Smtp-Source: ACcGV63+urituZqIhcuWD2yVyc6PiIdyMJvOGy2mdu6sngx6C3DXeya1riXnPLiFtP2eZ7mQbf8kBD+Ou12ZrHU6ZVY=
X-Received: by 2002:a2e:d11:: with SMTP id 17-v6mr2992607ljn.18.1540256412610;
 Mon, 22 Oct 2018 18:00:12 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Oct 2018 21:00:01 -0400
Message-ID: <CAHC9VhS=5tbibmdZ6ozL_bMRtr1d2OvyKEx0CLcvU5OfE4uQbQ@mail.gmail.com>
Subject: No audit patches for the v4.20 merge window (audit/next is empty)
To:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A quick FYI to let everyone know there is no audit pull request for
the v4.20 merge window because there is nothing queued up in the
audit/next branch.  I do expect we will have a few things ready for
v4.21.

-- 
paul moore
www.paul-moore.com
