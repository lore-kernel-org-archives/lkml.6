Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED40DC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD46626838
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD46626838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933041AbeF1EMG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:12:06 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:34218 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932124AbeF1EME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:12:04 -0400
Received: by mail-qt0-f182.google.com with SMTP id d23-v6so3636558qtp.1;
        Wed, 27 Jun 2018 21:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ySM3sy1aI/8htuK6R6KLVEKvwLzW4CHXfLlasZ79954=;
        b=ogJhnZ0Zho/X+6a6HN036pqO6n4EcoaoxBsursA+7F19ZR8KZ9MMCRXkKLv6rCjwC8
         TYD9j324MkhEdAcvv55EbykBsxflF74k+ifBgc9CAz5wVi8wKH5hqSGtwwCkhrIjmPba
         s0M/UKoj33IVr5HDN4wgL7vPfv+Ijwn1mqNIlIW2ZkswtCIlXI5AMAJVv4MYb1kh+dpJ
         Sgmi99oAxIhL/WmpjaTsN6N7sy04MV9NXb5FWPygBNj7qz5y5jLQmX1fyr5HFF3alXsR
         7HyWgInOdiGJeZaBXYFkWy0qcj4JeTHAQXb7WeJY30vBnTy5E1gJ8TDyvVZJZXojnpV6
         Vong==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ySM3sy1aI/8htuK6R6KLVEKvwLzW4CHXfLlasZ79954=;
        b=a5aWoOeTRGUxRG+JVx8UlsCzqDkCZc7vZFolYu/yhGyeS1WGATs0VcTp7H7dEISpNN
         e3PYj3MESo0dNTwow9N9TscyqvkPjNrBfwoC1PwXLoa6ISBgFkAx0STxa7P1SeYdqAdy
         8Ny1SssoIjIlxd8OSigaV1OJg15SDSdtm4wpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ySM3sy1aI/8htuK6R6KLVEKvwLzW4CHXfLlasZ79954=;
        b=YsM98u3smIRDvpPsIPc853bQYTzvFlmLQUwVhCxHHIxAaxBnhx+X2dMeN6ErbvVjMd
         tpex6Ut8/BPgD51ZHjNopfxvSHR589wx0KS3T2jXIOjKSxpRJ5Q9hejlCny3NKskkWmB
         o00wVT6Cu4PCVBcA6+zcXm2zxZvr/NsQSda5gPMrctKtt2bkn90S1Gif0/33ArlfbrzI
         5fIb63iy4ePhpNHrZJWI85yzQQ/8Dlb2w+nfaaBv+CZJ6+Qe9zTyNCctF+h5dyKu1+Xq
         heIbepemztDWYkPhQjZKs2Opb+Wt6Ds5DMZ33pslgqqaW8MZ5qv/CbPdVb4v6qCrMUW0
         Bhqw==
X-Gm-Message-State: APt69E0Gx2MGRaIKFyKJD0ufOMGXi3ZSwu2yZVKbFlPOmD5JV6EGCN3J
        inbCq9kY2NzDOcjzM6bAUpU+Dp/DrDMqn4iimmA=
X-Google-Smtp-Source: AAOMgpdddze5k2MCIvKUBhYBVYE2DnvBUrl/n/ztaVsWElhRORbWjO5DEh4UknRCQwF7FLGPDIZ4+HRQpaJlSOcTGWI=
X-Received: by 2002:a0c:8283:: with SMTP id i3-v6mr7836142qva.21.1530159123444;
 Wed, 27 Jun 2018 21:12:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:169d:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 21:11:42
 -0700 (PDT)
In-Reply-To: <20180626232605.13420-8-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org> <20180626232605.13420-8-benh@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 28 Jun 2018 13:41:42 +0930
X-Google-Sender-Auth: QDqTOnHlUwfzoNmMcIAzaLS6ROo
Message-ID: <CACPK8XepxUALx5Wsiyvyk00N98Ew=UcwRe174DZojgD46mkypg@mail.gmail.com>
Subject: Re: [PATCH 07/14] fsi: master-gpio: Remove unused definitions
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-aspeed@lists.ozlabs.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2018 at 08:55, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
