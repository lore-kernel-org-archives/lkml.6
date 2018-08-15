Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB2CC46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE4E2098B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rcqVoqQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE4E2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeHOEKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:10:49 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:32978 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeHOEKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:10:48 -0400
Received: by mail-pl0-f51.google.com with SMTP id b90-v6so9045689plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 18:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DvY/62/5zpjBIZMJS5WuY3UFtL+mNgElbQXvCkSyF9A=;
        b=rcqVoqQ5VcPU29qm8qqsz8ElWuRNM+i++USoA/TeWORl8GA5BhMKe0a32lDv9bT3Qv
         9YpvZV1wf/vEtOJAHMJkO0Iro1Vm9ROLNVxHhwH9Z51/e09kgmHdBBUbEY13dOm2ms8y
         3zRjkSstrZRu8CoMB8naHkQq0Q6BCUrug121jS7qXRJAIwYwKG+nkVZaIQ0HUZ6rvdR3
         +2+Dg/ZiAtkOcxIMKbhpjGroS4kgoac1na2ESC1MMtv+OjDDXYCH/Rnm0b+JSZhOfJqP
         tTRqQr198TXQgChccoCxPfFFO+edeB2Lfi8IuwmbhpNz2YalIEZe1q8VoTVek1SNOoGp
         9LKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DvY/62/5zpjBIZMJS5WuY3UFtL+mNgElbQXvCkSyF9A=;
        b=r15LYC7ak6i+PDjTtOpEjQ4fTsd4WPmkYml68k1gm6YuKA/UtECebTtlr5cqblJdAd
         zal1WUCTizfs/auld+ZTGvtiRqki8GuB4Y4h5KCEkQWcDHIK8gDmDOfry41Uzks9Ba2p
         9psiLxADl8BUqMTv74B4dSBfVIuP1BGtrIOHvLT3cXdS5nHDWZl2l3B6OB6XY3+Au4Wn
         qHT3DSu3DeQYr+FLcO77xY1nA5FZ3IHP8JqtTmOmoOpUNVChhlLcYCeN8PM4Vz/tAfZV
         sYRHaF5q5o3maRnGYHFx/ixewkbJ/ECLs4EO8M88GcTmob7L9+9PIQGNzPOGcQq1PrBW
         A7lQ==
X-Gm-Message-State: AOUpUlHdzcjBzdAWDeHTfLEG1k+SLt8LE6Gi9z8yUqMkyNNVNQ/eMoM7
        oFGJ1Lz1VJexJaVoVTITHePufAanop4=
X-Google-Smtp-Source: AA+uWPztXgB9qOLkTeqtad91XqUkMVU8/B/5ixG1PvJtoQtG9m6IxHOP6GmvTJ9BDSeBhQ2J0QEeZg==
X-Received: by 2002:a17:902:1121:: with SMTP id d30-v6mr11875081pla.250.1534296056933;
        Tue, 14 Aug 2018 18:20:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id p64-v6sm39819275pfa.47.2018.08.14.18.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 18:20:55 -0700 (PDT)
Date:   Tue, 14 Aug 2018 18:20:54 -0700
From:   Joel Fernandes <joelaf@google.com>
To:     linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        netdev@vger.kernel.org, ast@kernel.org, acme@kernel.org,
        fengc@google.com
Subject: samples don't build on v4.18
Message-ID: <20180815012054.GA70201@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
When building BPF samples on v4.18, I get the following errors:

$ cd samples/bpf/
$ make

Auto-detecting system features:
...                        libelf: [ OFF ]
...                           bpf: [ OFF ]

No libelf found
Makefile:213: recipe for target 'elfdep' failed
-----------

I bissected it down to commit 5f9380572b4bb24f60cd492b1

Author: Jakub Kicinski <jakub.kicinski@netronome.com>
Date:   Thu May 10 10:24:39 2018 -0700

    samples: bpf: compile and link against full libbpf
---------

Checking out a kernel before this commit makes the samples build. Also I do
have libelf on my system.

Any thoughts on this issue?

thank you,

- Joel
