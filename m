Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB076C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B592620823
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549920330;
	bh=tqsy22QYONc8A0mlJUYHZrOAwRACNabev72R7f/MzBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pA4j0TpRA/BUvSAdIfGNXtG0TpOCld4olShBVMtEepweRmZ3PuIuHaX6+Fc4Oyl4B
	 PddM+kNV3wetS4S3KUgMYA6w9SfAXVuIrNB8lD9Lannx3yzbdM0k3YwaozO4Gh6ETj
	 eHtv4OooGNIbO4lGkOZACakX0nY+YBxiBf4E/NAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfBKVZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:25:29 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42220 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbfBKVZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:25:28 -0500
Received: by mail-pl1-f194.google.com with SMTP id s1so156647plp.9;
        Mon, 11 Feb 2019 13:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q+3TpLItlIcSTXMnFZM+gf2PHpo+Nd030GU+usf4tHc=;
        b=eINO1+gUFnmNHW5YlT0g0bMSeifWuCSx/pQe8RnscHC/iDq8g6bW6uylQAs7DCy+dm
         QbGbw3dRAwCJT3+f8n6PKJSGc3QwWrRO7ocyEKxnevkpuzlV8X0sCNTa5mGfuTARhf+H
         Yu60PJ2Q4CxtIQSkIWRj0kHVQthH6qSeVYe0HqtIFwH2wDsVUY7Vebi4VlCGSo3b4t9A
         YA9M53t9fkxce7mcDQqBwNDZQuveCrkY0Rhx1xNEakb+4MQUXOBmjtzqQzyZWn6oVHVo
         h0n61tBPoqtcIFnprAnFikCO9B697ZsBhFW1h/dHSBXnwY/56jRmptf82o6K3FLNkJs2
         5CTg==
X-Gm-Message-State: AHQUAuYLgXKDQCIIAjSPUhkxnb91wJtadxLqE+RhIjmaGQJBDLnLYNs2
        Lbb6PJKapgFVWV9SKf83vng=
X-Google-Smtp-Source: AHgI3IbBMoEpI4NDd8FfMXiDv7E4QuEA1BsIy666603uW3Gx8IZkB+2aFENqFT1pjkm291dVytQ6lg==
X-Received: by 2002:a17:902:e512:: with SMTP id ck18mr341223plb.46.1549920327709;
        Mon, 11 Feb 2019 13:25:27 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id v11sm17098063pfa.49.2019.02.11.13.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 13:25:26 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Mon, 11 Feb 2019 13:25:23 -0800
Date:   Mon, 11 Feb 2019 13:25:23 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        longman@redhat.com, linux@dominikbrodowski.net,
        keescook@chromium.org, joe.lawrence@redhat.com,
        ebiederm@xmission.com, linux-api@vger.kernel.org
Subject: Re: + sysctl-return-einval-if-val-violates-minmax.patch added to -mm
 tree
Message-ID: <20190211212523.GU11489@garbanzo.do-not-panic.com>
References: <20190211210632.Nfd0f%akpm@linux-foundation.org>
 <20190211211716.GA31039@avx2>
 <20190211211917.kq2ahdkhoe36obhp@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211211917.kq2ahdkhoe36obhp@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:19:19PM +0100, Christian Brauner wrote:
> On Tue, Feb 12, 2019 at 12:17:16AM +0300, Alexey Dobriyan wrote:
> > On Mon, Feb 11, 2019 at 01:06:32PM -0800, akpm@linux-foundation.org wrote:
> > 
> > > @@ -2848,8 +2848,10 @@ static int __do_proc_doulongvec_minmax(v
> > 
> > > -			if ((min && val < *min) || (max && val > *max))
> > > -				continue;
> > > +			if ((min && val < *min) || (max && val > *max)) {
> > > +				err = -EINVAL;
> > 
> > I was asked to return ERANGE in kstrto*().
> 
> I think we discussed ERANGE vs EINVAL and decided EINVAL because there
> was precedence for other sysctls already.

Can you do a proper audit and see?

linux-api folks may care.

 Luis
