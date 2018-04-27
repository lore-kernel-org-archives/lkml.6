Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqTeUG5mSWlI7JA1sAXSW3V8f6bx9ZP8NdqhWo1ElvrActzMu3RIGLzJWFMavWADKK4JY0M
ARC-Seal: i=1; a=rsa-sha256; t=1524838036; cv=none;
        d=google.com; s=arc-20160816;
        b=LK+209I28S3z7ZUd+hFT5lVOAIJMrDD1jyDAk8FGclxSIe1UhC8yUTUYfzDbMvGVpx
         AG58ZbPoCmtwjS5gUEDhvijZH+ZgkVtZtjSfB4NVInPLZFGMOXATYuFK2TNEcQPnOlVu
         nddCbL4nxRbO+HQQvyMkJWlzUYSZchOXWjeO6+f+pEtDzKCxzSN6QCJQ/p7z6UAypHr5
         8DiB0POUJYf78gcKBTlKujzWVpfQKdWmZij8GPtauSfDNWrCtdrRxnH0mic9iW09LVpN
         7HtfWjP5+egbWv9jO4aYyQKXnuG5H0MpjRPmIBXEJcHPQTIk7JdeUyWKHRuyAvHrOP8n
         oRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=J6JExNHnzpYYXlMlvZZJkU51+3jyV1IE8kr8VEt5EQw=;
        b=j0cnzjBKHWVjqKRkPqWcBQAKl7HFOFKiIRH67xTV3FTJM4/mpVwEnDslsZizVQEawM
         kXC/4lhnHgitwFrwfiwMFPgqstNU3o2fMCQBtKAbBPLBYr8H+t14dEbnyfXE+c1c49mb
         o9QGCQnTYTUdDQBmVDpe7AP52HY/9vrDBihXkoFE0DBphMRnsi1UUiicFq4Ttn6Vojnc
         WzmADQHfmYXJaQjOVFWfVrmbxUkGqVw4gsZr2mpJ8eniXOFrOYZCsSxc/rmhm7aQcaQq
         lokXGDs5KXEw3bG3Jx7Ni/bqrKxEFPocFQDQQhbyG1mMO16amSFMvjTOMj8AMwQP+OY+
         669g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25033218BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 4.14 05/80] tpm: tpm-interface: fix tpm_transmit/_cmd kdoc
Date: Fri, 27 Apr 2018 15:57:58 +0200
Message-Id: <20180427135733.204232204@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908568508310439?=
X-GMAIL-MSGID: =?utf-8?q?1598908568508310439?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Winkler, Tomas <tomas.winkler@intel.com>

commit 65520d46a4adbf7f23bbb6d9b1773513f7bc7821 upstream.

Fix tmp_ -> tpm_ typo and add reference to 'space' parameter
in kdoc for tpm_transmit and tpm_transmit_cmd functions.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm-interface.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -400,9 +400,10 @@ static void tpm_relinquish_locality(stru
 }
 
 /**
- * tmp_transmit - Internal kernel interface to transmit TPM commands.
+ * tpm_transmit - Internal kernel interface to transmit TPM commands.
  *
  * @chip: TPM chip to use
+ * @space: tpm space
  * @buf: TPM command buffer
  * @bufsiz: length of the TPM command buffer
  * @flags: tpm transmit flags - bitmap
@@ -544,10 +545,11 @@ out_no_locality:
 }
 
 /**
- * tmp_transmit_cmd - send a tpm command to the device
+ * tpm_transmit_cmd - send a tpm command to the device
  *    The function extracts tpm out header return code
  *
  * @chip: TPM chip to use
+ * @space: tpm space
  * @buf: TPM command buffer
  * @bufsiz: length of the buffer
  * @min_rsp_body_length: minimum expected length of response body
