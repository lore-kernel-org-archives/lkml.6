Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7089C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 10:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBFC2064A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 10:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJB2shC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBFC2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeI2RQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 13:16:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45214 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbeI2RQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 13:16:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id h6-v6so8762987eds.12;
        Sat, 29 Sep 2018 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rdMkzZRZyIxeYBm9YL18cJajyC96vIB64xYloC1jxso=;
        b=dJB2shC1oLsEXc0myzppMYva6r+Sjc9CNTBFEocc2Dn5CJNkcilRz8UrxSITaWqfmT
         KCx/XHYkJdYaAA/uhHhVJeN25lInLMmr0M2MK2jY+LVmM+VHUSy/6GJsxYAwwzg9l3zK
         qpFvgEab67vUWBV8WXUPMOomDZdchOBKN/2Bo41R1Nm9RoPTkUk+cKb3mzjhvQQIj2R9
         mg94HtqVTvajd8d4U6l/scToeqOcN4RyCajV0Lb9w6N9Fj+w/eh9K2+rWFFu5qtO/ZlO
         xJAjixJsaCHF3H8nadrhm3dlCCvHtTGevpJFotr90Fp5+hxYyAz5mZKRjdO7xTNDqokl
         5yLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rdMkzZRZyIxeYBm9YL18cJajyC96vIB64xYloC1jxso=;
        b=PZ5tLW9G6bICpK7/2Wwug6lek+pepRRKCWNZ0Zs9DXt/3w8IkXGz9LSh5e1Lddhx68
         nSuwM723jcvCjxobnlByCBGp3gyvOOE5ewG2htlR7Fn6HmCPJ35L8LAoVEU9tT+l/K3K
         qilKtbp64KCWcZNf45gzJUHohr0dUqpHnLUMqT+aI9tcMIRDrao9u7WvySKZGt2SplZD
         GFPQ3d1tkGP8VGPE26+FXOa07HlQUSik7UzqRw7dBS+Qz33Nl22mBszsNTuMIB2tYhxi
         kSgQkhie4ixOdvqoOVNL1CHDkS1G/4+p33G3YmBIye0prRz5g6SLeCNmRt56xY6dbqH8
         yILg==
X-Gm-Message-State: ABuFfogwgktFK7iGcx7gddHHtJhmqKFvkYI6vUjpQ0bFotilAlNtYePS
        EZu/cUJdTta4hDxpNm6aHQU=
X-Google-Smtp-Source: ACcGV60I/+VuQqYkAW1Mn3VjRED5pR/OfGn6yQBHLrgpIIuFBLzrTvpmsylO3iSCVpbG9NVHbk3rqQ==
X-Received: by 2002:a50:aa22:: with SMTP id o31-v6mr438045edc.23.1538218081867;
        Sat, 29 Sep 2018 03:48:01 -0700 (PDT)
Received: from jdlaptop.local.jdieter.net ([80.233.39.62])
        by smtp.googlemail.com with ESMTPSA id d14-v6sm1120174ejb.35.2018.09.29.03.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 03:48:00 -0700 (PDT)
Message-ID: <6bfc36e2f038506e26b28f29406f112057af22e1.camel@gmail.com>
Subject: Re: [PATCH] usbip: fix vhci_hcd controller counting
From:   Jonathan Dieter <jdieter@gmail.com>
To:     Maciej =?UTF-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        Maciej =?UTF-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org
Date:   Sat, 29 Sep 2018 11:47:58 +0100
In-Reply-To: <20180920202942.208509-1-zenczykowski@gmail.com>
References: <20180920202942.208509-1-zenczykowski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For whatever it's worth, I've tested this on 4.18.9 and can verify that
there are no regressions there.

Tested-by: Jonathan Dieter <jdieter@gmail.com>

