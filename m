Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00555C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA1D2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544032924;
	bh=fDBJshuBsEkWnRB4yq0Bo/Hn3wz4HdkotG2FiAFTgZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JHiIeOLb59jUcfQMky18uk7kPWZ6kTjOJh2rMjOnl+9MDzq8A/LsvScmCJgajIfpJ
	 kQvMMdwH8kPY5dILr/LiIMF4spwBYS/CN1If8I9V2l+wtq81gPfa9WoNm63WmpF4WC
	 rUapIw0Uj6SJ3VNKMvLd4MWEA6RIZ93ZphZyy0CI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA1D2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbeLESCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:02:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40260 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbeLESCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:02:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id q26so13805377wmf.5;
        Wed, 05 Dec 2018 10:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7psAGPHQAz0ei0xIrQ7aTS4rM04FnEgHbb7ZeeLxY0U=;
        b=VkOjYw8d2ua8RkJTXl0YdCGdq88jJLYPPIYgzy8SLUi1PrDFi6UIjm1v3xsHIZHZF8
         AkraY95DGZ9q0BBici08XhpM+TgDE6lA6NOhlXGOrM8OolBfOXr8FGkxX/q756YL1LHF
         zNoS4LBwYfcfxqfkP81Sp4hccms/Ene4sN1Ws35KoL6ui0ZNT27wyiz10MSzcA/6+o+8
         7kjmreO5BMjKyZWRxMLTPwy3RFhSlBY5w9cFx5H3t4eBJpGTZD+K9Vz4+rz85pmQL8o1
         Yc30d9S4r+4+g4JqZ6Rgg0ZJaS9kVq6yrIIba3wQVAQIfkDH4eOLAe8r7trE711pdGpm
         4KnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7psAGPHQAz0ei0xIrQ7aTS4rM04FnEgHbb7ZeeLxY0U=;
        b=bzp64m0zctc/DdFCqfkBK6Ku3BGG6FFXnDu050amf99aAjjD0yT19gjQAg6QJ1h+6N
         1xTbPNksqsCPAlQ6kRfAg/X5B/6V82Z8VwvAo4BGLWsLQuo24lXDndoj2/6WCGoGnceD
         GxoiPqzYGR/0sA6yDPFsJe5adwsSpD/d3QNusHxgELhqRP3D3rRP5ilZrc0ZVpF/TPtM
         zPu+BEwiYb8K/3dQy4xBvnbb8EIMJj4+B+8OqibnR74DKEtYTqorgC05OFRU7EkJzEej
         8DVjxK77soRgU//Tcbb0/wD8u8LbhsEAHOSW2NJNNmTw2ApFMxKvZwyr+SkMiqc6sRsD
         cMaw==
X-Gm-Message-State: AA+aEWa2OyWBXOD7tJUy6CxiRyvJbxGPQIcQLiX1pY0LtCl7erv7W0mF
        JU+HfM6U2bHB27B1GgRmM7s=
X-Google-Smtp-Source: AFSGD/WD+BeL+Cg15xJudC0fO9cDtwzVY1pJWuUvBegk+vuyULnHAeymqJGYfNsrnmWsdH7B/soydw==
X-Received: by 2002:a1c:c543:: with SMTP id v64mr15938542wmf.123.1544032921034;
        Wed, 05 Dec 2018 10:02:01 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j76sm33555207wmf.26.2018.12.05.10.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 10:02:00 -0800 (PST)
Date:   Wed, 5 Dec 2018 19:01:58 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>, X86 ML <x86@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Streamline MCE subsystem's naming
Message-ID: <20181205180158.GA64770@gmail.com>
References: <20181205141323.14995-1-bp@alien8.de>
 <20181205163037.GC109259@gmail.com>
 <20181205170006.GK29510@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205170006.GK29510@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Dec 05, 2018 at 05:30:37PM +0100, Ingo Molnar wrote:
> > Would it make sense to organize it a bit more and separate out vendor 
> > specific functionality:
> > 
> >   mce/cpu/intel.c
> >   mce/cpu/intel-p5.c
> >   mce/cpu/amd.c
> >   mce/cpu/winchip.c
> 
> That's too fine-grained IMO and look at the path we'd get then:
> 
> arch/x86/kernel/cpu/mce/cpu/intel.c
> 		^^^     ^^^

Oh - I thought we'd have arch/x86/mce/ or so?

There's machine check events that are not tied to any particular CPU, 
correct? So this would be the right conceptual level - and it would also 
remove the somewhat redundant 'kernel' part.

Thanks,

	Ingo
