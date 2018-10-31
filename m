Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2687C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E6D2082D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E6D2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbeJaKAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 06:00:48 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:41307 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbeJaKAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 06:00:48 -0400
Received: by mail-pl1-f172.google.com with SMTP id p16-v6so251153plr.8;
        Tue, 30 Oct 2018 18:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=aCcWXrhhZUGsJLjoz8RFRzE8OiSUjQ/jpYYwsZIJqa9XkgpWj1sLG0PAi6kA+kiAR8
         8nhX8XtTAYO7RKBfH0jXe3B32Eor7VyK2brO6WD2YuGRhlMSforueefCRddEynyWbiVF
         ipiQiQyIaPLqHKMHVX+4bYND4UJ+dQgWbOrYBV+AlIjYOPpAnKOaMPFfOBqyfRkxkVQB
         5EvtrtWY2T6jwaj/2JXQWi8B4ZLyiF7E88SX4ftuJqGPlsttovQ0VzAtiK5MWAOZcrfd
         QNOXIZtUo8ItlfJBQ+y3Rt58jgAjEtWAe+mRMgCJs6duixQiNcWX/BfbgjLW37859ppQ
         XPFQ==
X-Gm-Message-State: AGRZ1gJwcrp43zErmG8uPHTkd50YskFr9Sk7PGGCYNObHSsE+uOefE1v
        edSVLvjat5aTe+YoTNVA0Iz/pKb+
X-Google-Smtp-Source: AJdET5deF9PD+GDJ9ozV1ALZVjkD//lOlLy3URB8zmn9rhHQ61N+pt9GcSt1xvf4MgrEfMFedIm+vA==
X-Received: by 2002:a17:902:e185:: with SMTP id cd5-v6mr1020885plb.224.1540947900432;
        Tue, 30 Oct 2018 18:05:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:e9fd:d0f6:3e3:43a5? ([2601:647:4800:973f:e9fd:d0f6:3e3:43a5])
        by smtp.gmail.com with ESMTPSA id o4-v6sm10776329pfi.172.2018.10.30.18.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 18:04:59 -0700 (PDT)
Subject: Re: [PATCH 11/16] blk-mq: improve plug list sorting
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-12-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a1910a3a-995c-065b-399f-40ae2e3b596e@grimberg.me>
Date:   Tue, 30 Oct 2018 18:04:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-12-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
