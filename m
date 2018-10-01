Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAD3C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4580B208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S0Ix9PzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4580B208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbeJBCY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:24:27 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:37834 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeJBCY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:24:27 -0400
Received: by mail-pg1-f201.google.com with SMTP id h37-v6so16818767pgh.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 12:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=udaP/p7JA9sNL+94no8kNxyGH61VvMpNqCPfAcizEOQ=;
        b=S0Ix9PzTeTETWVziFDdenMCFKp59d3063s6Q3p66CGtdDDrgLFYv//FBKxq9nreyDs
         1DeDB/pGJDG6yFo2WurfoseLp8O5PDdzwDU4GconXQd/IsGVt65+XbELa6+rctijCUQX
         JVDn91lhYwdBZ9Jy3QJ+FyVlrVGg0gQ2ZWzcouzxsIjO5SGQk0F3BmLaXln8dHrdU+yV
         F9SVkgm2JpVBD7uQChCMli3fY54JlnZ/7dDj5Tc0380gtFHE84S1LCo0xF0eGqnxbu2f
         GD+JOPT0lr5LpgOXPmOaChPDL3CpKaFby1NF26+lUhml0hivoW3avhM2xZ9NKCfYDACT
         yptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=udaP/p7JA9sNL+94no8kNxyGH61VvMpNqCPfAcizEOQ=;
        b=AofWm7R20ji31QvRfnESGrrw+K7sbynWsclAOOuIEAZ0T3ooaihvL0Lyd8lNgng6Tp
         ElAx0N8iytTvsoqHf3zvMXBwnwVg/wQPfdqe1mMkCZ/BRo/4JtOF1QBJMlre0oU6ZILu
         HZ+Of6YTn5oReJQf7jT6xkZSGVyzw3CBB/gTpISx5YpInV0VCLAJLoS/H0GS3ZYojase
         1+VpcKxiyByiyGtwzjdzlphERtWbtsDlxN5I3E3v5AISBSUdFUfTsaotaVBHy1R8HuQA
         6AwjlIuP0kZgOpOnigaAoS/2c1DSheSroKU9h/1JfJ2uIwtEb22lIdw2XeVHtljd227x
         7GCA==
X-Gm-Message-State: ABuFfoj3oSre+B9GU3ATjI7vdb08o4mQ8lZO0LOS3nJksdQHAof3XjIj
        P3tPmirrv7hnKQSPFwwEVktL9R7h+zU=
X-Google-Smtp-Source: ACcGV61R2rvneeiFmOjqbPXQy0Hxj0PyIruH0rAsK13hgcu2ZoZyzVfSvLmOKMua4msck+l210dCjqEWAeY=
X-Received: by 2002:a62:ca1a:: with SMTP id n26-v6mr5695133pfg.15.1538423105823;
 Mon, 01 Oct 2018 12:45:05 -0700 (PDT)
Date:   Mon,  1 Oct 2018 12:44:59 -0700
Message-Id: <20181001194501.58338-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v3 1/3] dt-bindings: connector: Add self-powered property
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>, Li Jun <jun.li@nxp.com>,
        linux@roeck-us.net, jackp@codeaurora.org
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
-------
Changes is v3:
- Rebase on top of usb-next
- no change w.r.t to this patch. Same as previous versions.

No v2 version as the patch was introduced there.

---
 Documentation/devicetree/bindings/connector/usb-connector.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
index d90e17e2428b..a9a2f2fc44f2 100644
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

