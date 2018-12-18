Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43C9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A419621850
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pITo9uW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeLRRpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:45:38 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34776 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeLRRpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:45:38 -0500
Received: by mail-io1-f65.google.com with SMTP id w21so13472916ioc.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 09:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dC82Cs/RyQzNGzQ6zOmzJmij6whGKd/Hgj5pzQDI310=;
        b=pITo9uW8NM2XuTXW+7QM7x19SQmlnyiU3gkHAi9Ga1mO3dDfveoVvrBHzjcccXkM4k
         64rgeBqo0EQfswp+D1BJSh4n+LW0b1aMEfl9v36yQ3aDmoX4DmAlI+kbZbv+V+wRtIrS
         b5L+t7mMmzsZSdy8MsdMl/4R/Y163LpTwIfAsTDxNO3Zn9QsdtrfIazhBHHSR/r8+4jB
         fksAgAkJXwwrJxM2APs3rmuK5b+VKU1XqgHRcwp/YQmQTUf42yEQfu0fvmdAPkBvP8t/
         44EKD99tTXAdJZihA23O+3KDlAZKkUqtmSO/Cj30uMGo22e+DFSHJc0XegICDYLyfoTj
         esjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dC82Cs/RyQzNGzQ6zOmzJmij6whGKd/Hgj5pzQDI310=;
        b=hs7HgrdO6KvNcvsG9pQbBSiJ3Q4LdEjWFq0qQbybBSysjFp9u9M6b+6p5LQTgJ3FNQ
         W2ZLDFKeffhioYkXwB96J+Nw7ENasbuq2osfGlzhJmN3WzNKT+PUJV9p2qVKqfqSn9rB
         XmvxZdBD3sb8iHsG6S3W1n339hrx8rVnw2FcE+/DDHMBgWVMXELGojWouRV5sHX5SSGU
         btTx/J13d4Ibz/n5qU0ES9qqcyJLtva030vLzXeqe5o72Du57hgAPs//qGLHqqlgMYcH
         upm/JN/aRwe5F/kTc/TfoLxjJ79QBgTbvWonCJKgZxAYmGwg5qmY3MqPMEE1aFi9m46F
         c7qQ==
X-Gm-Message-State: AA+aEWaBkZaAfqBhuGxWSgSfUmvfkCLzHLtoZKHl+e4el+QGV+aDJxt4
        dqH1rLQU4i1K7c73eTVRKeBrDA==
X-Google-Smtp-Source: AFSGD/W58D9pj+/ZfK0VsNIKD6TS8DPS7IZRLgCpVjfCum1VFPiSA8Nq4q6EAQDqGTRxxBW768UU4A==
X-Received: by 2002:a6b:cf1a:: with SMTP id o26mr16380752ioa.32.1545155137511;
        Tue, 18 Dec 2018 09:45:37 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w26sm6773735iol.60.2018.12.18.09.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 09:45:36 -0800 (PST)
Subject: Re: [PATCH] dm: give req_size precisely given by user
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     stable@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <20181218172537.12300-1-jaegeuk@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <01a60138-63ab-6a9d-c0ba-b8fea551b14e@kernel.dk>
Date:   Tue, 18 Dec 2018 10:45:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218172537.12300-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/18 10:25 AM, Jaegeuk Kim wrote:
> This patch makes dm be aware of io_pages to assign sane req_size for reads.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

