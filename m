Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9528DC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F9120823
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ4YNOd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfASITZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 03:19:25 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42530 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfASITY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 03:19:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so7377431plp.9;
        Sat, 19 Jan 2019 00:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1EcKwu0GULlC0nUFpv4OivQZC0RXDycgG3OU8afRkfQ=;
        b=UQ4YNOd4MeTNchhYMFv4RmhnbNMhJ0yWIsQUl+7y3m6YN8YYQDkgWx9BJnuBCh6Qcg
         jpWn6auLM3jBy1lM4WHvImLdGRoLJDqqlkR+XJXxVDetLswG2WUHkKnqhfmQxaxGhj7Q
         /FBTzRsGV+u2c0ZzmS35nwcFX3qc/07PDJRLDKC/oBBynD9KhnQxRNCw4ZexttkjQ8nu
         g01kKkQN5XQd1k6M03amDZrdZQIhmc2IerhQzfyeDm5PoP5InDJga8cJfAwCMEMOKVqV
         v3BSj4i264w+Ck0sMLTwZc6jBgw9wFtHeC4cFv1ZVEp2ki9EdFMXuF7I0i3l8A+ABrPN
         LsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1EcKwu0GULlC0nUFpv4OivQZC0RXDycgG3OU8afRkfQ=;
        b=YTSnRHg4OA9i/lhwvovJAwoSJeidg8ee4EDWRvmqjLHN6QFO9cxukIB1i3iaXgQp+g
         RDKjXKmpYsjmXs5FI3G9ZnUQSS+09rbRHkJysC7NCwfaaGovuwPXa6cjc0dw/ksv5CdY
         h+vBxD2W7Iy97HJPz3zj+I7zAiRL7Mo57WdhmSdjyMT308wmn1gk8gJedjNIeHrmMdJ2
         RPSGFTG+xhCDm752ZP2FmF5HNmNC406xIx3VEWph9WgR7Dod14gGGkrefHPGv2HhFseA
         nKEmH7lBT69hd+hExjMxPdxRO8sLtMWmEnQBm7fw+9bJIbMUTZ+lF9w+5h5nOWr1Duoq
         js1Q==
X-Gm-Message-State: AJcUukcnFt+vKlDCAsI4YX3f/9xP6Tx0jMJS/nUduLas2MadF4IQWFGz
        yS/4Zj55Nt33gcKh8392Pdk=
X-Google-Smtp-Source: ALg8bN48sWygmxBXFC3SEZbp2GffqxNi6D7mSafaPDnXbEhoA72gq5Z4JJXjDqdv/qgAY3Pwe7d4sw==
X-Received: by 2002:a17:902:8a95:: with SMTP id p21mr22592166plo.183.1547885963812;
        Sat, 19 Jan 2019 00:19:23 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id w10sm8253029pgi.81.2019.01.19.00.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 19 Jan 2019 00:19:23 -0800 (PST)
Date:   Sat, 19 Jan 2019 00:19:20 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_uart: Add a local variable to store the
 result of h4_recv_buf()
Message-ID: <20190119081919.GA10681@myunghoj-Precision-5530>
References: <20190111065514.GA26542@myunghoj-Precision-5530>
 <09FCB21A-2184-4CDB-8BF0-75C403DF39F9@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09FCB21A-2184-4CDB-8BF0-75C403DF39F9@holtmann.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 10:19:41AM +0100, Marcel Holtmann wrote:
> Hi Myungho,
> 
> > In h4_recv(), if h4_recv_buf() returns error and h4_recv() is
> > asynchronously called again before setting rx_skb to NULL, ERR_PTR will
> > be dereferenced in h4_recv_buf(). Check return value in a local variable
> > before writing to rx_skb.
> > 
> > Reported-by: syzbot+017a32f149406df32703@syzkaller.appspotmail.com
> > Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> > ---
> > drivers/bluetooth/hci_h4.c | 11 +++++++----
> > 1 file changed, 7 insertions(+), 4 deletions(-)
> 
> patch has been applied to bluetooth-next tree.
> 
> Can you actually fix all callers of h4_recv_buf since they all suffer from the same issue.
> 
> Regards
> 
> Marcel
> 

Hi Marcel,

Sure, let me check other callers and fix them if applicable.

Thanks,
Myungho

