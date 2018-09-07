Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88569C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEED2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISVqSDxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEED2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeIGWlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:41:20 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38185 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeIGWlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:41:19 -0400
Received: by mail-yw1-f67.google.com with SMTP id n21-v6so5696209ywh.5;
        Fri, 07 Sep 2018 10:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kvOy7j6VyQo71prQRraDJula3JlRDxnFJbSd7s/3VsM=;
        b=ISVqSDxLzRU/Zu72YJywjEcV0C/qiz+Rz/ZlymoJ6RJ7xll1jGuYPTUUXf0x9fMZoP
         J9vhg+RKQtSOPAFtjFT8eOJEe3wKCwGUC6jVDKKg50t9r6ZEbcTClgALLhpvd51Ofm0S
         MoXzKjr+Em1z2ij+2EGC8WwWs+61nrsFRZ6zfG6J1MGtDcVrXtAUo4qC4KMfe8JCsxT4
         ZA1kZIAGl0md3BRLec7bvE43OJ6c381TPZTPy5/g7XPnQQXbBXxW/cUGRUEfyGDnyBZZ
         hAWAhuKtVFxE1Ea4xmLWF0y3xYrtBrCYW9Jgq8npv2WICwKYXqCKvmSPHDB9MmuNx039
         1Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kvOy7j6VyQo71prQRraDJula3JlRDxnFJbSd7s/3VsM=;
        b=G/JVZBOFIJ0aX3eScWcv2BKZr/zh5VkiZj4xzSgSjhoLM6288RSvSEboZo4sx38BRy
         TeWaWhH4ghPw7+jurploeHPMK8KvhNFR4RWmCu5S7GfI3e3VteN9TMp04Ij4TtwXf458
         3/ziZdGSJjrI6H6Ag+CWARVrFimEjpFxpNA9zkWLGbO5gB7hh6fkwpdxoOEZG90XkvVs
         XpTOLzImwRDXyVKKTsGm+V33g4FJvhA/x9Fsj3SEoFingdMDhHPQ2BbNrlrOKkV89A9/
         eg/dogkCQiDFj+4OD97bP+3sx4z6hBivP1Mkk3ZRCLQ5C1ph7L0wO5yma6Japj65/gA6
         T7vQ==
X-Gm-Message-State: APzg51BRNh0JhiJfx4jWZdqdLipD/b/mOPBtd/l5D5ZajvFaovuQw1X4
        gDrHmAZLIarzLdIai0hpOz8=
X-Google-Smtp-Source: ANB0VdZ9xUQKtdWCX9iMgUkZbmQmANafbYrt4KFKlE7uHfHZ4yHgaFO1+PjDF5CJz9o5M0m/RLPJRQ==
X-Received: by 2002:a81:af0d:: with SMTP id n13-v6mr4869628ywh.105.1536343155669;
        Fri, 07 Sep 2018 10:59:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:70a9])
        by smtp.gmail.com with ESMTPSA id j8-v6sm3050341ywj.6.2018.09.07.10.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 10:59:14 -0700 (PDT)
Date:   Fri, 7 Sep 2018 10:59:12 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] blkcg: change blkg reference counting to use
 percpu_ref
Message-ID: <20180907175912.GD1100574@devbig004.ftw2.facebook.com>
References: <20180906211045.29055-1-dennisszhou@gmail.com>
 <20180906211045.29055-12-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906211045.29055-12-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 05:10:44PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> Now that every bio is associated with a blkg, this puts the use of
> blkg_get, blkg_try_get, and blkg_put on the hot path. This switches over
> the refcnt in blkg to use percpu_ref.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
