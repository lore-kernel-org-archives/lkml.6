Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51967C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133932086E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133932086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeGEFYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:24:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50728 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbeGEFYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:24:03 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5A12E108CE7C3;
        Wed,  4 Jul 2018 22:24:02 -0700 (PDT)
Date:   Thu, 05 Jul 2018 14:24:00 +0900 (KST)
Message-Id: <20180705.142400.1075427810487350044.davem@davemloft.net>
To:     treeze.taeung@gmail.com
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] samples/bpf: add missing <linux/if_vlan.h>
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180704133639.11855-2-treeze.taeung@gmail.com>
References: <20180704133639.11855-1-treeze.taeung@gmail.com>
        <20180704133639.11855-2-treeze.taeung@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 04 Jul 2018 22:24:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taeung Song <treeze.taeung@gmail.com>
Date: Wed,  4 Jul 2018 22:36:36 +0900

> This fixes build error regarding redefinition:
> 
>     CLANG-bpf  samples/bpf/parse_varlen.o
>   samples/bpf/parse_varlen.c:111:8: error: redefinition of 'vlan_hdr'
>   struct vlan_hdr {
>          ^
>   ./include/linux/if_vlan.h:38:8: note: previous definition is here
> 
> So remove duplicate 'struct vlan_hdr' in sample code and include if_vlan.h
> 
> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
