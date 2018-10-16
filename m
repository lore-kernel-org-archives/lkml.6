Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E69C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C04B20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="L/FcNMEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C04B20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeJPHvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 03:51:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43705 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbeJPHvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 03:51:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id 80-v6so9909712pgh.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 17:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=tMQBZuAMjt1FkZfBs4UV5DijDt4DkhvMojJJ2OXPgtI=;
        b=L/FcNMEOU5xYzlq2zP+54tuWOifb9dchGTzVIE+3WhCzbjLPjnIVjA6MuFM2TfE5xw
         nqDC1sVDDXhjo9DcovreSnlmDSxYfzUPWUTCstOdyg6XNRvkceGAdhbM7sK9NigeifYc
         /P+BOykiYH6stLHqyuSAEPH+VI/7q+QsBpgi3EdrPh6KvvY8gGIQP+NeAKPhGlI/7h9O
         k9CcA0LfNtg8HExsoaKiYB4yjdBwMhUKDRZF17G1/aHcmK3Tm5vqq6TaAybn5hSiPns4
         EIqORFPCBb7eLL1PvppT44M/g+9ge/Y1deLRAz36kzywY9LKDQ4i14MTYF/cvA1RHTJJ
         F8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=tMQBZuAMjt1FkZfBs4UV5DijDt4DkhvMojJJ2OXPgtI=;
        b=T2i39nVmecbAWaZzu8npnZ5cQrkpS0rgej2X97cd3G0pqI5ScO/13SuRKZqvb0nlJ9
         xonfoNhRKeVOi2GDwav9yNIOJNZylh93lDzi8uWLsLFPYj5Dgq97A3mDjy3nw0E8IpZf
         nkzKz8sq8IVdv8rQb0E8P5j2CME2yWAHrXQdh28/O7zl5qY3RtaACATDBnfy/P8gyx5+
         ujcKSpkwEC733XhR6Dvh5KxpFozBXu9ObPbtAQOqBWjlHdtFyLE6Ta3YD4KNlL2L4GOg
         y8cxRKQqrjmw9+0BxfhSVKqfXfCz5mUcbP95CKU4a3G23m7B0ErShHaJBq6STKH7AHHO
         P1Fw==
X-Gm-Message-State: ABuFfohFLfN0XokYDNlIGoS+JVMe1fbuQuHD6t2OHIK1S+byfm71gPcE
        Q6SeJVk3EHveV+mn0mMshKtwvBtJHzM=
X-Google-Smtp-Source: ACcGV62A+CYJf4BHUbwI8z72gjvJ4gRfUglCggCNOBalkZvnLineMaxhPGxx/qem+YitjDzY01OkUw==
X-Received: by 2002:a62:2c16:: with SMTP id s22-v6mr19621680pfs.6.1539648256407;
        Mon, 15 Oct 2018 17:04:16 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id i69-v6sm11524907pfe.106.2018.10.15.17.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 17:04:15 -0700 (PDT)
Date:   Mon, 15 Oct 2018 17:04:15 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 17:04:10 PDT (-0700)
Subject:     Re: [PATCH v2 0/6] sparsemem support for RISC-V
In-Reply-To: <20181015175702.9036-1-logang@deltatee.com>
CC:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        sbates@raithlin.com, aou@eecs.berkeley.edu,
        Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>, logang@deltatee.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     logang@deltatee.com
Message-ID: <mhng-fd0541de-3ac1-4772-916d-be6b2d02e63e@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 10:56:56 PDT (-0700), logang@deltatee.com wrote:
> This patchset implements sparsemem on RISC-V. The first few patches
> move some code in existing architectures into common helpers
> so they can be used by the new RISC-V implementation. The final
> patch actually adds sparsmem support to RISC-V.
>
> This is the first small step in supporting P2P on RISC-V.

Thanks.  I see less maintainer tags for the parts that touch other ports than I 
would feel comfortable merging.  I'm going to let this sit in my inbox for 
a bit and we'll see if anything collects.

For patch sets I submit that clean up other ports I've attempted to split the 
patch into N patch sets, where:

* One part adds the generic support, which starts out as dead code.
* One part per arch uses the generic support.

This is a bit of a headache, but it at least allows us to get the RISC-V 
version that uses the generic support in quickly while waiting on acks from the 
other arch maintainers.

Like I said, I'll wait a bit and hope people ack.

Thanks!
