Return-Path: <arend.vanspriel@broadcom.com>
X-Google-Smtp-Source: AG47ELsg9Xrr8e/Tp5TLYasYke/BPQysFf3kBNnCnW5ijK+BjtPoTVplPC3R4UAy489VOmq/TGw8
ARC-Seal: i=1; a=rsa-sha256; t=1521107737; cv=none;
        d=google.com; s=arc-20160816;
        b=CtDcblOw5TMpZjrImGe6V50F7x/zvV2EWt8hpbV0x6D99insrRp5IwZYNx+QV63NvZ
         yis1jYzohTRPyKkqBf8X8vW1vDe7AazvxMO7IrHaLhpnMuiOQtR21dKEICgz0lRzNL0p
         t4wYym3ZiXMgFstXBG+V9XGMomi+M3KictV8blOYUo1FX3f1aX0NozMl2eTZWdNrvGHV
         WLBG3FiNOh/rm8FhD3DYpqhHmYAdxu0GCyLxKJozvAMcgxi5Es815LtIETsvBShLhZea
         SAbQfAXHq6qrYVxSSPfB0iPz1lGrGEWcww1dnG0NIBwqRMMqSytMLBdalPKngio9MYHj
         NDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=/b2NMSKM8dZfhRvLmmwdX7PDP65bnUhggvf7jVmqWxY=;
        b=0GwQ2Dwzn36pij9E7FD9EiqgBbo+98saOzb/2eeyIN0E5kO9VML/lfqLPyWS4rKOvM
         O0mEsqbjW9J775j/Uvs8FCiyEmnLmY/sQu5vMIi4JI7jyLq6yk6ZQ8L/2LIierGxuO3r
         +8AVbB/cZBZS60KpdUv2n86k6cTlc82TArNOj9ymKbC0pJ/Y3LTnNs/dINkVQ89UG0Ru
         VxmA2zb7UuSLzsFMvHCbUEctN7asdCNo87gvqByNR7XnZv50mVde9D8OP4zF3G5+5k+e
         XYrtGtJgwymcG7rULXKr7aWAI5r+Ol0/70Yb3ndSQHqfOuHMaow037YdHTfq6HKxi7kv
         01LQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 192.19.229.170 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 192.19.229.170 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
From: Arend van Spriel <aspriel@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Arend van Spriel <aspriel@gmail.com>
Subject: [PATCH for-4.16 1/3] sysfs: improve devices-coredump description with user-space perspective
Date: Thu, 15 Mar 2018 10:55:23 +0100
Message-Id: <1521107725-25027-2-git-send-email-aspriel@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521107725-25027-1-git-send-email-aspriel@gmail.com>
References: <1521107725-25027-1-git-send-email-aspriel@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594997067406689415?=
X-GMAIL-MSGID: =?utf-8?q?1594997067406689415?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Instead of referring to kernel internals, describe the ABI from user-space
perspective to clarify what can be expected when using it.

Signed-off-by: Arend van Spriel <aspriel@gmail.com>
---
 Documentation/ABI/testing/sysfs-devices-coredump | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-coredump b/Documentation/ABI/testing/sysfs-devices-coredump
index e459368..d5a4c75 100644
--- a/Documentation/ABI/testing/sysfs-devices-coredump
+++ b/Documentation/ABI/testing/sysfs-devices-coredump
@@ -2,9 +2,13 @@ What:		/sys/devices/.../coredump
 Date:		December 2017
 Contact:	Arend van Spriel <aspriel@gmail.com>
 Description:
-		The /sys/devices/.../coredump attribute is only present when the
-		device is bound to a driver, which provides the .coredump()
-		callback. The attribute is write only. Anything written to this
-		file will trigger the .coredump() callback.
+		When present the /sys/devices/.../coredump attribute can be used
+		to trigger a coredump of the device. The coredump contents are
+		device driver specific and thus vary. The coredump attribute is
+		writeonly. Anything written to this file will trigger creation
+		of the coredump. When the coredump is made available under
+		/sys/class/devcoredump it will generate a uevent. When the
+		coredump can not be successfully generated no ueven will occur.

-		Available when CONFIG_DEV_COREDUMP is enabled.
+		Available when CONFIG_DEV_COREDUMP is enabled and the device
+		driver supports coredump generation.
--
1.9.1
