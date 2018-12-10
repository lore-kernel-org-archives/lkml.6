Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=BODY_SINGLE_WORD,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38AEC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6609920821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ0V1mhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6609920821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeLJQeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:34:19 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54681 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJQeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:34:19 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so18248725ita.4;
        Mon, 10 Dec 2018 08:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WASiI+LGr+j54QgtHqz/Mb0c0vmWaC6GIOI+FQCQgEU=;
        b=VQ0V1mhbautHilWcQttqI0IKcuAabwRncM0QM76dFZwa1OvaV3riLUpfMQ+s5AOJgJ
         X14AO6qQHveNjq3X5eD46B9UF0gG9WICsirB/2+dqFbZgp+NVgdRU2uk9hTqREbTL1ol
         J2B0EHxOfNNISSCxb41agy7v6tNLgGHHL0DoTrKOIL2jQoSBgHqxHR8khwyJnaA32s5L
         5UOUjXEq40mPFA+W6GscwWtYMC/nCpqjbsgzhXUxBkea/nDz9d+AK4LWsUbJR2DRaofP
         ZH08gQu8/SO32RFDXt+Xx5oL2Ba/ZMGI2jd56hRVP4mUxe1GoBBvnL0YYEpbw4RkWvf5
         FaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WASiI+LGr+j54QgtHqz/Mb0c0vmWaC6GIOI+FQCQgEU=;
        b=IjeWHpZkFfW7HhHH3rnUoREG3/V56PcPSK3af4mTvzhnG9icwZT3t/RnP5bqQ6eLMm
         CMBLwNO/me7MYLTa3HzD+JOzV0AcvrkGLoOfywXQqoKTDLpsjmzpXbVp/j2MvRkrBqld
         MDl0HfbrkdDeUeOzZwvmVXCGL37TjYazu6aaQkHFVbWvEiN1r6FAJKGJwIcakQFIr7OJ
         WOVPEY+CWFfGyd6fwV8Sh8mdVBEcE3AyLNbeDneyNcgRTxUxfBSxrhPMJ3MawgN3rIN+
         QulbHUhKC222YP9S/gb5IXV8NJeOGCt7SkUUPNiM3LXbEgeOF4ejWKIQzEJlLoiC4r2p
         b2hA==
X-Gm-Message-State: AA+aEWbrQR+EQzLuy4z1T0/CUG7Rn+ZHr6H5up8nr+Q1rTcMAaimmoqv
        sslQ7xOZUWgJh4A6LOOadiR7ROXS1j42vshofpXCDBdr
X-Google-Smtp-Source: AFSGD/WO7tsbiZEQTQXkksnWjSm84tgnNZLbD5uDhhskufnk60GeC9rZrLIyc9aCuG6/FjjQSS7ehrdFid6c2+vZmUI=
X-Received: by 2002:a05:660c:250:: with SMTP id t16mr11013213itk.78.1544459658962;
 Mon, 10 Dec 2018 08:34:18 -0800 (PST)
MIME-Version: 1.0
References: <20181102130209.24507-1-tiny.windzz@gmail.com>
In-Reply-To: <20181102130209.24507-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 11 Dec 2018 00:34:08 +0800
Message-ID: <CAEExFWtzPP3KiJC509s+YdZOGSS0J82idNRL7gzxaAmzOCutAQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: xhci: fix small typo
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping......
