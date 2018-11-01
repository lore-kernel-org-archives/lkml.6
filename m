Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3A4C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82D82081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siZpDaWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82D82081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbeKAXqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:46:24 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45090 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeKAXqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:46:24 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9-v6so21290203qtj.12;
        Thu, 01 Nov 2018 07:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tfdzyVc2dvWvT4n/qpMEEt+E0mRmUmqg0MbxEnbWuGY=;
        b=siZpDaWwcnzlnpZ7Mi+9PRLG/8noeYjczwWHZmH8aOhw60SmileiRHoV/9HjFMvpDt
         /WFEK1VKCrC0dw9HR47J+7IUFB+uJBThQE5GQx3Bb69BUU+sNo6J/Z1F2UmuZydG03K1
         bWNuc79MA9oJ0tl7Oocpq/x3swzUNZ7E+S23LbkPzZ7bcKMbqm5HNJFWsSTOe5+PO29H
         UoKWywscoiI1QXE82PAtknVRjK5a/LQP9qAavdCp3psyAPbUt+zwvW300aaJ6snF631z
         riYJgwSiPkUqwiAMbt8tvla9reH1wnFzs9n5bTkOzribK4LMxtJrIlwkvh3tg7mTAAE3
         r4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tfdzyVc2dvWvT4n/qpMEEt+E0mRmUmqg0MbxEnbWuGY=;
        b=alswjpV58V8PRlgN6qAsZoLirYtKJcXNND+gaA43a1ZC0kYoPjn0WvgY+GYQ6UF5j+
         DUl18hEQzLOouxjn2MMKt2p+A/okBDKxPp/FDGNMDnBfSprQu27SBVWlb6LTg1bGF5XC
         YcpXswsz7+C6/czoxLEVCHvRk5mktLu7XjAc6T0bd+VhOftfh2KpYi2iUOMlD10k7r7M
         B0Z5LFDDMHZuPVEitJshl5JAM+F3j1oGKR0yalAvaGJCLImUfb+al04rPgwyeQ1Ykr3O
         dMRToXGXkAnOSueLyUse9AZ8Xa4LrQI3LkT/0KXIkDYGgvzGNpblnEfPkkxF0KB1XEs4
         6R/g==
X-Gm-Message-State: AGRZ1gK2SqjkMUfP8oNyQbMmx5FmbWcRnWa4elbGmyxUiNlwEN36uHer
        KpBLWf68gbgDeyBpo9c0/zg=
X-Google-Smtp-Source: AJdET5cNRcrzQvYhKBre6Yd6MySbFyaFRTWYN+1g3/dTr/KmN46dzEULKeuoLNv/SDtTOKg16iSCkw==
X-Received: by 2002:ac8:2579:: with SMTP id 54-v6mr6646752qtn.88.1541083387382;
        Thu, 01 Nov 2018 07:43:07 -0700 (PDT)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d8-v6sm2893938qtd.34.2018.11.01.07.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 07:43:07 -0700 (PDT)
Date:   Thu, 1 Nov 2018 11:43:02 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        giuliano.belinassi@usp.br
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 1/3] staging: iio: ad7780: fix offset read value
Message-ID: <2191be4d531651db39682178ec0660eeb5697439.1541082656.git.renatogeh@gmail.com>
References: <cover.1541082656.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1541082656.git.renatogeh@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable val subtracted an uninitialized value on IIO_CHAN_INFO_OFFSET.
This was fixed by assigning the correct value instead.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 drivers/staging/iio/adc/ad7780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index b67412db0318..91e016d534ed 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -96,7 +96,7 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 		*val2 = chan->scan_type.realbits - 1;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_OFFSET:
-		*val -= (1 << (chan->scan_type.realbits - 1));
+		*val = -(1 << (chan->scan_type.realbits - 1));
 		return IIO_VAL_INT;
 	}
 
-- 
2.19.1

