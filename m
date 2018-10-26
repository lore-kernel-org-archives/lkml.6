Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC28ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9412C20848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHIXjXt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9412C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeJ0CnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:43:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38124 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeJ0CnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:43:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id b14-v6so2260271wmj.3;
        Fri, 26 Oct 2018 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DMG4e4d02HBH0bqTbzWiOAkclUf/Vvke8uVsQi9G2tw=;
        b=HHIXjXt3puYiFxlE6j9OYV0W2sKXOZC32F5Ex3EHpL8eaVXWm3EWIc/QQ/ielfG/up
         FFMn2TpczBz0kVLa3Y0W0kmgmuXTN1xqPIgW9bK2D/XTylQZ9sOcXhYD0iEJ3Huapveo
         u6+FrJ4VNlj38ASi4yOQWL6gHLEtIOGR+wU2dew5q8guG3N1QQWHzWCoZ7CgcaLhNNvb
         UqTALCTnQEfDCdTPpLZnDw6/7+q2KMAI1nx9cokePpjOadPJxcBsS2uRW9vhror4FGdM
         NUX4hT1euheJe+uf31L6wKJMwByh7UZlYLZuZHJcksT1nJMA/10pagosjmuYdUa4jNjg
         dd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DMG4e4d02HBH0bqTbzWiOAkclUf/Vvke8uVsQi9G2tw=;
        b=WED0Sc88XVC00I9+Qb0uoT5x8gKG3tSHZfflxT9CwxCGFuLPIkT+MN9uws3WHjJx54
         xiac7aJtCfJj8Xkz8Atg9SGKEiV9HUV36ayC4ETm1jN1mi6vFj9t4zZKv+crEm6pvWVO
         ywjLeATIHqa7wfV/9FhSVKBqj7XaCnsDZk3gsqqzZ5phnQjbdEkA2L28bbN7poAY+APL
         ygwS8kL+o68yPxYNU1/g86GYEItIWR8RaNXmzUCQmtTP1rCQAQ+KIahA7YWP30UTs/X/
         i9/EW5pC+1oW6HBOlrFlM/eg7+xBRwwj9lv3PvKJ0phzvOkgJQOVq6OU/zVGijb2pbFo
         15gw==
X-Gm-Message-State: AGRZ1gIpgm9aPyRSlN5NIzFp87p5aTqmm5faX6DLA0AapiKpRupd4LW5
        h4YED3jhK16atrmS2B/EIPA=
X-Google-Smtp-Source: AJdET5dNT8gsnR7VBm7A/Pbv8IEmcLxDR3rSQadPjeLu/aOtrBuR7uJ6nIssb1ZdCHoTNcOQa4pAIg==
X-Received: by 2002:a1c:838a:: with SMTP id f132-v6mr6664508wmd.51.1540577118814;
        Fri, 26 Oct 2018 11:05:18 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id x12-v6sm13103580wmd.32.2018.10.26.11.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 11:05:17 -0700 (PDT)
Date:   Fri, 26 Oct 2018 11:05:15 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, ooo@electrozaur.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        hch@infradead.org
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
Message-ID: <20181026180515.GA12129@flashbox>
References: <10b12992-3570-4646-374b-82cbd7276839@acm.org>
 <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
 <1538503063.193396.6.camel@acm.org>
 <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
 <1538521591.193396.8.camel@acm.org>
 <20181025213144.GB24709@flashbox>
 <CAKwvOdn=TvoGdFvgxX6TyXBXnhVLttriRrZEnzS6DjcjL64DPA@mail.gmail.com>
 <20181025225548.GA10326@flashbox>
 <CAKwvOdnwmf47_m_0K5OCLmXbrkLNnekpNOPCCMeJqkuqKUbQ-A@mail.gmail.com>
 <1540576908.66186.103.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540576908.66186.103.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 11:01:48AM -0700, Bart Van Assche wrote:
> On Fri, 2018-10-26 at 10:54 -0700, Nick Desaulniers wrote:
> > If creating one instance of this variable is a functional change, I
> > can't help but suspect the original code was wrong.  But maybe Bart,
> > Boaz, or Christoph can clarify or have more thoughts on this?  Looks
> > like Boaz added this header in commit de258bf5e638 ("[SCSI] libosd:
> > OSDv1 Headers").
> 
> Hi Nick and Nathan,
> 
> Had you noticed the following e-mail from early October:
> https://marc.info/?l=linux-kernel&m=153849955503249?
> 
> Thanks,
> 
> Bart.

Hi Bart,

I had but there doesn't seem to be any reply to it so I wasn't sure if
there was a final consensus on removing the driver. If that's the route
that everyone wants to go, then I guess we don't need to continue to
debate this patch.

Thanks for the heads up,
Nathan
