Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44781C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DBF2476F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DBF2476F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753496AbeGBTBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:01:36 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35584 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753312AbeGBTBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:01:34 -0400
Received: by mail-pf0-f173.google.com with SMTP id a24-v6so4271413pfo.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 12:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fMZiRr31kIxQgnBfAWaWt6gqSFblcyyvArJVX4D+c6U=;
        b=YIopOhs+FmuO1TH/e0TuR7taqwSI60O+dtvImiK7M3Z0GZp6vEGEW5l7s2Y2Dca4x3
         xsdD7WiJyRFWcG3islQsrKXI75jAtAEzOd9+FTzjudSzs3rmD6fC2wMPOp6EDOtflmri
         uBAHaNU/TpyHAWTxh2DiQtm4NOjQ+bInP6nTz1HxlJpUxzyN9AcAoBhZUrmbDMkqpN+4
         XC9PGcGN4R8rh0xVxqMzJgu4+tmTu1eYmWN1lq+wZHAl3z8aytCdw2kwKVsjs3oHhFfM
         5/bbl4+GQi+WR+CCogWHD9ZEXjKpDwvvvVdgbqGcQi4ahP5g6KWr+MhDzocOv7yATOxL
         bf2Q==
X-Gm-Message-State: APt69E2ulJH7w3HSG0KO23T4mcoyWTFCVdHqEDo/sJnJERHBQLsWI/y+
        mqMmPk5jQ62ignr2s8zdONZFbw==
X-Google-Smtp-Source: ADUXVKIEmHZPQLLmFvEIMWeO5tkNguH1q3rXhK6kw8oo9CV1E9tqdoU6+zLKB/Bhnevjc7iHinBhPw==
X-Received: by 2002:a65:6147:: with SMTP id o7-v6mr22846106pgv.163.1530558094118;
        Mon, 02 Jul 2018 12:01:34 -0700 (PDT)
Received: from trogon.sfo.coreos.systems ([2604:2000:80c5:4400:140c:73de:b623:c90])
        by smtp.gmail.com with ESMTPSA id n72-v6sm34057276pfj.68.2018.07.02.12.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 12:01:33 -0700 (PDT)
Date:   Mon, 2 Jul 2018 15:01:28 -0400
From:   Benjamin Gilbert <bgilbert@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-x86_64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
Message-ID: <20180702190128.GA455@trogon.sfo.coreos.systems>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems>
 <20180702093450.h5tfjeynpi3nwjbo@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702093450.h5tfjeynpi3nwjbo@black.fi.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 12:34:50PM +0300, Kirill A. Shutemov wrote:
> Could you check if you can trigger the issue with my changes to config and
> the way I run KVM?

Yes, the issue still triggers in that case.  I've also verified that the
kernel boots normally with your qemu command if the commit is reverted.

--Benjamin Gilbert
