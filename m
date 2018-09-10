Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19088C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47E92087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8gqmusZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47E92087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbeIJUsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:48:24 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33248 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbeIJUsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:48:22 -0400
Received: by mail-qt0-f195.google.com with SMTP id r37-v6so24733819qtc.0;
        Mon, 10 Sep 2018 08:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vOxPrPTlIY/zPxGQlmLvtzge+dWB12VYdcGNhE4jXoo=;
        b=N8gqmusZx52zD3X/Q36LvSI+mzIMCqPHOFXZNUl+yT12Fv8OVoGhHBKYOLFDiXcF+U
         rclwfZEBhXSb+jIxhRxCsCWlU8/59GT9MQfRboLPSGVCYKvGqVldkrbFW9Z/qOoohX73
         EHhirVqLsvVi+MjhtI65TNENnZbuLJThE7TIsFcbCcsoM3AAF6gVF87OjpLg1/qp0Imk
         /hHz2KoOFdf8NjQScls8j5lGp6GiM/GSuDgZUHsX7o4PPzy2+CSXx+6Q4QoS4uzcl2rC
         C+CgjoS62WzpAkaToGKoxhyK+IuS1DdWaxnIXQEEn9YFSGjphZ7JkY5EiQbTE4qLMsmH
         af3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vOxPrPTlIY/zPxGQlmLvtzge+dWB12VYdcGNhE4jXoo=;
        b=DQ5WwGBMPcw4OQe6KOQxfA+Ca7Frx94AUhwDUEut/iehngrAAS7wRw+NYwDpyy66dt
         Lzi4dhBwo7wMjI0/WI9cIuwSobeIeoCKZwJqHYVQ4ntgSYJhhnQSchnIt6ka/EcJ05xi
         3ejUZ4KIS7xOpGAxJDLylFUgltIMWWTH59H9dxZauMipRlGKfwkwuN1Ob3if/54xQ0V/
         QPCvGTHhWJBUS3C5Tg2BUCfWYNmje5R4PwOvF5z/V5qw3StCmrleYYkw+Sk9pJKKtV22
         La85MKtk71dFRFE3yXhRvFcQNSup4T7yF2RBzJKKR1AqaYaSzsmOt7VzSgLhg0WinKpR
         QxFw==
X-Gm-Message-State: APzg51A9xkSy6IsmZyAiYXoh5XVsb8J3+ccDj6ZX7p0jFlhWheTygVU2
        GmQz9o1CszaOLSY/CL/LAE+ImLr7PGjFcMmDEww=
X-Google-Smtp-Source: ANB0VdZxHIaqDs++S3Qw5fx9EMll6uuPtOtUS/Swg6oT6W1onChG1Qmboh+DftClQ7jVxLZxbALPr1V4uGvV6urnZz4=
X-Received: by 2002:ac8:3110:: with SMTP id g16-v6mr16888461qtb.312.1536594819090;
 Mon, 10 Sep 2018 08:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <1536589188-27550-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
 <1536589188-27550-2-git-send-email-yanhaishuang@cmss.chinamobile.com>
In-Reply-To: <1536589188-27550-2-git-send-email-yanhaishuang@cmss.chinamobile.com>
From:   William Tu <u9012063@gmail.com>
Date:   Mon, 10 Sep 2018 08:52:56 -0700
Message-ID: <CALDO+SYAvwZk=VAv+mqfdtT2dDJR1RQeUwJmO-QAfQV-KPjYrg@mail.gmail.com>
Subject: Re: [PATCH 2/2] erspan: fix error handling for erspan tunnel
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
> When processing icmp unreachable message for erspan tunnel, tunnel id
> should be erspan_net_id instead of ipgre_net_id.
>
> Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
> Cc: William Tu <u9012063@gmail.com>
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
> ---

Thanks for the fix.
Acked-by: William Tu <u9012063@gmail.com>
