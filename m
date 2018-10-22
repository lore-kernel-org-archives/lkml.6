Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCD7C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C33020652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C33020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbeJWGIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 02:08:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35447 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbeJWGIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 02:08:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id l17-v6so20569897pff.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 14:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lIv6larhBHKispBblV725Bm3pwAaxUftiXw2wrKWE+E=;
        b=ayH8p2hgC4mZmQXPKFYRwsRazVpYBqO8T7eggfQSByQuS/NOFr/KNnRdD+CqDgKT83
         AKAsghYBiRw8QUUIpEyyMnBXCV6Z7e/Ls12e+leXdmgRpH8RwxVNlQqm5jEViEn/7x1x
         FtNKh+m/Kr2CdJI138Z6YrWR0EAVnp4nLkli0O4iZAjjr5wqr/egzScc8FLYXNtcB2fM
         r/2vRUrYHGpfLzuP/mkmhTVgSh0zZ+6Of7MMIBbM9ROaeUjzCGhMKCYfqFD5ijucoVz/
         zRN5NMeISubW2J2hN8Baew1uaiPdce0ukY9K7PGHlOtt5dbv2FHCVu6CsfhE1mPC7VDB
         Rc6w==
X-Gm-Message-State: ABuFfog8Wigz2ln2Km4OFr2/OGdmjp59SgTbwLHyOuBUm8UgIXxBLdmU
        3x2v5B2/0nyITGjPMUe1N8s9LPRjEi0=
X-Google-Smtp-Source: ACcGV62dkAAFtYov+++RwrQa4vu+C0O0OYmG3L/427XeZZ2S0wnYhMZf23cnsbCAAPSKVbTZgh1B8Q==
X-Received: by 2002:a63:d60a:: with SMTP id q10-v6mr43778098pgg.175.1540244872799;
        Mon, 22 Oct 2018 14:47:52 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id l5-v6sm17025464pfl.28.2018.10.22.14.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 14:47:51 -0700 (PDT)
Message-ID: <1540244870.128590.39.camel@acm.org>
Subject: Re: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
From:   Bart Van Assche <bvanassche@acm.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme @ lists . infradead . org" 
        <linux-nvme@lists.infradead.org>
Date:   Mon, 22 Oct 2018 14:47:50 -0700
In-Reply-To: <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
References: <20181022151818.135163-1-bvanassche@acm.org>
         <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-22 at 22:14 +-0200, Johannes Berg wrote:
+AD4 I must also say that I'm disappointed you'd try to do things this way.
+AD4 I'd be (have been?) willing to actually help you understand the problem
+AD4 and add the annotations, but rather than answer my question (+ACI-where do I
+AD4 find the right git tree+ACIAIQ) you just send a revert patch.

Sorry that I had not yet provided that information. You should have
received this information through another e-mail thread. See also
http://lists.infradead.org/pipermail/linux-nvme/2018-October/020493.html.

+AD4 To do that, you have to understand what recursion is valid (I'm guessing
+AD4 there's some sort of layering involved), and I'm far from understanding
+AD4 anything about the code that triggered this report.

I don't think there is any kind of recursion involved in the NVMe code
that triggered the lockdep complaint. Sagi, please correct me if I got this
wrong.

Bart.

