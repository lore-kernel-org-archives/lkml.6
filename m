Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CBFECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 14:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F7C20836
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 14:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F7C20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sunsite.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeJUW0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 18:26:53 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45743 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbeJUW0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 18:26:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id c24-v6so1933257lfi.12;
        Sun, 21 Oct 2018 07:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvJrMdTqasSaSF9zrYxVPKOoq+EUN3lhwPDiYYehUEI=;
        b=jdaWpkDTCNBaO+4cxPCtSjP2IQy28DfFdGu87pzL9BJN2L0Yj/3Pm1wKeAT0A8u8GF
         zyQMwZPA0kGCqjaet1GDfhEDtwUZx8iDRZ8rtxeE/Oe90+AfY997Arc03huXG6tmNCFp
         75LCl1/EIV1UEExW5dPmnW4ndfdZD6uNXq5H15lmMyPrvAAa6GqnBG57YvoT3JRDx7ti
         iVWw59yYzdUckF9RJkGuY+Xr+zvJPxziO68CEWJbkyG9JSFYoVEv2mFW+kEU0Rzq3vh3
         U0DV96+0AhuYKXrBC+3sXAXqBVbSzImIaXQ/I3UaEFq6eAAzBEeR2EKVcUN5nFBY2Ek7
         7WOw==
X-Gm-Message-State: ABuFfoinYGxZqzcQx/0tKp6dTCmHyH0W1jX4Z4zkMpK+8n8TSGxg3eot
        SGcVNJzbyeaBMhNhVV7BGN7OsPdEqnzDWJ+VnWDcv52Q
X-Google-Smtp-Source: ACcGV61UcC7opRp5SJG6J5Rx1RtLzuDQW9xz7Wd5Ih6Eau69hsKx4NdZFxojbkbtaBeVT4JRu0Y3og59i+rWQoRLpf0=
X-Received: by 2002:a19:660a:: with SMTP id a10-v6mr6992005lfc.100.1540131142621;
 Sun, 21 Oct 2018 07:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180625161303.7991-1-federico.vaga@cern.ch> <20180625161303.7991-3-federico.vaga@cern.ch>
In-Reply-To: <20180625161303.7991-3-federico.vaga@cern.ch>
From:   Peter Korsgaard <jacmet@sunsite.dk>
Date:   Sun, 21 Oct 2018 16:12:10 +0200
Message-ID: <CACXmViZZ3SBPbV4AXK6EsJPfD5TJqEU_-Q36+vz5LxTk_pzq4A@mail.gmail.com>
Subject: Re: [PATCH 2/3] i2c:ocores: do not handle IRQ if IF is not set
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 6:14 PM Federico Vaga <federico.vaga@cern.ch> wrote:
>
> If the Interrupt Flag (IF) is not set, we should not handle the IRQ:
> - the line can be shared with other devices
> - it can be a spurious interrupt
>
> To avoid reading twice the status register, the ocores_process() function
> expects it to be read by the caller.
>
> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>

Looks good.

Acked-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
