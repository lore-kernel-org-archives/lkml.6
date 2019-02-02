Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADB6C282DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 02:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D686821479
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 02:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549075421;
	bh=Fxt6EEMv8diFfhlteQ86/lbQu5PeOYN/xZ0FX6sJOXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=E3XikGyllsUHI4A50z49WADEFEt4uROr9AzTqqoOuu1zPn6VzpnQNVXxQ+z7f4A14
	 rxrnix/5ztMCI4vrFI0CNrLNQ+lCWFydwIee2otwalsY6aGcoZ9rYgb3HggTCg3bg8
	 JL03yH6hKtFHUzVhyo+l7ZU7W8wWeUzBio65lqgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfBBCnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 21:43:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:53106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfBBCnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 21:43:39 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B28F218FF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Feb 2019 02:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549075418;
        bh=Fxt6EEMv8diFfhlteQ86/lbQu5PeOYN/xZ0FX6sJOXc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S21h1YK6BKzStzLpb02jBXcXjiAsDdc458X7QJmfYXf1ODZMZZ7E7Jc3BUzaCPXEs
         EKCHDng9G8RQA/go4L/HvyiYjmvV8wFVWCcUkjzRcWhud6nEF2SXX+T8iPp1rr/WEA
         mc5/qgLztvWE43ey44fMZnNxFaKvMgrfLMgRlNHE=
Received: by mail-wm1-f53.google.com with SMTP id f188so8001180wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 18:43:38 -0800 (PST)
X-Gm-Message-State: AHQUAuYp470Z2+mXF65YYCOzd5ML43BOte6oezaKuMHnC1Lci46RuYuu
        kTs3K2Kat/ZZUYgFyR/5twta8rWcPFKAxcKHYcDbsw==
X-Google-Smtp-Source: AHgI3IaLDtknMk9msnJzB8p7/ZaFnEjVI0O5HgO/SZlNE4vPPjnv1MQHAdxZMYvosaAD9ErsV8lMjEKVltuVctTk/ok=
X-Received: by 2002:a1c:f112:: with SMTP id p18mr4348326wmh.83.1549075416752;
 Fri, 01 Feb 2019 18:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20190201205319.15995-1-chang.seok.bae@intel.com>
In-Reply-To: <20190201205319.15995-1-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 1 Feb 2019 18:43:25 -0800
X-Gmail-Original-Message-ID: <CALCETrWupURU3QW-hs238oCwK0kUV+dpv4NWmH4E9=DBurrMpg@mail.gmail.com>
Message-ID: <CALCETrWupURU3QW-hs238oCwK0kUV+dpv4NWmH4E9=DBurrMpg@mail.gmail.com>
Subject: Re: [PATCH v5 00/13] x86: Enable FSGSBASE instructions
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi hpa-

A while back, you were working on some patches to make modify_ldt()
play better with this series.  What happened to them?

--Andy
