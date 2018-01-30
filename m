Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbeA3Fvd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 00:51:33 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39061 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752293AbeA3Fvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 00:51:31 -0500
X-Google-Smtp-Source: AH8x226PrnN0v1KSNzN3qm1Q3BtyWN7zBu4lWPwarOp34ajxlFIvHch4UPsQNdTCoWYqztKq2ApUog==
From: Joel Stanley <joel@jms.id.au>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Cc: Jeremy Kerr <jk@ozlabs.org>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Eddie James <eajames@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fsi: add property to avoid scanning at boot
Date: Tue, 30 Jan 2018 16:21:14 +1030
Message-Id: <20180130055116.17411-1-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches from Chris add an optional property that says the
FSI attached hardware cannot cope with being probed unless the state of
that hardware is known.

This allows the driver to eg. defer to userspace which can make this
decision.

I am collecting patches for a FSI tree to send to Greg, so I am just after
review from the device tree people.

Christopher Bostic (2):
  dt-bindings: fsi: Add optional property no-scan-on-init
  fsi: core: Add check for master property no-scan-on-init

 Documentation/devicetree/bindings/fsi/fsi.txt | 7 +++++++
 drivers/fsi/fsi-core.c                        | 5 ++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.15.1
