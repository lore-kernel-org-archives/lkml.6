Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978EBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E24208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="idcKZh/p";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="idcKZh/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E24208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbeGaM2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 08:28:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55036 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731264AbeGaM2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 08:28:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DBF8D60117; Tue, 31 Jul 2018 10:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533034098;
        bh=h/lb3QojtQzob1smCZ5jMt759yTtwNQ0abCgAG2EOgw=;
        h=From:To:Cc:Subject:Date:From;
        b=idcKZh/pzUY1zu9hVJCA5w4kmLaXO5xX8FoIGxxv01O0OT6+7Ep0NpTczFwZr5ges
         A56JGw1U3IGxIAnVs24KXuquO4GAbhjWvKALfOkXDwnoxz9jthw0lvGPy4StGXu7JG
         uzzK9yguF1GkyUXymj1CBWeD/+Jg20W4VI5mOFec=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6563660117;
        Tue, 31 Jul 2018 10:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533034098;
        bh=h/lb3QojtQzob1smCZ5jMt759yTtwNQ0abCgAG2EOgw=;
        h=From:To:Cc:Subject:Date:From;
        b=idcKZh/pzUY1zu9hVJCA5w4kmLaXO5xX8FoIGxxv01O0OT6+7Ep0NpTczFwZr5ges
         A56JGw1U3IGxIAnVs24KXuquO4GAbhjWvKALfOkXDwnoxz9jthw0lvGPy4StGXu7JG
         uzzK9yguF1GkyUXymj1CBWeD/+Jg20W4VI5mOFec=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6563660117
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     David Miller <davem@davemloft.net>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: pull-request: wireless-drivers 2018-07-31
Date:   Tue, 31 Jul 2018 13:48:15 +0300
Message-ID: <87bmanadg0.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

two small patches I still would like to get to the net tree for v4.18.
Please let me know if you have any problems.

Kalle


The following changes since commit 144fe2bfd236dc814eae587aea7e2af03dbdd755:

  sock: fix sg page frag coalescing in sk_alloc_sg (2018-07-23 21:28:45 -07=
00)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git =
tags/wireless-drivers-for-davem-2018-07-31

for you to fetch changes up to 299b6365a3b7cf7f5ea1c945a420e9ee4841d6f7:

  brcmfmac: fix regression in parsing NVRAM for multiple devices (2018-07-2=
5 10:30:36 +0300)

----------------------------------------------------------------
wireless-drivers fixes for 4.18

Last set of fixes before 4.18 is released

iwlwifi

* add new IDs for cards already available on the market

brcmfmac

* fix a regression introduced in v4.17

----------------------------------------------------------------
Emmanuel Grumbach (1):
      iwlwifi: add more card IDs for 9000 series

Rafa=C5=82 Mi=C5=82ecki (1):
      brcmfmac: fix regression in parsing NVRAM for multiple devices

 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |  3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c      | 69 ++++++++++++++++++=
++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |  5 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      | 22 +++++++
 4 files changed, 98 insertions(+), 1 deletion(-)

--=20
Kalle Valo
