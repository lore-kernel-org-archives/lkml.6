Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AG47ELs4lqS+QWJ7AUBKmgZgowJToZGABS5eWeTM6a7M3iFIIJbK9nE+7FmdtKj9P8walqnHmQRr
ARC-Seal: i=1; a=rsa-sha256; t=1521476831; cv=none;
        d=google.com; s=arc-20160816;
        b=Qdjf2xSt0E8akMRWzFCzqdVf8HI0VOUVMzrd/Ip0nQ77H1VGizbtzJe5MFhnzd3J75
         ijMSet8vWiRa9RHkaMCCKzvAOJOR51evSuw2UtAUlYB91iK90qlhqY+irvYIl8VzDKh0
         d0lBZAW4nYr+JGDF1j0o9005d+13XbXBQ5RRlXQEJl/d2i19DaTRswfpgI4FDzcyFQcT
         tNWQPk5HsBMGmoUBAKxln6VB2vHS1BYcqUedUUzpC++pdOHHvQtHAPfMD/j0X9xc4VJo
         y9RzUYaOG4U6D5TIoptNLjdGJBA+X9pVP3jMCWq6HbK9ySMdYV6xBSom544oDEezC6Jv
         OZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=kXtK73lruWu8ioQzAd6/q/RJTTUnPp9SHYvbL2lEbnk=;
        b=r+m/IKdeguoG864VsZ1DdWS7j7bpMfKsfQv7vq8e2kYl8smeFrJWVUOeOZuSoV1G52
         QAEFA2WzQEEnf+pR10pyrqQk7EBcz27QLtbxssZAzkDpl78NQB2M8tsoLkZHPkz8s0dA
         PRgGyFmdeU+n3hBiOGWhAndfSE2zPpjAxNLPzRLqxdlIWokhS/rtEzx8j8ZjruHWtJRx
         aj7r3PldNdMRo/Rh7VWSjgiAb1PNM1EC4SCGpip4mggYQH43NqfrO62vTtsVxXH3Wh7M
         Nv+125vKxlv8yNn7WjLxpMGTzscIm2aEDLz/eExCT0V9Q28L474PW3LyvTeTk8+KWGvh
         Wgug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="212938683"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/19] thunderbolt: Add constant for approval timeout
Date: Mon, 19 Mar 2018 19:26:57 +0300
Message-Id: <20180319162703.5331-14-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
References: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595384090727043848?=
X-GMAIL-MSGID: =?utf-8?q?1595384090727043848?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We will be using this from Titan Ridge support code as well so make it
constant.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/thunderbolt/icm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 6798516d6474..1c10aa8d224d 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -41,7 +41,8 @@
 #define PHY_PORT_CS1_LINK_STATE_MASK	GENMASK(29, 26)
 #define PHY_PORT_CS1_LINK_STATE_SHIFT	26
 
-#define ICM_TIMEOUT			5000 /* ms */
+#define ICM_TIMEOUT			5000	/* ms */
+#define ICM_APPROVE_TIMEOUT		10000	/* ms */
 #define ICM_MAX_LINK			4
 #define ICM_MAX_DEPTH			6
 
@@ -260,7 +261,7 @@ static int icm_fr_approve_switch(struct tb *tb, struct tb_switch *sw)
 	memset(&reply, 0, sizeof(reply));
 	/* Use larger timeout as establishing tunnels can take some time */
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, 10000);
+			  1, ICM_APPROVE_TIMEOUT);
 	if (ret)
 		return ret;
 
-- 
2.16.2
