Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3D8C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3034207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KtWHiNAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3034207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeJWSjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:39:06 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:38209 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbeJWSjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:39:05 -0400
Received: by mail-lf1-f47.google.com with SMTP id x24-v6so680281lfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 03:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iXcupABbqBtyAW0opOo1EZvePTosGW9Qth1CiFBojlc=;
        b=KtWHiNAT9oHyF38BlGdNwFIMxCiMGRK8a7amN4ByTqZ6UT2ltyJKZNdiv1sUJ/eiT+
         7UGUCs510kelCRyW+TdrJ9YUPYcI3WGSGYpiT1vqrvA+xwvrfE060BTtB/SqqDaz9hOc
         N6yjaUVNCYqpumCdY+SnVmyocY3rquUUWygbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXcupABbqBtyAW0opOo1EZvePTosGW9Qth1CiFBojlc=;
        b=H/D4NOU4RoQCeVtFT/ooVkdAtJliHzeEXtvtv5nucs3yWqq9ufyNqoG75y538/aYc7
         bp7UbWSJVsS7re6Rcr3Ht15joI5POvviWoPdhfKpCKvjcOTAGyIuXni1CuYRPMaRWOpM
         AGplRBbd43VZ+TxNWf/BRxDYbssWto03WOMPikjJGQlVCgiy3Snx6zupwBiT+AukMnEQ
         G6WEWqde0/b46IaR+God/Gjkqe5LREQvtAh8Hd8O1hEJAlZKfFIf7M3aqy7AD35kuVjy
         uoLsR98wFZJL/IZypqvFWKqZtcywbljdTX9lV4EoAcM1CFEsAyptOJB5w+Co52Lq0wkZ
         gYOQ==
X-Gm-Message-State: ABuFfoiyI1GKWJFMVtFEzsyLdV3Lo6W96BzttIU0IoJSALeXFn4a0AaO
        y9ovc+EkATYErrQhPzQtWQkmkImBfPdM71Iz
X-Google-Smtp-Source: ACcGV60WclcnUprwCTpe+UdxZOp9Wai679vo7Wl+p3X4huGWN9xogvH8+rM/yUXOLHdjT9dzNArDbA==
X-Received: by 2002:a19:5f1e:: with SMTP id t30mr3907162lfb.76.1540289778109;
        Tue, 23 Oct 2018 03:16:18 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id n3-v6sm153816lfe.8.2018.10.23.03.16.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 03:16:17 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id o14-v6so818118ljj.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 03:16:17 -0700 (PDT)
X-Received: by 2002:a2e:9e56:: with SMTP id g22-v6mr12509799ljk.120.1540289776740;
 Tue, 23 Oct 2018 03:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181023090121.70cdbef2@mschwideX1>
In-Reply-To: <20181023090121.70cdbef2@mschwideX1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Oct 2018 11:16:00 +0100
X-Gmail-Original-Message-ID: <CAHk-=wjKE1Bp5Vm0RtPikB_2w_cTLiYASDobq_H7ky1_cG-krg@mail.gmail.com>
Message-ID: <CAHk-=wjKE1Bp5Vm0RtPikB_2w_cTLiYASDobq_H7ky1_cG-krg@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for the 4.20 merge window #1
To:     schwidefsky@de.ibm.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 8:01 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>>
> please pull s390 fixes and features for 4.20

Pulled,

                 Linus
