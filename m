Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81140C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C6726931
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNvfXi+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C6726931
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755340AbeF0Bba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:31:30 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:34604 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbeF0Bb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:31:26 -0400
Received: by mail-pl0-f45.google.com with SMTP id z9-v6so210190plo.1;
        Tue, 26 Jun 2018 18:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=JmMqhdSGdNRzaNiXIr1WCriQw0BHGB7OYLS7BIIUa84=;
        b=TNvfXi+zyJbwIG32I65Rlca9EN0sA5jeprr61b0fRo64JjA3dqKKKjBUbTyuwyIqle
         3NeK+KfzBwJ2j7uFYHjqzOIxZxaH2oohvp243L6pAH/0hXMOhXP+iPz1X5id5W3Yi5fP
         aJx6G9dOeH91JF12UtbeixwsQQ7d3aseBawheebu2FFxEFRm/vTkZtZUD3gj+/MG07+X
         wzcApIJ9JUYqh07wfLaVAMP4eTz5kYksJ2vaVMsJaTHos+79P6I8AuGqI36hdTz84eiw
         GgWnBTCDvU3WDIuLqVV/DV8FkFbeHFd3fGQo8bBo8ZFjDWviKVu/j7OENbbj2N4Zxnfj
         wLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=JmMqhdSGdNRzaNiXIr1WCriQw0BHGB7OYLS7BIIUa84=;
        b=UzaBm9w/ydWMtYUuojxJwCtQMRlcUhJYH6bGc/VbJPJX+TB2ZSf0Sp6zDYxX+AtYC3
         xpxsNLrAAAyrUd86pEyCn9+bgO8RXYTbYYakZwvZ0V+3cOm1Pqq9LDzSG9/4YDmelWAd
         hIo4C0+8rL22dIePVRRYWyokJPN+mGsK2AeI0kSYUhjyAd4s6ZZMjx5OdpGWslhBLTmo
         cGDskSL5Vb8dOrGzD9Zk/JmoaFbY5HsTsrL1D6zjWZTBhi/JQwCQPzXLSeoqUM4z1vt5
         +1KYCsqzuHPNOckNWCSdGwSdu/b1GDm+IXm00mEVgcsSP/x5+PcR75XzcJda9PQnbqWe
         w7nQ==
X-Gm-Message-State: APt69E0bfjbVHZbLjHC6tqek5OEv6zvrgYBFyYUUgdNc9ZHuS/PAcyK7
        JLBCWtBfNdxxSVB8lzeCXr0iq70j
X-Google-Smtp-Source: ADUXVKKUyhyZnETFSEqDmUZWcGkOcSnUNvn4JCo6Aw0A2KfmbuqhLMGi9ec2Tng1u7OEIvYmo3HL6g==
X-Received: by 2002:a17:902:7891:: with SMTP id q17-v6mr4003596pll.186.1530063086038;
        Tue, 26 Jun 2018 18:31:26 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.70.42? ([2402:f000:1:1501:200:5efe:a66f:462a])
        by smtp.gmail.com with ESMTPSA id p12-v6sm4697477pfi.175.2018.06.26.18.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 18:31:25 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] net: e100: possible data races in e100_watchdog()
To:     jeffrey.t.kirsher@intel.com, jchapman@katalix.com
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <ecf9293b-9105-8eb1-7184-77de6dd77786@gmail.com>
Date:   Wed, 27 Jun 2018 09:30:51 +0800
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

The call paths in Linux 4.16.7 that may raise data races are:

CPU0:
e100_set_multicast_list
     e100_exec_cb
         line 879: spin_lock_irqsave()
         e100_configure
             line 1139: nic->flags [READ]
             line 1148: nic->flags [READ]

CPU1:
e100_watchdog:
     line 1758, 1756: nic->flags [WRITE]

The READ operations in CPU0 are performed with holding a spinlock (line 
879), but the WRITE operation in CPU1 is performed without holding this 
spinlock, so it may cause data races here.

A possible fix is to add spin_lock_irqsave() in e100_watchdog().
I am not sure that whether this possible fix is correct, so I only 
report the data races.


Best wishes,
Jia-Ju Bai
