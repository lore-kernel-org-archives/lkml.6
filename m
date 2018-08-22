Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75389C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD0D20BF2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GVXHK++8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD0D20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeHVUmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 16:42:31 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41435 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbeHVUmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 16:42:31 -0400
Received: by mail-pl0-f67.google.com with SMTP id p4-v6so1142833pll.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=IIMRiRNGcYzGJ0z2cvH801dtNiQaUXGpNk/Zy5WsLfE=;
        b=GVXHK++8FWACBTT3xakiZ9OHEu2KNzDJ8JWy0VdmCMNKFenXPYd9GKirZBEZGl+1np
         A0GLC4LKe3ZBcysDPYvtThQHtLdZOKcGD2UKbVh2763XSNbVl1HRuvJ2HMVLA4l377fA
         ZCvDjRp9ZJ1tKNOjJMS0PsMYDLGqoKRzHlybNqyZ2od8MTYLKRkF7j8ZDRGaaUjUPDP9
         XPZ9W0qrF19CE8u21cO2gx4Gx244BQXXGZG/phiWxn52t01lUZTr2ut8cH0aNmNaGcK/
         /HNZj12c2cDuLH2GspxbykVyvIKvr6jxKlgVDWqGGO6iB3B+hOE5mQb1x/uaSj/zAcZr
         St6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=IIMRiRNGcYzGJ0z2cvH801dtNiQaUXGpNk/Zy5WsLfE=;
        b=PtJIvCCmZT6fQ9Q1VvbGCRwBP5upGBbBQYpW+vsZNcRj6/ez1Z/PKv4oJ6ADJWQOZT
         fKIbpcL9/4jRAwJkin06YMRfBolloNjx0R4fPH9L+TsMDLMZs5UhCCSFc0ORRmSZaIb1
         qOdHDm3vHYBwamxeUSXJhpAXSmQ2maTZuO/ZbjlXXT+zjW5hD/0Rey5vAdUY4q+mqCWQ
         YXUeKtyAcPuMvxi9BMikVjuE+JwlYsKdE0phaxp1CvRDTutc9DP9xH98cswUm7N4/lNy
         iy+A222mEIgvvR9YKU05Bok6UCV+jSr0XFAWFMVnSfKdmHLS6eC/7q1AFwxhavplCHs+
         pxBg==
X-Gm-Message-State: AOUpUlEjXhnwlpKD1kfz5dkf8ojXjL5xUcP5k4YmeFzkt5OiG76QhRDy
        EZfdA6KbBVbCF8aC6OHyTv4ybA==
X-Google-Smtp-Source: AA+uWPwhgx1WAXlgvufmDAXcmpPO/MeVkt10W0TeUsmJFlw40u1CfvaSNuhx8kZkEf1OK15VTI9e/A==
X-Received: by 2002:a17:902:b193:: with SMTP id s19-v6mr19267834plr.217.1534958207179;
        Wed, 22 Aug 2018 10:16:47 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id n4-v6sm2798036pgp.80.2018.08.22.10.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 10:16:46 -0700 (PDT)
Date:   Wed, 22 Aug 2018 10:16:46 -0700 (PDT)
X-Google-Original-Date: Wed, 22 Aug 2018 10:09:59 PDT (-0700)
Subject:     Re: [RFC PATCH 3/5] RISC-V: Add cpu_operatios structure
In-Reply-To: <20180822060353.GA27106@infradead.org>
CC:     anup@brainfault.org, Christoph Hellwig <hch@infradead.org>,
        mark.rutland@arm.com, Damien.LeMoal@wdc.com,
        linux-kernel@vger.kernel.org, atish.patra@wdc.com,
        linux-riscv@lists.infradead.org, tglx@linutronix.de
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-fdb283aa-89d9-4de9-95f7-7886ed854df1@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 23:03:53 PDT (-0700), Christoph Hellwig wrote:
> On Tue, Aug 21, 2018 at 10:34:38PM +0530, Anup Patel wrote:
>> The cpu_operations is certainly required because SOC vendors will add
>> vendor-specific mechanism to selectively bringing-up CPUs/HARTs instead
>> of all CPUs entering Linux kernel simultaneously. In fact, we might also end-up
>> having CPU ON/OFF operations in SBI.
>
> Your forgot an essential part in your analysis:  Right now we only have
> one single way to deal with cpu on/offlining, and that is the dummy WFI
> kind.  Once other ways show up we can build proper infrastructure, but
> until then this is just a white elephant as we have no idea how these
> abstractions will look like.
>
> And my hope is that we'll just see new SBI calls, in which case we'll
> just need SBI and dummy version and can avoid all the indirect calls.

Yes, the goal here is to define one good interface via the SBI.  We've got a 
session at Plumbers this year and one of the blocks is to sit down and talk 
about this API, hopefully we can make some headway while there.
