Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84F5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7412C208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7412C208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754583AbeGITQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:16:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933353AbeGITQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:16:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02C2340201CA;
        Mon,  9 Jul 2018 19:16:32 +0000 (UTC)
Received: from localhost (ovpn-200-25.brq.redhat.com [10.40.200.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55DAA1C596;
        Mon,  9 Jul 2018 19:16:28 +0000 (UTC)
Date:   Mon, 9 Jul 2018 21:16:27 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Taeung Song <treeze.taeung@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, brouer@redhat.com
Subject: Re: [PATCH v2] samples/bpf: Fix tc and ip paths in xdp2skb_meta.sh
Message-ID: <20180709211627.5c715bc0@redhat.com>
In-Reply-To: <20180709175121.3355-1-treeze.taeung@gmail.com>
References: <20180709175121.3355-1-treeze.taeung@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 09 Jul 2018 19:16:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 09 Jul 2018 19:16:32 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'brouer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018 02:51:21 +0900
Taeung Song <treeze.taeung@gmail.com> wrote:

> The below path error can occur:
> 
>   # ./xdp2skb_meta.sh --dev eth0 --list
>   ./xdp2skb_meta.sh: line 61: /usr/sbin/tc: No such file or directory
> 
> So just use command names instead of absolute paths of tc and ip.
> In addition, it allow callers to redefine $TC and $IP paths
> 
> Fixes: 36e04a2d78d9 ("samples/bpf: xdp2skb_meta shows transferring info from XDP to SKB")
> Reviewed-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
