Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A258C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573162070B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+8m9gVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfANUMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:12:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43888 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfANUMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:12:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so329872wrs.10;
        Mon, 14 Jan 2019 12:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E4SBl3U0kVyqGqSUxFZSpYSw0A7I9Y7IH1FMPBhTXVc=;
        b=W+8m9gVNzHwIm55Z22NUfBozWEpa4sNqH4vFj3l6bGoumlezuvwlL5kv14o65/qqBy
         BI0vRbCRebK9bK4W0AY4mABm1BrLMlfZHQj15aFiz5tDV/8J8sKUNM6HWCP1HITxE8ye
         qu3Yp/rXYLZkTRKmlkzajy1rkZo0tymJ+vuDfHVueCCqr1iH0IzwwtWnA4RMucX6OakY
         sF7fHRUSx4LUk1h/6W3HuuAMTf7kAiR5Kb4tac/wtzxSALV77tC7Pbs1nGzeaDWE2Vty
         CGAcGFgtsAagN6KL3+fXYIxKXJzKAvdhCEYZiRPv/drovA0dFCWteeLyNkde28BF1dsm
         +deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E4SBl3U0kVyqGqSUxFZSpYSw0A7I9Y7IH1FMPBhTXVc=;
        b=rHlF2h66vZjz1QU21Sjbox+Qquea1Lu0SmLT4gdIO+gjjDz3j2m2elX31mBgW5TM31
         pIw/GF7pudKdj0SJ33etQL3r2nnhh/7o5w+74gB85caNbcG8QVCnVwr4F6sZgisRepYY
         jhJ8GhOIHw1v8eW7eR28zhbiD55y2Nx6AUFrQJhR5sAWWa3YTvuFvWlmyf/aNq9+jt/c
         fUeyr0geZf1OXvWPJJRgIcBKoGGNEPxDIh/7QJNT3ybXpsKX898xbMElD3d0k708iiPp
         H5e9jWoYAe0fqbUpS4ph7nOyZ64BZuPJp9mb0AYzUZOlxNRjBHSgsw6jW1agJ+SdHOls
         i4Yg==
X-Gm-Message-State: AJcUukduWs61hO08wenv91GHIn+z7Gc2HmnJIkRx8k6Px2W1UJa93Wbq
        HAtp6ab/eR6EkexknmXtoTYWmi0=
X-Google-Smtp-Source: ALg8bN4yb81uLhiw1HmtohMiQQ6ixMR4VnMDE8XudEU08HGa38JtY+JLYpK70n2yz2tRkcf8DU3Q/Q==
X-Received: by 2002:adf:b102:: with SMTP id l2mr145895wra.296.1547496718309;
        Mon, 14 Jan 2019 12:11:58 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id y185sm19124033wmg.34.2019.01.14.12.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 12:11:57 -0800 (PST)
Date:   Mon, 14 Jan 2019 23:11:55 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: return exit code 4 for skipped tests
Message-ID: <20190114201155.GA9978@avx2>
References: <20190108193108.GA12259@avx2>
 <87zhsahm1s.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zhsahm1s.fsf@morokweng.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 07:33:19PM -0200, Thiago Jung Bauermann wrote:
> Alexey Dobriyan <adobriyan@gmail.com> writes:
> > --- a/tools/testing/selftests/proc/proc-loadavg-001.c
> > +++ b/tools/testing/selftests/proc/proc-loadavg-001.c
> > @@ -30,7 +30,7 @@ int main(void)
> >
> >  	if (unshare(CLONE_NEWPID) == -1) {
> >  		if (errno == ENOSYS || errno == EPERM)
> > -			return 2;
> > +			return 4;
> >  		return 1;
> >  	}
> 
> Can't these tests use the KSFT_SKIP macro defined in kselftest.h?

They can! I tried to find a single use of XPASS and XFAIL and failed and
now I just don't want to have anything to do with that header.
