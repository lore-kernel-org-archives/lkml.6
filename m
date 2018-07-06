Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964A1C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5355A20837
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OaPTFB5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5355A20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754079AbeGFOKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:10:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39328 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753652AbeGFOKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:10:50 -0400
Received: by mail-ed1-f66.google.com with SMTP id w14-v6so8771619eds.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 07:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aR4B7tb3weh0/bPO1IMsn6iyr8S3LYZKPCOeM5TJXt4=;
        b=OaPTFB5Fc2y7rbdUmTh71HjIOZmIqwOfDofCdH4eqFSAUG/0bQqUcQhGV7oR3+Ntet
         iMsI0HYjsJi7WLhtr6AqMY7B3R5PBRCTm1Gxmswm2stTD4yUEVipF72j/9sJAIoXqL4E
         JozsT1bHdhIpMkPWWYo9SC6eW4PNRbRcWHMKw0gZNju0YYzcBf5dIN6hbaXV3gZW4hVW
         /fXsHB28nD2aOCaW8tgHDGY8dXQ6oQBYt7OrqP17yWHP3P3PeZaqkMiqgOE3WhmeFkJB
         sBwspy8rs61+YRw7Bw9c6Lu3Df4gMlzPnc5tRh8ZRmUdXfZH846qIdqyfJ5mO0VugNFn
         u7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aR4B7tb3weh0/bPO1IMsn6iyr8S3LYZKPCOeM5TJXt4=;
        b=PSdD1wF+1WKngLO+Au2Q71gZERbt3/w2oTsJO1PeWBGdToDhrplAPpRYLMcnbBrx+o
         Jmzz9fZznNgXZrH7Wdsp+dWsXceu+5g5FH01S/bfQfpHoNGW7JwJFo5ChkectCaYXsDG
         SDf0ZEbJJr5xoFMkYH7ruqXL62fWWCvhVhuL438PqYN8ov12K9a8GSSB1Sjj5CQ1PhK6
         VCNOrNzM+eA9vAN9pDk1A+7KUeF6btJRVX/IltS0MyhByvjA7T3qS3b+gigplay/OfWH
         wGRaQqwxIjO5NgSd/gV7STEHTLsZCl2XU1sVT1Ri1orKq/RORvSHJshJiMzJfDOd2n8L
         9vyw==
X-Gm-Message-State: APt69E2P+vaVI4l8isaBl97TZmCAjlRIXba5Q+pD37kqyBPXN3y5ch8y
        n/lY547NSjFMxtBmoxh0XWPOiA==
X-Google-Smtp-Source: AAOMgpfkjzZeeFAk9ugqbewTF3maLUIecDjg2jzdMlV1pRe3g853QOx2PfYMZFgzcrhBXINoWswo2Q==
X-Received: by 2002:a50:90e7:: with SMTP id d36-v6mr10724078eda.279.1530886249679;
        Fri, 06 Jul 2018 07:10:49 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r3-v6sm4506579edh.9.2018.07.06.07.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 07:10:48 -0700 (PDT)
Message-ID: <1530886247.3205.53.camel@arista.com>
Subject: Re: [RFC 0/3] iommu/iova: Unsafe locking in find_iova()
From:   Dmitry Safonov <dima@arista.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org,
        Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Fri, 06 Jul 2018 15:10:47 +0100
In-Reply-To: <20180706131611.h3w2kdinmjguikgo@8bytes.org>
References: <20180621180823.805-1-dima@arista.com>
         <20180706131611.h3w2kdinmjguikgo@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-06 at 15:16 +0200, Joerg Roedel wrote:
> On Thu, Jun 21, 2018 at 07:08:20PM +0100, Dmitry Safonov wrote:
> > find_iova() looks to be using a bad locking practice: it locks the
> > returned iova only for the search time.  And looking in code, the
> > element can be removed from the tree and freed under rbtree lock.
> > That
> > happens during memory hot-unplug and cleanup on module
> > removal.  Here
> > I cleanup users of the function and delete it.
> 
> But this is only a problem if more than one code-path uses tries to
> handle a given iova at the same time, no?

Yes, as far as I can see, there are code-paths which may try to handle
it at the same time:
o memory notifiers for hot-unplug (intel-iommu.c)
o drivers unloading calls free_iova(), which in the result calls
  find_iova()
o I see at least one driver that frees iova during it's normal work
  too: scif_rma.c:scif_free_window_offset()

So, I decided to fix the interface while it's not widely used instead
of all callers.
Looks worth for me even as it's all corner-cases like unplugging the
memory.

Anyway, just found it while some college wrote a debug sysfs interface
for iovas and used find_iova().
So, if you think it's not worth to change - that's fine for me, but I
thought I'll nip this in the bud, preventing other people to misuse it.

-- 
Thanks,
             Dmitry
