Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3CAC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8232083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtKvuFi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8232083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbeFTCuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 22:50:01 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42072 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753730AbeFTCt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 22:49:59 -0400
Received: by mail-pl0-f67.google.com with SMTP id w17-v6so897787pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 19:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=M0rGZgWWY7dcASiTp0hDxNvg+Zcgxe+cBW6GCM7sAgg=;
        b=ZtKvuFi4Zx5mS1jKGTFWPfH1XROdksRaz4PRn6IpGRqVdsyWJ061lqoLHcmq2W/okN
         pdyQwrsUf922lDonh32uoi2tsnRiBT/9rZuRNrQhobTLB5pQFyZ66RnYdg9GzyqHpBgF
         51T2gB+dcpt4nPeQO0UMseozKlZIo6gW1b2fmOotiEqo8O2oIymarJOVcou8uXQWIrcl
         zaIGG4n2CRUAJUrkJtKlSkmrYeyJ+H5Urtqyl4s+Q8V+5hWmR8BonlkCNo0Ila9Jx8fW
         +sgdi7qyQ7UIAaVQU9zOOHIRcB3FrtqHQDgnHIR+gZryLBXLmH4uUe8pMJ3aFfCzYAQh
         ArBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=M0rGZgWWY7dcASiTp0hDxNvg+Zcgxe+cBW6GCM7sAgg=;
        b=ZvwMUKUFic7YeL5I0JqgZGCL8qiP7TqFzRjeZLIvfvGX9kvFxijbtJcPqS1L5yBdkv
         895olJPg0chs0wAjGoJGltB3zBdwHB6ei2gQhqPchmonEIiUiV8drAVlR+Qz9DyC4vOM
         d83n1sUv6Zz6uPmIlsW7qZKzBHw0kw3yCVGUO0jvVTkd327tdrHImPFs4DbDZAyhxBWo
         GlTmOQns5NeJtjvrH8lqfIGM57f8OmGWfTGFWqMqUHoBT2Omdw5H+YytwjbnflN/8hCg
         OzXRV5Xia9OdD78R8W/Rva1tgkdHAPDPOH7qDNJfSQHsiNPSm4DF5q9ASZ/qdkYPNnzM
         1VLg==
X-Gm-Message-State: APt69E0Bb6M4wm6lEVWmWojLiIX3yW5P2DKQvc0p6WQ3ifGQPs0PnsNs
        2ELvA7yIeygQDZVEm+wRMpvLfwEq
X-Google-Smtp-Source: ADUXVKICrPNQ+Chesu1CsC4+IRzOMtfWbfOeYat6F36Sm4N5tVHKShreGVJeMOLB+WAOC2HCf6p+sw==
X-Received: by 2002:a17:902:822:: with SMTP id 31-v6mr21357157plk.172.1529462999133;
        Tue, 19 Jun 2018 19:49:59 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.70.11? ([2402:f000:1:1501:200:5efe:a66f:460b])
        by smtp.gmail.com with ESMTPSA id i71-v6sm1044403pgd.22.2018.06.19.19.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 19:49:58 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] xen: Two possible sleep-in-atomic-context bugs in
 bind_evtchn_to_irqhandler()
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>, jgross@suse.com
Cc:     xen-devel@lists.xenproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <80315b22-63c1-c8cc-1035-11fa36bee83a@gmail.com>
Date:   Wed, 20 Jun 2018 10:49:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.
The function call paths (from bottom to top) in Linux-4.16.7 are:

[FUNC] mutex_lock_nested --> can sleep
drivers/xen/events/events_base.c, 839: mutex_lock_nested in 
bind_evtchn_to_irq
drivers/xen/events/events_base.c, 1030: bind_evtchn_to_irq in 
bind_evtchn_to_irqhandler
drivers/xen/pvcalls-front.c, 371: bind_evtchn_to_irqhandler in create_active
drivers/xen/pvcalls-front.c, 417: create_active in pvcalls_front_connect
drivers/xen/pvcalls-front.c, 410: spin_lock in pvcalls_front_connect

[FUNC] request_irq --> can sleep
drivers/xen/events/events_base.c, 1003: request_irq in 
bind_evtchn_to_irqhandler
drivers/xen/pvcalls-front.c, 371: bind_evtchn_to_irqhandler in create_active
drivers/xen/pvcalls-front.c, 417: create_active in pvcalls_front_connect
drivers/xen/pvcalls-front.c, 410: spin_lock in pvcalls_front_connect

These bugs are found by my static analysis tool (DSAC-2) and checked by my
code review.

I do not know how to correctly fix these bugs, so I just report them.
Maybe create_active() should not be called with holding a spinlock.


Best wishes,
Jia-Ju Bai
