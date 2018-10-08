Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D698AC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943192087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/87s7TY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943192087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeJHP6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:58:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52868 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeJHP6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:58:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so7276512wmw.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 01:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7pQLYn5LWiSLPhvFylOjR1Z+Qf4mdwFAAQNTRUl7QNU=;
        b=G/87s7TYLN17wRhRBZ+odXgY4wLDLb2MW7UoLEcHJR7jyV1FyMiQMW4AZUpL2ajUt4
         wTq9d6V5kr4gvPGi6kMfZdVtP8VrCpDtKvVaNhlBRfR9Th38OGffmQWVZVArTnrvWEdp
         DSp1/Ud8xy7dX0Nisy16e2tOPpXc1FAgdCD+kSd2/PdjgDo/wHyrzGJRap0up3MeskQM
         A++K77A12H6JnB1lAz2nbYdTkLUwEpnhJBn92qFTuCfA/mywFuutMSOwTLwD9jmSwyre
         1N3HCs93NFmArCNdam0K+m/xNSRtsT4Ik0rO2LHyo7XSdf9C8552YmzdIZXkTXHwp+Al
         cDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7pQLYn5LWiSLPhvFylOjR1Z+Qf4mdwFAAQNTRUl7QNU=;
        b=ce8Pt/5gGcvUFVVo7il5HOOZ0VaODGVA+9zT5H56kndACy59JURTM4SnYGvZzR8lQX
         Ii2KFcDDH1QW3rEEnmgTTlCFWCzYnNoH59dY6KDXB5mRXh7Zkje5Gyxkxl6g92ZuaQRc
         RDnLFn6A0KQs1DBvcPucAykqmt9zN85fR15pr2EWdR2VNL2vqxBIp/624gsXpVv3Yu3v
         wxh6KETSZz0VEFDW4P+9nPQrMy9//LnO50wCRjVqGFmsjah2pVx4TbBf8mmHfMl9EgsG
         5V3ebS9urvpgQbpUDwPDiab8gs/PQ/VsT822CbZQL+WxFkyrhrR3FJ6MBN74stOxaT1J
         +zbQ==
X-Gm-Message-State: ABuFfogYMcEML0w0Vtw957CIKOJ/zHD6GvV6cEC1iZElCXdiBnkWnaq6
        J/86VosP3IM4HPJqA+a+MYQ=
X-Google-Smtp-Source: ACcGV63Fm2wF6/6MgpKEPOcVMSvzXUrE94e+UjyeIL3S+XAcDkYzp4ZpLpD+UMz31S69dN2POG97Kg==
X-Received: by 2002:a1c:96c7:: with SMTP id y190-v6mr15105498wmd.36.1538988476785;
        Mon, 08 Oct 2018 01:47:56 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD31613C1F2E846AEDA540D.dip0.t-ipconnect.de. [2003:ef:2bd3:1613:c1f2:e846:aeda:540d])
        by smtp.gmail.com with ESMTPSA id p1-v6sm9687004wrw.12.2018.10.08.01.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 01:47:55 -0700 (PDT)
Date:   Mon, 8 Oct 2018 10:47:53 +0200
From:   Juri Lelli <juri.lelli@gmail.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        andrea.parri@amarulasolutions.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  sched/dl : return accurate release rq lock info
Message-ID: <20181008084753.GC9130@localhost.localdomain>
References: <1538788117-45448-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538788117-45448-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/18 09:08, Peng Hao wrote:
> find_lock_later_rq may or not releease rq lock when return
> later_rq=NULL, but it is fuzzy.
> If not releasing rq lock, it is unnecessary to re-call
> pick_next_pushable_dl_task.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>

Subject has whitespaces problems and changelog might be improved.

Other then that patch looks good, thanks!

Acked-by: Juri Lelli <juri.lelli@redhat.com>
