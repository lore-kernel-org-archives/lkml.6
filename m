Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD0CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E3A223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dvf6xcmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E3A223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbeKMBt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:49:57 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43622 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeKMBtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:49:52 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so6517442lff.10;
        Mon, 12 Nov 2018 07:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MSCObcsgmp/ZbtAsIo3KtPAhYG6nDRGqdyXaag2BAZw=;
        b=Dvf6xcmY+uqjHtS4ldrCunQr1xE5Dn88rVmdGT7JWFSFb6SHNTeLYNlS8bEqwiyqpC
         2Ae0LKgoyazdhAQp+8vnWE1KRfP6nvb4sBUYapQbvYi4NeuCD+rsHNslgLA8rFJxUvXm
         Iqg4Or4LhT2Bjvaz/9L6LyMl1iAX1DAgIH/bnXYoF5/6EDdOtbwDD4Sd7muePGIdZOAX
         wsDzLt25erpSaeQSUslMgvi4ybndS6l/ai/fWBu9CPvyhjEDXdMH6PZ7n4UpCD0kcEME
         ly/Uj1vIYsPTnV3QG3yMx/A3h+krn6TuLwmcW1BCtLAUT31tRvEOn4NLfuSn/TxBu9/S
         CHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MSCObcsgmp/ZbtAsIo3KtPAhYG6nDRGqdyXaag2BAZw=;
        b=NROjOvTKyiXoU4s/npxdhNpQImMQA41LEE6ZQMB21oHyCfpY2D7k8ah23NgP3ZFC1E
         aP80VONH01SoJKYXLU2L21s/Zn80y5C596GcitO4r+igv6j5Di4I0C6BtK6j5s6MDYyW
         +nFNwJD8uVn/hMQg+Lt/eDksy93eSKQC1/YtExI0rE5jfPpZHhitPd5ZbdWnvtnL8Ttg
         HdoUBWEKPM4H8XkurxGp4xejnp3YcP+BT05WWesM1FuXp5xlfy6hswyp8ycibLSWrYnk
         5LpcOScW+MdzmPGKl2llsg0L1TQpSC6nJ3M81Yluje8jGOjEvFQO+cuGzR3AsjWKqx4Z
         4WsQ==
X-Gm-Message-State: AGRZ1gLxWJDlnEtBeLjtFdoVmowNzji7buXC2lcIOJz6JYcLna5E0aRy
        HtzuHdZ+RfoFuxRiY/NWTOMB4Zbz
X-Google-Smtp-Source: AJdET5cjojOiU/49IVdNni8VdjCRtWWldzNH1gGZB7s5ViBv4C7tb015oNeuFFjEo9BjmwPVP49Z8A==
X-Received: by 2002:a19:4849:: with SMTP id v70mr946364lfa.62.1542038161148;
        Mon, 12 Nov 2018 07:56:01 -0800 (PST)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id 1-v6sm1765242lju.61.2018.11.12.07.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 07:56:00 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 8B2E54608E4; Mon, 12 Nov 2018 18:55:59 +0300 (MSK)
Date:   Mon, 12 Nov 2018 18:55:59 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH] proc: fixup map_files test on arm
Message-ID: <20181112155559.GV13195@uranus.lan>
References: <20181110184920.GA18252@avx2>
 <1541904527.857883.1572718104.2AE8D0DA@webmail.messagingengine.com>
 <20181112141456.GA15690@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112141456.GA15690@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 05:14:57PM +0300, Alexey Dobriyan wrote:
...
> > >  int main(void)
> > >  {
> > >  	const unsigned int PAGE_SIZE = sysconf(_SC_PAGESIZE);
> > > +#ifdef __arm__
> > > +	unsigned long va = 2 * PAGE_SIZE;
> > > +#else
> > > +	unsigned long va = 0;
> > > +#endif
...
> > 
> > I have sent a patch removing proc-self-map-files-002 AND making 001 to use as a
> > HINT for mmap (MAP_FIXED) *at least*  *(2 * PAGE_SIZE), which would, likely,
> > attend all  architectures, avoiding trying to make the test specific to one,
> > and, still, test the symlinks for issues (like bad chars, spaces, so on).
> 
> If the goal is to test the lowest address then going for 2*PAGE_SIZE is
> a mistake.
> 
> Which BTW hints to add a test for the highest address.
> 
> > Both tests (001 and 002) have pretty much the same code, while they could have 2
> > tests in a single code, using kselftest framework. Is NULL hint + MAP_FIXED
> > something imperative for this test ? Why not to have all in a single test ?
> 
> I dislike tests which lump everything together into one process.
> 
> > Are you keeping the NULL hint just to test mmap, apart" from the core of
> > this test ?

Guys, lets simply stick with Alexey's patch. I personnally think that
testing mappings should be a separate test in vm/, but seriously this
took too long already :) If Alexey's patch fixes the problem with arm
I think we're fine.
