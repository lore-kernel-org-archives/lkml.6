Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A04C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB49724960
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dGl6xbff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB49724960
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933917AbeFVWgF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:36:05 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37749 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754401AbeFVWgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:36:03 -0400
Received: by mail-pf0-f195.google.com with SMTP id y5-v6so3833704pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=az8NNOGTSgAOPZGkFzx4Q6ziQ6znhgVek7Aosbe6yW0=;
        b=dGl6xbff37OxUDds4dW6obzOmtGBOYrPapgLP2q1ZoJ6uUouv+YarphYuQIAgBcJUS
         6O4gx00tHu8xZ4Dv6iqME7MdtK704wOo7z7Eih9eObeQPbXCL2xN0XGtPu4Ql6q9RPTG
         E4Be5u3g2EfEnwtmcR/KSO7ylrOVXGgpT/BNubavXapo4G64QIDibqZxk2UmA2ErNic2
         EEOn9stqvbWV3uDXQ7Ri0tR6v+MlvkyPEN/dkuyu7tg2gX+O6zuHE6fgS6TJZYpNrbS/
         9oySqPJEs+cYtPMhyySlpJXMhY6nggDAdsQriRijmt84JbH3zQMaaFvQmmsHIw0xRoqb
         XJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=az8NNOGTSgAOPZGkFzx4Q6ziQ6znhgVek7Aosbe6yW0=;
        b=g2NvxVzYS/p6l7x/DJ6/3ayBvRYnAPVzlbgBs8EG20jtxy9QohXBNtFLR9YFhD437c
         5b+Bl0ukiw8K0+gsEi7aY26svNKys1++prhVfvaxrfpleDr8J4qFJAciV2X654q/0XBI
         mOf1sE85ku5t5BD+4dEkQGiGRirzZux5DE1l/AOneOQZAsi9flbzZfO/UYCF5KXPDY/0
         2jbzf1I8ymvr6Zx/161srIxfLlv680du7R7qYZCHzUfws/Pk5m14WXSLd0fnxBMQkn1K
         IpNejVXxSkIxdwNNw2PHV6nSGHAVBzXIwFlCqwSafKTyI69OvkEGvxRL2nSAM1PKhUV1
         RxOA==
X-Gm-Message-State: APt69E3fLsPiOvCrCRzUpIgHpeIzfJlHdUJgC3VmCsC6gpmAj8bRVGoH
        Cb1V2URqkRMayGWz1hnfy2AVNA==
X-Google-Smtp-Source: ADUXVKJUqHhmeNNLzLdInXn7ttlGkLN8fVbhQHUoR3u+/XutNqB3wg9AEECmTSkbDNCx8BGQ7sFn+Q==
X-Received: by 2002:a62:9513:: with SMTP id p19-v6mr3492803pfd.239.1529706963239;
        Fri, 22 Jun 2018 15:36:03 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 10-v6sm19997413pfs.111.2018.06.22.15.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 15:36:02 -0700 (PDT)
Date:   Fri, 22 Jun 2018 15:36:02 -0700 (PDT)
X-Google-Original-Date: Fri, 22 Jun 2018 15:36:01 PDT (-0700)
Subject:     Re: [PATCH] MAINTAINERS: Add Daniel Lustig as a LKMM reviewer
In-Reply-To: <6b17610f-e54b-9c05-2f28-f4873eff3a4c@nvidia.com>
CC:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        paulmck@linux.vnet.ibm.com, akiyks@gmail.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Daniel Lustig <dlustig@nvidia.com>
Message-ID: <mhng-5248f5fe-5b7b-4210-b5e4-7d726c28fa0d@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 14:48:56 PDT (-0700), Daniel Lustig wrote:
> On 6/22/2018 2:17 PM, Palmer Dabbelt wrote:
>> Dan runs the RISC-V memory model working group.  I've been forwarding
>> him LKMM emails that end up in my inbox, but I'm far from an expert in
>> this stuff.  He requested to be added as a reviewer, which seem sane to
>> me as it'll take a human out of the loop.
>>
>> CC: Daniel Lustig <dlustig@nvidia.com>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>
> Looks like there's an accidental backquote before my name?
>
> Once that gets fixed:
>
> Acked-by: Daniel Lustig <dlustig@nvidia.com>

Thanks.  Unless anyone has any opposition I'll submit the fixed patch as part 
of my next pull request.

commit 9d01337e4724be4d34bfe848a7c64d14bfdb89ea
gpg: Signature made Fri 22 Jun 2018 03:35:24 PM PDT
gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
gpg:                issuer "palmer@dabbelt.com"
gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
Author: Palmer Dabbelt <palmer@sifive.com>
Date:   Fri Jun 22 14:04:42 2018 -0700

    MAINTAINERS: Add Daniel Lustig as a LKMM reviewer

    Dan runs the RISC-V memory model working group.  I've been forwarding
    him LKMM emails that end up in my inbox, but I'm far from an expert in
    this stuff.  He requested to be added as a reviewer, which seem sane to
    me as it'll take a human out of the loop.

    CC: Daniel Lustig <dlustig@nvidia.com>
    Acked-by: Daniel Lustig <dlustig@nvidia.com>
    Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff51b5f..ac8ed55dbe9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8316,6 +8316,7 @@ M:	Jade Alglave <j.alglave@ucl.ac.uk>
 M:	Luc Maranget <luc.maranget@inria.fr>
 M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
 R:	Akira Yokosawa <akiyks@gmail.com>
+R:	Daniel Lustig <dlustig@nvidia.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
