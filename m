Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD5CC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF33206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF33206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeILNmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:42:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726624AbeILNmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:42:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 94CB18011309;
        Wed, 12 Sep 2018 08:38:47 +0000 (UTC)
Received: from ws.net.home (ovpn-117-57.ams2.redhat.com [10.36.117.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D3D0FA984;
        Wed, 12 Sep 2018 08:38:46 +0000 (UTC)
Date:   Wed, 12 Sep 2018 10:38:44 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Eugene Korenevsky <ekorenevsky@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v2] efi: take size of partition entry from GPT header
Message-ID: <20180912083844.iegei2kobcz4b7ag@ws.net.home>
References: <20180911161527.GA30689@vnote>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911161527.GA30689@vnote>
User-Agent: NeoMutt/20170912-66-504cd9
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 12 Sep 2018 08:38:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 12 Sep 2018 08:38:47 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kzak@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 07:15:27PM +0300, Eugene Korenevsky wrote:
> +static gpt_entry *get_gpt_entry(gpt_header *gpt_hdr, gpt_entry *ptes, u32 index)
> +{
> +	return (gpt_entry *)((u8 *)ptes + gpt->sizeof_partition_entry * index);

I guess header use LE, so you need:

               le32_to_cpu(gpt_hdr->sizeof_partition_entry)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
