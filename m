Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86CCC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7FA21722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PsFb9lKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7FA21722
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbeHTX0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 19:26:17 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45204 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeHTX0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 19:26:17 -0400
Received: by mail-pl0-f68.google.com with SMTP id j8-v6so7622209pll.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 13:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GLDbSdsTgGa1wCScKmKnljoWzofeP6d7YbzDhYvhXrA=;
        b=PsFb9lKbWG0SmSForrT0mD7eLqicLjP4NTAS/0gwGyFR17PjjSFPXw7M23pZ8cxsGB
         1BJAb7RN/neovZAuzW2dev8yM1C0gDXC8vluPhj4Sz4SmsHI0ZZl9fe7BRgxfyzLefmd
         u/LlZ0gwBzdHVPLPGNDQCFIKC72k460RJuizFQSWSzzEZy3zBJ+v8sZ4sAJ4qYD1/OMN
         MFscGgb2uxQTM+GYUTiz9z1bUXycmpFJy00+oc8AewA9fKf2Ip6lnd/GIFUVwAcgQvIR
         kdDnMIXu/PKFlOSjJZZmdEfeFkQ0C8wOCzILE/vuBhrpYsa0eT3H2HOkD0ZkcCX0Trfk
         eafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GLDbSdsTgGa1wCScKmKnljoWzofeP6d7YbzDhYvhXrA=;
        b=mKZaItzeus/+4VvdkPEXySDvNheK+CTOgDsrCHt3uhhU72dRANTA8cTg0ofJYjv/Bp
         Ml8pXvoYiGP7Zsy3fJvPGvzgprrfv1WmjgXuwXiIuTkbkXCop5fYZGV4HWRubT3IqZ2P
         eR+OY1qpmrOhjtlWF/4l3f433rrf6uxO1/ZdS0K5HnnPaepoiORGmaJ9hUH775BpMxWz
         O5ejq3RCQnJHUKkMHbtXrI7JjeLTgIc6Q368s20dUJMXBd1bbp+UYOrzG0eFqlrfNuuG
         kUCKqOUwnE42Me2l4elSiGQcAtP3uNa88nEuZXtv/wA6oTq2PRTyNgByEiuKD9zCH2oc
         sd1Q==
X-Gm-Message-State: AOUpUlG37Ws0sfG3LsRXG2OgUAvKHE+O/N6k0tnbQ80KYh4SyGkwd2ci
        uEWKmYVTYMANdVJQSMAth8b+2g==
X-Google-Smtp-Source: AA+uWPym0DzbygPcwpMTPWDsML44pvClsujXxN1qlv8tG3KiMziOvmvKK+8ndvswrNI4snUI4Ui8mA==
X-Received: by 2002:a17:902:9b93:: with SMTP id y19-v6mr42448158plp.113.1534795757957;
        Mon, 20 Aug 2018 13:09:17 -0700 (PDT)
Received: from wnukowski-desktop.sea.corp.google.com ([2620:0:1009:11:cdf9:e330:7b8e:1961])
        by smtp.gmail.com with ESMTPSA id r64-v6sm18757727pfk.157.2018.08.20.13.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 13:09:16 -0700 (PDT)
From:   Michal Wnukowski <wnukowski@google.com>
Subject: Re: [PATCH v2] Bugfix for handling of shadow doorbell buffer.
To:     Christoph Hellwig <hch@lst.de>
Cc:     torvalds@linux-foundation.org, axboe@fb.com, keith.busch@intel.com,
        keith.busch@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, sagi@grimberg.me,
        yigitfiliz@google.com
References: <CA+55aFxOc7_s-BbWJx-kyit-pH9m5fQJk6MSMJ57tFFvMtNh-w@mail.gmail.com>
 <20180815225157.89523-1-wnukowski@google.com> <20180817070712.GA11383@lst.de>
Message-ID: <2414346b-5ea5-834e-24a5-0d22c2c68b6a@google.com>
Date:   Mon, 20 Aug 2018 13:09:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180817070712.GA11383@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for applying and improving the comments. All still makes sense.
I will forward this patch to stable@vger.kernel.org once it get merged
into Linus’ tree.

On 08/17/2018 12:07 AM, Christoph Hellwig wrote:
> I've applied this with some major updates to the subject, changelog
> and the comment in the code.  Please double check it all still makes
> sense.
> 
