Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527155941-2-868085619557951533
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155941; b=i1hfJwN7CVQyW+yXw0Hnbi93EqdGfM1wZkhdx1mzcY/oYTF0Dj
    n2+xn8KwYQedoYOvDyuvFvaZz8ejgFiHgicjZ1aWNlE2Znsyt5cXgp5JRtZ67HSt
    Tz71FdJ9fXzuvMyuyUh4n6wqlz3IXnj5yYuHXvEdLe8TOFO6X6yT0avk+L2R+T7T
    21wxgSbzcOGGDHxEMtppUiGZetWWHq+QdU1GcHJG3mnXqDIPTRlpfA5kk7/RlkM+
    DmjA2+ykJ2ugWQTEoJZGS6HfPxOFcyYg64XkB/S4aa7594T2e0/e3tVADwlDkTBW
    K8r6yWeC536A2JINtvqaE5C6/1P3P3bz6L2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155941; bh=snNWrHMJUdMG6lnNA0R9NC808IQ75k
    YMNGvYxJWerNU=; b=L5VRo6LDGJQwlwommCv+TVM1H1e4cnsoVQbBpRdg3Q/A/R
    4mCPTuMv06pgLY6ItCSdzuPSaGW9FIMrjEW3+5NPSkbxnJFCCNj4jNgMBe3YXF9R
    bkVQ4ka3ZbbnY2enIjPnNPedLjbdms+369bfzl8sd5KZ5MY6eevUaiL0s3yRkpMw
    qkb9popZWv8zxzydWFZYvpsfP7U75WiHvXq0mTEAF4OMD2R7VKX0sqbK/HL3gQ9t
    EDaLLo7+iLpu47d6KoXv6dJgJXoQvFdX+dNeI9iredUiTTXEDbSex9adXeBmgSQq
    s+uHlijEp+TAMStZ7hhlF+nLz3uE3BTYQW6jWjgQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=B98z3hoy x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=B98z3hoy x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPeMPrw9oHWA79oHt7gi75z66QFbBM/GDDY1D06RDw7AkCCoOBL5AhPdyr78wifQNx5BKEpakzGewOjtGiZLQRPMFsN8W/cMd1VUkgRqXJ34gT/fRjOv
    IDwU8LIWpKaBYrmAu5m+jzCPHdOko7o5Xx1NuW5MeMDYgzkTVXaTp6i2R+jmi+YdTodGrBlq7V7PApC6E3+XTgLwMwPiE0GhM+pYXmlUKiV+ezYb9uh1g3Bv
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=H14h7lNoW1mxTpCc5fkA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030700AbeEXJ65 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030662AbeEXJ6w (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:58:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 156/165] serial: arc_uart: Fix out-of-bounds access through DT alias
Date: Thu, 24 May 2018 11:39:22 +0200
Message-Id: <20180524093628.387579696@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit f9f5786987e81d166c60833edcb7d1836aa16944 ]

The arc_uart_ports[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Note that the array size is defined by a Kconfig symbol
(CONFIG_SERIAL_ARC_NR_PORTS), so this can even be triggered using a
legitimate DTB.

Fixes: ea28fd56fcde69af ("serial/arc-uart: switch to devicetree based probing")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/arc_uart.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -596,6 +596,11 @@ static int arc_serial_probe(struct platf
 	if (dev_id < 0)
 		dev_id = 0;
 
+	if (dev_id >= ARRAY_SIZE(arc_uart_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", dev_id);
+		return -EINVAL;
+	}
+
 	uart = &arc_uart_ports[dev_id];
 	port = &uart->port;
 
