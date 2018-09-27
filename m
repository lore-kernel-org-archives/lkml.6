Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627D1C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230EE2172A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230EE2172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbeI1F3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:29:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33777 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeI1F3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:29:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so2944715pfn.0;
        Thu, 27 Sep 2018 16:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cxmQn1GVXysO8fPNDcHZ6uxAsuchFdxvy6uUiAUqhtg=;
        b=NiSg7Ji1kIgRNkgV5iz1vAejT7EM1gR0UiVoQ2ruFyUy1e2Bfm9DWoXU0KT+MkgAJT
         S69eqWML7xIQzNcyHLWFr4Nv1Bd6O8iIJuiLadJBEWeasy6HOeV9knmdtNoctpNrHqAs
         pke9UYP9/yFWSnAMWkb9HqJ8oLLr1wbntbfoAGjAmEJ7r1VqsHpCxJ5WzaWOMEx9UweD
         thr5ODfh4MGAdlGDjgRnyMDar44PWtfQiW+Lfrf69bimmO0GMbxQ/7dFRiMSqZa2NswC
         2gQ+yX7OHwyrstcgPtbGTIhm4j6XTYe1ga2RUj3RgSdru2HXrYxBu7BXqILimYW+CGW6
         gnZw==
X-Gm-Message-State: ABuFfojN3+c5fPXQ/GIgWc+PQUFX23ni6bfH0CztwQvYuDl5D8KZwctK
        fTZyMzsk2sgd0CCV3HCb81A=
X-Google-Smtp-Source: ACcGV60nC/9bW6/ABYqSmg9tJ27dXqqziDGJT7Vfce41RdgeYJeMFtZrNTx+1AR0rtk2gOPNk6Chew==
X-Received: by 2002:a63:29c6:: with SMTP id p189-v6mr4095530pgp.188.1538089741608;
        Thu, 27 Sep 2018 16:09:01 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id b3-v6sm4372001pgm.74.2018.09.27.16.09.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 16:09:00 -0700 (PDT)
Message-ID: <1538089739.226558.10.camel@acm.org>
Subject: Re: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 27 Sep 2018 16:08:59 -0700
In-Reply-To: <20180927225823.GD28301@ziepe.ca>
References: <CAKwvOdkZ-0k4BhXYz0wj3wXNyy95nKFe9aYXxXveLafuviGG2w@mail.gmail.com>
         <20180925023722.GA32600@ziepe.ca> <20180927010803.GA7640@flashbox>
         <20180927044826.GC24889@ziepe.ca>
         <CAKwvOdnmg2XY6K-8jTna3EKR1Nx04gOm6ZoywUwQO_CSANR_jg@mail.gmail.com>
         <20180927202849.GA11120@flashbox>
         <CAKwvOdnMOcdKPNHwKbcsg8rJX3_hDTgY752Nb4hgMC2D4p5aRg@mail.gmail.com>
         <20180927222821.GC28301@ziepe.ca> <1538087622.226558.8.camel@acm.org>
         <CAKwvOd=qNZsfSFJUFZqBbSYt4T_T7TudohzhTqpigvDAHek78A@mail.gmail.com>
         <20180927225823.GD28301@ziepe.ca>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-09-27 at 16:58 -0600, Jason Gunthorpe wrote:
+AD4 Anyhow, the standard is hard to read in this area, but reality is
+AD4 this:
+AD4 
+AD4 +ACM-include +ADw-stdio.h+AD4
+AD4 
+AD4 enum a
+AD4 +AHs
+AD4 	A1 +AD0 1,
+AD4 	A2 +AD0 1ULL+ADwAPA-40,
+AD4 +AH0AOw
+AD4 
+AD4 int main(int argc, const char +ACo-argv+AFsAXQ)
+AD4 +AHs
+AD4 	printf(+ACIAJQ-zu+AFw-n+ACI, sizeof(enum a))+ADs
+AD4 	return 0+ADs
+AD4 +AH0
+AD4 
+AD4 +ACQ gcc -Wall -std+AD0-c11 test.c +ACYAJg ./a.out
+AD4 8
+AD4 
+AD4 I forget if this a common compiler extension, unclear standard, or was
+AD4 formally revised in C11 or what, but it is the real world the Linux
+AD4 kernel lives in.
+AD4 
+AD4 It is even more confusing if you wonder what types A1 and A2 are+ACE

What's unfortunate is that gcc and sparse have different opinions about how
to compile the above code. Even if gcc supports enumeration constants that
exceed what fits in an int, sparse does not AFAIK.

Bart.

