Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337A9ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA04B2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B2MCwMFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA04B2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbeISENj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:13:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40168 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeISENi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XRX3IQnXjrX3yiXggUUaOMCcPIOeXaAX+aSgoeGv32g=; b=B2MCwMFnKL/Oq47BYI9Ll/8YDB
        OzqXrMPptKSMpjnPGUg0ShIe8frGZho2jn4I6oC7az5sGrtjCDtKHylt8vrCYPP1XqM+I1mmyfz0E
        mthMe4ZqJlhjSeut/oPAPBDKFFGv1cb8VbFKN3zztsy0yBeafycDwGoRZutSWxSKn1PwYBnwoHtR5
        DsS6bOJUKEd73ZjI2YaJWCMV9sF4PyLIa/CuyBgxXauOL5LYVjkQNlhVoCWMQ0SqHOwY3lhe543I7
        AVPpIRmyX6CWCCdpoUJyp1q2t6zaZo53L/Cj9gbuXaIpmFktM4umlTQItDHQ9xVA2+/hx9OBEfX33
        SSFmzfmg==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2Odx-0000Pb-FT; Tue, 18 Sep 2018 22:38:53 +0000
Date:   Tue, 18 Sep 2018 15:38:52 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 4.19-2
Message-ID: <20180918223852.GA10584@wrath>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus and Greg,

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v4.19-2

for you to fetch changes up to ff0e9f26288d2daee4950f42b37a3d3d30d36ec1:

  platform/x86: alienware-wmi: Correct a memory leak (2018-09-10 13:45:43 -0700)

Thanks,

Darren Hart
VMware Open Source Technology Center

----------------------------------------------------------------
platform-drivers-x86 for v4.19-2

Free allocated ACPI buffers in two drivers.

The following is an automated git shortlog grouped by driver:

alienware-wmi:
 -  Correct a memory leak

dell-smbios-wmi:
 -  Correct a memory leak

----------------------------------------------------------------
Mario Limonciello (2):
      platform/x86: dell-smbios-wmi: Correct a memory leak
      platform/x86: alienware-wmi: Correct a memory leak

 drivers/platform/x86/alienware-wmi.c   | 1 +
 drivers/platform/x86/dell-smbios-wmi.c | 1 +
 2 files changed, 2 insertions(+)


-- 
Darren Hart
VMware Open Source Technology Center
