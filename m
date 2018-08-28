Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EF8C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC0D20880
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXIvRPYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC0D20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbeH1Wss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:48:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45507 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeH1Wss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:48:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id p52-v6so2126309eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 11:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uM0DCHXgGC1ut9Rfcytdnuu0/9NTjUhcAJ6qk5MuKUU=;
        b=vXIvRPYmCX/spBIOpWT9aCrHr6FMA2ztEQ8BEPVtuT9lUVbypiVAb2ZDUY9l+glrU7
         fO0cxoQRKHmMHuHhXft9UQtetR6ZlVCqNqJIEe2XPazHjpVNBTrqgyoa4qlnpa5WW85s
         8yhlL/oitb7GNvq7j+QvByYeG5eTzvw5adVnfuDEIyuQKWYUflzeoO98hl1ZBjAQWl0M
         ozxMOiFYVCs+jm9kpJCJ6Q3qLWOI1FB0cF5FcJMfmHZs5XqvQEVGL0mhy4kB/WqWDGly
         Z2Xvwi682CTZ4hAwN2kNtC0enTmTxRW5x6gJ8kraict/WUhCLtOijodMqXvPwP0de8qg
         8zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uM0DCHXgGC1ut9Rfcytdnuu0/9NTjUhcAJ6qk5MuKUU=;
        b=cfW79JCKe8atEG9XpGsE4khg1FdPvmL4gVrux9cLYWoSKbQjYQNcaECdT6n7qEo2zm
         AYFEdzx+MKG2TfDNencK2ggKEcBYcevxlSgxhs4akDiXYzn+j21C9cumym/KdAaOgnPz
         b0mi+KVdsPYGdvHZH7lVbhmLDMXPxgo1k9RR9xm8mwVBYF0/i1EWuIJmePyGy7T22Sjf
         alDeHGmlPj2B9pGYc+sKUNpIxw669GnydTNxCDV1xP6IcEy4N7eN/dos+fYvdwFtbLh2
         1yBWpcI1xvQFhReowJd09JRstMd/JlObh8OuhwBCxpYdAr02eyw6Q3uTO92YEXus6eRx
         3cxQ==
X-Gm-Message-State: APzg51BXaMPUVdJkDg4MIjZmr5d/4YJO6dyjNU65CxGDSkdaeIUyqaqs
        0tF8Q5BzGcS4adR0DRrN/Z/yP9Gp
X-Google-Smtp-Source: ANB0VdZvNAJx5fkqUEDurN06XrEgDK6wO4dYdY85Tw0EFg5xA2SqGbmANOK2LVVD5BgzSeoTGFKHhw==
X-Received: by 2002:aa7:c5cd:: with SMTP id h13-v6mr3854979eds.27.1535482548501;
        Tue, 28 Aug 2018 11:55:48 -0700 (PDT)
Received: from localhost.localdomain ([109.79.175.209])
        by smtp.gmail.com with ESMTPSA id o24-v6sm742975edr.64.2018.08.28.11.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 11:55:47 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 0/4] staging:rtl8192u: Style and a question?
Date:   Tue, 28 Aug 2018 19:55:31 +0100
Message-Id: <20180828185535.28808-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This short series of coding style changes clears the remaining checkpatch
issues in the files r8180_93cx6.h and dot11d.h. The file dot11d.h does
still contain lines over the 80 character limit, but most of these lines
are MACRO definitions, and I'm not sure splitting them will add anything
to the style and readability of the code.

My question is with respect to the member variable 'enabled' which has
been refactored in the third patch of the series. I've renamed the
variable to 'dot11d_enabled', (in addition to changing it's type as
suggested by checkpatch), so that it is easier to search for in code.
Now that it is easier to search for 'dot11d_enabled' and it's associated
macro IS_DOT11D_ENABLE(ieee) it becomes apparent that the variable is
initialised to FALSE, (and elsewhere '0'), but appears never to be set.

The function dot11d_update_country_ie(), in file dot11d.c, states in its
header block comment that it assumes that the value of dot11d_enabled is
true.

The dot11d_info structure is allocated:

ieee->dot11d_info = kzalloc(sizeof(struct rt_dot11d_info), GFP_KERNEL);

And dot11d_enabled could be set with a memcopy or a memset, but if it
is being set I've missed it completely. There may be a kernel specific
mechanism which I'm not yet familiar with?

In my ignorance I'd be tempted to remove all code which relies on the
variable being True, but then that function dot11d_update_country_ie()
specifically assumes it's true and is an exported symbol.

John Whitmore (4):
  staging:rtl8192u: Remove unused definitions - Style
  staging:rtl8192u: Add required SPDX-License-Identifier - Style
  staging:rtl8192u: Refactor member variable enabled - Style
  staging:rtl8192u: Rename member pDot11dInfo - Style

 drivers/staging/rtl8192u/ieee80211/dot11d.c   | 66 +++++++++----------
 drivers/staging/rtl8192u/ieee80211/dot11d.h   |  6 +-
 .../staging/rtl8192u/ieee80211/ieee80211.h    |  2 +-
 .../rtl8192u/ieee80211/ieee80211_softmac.c    |  8 +--
 drivers/staging/rtl8192u/r8180_93cx6.h        | 19 +-----
 drivers/staging/rtl8192u/r8192U_core.c        |  2 +-
 6 files changed, 43 insertions(+), 60 deletions(-)

-- 
2.18.0

