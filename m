Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="PY4i56As"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D8DA60764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeFFNwZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:52:25 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:48681 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbeFFNwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:52:23 -0400
X-IronPort-AV: E=Sophos;i="5.49,483,1520899200";
   d="scan'208";a="735681358"
From: Norbert Manthey <nmanthey@amazon.de>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <x86@kernel.org>
Subject: Make CONFIG_NET and CONFIG_SECCOMP_FILTER independent of CONFIG_NET
Date: Wed, 6 Jun 2018 15:52:00 +0200
Message-ID: <1528293127-23825-1-git-send-email-nmanthey@amazon.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

currently, KVM and SECCOMP rely on functionality of CONFIG_NET, and hence the
latter has to be enabled when building the kernel for the first two
configurations. However, there exists scenarios where the system does not need
networking, but KVM and SECCOMP filters. To reduce the kernel image size for
these scenarios, and to be able to drop active code, this commit series allows
to enable CONFIG_KVM and CONFIG_SECCOMP_FILTER without using CONFIG_NET.

The functionality that is required for seccomp filters is kept in the same
files and - after reordering the source code - is guarded with a single ifdef
per file.

I hope these changes are useful for other scenarios than the one I currently
face.

Best,
Norbert

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
