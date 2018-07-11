Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E938C38A24
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F246520C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="CwmUnUF6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i6GJDPoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F246520C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbeGKUqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:46:25 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:39107 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388065AbeGKUqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:46:24 -0400
Received: by mail-yw0-f193.google.com with SMTP id r184-v6so4292803ywg.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZWoXq84yc8740yqKuwyM4w8PxMWYeQjSfFe+f8Ci3XY=;
        b=CwmUnUF64zcSw7oWQpP1hgA+fHBcLsFEg4YGXcIMKVRIhPpg8ThelIxaRn3lgfeiC5
         +xsle5RiBU+pTYphECU/pBBDLL/CDahMjgUEAnzR1dkSNZZbT5B9bkcDbS77uMgPMUAI
         K1G0YPE/+imhrYm2Fgt8dcyTjNJLIDln85VJ1AwLcEE3v1nUCTWoqTWVOTCyJJ4ci2Ap
         eVeBDoSvBTBv2/5na/x1jiGtLlW0LEjnZoDNyPJolbHFP7gSnMvcJ0BnMwJBYopwYm9v
         rXq001xGCLrTHkavn3VsMSl7K+GJbBh+eQCBKAFAHEibmiC9a2ysg6cFQtkHD8cqroGD
         j9ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZWoXq84yc8740yqKuwyM4w8PxMWYeQjSfFe+f8Ci3XY=;
        b=i6GJDPoDCNI/MFon+KRh20wpgxJNApXanbnfL+u3nCJLg+1vYSRnUd6kEgbq8xMvvt
         I5G1K9xR9IUbEG5iH8BUC8bSAFz8Bjyg/tb7F/E4ffXWKxFosSg2Fn5g21uC+r8EnCLM
         1Ogf9aky3LbFU5Pr8txOBL1+EQ7AOlsbEsvbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZWoXq84yc8740yqKuwyM4w8PxMWYeQjSfFe+f8Ci3XY=;
        b=Pqg+Xu8ohr+pcvrgEC524ixHQibmqv5WtvDFMw5eo9A7at3C8auoLv0wlB/H/91lyn
         N6TwxlQcAKGZ3tk/q18BVJ9oJx+3/xtLy6aREPwfQqIrtassXw+7fU9GUTQZJsaJbjSA
         JX0KuIdzy1alMLO38zC4XW5foHCVZbzPFkIsraHrhcDrmi+klbcf4iT4YgzKh3yALfjw
         O3tdiPrm8iiREZx8lI/YriBW5xTHeWmNfaR/t1iNxuV5PXPn+csghj4x9wCCUACeqVS9
         zmx73i7vWPHwTuqaB1e6pUePhlg4F+suubtSQl3U1xGedIYJdQ6SCWqQm/7ifemiegRr
         yIag==
X-Gm-Message-State: AOUpUlEMaNkBZyEEZZXfBpZnG2RZYPVJZdmof9/ovWv7ZBCR3kQTNof+
        PBYnSZjUDQJlSpsZbe1DIBbYg1Mv1VOqyc6xM7PMTQ==
X-Google-Smtp-Source: AAOMgpe4YkuRFNSVjlZ0uKbFPB7sWbUH7rX+dhzIvhY8is12SCKo8ww35jB/uK9yliXvZuGJ+1L96Zw+qimdqpkvDDM=
X-Received: by 2002:a81:3b04:: with SMTP id i4-v6mr99601ywa.38.1531341619307;
 Wed, 11 Jul 2018 13:40:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 13:40:18
 -0700 (PDT)
In-Reply-To: <79334C7E-6E76-4B5C-9A32-C6DA40D8E88E@linaro.org>
References: <20180627035642.8561-1-nicolas.pitre@linaro.org>
 <20180627035642.8561-2-nicolas.pitre@linaro.org> <CAGXu5j+KLvJ-n_QRrfq15E8iO_rqfpp+K7PDAZHZMHcemy9y7g@mail.gmail.com>
 <79334C7E-6E76-4B5C-9A32-C6DA40D8E88E@linaro.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 11 Jul 2018 13:40:18 -0700
X-Google-Sender-Auth: Rhc3jKHvSyD34SSpLSiIiyjYJF8
Message-ID: <CAGXu5jKfHOmDHAO726KTNP4CY_Q=g7HN3zy2hqUA5ZBZMu=Vhg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] vt: preserve unicode values corresponding to
 screen characters
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-console@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 8:39 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> I am on vacation away from an actual keyboard until next week. Will look at it then.

Awesome; thanks!

-Kees

-- 
Kees Cook
Pixel Security
