Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804264-2-7882024578500396896
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804264; b=rknn+0770QVR07BZVhYw91PaJW8HiaXMikafY42BLv0eb/u
    3n5Z1sk6fZFSaji7CrG9B5A1yCzfG053V/2X4JJ+4LOWsiZuQ9gaE152rIlVQsvC
    bEqq3Oynw1JWV6xk1plwCZSO2sPXT7pf0Enx5hn4i80cUrfE+eCCC1JlkDQxIKyc
    hUpmcNtc5yiOmur9vAVZcy2Zrt+fdlm9429LLhMNj2fjwnRWrCQchhFHdLcE2tY6
    FrMZ3BGK2YI5J+a9L58TnyrAw9J+QPHjbhNYA1y4y+YxWZOzpAImRRC1FOd4gY2x
    Vi2+URP6JySWgW7FVKmaee0BGYNTllC+WUxZr9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804264; bh=J5gc2FS4lxmcho2jvN7o1RJ7QP
    9Izsq4ZjE19YHIkAA=; b=dERt2oPGluClFeJtvEgc2+HHYD8a6vRchdE4vZYWYT
    WwqSpcjOrw62PJZWsK37ewtRLbBqALlTcwmK2iJZsbC7o6bmpxF7/oAAsTyzsXEK
    QpX3DtSAhCszTEXUpm9IvtXpkrFzEuvTqh2GDwHzQgLYLhBtQri+9pKTfu+9OeGx
    3cfNZob1lgHlP1UjIGYPSVTdI/J18RRPl008WE+WR6KiTwhbtt2t0ckIbpcGeUgi
    kEjWadWLe3aobu1byG9tfNazvAJFfxioV75pzrIsZyKhExDKugwkQGU6O2MbK1XE
    3lhAAHrilkMV4Mm2ex46orF5W6XCxGoxES3Fpwb3M23Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755338AbeCWKHt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:07:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41382 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755375AbeCWKHr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:07:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rask Ingemann Lambertsen <rask@formelder.dk>,
        Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 083/177] dt-bindings: mfd: axp20x: Add "xpowers,master-mode" property for AXP806 PMICs
Date: Fri, 23 Mar 2018 10:53:31 +0100
Message-Id: <20180323094208.965444792@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rask Ingemann Lambertsen <rask@formelder.dk>


[ Upstream commit 8461cf20d17e0090e9236b73d25b31be4f7fadc5 ]

commit b101829a029a ("mfd: axp20x: Fix AXP806 access errors on cold boot")
was intended to fix the case where a board uses an AXP806 in slave mode,
but the boot loader leaves it in master mode for lack of AXP806 support.
But now the driver breaks on boards where the PMIC is operating in master
mode. To let the device tree describe which mode of operation is needed,
this patch introduces a new property "xpowers,master-mode".

Fixes: 204ae2963e10 ("mfd: axp20x: Add bindings for AXP806 PMIC")
Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/mfd/axp20x.txt |    3 +++
 1 file changed, 3 insertions(+)

--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -28,6 +28,9 @@ Optional properties:
 		  regulator to drive the OTG VBus, rather then as an input pin
 		  which signals whether the board is driving OTG VBus or not.
 
+- x-powers,master-mode: Boolean (axp806 only). Set this when the PMIC is
+			wired for master mode. The default is slave mode.
+
 - <input>-supply: a phandle to the regulator supply node. May be omitted if
 		  inputs are unregulated, such as using the IPSOUT output
 		  from the PMIC.
