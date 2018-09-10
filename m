Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D70EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1068520833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVnF82b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1068520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbeIJUs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:48:58 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:39952 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeIJUs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:48:58 -0400
Received: by mail-qt0-f176.google.com with SMTP id h4-v6so24718138qtj.7;
        Mon, 10 Sep 2018 08:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZakQeuBzupj7UAlHM/DcMfOMZy+D+ZvqSxrS04edCrs=;
        b=mVnF82b4ZY9aWewJljoNGhnqWWv82H1vvdYo+QOc77PwTVrBgGdXVYlWj5wvBDgkGZ
         U2uLJbhsUypuEcEG5KJt2dL+d2Lh8nfjYYWtFSLsUcw+niNDhF01Kl1ipHAzfVLM9ZwA
         SsenYaHhdCTuRn8GmQL7eEhFDaY41gWd28JQ85m98dGtQ2KY8+o5nu3iJcQV6ZUqJr1h
         ek8owwR1qNQLD7f4oQNfdTJ/5tsvL4HfAkBPDXV28WagTAr4coaeGt9HZCqbGTPHqwdc
         Mytf30Qx2gKgNjTaXqdaZfpfk6rgqi6L5DkobELyOmxsdKJnuPhGI0WOparieY0uSdTa
         oBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZakQeuBzupj7UAlHM/DcMfOMZy+D+ZvqSxrS04edCrs=;
        b=QTQOWO2SaY7LxjHIG7sygqx8mXE4Yf7ej4Efqq1pGdW8qV8GbaWJWw93FVa/IoJS9X
         506ABNMZJN7mTwL/FjOvy6g3ZHO+Me+MsWwlKu6yLPdbTJALA6MV/KYF8dE6DzFNRn8Y
         Xd9f6YtS3pk0FflTmMoCJU0qpbWrLgi1v3TfsXV5kVe4RXNi+avJhSsyx5Qr60bPBcUp
         G+SkFi7eX1Rhj1PAzDogqcNhmJyE/nF7mYE+ZDZBjFi31OxUwMSQm9V32ZlSqS2Kk5KY
         2u3WCZdI7ptVAL6kZAyRq87QCbvvyqQO5Qmlg+o7bgwMvhZ4brrNgDRl6yN/yk5DMusG
         Jw9g==
X-Gm-Message-State: APzg51CoZ2OKTTxBQ65YOX88dweR0gQExM5MoU3LL15t0lWxvFuzIWmj
        tJFvmYlPVfc8EoBFiZxO9EA5wwMpFJWq3GxD45g=
X-Google-Smtp-Source: ANB0VdYJInBlCAmANoWFXxFNgfxzG30CJfZHltjlNk1ABzSHTsSONoEeIBLu4YhBGjTy65KWYVd3KjWGDCAeGI8sRLo=
X-Received: by 2002:a0c:b0c7:: with SMTP id p7-v6mr15037114qvc.210.1536594854164;
 Mon, 10 Sep 2018 08:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <1536589188-27550-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
In-Reply-To: <1536589188-27550-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
From:   William Tu <u9012063@gmail.com>
Date:   Mon, 10 Sep 2018 08:53:31 -0700
Message-ID: <CALDO+SZXcfRcW85+vTfZvXP-bRsJrJhaShVLhULKhMASzRfSwQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] erspan: return PACKET_REJECT when the appropriate
 tunnel is not found
To:     Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 7:20 AM Haishuang Yan
<yanhaishuang@cmss.chinamobile.com> wrote:
>
> If erspan tunnel hasn't been established, we'd better send icmp port
> unreachable message after receive erspan packets.
>
> Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
> Cc: William Tu <u9012063@gmail.com>
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
> ---

LGTM.
Acked-by: William Tu <u9012063@gmail.com>
