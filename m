Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518323830-2-11218513792543542805
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518323829; b=gz3X878k+xR2oKbDYw4dTx4QwXsKkv5vvr/vCdHtzyt5GgK
    BddiajofDOz5rUPM/+0uNexVNUVFQPNmW+1JSJT2h3GTGdcPLqC1NNXsnxtqFoo+
    3MOOxrSBg3LmDNSqnGbwk7I0jXcjZLh40myPUC/X7ncrZmPA6Go7L6tEArBlZitH
    prZozuDA90tx+fSTbp3B7hRuDuvGLbcpVA8Ye977pOwDsShpq/qkWVZGYWx3Eo2D
    TcV6SNjAp1CFIsV6fi0y48E4cAT8zFJEQjd7k+4DOfwm0lMKuteNP2c5QCcAL3G4
    bm4uTQfHbRWYzgVTPmgaZBBPnHUDP7uWqo4qY7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323829; bh=XBZlk2wUKbl5smub/cr
    RWvUKtsp2e6RTeiaw9ORZU+k=; b=G05ZpbsaJZdGQCzwwYmx7kRIDpqUE7Bh6Xh
    bPI1J78vPhHEKjwlYDD5KN2H5gkvCK9UZYK1kySeAAVQBv5qByZv+QJNG1wpWPTV
    TjrklQw404CEPmVev1E9+kYTfUz0UrVefAopNIjeWs4txidVYp2YcC+0dtTgS1Ez
    /qoI7n7GLIE1Q8DsYgq6PItaEx2+jFC46RqHUL1yhekvZ+xIDqRAhYT5+Ka0GloX
    CkR4S/i4NazlsyzWRLgjP2WKuizLu210y53l5PvRTFBYBhfJGdieXWcdMvLldULe
    +PehSg41boZGp0zBSyP50R9yq+uA0CiAmAUuEhrqjF40kYKPjVQ==
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
        id S1753254AbeBKEfE (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:35:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41758 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752994AbeBKEeM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:12 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Andrew F. Davis" <afd@ti.com>,
        "Mark Brown" <broonie@kernel.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.72761852@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 068/136] ASoC: cs42l56: Fix reset GPIO name in
 example DT binding
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Andrew F. Davis" <afd@ti.com>

commit 8adc430603d67e76a0f8491df21654f691acda62 upstream.

The binding states the reset GPIO property shall be named
"cirrus,gpio-nreset" and this is what the driver looks for,
but the example uses "gpio-reset". Fix this here.

Fixes: 3bb40619aca8 ("ASoC: cs42l56: bindings: sound: Add bindings for CS42L56 CODEC")

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/devicetree/bindings/sound/cs42l56.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/devicetree/bindings/sound/cs42l56.txt
+++ b/Documentation/devicetree/bindings/sound/cs42l56.txt
@@ -55,7 +55,7 @@ Example:
 codec: codec@4b {
 	compatible = "cirrus,cs42l56";
 	reg = <0x4b>;
-	gpio-reset = <&gpio 10 0>;
+	cirrus,gpio-nreset = <&gpio 10 0>;
 	cirrus,chgfreq-divisor = <0x05>;
 	cirrus.ain1_ref_cfg;
 	cirrus,micbias-lvl = <5>;
