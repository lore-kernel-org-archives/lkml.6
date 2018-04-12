Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeDLSXd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 14:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752763AbeDLSXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 14:23:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E478E21771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Subject: [PATCH v1 0/2] kexec: Remove "weak" annotations from headers
From: Bjorn Helgaas <helgaas@kernel.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Dave Young <dyoung@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Apr 2018 13:23:29 -0500
Message-ID: <152355706051.36693.9856090891621551967.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Weak" annotations in header files are error-prone because they make
every definition weak.  Remove them from include/linux/kexec.h.

These were introduced in two separate commits, so this is in two
patches so they can be easily backported to stable kernels (some of
them date back to v4.3 and one only goes back to v4.10).

---

Bjorn Helgaas (2):
      kexec: Remove "weak" from kexec_file function declarations
      kexec: Remove "weak" from arch_kexec_walk_mem() declaration


 include/linux/kexec.h |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)
