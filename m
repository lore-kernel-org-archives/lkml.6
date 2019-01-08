Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DDBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBD92070C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvwFNMOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfAHDG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:06:29 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39476 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfAHDG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:06:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id r136so1175020pfc.6;
        Mon, 07 Jan 2019 19:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MyhZ2Cwjrxjlo8DuX7wpBjMsVGWkbIzgYxuzPKW4dTk=;
        b=ZvwFNMOpWeuWjsYH0m7ZwJ/YDXpodZrHTguZW6viRiLg6ds0kfIROqFM7CzrSQWjDY
         RA0k8qAIpvN13BvBnrVbVh4/OoeYQ+qtD9kFUPUMiv1u4tLR4O/tc93PEi4lsXMC3QOE
         BS9QSO+KcKtFLtZlQd0082p28CPRnMSL9GF12g4vm4CUz1eWJF7h8LG2nzW6ZZQ3DTLy
         PL3lCJaOEVJH1p/zDh0ttmUZ21pyqIhKaeu1w6nkDCPvpxCMauGhYN5aOFSlU3xAkcQr
         4syhdbjKOYqp+ZDVNOCVq02FooNU0UGJawlw/YvEd5582aj/h/3u49is8upW/TTzT9Ny
         v4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MyhZ2Cwjrxjlo8DuX7wpBjMsVGWkbIzgYxuzPKW4dTk=;
        b=uafGMyv17pCbu9c2AIiMuVuy2CthlLET2SqoZvvjRxYAdfrqPGxah0D6fI8nC8bDzs
         x7xyX7qs4JvoHkNAlk3hCWM8SG0B4lNIZdDCtGh/N7cKnK1TaslXq68JjxYmHfxfuTin
         C0Oz+PV4uTJn4NiqPalfwrDv5DL1QP6ZCT4qbF/SF7s28C4ciLJJsv7p0oR/gZGk56US
         i6eLDvPNIg0vnhmGhRakgJYnx7rhbG0MCQnL83VPKQ3Fh4yBoAgaCLJ2Z0gaAjIpYZLC
         b5Uc/u0/0TEpNvY8RnE/wU5mfVejL62/CLNAlOcvKkbaI+nKfQFaSu640tQ3sBUX54FI
         6Giw==
X-Gm-Message-State: AJcUukc2YKrB86tiEkg3a9N/uYWn9QrN4vZ6COhAe4/piBLPoSzotPcB
        cDE3pZVgZOx9i2+naz82/kc=
X-Google-Smtp-Source: ALg8bN74poVqOdNggXDH+NWL2DuGtEMu12s0oDpO39bNWdmRUPs5DC8dQRbKvJLwkN0goli6v6vDRw==
X-Received: by 2002:a63:5621:: with SMTP id k33mr20697pgb.395.1546916788546;
        Mon, 07 Jan 2019 19:06:28 -0800 (PST)
Received: from localhost ([39.7.51.153])
        by smtp.gmail.com with ESMTPSA id x28sm136743025pge.66.2019.01.07.19.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 19:06:27 -0800 (PST)
Date:   Tue, 8 Jan 2019 12:06:23 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: Re: [PATCH RT 01/13] work-simple: drop a shit statement in
 SWORK_EVENT_PENDING
Message-ID: <20190108030623.GA6619@jagdpanzerIV>
References: <20190107195252.599921907@goodmis.org>
 <20190107195331.608898679@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107195331.608898679@goodmis.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (01/07/19 14:52), Steven Rostedt wrote:
> Subject: [PATCH RT 01/13] work-simple: drop a shit statement in SWORK_EVENT_PENDING

						shift?

	-ss
