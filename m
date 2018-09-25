Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCCEC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030E32086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD5inT/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030E32086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbeIYSop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:44:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39930 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbeIYSop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:44:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id s14-v6so23180050wrw.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 05:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gH0wuWmPFxuEhPvVxwSajJ2CD6lAeNUE+aZZCwyIDxU=;
        b=cD5inT/TKcPNrwUGb0SvA0bi8en5Z4t60qK5hDyfgPMlBDd9npgfytM2jJPr869rE5
         c6jFvwH5vnfMQmk+2jPnER5/vX40K8Mpyur3jEIL7XSvUopEUC7mxo5tcyCJkua7a+Oo
         g7HnQS/HX3+oC3d3HmpmOYpg9FU1J5rgFFvuvAh3zNQfdUucVCFeX1hjg8o6xoqCOFg4
         KEbzTaDfd1DTB3at76C1SAtGwA0Js7dCAhIuzt6ugKB1T18KvaY2l0zvmFOthFeosrcu
         d7CxvQs+w0rSJr10a9OLnCUfA77HvU9AKbWfEB4jgWifnGIQHu9y7brxwhC7dTmsU+l9
         t09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gH0wuWmPFxuEhPvVxwSajJ2CD6lAeNUE+aZZCwyIDxU=;
        b=Ul/DUrFK5YGpAuRTU33zp02qPjbaOgx5VrN3jc6ilVj6ambItGVHymw1q3Cq1JwsNQ
         CgMInN4AGHTkTid0EUMMmgbBN9j3U1p5owng711qbn3IjjcIDKGoVDZg5kOElsba7Wr5
         0sinDBEsxecz+UsMA4UcPY1uLUhqlIxD9IleKkR3mTKth1nypacXbWKeYf6FlaIcuLEa
         1yYnvsOFOD5ptpBS6Qy992iGqTwEn2SiyhXGDfFcbwELewiL0MIWlNrVd+F4wQT+mVva
         ATj2zEbQYBktaBKkBhlBUZlI4HeGDE8N6AFVY8HDtwBrvJ/YHl1uHqW7tTXHPTFS+rPZ
         Xkfg==
X-Gm-Message-State: ABuFfoitBvIuxjXlGMXUKaDiG+QQWZSbnA7W6GgPXPONaYl+Hka8ctst
        8MM2/oPQgN4NL0FvWxW7wC8=
X-Google-Smtp-Source: ACcGV63SSndQmoAdA2ouUm840KN1v/Z8QvFRHgoDFXTsL019FuJMEa7q4Vor1rX3NegAvZlB1nhIxA==
X-Received: by 2002:a5d:5450:: with SMTP id w16-v6mr910888wrv.4.1537879042002;
        Tue, 25 Sep 2018 05:37:22 -0700 (PDT)
Received: from localhost ([178.121.95.75])
        by smtp.gmail.com with ESMTPSA id p11-v6sm2904846wrd.74.2018.09.25.05.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 05:37:21 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 25 Sep 2018 21:37:16 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        He Zhe <zhe.he@windriver.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] printk: Fix panic caused by passing log_buf_len
 to command line
Message-ID: <20180925123716.GD523@tigerII.localdomain>
References: <1537291068-443145-1-git-send-email-zhe.he@windriver.com>
 <20180919015030.GA423@jagdpanzerIV>
 <6c354803-5341-7237-9ee3-7882252c7483@windriver.com>
 <20180919023932.GA14090@jagdpanzerIV>
 <20180918224312.6e9aef50@vmware.local.home>
 <1545bc85-b64a-4b45-d40f-79567ac621dc@windriver.com>
 <20180920123056.27b2cf18@gandalf.local.home>
 <20180921073753.mqayzofcofpmhiyu@pathway.suse.cz>
 <20180925120135.GB523@tigerII.localdomain>
 <20180925122300.qq5w4skwmxbzi6sy@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925122300.qq5w4skwmxbzi6sy@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/25/18 14:23), Petr Mladek wrote:
> 
> Thanks for pointing this out. Well, it seems that the change would
> require a new syscall to pass the buffer size as long. We need to
> be sure that people would use this in the real life.

Agreed.

> This thread suggested this change to avoid a checkpatch warning.

Not exactly. I suggested u64 change not because of a checkpatch
warning. But because of u64 memparse() return and because of potential
log_buf_len=4G+

	-ss
