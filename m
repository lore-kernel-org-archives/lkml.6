Return-Path: <jthumshirn@suse.de>
X-Google-Smtp-Source: AG47ELuYP7lY1vNlIZALHaTwAv4oG0GK0Dom5q0DfrpVg5IK2JXynZ2wyIPgZWrvwpSEs63P7uf7
ARC-Seal: i=1; a=rsa-sha256; t=1519738226; cv=none;
        d=google.com; s=arc-20160816;
        b=t+5feQP2N09pdlVeFGT3PmMddYUlSw6IpDUhgVtCTayH75sRo8ruo9dehV5BpczMA3
         /xydJ54xkGgXeCLiuRsi8X0zXQ+KT+acth6jahJWosGBFzLDBCQcbxMA94mwDfYpTPFe
         ma4TpkBnFQQW/uuA9rMUTmy8w3E61n2aJZ7rMmDl7RAYHhFUejsJfuzBIyUg6DDUde6d
         YgMFEReIER8PvvixG9HF8BeVAT0At605Asjbs4zRPNoerQyqPO6hNvn834NbO+8J88On
         6WjUyU/LcOBYAmMpN6q+F6se2dxnYQJN/V317X0qS53m85FTLatmsGBas60rF+67bYWC
         XlcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=ql3NoZOk5IFipSTmvuaO+txzymafu4goMQ0RmRsNJmc=;
        b=o6hV4EcqcsAe88wr3U7prw5F+KswAfV/kPfo810kzxf8zGzKKgLEfKsUJMfri61FEt
         b0nEhIBJmZBJ+/SkEDxzfPgvV6fNdCYCaKzHPUvry1vbYxSGX8PDmQu2GOXtBsktIvyi
         /WD9aZ+GCvb+0+KBYyo7ZeuUIQyFJ66K9VqlBm5Xt4Ti1kYNgPTk4kbkbURWKy0ajEdo
         hmcfzlvt5r5Dv6J0deaRdFpNrJzn1eM4NSIGUmeSzu3AlQPAgzKFfQeIUiVP2EkLfDOj
         TguEJ2P79DIrF3RQvlBPtyBxk+yI8XPYulRk1MTXoug6dAidcbbJ/9zQWJnebPh73Nnz
         uhLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jthumshirn@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jthumshirn@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jthumshirn@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jthumshirn@suse.de
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Michael Moese <mmoese@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 0/2] MCB Update for v4.17
Date: Tue, 27 Feb 2018 14:30:16 +0100
Message-Id: <20180227133018.7732-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593561030939942355?=
X-GMAIL-MSGID: =?utf-8?q?1593561030939942355?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

here's a small mcb update for the 4.17 window. The first patch makes
the PCI Vendor ID of Altera generally available in pci_ids.h and
removes it from the two private implementations before I would have to
add a 3rd one.

The 2nd patch adds the Altera's PCI vendor ID to the mcb pci driver
which enables at least one carrier board. This was reported and tested
by Ben Turner.

Johannes Thumshirn (2):
  PCI: add vendor id for Altera
  mcb: add Altera PCI ID to mcb-pci

 drivers/char/xillybus/xillybus_pcie.c | 2 +-
 drivers/fpga/altera-cvp.c             | 3 +--
 drivers/mcb/mcb-pci.c                 | 2 ++
 include/linux/pci_ids.h               | 2 ++
 4 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.13.6
