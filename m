Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3263C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD2F208D6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nv9YI1QO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD2F208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732763AbeHNReT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:34:19 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:40629 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbeHNReT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:34:19 -0400
Received: by mail-qk0-f170.google.com with SMTP id c126-v6so13536493qkd.7;
        Tue, 14 Aug 2018 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Txk6oWhViutvEe6HaUZP134awYrZYqFog73Niq3QikM=;
        b=nv9YI1QO0G4qIMd9IAokLBJI6PDYw1FB+z7rSGcr+P8erWSzWN0uoRDLEVjbQdtRCQ
         OTtJCP2vI5S/Qz2IuxF4OWefqhNS4+GZkTbBshCLGc1Ry0qSEBf+UDRK0dgh4qHpJVoQ
         /jNI9Knigy3B/OmYbRZiGEJzWxpes0JOhQVz+4ZI1cUZgZOfnJXEjI17qS80yQg5xPcJ
         WdK+Lq8fgVBbwkM9/9+p8yIAdc1jFaTqVrTxe3HuG3pNLZEaLXvuG0+IyFW/wWfBjNuT
         KeImdfZUYu/PWJM0pcNXepf3v1sP1mBPQaALukdQAq4x0YhLuhUH2x2dygLuu76dNmAX
         ALQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Txk6oWhViutvEe6HaUZP134awYrZYqFog73Niq3QikM=;
        b=TMI58VZyRj9fo0iSL2LAG/jSacXwgu5Lg0VOyE05GcD237tUPv2Ze26oSHZM7Ww00v
         GkNnyN4YMhADrwnWZ7v3f7bRlgf65aGiMjoLuraicN8AsX4K2WK8DVPFLKISucpHX+3a
         tTizH50XJUbisNlKPcK2R0XoLtVbV9uaEM4tCh0LYgJJdr0kwS8kLiJeXe2mkwzbsXqt
         YOpHt0tqGGj+EmIvTgI4P6BbrLSSiLpZbTZ2LpZQ9uTCb4z/u7IU4IbOw+8SrY0SLDvX
         iGQx9FRSqMS+89gp/1xd9nw1neTeUBNFp6ua0PwyH/4/Hjq3XtXYYQtOn8jWtJxHCV+m
         MS5w==
X-Gm-Message-State: AOUpUlHu9S1On+iLg+lE9jrZ0HOMsWT9z5TSwnNb3x9HZvZOzqdHOYWJ
        a05bdJ7IuD48pSL2wFIEh/zPFmyAGB6dg9Pd7r4=
X-Google-Smtp-Source: AA+uWPwrphuJwJ3/fbq+YAGFQG+FS25jM+y0R8K83Od6vCPsmwcBYCURxPPOr7Mlbe6o8xJxDlboj43yAKDDTp0LvSU=
X-Received: by 2002:a37:f9f:: with SMTP id 31-v6mr19560466qkp.278.1534258010592;
 Tue, 14 Aug 2018 07:46:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9e5b:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 07:46:50
 -0700 (PDT)
From:   =?UTF-8?B?5byg5rOi?= <zbsdta@gmail.com>
Date:   Tue, 14 Aug 2018 22:46:50 +0800
Message-ID: <CADUUTHBZ---U7YNYYry7qJY=vt_QpXpytymqJQc9xLFE_NjsAg@mail.gmail.com>
Subject: How delete node or property in overlayd dts?
To:     robh+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/delete-node/ /delete-prop/ could be used in dtsi files without device
tree overlay.

but with device tree overlay,  /delete-node/ and  /delete-prop/ are not work.
How to delete property and node in overlay dts?

for example,
in basel.dts have following node
node1 {
    property1;
    property3;
    node2 {
        property2;
    }
}

in overlay.dts as following
 node1 {
    /delete-property/ property1;
    /delete-node/ node2;
}

after overlay, property1 and node2 is not deleted.
