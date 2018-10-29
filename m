Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D01C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EEA20824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EEA20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJ3FzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:55:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:39215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbeJ3FzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:55:23 -0400
Received: from ls3530.fritz.box ([92.116.145.205]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M54L0-1fMeBY0TYk-00zIEt; Mon, 29
 Oct 2018 22:04:50 +0100
Received: from ls3530.fritz.box ([92.116.145.205]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M54L0-1fMeBY0TYk-00zIEt; Mon, 29
 Oct 2018 22:04:50 +0100
Date:   Mon, 29 Oct 2018 22:04:47 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for kernel v4.20
Message-ID: <20181029210447.GA17383@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K1:TPtbL4AcVsdvDM6B+WCRhTIOErF63mXv9gqEdyKwTr9oyy/zaOy
 RfcLQAlKA1FrW9PULefL17NLbMLAHpsDTzs5T5QEYVeXXGXd/J8PZPPuBcQpUPw0tVNCtGd
 i1FxiMUeyEckgCjksu+laeuMK6G/KUIWXuYfRoFIGPwj/l9jYpnFldppU+HBWOJQNVdAIbP
 BIlOhlI9i546EQIGai2FA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:23asvMYnP3Y=:RWYNtVf2pY33leUvQecKRH
 3NgmbwxRlW/oK8gj+joekoIisJQOuynzcjGKLk5t3xrgS8l85/tOBJola07VQ86/1kzCaPtPx
 gZrd+XE5DBWqdu2bQ4NFvfhH/Mn3jjMHBaZZx4Lm5wKv0+leXBKpZ+Iu2l9yi6y7vww9j1Vdi
 AlV0r2AfVmrKyvPway7E3Mom/w45idCKItRmCT/wMcGB6LdLxRDGVY5UVn3lvojk62blVDbXN
 2VF6Os3MyixjQA30rVvRenSnZC+lEUgeb4iWO/rGitTnjKPRAULQufwzsRYmValmuWxOe0IE6
 p8B2oemqOzd0T+S+WwHeG8Uf/qnWH0GjYPssic0O06Eep9fYLNovRoOMZ8rt7cMErcYwrDuiG
 9As/C2OM/vJCcYSpynQGJZJb1cCmtwiMCP8aMWDxQJq2uftPom/4JH+TPpxj29v+eI2hd3Xh+
 rYWkugVZ0IH32T00FuTZ+AbxY+0dQoTxZgzeEM7hwOAb6ZAhsI44yjzcwOaQSGrviZN47BT+I
 kXtVfcJt0rUjxsFKqPSrFjgsMB41uHBKAsyfI0CnIQSRE7Re5Tzk+z8V4YVqEhT9nLU079Fuz
 H46OXskvtLg0ylZJCZerHoWNYy7ESAkyx+iUP7Jnt35S+N/sd3Q/5NcFNWAK3hZwxp/DdJvpL
 vQFQKtFIfawp/RKBg3bPbWYGTSv4NtwF7BDflOdvXnFy2U/eRRWjJvZE+taW/SYkdwT3wIqgw
 jGd5pQBnPZQo3WcbBkHcMrkMQWq4zP+TMBsHbAP5Lo0I2krA8HepCDLV5smPhHY5NbywAW4Nn
 UWOJMf7rrqO19ORN8iZIi7UR0utIw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull three small patches for the parisc architecture for 4.20-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.20-2

Three small patches:

- A boot fix for A500 machines, crash was caused by the new alternative
  patching code from this merge window (by Dave)
- Change __kernel_suseconds_t to match glibc on 64-bit parisc (by Arnd)
- Use constants instead of hard-coded numbers (by me)

Thanks,
Helge

----------------------------------------------------------------
Arnd Bergmann (1):
      parisc64: change __kernel_suseconds_t to match glibc

Helge Deller (1):
      parisc: Use LINUX_GATEWAY_SPACE constant in entry.S

John David Anglin (1):
      parisc: Fix A500 boot crash

 arch/parisc/include/uapi/asm/posix_types.h |  3 ---
 arch/parisc/kernel/entry.S                 |  5 +++--
 arch/parisc/mm/init.c                      | 10 ++++------
 3 files changed, 7 insertions(+), 11 deletions(-)
