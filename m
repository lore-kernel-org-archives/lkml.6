Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2E6ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 17:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C80020881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 17:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+UlGq9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C80020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeIOXGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 19:06:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42485 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeIOXGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 19:06:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id g23-v6so5563298plq.9;
        Sat, 15 Sep 2018 10:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L/eeXoJ2tdf/zTRRrynwm9J5HH2dofi+d09wyXHyjXI=;
        b=F+UlGq9bZyI7aIoGBt8G4BnvhbX+uUYo6f6/ZRbA0e2E7/7rrK3dhqmqZJJW9VYmkt
         g4VOSrv5q02NMuSoha6eDfcOiOSdv/7HzTe31yz5nFYjMMk+XhNYOstRSg74blW6sVml
         hVYGuVaVRpPXzQRj72Gi6J7NkYwniWP9VLIQ36RySkmlOLk1Z1olUILbJIWmboNGxQ4f
         y0phLmg6Ozy1IJtIb2uVOv1mVo3vX6tAZZNEFxtkTBjaeCNru/dea0qR4ldZdewopfsf
         esSan3Z4vqE75SyMwELHlswsjtjK7zepuqaqde69hu2YYAMQ4V0gNu80np+f/9Pjtrwu
         oDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L/eeXoJ2tdf/zTRRrynwm9J5HH2dofi+d09wyXHyjXI=;
        b=cdd2yQRp35f43rtvQb0DItRhHakzoUvdVsgi3dQucDrQSE5V4FfFs958ZoXuyGK9QG
         jSyFIwHsAqgB3R6RZIarzzX57K1tIehMPjcmnqG1KUuQuF2Yy3g1gkT18ml7wFd73lQN
         iW8jH8ADP3HW2jUOr3ogf7DTI2+8MB1TB80CiPKEGAQd73+3Yp9/tMZ+kpfR+tbGCy37
         utK2HzaaKT7r4d1qjoxO5sA06dQTBgXW+WVExVjqcFOm/7DiyxyAZfi2iHyyS+BYqg7B
         HEl+eu+FCe+++3cV2HsFZEQaSoBtvrC29If2aLtujbCUyAyhtbctB1HxQxIYHtNnHkNo
         YGNQ==
X-Gm-Message-State: APzg51AKMbMDFLCeecerm4L4VG0DAtP2gmyC+UTdLr5WNmTSLNKy6Rqf
        ME/yNxQBmMkHJkEhhH7DN3U=
X-Google-Smtp-Source: ANB0VdYqwqG+pKbzfu6W4pbiAxd8oBLBqOjuGuPEuP7UsmN2HqU7UmLJ4bCZAlMQ0eVShIsfa1LNIw==
X-Received: by 2002:a17:902:246a:: with SMTP id m39-v6mr17281940plg.57.1537033606126;
        Sat, 15 Sep 2018 10:46:46 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id l3-v6sm12653249pff.8.2018.09.15.10.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 10:46:45 -0700 (PDT)
Date:   Sat, 15 Sep 2018 23:16:34 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     peda@axentia.se, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Julia.Lawall@lip6.fr
Subject: Re: [PATCH -next] iio: potentiometer: mcp4531: merge calls to
 of_match_device and of_device_get_match_data
Message-ID: <20180915174634.GA15225@himanshu-Vostro-3559>
References: <20180915105430.24052-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180915105430.24052-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 06:54:30PM +0800, YueHaibing wrote:
> Drop call to of_match_device, which is subsumed by the subsequent
> call to of_device_get_match_data.  The code becomes simpler, and a
> temporary variable can be dropped.
> 
> Found by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Already applied!
https://lore.kernel.org/lkml/20180819201752.2280be76@archlinux/

Anyway, if you want to work on making similar changes, you may
refer the following cocci script:

I tested[1] the changes through 0-day and had few false positives
and regressions. Therefore, check the results and compile test
the changes before sending patches.


Julia, and I had tried to make the confidence "High" but few 
cases were difficult to resolve, and later neither of us had 
time to look back at it again.

Not all maintainers will acknowledge such a change, but IIRC
Rob Herring gave a thumbs up on few cases on the dt-mailing list.


[1] https://github.com/himanshujha199640/linux-next/commit/efb7ed923bd00c86fe0a4e67e2ddb636ff0e0ff4

---------------------------------------------------------------------

/// Use of_device_get_match_data() to get matched data in an OF driver
//# of_device_get_match_data() returns const * and therefore the left
//# argument of assignment should also be a const * for compatible
//# types.
///
// Confidence: Moderate
// Copyright: (C) 2018 Himanshu Jha, GPLv2.
// Copyright: (C) 2018 Julia Lawall, INRIA/LIP6.  GPLv2.
// Keywords: of_match_device, of_device_get_match_data

virtual patch
virtual context
virtual org
virtual report


@r1 depends on patch && !context && !org && !report@
expression x,y,z;
identifier match;
type T;
statement S;
@@

- match = of_match_device(x, y);
(
- if(match==NULL) S
- z = match->data;
+ z = of_device_get_match_data(y);
|
- if(match==NULL) S
- z = (T *)match->data;
+ z = of_device_get_match_data(y);
|
- if(match==NULL) S
- z = (T)match->data;
+ z = (T)of_device_get_match_data(y);
|
- if(match!= NULL)
- z = match->data;
+ z = of_device_get_match_data(y);
|
- if(match!= NULL)
- z = (T *)match->data;
+ z = of_device_get_match_data(y);
|
- if(match!= NULL)
- z = (T)match->data;
+ z = (T)of_device_get_match_data(y);
)
... when != match

@r2 depends on r1 && patch && !context && !org && !report@
type T1;
expression e;
identifier r1.match;
@@

(
- T1 match = e;
|
- T1 match;
)

// ----------------------------------------------------------------------------

@r1_context depends on !patch && (context || org || report)@
type T;
identifier match;
statement S;
expression x, y, z;
position j0, j1;
@@

*  match@j0 = of_match_device(x, y);
(
*  if(match==NULL) S
*  z = match@j1->data;
|
*  if(match==NULL) S
*  z = (T *)match@j1->data;
|
*  if(match==NULL) S
*  z = (T)match@j1->data;
|
*  if(match!= NULL)
*  z = match@j1->data;
|
*  if(match!= NULL)
*  z = (T *)match@j1->data;
|
*  if(match!= NULL)
*  z = (T)match@j1->data;
)
... when != match

@r2_context depends on r1 && !patch && (context || org || report)@
type T1;
identifier r1_context.match;
expression e;
position j0;
@@

(
*  T1 match@j0 = e;
|
*  T1 match@j0;
)

// ----------------------------------------------------------------------------

@script:python r1_org depends on org@
j0 << r1_context.j0;
j1 << r1_context.j1;
@@

msg = "WARNING: opportunity for of_device_get_match_data."
coccilib.org.print_todo(j0[0], msg)
coccilib.org.print_link(j1[0], "")

// ----------------------------------------------------------------------------

@script:python r1_report depends on report@
j0 << r1_context.j0;
j1 << r1_context.j1;
@@

msg = "WARNING: opportunity for of_device_get_match_data around line %s." % (j1[0].line)
coccilib.report.print_report(j0[0], msg)

---------------------------------------------------------------------


Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
