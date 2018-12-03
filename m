Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DCEC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEB72081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq+C5MZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDEB72081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbeLCICE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:02:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40726 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeLCICD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:02:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so4561565wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 00:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EN4NQIi3gEp/gwXK9jYi93x1ES/AinZ78y2ykl7Ga2Q=;
        b=aq+C5MZxGH0SXNRevs+IzzjRDCiAi5BYnu5/d6bdjsuy9JeQ5ZHU8mAyJEZbI5H/0O
         8/mLe42hC1BJVm7oHb+reBij8IKmC8oQ0pTN3gbGUKE3OJtra4a7b1e6ftnh5OMZnSeH
         a8ae7pbZvTVE2SMatURpXFmlj9EAvfQs0UHXhXllG6wQxa4yXKMwKQreoUcYqgWG0ma3
         S8Y/Vac+j47tdp9AAYoz9zhfebcVJtxHiVaVj/qMI5s2+Kq0gm+011JmyIeONqDwEYPf
         G1fbecHjXb+xKWoZnQnJuAbWrZ134UbK9jNDls45+vexOZmmHo4xKD8x4QR8w2eOR/Gn
         IY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EN4NQIi3gEp/gwXK9jYi93x1ES/AinZ78y2ykl7Ga2Q=;
        b=MOLhFL3JEXW8m3Euwc1zkd4m4IGpqBiiFmktMvwq980dv5RWV4EQCqw5cj/EYuUyuu
         JPoAu61Vwr2TXAYFc8EuW473pHZfEx6Xptk3/1qbbL850YROvYXUBJOTIKOHCfBoInE2
         h8sncP2HiI2lB6Eo8DlrDlK2/JuZg4fraCQCEq5Jv92lobOVRA4a/TYFXarn+v8nfiui
         G3So5w6BUlBjplXOYvv6l9oOuy8JT2/oS0dnti6lqIDLHtTYk8a/JzKkOngdR95XfPSF
         gV5YdY9Nk0YOe3IhvZsvBCAlLQEd4MYG5i3VjPz44NZFif/e8Oh0fVfzXuz2eXD0cv3j
         yqUg==
X-Gm-Message-State: AA+aEWaOZqxCUurk8W6dneIz1YPaPhH2wE2j/2qUEgK8WAzRAkNtCsWO
        ISK8r9pfx+nQGasNTOzhm3I=
X-Google-Smtp-Source: AFSGD/XUwbVzpdPlNRHyfDo4aTd4xrRlPwM9aOXuKl9poH0r1Gr+UTb+bgGCWH8QkVaOqp3cZ4MwXA==
X-Received: by 2002:a1c:b58b:: with SMTP id e133mr7589024wmf.0.1543824119505;
        Mon, 03 Dec 2018 00:01:59 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o62-v6sm5170591wma.1.2018.12.03.00.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 00:01:58 -0800 (PST)
Date:   Mon, 3 Dec 2018 09:01:56 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, paulmck@linux.ibm.com,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn
Subject: Re: [PATCH v2] locktorture: style fix - spaces required around
Message-ID: <20181203080156.GB25965@gmail.com>
References: <20181203022356.58794-1-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203022356.58794-1-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Wen Yang <wen.yang99@zte.com.cn> wrote:

> This patch fixes the following checkpatch.pl errors:
> 
> ERROR: spaces required around that ':' (ctx:VxW)
> +                torture_type, tag, cxt.debug_lock ? " [debug]": "",

There's literally 1 million checkpatch 'failures' in the kernel, so 
unless we want to apply 1 million commits (we don't), please do such 
cleanups as part of some real feature, simplification or optimization 
work.

Thanks,

	Ingo
