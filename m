Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3343915-1518627896-2-5996147384583280337
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518627895; b=jC6LhaxHO00jtaGEFpS0GgU5mMOfvqH1WPL4hLs7ENh2bIo
    mxjafg7Nr3i7ryNDEmjFUfWkmxmDvFYV44BBWVZXS4tsrNU9IslwH4HFpJ2ltu9A
    r7dgM8ZJf5zZ54lrfbyelf0Og9Lfzt1RZCkrqW8nuTxDyEto4nvbfC/vnszorb9n
    zuAEpLm28/zRtzb/tc4PsTf/2r9tdJvpP6zFe25h9dwHcOzuAbxwnJDX6fIG8Ha5
    8nLpiQM02GcnSUXaeH3nJo0YDsHAfXMydw3Z/mWzEXxJdqeUn2ZS4X9JLns0sspb
    uyfrMMGx9OKVvMK7PZcZtOGL9mexvAMAJSXK9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518627895;
    bh=BL0ncKgwa0GLlS5IOqhMNBSzT5AMwd0WsZ/2iUfauE4=; b=PNclwdUkknzJ
    t9Lbxw/LYLNgb528zdg4IdAmB5p6C+CDh+u/+84v0I89av5dqRaN07xyi2CCCqhT
    o89GbQXf00GyELzJHtNqOzuly0cE/t0jnPPY7vVaFtzWqpMDNEEmiYLnhRv9H/5X
    PG1vz6TZudZ0n0Rq06nLYTfR7kMzZSnH7cNCpVV+uZfkbJqK2fJX2WW2QyWREpQu
    dVxk/QN3yY1ec4e1CqHsG9XJDTz49YfAJiZ396+WG8WLtAgpBxhCT+SYm4NlUCs+
    h7PULcOxqGFq0A2Zz4hQURds7CrUIt5oNpoKDaEWGxmsJXgOQJvsGXaLxTJJ8iCr
    9FcdHOiXoQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=metanate.com header.i=@metanate.com header.b=NFP1tcnw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=stronger;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=metanate.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=metanate.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=metanate.com header.i=@metanate.com header.b=NFP1tcnw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=stronger;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=metanate.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=metanate.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033294AbeBNREu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 12:04:50 -0500
Received: from dougal.metanate.com ([90.155.101.14]:62429 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032907AbeBNREt (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 14 Feb 2018 12:04:49 -0500
From: John Keeping <john@metanate.com>
To: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        John Keeping <john@metanate.com>
Subject: [PATCH v2] usb: gadget: f_uac2: fix bFirstInterface in composite gadget
Date: Wed, 14 Feb 2018 17:04:33 +0000
Message-Id: <20180214170433.26425-1-john@metanate.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180112184332.28138-1-john@metanate.com>
References: <20180112184332.28138-1-john@metanate.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If there are multiple functions associated with a configuration, then
the UAC2 interfaces may not start at zero.  Set the correct first
interface number in the association descriptor so that the audio
interfaces are enumerated correctly in this case.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Krzysztof Opasiak <k.opasiak@samsung.com>
---
v2:
- Add Krzysztof's reviewed-by

 drivers/usb/gadget/function/f_uac2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 11fe788b4308..d2dc1f00180b 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -524,6 +524,8 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 		return ret;
 	}
+	iad_desc.bFirstInterface = ret;
+
 	std_ac_if_desc.bInterfaceNumber = ret;
 	uac2->ac_intf = ret;
 	uac2->ac_alt = 0;
-- 
2.16.1

