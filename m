Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527159268-2-13213362181989018229
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
    1527159268; b=SHi21bufgs4Ikbn2AzxqD6Wj27GrybMaSQN9v38AhYQb5niRVA
    aVTtaAYoqCHVeAUCa7B98sycQCb2vcq5iHmTxozNRrL283xUmCdatvFOn0bmi64L
    mTn0cBq6YbFUKmKzJp4yj7b3NVWRYkxnLF5pnfiQwnnb5O3pbeYBJykLYN/sRJvE
    fxBxizMOrieWcN69V/urViYMFwS9MfcZ3TV3bRY6jILvqfAPflLNZYwzRzmAwwi/
    q8Ux8Lhtm2GvMrXNtVSVpMRAOmFEqS+4ZZrs1Tc/SDTy0mfQPkmRdCDXPn9tMp+f
    xRPQRKGZDqtUjabwDV/mg2qdHcYMiRpUqspw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159268; bh=f06vKPuDXBkuBOOQ7BoKDyzSzEhAs9
    n2kSmPZAcHb70=; b=XuFSuOatGG5993i7h4xrTGRr0lrQ77Ss8qfxWiCs3hcswk
    EMoFLRe0odl1zSTqYp+RSqVUwEErZoN0/F/EqjA7+QIGKAmMjuYTaa+CZOsrGQHj
    qu0nb8xaTjdt3vRmGaLUige92HoW4apqvoOs+PtLodg2iiSrkKLMI08YHjdnmDf8
    uR4V2EDbT1LVbwy2qcmiSDyZwna7xqa3hUdTbf15toj9TYm2zv7/7yhAxJFCJW6u
    4acmoQPFd0j5rwoA1iiRI7pzGeNgGgfCESook82uHJYX5FGvnA+iEIM8uiSeDzMw
    KLQaypaty4/Oktq+iHl104FFVi3iXmIGKarNkCmw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=o4dPt5wG x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=o4dPt5wG x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfNDqOtoiypvkOHlD2uScz6e89w+qE4TEPn5GsuDZ2yjlqcbncyxnmiHRilAys2x1KfPM2yD8DosRmrnuWsAKdI4URg30xEFzpZgFR8Iijj4kMjiqLsZo
    uY3pmK//Y1TnfxOTyFRr3TjbC1n9LFN8A75u5g/1LHq7Ftx7h5Omf56CxzWjFytsXyIvR22fDZO9O3lv9nEmfKoGanc21SWyq4lHgzRnvEIlYtByFchLdxGh
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=s8YR1HE3AAAA:8 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=yARby3lnm6p1CmaUAsUA:9 a=QEXdDO2ut3YA:10
    a=jGH_LyMDp9YhSvY-UuyI:22 a=IawgGOuG5U0WyFbmm1f5:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030382AbeEXKy0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:54:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030352AbeEXJ4y (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:56:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 127/165] clk: Dont show the incorrect clock phase
Date: Thu, 24 May 2018 11:38:53 +0200
Message-Id: <20180524093627.142660000@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1931,6 +1931,9 @@ static int clk_core_get_phase(struct clk
 	int ret;
 
 	clk_prepare_lock();
+	/* Always try to update cached phase if possible */
+	if (core->ops->get_phase)
+		core->phase = core->ops->get_phase(core->hw);
 	ret = core->phase;
 	clk_prepare_unlock();
 
