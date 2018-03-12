Return-Path: <arvind.yadav.cs@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520854671; cv=none;
        d=google.com; s=arc-20160816;
        b=oPy9OBk42bryHjksL85HIvuIy+/f+zNyzcbUShbOuNvIVWdFba8DVvNwJX98YtUn0r
         9STnqKzHVc3sN0wuGjy6nFEEsvuok+0g32OXUzqzYUd9po844joH06Af2nCrUwhYbOki
         NkEf3r5/UbnMNweIfy1NBOc2DsfPYBr00dByV0CK5zs0ypW1maQLjsSUqeu4cAyZL9nh
         UJopuDqWMLKWF8zDMjTNZtn3xpvYQAYQY1OTlAgWfhz/M/bJ/CkjChNIzbcQNWtk4zIv
         muC/MvDXSbatuUQhAWf9qYxRDijAy8iWwXqV3mYhepwXq7mhvonzHOakZIqadZc2/UhB
         wv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=W+gnzznK0NrYtyMLezUOMTNHPwpmb7QXrVYYsTo+UQ8=;
        b=VYQq7lAVyXHyJEB544wUO+DcBZRUea/EJL7kc1/0Z6YV/Hps8Aps9E7uXQYCtdPWvC
         MRxMivzX4i+gIquxCsNOz9u5kivU4+Xz0NhIIIC674BEPomQdzUc/pxoualKjKmkrRFy
         a9cAo5CdFxCPgSywxqytpZ6tYI0Pw50wkprlJTXuUXf0UWqanZN5vfuHfaqrp+pzRAMl
         Ir5DzmLWC0jJu25kIWNWPV5H2c4kkW3+AQTOpO+OqHULQWyUHNZI8ivLvoL+G/C/B3Je
         iQwUdXiucSlyF14xjorN6vIEIFIbAbeYD6UYRY3w+lnY7MMh/Gh6M8FV9yROU914HvCC
         v7sQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RsqJtV4o;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RsqJtV4o;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuCfPeRIGoKPGsgYy+8lw0n/B59RUKfaUD5Jwp1XhUp1L2pVz4wRmqLW9CYA56lO4RYFn9Vkw==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: sudeep.dutt@intel.com,
	ashutosh.dixit@intel.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	fbarrat@linux.vnet.ibm.com,
	andrew.donnellan@au1.ibm.com
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] misc: use put_device() instead of kfree()
Date: Mon, 12 Mar 2018 17:06:51 +0530
Message-Id: <cover.1520849284.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594731707673630680?=
X-GMAIL-MSGID: =?utf-8?q?1594731707673630680?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized.

Arvind Yadav (2):
  [PATCH 1/2] misc: mic: Release reference count and memory for VOP device
  [PATCH 2/2] misc: ocxl: use put_device() instead of device_unregister()

 drivers/misc/mic/bus/vop_bus.c | 6 ++++--
 drivers/misc/ocxl/pci.c        | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
1.9.1
