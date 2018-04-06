Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-878918-1523003007-2-11871965229103478367
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523003006; b=lwVFSRos9yRXHghZ7+2+Ih97cLUdizuAsoSEm+g/1KxG2v+Nta
    26eRzw4CsdaJ0k/RrWDd3dHKS6DpMruztlQAWXmpm3tsSzURXpxeoERz0JGXbWNy
    qJKY82yl+iDXTQcBCAzVZN82kDc7Rqmnbs1mBNIiZ3tv4tgePuJxyHtc5hc4BB9V
    5KMy+aDSZrrlho5dfXWUTVqMiScFLWmoVllVeM1IsO1EFyc0W2roLJTMPtXdR8Md
    Vfw9tCQ1gv4i71+XH6G+qh4kuPATjTJS2gmArEPbmBEB0VTVPiYJbx0e/wsS9ufM
    8bDlolckhIxvgMG6O72igeQUXlCC9MIAuFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523003006; bh=Av13z372LLILNwuCPocV2WknaeB+j/
    UaXmLBGpRapYM=; b=NUuXWy3LH382CA/leOrc+nGWezg6v2ODhA1LENxDP95CjK
    B7ZG47766YzlTAhYppVwEVb+5neIXkywgCpIY08OYAJBNCQJW06CIKt1rPZOEQoi
    TRtzAoy1gVEcwBkoUzJ9cOSkYNqHU0M1jGDJUsrE5kMSylk2//Axd1TRhfMuEeTQ
    z4KxLHX2YwPFSeOSvd80vjSnCeL9y5z5CMA0jU6dJnqa2S4wzDl8ymibI1/xIlK7
    gW4C/gUBmPNwwoR38sOdAItedERxQCpZLJz6PHw/c+Pjm0+xED///4kAJfYdKdjJ
    z2Hg0O/xtDU4R8KuzthJIL/TVJ5pRN7DdkT0VI5Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAKqFkgQk1kslRI+Qg9i2t4G3Te4LBpPk3qWjvUpe0GechJtWR6T9Faouhkx6X0Y8BltuYs7RvUpeuMVWS6jtaRdX6gj/6S4fxeM7CgEBc/5GfOsX7Ka
    4G+6CTohBm7FQ+oR6dGhrf2xlamoHu5gI0nQgbax7VD4+jtziw6HsdPQtMQA0qmHzZZN6SeEpHJ8cq1qzXySSqeiqR6om0ZgRceyHHFSDy0hTPxfcXfKnPN5
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=FILhe0E5uq0Vktr4X_UA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeDFIWe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 04:22:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:49294 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751201AbeDFIWd (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 6 Apr 2018 04:22:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,414,1517904000";
   d="scan'208";a="44584113"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH] Documentation: typec.rst: Mark ascii art as a comment
Date: Fri,  6 Apr 2018 11:22:29 +0300
Message-Id: <20180406082229.55375-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.3
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

To prevent processing of ascii art as reStructuredText
elements, marking it as a comment.

Reported-by: Masanari Iida <standby24x7@gmail.com>
Fixes: bdecb33af34f ("usb: typec: API for controlling USB Type-C Multiplexers")
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 Documentation/driver-api/usb/typec.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/usb/typec.rst b/Documentation/driver-api/usb/typec.rst
index feb31946490b..972c11bf4141 100644
--- a/Documentation/driver-api/usb/typec.rst
+++ b/Documentation/driver-api/usb/typec.rst
@@ -212,7 +212,7 @@ port drivers can use USB Role Class API with those.
 
 Illustration of the muxes behind a connector that supports an alternate mode:
 
-                     ------------------------
+..                   ------------------------
                      |       Connector      |
                      ------------------------
                             |         |
-- 
2.16.3

