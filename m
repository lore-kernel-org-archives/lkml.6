Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008B2C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2307206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hkOqPqY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2307206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeI2GNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 02:13:15 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:53918 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeI2GNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 02:13:15 -0400
Received: by mail-it1-f201.google.com with SMTP id e21-v6so3032476itc.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 16:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WYhEGWFlZp8I00fOpL04YdCTY1rewGNsa3hhi7x38fI=;
        b=hkOqPqY6CorgJ4JDlZP7VJpetlKZAbmVH/w7SZ6IhA/I7zCiTHAi9LiNPCyTb9oI2s
         lxjGcJc8CFQ0B0zwd2Q7/33qzCZM7PBHlvqnxnlEPkNxRRYcgTs1Hrta3I6CxaDMqjBN
         bJ5sj89LlhilWwQMUbOTRYHPpMLAVBVPZ88Qcpn/qdiy4kH7TiyNWQVy7c732S6sp1t7
         tU95KAeoyjADInl+7dGjH9uJZ/GUgC96A2WaQZfrhSYlfjb4h4YZoMXCKXvnlt5Zv8S5
         iZUcywCuJCfM9505uXd0xnWxiTBIl020EjuB7B5dyPTHvxOnHgSVm3ebPdNvwfujly/2
         ywWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WYhEGWFlZp8I00fOpL04YdCTY1rewGNsa3hhi7x38fI=;
        b=qz+bKYZitsRO4SV+GoFEDq0/LcezNOvlQueG9XxwMI/Wm8gdzpdvsvJB2mEWvqhFHF
         ipr9uuNE1KWgvjFgISwvDzKO0p4gyPVo2EAUApEWaarZKjOaPQgFQc9S2u8B7fReiaO4
         s6Ryk9qsGu/8Odl4qjWZ7sy00AUB161JbA6dgMs1O7o80f6SnI5UjBS0YwYdAXQ7glMW
         Fznvu3L8f/GJY0zVErC6EI+DqAdIT1Ohzf9uf3G7jUqqb7Q8Go8eipD8GQSdwMwj16rH
         zbwzswP2hUTxf6y1FLW/iskCmXxrJwsyPmgsyiDKlRVv02dpvy78Je8Kz2lGIsiVyBrm
         bOvQ==
X-Gm-Message-State: ABuFfoj5NGQZd7ZR2iMIGT+BnI7MKsqe4IvCfRYNtJOAn6I5rB3D4Fbm
        1rYBxcI+S+7cK4Dgp5iOqsU89cUgF7c=
X-Google-Smtp-Source: ACcGV61g7rrQxKfWIvtPXvSVn+MwINlXGHoXUpuAaq9awaH6fZPuEyNrvr+s465Yw1+yZufP2gnFDzqq0Oo=
X-Received: by 2002:a24:6794:: with SMTP id u142-v6mr197776itc.9.1538178428213;
 Fri, 28 Sep 2018 16:47:08 -0700 (PDT)
Date:   Fri, 28 Sep 2018 16:47:01 -0700
Message-Id: <20180928234703.15970-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 1/3] [PATCH 1/3] dt-bindings: connector: Add self-powered property
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>, Li Jun <jun.li@nxp.com>,
        linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From USB_PD_R3_0
7.1.5 Response to Hard Resets
Device operation during and after a Hard Reset is defined as follows:
Self-powered devices Should Not disconnect from USB during a Hard Reset
(see Section 9.1.2).
Bus powered devices will disconnect from USB during a Hard Reset due to the
loss of their power source.

Therefore it is necessary to know whether the port belongs to
a device which is self powered or bus powered. This change
adds "self-powered" flag to the connector class which present indicates
that the port belongs to a device that is self powered. Else it is
bus powered usb device.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 Documentation/devicetree/bindings/connector/usb-connector.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
index 8855bfcfd7785..8f7a36ae29bf7 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.txt
+++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
@@ -14,6 +14,8 @@ Optional properties:
 - label: symbolic name for the connector,
 - type: size of the connector, should be specified in case of USB-A, USB-B
   non-fullsize connectors: "mini", "micro".
+- self-powered: Set this property if the usb device that has its own power
+  source.
 
 Optional properties for usb-c-connector:
 - power-role: should be one of "source", "sink" or "dual"(DRP) if typec
-- 
2.19.0.605.g01d371f741-goog

