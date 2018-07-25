Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5F2C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8947420844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3JHWrCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8947420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbeGYT0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:26:22 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35639 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbeGYT0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:26:22 -0400
Received: by mail-io0-f195.google.com with SMTP id w11-v6so7106304iob.2;
        Wed, 25 Jul 2018 11:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VW582KrGB6yEvf/lwW6bEIySdRkbggnQEBsDyIVGqSM=;
        b=g3JHWrCWNY1XucoVHS5kzq+dycNQ+47jxBPcWDpmMlduPgjlIqjRwPqewgRum+3owU
         sMXDSRkKa7sZN96XJTiX/5ww7m0GmjGC9Os8wU9s4LQKQEdGn6Lz7IXGqjj1f9acnM2b
         otNZBf0zZBz77Uu2cN5L/+H3XATgD4WjNUPUwCOsHQe2O9Sr+CDi2Z6A9f5uUgflx7Y7
         LEvUzcy2k3xhqPPXhAHgiWs0RqefZBSmNgkVweL8Wv0V88vVEtPyRTldY4l836HLMpiR
         dHw+J3DxonZjmjXSEP2d8+0FGJNGrRwjIaANQBBayQbXJcWRKzY1dbFrKQKt9dA0yiWn
         cKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VW582KrGB6yEvf/lwW6bEIySdRkbggnQEBsDyIVGqSM=;
        b=eZQbn8PpiD0ZsNF8UOZbXhtsZxWLx7ZG/dUxEMbNk3W/WFlI3gCBtuHssbUtA1eKY2
         Wq8CTFsrUcJOzZdQ7mh6SR2ndeCwVGp9x/qHAJ+U/SkS8w7cvV03bIB7WmeGQchoR+pv
         fYUntCXeYXlvN4kcTY7j+3vqDbi5gDtcwK6euvtis8Q1W4nmOfDZ9uZUHGZnoBSLD/bA
         mJNWocvetKg63GKQkJs6qa5HfDM2twcjWS918gLSmaTM9CsKc4Z5bFeOxnTMbMJoxwnI
         BA5KgWvjwOIfjrKU3psvvSDVWKZ8tQm/TQiIiUUg7oqgv/hEK5zhBd8z2oKULtaxgDm4
         b1zQ==
X-Gm-Message-State: AOUpUlFPpPOFSO2po5Quh37JCMMuA2e5bQ0o28il2LfQlsk0owuvT1D4
        aQvkUHYcMacRo9+KQTUVBesUectC
X-Google-Smtp-Source: AAOMgpenBt+KXFH6Y7qzVcgNSINHFljDuoKZNa8CZIwPvy629qkFY4jIloWpFzxkk3ifRcxLWUYQiQ==
X-Received: by 2002:a6b:9e91:: with SMTP id h139-v6mr17754978ioe.185.1532542412828;
        Wed, 25 Jul 2018 11:13:32 -0700 (PDT)
Received: from dsa-mb.local ([2601:282:800:fd80:e4d8:8895:822a:720a])
        by smtp.googlemail.com with ESMTPSA id g26-v6sm137929iti.0.2018.07.25.11.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 11:13:31 -0700 (PDT)
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to
 per-namespace
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        nikita.leshchenko@oracle.com,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Alexander Aring <alex.aring@gmail.com>,
        linux-wpan@vger.kernel.org,
        NetFilter <netfilter-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1a3f59a9-0ba5-c83f-16a6-f9550a84f693@gmail.com>
 <CAM_iQpWabZorkMNswyfHyS4KT=f_bgMtK8K35=84uah6Kfqxew@mail.gmail.com>
 <1a27e301-3275-b349-a2f8-afdfdc02f04f@gmail.com>
 <20180718.125938.2271502580775162784.davem@davemloft.net>
 <28c30574-391c-b4bd-c337-51d3040d901a@gmail.com>
 <CAM_iQpW4-JkZY7jXx0Q1b907hQ85UOL1eXv2YHwSukb5L=apUg@mail.gmail.com>
 <5021d874-8e99-6eba-f24b-4257c62d4457@gmail.com>
 <CAM_iQpUc-H2kZCBevePs6g-8qKyJkUhdd1ZDSQgYsCG0ChfC2w@mail.gmail.com>
 <87muufze8w.fsf@xmission.com>
 <4b03b5f6-87ce-9ff2-7c14-598beebd8fb8@gmail.com>
 <87zhyfw70m.fsf@xmission.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <dacc9322-fd5a-dfeb-e4f1-7a288fb79886@gmail.com>
Date:   Wed, 25 Jul 2018 12:13:30 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87zhyfw70m.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/18 11:38 AM, Eric W. Biederman wrote:
> 
> Absolutely NOT.  Global thresholds are exactly correct given the fact
> you are running on a single kernel.
> 
> Memory is not free (Even though we are swimming in enough of it memory
> rarely matters).  One of the few remaining challenges is for containers
> is finding was to limit resources in such a way that one application
> does not mess things up for another container during ordinary usage.
> 
> It looks like the neighbour tables absolutely are that kind of problem,
> because the artificial limits are too strict.   Completely giving up on
> limits does not seem right approach either.  We need to fix the limits
> we have (perhaps making them go away entirely), not just apply a
> band-aid.  Let's get to the bottom of this and make the system better.

Eric: yes, they all share the global resource of memory and there should
be limits on how many entries a remote entity can create.

Network namespaces can provide a separation such that one namespace does
not disrupt networking in another. It is absolutely appropriate to do
so. Your rigid stance is inconsistent given the basic meaning of a
network namespace and the parallels to this same problem -- bridges,
vxlans, and ip fragments. Only neighbor tables are not per-device or per
namespace; your insistence on global limits is missing the mark and wrong.
