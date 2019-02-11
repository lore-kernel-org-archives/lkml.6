Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBE3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1405222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oII1SX+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391849AbfBKPOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:14:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54252 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbfBKPOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:14:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so18124178wmb.3;
        Mon, 11 Feb 2019 07:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=/MfpOEM5Hi4WmZzofpP+jzifsTDHz3Un+gIrfmlkxQk=;
        b=oII1SX+8NP1TofKpAgtWnVJ7S9S0zKjMG4G/LguNYgDVcRQaZm0XAUNG8eBpD5yixr
         g3Vlk1WXOxCvNVp6ndXhyt5p+asILzB1QfoXqnKrYlg+W0NQ2xoGrzvs+tXNLrfy2Dj3
         RC+TTeyiKK/mTwP+7bT1bBDZdVlOwxcHHab28ODiWmJKkfkqDV+ULJb65jpEsOsVVKB6
         NRTIDCKT6a/DG2mUtaxC3SR85GnOk+USqvxgheTTlDzz3kLT5mX2i95v6NP2KgTqo3L6
         kfdHW/LVwjgu6oPc0bTFm2drnwv34mshL7fMbSv93ysNXw8pBM5zlUrzl9xzmVhPiQtw
         7gpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=/MfpOEM5Hi4WmZzofpP+jzifsTDHz3Un+gIrfmlkxQk=;
        b=iQH+R/JxCgGM9ev2ARfcx2rL03NncAUO2x5AoXDxkaj4LfsSk5eZjGhBPXM6LLboM5
         Qq3wkJoGEbcunqJA4arLPz20Uy1mtOz9PusuAhzCOjrw5e7dVtfiga0DUiDE+hrdgIwt
         2k1VrV9WrSrwu+VAUMNwhW5AMfOfIWM5ZI3EUOyDsZskon+FXgwoTFNKMiFycElAQgEU
         l0KZ7cpDII6eTmDhjnbfXemDmlwCSkQKg+R1nbhCPU7wwFvm8iA4mac/Qlq9+vWJUf4T
         8vkjCL42sjylPMfXey3p8oQuNb4q6IqSRg/reexwMDGAB3X6ZzM6mkPL64emAg6tjA1E
         rd2Q==
X-Gm-Message-State: AHQUAuZKTgrSC9vEmARE+w0ehkCJMI/Mdz9r1NpU2madp4LfdTgMuwux
        7cfxtLk+Qo0ftDgq3JFOHEE7jDT6bq4=
X-Google-Smtp-Source: AHgI3IZbk6K1YP8g9cdhjWWLvoPPTYppIqAuDHcddZP8ExQ6cX6iOsNNrr18yS+UTmF4Qobgh7UAZA==
X-Received: by 2002:a1c:f916:: with SMTP id x22mr10261300wmh.87.1549898060633;
        Mon, 11 Feb 2019 07:14:20 -0800 (PST)
Received: from alpaca.bmw-carit.intra ([145.253.130.2])
        by smtp.gmail.com with ESMTPSA id i16sm1844574wru.16.2019.02.11.07.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 07:14:19 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@alpaca>
Date:   Mon, 11 Feb 2019 16:14:12 +0100 (CET)
To:     Joe Perches <joe@perches.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linuxibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: use tab instead of spaces
In-Reply-To: <7befaea3d1a86950f9dd270fed47072214fa2876.camel@perches.com>
Message-ID: <alpine.DEB.2.21.1902111610380.2831@alpaca>
References: <20190210181011.6117-1-lukas.bulwahn@gmail.com> <7befaea3d1a86950f9dd270fed47072214fa2876.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iOn Sun, 10 Feb 2019, Joe Perches wrote:


> On Sun, 2019-02-10 at 19:10 +0100, Lukas Bulwahn wrote:
> > Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen as
> > further maintainer to the KEYS-TRUSTED section entry. So, we rectify this
> > with this commit.
> > 
> > The issue was detected when writing a script that parses MAINTAINERS.
> 
> checkpatch already does that btw:

Good to know.

> 
> $ ./scripts/checkpatch.pl -f MAINTAINERS
> WARNING: MAINTAINERS entries use one tab after TYPE:
> #8408: FILE: MAINTAINERS:8408:
> +M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> WARNING: MAINTAINERS entries use one tab after TYPE:
> #12607: FILE: MAINTAINERS:12607:
> +M:  Ilia Lin <ilia.lin@gmail.com>
> 
> WARNING: MAINTAINERS entries use one tab after TYPE:
> #12608: FILE: MAINTAINERS:12608:
> +L:  linux-pm@vger.kernel.org
> 
> WARNING: MAINTAINERS entries use one tab after TYPE:
> #12609: FILE: MAINTAINERS:12609:
> +S:  Maintained
> 
> WARNING: MAINTAINERS entries use one tab after TYPE:
> #12610: FILE: MAINTAINERS:12610:
> +F:  Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
> 
> WARNING: MAINTAINERS entries use one tab after TYPE:
> #12611: FILE: MAINTAINERS:12611:
> +F:  drivers/cpufreq/qcom-cpufreq-kryo.c
> 
> total: 0 errors, 6 warnings, 16993 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace
> 

On next-20190211, the checkpatch issues in line 12607 to 12611 are not 
reported anymore, as I already fixed them in commit 70e6e7d92bca 
("MAINTAINERS: use common indentation").

So, the issue addressed here and in the later follow-up patch is the only 
style-related issue in MAINTAINERS.

After that, everything in MAINTAINERS is stylistically clean.

Lukas
