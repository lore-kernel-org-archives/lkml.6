Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FD7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632502086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVMdZIud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632502086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbeK0U02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:26:28 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39268 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbeK0U02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:26:28 -0500
Received: by mail-yb1-f196.google.com with SMTP id w17-v6so8762486ybl.6;
        Tue, 27 Nov 2018 01:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3tECLqTkzFOjFCy4pDgJ59MTjzCv98LoBr5PspWdCgI=;
        b=qVMdZIudvMC2OTME8ZOMUm3eUfKK2siVbKT9hbBaUVdfwBf82p3ZwW2TKTtnM9tcC8
         4Sqk0nsKeO+zhMu41M5Tg50V9ko29928unxXxSmVG6t3MKssXScO6iBmQoKfZb9q4L+o
         8MxbLLBXU9PTSPbIKsXmXUTASbAyb1Bvbi/ffYkkb+ENjb+/azKEP179lglIiNu56qBf
         9T5PQ00+Oot5PqqKEjhd0/o06J5KiJ0G6DznoNn/r4qaftEfebbq9Q83+mSLYpcbaThc
         cIQzJ8xcKmd/YIBfQzU51LLrLRgS8DETxKpx1Zvswcfdj3hprAMqTPV/Km/YhNOPN0jk
         iuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3tECLqTkzFOjFCy4pDgJ59MTjzCv98LoBr5PspWdCgI=;
        b=Ff1IwFYH7zZCHvWG2NNUGmOz0ezHrhOZkbj3wlt83m0I8LLmHRXAQ8hhOS2sDlwoHl
         d4oFnc6ds76ZpXi+jzlr0UTquOFbgZTx+KH2sJu5SbSW6qXNYjn2+a75SSc7/DbgHuhp
         To/9FYQrv/SirK6En0ahxq2/UwOZ59XYaga0t/BDxbLSPYkbQdGBoQeDs++dwopQhNuV
         r9XaWdYIgc+4utSQLdHwRV43yofHg0vQGcCu8WmF7aBTUKqXlI4U17OVVRxtI2ZYb5Er
         3W2J2GmiUtZafu658MBwHBHSSBnbwY9e4k+NctA0n9eqjvcXNCoVF/QOxSBFe1i9c4JN
         ZaEA==
X-Gm-Message-State: AA+aEWZjTHMTvui6LWoO3Y/Sf3rd+jD8ICkAgKPZWDMF/MqcIyltJyX+
        hD3cvGYsPBcYbQGf5hJT2cw=
X-Google-Smtp-Source: AJdET5e869c0VNWMdetIjNQTfhnPTf528KCgNJnFqwkcsQBsAzmE1R0asykrHs/9WZpwEf7col3p4w==
X-Received: by 2002:a25:1cc1:: with SMTP id c184-v6mr32794855ybc.421.1543310950650;
        Tue, 27 Nov 2018 01:29:10 -0800 (PST)
Received: from localhost ([199.201.65.3])
        by smtp.gmail.com with ESMTPSA id d4sm792217ywe.104.2018.11.27.01.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 01:29:09 -0800 (PST)
Date:   Tue, 27 Nov 2018 01:28:59 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Peng Wang <rocking@whu.edu.cn>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: remove unused member "cgrp_ancestor_id_storage"
 in struct cgroup_root
Message-ID: <20181127092859.GC2509588@devbig004.ftw2.facebook.com>
References: <20181127065357.28130-1-rocking@whu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127065357.28130-1-rocking@whu.edu.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 02:53:57PM +0800, Peng Wang wrote:
> "cgrp_ancestor_id_storage" is not used, so let's clean it up.

It is being used.

Thanks.

-- 
tejun
