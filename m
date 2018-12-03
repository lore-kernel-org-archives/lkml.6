Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C14C65BAF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2DA2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYv+Q2Ag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2DA2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbeLCIAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:00:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53913 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeLCIAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:00:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id y1so4629645wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 00:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7MNQNLCdVJU209/uRxTGLhC5K6Fs9o95Vroaj37hV24=;
        b=kYv+Q2Agj/0Rx7WyjdI1RSyORzA3CPbE8FD+NM49vGzTLZwtCa888p71qiFaBWEM4C
         3ujx4adyndXvsiHnCFXtYdydGUBw7Xn0ZyD2IQaJlKVq13oeOIkGNaLqfAE2RRQMY4e1
         wYj5+FDFkqQ4uCYg7GjoA2rpRIWhoturMGxLdwYwdOah2IX6JLcIiR+LkB0z3dS/+8MB
         BUpKBMj849i9Dj9Zcb8b44W/DTqfOCOtkRYRY0b/g2+EbVbX6fCnFhqz0iT6c7dSt79J
         EHcaQoboWDz0jX2UGfqL7l9OsjebZ4TvBdLi+FRVpdXtGaYXkxePyB83+j7xDWPJgug8
         Y8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7MNQNLCdVJU209/uRxTGLhC5K6Fs9o95Vroaj37hV24=;
        b=BC37URCtuh4navCF/lwY+q1J9opNLtDh9dBZD/67pAH9n+bxh67Bzb2uuSMDzBF9KZ
         cUKy7FpbdJjiSJqX/WbePxCKm7Gpkjki9dkv+mp5jPOuAqa6aa9zanCs0d9xyRV5nHSa
         btnGnoT6Mt4mAwR+7gRCTWH1awhHdP9Hf2lRv4YbUVI0JjJxc1MNAfhTXe4ge5yV7RrP
         /RL7uKO4qXaPy9k9/GTh9B0swCIgFfzcUq/DJe3d742koou+QUwtEi9fvhOtTRCdJ+lr
         3RVQUhzVmTBWzmwD5ZplW6LipN0ePzfHPZxRybysCYJ5q9q/rbAsebmrbrnV+OckF2Ba
         2SsQ==
X-Gm-Message-State: AA+aEWa5dN9ljOusjKQS/weu5KDRA+GEVtXRT+1ExvHe3Ut41NaCig0O
        hK+seG2bKVDtEKRNqTXMYKQ=
X-Google-Smtp-Source: AFSGD/XSOjvqwKFjrIOErAKLIDXuPQXbEI0R0iOlpdHdXJt1KLEYjuP7SSLe9gRzTNFtFxkMTFv8xw==
X-Received: by 2002:a1c:9183:: with SMTP id t125mr6998702wmd.79.1543824042864;
        Mon, 03 Dec 2018 00:00:42 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c13sm31617989wrb.38.2018.12.03.00.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 00:00:42 -0800 (PST)
Date:   Mon, 3 Dec 2018 09:00:39 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, paulmck@linux.ibm.com,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn
Subject: Re: [PATCH v2] locktorture: Fix assignment of boolean variables
Message-ID: <20181203080039.GA25965@gmail.com>
References: <20181203022318.58083-1-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203022318.58083-1-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Wen Yang <wen.yang99@zte.com.cn> wrote:

> Fix the following warnings reported by coccinelle:
> 
> kernel/locking/locktorture.c:703:6-10: WARNING: Assignment of bool to 0/1
> kernel/locking/locktorture.c:918:2-20: WARNING: Assignment of bool to 0/1
> kernel/locking/locktorture.c:949:3-20: WARNING: Assignment of bool to 0/1
> kernel/locking/locktorture.c:682:2-19: WARNING: Assignment of bool to 0/1
> kernel/locking/locktorture.c:688:2-19: WARNING: Assignment of bool to 0/1
> kernel/locking/locktorture.c:648:2-20: WARNING: Assignment of bool to 0/1
> kernel/locking/locktorture.c:654:2-20: WARNING: Assignment of bool to 0/1
> 
> This patch also makes the code more readable.

No, it doesn't make the code more readable!

0/1 patterns are blatantly obvious and shorter to both write and read 
than false/true text.

NAK.

Thanks,

	Ingo
