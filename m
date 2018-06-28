Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6B8C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21246214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21246214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966824AbeF1OeO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:34:14 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36321 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966506AbeF1OeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:34:11 -0400
Received: by mail-wr0-f193.google.com with SMTP id f16-v6so5767306wrm.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qcXB1Jp2Fjand+VeQ5L1pA/zQ7f3NzSM8pwsjYyTWTQ=;
        b=pmUhhxsEwfXTrML59ttvjCxppe9ixWb7HWPeD4exkxpi2Wo+Gmqoa7hLIG55NUVxqO
         /Xz1115gB2It64TEndp6i+wVU6N+RvPMhQdR74Ulz5v7EFLPr1eAqBwFIwD/DqTEwrIi
         u1yaufEdFYwA8x3HQ/fnR6KzRPeKfpfld2pJqG/pwOOVZpaR1d86j/bWtnPU4L4MXxDs
         dYkLhjScrik4zty6aG8sHmgzKYCM7zR0N4QEemSEvRO3U2c75DGdsTfw1o3bxKUtFp+g
         ggfBZUagchV4m9/EcNt8wTUCQ+7uFPaURyQRdwjlM40dPQgMi3/gYq58/Xvr7bqKsAhD
         thoA==
X-Gm-Message-State: APt69E2Iaf+5hTaGIOXhbJlP7+m/Gu9AyB3M7/YVFekIfggO7n1mrfxx
        WafSNbDPQtgi329P0oGZ/+o=
X-Google-Smtp-Source: AAOMgpcg5/IjuddLOoMqZZYSG13nm9IVyLmrm9OLcMDPkbjFPPP++m9YiWUhalz6THNRuRbarTI8Ag==
X-Received: by 2002:adf:f6c4:: with SMTP id y4-v6mr8476590wrp.4.1530196450665;
        Thu, 28 Jun 2018 07:34:10 -0700 (PDT)
Received: from [192.168.81.52] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k82-v6sm13298006wmg.10.2018.06.28.07.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 07:34:09 -0700 (PDT)
Subject: Re: [PATCH] nvme: trace: add disk name to tracepoints
To:     Keith Busch <keith.busch@linux.intel.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-3-jthumshirn@suse.de>
 <20180626150106.GB6628@localhost.localdomain>
 <20180627073328.aws2apvc357jobge@linux-x5ow.site>
 <1e7d0f93-9d20-1b99-58c4-651b1d0dedf0@grimberg.me>
 <20180627234313.GB10657@localhost.localdomain>
 <20180628005943.GC10657@localhost.localdomain>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c25e48f5-ace4-5d2c-8174-11ac63316323@grimberg.me>
Date:   Thu, 28 Jun 2018 17:34:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628005943.GC10657@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Thinking more on this, not using the hw qid really limits the utility
> out of using these trace events: We may not be able to match a completion
> to the submission without it since cmdid alone isn't enough to match up
> the two events.
> 
> Here's an updated proposal and actually tested. I was also able to
> combine admin and io submissions.

This looks good!

One thing that is missing is the controller id when we have multiple
controllers/subsystems in the host like:

TP_printk("nvme%d: qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, 
cmd=(%s %s)",

But Johannes can add it I guess.

