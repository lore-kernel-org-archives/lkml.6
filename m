Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475E5C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6742082D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6742082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbeJaKKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 06:10:42 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:45984 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbeJaKKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 06:10:42 -0400
Received: by mail-pl1-f169.google.com with SMTP id o19-v6so6398656pll.12;
        Tue, 30 Oct 2018 18:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=tfi0H7T/JVBR81+kZwecbLC9Bx/53NuJjxDSwIlPeMn75Hvm77PoEdtANXlRFjWlyU
         yoEKwOAUPCAsJPEnUYvDslK82T8YKokWlc9gXb9j0Ivz2oI5DFlXIOlb4EcWgcEJVF4c
         yKwMZBZffz2nNQow78xJ/wVfkd2Sejt8MdD0DMgpOrWaoQjumZwuTXGhetu8taaDe7VC
         VBp6EmpYaAGkW/8SqfDxWyN+ZbPCjT27AHKvgjaIMkjM/wfDHPPfftButDTvFK1Jw9sZ
         PwUI6FWKv+NdyNp1TOahgN5JJvFWmCY5zvB6sYwVevLW0UFjLS9s0fbHbyZm8xX6L0aL
         tXuw==
X-Gm-Message-State: AGRZ1gKF0Eg985HKSg4OeqPR7Scy7P6PRtdLN9IwzrBN9pXVnwpLua+V
        Sjr7f2/mhOq9U+pRIEWRIP1EY3XX
X-Google-Smtp-Source: AJdET5fgrMPyfSlVO7HR01WMnHzwMx+y58k3P0iQjdIKlvfBoURjpGD0f83PyAUe3adorChzA+pCcw==
X-Received: by 2002:a17:902:4281:: with SMTP id h1-v6mr1114114pld.114.1540948493305;
        Tue, 30 Oct 2018 18:14:53 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:e9fd:d0f6:3e3:43a5? ([2601:647:4800:973f:e9fd:d0f6:3e3:43a5])
        by smtp.gmail.com with ESMTPSA id s2-v6sm59841578pfk.133.2018.10.30.18.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 18:14:52 -0700 (PDT)
Subject: Re: [PATCH 12/16] blk-mq: initial support for multiple queue maps
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-13-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <383b79f4-53d9-2187-149e-578e065f5c44@grimberg.me>
Date:   Tue, 30 Oct 2018 18:14:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-13-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
