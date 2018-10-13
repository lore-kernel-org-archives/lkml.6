Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ED7C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93EC20859
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5DvCsT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93EC20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbeJMPay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 11:30:54 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:35672 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeJMPax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 11:30:53 -0400
Received: by mail-wr1-f50.google.com with SMTP id w5-v6so15695907wrt.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 00:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NseNZUrLXiYpT4+BgxE7y7IHYFDbxTSq55jLLHgY0Lg=;
        b=l5DvCsT9Hh8WjLTdk1c43LPwNUCw9hutIjuGYQ7zC6oWr/CgU1AsmFlaqCFXPzwpON
         pmDfKCKIigglOKeTWwDFDmk5yz4CqngTs1DG8nDDkUjUTffX9haXZ1JjjH/+QqO9tQjy
         5Qi1Qo6jm+Q6Hq6LgF/J3JzVkvBzrLOWDVGktoAaKDlUtFToTNtIl0RR4G5VV9NJ6+/Z
         QEtZ8q73dstyRd23J5pGiGFOLHfwza7aORkGuL3QrHV37LOVzj3An9oOxnkoonr5sI6f
         6WKim/FIm46hrDcT2hSGJ6R4XuDSBn+PksIdPkotfUfUXnW3N73ZtKafrj3bhuCeVMV7
         z8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NseNZUrLXiYpT4+BgxE7y7IHYFDbxTSq55jLLHgY0Lg=;
        b=bTusDYdp8P+zvJHKFbz6oPUmW7SvVf/ZANT6jy0UM12IKN8UUTApWfCeuNYSV73+D1
         RyETVSSQ5GVf1Nqj99oeEpnQiUQoPc50KolOFBGU5dIA3juBHcR7xoejUcjL4rLtXhle
         AIhVRO2fcgNe+xXnCVUzimVHRuZhgsHhOizE1Q7orQsrqxLQ4YrCCfA4Q2fQ7+NWr40X
         gj1EkFu/gP6Mn4IpJwUKRZVlWLOdj8Iq8eQes6HonqE6XKbaeApY6A4ropIJvPsbgS0J
         zSLH2hAYBKPZq80aOaItYedrnEmDkNeNqNOm8mlyyt3/RqspJ2YK+iZ2iXugelU00XxV
         y98A==
X-Gm-Message-State: ABuFfohKepaiUpRRBVH2yvQXNChUQiH0yeHi18vpimWDPdXaw6TOIer5
        31DFANAI89uU3QTOzs7I9w==
X-Google-Smtp-Source: ACcGV60ymo9NBBFivA0zBwiIuOLfVXXz9+aB+2310I9Xmlrqp3VskppG1Kofkdz8wnk3/0XyQt3HbQ==
X-Received: by 2002:adf:cf0b:: with SMTP id o11-v6mr7743296wrj.272.1539417283630;
        Sat, 13 Oct 2018 00:54:43 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id w2-v6sm2614658wre.57.2018.10.13.00.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Oct 2018 00:54:42 -0700 (PDT)
Date:   Sat, 13 Oct 2018 10:54:41 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: procfs: Move proc_fill_super() to fs/proc/root.c
Message-ID: <20181013075440.GA25825@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
