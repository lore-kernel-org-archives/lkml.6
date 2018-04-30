Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpKBrvTeuYIljFnmp7tJdYu41IK9DpBh0D46fPCpMKmAV9RYykw/pr31Xfw1AXFuXB4CjBz
ARC-Seal: i=1; a=rsa-sha256; t=1525116480; cv=none;
        d=google.com; s=arc-20160816;
        b=HH1z9oJPdo44srLqAGR3rqz+n5/L1ydJAkvMjxcPtgK6T8/hVwffZPZv5xmG6vtZba
         zFP9lqRJSLfctbZdCxKDNckVqOZixkY7gfYSaWGZuMmIDRzEnQD2elJJ+7fICsbDIAlv
         bI+ho+zxhDr9yS6qE9RgZpTagTkQY/J3MS4vQwvtHcn403ayKh5oOmZTCo0AD36/ns63
         sP914x4K44pW4xWgqZFCQRgVscQOuLMkJVKS+V7uLpQRl/QRPeoxbPbeV4elNeOb/w7Y
         3HqoGAaThOw0HqaVXQgkvNOIdYaaMriYmi6ETh337DpONXNQrs+7P3kLgBREKgJqB0eT
         j5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=0gTBzhqDZBP9Ra7e8JgGVNS71sYcO4OUR5sintK9pYs=;
        b=r9dedVkNg+iQnIEQ5YKLxUPqD2OgRG46mFrcDaYGCWuhZqvIQTtgy4AL9WeSJe/ow9
         GeJQpZRf18rn4OWYLepPDp9B6rtvrXeD5E/fYpV9H6pXOT3rBDLVwEVO2rM49poFTb0v
         T2kFPZ7P82fAWiMqpZua4R1igT5tFHh9zFFS8twM5RxBbuL50mXdrUe4COLqEqNF4NsI
         pFL8Rn4cFpNYnfmAyXJsoFblWL+G5g8E7e5ydbBNW0M7wg9CUjCSmsoa/b2vpcEkMgqQ
         1MxjUzG6bLNG8+xYe0Lyb9XgR3IO+ACKxFVDikJG7zysAwud7vwaJrCe0ihRllsQeRTH
         +Qzg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C0C22DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Quanxian Wang <quanxian.wang@intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.16 020/113] usb: typec: ucsi: Increase command completion timeout value
Date: Mon, 30 Apr 2018 12:23:51 -0700
Message-Id: <20180430184015.932987279@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200475896831863?=
X-GMAIL-MSGID: =?utf-8?q?1599200538596059239?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit b1b59e16075f5e5da2943ce8de724ab96bc3c6c2 upstream.

On some boards, under heavy load, the EC firmware is
unable to complete commands even in one second. Increasing
the command completion timeout value to five seconds.

Reported-by: Quanxian Wang <quanxian.wang@intel.com>
Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
Cc: <stable@vger.kernel.org>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/typec/ucsi/ucsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -28,7 +28,7 @@
  * difficult to estimate the time it takes for the system to process the command
  * before it is actually passed to the PPM.
  */
-#define UCSI_TIMEOUT_MS		1000
+#define UCSI_TIMEOUT_MS		5000
 
 /*
  * UCSI_SWAP_TIMEOUT_MS - Timeout for role swap requests
