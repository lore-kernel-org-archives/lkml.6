Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E133C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4914126816
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4914126816
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932244AbeF1ELV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:11:21 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38057 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932124AbeF1ELT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:11:19 -0400
Received: by mail-qk0-f196.google.com with SMTP id y4-v6so2284912qka.5;
        Wed, 27 Jun 2018 21:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tXLK+AQqu9YDRNRM9/OkJhrWZg7IHhl7rrGI6GHf418=;
        b=f2dZBVSYLzz73LfigAb54kprsEaKLJ8e/oXIeJMB0S/0wVDm8xSzexsnHhc0eC5F2H
         00cqbQaqbPIc4yKAMPb7SHcsODp35E2zVUsIugprixPJ7wefhCPjQvnMRKMVpB3RZ/gl
         axcTGBTRmf4df5UP0CuJe0ROu7wRDuYYoOWiV5QMh6lMygWh2y5+KoJVL316pQ+4iyJv
         59yLa9EMlHL+pQmyVvtmpNcBoohlA0/k3vm7GdHxYRoofpuDGMi0KPeN1gr4UjcdgMo3
         gGk/cuBqE9N0JF0AsA7OvMt179ajObGcncVBAbA3gj9Z7JKeII0M6PQDMxeytNbH8dCS
         Kphg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tXLK+AQqu9YDRNRM9/OkJhrWZg7IHhl7rrGI6GHf418=;
        b=BVbhJhiOHoTGrWksXaP2pTA3ScHtoxIzAC0JyW/slwwrsabsFHy7PqYfuMM8x86DCy
         yeZhcteaigo4pmsl6JiQdlTcVzPaKpYxvzUss08sHySBvWES5SbD4H0CqUQUya4i7/mH
         l4hkjjhWkv5Az14hnSax4vhJsZFSF1o2A44ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tXLK+AQqu9YDRNRM9/OkJhrWZg7IHhl7rrGI6GHf418=;
        b=C1/JYie+B+ywa+NdnIT1YinK58IhU5nSOC+hX0W1Q+XaAl5FVd/h3tUHXWbDUVjOa1
         5t7+nN00nZiMfz/zghG9TpiIHHiENlYLGZi7EMtx8ZCIWy66OFQY+fIYpItorYRkZj9a
         DsnRwLRQOnBQKfuIcj2vwgG2XYT0wpqvKfS8Ntr1qj3VsfLjpJKcLcfmjVkF3N+i9PMf
         Mvf9rgkeTnG+OJbemB1SWz/PE2L+o5dbpXEeYHEajjxNs1liM2iLnw7m6ALg27hEOIY0
         km77bExbrsbzWPuNLS4h/E3qsGijT6UIdtEJWoRBQyzSZGg1RpPcH9ja05T69fUj9F1K
         HTCg==
X-Gm-Message-State: APt69E1Vc5J6f+MegwZOdH+XNalOjvzIl2c6cMGgwIbBuGEJQYIDZKlp
        sHogIX9iQCe+YL8GY+iNYd0X+vIx9pkMTZ08hn0=
X-Google-Smtp-Source: AAOMgpeE5n9gS9ANjD/2HQtmP8Aql0qJXuf7Zg+obgvZoFIfyrJwUhDmgoOoJ8VmHmQHgz8x2peffpa8uJuQD9CZ5yE=
X-Received: by 2002:a37:6a04:: with SMTP id f4-v6mr7342365qkc.112.1530159078916;
 Wed, 27 Jun 2018 21:11:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:169d:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 21:10:58
 -0700 (PDT)
In-Reply-To: <20180626232321.12372-5-benh@kernel.crashing.org>
References: <20180626232321.12372-1-benh@kernel.crashing.org> <20180626232321.12372-5-benh@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 28 Jun 2018 13:40:58 +0930
X-Google-Sender-Auth: YCHrBQZmt6ThTx1vDR_jWBUUVhA
Message-ID: <CACPK8XfedsD-PYE-7LBrgsJn1a8J0ogN8m+neBuRC1ecXtj6Yw@mail.gmail.com>
Subject: Re: [PATCH 04/14] fsi: master-gpio: Rename and adjust send delay
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

On 27 June 2018 at 08:53, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> What the driver called "FSI_GPIO_PRIME_SLAVE_CLOCKS" is what
> the FSI spec calls tSendDelay and should be 16 clocks by
> default.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
