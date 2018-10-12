Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0419C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFDB2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RMqIlIyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFDB2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbeJLXiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:38:05 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:60175 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbeJLXiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:38:05 -0400
Received: by mail-it1-f202.google.com with SMTP id e197-v6so13512219ita.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wkBf/9OUdwhUj4wdZN8NT4fSQ72oF4DYmi0hmSgOzms=;
        b=RMqIlIyQvzxlCdrO7QwCysBUE94mlbaFmCVFxKC2CkjFP3RsDDADFF4B1S0j6LZgHx
         rSnPFAxHmQQQfKxlh6V5VdBa65lYd2i3grKefcjSM5s5K2URdDqvzEgg/H2c+vLIdMDP
         jHjstE2wuwfHfJKN817ztXyzXZBY0pcYyKJFvto0P4yOqHEtYZ72NRili/5rhS96n8oi
         GedqXHX/AAuXSKiijWzJHO7vb66NTCWIBAGlrVCqLhnsLb3Dvh3KOE01IxO3C1iOa6eI
         nDRIoXi5cRyqOIIbPN0fSbS4BY7U+dPm8oV40N3R5YqNck45J8UU14BSO3kvOqZP08ih
         NaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wkBf/9OUdwhUj4wdZN8NT4fSQ72oF4DYmi0hmSgOzms=;
        b=YAQzAIEvHR0b2EgU4KtJD/7pCgQ2y0gASFqPf2+GeNlB8gGQV25ON34rEpEiWlUGU9
         Vt7T67jjkRk8v7NUUjfgiEmGwWNUyHPpNK37U1t16v+ado9sEs7qoW2IJimqyJhyxqCI
         jxtdCN+7LIbmxqzHKtce4zDONONdgPNKgIC0rzfgdzQgnGEzP6CoDzycWycBgO0ewvC8
         7rqCuv8bmdZM9HghAc0tvjgxcACdzQih20Vk59lgaGUhy6vZ6oDDnZCNv2Nymulh4z3W
         UrVjlf7E6vYJ9vvREwUExtlJ2nJTJUyXTFO8KXPWPqbG1Fh5Wwa0FvPnHZ7zr84Taae2
         MiDg==
X-Gm-Message-State: ABuFfohYKh2sy6JpsyRf3dxcOEjnuD2CVmKWfrZhbWz/HMxjpZaO28Yo
        cehAyzSHj0eaeJNPipSev+kZ82nBjjAv
X-Google-Smtp-Source: ACcGV603JtLDqXEY/cASGZom/kUSVDnVB3+iUnrjGWbcY03q/JDKnQ+ot1WgC+ASnw4XhgmvukX7yVhHqJ64
X-Received: by 2002:a24:e48b:: with SMTP id o133-v6mr8340101ith.0.1539360295529;
 Fri, 12 Oct 2018 09:04:55 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:04:44 -0600
Message-Id: <20181012160448.79018-1-zwisler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 0/4] gsmi: Google specific firmware patches
From:   Ross Zwisler <zwisler@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ross Zwisler <zwisler@google.com>,
        Duncan Laurie <dlaurie@chromium.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Guenter Roeck <groeck@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains some Google specific firmware patches that we've
been carrying out of tree.  I've updated the changelog for each so that
it is suitable for upstream, and I've retested them to make sure I know
what the patches are doing.

Duncan Laurie (3):
  gsmi: Fix bug in append_to_eventlog sysfs handler
  gsmi: Add coreboot to list of matching BIOS vendors
  gsmi: Remove autoselected dependency on EFI and EFI_VARS

Furquan Shaikh (1):
  gsmi: Add GSMI commands to log S0ix info

 drivers/firmware/google/Kconfig |   6 +-
 drivers/firmware/google/gsmi.c  | 120 +++++++++++++++++++++++++++++---
 2 files changed, 115 insertions(+), 11 deletions(-)

-- 
2.19.0.605.g01d371f741-goog

