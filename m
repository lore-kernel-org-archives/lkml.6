Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4BFC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94CB2064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94CB2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbeGZPgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:36:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45398 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbeGZPgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:36:46 -0400
Received: from localhost (unknown [62.119.166.9])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 38B65A95;
        Thu, 26 Jul 2018 14:19:35 +0000 (UTC)
Date:   Thu, 26 Jul 2018 16:19:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: [GIT PULL] Staging driver fixes for 4.18-rc7
Message-ID: <20180726141921.GA14060@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9d3cce1e8b8561fed5f383d22a4d6949db4eadbe:

  Linux 4.18-rc5 (2018-07-15 12:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-4.18-rc7

for you to fetch changes up to b96fba8d5855c3617adbfb43ca4723a808cac954:

  staging: speakup: fix wraparound in uaccess length check (2018-07-16 10:04:11 +0200)

----------------------------------------------------------------
staging driver fixes for 4.18-rc7

Here are 3 small staging driver fixes for 4.18-rc7.  One is a revert of
an earlier patch that turned out to be incorrect, one is a fix for the
speakup drivers, and the last a fix for the ks7010 driver to resolve a
regression.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Hans de Goede (1):
      Revert "staging:r8188eu: Use lib80211 to support TKIP"

Samuel Thibault (1):
      staging: speakup: fix wraparound in uaccess length check

Sergio Paracuellos (1):
      staging: ks7010: call 'hostif_mib_set_request_int' instead of 'hostif_mib_set_request_bool'

 drivers/staging/ks7010/ks_hostif.c            |  12 +-
 drivers/staging/rtl8188eu/Kconfig             |   1 -
 drivers/staging/rtl8188eu/core/rtw_recv.c     | 161 ++++++++++++++++++--------
 drivers/staging/rtl8188eu/core/rtw_security.c |  92 +++++++--------
 drivers/staging/speakup/speakup_soft.c        |   6 +-
 5 files changed, 171 insertions(+), 101 deletions(-)
