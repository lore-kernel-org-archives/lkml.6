Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A439C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9391205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="ndMWNJb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfAQCqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 21:46:53 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:32918 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfAQCqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 21:46:53 -0500
Received: by mail-qk1-f196.google.com with SMTP id d15so5201137qkj.0;
        Wed, 16 Jan 2019 18:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B4j/WuweH0wMxL+RODpScBf2L4ITsa+/ZzunIai8Y/4=;
        b=ndMWNJb7QvWxiFN6aMSNgjChjftJHxNGb2N5am20Zt7XOu4JU3cOpXldQSBFcxRaft
         3kDybIQBtpZONmus/afJeaEQI9SzC8nZ92FcyabaKSlvn4mPt411lr9giwyRi+2ep/EF
         WnCM2PZqx/MobKE62RRhgqsT9EsPsNS9PQvG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B4j/WuweH0wMxL+RODpScBf2L4ITsa+/ZzunIai8Y/4=;
        b=j1abaY9L6XZ4qH/+x0UnyIkYjAHA9jKSub+v577yvZHpmwxMQoI1FP25SflMJ0MhB6
         EeC3aa7RSJ5AuFq+anRJNS9W2zJS1fDM0C9c2G09fcQC5VG6FrUMWkLeJUcjNwNvD2H/
         3yb/CdkL0vZuj34qigKLdaqoZS67m/T1ISA52lL1xvZlp0XrPT2tSYEHNoBpgNPqk+Xv
         rqdd2D91bHPiM0bWbIIqbJg2jogRyTV4dC38DMuBKoDN1d7rPiOTrx55+clyaFV7ROQd
         7Q4yLLUzOpspuAzg9zL/sAaWceyawMcD15PVVZIcklCgytjp4AokyUJd0mE7U67NEl5F
         TXiA==
X-Gm-Message-State: AJcUukctl/l8TuFDRIY9pqaNq8/WQ7fariWrF51O/w2uA48GfsqKoX3G
        N5hVg4SFqR3+sQxh8qMrDodQjNs8VyXhJOebMLI=
X-Google-Smtp-Source: ALg8bN4g6CHYobJ+o57LHwHQTioIoweDmYs1sEQbf7J1qINqKMWVyLA9iuNyxJeLx02SEqS/s3dBOJQ5a+0tigglcWI=
X-Received: by 2002:a37:781:: with SMTP id 123mr9208486qkh.231.1547693212458;
 Wed, 16 Jan 2019 18:46:52 -0800 (PST)
MIME-Version: 1.0
References: <20181217200405.2904551-1-vijaykhemka@fb.com>
In-Reply-To: <20181217200405.2904551-1-vijaykhemka@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 17 Jan 2019 13:46:39 +1100
Message-ID: <CACPK8XcbXso=13nRC3xM62RnWfEKnFcZpaBA4OAB7mad4mdGGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: aspeed: Add sensors devices for Facebook
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 at 07:04, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Added ADC and other sensor devices in Facebook Tiogapass device tree.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Applied to the aspeed tree for 5.1.

Cheers,

Joel
