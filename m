Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F70C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 20:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7302148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 20:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YzVqKFyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbeL0UZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 15:25:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34321 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbeL0UZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 15:25:16 -0500
Received: by mail-pg1-f194.google.com with SMTP id j10so9184980pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 12:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sa2xitYbhv23h6ykCl7D8XaNx7MbfbYEeVHMesewNC8=;
        b=YzVqKFyJo8YHNUflNhbmKT+rZCU6/rWDP5kI6Il6u8ohHUVdm2aBULXJzqu5J8apof
         jS+nmwaaJT09WYX5l6zf7H259MgoTdJ7aD+DstwxGQqUkNBQ/AxhCj58PPw0sAVaU1Wy
         2s4WlOQOfNyRsqIr2kfR4FfQsUdj3/+QEHwHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sa2xitYbhv23h6ykCl7D8XaNx7MbfbYEeVHMesewNC8=;
        b=IBmXkejUkcsDNwgoeqF0XTP1PdyFkA1mFSn1ITktQu8HA3qFMsc8CgP5o11A8nZeg9
         CuHpxWHKcc/hrFL1XZcMCH07J08DXwRR92+Sr1bqw+99CRsF/jAOW25ZCef/qDtVm6Zc
         DgKUx6jWSn0EUW36J3w2q+HU1O9XMPswPigUHctUhqpBzpuKSGgcc19QXmdrSTupyNp/
         8rGpTkEw2oIFZU/3wRRVMj+xy9HJ4de8MGR1axLRzh98H2WXeTZKTVSkP2MKlTmIziFd
         KjnbVU3zo36gIAt21Wg3KZeX86em+8EEQxZJPo1yx7UcmGXTREHKuiXlNovvRCgm8lql
         EgYw==
X-Gm-Message-State: AJcUukfWZ8mRAWmJ+KjBXNgA7Lev5dD5MVgMwNMearQvx867gDo9ClI+
        wNskycsXhN5BgscXjLY2jfcNbA==
X-Google-Smtp-Source: ALg8bN7EqY+GDPLCJ2z0F2pcDn5LznrSo5TjwPUF6c9WUZwYu7SUnzHd2QWEH8iwueB3d1+bTQCxYw==
X-Received: by 2002:a63:5c41:: with SMTP id n1mr22920893pgm.1.1545942316143;
        Thu, 27 Dec 2018 12:25:16 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p24sm62813200pfk.155.2018.12.27.12.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 12:25:15 -0800 (PST)
Date:   Thu, 27 Dec 2018 12:25:14 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 3/6] Bluetooth: hci_qca: Fix frame reassembly errors
 for wcn3990
Message-ID: <20181227202514.GK261387@google.com>
References: <20181227073136.8431-1-bgodavar@codeaurora.org>
 <20181227073136.8431-4-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181227073136.8431-4-bgodavar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 01:01:33PM +0530, Balakrishna Godavarthi wrote:
> During initalization of wcn3990, we observed UART is reading some
> stray bytes on the Rx line. This is logging Frame reassembly errors
> on the serial console. This could be because of tristate of Tx line
> of wcn3990 during boot up.

My testing suggests that this change is not needed if the Rx line of
the SoC/AP is configured with a pull-up. We'd probably all prefer not
to have this change if there's a neater way to address the garbage
data. Could you test with adding the pull-up and dropping this patch
on your side?

Thanks

Matthias
