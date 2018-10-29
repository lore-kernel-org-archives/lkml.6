Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77065C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9722080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="L28M+Kw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9722080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbeJ3Fch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:32:37 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:38640 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729743AbeJ3Fcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:32:36 -0400
Received: by mail-pg1-f174.google.com with SMTP id f8-v6so4477677pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 13:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R07Hyb8PyR93HWXRVWLIhei7uPvejjZ+RFiXz2+Aoaw=;
        b=L28M+Kw66UHGjSLT613REpVBS7lTp+uZbjFlocTAT3FpF8DRkeUxF3/uHgnMVNjngf
         oipyyFaM3v7pqRC+W7b1WNbsrz+TM36QSFMLOuzVTCCPCKjFpNnpqwTQL1edWcpfedil
         I5oD6lH9N64tj25H8ipS5DVHLv0EjBbhoiLPOsqHGaQe9L9vPWZTW6EWjZxWcP5EQ61d
         l0E3uV0AjvsLWy2Yxe90BhPoj/pLZ/oCrgBQDg/Fgn0rAGqBjCaYLE31Fhz8YvvEP6Go
         yzW3t0vlqAMR+w8lHOBukSwSW7lcLuKbF+0VZ+fBfhmboc4L4g6/mk5t5eTwm6k9IUzQ
         rO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R07Hyb8PyR93HWXRVWLIhei7uPvejjZ+RFiXz2+Aoaw=;
        b=GXAZN2ko9JFr2LEY0NzaQa9gmYK6dyYpW/7omzdaX0NzwtXLESEiFBZiUfIZTNeJjE
         kgtLmubLIz7vkijmqPjQJpH/QmOy4BrLqs2oX0rObrncAOCrS3Lgd/TI9yDHBFQlTGTa
         e9l/0xrWNP/mwFW+lpee2DzPYgVTbSWkGBWeq6hp/DBO7OBKGav81wiumDZ46T0v26TR
         EMnT+1n6Ntc3gEdsX10CQkchGb1DFJKobjBpd5u0vXwIIwFDBskjFI4T1Q66nmEpbua5
         p4RVtWGJ8D/5GT/jmYLJ2ie6okiMPcqll9hM1IJGi2y1iAJTOQziCNW1Ha/jmL9oUXCq
         lQzQ==
X-Gm-Message-State: AGRZ1gI17OvBNYNDbQ34x9ChhYUNcH2I3/3pNDNb2t54ekHkZdWoNvLg
        /4ENW6fnurhZ4Trz4TJVO7W7dLusbhg=
X-Google-Smtp-Source: AJdET5d6QVrNe5WH9ScJNZcz1yKXyZwMkAJ4hrmqQ62iJsraBPU9vY/MuY+9FxveSGjHcUlLjHyRaw==
X-Received: by 2002:a63:de4c:: with SMTP id y12mr11577076pgi.198.1540845736045;
        Mon, 29 Oct 2018 13:42:16 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u79-v6sm29686924pfd.117.2018.10.29.13.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 13:42:14 -0700 (PDT)
Subject: Re: remove exofs and the T10 OSD code V2
To:     Christoph Hellwig <hch@lst.de>, ooo@electrozaur.com,
        martin.petersen@oracle.com
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        osd-dev@open-osd.org, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181027082019.20838-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f9423180-e0fc-efba-e759-dfa4725953ad@kernel.dk>
Date:   Mon, 29 Oct 2018 14:42:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181027082019.20838-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/18 2:20 AM, Christoph Hellwig wrote:
> The only real user of the T10 OSD protocol, the pNFS object layout
> driver never went to the point of having shipping products, and we
> removed it 1.5 years ago.  Exofs is just a simple example without
> real life users.
> 
> The code has been mostly unmaintained for years and is getting in the
> way of block / SCSI changes, so I think it's finally time to drop it.
> 
> Quote from Boaz:
> 
> "As I said then. It is used in Universities for studies and experiments.
> Every once in a while. I get an email with questions and reports.
> 
> But yes feel free to remove the all thing!!
> 
> I guess I can put it up on github. In a public tree.
> 
> Just that I will need to forward port it myself, til now you guys
> been doing this for me ;-)"

LGTM, for both:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

