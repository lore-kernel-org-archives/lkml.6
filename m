Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpUZRAhJ9eGSwAbn/DuAJ2AAk2Yjh4m0tmh2Bj66+Hko66igd0CFCOWoDi26HvqZ7AyFzrW
ARC-Seal: i=1; a=rsa-sha256; t=1525116420; cv=none;
        d=google.com; s=arc-20160816;
        b=NPm83AUWmnWUZ2HTwbYHj4/Jr647u52ExWAE5FlDyMw3h/52D1E9L/ecWFn6wpuhRM
         6cHvYx+jXYYMO9ANqQw6Je0xZKqXuPFkxDgmv/fhN5lKZWpIjUEXvD/vAgjqtlwUb7x0
         6bzya4njVQgbKyR2JIcLo/s6MCw6HoYEfGgpV33lmuVrsGZoPUy7CE6KumkiioTolEKC
         8U3ThFCeBhr9lyjBJOTG0jCn81sl9HvEGPSYDhu//McunlrW1t1BanFQi9dzcXTOH7Q1
         s//dQBA+Gq7Xh9NCIDzoX7IJaQeN3w4+cHDe8fqtIdcFE+aD41O5pzSRFgIPFEBEEDvm
         8ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=89LpjdmtO3Ud1A48G16afZ2lhsxvnmBUew81iOxv3XM=;
        b=yeUrCtG4m3zOEc41Xj5AkGXVpg4oGC4lUWCBUGWD2XuREgnyw1tDnMTKuKvR4Bb0rr
         9+TVSeM3CNJbhkenwtWOzbvCcQqEMZF63KDwu1hqVPqT81DCainXlJeLHpj5IoCGEK9i
         yLCLgSzg1CfsyZLP15+gb5IWbpmmbkq/+J+4DU3mG8rtTrzsx7nZfvX/XZE2GvCIxv9a
         LzlUlD+7zo8IfrwIEA14E4ldPK1dzItnc2h6Peskze+budymhs/RtjMBNWcXumC6O3J2
         C5bTdQSdNaag4BgBiwoP1vyhOzC2RD71evvD5BD/rjoXps1MjAIECv1Y+wwD2onUKgsd
         iIPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3942622DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Quanxian Wang <quanxian.wang@intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.14 18/91] usb: typec: ucsi: Increase command completion timeout value
Date: Mon, 30 Apr 2018 12:24:00 -0700
Message-Id: <20180430184005.166878717@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200475896831863?=
X-GMAIL-MSGID: =?utf-8?q?1599200475896831863?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -31,7 +31,7 @@
  * difficult to estimate the time it takes for the system to process the command
  * before it is actually passed to the PPM.
  */
-#define UCSI_TIMEOUT_MS		1000
+#define UCSI_TIMEOUT_MS		5000
 
 /*
  * UCSI_SWAP_TIMEOUT_MS - Timeout for role swap requests
