Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04B6C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC9220857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pv7OdwEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC9220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbeGaAAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:00:13 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43388 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbeGaAAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:00:12 -0400
Received: by mail-pl0-f67.google.com with SMTP id x6-v6so6169854plv.10;
        Mon, 30 Jul 2018 15:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cdiVCEk4CMVAogUqVEJbGi6RSd3/dSCIqJdcog6TGjc=;
        b=pv7OdwEg7MrlDOAYYo0qH2eQ5dPCAJntPG5CG+M2wt+0tT+bWRQm1XlOd4LFBPl8OR
         QCGkrRCwMErKknjkAWZLf9T9bXWmsIAR2l1oSYBPaz3hdnhH+4kljYyvF0En1M8hXiSW
         OwAEMV09IgQK67PPcQWT8dF01daRo8YJoI3vzOynJ1/tDV0M+sASWcUBQgl0h8E2fZ7k
         L0T1r+4BSpmIyk3NG+d6dYKRdh0/p0ZerwB86K+xDPE9wHvZoLS+9UEg+/uCqEGmQtRL
         LxRecVihFDn/s2IlTDG9YE4djxaIx+Ao+0UYrMtoidlK9c75KmZ3pcrwuF1ueibqsx0R
         ctyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cdiVCEk4CMVAogUqVEJbGi6RSd3/dSCIqJdcog6TGjc=;
        b=SE5aS3fYTjptv1ieVL3OjNZEmD3HKpL5kV10jOQYZQlIUA4KJKUXCiarseaxuXlst1
         Drzx75FCIpSm2e7A9kiSVbSF0nNYVaiEJv1sgQiC5Tm6SzldI8YvjP3myTvEMfv/gVwM
         x61OOT0D1Q6T62Rr0/gtHM4EmBakITxXZBNZ6CbujnhO/iqJL3XK5F6Nxr3qr9o5R7QZ
         8CIZwewYy/Wx4osk+nGjNtDoS4DH8AOszKxXLGKjfzjcZiy5i5ZktOdfsKBpkTcdpO9R
         +X/D1b6xSOgLNPQWojto1SQ1j3adIcCW2FmTRyFxwcN6Wk1Vuru9T6j6dwHVkkOQFusq
         BfCg==
X-Gm-Message-State: AOUpUlF3MCeP2vdNB9P1nMpRvi4V/OEU35KpxgTi2ri9PFM0BKcrVEbo
        60rptnLlF+HCNwom9KIvFY4GPPge
X-Google-Smtp-Source: AAOMgpeHlFD9hd9nsAkzKNHa5wXtCdd7IIeCHeuMiNz2OuZlyNwUhW1pIIPttORGemA/CcdFrkHedQ==
X-Received: by 2002:a17:902:ab94:: with SMTP id f20-v6mr17815212plr.231.1532989387734;
        Mon, 30 Jul 2018 15:23:07 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id 64-v6sm21086358pfi.89.2018.07.30.15.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 15:23:07 -0700 (PDT)
Subject: Re: [PATCH] net: remove bogus RCU annotations on socket.wq
To:     Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20180730074507.17037-1-hch@lst.de>
 <20180730074507.17037-2-hch@lst.de>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <bd0e18ee-c3be-fef2-b2b8-3a2ad576f765@gmail.com>
Date:   Mon, 30 Jul 2018 15:23:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180730074507.17037-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/30/2018 12:45 AM, Christoph Hellwig wrote:
> We never use RCU protection for it, just a lot of cargo-cult
> rcu_deference_protects calls.
> 
> Note that we do keep the kfree_rcu call for it, as the references through
> struct sock are RCU protected and thus might require a grace period before
> freeing.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
