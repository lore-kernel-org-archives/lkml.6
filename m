Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E7CC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC07520651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stcnd2w4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC07520651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbeJWE7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:59:44 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40016 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJWE7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 00:59:43 -0400
Received: by mail-qk1-f193.google.com with SMTP id x11-v6so9011906qkl.7;
        Mon, 22 Oct 2018 13:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qbDsNgB6glJd+kthiGz/4cYxN9r2W50JYnnQIt0J3wU=;
        b=stcnd2w4K/+BQghbgYXrh/ine8Xl/fs6JEGe2Kr2RgJD3ztWAeGOOT3vEAH1/CvcME
         tacoVXTAtPQ40zJxPlFjMfbNe1gD+iI3vTm/jaW2ujSOVdqVOlf/awKyuAISJI/i7snf
         WVgrTrarIEGyc2Cqkb1zI4DvjwdFOBo0+CVhbYyVNdBTwwiO7lLxtMAp6fKd+NxiXj8A
         xNJPz0VJwr64yHk7nyBvETETk1lWIGtp/YwLAI7KGj+NwgSAO1zNLyEA950C8CFsQZ2s
         tNbSqelr3+0rfV/VXJkrn1GzYT+UFGzc190EsNtCYETIyaoyhT5k4IYPPfXngKh7uiwB
         TPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qbDsNgB6glJd+kthiGz/4cYxN9r2W50JYnnQIt0J3wU=;
        b=Y9pI86RZ6Cs4wdRKybLZnZot5hpai1H0GTzJrKjNAbr4aVd0TLs9UFNOtKVfhs9c+9
         5GALQaDJgcI1MYvaejj91JkSVVhZ0Kq58I/k9n+ge3nXhPms2vXdNkadPyD9PSOamHI5
         gv7vnkIjSizBUM0njMGY6NlUrdlOQMH7Ncm4JNyWzsmx7j/u35wUN0cO08LQQrYtpc6l
         NT+zQq3/LEk3DglgGL92xAZCaZMNdx1xzs/dgtoY6J9WfMjcSyrg1n/QAIQdRTOnUa1p
         I2L8f2cOj5kzRUXe1cc13R37mi7iy7EoeBy1caYmlzUqnJAGYiFr9O9DwzondnOl4BK2
         H7wA==
X-Gm-Message-State: ABuFfogpMYZAm27WJ+MK+MFN/HTI9DHeBOBOz+/H1rNjKxgbAdmh2QYm
        hn/vRYh97RjWvZtGUthm+qM=
X-Google-Smtp-Source: ACcGV61sys11EYSSjzK+nMRF2ku3dE1GmOtQBGR01mUlqQxTRQIFoMJCzGCpGyJt+7z2TRifIV+zOQ==
X-Received: by 2002:a37:5288:: with SMTP id g130-v6mr46004357qkb.124.1540240779603;
        Mon, 22 Oct 2018 13:39:39 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id n190-v6sm21463469qkb.29.2018.10.22.13.39.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 13:39:38 -0700 (PDT)
Date:   Mon, 22 Oct 2018 17:39:34 -0300
From:   Victor Colombo <victorcolombo@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 0/2] staging: iio: ad5933: Remove unnecessary spaces
Message-ID: <20181022203934.6t525whwpp7rv47k@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warnings:

WARNING: Blank lines aren't necessary before a close brace '}'
WARNING: No space is necessary after a cast

Victor Colombo (2):
  staging: iio: ad5933: Remove unnecessary space on casting
  staging: iio: ad5933: Remove unnecessary blank line

 drivers/staging/iio/impedance-analyzer/ad5933.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.19.1

