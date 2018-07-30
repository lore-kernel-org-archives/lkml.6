Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3F1C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 03:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F0620870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 03:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BMg/CXQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F0620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeG3En3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 00:43:29 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:51890 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbeG3En2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 00:43:28 -0400
Received: by mail-wm0-f51.google.com with SMTP id y2-v6so11437662wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 20:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nfECFzjZPVlyRfUz2yJg3SfVMrKQXDob7lF9CNDUsV0=;
        b=BMg/CXQbq/x8HwUBEQJ9twJrEo3vxsuWkBBl0n6h4qNnQ/dkCo0jon7G/3ecmWzDB+
         +azZAYWdt/h+EbrzK4D1ksp/9/D5dHNU+DWuze0V8pwq01SQVB7lOtRVV4ICFP3hveP0
         zhwAaidfJJuGdFpgl5g8n9jBtv3cAi0HbwquQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nfECFzjZPVlyRfUz2yJg3SfVMrKQXDob7lF9CNDUsV0=;
        b=CZt9IKVHAj8jnOLV2K1o1mWO7qpN3ABVD+OpKEiz6z62udZ581zfOz4TRG4ta7aCMN
         toITN4S77qSuzg2NaTkIzXo1Zv++E5qVhMv/1Dwb5wkKR/52MWSUH0mcaTRT5w+yTGhh
         I/033cVDcMQuDXU1bjTmHlF86a6VS/vu0OF2R45HGrX9mZ6LiQCaweQwqtr35O7NzSdz
         NbJcxPNb5gGKzp9q5fwv5tbCJ+Llr819qCCLl6IwkHAIIosyNKycC+0f4YVubwBK9xfz
         AiIT48PlG+XeIe8xnFuX0sDnhzTstiYfOdPMuLSA4lEJeqUvLmm4AdBE/EHpWbRy1S0C
         IbCQ==
X-Gm-Message-State: AOUpUlG6TWvU/e+Tg0xKAPtIlmtItIzjM+ARA+9QQZITkl3Gust6ryDP
        J5YyLJ8XLauwepmzWNIGvgQODQ==
X-Google-Smtp-Source: AAOMgpd5AYSqnt0hKfJp/Z5JIQnOg4hIdJhjxkfAqJnEKg14akLnAgOK40nW6PZjB7oXNGcP2si8JQ==
X-Received: by 2002:a1c:be13:: with SMTP id o19-v6mr12774605wmf.1.1532920236976;
        Sun, 29 Jul 2018 20:10:36 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id t6-v6sm14588872wmf.8.2018.07.29.20.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 20:10:36 -0700 (PDT)
Date:   Mon, 30 Jul 2018 05:10:30 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        AL Yu-Chen Cho <acho@suse.com>
Subject: [Question] bluetooth/{bnep,cmtp,hidp}: memory barriers
Message-ID: <20180730031030.GA9430@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently puzzled by the the three calls to smp_mb__before_atomic()
in bnep_session(), cmtp_session() and hidp_session_run() respectively:

On the one hand, these barriers provide no guarantee on the subsequent
atomic_read(s->terminate) (as the comments preceding the barriers seem
to suggest), because atomic_read() is not a read-modify-write.

On the other hand, I'm currently unable to say *why such an "mb" would
be required: not being too familiar with this code, I figured I should
ask before sending a patch.  ;-)

  Andrea
