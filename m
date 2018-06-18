Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9EEC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB82D2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEPqAOL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB82D2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935854AbeFRSkm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:40:42 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32877 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935578AbeFRSkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:40:40 -0400
Received: by mail-pg0-f66.google.com with SMTP id e11-v6so7934946pgq.0;
        Mon, 18 Jun 2018 11:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ft8q9UVOKpNFkvrtqHmHb28xmDEDwR6JksgyKfuxK9U=;
        b=LEPqAOL76qGO36rx07U4mmbPn+xeZHhIW9n2Q/6ledLf7XEaBcUJN/wulRZxmjdDpi
         tK7fUfEvxzVC70wSqvFvjMa5XavkWBRn0dB8vD/a26J+1DtnI9mjjGhcGGfPXnadvkuu
         D7CkcTRaG0DLpM5wqXIB15o/WXlkBlva4brkArSJCgFsFFmhg/qQ6PYZu6DAR/eLaNCW
         a639+N2vEjwN40gqkS9xhxvV2lssPBkJduuEOE6P9FNCT/ohRruuk+AEVWb4Vb4xkTFO
         TjErWoVXTilc1H9py/js8IlLA/G06UW+rSi6e5kzYQD3nGUCJIOCCF1Pi4zZaATJWw1J
         B89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ft8q9UVOKpNFkvrtqHmHb28xmDEDwR6JksgyKfuxK9U=;
        b=qaIqEU73dGPXUkhuIPGDkj2Jl6GFIztIiOij/m8qSstk4ORxHJZC7SenlwY6u7eFb7
         wX04Ko/7gq+kWpGJFBy5moiDCVztwUd6nl0y7aDdDwBbxDb3xCHEe4Rkh6A6bRrBwsgS
         7YOUdSLmOTsF7K0/fcqlFMfTfJ9elijTBGJYcqblZRaKM7u2nvgcxSN0U4LRigyh3BCs
         mAQ2aOcf3WIj7+RIMzL0f4SkBqGbC/ibPxSPhf7xa2tKUA1NOfmt48qE9utzIjgvT1YP
         naE2P77UpP0KUfgkkYgnOJwTpfUfMIseGJGAoho/tsSzVOb+8IWqjWI7VN0O3eDNhRNC
         DDSA==
X-Gm-Message-State: APt69E03ipIg1lJ1CwawaFihoCsqt0MniUyPx76EDaAgNBdjn1Zrt6Q7
        NbByuDCAqJVX6cNSMRs4O+HTJ4ENjJ1wT8QNV+M=
X-Google-Smtp-Source: ADUXVKKUMi92faU0eRMpiHa/44RfMsNA88VmT+EWr9qDPkd9t4cbABGaTfEhEv5I9sOrBhAPbdv09BZU+4TLTwi+Rdc=
X-Received: by 2002:a62:234a:: with SMTP id j71-v6mr14361236pfj.221.1529347240161;
 Mon, 18 Jun 2018 11:40:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:284f:0:0:0:0 with HTTP; Mon, 18 Jun 2018 11:40:19
 -0700 (PDT)
In-Reply-To: <20180615190833.GC5877@mellanox.com>
References: <20180613234947.15767-1-xiyou.wangcong@gmail.com>
 <20180614053446.GB18426@mtr-leonro.mtl.com> <CAM_iQpXxHk+yFqqK-Hezsc83_mKfbUXr4=jjNnik5DwGscRKUA@mail.gmail.com>
 <20180614070108.GD18426@mtr-leonro.mtl.com> <20180614142448.GC24762@mellanox.com>
 <CAM_iQpWz9b01ksW_OUHgr1=pf-bNsq_TxoNCQxuDdhUXfvoyOQ@mail.gmail.com>
 <20180614172441.GE24762@mellanox.com> <CAM_iQpXFmqcCQWkyGPmev5LrPpDoEc=wpXQVDWJx2UQWPhwb2g@mail.gmail.com>
 <20180615025739.GB29138@mellanox.com> <CAM_iQpUYWzxMDgJJazLwvD1Tx_7i4PRC0r+2JKar3Vr4bW-Q+w@mail.gmail.com>
 <20180615190833.GC5877@mellanox.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 18 Jun 2018 11:40:19 -0700
Message-ID: <CAM_iQpXq0rz7FZoRJGjw_vP7_3EDTzF_aW3CW1EDBFiWA_G=4w@mail.gmail.com>
Subject: Re: [PATCH] infiniband: fix a subtle race condition
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 12:08 PM, Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> The point is, I don't care about the imbalance report.

OK, we are not on the same page.

Sorry for wasting my time.
