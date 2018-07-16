Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67071ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F07A208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLRb3ziV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F07A208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbeGPMDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:03:15 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37816 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeGPMDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:03:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id b10-v6so2491210eds.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QruYD3V9DD+0NhCJBXK4CClWBISzPfJiWBOTgZGbWMQ=;
        b=GLRb3ziVx5BE/gRro4Gzo4EMlNQbj5P4Sn5zZBZS0ttiZ1uB7LsH7XyhkKDxLUfftQ
         PH8fN6N8NahcNXvsTqW2bp+aGyDe7OIrpCnNYpKFqRO+eLH6nB0KXXOpAsjbjwxVDPiS
         FzlNsFVgSDQmeaIYh/e2JkFUpqWlEW6PYzmA2xMEMKX40zxrLDBrLQTUXzvYFdspyKq1
         vtNxkm4Qv+L3arPTR7+oUM452BWcH3GJ1vE6l1iIZgKVj1SW0Z0nSy5SZYJpgtuePWxe
         h3gdR0SP4H1uTl0YkBQOcOL0D/5otuAjE7L9ssjfR9pSzEfxiK1ET2dc3duCMHoIWeh8
         Cr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QruYD3V9DD+0NhCJBXK4CClWBISzPfJiWBOTgZGbWMQ=;
        b=t9Kbln5y8571iHleOaDJ693M26M4CP6M8lzCvn0dffT3IOzq9xhGFyABzediwwGEm0
         m/7ICz0ObGMzroMA5+Unz2qDpDhlWY1Rvl/dfpN6bPOReuUF5+ercooKTg6oalPqr1WM
         wlXTfN4HhqPJJ65/ub1k0fp2jBlxrZmbYJ++uke80KJB1/EeB/adnXPKHcHQvPfg/qNj
         ns77pt6RyzA6sER0BNuw70PGrFK8XUzQG3HYwiX69YovthSlwrp1+i6mTF/xQtpRnMKL
         WQzDlrNlaG1bDndq5nxO4/fYT7uL+O3oKtWI4i/v4bt4B9WOm0kB4ncikX4GQ1KGTxsX
         IWsQ==
X-Gm-Message-State: AOUpUlFtxWXgfLYY39AQnA8bENQOvSszh3NmidWsur5mwvAbEEckgvrO
        9oqXOLd9yr/9UIzZK0S1Wmg=
X-Google-Smtp-Source: AAOMgpeWhcmgc7aljwd0ZttTAyfx0h3r64ywtgm2xB/MGGojcPIxU2w05ETo5UBIkQ2s1de/fln4BA==
X-Received: by 2002:a50:c313:: with SMTP id a19-v6mr16647949edb.177.1531740972768;
        Mon, 16 Jul 2018 04:36:12 -0700 (PDT)
Received: from xux707-tw ([109.77.251.220])
        by smtp.gmail.com with ESMTPSA id p20-v6sm8881078edr.12.2018.07.16.04.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 04:36:11 -0700 (PDT)
Date:   Mon, 16 Jul 2018 12:36:10 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        tglx@linutronix.de
Subject: Re: [PATCH 02/10] staging:rtl8192u: remove typedef of struct
 TS_COMMON_INFO - Style
Message-ID: <20180716113609.GC22731@xux707-tw>
References: <20180713201247.21428-1-johnfwhitmore@gmail.com>
 <20180713201247.21428-3-johnfwhitmore@gmail.com>
 <20180716084205.GC8260@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716084205.GC8260@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 10:42:05AM +0200, Greg KH wrote:
> On Fri, Jul 13, 2018 at 09:12:39PM +0100, John Whitmore wrote:
> > To clear a checkpatch issue removed the typedef of the structure
> > TS_COMMON_INFO.
> > 
> > This change removes the previous declaration, which defined two types, both
> > TS_COMMON_INFO and a pointer type PTS_COMMON_INFO:
> > 
> > typedef struct _TS_COMMON_INFO {
> > 	...
> > } TS_COMMON_INFO, *PTS_COMMON_INFO;
> > 
> 
> Same here, this should be "struct ts_common_info", not TS_COMMON_INFO.
> 
> Can you fix both of these issues up and resend the series?
> 

No problem, I'll fix up the series and resend.

John
