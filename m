Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB52BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF8B20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547828173;
	bh=NVCELMY5b2ge3jfZ8z+S6yEvr2QuMVBaF5yR1U6Gktk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SZpYfEai8nD47ayUeQTlwBGXfEo+j2rrbwusxCQgp9dphMuwT1xjlPku1ZYzeapWH
	 uXtSbXDNP0RbhQTgUDk+s53IgjIx5znKcQGFtySA9/8tr1sIQBZd6smitTlB97TQeJ
	 RK3T9mPXBhwU2p8Pjx4DuucD20G7iqLONcD44ljw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfARQQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:16:11 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34719 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfARQQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:16:09 -0500
Received: by mail-yb1-f194.google.com with SMTP id a35so793126ybi.1;
        Fri, 18 Jan 2019 08:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rsOU4IZ09Qp6Nmi/lJ+hFBR4kFX8sxK+HJmA6AHo+Ns=;
        b=Iuso1rGlXoQmbfJ0AgUzCBwQan1kkY55FpIK9KhQkHxm0VBw9UuO1YzJ6/kwqi6vrF
         dsCdMI6DOOhiqcuAJAcbxysEF0B3eiCCk4qyqEY6sXYoFJwi+hh5gEUJ8fTvB/ecV4Df
         tvMV64XxQZPWxf60iVvuIF06t/uH9KrhHbannuyvsSIS19kv/iHa1S3598f9PAkUbaCh
         kAGU6VPAdZXioKuk4ZKuRB1RhS+NqT5kxMkl0kV5DGdmbH6fhFC14oI6MgoId34F1FpI
         /7QVvZOLl64qP6DjCM1PJRfRI/BKH84Jr+hK1Ogc72CBRqZmELSPJGhVADAi+5Kwdwks
         1fKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rsOU4IZ09Qp6Nmi/lJ+hFBR4kFX8sxK+HJmA6AHo+Ns=;
        b=EVMi6obBLdmquhRRUeVv7gBgGQZZ8sSqwiYMonDCgMmnebp6vKhP3OOJZ1uusUlvle
         nvj1dMfiKsxkN725hvlrjTQmcxfMxWCb4Q2rN5ndS+TUlD7yvyKwHCL/nS4BeYpm+mg6
         8ullBp15FjbpxkbD8SlWNxZQIuVy4ZtoOVI1OERCWhHWVwrSRfyXpztXq//qU/Fr5tOz
         FnnWQzOxTXoI5+f2YL6AErxvAfujVPKYwxCsYN0bpJdA7dXo/th5n25ZAovUnGwsMW+y
         xVJ0dclMr+/c7AzapW2JnJN/JIHD5kRpaSXw+s1D32+4qACVCpGRjAPdRYoczo+AuvcA
         EX1g==
X-Gm-Message-State: AJcUuke24Xn0XGBInkX9/CYspuD9n/xndrYAku5IWkbENGay/WPXNvXh
        sggFHhNXcoQ/iIGGjMec5BpGOcMB
X-Google-Smtp-Source: ALg8bN5QjiSbJ+MoTEJQ/46G1W1Q/JfxRrTTvk/4Mi9vpn0kmGinbUD+lrNO/vnKrLmXxxLFdrkWmg==
X-Received: by 2002:a25:bc06:: with SMTP id i6mr6872308ybh.340.1547828168672;
        Fri, 18 Jan 2019 08:16:08 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:586f])
        by smtp.gmail.com with ESMTPSA id j136sm2082224ywj.88.2019.01.18.08.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:16:07 -0800 (PST)
Date:   Fri, 18 Jan 2019 08:16:06 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups <cgroups@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/core: Simplify rdma cgroup registration
Message-ID: <20190118161606.GD50184@devbig004.ftw2.facebook.com>
References: <20190117181415.28566-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117181415.28566-1-leon@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 08:14:15PM +0200, Leon Romanovsky wrote:
> From: Parav Pandit <parav@mellanox.com>
> 
> RDMA cgroup registration routine always returns success,
> so simplify function to be void and run clang formatter
> over whole CONFIG_CGROUP_RDMA art of core_priv.h.
> 
> This reduces unwinding error path for regular registration and
> future net namespace change functionality for rdma device.
> 
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
