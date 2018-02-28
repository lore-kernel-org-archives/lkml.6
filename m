Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519833302-2-13509902199287746419
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519833302; b=KOMGBH9efY7wMkEfP+RoAJAjVaN6haqYkDCwkoukM50A5Do
    chRuhel9trDLPZf1+i4v9QeaOU3hNed5e/gI4bqrsn8BAQZO0liVRDTOT4Hu6DVD
    6awehu/VYbYIuOgkRkFlnNeuZi32milowJ7LlozSVleLQNlsFw8VmMCLBGdxpx/Q
    FQP8AcZ08UpuzDeqi2ojoZKNA9XXjPyXzdCIZ/+Dr+4LpHVTw9N+F3wIfI+hYXSI
    N0SaI/RSbofPKVahV6dMwwIyOHUOiNjtOpySA91rIRJGgfTK3zUlyz3KbYdwSSus
    lu3Ylib+oUDOjUL0YkpRSNDpMsHkT2mc18k6nsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833302; bh=GiABRYF/qz1faShJdSg
    cL+bK32w3OMIjG4IygKADs3k=; b=kvDN+4ZiX/4lwAnNZX+6ZLWlgASA2WYO4B8
    CBYA6LCHSXO/XqZsoAiwT4s9KiZXN+0ETa36wswC4mG9f45DSomHa59l86p19QMc
    jxV9Ir0lIhpw+tlqXGC+5IoBpPcJwbV2byic2Ul2/mjloZfO6DjyCw/sxsWNi4NI
    6UEAg/fTz+ev5DRjwSB2NSiFFvGILQUc978MQ7aflPzfZITF7DwNXcyUc9zVTXP0
    U+pKDkUTzyvVLSjUKfOz30ezR29qUHz52bcZOOaBRYu6hfLd83oW+YoHnFfX0UWh
    rCvtf8XHMBeUnASOC4JQu7p8h7+jinneteGuryJhYWlsIk4gKZg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933778AbeB1Pxc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:53:32 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34454 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933975AbeB1Px3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:53:29 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Colin Ian King" <colin.king@canonical.com>,
        "Alan Stern" <stern@rowland.harvard.edu>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.307034830@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 022/254] usb: host: fix incorrect updating of offset
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit 1d5a31582ef046d3b233f0da1a68ae26519b2f0a upstream.

The variable temp is incorrectly being updated, instead it should
be offset otherwise the loop just reads the same capability value
and loops forever.  Thanks to Alan Stern for pointing out the
correct fix to my original fix.  Fix also cleans up clang warning:

drivers/usb/host/ehci-dbg.c:840:4: warning: Value stored to 'temp'
is never read

Fixes: d49d43174400 ("USB: misc ehci updates")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/host/ehci-dbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/host/ehci-dbg.c
+++ b/drivers/usb/host/ehci-dbg.c
@@ -850,7 +850,7 @@ static ssize_t fill_registers_buffer(str
 			default:		/* unknown */
 				break;
 			}
-			temp = (cap >> 8) & 0xff;
+			offset = (cap >> 8) & 0xff;
 		}
 	}
 #endif
