Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B9BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 23:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C1620841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 23:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTgZR/68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C1620841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbeHAAv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 20:51:56 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:46212 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732720AbeHAAvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 20:51:55 -0400
Received: by mail-pf1-f171.google.com with SMTP id u24-v6so6811885pfn.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 16:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6VzOzblINlAwOt9Z3Tc0L0XEgO1pcUZqBpt6BgFfo/A=;
        b=YTgZR/68I0zouGJYpSC/shI4ShROXVy7T/S6KvZC1lF3R9LLzhfL5WFy5VZ7JApHZH
         uZyQnbZPTOqbxKgYsCp8LXiBP2evfS4CgaiL84twL6rD7zATWQ91D6tQAoVriy9yThZp
         5PrX0mnOZfSGNzmE64YZ8D85AF1DrQYHU+fcMwy63ggd2neiRqZ90jWsEvgNyJIwm1z6
         mV7fgy7NgOgHbz/1czOktjcQdRx4cBXs7SxpmgPzyg1AJcLhZMAaC+LNB5YYe2AuPdd0
         hWWvOUYHaKiY/FVAdVnj6H77DQJgY1t0gGDDc1CNYhqoxFwPd3oiKJfAH36/7zRpif95
         LONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6VzOzblINlAwOt9Z3Tc0L0XEgO1pcUZqBpt6BgFfo/A=;
        b=gKcL1IwRIIfcjKxA7kClW7Y0rv2QYPGr8k+TLYzE6zBRcEgxqf6kzwp2D0Z7UzaSKw
         3Hiidzzz5e1HoPfo7Nl/9jYGldtNWWB9MPDrw19LeIEBGG7RRTvPQmbARjfgsEDX3pDh
         ZtdXpJ35p0uq/EFotzdo1rohxNC4Xv4++j6pzS8d6prTydg2afcYgk5oJQHSulv0U1uF
         K0sSIVclxF7U2BT+rU40Q6nSnDf9brko6JqMUgBbyeS+7nw6meUyE26Bb/bWb09PQGvf
         VpqmfkIDwTgA3DSH0FDVxMT0nEQ2Qf+9xuExnzhS2y8/5Wlv976mE/eAzIraFmuTfTCd
         4QlA==
X-Gm-Message-State: AOUpUlHIAP791tpMjKPjSUwnFL3kSPpBSzfPTWSTf7bwgLF1ITy9uvUu
        8rehNRLJ8pAA1cm2ghpP0MD0X1FU8dHVay1Dr5WaQw==
X-Google-Smtp-Source: AAOMgpcjE2KXQ52wiHCfEDbj4WLlTirlWeV3fTht4jUZouOMkcHRPo49gfbdWuIrps9XWCuwf1xim0L8siUf6S70+0Q=
X-Received: by 2002:a62:8d7:: with SMTP id 84-v6mr24214435pfi.172.1533078557859;
 Tue, 31 Jul 2018 16:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdku_BOi6m2ugaef6=8+VH_+KAHH-Ch+uZZqMr8WAKARCw@mail.gmail.com>
In-Reply-To: <CAKwvOdku_BOi6m2ugaef6=8+VH_+KAHH-Ch+uZZqMr8WAKARCw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 31 Jul 2018 16:09:06 -0700
Message-ID: <CAKwvOdn1Ri2VP9hNfKwQ3WMzL278e7-3DGusZc1cwQZbk9H6nw@mail.gmail.com>
Subject: Re: Getting the instruction pointer on a per arch basis
To:     schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org, tony.luck@intel.com,
        fenghua.yu@intel.com, msalter@redhat.com,
        jacquiot.aurelien@gmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com
Cc:     Pirama Arumuga Nainar <pirama@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        Mark Salyzyn <salyzyn@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ More maintainers and lists for visibility

On Tue, Jul 31, 2018 at 3:32 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> I'm currently looking into cleaning up the code duplication between
> current_text_addr() and _THIS_IP_, virtually every implementation of
> current_text_addr() and _THIS_IP_ itself are basically:
>
> #define _THIS_IP_ ({ __label__ _l; _l: &&_l; })
>
> For a few arch's, they have inline assembly instead (for
> current_text_addr()).  Examples:
> * s390
> * sh
> * ia64
> * x86 (um and 32b)
> * c6x
> * sparc
>
> I have a patch that cuts down on the duplication, but I don't
> understand why the few arch specific implementations are necessary.  I
> could reduce the duplication further if it's ok to just use the
> statement expression.
>
> Does anyone know why this is the case?
> --
> Thanks,
> ~Nick Desaulniers
