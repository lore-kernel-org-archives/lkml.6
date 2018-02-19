Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519064219; cv=none;
        d=google.com; s=arc-20160816;
        b=U+LSv5dvWyDxwyzq3YI9BfS672i9vsr5hGse8+f8piZhCsL+qUQ7ysPbk6ZwmNuzii
         wLmq2oa7AOVx3fqeC2SIv0yILnopex2QEznDvNKkg9KG1szO83dn3NKHiy9V6DmkMpin
         w7QwWO6GgSSPjCsATjMwKNQ42SLXGr6ZVFFDX+ceXd5Nbu79/PQ7kl71vu2dMinsw6uj
         EzY9yb4UcZpRzrmJ5etrUIG+Sawhr6uJvd+7+1cQU0ejB4hQP6EGDJBZ4BKEWE8Pr19h
         MLvTvet2sOzDmahg1Ke+kToWnZmSjS6aIW4kpJovltIqf+fnq/XZkypc8ill3UHJHIIu
         pEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=9gW8qYjV9B2Sso8JTYmP6oASb8hC0DGhwEVLtVfRRog=;
        b=Y6GZoptbNBdQ1Ffx3cpu3GfEOwPFdvPEKfxwj4VNWiwFJrVP/5E+M2ukeM/+mgAiJZ
         nJ+naIL7Cq4ZlhOnAwpzi4J4K0vCcDOlaDv29o2pNpAkiZcEC2doyvQtXkYgPV6/slGV
         M7bfsBqRIvSECJhnwRK8PcAb/OUQR9M9BsEACuWurOs1KehKOLpKHaIYWh7SFZ+JnbLI
         WAS3kmV7vJOVTMie0cL/fKy1qGKO8GendUEcTkX74RoaNY1AqoAcFUnfjWVJbB+CqBRG
         DvI8qKFj96j8rjRt7iSrMgfTBRjMSKjM0KZDPKgNabzWHkuH9+XL76xRtf9qmfNBFO97
         kDCg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pp0/hvng;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pp0/hvng;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x2249CKOaqnepyaChyxuc3j2cP0fGZD5ATd7fFIUMXON0ybxpyrygJJTLKEy1Xvq1gDFlo2ow7w==
Date: Mon, 19 Feb 2018 23:46:53 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: "Ed L. Cashin" <ed.cashin@acm.org>, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH v3] aoe: document sysfs interface
Message-ID: <20180219181653.GA2925@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592854282679037569?=
X-GMAIL-MSGID: =?utf-8?q?1592854282679037569?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Documentation has been compiled from git commit logs and descriptions in
Documentation/aoe/aoe.txt. This should be useful for scripting and
tracking changes in the ABI.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
Changes in v3:
- name -> names in description of netif
v2:
- interface -> interfaces in description of netif

 Documentation/ABI/testing/sysfs-block-aoe | 45 +++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-block-aoe

diff --git a/Documentation/ABI/testing/sysfs-block-aoe b/Documentation/ABI/testing/sysfs-block-aoe
new file mode 100644
index 000000000000..b5837765bcdd
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-block-aoe
@@ -0,0 +1,45 @@
+What:		/sys/block/etherd*/mac
+Date:		Apr, 2005
+KernelVersion:	v2.6.12
+Contact:	Ed L. Cashin <ed.cashin@acm.org>
+Description:
+		(RO) The ethernet address of the remote Ata over Ethernet (AoE)
+		device.
+
+What:		/sys/block/etherd*/netif
+Date:		Apr, 2005
+KernelVersion:	v2.6.12
+Contact:	Ed L. Cashin <ed.cashin@acm.org>
+Description:
+		(RO) The names of the network interfaces on the localhost (comma
+		separated) through which we are communicating with the remote
+		AoE device.
+
+What:		/sys/block/etherd*/state
+Date:		Apr, 2005
+KernelVersion:	v2.6.12
+Contact:	Ed L. Cashin <ed.cashin@acm.org>
+Description:
+		(RO) Device status. The state attribute is "up" when the device
+		is ready for I/O and "down" if detected but unusable. The
+		"down,closewait" state shows that the device is still open and
+		cannot come up again until it has been closed.  The "up,kickme"
+		state means that the driver wants to send more commands to the
+		target but found out there were already the max number of
+		commands waiting for a response. It will retry again after being
+		kicked by the periodic timer handler routine.
+
+What:		/sys/block/etherd*/firmware-version
+Date:		Apr, 2005
+KernelVersion:	v2.6.12
+Contact:	Ed L. Cashin <ed.cashin@acm.org>
+Description:
+		(RO) Version of the firmware in the target.
+
+What:		/sys/block/etherd*/payload
+Date:		Dec, 2012
+KernelVersion:	v3.10
+Contact:	Ed L. Cashin <ed.cashin@acm.org>
+Description:
+		(RO) The amount of user data transferred (in bytes) inside each AoE
+		command on the network, network headers excluded.
-- 
2.16.1
