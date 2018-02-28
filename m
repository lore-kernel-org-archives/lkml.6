Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519834563-2-11986870182714307902
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
    t=1519834562; b=FCJpLAtpDTuAROGlayCe7HPpb6ZArTkvVjyuYKQ4/C0+Ard
    ozTXxOwYttX+D755BLgMFklsal21ie0A9h1WAE67ZhJxIctzTY52aZLbKPUpqSxL
    DDcefupwfBMDm9Bxs+l5lDDJgpvNVoKT2WRCVdmUU0DaEbOOzhFUtFxH/FTajNDw
    2olIioxd+ZuUcden21VjUkgHi1KKFTYgO6TG/kSW+42XAhwmadA/18NSa7rW9lFC
    1v4GQVb1RPwOWYw5Ir1iRkS5B/mg2yMqLmeC62CO0NkA43hkZ+PdRRQCvZhEmNi9
    69kjhqOMe/VLNdjQ0esnvnZXm1kw11ANRXde5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834562; bh=KN1jzBD0PTKxlE9TtcQ
    TaeKAKNf0iC+pngeJjdpn7bU=; b=Tnu2F8cGb1cr2CJhAGkVFLgxUA2n+ZsF2ap
    iOUiaCK57la+YljeXNYHsb6BLyJtDBJGy+xj4kcgM1BnEc+nikw01nd39WBjInwF
    byTcq4tRX/U41HizL+Fc6WxXbMzG5IRXbnakyF7b5GxPpyniHw6UXFZr//SssqIY
    i6zoONOoa6e4oParvgOFyQr6gsswbq4zq3MhHrTE8h956asF4zIb7wfb79tRTybq
    3xFhUT+zdEou2O9pCNoDpRMUTZJFEgdSfH5Zf9OB70AElRkn1Bu7fgsQv+101muq
    4Xt1oGvRzCe6XVQEEb3I39JT5zFqCxPoRzs7Um+NJZPbexe3HTA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbeB1QPz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:15:55 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35200 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933835AbeB1QPw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:15:52 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "David Howells" <dhowells@redhat.com>,
        "Rusty Russell" <rusty@rustcorp.com.au>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        "Pawel Wieczorkiewicz" <pwieczorkiewicz@suse.com>,
        "Takashi Iwai" <tiwai@suse.de>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.218771108@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 073/254] lib/oid_registry.c: X.509: fix the buffer
 overflow in the utility function for OID string
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

From: Takashi Iwai <tiwai@suse.de>

commit afdb05e9d61905220f09268535235288e6ba3a16 upstream.

The sprint_oid() utility function doesn't properly check the buffer size
that it causes that the warning in vsnprintf() be triggered.  For
example on v4.1 kernel:

  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 2357 at lib/vsprintf.c:1867 vsnprintf+0x5a7/0x5c0()
  ...

We can trigger this issue by injecting maliciously crafted x509 cert in
DER format.  Just using hex editor to change the length of OID to over
the length of the SEQUENCE container.  For example:

    0:d=0  hl=4 l= 980 cons: SEQUENCE
    4:d=1  hl=4 l= 700 cons:  SEQUENCE
    8:d=2  hl=2 l=   3 cons:   cont [ 0 ]
   10:d=3  hl=2 l=   1 prim:    INTEGER           :02
   13:d=2  hl=2 l=   9 prim:   INTEGER           :9B47FAF791E7D1E3
   24:d=2  hl=2 l=  13 cons:   SEQUENCE
   26:d=3  hl=2 l=   9 prim:    OBJECT            :sha256WithRSAEncryption
   37:d=3  hl=2 l=   0 prim:    NULL
   39:d=2  hl=2 l= 121 cons:   SEQUENCE
   41:d=3  hl=2 l=  22 cons:    SET
   43:d=4  hl=2 l=  20 cons:     SEQUENCE      <=== the SEQ length is 20
   45:d=5  hl=2 l=   3 prim:      OBJECT            :organizationName
	<=== the original length is 3, change the length of OID to over the length of SEQUENCE

Pawel Wieczorkiewicz reported this problem and Takashi Iwai provided
patch to fix it by checking the bufsize in sprint_oid().

Link: http://lkml.kernel.org/r/20170903021646.2080-1-jlee@suse.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
Reported-by: Pawel Wieczorkiewicz <pwieczorkiewicz@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Pawel Wieczorkiewicz <pwieczorkiewicz@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 lib/oid_registry.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/lib/oid_registry.c
+++ b/lib/oid_registry.c
@@ -142,9 +142,9 @@ int sprint_oid(const void *data, size_t
 		}
 		ret += count = snprintf(buffer, bufsize, ".%lu", num);
 		buffer += count;
-		bufsize -= count;
-		if (bufsize == 0)
+		if (bufsize <= count)
 			return -ENOBUFS;
+		bufsize -= count;
 	}
 
 	return ret;
