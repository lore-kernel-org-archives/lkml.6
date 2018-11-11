Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F36AC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB15214C1
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esOoI5ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB15214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeKKPez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 10:34:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43387 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbeKKPez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 10:34:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id g7-v6so2747061pfo.10;
        Sat, 10 Nov 2018 21:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o+PWUaNabVf4M0zRALBh+Q9wc1nFH7j6Um3v8Drq0XE=;
        b=esOoI5uty7W6Z/hPQRM4k1RbM7mVB/RodnZqrKGCNP4JICkti7uzLu69rmzjH1ay/O
         /gc1gvSGA+L4G+gQ45UeyUKGae7a295rJP7GDh1CLeCU+J4F+jMNSmreKoHfzfE2R0df
         j9HZsuClpnrh34KSyoQR3f+gX+zRWe8sobAcJnFncqLTVllX+Iowlb1VNma8VSQsnq80
         KOazAV7SkoXyDiZEyw1UC/9pH2ph03GwDhgjdj7ITmSgjgTpi1Py2kSM0sJ8cCg22R+9
         7fQTuXBDASHgMT4XTFAVK065b2uBNWnZdN9qpsZL9WzcOlI0bdvFXqfRSmewDniDBwIO
         uIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=o+PWUaNabVf4M0zRALBh+Q9wc1nFH7j6Um3v8Drq0XE=;
        b=mCnBea/iEs2RGdLsPlkT5zbQmrz9cc8u8qFzSBNwqMTJC/Dn+R/zbncZa1TGCKp+Gt
         YMsBUyz7yLq16gdgVye5XM2vt4h4gvHiNLjI1JXAuDWhwLzkCX5/4tw76jqYbpVqOsx6
         bCkq2dNaVLeJvHncgQsR1IXjWXpBOZENLMdYtuZaqhB1tnTNiqAO/ibuPqm90vQCY0FN
         6xgQUR+a0Cem96FlBFynakGM76ejs4o1wfcDo6dlWVBmq0KGRbydA7Zv0HqKXy+CPOgH
         FsTh/MXq1wRJswW3Vnnup4zdXjQOSJwYFbCH/ti/3RiyCL/Aj/UflrsGnGydC6aPgZx6
         iw2Q==
X-Gm-Message-State: AGRZ1gLxf+UmExs9CIYjClHUETJZB4EYlLwIBg/ezoTxlXMQNkHyow8H
        ZvJJP9gCB4q3WE78bvT6BFL7bxVmrCE=
X-Google-Smtp-Source: AJdET5eYCH+IzZjP3+aOViPLGyvsQYcwjR83XXNwVy+WRgLrxrd+Nt+OSLRYbhjShsSc3Q3VqKTi/Q==
X-Received: by 2002:a63:e20a:: with SMTP id q10mr12953116pgh.206.1541915241175;
        Sat, 10 Nov 2018 21:47:21 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f18-v6sm34393244pfh.0.2018.11.10.21.47.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 21:47:20 -0800 (PST)
Date:   Sat, 10 Nov 2018 21:47:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH 3.16 000/410] 3.16.57-rc1 review
Message-ID: <20181111054719.GA31398@roeck-us.net>
References: <lsq.1528380320.647747352@decadent.org.uk>
 <20180608141426.GA5242@roeck-us.net>
 <945ce3bb1ecd9c70249e79d2cb5572f9475c9786.camel@decadent.org.uk>
 <bf66aa7e856d4c2c83dc78dca95eee76437a1513.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf66aa7e856d4c2c83dc78dca95eee76437a1513.camel@decadent.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 12:09:03AM +0000, Ben Hutchings wrote:
> On Sat, 2018-06-16 at 22:18 +0100, Ben Hutchings wrote:
> > On Fri, 2018-06-08 at 07:14 -0700, Guenter Roeck wrote:
> > > On Thu, Jun 07, 2018 at 03:05:20PM +0100, Ben Hutchings wrote:
> > > > This is the start of the stable review cycle for the 3.16.57 release.
> > > > There are 410 patches in this series, which will be posted as responses
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Thu Jun 14 18:00:00 UTC 2018.
> > > > Anything received after that time might be too late.
> > > > 
> > > 
> > > Build results:
> > > 	total: 138 pass: 136 fail: 2
> > > Failed builds: 
> > > 	i386:tools/perf 
> > > 	x86_64:tools/perf 
> > > Qemu test results:
> > > 	total: 116 pass: 116 fail: 0
> > > 
> > > tools/perf builds are new, so it is probably not entirely surprising
> > > that they fail.
> > > 
> > > Deetails are available at http://kerneltests.org/builders/.
> > 
> > Thanks for testing.  I see you've now made the tools/perf builds work
> > for 3.16, so thanks for that as well.
> 
> I looked again and for the current patch queue I see:
> 
>     Building i386:tools/perf ... failed (script) - skipping
> 
>     Building x86_64:tools/perf ... failed (script) - skipping
>
perf builds are currently skipped in 3.16. Let me check if I can drop that.

Guenter
