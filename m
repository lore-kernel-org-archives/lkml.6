Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17132ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47DC20862
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO6pBIBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47DC20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbeGSRlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:41:21 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:39742 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbeGSRlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:41:21 -0400
Received: by mail-yb0-f193.google.com with SMTP id k124-v6so3527489ybk.6;
        Thu, 19 Jul 2018 09:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fCvaMgyC4HO3YmETnpEXZwlnTbwvELCzto9+JxrnNk0=;
        b=DO6pBIBpu2GWN8xrpoOX3KBwCZ0guYrTGStJ6YhCw6QC3C1UROvELXKKv+dYcq1fgs
         qcPx8S1TCUF919wPiFlBUGFrIvoC0C+3xAnE9h00fWfGtYtv2nYN5cLFnww7v/VkpOLq
         YzuRtr4tQzNxIk+C034s9MUaDQyDX9Qc4Pt9gpYlLR3oiTTGfihcYyLDrpHPcZHSUQAn
         YbR5/eyoh+6dGuN23SxzOjwBq+jrUdcgrEjhF7mLc/57a1Aox2jxagXvYyiHxmMV87Ol
         M4Ra2d1xWyiakfYbz7K4571HkUQmHFJPPAJLKIGXnDX6AD8+wJ18RVnWdsWUU7nFgeb3
         HqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fCvaMgyC4HO3YmETnpEXZwlnTbwvELCzto9+JxrnNk0=;
        b=sHij72hV8MS2AqzogVpxertHnWv56UbSfg0j3kVUpPNoX4QlsOsJmxT3m2XcVBSojw
         38NEdwFCjEpDcAmAe29ZrUhWDvo31ApgPnfDqaPaAzFUgbOgkA5RFsXY24eUqQ1FFTKV
         XmqpawSL/E76Kje6DEIWylNVbazujgxJyGsJT7jTL3DRl/S0JABXgQL58aKX93g3kwCg
         MXICrL5dLPfJIzbVrlEv0sviflakSJjXSMvrHSa7D8YuEWZR0vRiFUQbgCb1XTtGHiIp
         N07WdYtZMOI63dgrhtg2Z6mMEF1FpIuPo2TXHM44YPQm9l/lWryQm+U4RaEw3lAEQUCu
         itKg==
X-Gm-Message-State: AOUpUlE35fTLTLKL94p9MsuK35/yvKX8BaODmDPsBSmFirOUr8Cpu3IF
        x2JxJumFgK27ZT0C/juGQ8E=
X-Google-Smtp-Source: AAOMgpdGKp5Ud7KnBlVTEj+K1W2sHEOLSRcJxbM/ZejyCRa+8hSJ+fHzaAsInzbhJi6u6v++wkMnmQ==
X-Received: by 2002:a5b:307:: with SMTP id j7-v6mr5949381ybp.352.1532019438041;
        Thu, 19 Jul 2018 09:57:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1d36])
        by smtp.gmail.com with ESMTPSA id w199-v6sm3205611ywd.104.2018.07.19.09.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 09:57:17 -0700 (PDT)
Date:   Thu, 19 Jul 2018 09:57:16 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Claudio <claudiozumbo@gmail.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Claudio Zumbo <claudioz@fb.com>,
        Shuah Khan <shuah@kernel.org>, Roman Gushchin <guro@fb.com>,
        kernel-team@fb.com
Subject: Re: [PATCH kselftest-next] Add cgroup core selftests
Message-ID: <20180719165716.GV72677@devbig577.frc2.facebook.com>
References: <20180718173358.14007-1-claudiozumbo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718173358.14007-1-claudiozumbo@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 07:33:58PM +0200, Claudio wrote:
> This commit adds tests for some of the core functionalities
> of cgroups v2.
> 
> The commit adds tests for some core principles of croup V2 API:

Acked-by: Tejun Heo <tj@kernel.org>

Thanks, Claudio.

-- 
tejun
