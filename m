Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GJAcBvumGltBFwAAmS7hNA
	; Fri, 08 Jun 2018 15:56:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F0BE5607DC; Fri,  8 Jun 2018 15:56:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlOB1lO3"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 582B4605A5;
	Fri,  8 Jun 2018 15:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 582B4605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbeFHP4Y (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 11:56:24 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:44053 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbeFHP4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 11:56:22 -0400
Received: by mail-lf0-f53.google.com with SMTP id 36-v6so20775492lfr.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 08:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QTvyie+NFQwfLkWlL33g51lHg1HUimomLm3bF7UnGRw=;
        b=XlOB1lO3VdW/IsPfT1eFAjEhHlr/jGipIZxMJ29z9r3XcMt1ek73nuRcdtDj4AX3B3
         mICVSYnu8gN5r3+nFvSHh4av5BAeBdwWTghCGwol04eflKPAwtxolXCdY9SzjVd84WgQ
         UTqo5WxBvGIYGx/2uMw5qxIt5eb9S6EhH24PZJZEtK1FXumjL+wxQizNo0gd7817QcpS
         9Pa9GScvbMi94eQBrfnxfMwwlaNqRXCEAJ+RKmfdCbOsqJlbFdQ0Z+5U7T9l955gDju+
         AXjCEUeT7ltvLzAcBnM/NeuCZqkL114/uuUJIxnrNQzLJVtX6YGeMtadPqRxpyTlo6qY
         0OCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QTvyie+NFQwfLkWlL33g51lHg1HUimomLm3bF7UnGRw=;
        b=i5ii/u1nBPxSwClXLnK4Ikufnh+8aa931Kya4KOer6K7yLwSnjVuSq4iKmuZJqtoRM
         yTI8drlAe/iCk9C/RTpvGl8nyAzAEYqG0EaMAU2v5W4CPMjzI6ayrIRwIPgFqJuuvU+S
         HQk0rH+OeKNoZSnvPVbF+pNqXcOGl6QtAGi1DzzxR4uczqGy6w1i9VyqxNmqm/nL10io
         p3WYAxx6K0MSxQE0/WfIr5EjY258Sd46wbPjv12NTQzK+u3V5GvRcHPSNft0VtfRedUU
         1ztjCR5JgK2MeXWAjz99M5UWX06z8PNqV9LIuFdJYzrxmkPUX3IpOvdOHT/CW1SYz9rZ
         aHwQ==
X-Gm-Message-State: APt69E0ib/i61857/+jAjI1g4DlosUoxtPdZg/8MWKA9IwdFToguUVfw
        L26s5gzq4mJTR+mH7z/9rZPBFDM0bYzoKXfUfarEs9A=
X-Google-Smtp-Source: ADUXVKJpDFXyP81Bm1ZXnl0QBvizt7wC6Wo6g2IGZ0v3kIcGjDLYKNey16dhvLtI1n8VtMXmGdry/foUtsubHCbO8kw=
X-Received: by 2002:a2e:95d5:: with SMTP id y21-v6mr4831930ljh.90.1528473381221;
 Fri, 08 Jun 2018 08:56:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ae16:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 08:56:20 -0700 (PDT)
From: Alex <mysqlstudent@gmail.com>
Date: Fri, 8 Jun 2018 11:56:20 -0400
Message-ID: <CAB1R3sjA97Hd32iJ-6e4qbeAbSSDJNZJQ4+ppAJOTDqH1+jQaA@mail.gmail.com>
Subject: How to determine why kernel is dropping packets
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having a problem trying to figure out why the kernel is dropping
packets on any machine connected to my cable modem and I don't know
why. I've tried posting to fedora and network lists, but haven't had
any luck, and hoped someone could help me here.

I have a fedora28 system with 4.16.12-300.fc28.x86_64 on a Xeon
E5-1650 v3 @ 3.50GHz system, and during regular activity, it's
dropping packets:

# ifconfig br0
br0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 68.195.193.42  netmask 255.255.255.248  broadcast 68.195.193.47
        inet6 fe80::6c26:fdff:fe03:7f7e  prefixlen 64  scopeid 0x20<link>
        inet6 ::ec4:7aff:fea9:18de  prefixlen 64  scopeid 0x0<global>
        ether 0c:c4:7a:a9:18:de  txqueuelen 500  (Ethernet)
        RX packets 202664225  bytes 255532394512 (237.9 GiB)
        RX errors 0  dropped 391461  overruns 0  frame 0
        TX packets 130138618  bytes 91417518889 (85.1 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

This occurs on the other similar system directly connected to this
Optonline cable modem as well, with a different kernel, so I don't
even know if it's the kernel itself. Perhaps it's a kernel tuning
option?

I've had the cable company here and they've replaced the line from the
street and the cable modem itself. Perhaps it's somewhere else on
their network?

How can I determine what those packets were that were dropped and why
they were dropped?

Regular ping tests and tests like speedtest.net work just fine and
show no latency or lost packet issues. DNS tests frequently fail or
timeout.

I don't know where else to go for help or how to troubleshoot this
further. Ideas greatly appreciated.
