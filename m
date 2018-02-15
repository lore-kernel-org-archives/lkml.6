Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518710898-5-4790253613351037441
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710898; b=FLVbCrnnyQweIMw0raEAL51lo+PA97Qf/j/n+POuwfKpbGU
    +ZZC2me27jSLIfpqEDntyaw4YotVUI9tdkxFj4esbWgrvZxYQu9rHD1f9H3O+Brn
    sii5132cv3yh07LLe9nz7fOtRIpL7J+LwDaByxypp3BM218ZHMqbJuVI2qI9Bykr
    0BdhpeT+HBODRk9biofMavyOgvUt4MOudlRroxtuFT0NAiU403GgfUHlEv7gzuaw
    ltrsSwWFRG9wGCI12m5hZGAvbsV6bj/LC+VsllVqRmB0zWn/XWCeLBS404FPox39
    89i2XwRybDEL/2L1SbiHUIQqr5oGdo+uaH4gKww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710898; bh=7BXcOCWnrE7NBfxr3gIzV/irzk
    ypEqpaGcazBTq/4yU=; b=AlaTh+iWwKjLfs8XdK1n1ePhLmt0m1eEi5aGT7WeFd
    5+ZW9f3dXFEzmA9tJORDadG3BQDlxIWy1IMrkRw6Qya3DAR/fdTVMplKl3q8OWTG
    dDyAgUga/uH36V+nTWBdamz5UnvbZ6mnYPgxy7NtHaGBVvN8iHHHE/yqh80+RIM/
    nnMyyfQiGaetV2dM321NNNf2nkIUrJr9YRT9ScXeXDyegDtQooW/JdUjfDRDLKA2
    SC7N/185qu0TdQ2C3IWqzrfQqmixaUrVhYXSAhA29TmXMqVdjXyNFgn+OKMmTGBT
    CLVLe37ZbFN4L88ad1QOQIYulWiXuEUzflQP/lr2OVjw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033898AbeBOQIO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 11:08:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35010 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424492AbeBOPpe (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:45:34 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Rob Herring <robh@kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.15 152/202] media: dt-bindings/media/cec-gpio.txt: mention the CEC/HPD max voltages
Date: Thu, 15 Feb 2018 16:17:32 +0100
Message-Id: <20180215151720.914665776@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil@xs4all.nl>

commit dac15ed62dc9d7898d3695a3c393d6f712d66185 upstream.

Mention the maximum voltages of the CEC and HPD lines. Since in the example
these lines are connected to a Raspberry Pi and the Rpi GPIO lines are 3.3V
it is a good idea to warn against directly connecting the HPD to the Raspberry
Pi's GPIO line.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/media/cec-gpio.txt |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/Documentation/devicetree/bindings/media/cec-gpio.txt
+++ b/Documentation/devicetree/bindings/media/cec-gpio.txt
@@ -4,6 +4,10 @@ The HDMI CEC GPIO module supports CEC im
 is hooked up to a pull-up GPIO line and - optionally - the HPD line is
 hooked up to another GPIO line.
 
+Please note: the maximum voltage for the CEC line is 3.63V, for the HPD
+line it is 5.3V. So you may need some sort of level conversion circuitry
+when connecting them to a GPIO line.
+
 Required properties:
   - compatible: value must be "cec-gpio".
   - cec-gpios: gpio that the CEC line is connected to. The line should be
@@ -21,7 +25,7 @@ the following property is optional:
 
 Example for the Raspberry Pi 3 where the CEC line is connected to
 pin 26 aka BCM7 aka CE1 on the GPIO pin header and the HPD line is
-connected to pin 11 aka BCM17:
+connected to pin 11 aka BCM17 (some level shifter is needed for this!):
 
 #include <dt-bindings/gpio/gpio.h>
 
