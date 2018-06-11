Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rgSyGeV0HlsoFAAAmS7hNA
	; Mon, 11 Jun 2018 13:11:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 73C0A607BB; Mon, 11 Jun 2018 13:11:16 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8rBg/O8"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 02698601C3;
	Mon, 11 Jun 2018 13:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 02698601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933199AbeFKNLO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 09:11:14 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36685 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbeFKNLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:11:11 -0400
Received: by mail-lf0-f50.google.com with SMTP id u4-v6so30484898lff.3;
        Mon, 11 Jun 2018 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uOhlSVzj4EBIQDTlN0VAGX6cnYuUHxB3/HVA1BB8yIA=;
        b=C8rBg/O8NPy9oXvg3xWpGU9sCOWPI0MMFAbmAJs63mtdGvObDUMmPRkfkOv57SPWcz
         1ID0uN+kKUHkneoK9p2pv+GH8VVvDqtVoD+pqbVZF8jZx67TXV/h2EGoEUsx/gWc93Co
         pvcs9CkDmFlIP1fbRJnxEV54hOITCadzM7vwGvH02tn1+LHN93Sn0tJmnQhulV1ZHXkF
         7CrL5YVBanuAHu6jENFP4+WpWlgT1Q3F3EGZcHL78LSsxeAu31eRlEGa/RoDIbDCoIV0
         +cH8n8mhoBvPjP89SG5G+/P0bRKvR1WycGLGI54Tck85deacUbmcnNtkmNfGQPlf2pGO
         me0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOhlSVzj4EBIQDTlN0VAGX6cnYuUHxB3/HVA1BB8yIA=;
        b=RpSkOa5uQ9bRl61M8x2PUNN0xZVPW/WGwsRmjg/nuNRObkJi9DOhP3IFXgXcdGAKOO
         eEUBHqsCHM55YpELiLLYwqzZc7i249mFQoTUUijHAGPhW+ngBevfWye0HLdXd5G33phc
         Hdn17OPXuxenOxwWbAhOSpDJzyq9ISl99i75F1jFttqKmp+Jze5bLY9gPcr3ECYhI421
         SzVui7hceOYbkSxaK55wUx8Bnjw0rYtt03xm+/H6sGFiFTmG9sENt1OEQ1CRHjriBZlx
         HwTsp8g7MyCtKJnxlMdeH2MGEkB14YO6mNJOAK+iwZLMMjh2rfpupG7x1uS/NCHC5Ejr
         SYQA==
X-Gm-Message-State: APt69E0N29ambTUa2Nz/uoiMkwUVy2DneWhlCLx+dbMFeJRd33GP8o9H
        siJaTLZu0wfk1HUveUmUtFyLeO/zIp9WgLDK+M4=
X-Google-Smtp-Source: ADUXVKJVSoTdn5UgWh0hb1RhLykkAvw54ve45p9agRCnYJIoL526ohMR2pZnbVLwVBeQkap/i/go7zX2xAF7CwN6GWM=
X-Received: by 2002:a19:5ad4:: with SMTP id y81-v6mr10773450lfk.82.1528722669515;
 Mon, 11 Jun 2018 06:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-21-ricardo.ribalda@gmail.com> <CAHp75VcKxZdp=Rmkt=K+yHq2aFAfSsD+SrKvPsSCCVLmLgc1pA@mail.gmail.com>
In-Reply-To: <CAHp75VcKxZdp=Rmkt=K+yHq2aFAfSsD+SrKvPsSCCVLmLgc1pA@mail.gmail.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Mon, 11 Jun 2018 15:10:52 +0200
Message-ID: <CAPybu_1EYTD91x9v6Rs8apwk0dgPWYVNm3uXFYBi+nLQDgDYvQ@mail.gmail.com>
Subject: Re: [PATCH v2 20/24] serdev: Make match_id accessible by drivers
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I agree.

Fixed on serdev3 branch https://github.com/ribalda/linux/tree/serdev3

Will resend after I finish fixing all the comments

Thanks!


-- 
Ricardo Ribalda
