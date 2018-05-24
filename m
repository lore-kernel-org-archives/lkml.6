Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161793-2-6875154842891852642
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161793; b=fGIxjfvGQEqNNEEIoM79JKlWLNtBvBZ52JYQKHaTT4BjCmU+9O
    QTW9T1WTrK5rxC6hsYWG63Us7m35Okbv017fbzawyvaN6qBkr+tAqJQ922hsk4kP
    Jx7KByP+RkZXTY1qbSUDk4UPr09go7451kGbPqEWZZISO+jFAI64T9OBzeNfbT64
    fh21gecEixQwI8BtfjcOs3Gp7TMn5EDzeGDNeuUaMKpGXhwB7N463B07YShNhq/C
    xcJaIFpQR7o6UXNlMwIau1rSnd2nA6AoxhS5fm/D1bJYezlRQZzxyCbScqY2r5B9
    oeikFtySIbWUsqxLCtJXP9yhd937SDXT9C8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161793; bh=ouUZAIpDvODIzU0YdoEYXuce6g6wgQ
    QHIDrv8qzjalI=; b=AEp6QlJ7vhNqEpEU/3m/Hqv25kR78tdqEc/QrnvRDw8IF4
    rH+VHgleJ19rSBDdnW7B/bn2/vxmxuHVRjSIpB/LS1voeCcx8K9/xFfECAyKi8up
    ew6N2ikR9UBAbn3BRh4ehmUBlytlcmKzLqq2rbr2Oale1nEFpmHEy4AK7m6jO0Vy
    xYltKfKUHyz9xdktJsac8pEA9NDi6e1YqZekbDWQ9rOUFACykQgtjyVgZ80QI9Jk
    XTsKqM1zdEUSfhh3z3Gnoez7s1qcU9/30xlEXXbnIV03Zzo7YuKUzVni72gVafdI
    5iGcAyi5X7vqx1jDjVRiEbK58sOyHuJbQA6WlLPQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=JOIlXFaM x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=JOIlXFaM x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJI+uPCbmnYQi75cyL0BNpK87bAX8SCuiwTrXCSe5zhYtFKkiBEI6Oi/F8tD9E2pawJIY38ImPKFIq/NsbNwrWJYLS/mhPt8in+MVu/8BRPxOijS3Tt8
    FbeyVOdKyoy2BhnlocCdMeFPO0ZqQ2NXHKBT1AJnXi9XnSuzoy0LIjGYtSzJwT0TEvZIzk9IPjzQKSrA4NRAaZPJcAk/m2DRXk2soRVimitEt/SG0Z33KZvs
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=s8YR1HE3AAAA:8 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=yARby3lnm6p1CmaUAsUA:9 a=QEXdDO2ut3YA:10
    a=jGH_LyMDp9YhSvY-UuyI:22 a=IawgGOuG5U0WyFbmm1f5:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967562AbeEXLgR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:36:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967500AbeEXJt5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:49:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 71/96] clk: Dont show the incorrect clock phase
Date: Thu, 24 May 2018 11:38:54 +0200
Message-Id: <20180524093609.470469718@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit 1f9c63e8de3d7b377c9d74e4a17524cfb60e6384 ]

It's found that the clock phase output from clk_summary is
wrong compared to the actual phase reading from the register.

cat /sys/kernel/debug/clk/clk_summary | grep sdio_sample
sdio_sample     0        1        0 50000000          0 -22

It exposes an issue that clk core, clk_core_get_phase, always
returns the cached core->phase which should be either updated
by calling clk_set_phase or directly from the first place the
clk was registered.

When registering the clk, the core->phase geting from ->get_phase()
may return negative value indicating error. This is quite common
since the clk's phase may be highly related to its parent chain,
but it was temporarily orphan when registered, since its parent
chains hadn't be ready at that time, so the clk drivers decide to
return error in this case. However, if no clk_set_phase is called or
maybe the ->set_phase() isn't even implemented, the core->phase would
never be updated. This is wrong, and we should try to update it when
all its parent chains are settled down, like the way of updating clock
rate for that. But it's not deserved to complicate the code now and
just update it anyway when calling clk_core_get_phase, which would be
much simple and enough.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Acked-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1929,6 +1929,9 @@ static int clk_core_get_phase(struct clk
 	int ret;
 
 	clk_prepare_lock();
+	/* Always try to update cached phase if possible */
+	if (core->ops->get_phase)
+		core->phase = core->ops->get_phase(core->hw);
 	ret = core->phase;
 	clk_prepare_unlock();
 
