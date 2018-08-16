Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C2FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 04:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEE421480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 04:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Otp5z4mf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEE421480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbeHPHAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 03:00:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43267 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387854AbeHPHAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 03:00:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so1392565pfi.10;
        Wed, 15 Aug 2018 21:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9D3iI4cQThiddCk5EGZZHzD1YuN9DvbJF04w6shjpuo=;
        b=Otp5z4mfH9v37ykPVGveCTvz919SR6hqrKW/Q2iO57y6EARm+ZKzcj2JznNvsnxWUr
         +BUGfK2jC81l0yL8NI+GNkjjlM82UXgrNW/eI/5ul1bObj8+GQ+5dMkMBZYD4STG9K40
         GFfK7nACCWMR3mO4ILfkZtCBRkG+7ikoWIJAAi/quceXjCDmMJ2UPFsRNyt9kCp42rJl
         L0uduzcuUM+v/nqNufA4zNxFCEac/DsGrX0X6b1NebEyhzn2YEl5qvFx5UdoPQ2fTBXv
         hiran1u16Nypceo/eVcvxgQBBhLPnh5g5d68g+5Ihl/jLmPD9xPfLKN73MEwVxaC/ydH
         8Hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9D3iI4cQThiddCk5EGZZHzD1YuN9DvbJF04w6shjpuo=;
        b=eT1Th4tJcPaJ7MppZM9vJIxJYr53DOgx3CXL12v7CdVj7urvTrhbd0sPLsXH25v0B9
         OIv1c0OEWDclvAHvuM8bLxVPaJjTKgOc3/Pz7OYCymAMcV7+C+e5LB8uaZSJLs4micWr
         caWG/IVAg9AZ1cBsfVgNMTTJMQRT2Gy3dcMDQNyvtrugHKErZpNPtNlEqArOdM2hRHjb
         6U1Wv0PNHGnfHTs1L25SlcFpCcAH0vaLXfr6i8xdLYbZJK70mjeBKj+UGvE+Qulg7Wd1
         pkpP8KVmAKzJbM5wstr25ge6XUrkmJybrHadpxguYzZ7j2Gd6seIq2uMOgcoaHrO0Xuh
         NP6Q==
X-Gm-Message-State: AOUpUlFceOcUPj11Wj8hlEzorqs/DyXHK0ng1J4UPOXy/Tp8ZQC8MhBV
        N9+XPIz5gUNS3s5qzVXlCWY=
X-Google-Smtp-Source: AA+uWPwCpGGjqpyiEhWG8eNm8nadE/PwxL00otgBc0o6mPr12+189Fxkxpm9JLgBZqrWmWJGe7p8UA==
X-Received: by 2002:a63:b504:: with SMTP id y4-v6mr27986526pge.247.1534392321267;
        Wed, 15 Aug 2018 21:05:21 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:97de])
        by smtp.gmail.com with ESMTPSA id v71-v6sm30760152pgd.56.2018.08.15.21.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 21:05:20 -0700 (PDT)
Date:   Wed, 15 Aug 2018 21:05:18 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     David Ahern <dsahern@gmail.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, mst@redhat.com
Subject: Re: [RFC PATCH net-next V2 0/6] XDP rx handler
Message-ID: <20180816040517.7vjm4bwxosyzvapu@ast-mbp.dhcp.thefacebook.com>
References: <1534130250-5302-1-git-send-email-jasowang@redhat.com>
 <20180814003253.fkgl6lyklc7fclvq@ast-mbp>
 <5de3d14f-f21a-c806-51f4-b5efd7d809b7@redhat.com>
 <20180814121734.105769fa@redhat.com>
 <03ab3b18-9b13-8169-7e68-ada307694bc1@redhat.com>
 <08bf7aec-078a-612d-833f-5b3d09a289d0@gmail.com>
 <aa9cf883-7822-70a7-5ab5-c873b69c2098@redhat.com>
 <f4c0346d-6665-5312-0310-ffbda505b7ec@gmail.com>
 <2792239a-ed3b-d66e-0c1c-e99455311eff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2792239a-ed3b-d66e-0c1c-e99455311eff@redhat.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 11:34:20AM +0800, Jason Wang wrote:
> > Nothing about the topology is hard coded. The idea is to mimic a
> > hardware pipeline and acknowledging that a port device can have an
> > arbitrary layers stacked on it - multiple vlan devices, bonds, macvlans, etc
> 
> I may miss something but BPF forbids loop. Without a loop how can we make
> sure all stacked devices is enumerated correctly without knowing the
> topology in advance?

not following. why do you need a loop to implement macvlan as an xdp prog?
if loop is needed, such algorithm is not going to scale whether
it's implemented as bpf program or as in-kernel c code.

