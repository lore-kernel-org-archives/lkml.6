Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFC9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F4020855
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PztqzGjW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PztqzGjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F4020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbeGCKyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:54:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52382 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752948AbeGCKyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:54:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8A0A660B14; Tue,  3 Jul 2018 10:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530615251;
        bh=4fo3qYVBiVaDWMzAzl5MMBiecPygtZt4EFuTSR1h3gA=;
        h=From:To:Cc:Subject:Date:From;
        b=PztqzGjWo3Ud98sG0L/8jSHH46hEdolssrpDR7iYfEERQ1RqDRjoHO/Pq7VMbZkJJ
         D5YxndDeIW1Ao8DmHCHLbiB1nGxvBY6RWOcpKEEF5vJOI1GBv/lLY+FYXP7wj+jJKl
         /ENjP9B+80jxq4iVY472sB4HZyDxU4S0kSNoBdsM=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE7DB60B14;
        Tue,  3 Jul 2018 10:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530615251;
        bh=4fo3qYVBiVaDWMzAzl5MMBiecPygtZt4EFuTSR1h3gA=;
        h=From:To:Cc:Subject:Date:From;
        b=PztqzGjWo3Ud98sG0L/8jSHH46hEdolssrpDR7iYfEERQ1RqDRjoHO/Pq7VMbZkJJ
         D5YxndDeIW1Ao8DmHCHLbiB1nGxvBY6RWOcpKEEF5vJOI1GBv/lLY+FYXP7wj+jJKl
         /ENjP9B+80jxq4iVY472sB4HZyDxU4S0kSNoBdsM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE7DB60B14
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     David Miller <davem@davemloft.net>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: pull-request: wireless-drivers 2018-07-03
Date:   Tue, 03 Jul 2018 13:54:07 +0300
Message-ID: <87tvpgr3n4.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

this is the first pull request to net tree for 4.18, more info below and
please let me know if you have any problems.

Kalle

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git tags/wireless-drivers-for-davem-2018-07-03

for you to fetch changes up to 4fa9433f950a3df0c180be37f14efe033198aa24:

  Merge ath-current from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git (2018-06-29 13:29:17 +0300)

----------------------------------------------------------------
wireless-drivers fixes for 4.18

First set of fixes for 4.18 and for numerous drivers. Something to mention
about is the wcn36xx fix which makes it possible to compile with gcc older than
4.4 (though I'm not sure if we even support those anymore).

qtnfmac

* coverity fix for a new commit in v4.18-rc1

rtlwifi

* fix kernel oops during driver removal

* fix firmware image corruption for rtl8821ae

brcmfmac

* fix crash if there's no firmware image

mwifiex

* a revert and a better fix for a new commit v4.18-rc1

mt7601u

* fix a recent regression about unnecessary warning about avg_rssi

wcn36xx

* convert testmode.c to plain ASCII

ath10k

* fix a firmware crash during bandwidth change

----------------------------------------------------------------
Ganapathi Bhat (2):
      Revert "mwifiex: handle race during mwifiex_usb_disconnect"
      mwifiex: handle race during mwifiex_usb_disconnect

Geert Uytterhoeven (1):
      wcn36xx: Remove Unicode Byte Order Mark from testcode

Gustavo A. R. Silva (1):
      qtnfmac: fix NULL pointer dereference

Kalle Valo (1):
      Merge ath-current from git://git.kernel.org/.../kvalo/ath.git

Michael Trimarchi (1):
      brcmfmac: stop watchdog before detach and free everything

Ping-Ke Shih (2):
      rtlwifi: Fix kernel Oops "Fw download fail!!"
      rtlwifi: rtl8821ae: fix firmware is not ready to run

Ryan Hsu (1):
      ath10k: update the phymode along with bandwidth change request

Stanislaw Gruszka (1):
      mt7601u: remove warning when avg_rssi is zero

Xinming Hu (1):
      MAINTAINERS: update Xinming's email address

 MAINTAINERS                                             |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c                   | 16 ++++++++++++++--
 drivers/net/wireless/ath/ath10k/wmi.h                   |  1 +
 drivers/net/wireless/ath/wcn36xx/testmode.c             |  2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c |  7 +++++++
 drivers/net/wireless/marvell/mwifiex/usb.c              |  7 ++-----
 drivers/net/wireless/mediatek/mt7601u/phy.c             |  6 ++++--
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c       |  3 +--
 drivers/net/wireless/realtek/rtlwifi/base.c             | 17 ++++++++++-------
 drivers/net/wireless/realtek/rtlwifi/base.h             |  2 +-
 drivers/net/wireless/realtek/rtlwifi/core.c             |  3 +--
 drivers/net/wireless/realtek/rtlwifi/pci.c              |  2 +-
 drivers/net/wireless/realtek/rtlwifi/ps.c               |  4 ++--
 drivers/net/wireless/realtek/rtlwifi/usb.c              |  2 +-
 14 files changed, 47 insertions(+), 27 deletions(-)
