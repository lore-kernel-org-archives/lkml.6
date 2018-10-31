Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85768C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D9520664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D9520664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbeJaJtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 05:49:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37109 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbeJaJtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 05:49:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id c10-v6so6510190pgq.4;
        Tue, 30 Oct 2018 17:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=khWo0nrLtR0gpz6qZiFVs3uMUmNdBFNMYf2YM6o6TGQ=;
        b=ZQOSVZCNa6Mkhba6vaAWNLuZM0hs4gW69BwS2d9qbJUbSEZ8ulAJU80Txf9tfj8/gk
         7qxibsWSl/PZzSV0pUnkotVjp8hMjMXs9/yL/eWMm/2h+f3YA2hMj+KiK8Pzzab64sQJ
         zoE0R4JIxQ29NWzEm2iKyj68AZw1KOadINLvF46IALlFXLX7xMLFPwcy8BOne4TVXxAK
         nyBL46pC3Ihn6e/jBcameKXwyb94+gA23xDzT51ODk/Rs4ng4gSJ9p3pxiXk47rTZaG3
         mJFsZkE6+U/2UQ5UX8L156bYEEroK+Urj7idoG3N7NrTIAVR/bxJO4b4J2obAV2xtYhQ
         u9YA==
X-Gm-Message-State: AGRZ1gKgyiXNHgXkZUfhXqaT+7co4+yeLK7U7afqjjgyk6aygLxXyxnK
        8mEncDZpis9PqtkJhLqPeRIFI8kC
X-Google-Smtp-Source: AJdET5fBcy3hJbACTsPhoC8xXge8hW59/2+AHQnHGStlqqVBkBcjz5ud6H2LF3bZicdjbTmtD2I6rw==
X-Received: by 2002:a62:4e01:: with SMTP id c1-v6mr996465pfb.141.1540947225329;
        Tue, 30 Oct 2018 17:53:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:e9fd:d0f6:3e3:43a5? ([2601:647:4800:973f:e9fd:d0f6:3e3:43a5])
        by smtp.gmail.com with ESMTPSA id x189-v6sm20604509pfb.162.2018.10.30.17.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 17:53:44 -0700 (PDT)
Subject: Re: [PATCH 06/16] blk-mq: add 'type' attribute to the sysfs hctx
 directory
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-7-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2d858eb1-56d6-5c3e-7c7e-9e36b1ad04fc@grimberg.me>
Date:   Tue, 30 Oct 2018 17:53:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-7-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> It can be useful for a user to verify what type a given hardware
> queue is, expose this information in sysfs.

I assume the user is expected to understand the meaning of the
enumeration it sees in accessing this field correct?

Would be nice to output some meaningful string but I'm not
yet sure how to do that, but would be nice...

Other than that,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
