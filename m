Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6334EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 05:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067B92650A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 05:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSDH8uFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067B92650A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeFZFKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 01:10:24 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32789 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeFZFKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 01:10:22 -0400
Received: by mail-pf0-f196.google.com with SMTP id b17-v6so7540317pfi.0;
        Mon, 25 Jun 2018 22:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xrk+GqouRkO2sMqxpXnSsY+YoLo/L2MiMcF1ddS4UQk=;
        b=qSDH8uFH339XY8ZhnyVuxdp+ewFAp9FdegeIt11s3MlYvylqG7o90Yvj42P37PuXZA
         DjHVrKHNBjsNpmBhQAh40CTSqYjjdiZmhLlGVu+X6QpILas6HiTpJtGv+ByjOf+w1m0O
         yfVlpGhINxFxQfEZNShEAYcWjGb2SDjSnZcK9HnzAAQ4dcBHx+7Q7Bp6vfn++JAN7rTG
         JvofzMwOZkqyiwZ24GNau1zZEvtDSlHsyuNq/ZE4ecc68ewNf7bvuLmnxI8bkRjDDOlf
         xFh0puS+o0LpIcs+gomuY+N1qm+uAr+hoNCB6jqkCKWScZFYs1FNkVBccdSTpn5WMExP
         DmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xrk+GqouRkO2sMqxpXnSsY+YoLo/L2MiMcF1ddS4UQk=;
        b=ewx60x40coMw4hF4jUANEfnru2ecSuQiAJ9FyRnF5MG/hLjGCdr31wdSSWpsoKfDfu
         tCi89XZVnqT+Vt9qCtpKCu2xvjnGkPqMtoOPh8w9Pw+wEVoI8xkIlvWwtBj+bkrbOxhJ
         GxIaEPPfpr30HnUXUqWX38+0jImA5R1kHMQ6k7nLAmxNnnWZqqgkNnpyxOQoJ+y7w/qy
         93djSnb04/a4samPtW+/fWJSumJz0tBrZVvu8dAeQ34atqIDPutgFuh3VYjBhLDGDPz7
         EtUSSl/OqGSi5Ph/dYR1OpC6hNll0njSCbx6+GNHPNP+KGNMvEMqqK1XNGWwUKWsNHi5
         khbg==
X-Gm-Message-State: APt69E0g+UB/zvycHdByPtuCm4FcCTxlln21S8LUHIWfcy++1B9Mr370
        hFxs2U8f5PQeAtQprSmhksQ=
X-Google-Smtp-Source: ADUXVKIfm8HDqBfp/cPQkVYC/F92lJOwGsgnlPL8V2wvbp1W62Q2qrQprbBJ/tn8dZrjJyVhfFZ8tA==
X-Received: by 2002:a63:7986:: with SMTP id u128-v6mr12672017pgc.273.1529989821563;
        Mon, 25 Jun 2018 22:10:21 -0700 (PDT)
Received: from hxeon ([147.46.241.218])
        by smtp.gmail.com with ESMTPSA id g78-v6sm983986pfe.39.2018.06.25.22.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 22:10:20 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@hxeon>
Date:   Tue, 26 Jun 2018 14:10:17 +0900 (KST)
To:     Byungchul Park <byungchul.park@lge.com>
cc:     sjpark <sj38.park@gmail.com>, paulmck@linux.vnet.ibm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [PATCH] locking/memory-barriers.txt/kokr: Update Korean translation
 to fix broken DMA vs. MMIO ordering example
In-Reply-To: <20180626045609.GB20783@X58A-UD3R>
Message-ID: <alpine.DEB.2.20.1806261406220.1528@hxeon>
References: <20180617051608.2128-1-sj38.park@gmail.com> <20180626004738.GA20783@X58A-UD3R> <alpine.DEB.2.20.1806261218490.1528@hxeon> <20180626045609.GB20783@X58A-UD3R>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="781441777-375754469-1529989820=:1528"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--781441777-375754469-1529989820=:1528
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 26 Jun 2018, Byungchul Park wrote:

> On Tue, Jun 26, 2018 at 12:21:23PM +0900, sjpark wrote:
> > Hello Byungchul,
> >
> >
> > On Tue, 26 Jun 2018, Byungchul Park wrote:
> >
> > > On Sun, Jun 17, 2018 at 02:16:08PM +0900, SeongJae Park wrote:
> > > > Translate this commit to Korean:
> > > >
> > > >   5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")
> > >
> > > Hi SeongJae,
> > >
> > > You keep doing good jobs ;)
> > >
> > > I believe it would be better if you consider the little things below
> > > more. What do you think about it, SeongJae?
> >
> > Thank you for great comments!
> >
> > >
> > > > Signed-off-by: SeongJae Park <sj38.park@gmail.com>
> > > > ---
> > > >  Documentation/translations/ko_KR/memory-barriers.txt | 15 +++++++--------
> > > >  1 file changed, 7 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
> > > > index 921739d00f69..ada0a709cce1 100644
> > > > --- a/Documentation/translations/ko_KR/memory-barriers.txt
> > > > +++ b/Documentation/translations/ko_KR/memory-barriers.txt
> > > > @@ -1891,19 +1891,18 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
> > > >  		/* 소유권을 수정 */
> > > >  		desc->status = DEVICE_OWN;
> > > >
> > > > -		/* MMIO 를 통해 디바이스에 공지를 하기 전에 메모리를 동기화 */
> > > > -		wmb();
> > > > -
> > > >  		/* 업데이트된 디스크립터의 디바이스에 공지 */
> > > >  		writel(DESC_NOTIFY, doorbell);
> > > >  	}
> > > >
> > > >       dma_rmb() 는 디스크립터로부터 데이터를 읽어오기 전에 디바이스가 소유권을
> > > > -     내놓았음을 보장하게 하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
> > > > -     가졌음을 보기 전에 디스크립터에 데이터가 쓰였음을 보장합니다.  wmb() 는
> > > > -     캐시 일관성이 없는 (cache incoherent) MMIO 영역에 쓰기를 시도하기 전에
> > > > -     캐시 일관성이 있는 메모리 (cache coherent memory) 쓰기가 완료되었음을
> > > > -     보장해주기 위해 필요합니다.
> > > > +     내려놓았을 것을 보장하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
> > > > +     가졌음을 보기 전에 디스크립터에 데이터가 쓰였을 것을 보장합니다.  writel()
> > >                                                                         ^
> > >                                                                      참고로,
> >
> > Nice comment.  This will enhance the readability a lot.
>
> Could you add this, too? A quite little thing tho.

Oops, I missed that.  Sorry.  Attaching the patch below.


Thanks, SeongJae Park


============================= >8 =====================================

From bcfb52af5d1f6c6aa171d105bdd7376b4dfabf13 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj38.park@gmail.com>
Date: Sun, 17 Jun 2018 14:08:42 +0900
Subject: [PATCH v3] locking/memory-barriers.txt/kokr: Update Korean
 translation to fix broken DMA vs. MMIO ordering example

Translate this commit to Korean:

  5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
Changes since v1:
 - Applied comments from Byungchul Park
 - Rebased on v4.18-rc2

 .../translations/ko_KR/memory-barriers.txt         | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 921739d00f69..7f01fb1c1084 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -1891,22 +1891,22 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
 		/* 소유권을 수정 */
 		desc->status = DEVICE_OWN;

-		/* MMIO 를 통해 디바이스에 공지를 하기 전에 메모리를 동기화 */
-		wmb();
-
 		/* 업데이트된 디스크립터의 디바이스에 공지 */
 		writel(DESC_NOTIFY, doorbell);
 	}

      dma_rmb() 는 디스크립터로부터 데이터를 읽어오기 전에 디바이스가 소유권을
-     내놓았음을 보장하게 하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
-     가졌음을 보기 전에 디스크립터에 데이터가 쓰였음을 보장합니다.  wmb() 는
-     캐시 일관성이 없는 (cache incoherent) MMIO 영역에 쓰기를 시도하기 전에
-     캐시 일관성이 있는 메모리 (cache coherent memory) 쓰기가 완료되었음을
-     보장해주기 위해 필요합니다.
-
-     consistent memory 에 대한 자세한 내용을 위해선 Documentation/DMA-API.txt
-     문서를 참고하세요.
+     내려놓았을 것을 보장하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
+     가졌음을 보기 전에 디스크립터에 데이터가 쓰였을 것을 보장합니다.  참고로,
+     writel() 을 사용하면 캐시 일관성이 있는 메모리 (cache coherent memory)
+     쓰기가 MMIO 영역에의 쓰기 전에 완료되었을 것을 보장하므로 writel() 앞에
+     wmb() 를 실행할 필요가 없음을 알아두시기 바랍니다.  writel() 보다 비용이
+     저렴한 writel_relaxed() 는 이런 보장을 제공하지 않으므로 여기선 사용되지
+     않아야 합니다.
+
+     writel_relaxed() 와 같은 완화된 I/O 접근자들에 대한 자세한 내용을 위해서는
+     "커널 I/O 배리어의 효과" 섹션을, consistent memory 에 대한 자세한 내용을
+     위해선 Documentation/DMA-API.txt 문서를 참고하세요.


 MMIO 쓰기 배리어
-- 
2.13.0


>
> > > > +     을 사용하면 캐시 일관성이 있는 메모리 (cache coherent memory) 쓰기가 MMIO
> > > > +     영역에의 쓰기 전에 완료되었을 것을 보장하므로 writel() 앞에 wmb() 를
> > > > +     실행할 필요가 없음을 알아두시기 바랍니다.  writel() 보다 비용이 저렴한
> > > > +     writel_relaxed() 는 이런 보장을 제공하지 않으므로 여기선 사용되지 않아야
> > > > +     합니다.
> > > >
> > > >       consistent memory 에 대한 자세한 내용을 위해선 Documentation/DMA-API.txt
> > > >       문서를 참고하세요.
> > >
> > >      See the subsection "Kernel I/O barrier effects" for more information on
> > >      relaxed I/O accessors and the Documentation/DMA-API.txt file for more
> > >      information on consistent memory.
> > >
> > > Don't you think the whole sentence need to be translated? If yes, then
> > > it would be better to do that as well ;)
> >
> > Oh, my mistake!  It should be.
> >
> > I applied your comments to the second version.
>
> Thank you SeongJae :)
>
> > Thanks,
> > SeongJae Park
> >
> > >
> > > > --
> > > > 2.13.0
> > >
> > > --
> > > Thanks,
> > > Byungchul
> > >
>
>
--781441777-375754469-1529989820=:1528--
