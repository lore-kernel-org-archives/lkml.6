Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518795545; cv=none;
        d=google.com; s=arc-20160816;
        b=i0zp6L98sBFUsQo8S7O4iod5BJ97yakuPOllCP6SbCef2x9Fnflvo/FJbpaYerOS5C
         ETDXNLY/AXIVKTZWNHzH2XVUCaMAHTGErXByD7Ctn2BEk/prioI5eVNq8d4x1+INjeYB
         IQ5MNOoNWjSeyo7pc/VLLzwt2XRd3lWTUfTNnjNPHKL7/U94f6DHrpjAV6TPr23rJaBF
         +RWdlIycwbEgRnltE1+H9yfMbFK7XPmV4f7wyb3eyoH90bAX0S62HxAlSA0PA8VMucVa
         KoqmSG9/lw2Lhzp5AqpoUp1PLWUJhOmfyDZSwQHrdsijV2b9qpM4WjjlVNqWTzLUpjsj
         uE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=4MP5qzMPnYSu8Np5DEOStRW89XjbQfoLEz8EmSALmr8=;
        b=XihjXoMSxgKTt/KLlEDgRDnajzkDyo61TjBqH94cMCZGDsobg2IVfdjx35TSM8B5PK
         H6dvFCMVIb6rEPn5udvwTh3TjCLy4vx8nxf8xSwrVa+UTC94S9uRGCePwapIXi8exGJ3
         MyAY5zlKozfqg3C3/eatGQKHeh8DUlQ3jXQF3XAZ4G4KqflhvVLLYGgnUPcGidLLf8pq
         1cEm0Y4liW+xgZh0M5YQWj00RlwH9y7ON9g5oS3gj0zf/4sBmBhWXdI0T+0iGTz+pPP1
         7q/IY2WIMxJku+h1OAGNmYf7y2dJLvEkHkfPVGwk5ynerhTyO8+0QIJloFeBHOz27FFQ
         9eiw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hso04+jW;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hso04+jW;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227lPHAdQO1eFD0CR2xKvXmXNGJowPrtze3BK95tU9B/IAR4Osdc8Ei+MgNvFlr6Q/94H4nFQg==
Date: Fri, 16 Feb 2018 21:09:00 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: "Ed L. Cashin" <ed.cashin@acm.org>, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH] aoe: document sysfs interface
Message-ID: <20180216153900.GA12832@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592572558446163401?=
X-GMAIL-MSGID: =?utf-8?q?1592572558446163401?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Documentation has been compiled from git commit logs and descriptions in
Documentation/aoe/aoe.txt. This should be useful for scripting and
tracking changes in the ABI.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 Documentation/ABI/testing/sysfs-block-aoe | 44 +++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-block-aoe

diff --git a/Documentation/ABI/testing/sysfs-block-aoe b/Documentation/ABI/testing/sysfs-block-aoe
new file mode 100644
index 000000000000..d197c7770dc0
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-block-aoe
@@ -0,0 +1,44 @@
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
+		(RO) The name of the network interface on the localhost through
+		which we are communicating with the remote AoE device.
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
