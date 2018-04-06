Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1291772-1523018491-2-5477701086853737848
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
    1523018491; b=YaUiTZF+EJIbsioyMmyK23C082pLW7UV2EmAc4Aema9r5XuVbN
    eqPTdNhQMLHyDRE8CTUUbvxKrYFIJt8m2dzDhXs6C6mBuuMev7m9tpjSHooxDMVx
    y1xKD3p1R90RNY1Ip7nuaoeNLMrHBaQr5i2hLPoiPBiWG9i4EZHxYd/DcDftKJGD
    p9SsBomns4VCRkD4icCaJctq0G6OjigGPMHuzKC+EkNr1cwbKGa9dFf/DFyfMi4v
    5aqp/Mg9oFST1t/KxjD6/CJK37yV1u8Bnh3jE3KY8B9ZlLRvSg320JbeViIYvDVM
    UpwIqxW1RYE+enx1a+dzMruR6OWPmJnyo1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523018491; bh=Ie+YSVsSsAxDVyKAQzqsEYW9oCRSqc
    bPQ8Z0e6RhdWU=; b=afid4U8rgH5LQ/ihk8W3F1a2LhvS0uNs/4J8E6utwb7po7
    Z/FnWGm3mGapjFxF5PxFCM6P1funuS196BMCXSj57i7ZAZFUjzxKs8MKmNA51Nlu
    pznjuaIBSrqQFCW5SLsoq4EOVumD0HeaQwDJ1Rdy991Rpfn4r0Ceh9v+Y6zfNO7S
    XBBPonUkmsTmmbYP2f6RskLswvLZxipMmva2aFgzA4xTA4VNQB7az6DHa3eutmrK
    lYS3opJA8l5ph8HkDLfoxzfG4fOEBjG+BwyZrFLKlz/O93Q3f06CK7dLxTMy9Joj
    zaGH0HkrSp0gfaIAnA4/y6e7IPubDOSTFhTk4wAA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfJ2ENg71x0H0nf3Ip4ez0CgtINCcZG/ZqB1l9mBF6acIvni6RR01AmwbHW4XMZ4+U5UtolShn90A/iy1kXPB9LtbVq4GiiadCXzQV7he8DtGfllJ9E4q
    0b98vRjNYFre3OcMKFEAo3EJIV9+7JKgc7Mbh+YDuV5my85oD5sbt03HBDoHWST1Zm48QHdNmaTiqX9PjaOq18l9NPVN/0Xu3DVbKOKja1McOiwCWRcXWZzT
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=5vjGDjYnuVaS9vKdJVUA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeDFMl1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 08:41:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:5597 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752517AbeDFMl0 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 6 Apr 2018 08:41:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,415,1517904000";
   d="scan'208";a="44628818"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Markus Heiser <markus.heiser@darmarit.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH v2] Documentation: typec.rst: Use literal-block element with ascii art
Date: Fri,  6 Apr 2018 15:41:22 +0300
Message-Id: <20180406124122.70676-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.3
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Using reStructuredText literal-block element with ascii-art.
That prevents the ascii art from being processed as
reStructuredText.

Reported-by: Masanari Iida <standby24x7@gmail.com>
Fixes: bdecb33af34f ("usb: typec: API for controlling USB Type-C Multiplexers")
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Tested-by: Jani Nikula <jani.nikula@intel.com>
Reported-by: Hans de Goede <hdegoede@redhat.com>
---
Changed since v1:
- Using literal-block element instead of comment
- Subject in v1 was "Documentation: typec.rst: Mark ascii art as a comment"
---
 Documentation/driver-api/usb/typec.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/usb/typec.rst b/Documentation/driver-api/usb/typec.rst
index feb31946490b..48ff58095f11 100644
--- a/Documentation/driver-api/usb/typec.rst
+++ b/Documentation/driver-api/usb/typec.rst
@@ -210,7 +210,7 @@ If the connector is dual-role capable, there may also be a switch for the data
 role. USB Type-C Connector Class does not supply separate API for them. The
 port drivers can use USB Role Class API with those.
 
-Illustration of the muxes behind a connector that supports an alternate mode:
+Illustration of the muxes behind a connector that supports an alternate mode::
 
                      ------------------------
                      |       Connector      |
-- 
2.16.3

