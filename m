Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BE6C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9AA2089D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muTWCyR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9AA2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbeKQK7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:59:43 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42867 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbeKQK7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:59:43 -0500
Received: by mail-ed1-f65.google.com with SMTP id j6so16051703edp.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 16:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O/OrTk4RWB+bnrpuTRHaVd7D6PzOxq4AJNr3u5tMrtw=;
        b=muTWCyR1BRDIC7idgDDUfWFr9TlVr+HOD3fhjEvkAP7I9eVM//6+UqajWUCPruLG7Q
         wIkjSyOySKiL6NfB0edQVppuXUf2ZZJuVt5ikp9u+Z/Rc7Uw7Kae376smVGWstREwhBk
         QVX8qYE4quTGoEHR4cnvhsh1MhVafYxLC5kb/6LxfwjVQvaV/Bcr8aB0PXx8nMNBGjwm
         0tzCofFshmvvnh5SQxip/9NVcxOUyiRK8PCDel9ANZaDaxE7BURrtdwVZ7x/LOlXARyj
         fh5r6WrNNTNwV1OMGRiD2dZrN+i6QI4LykN/1/OORCdpgcfl1MrZA0ELrlCH2EYvUxs3
         z4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O/OrTk4RWB+bnrpuTRHaVd7D6PzOxq4AJNr3u5tMrtw=;
        b=NLg3AgmJ/9M0rlyDCAtkbMFShTuJ01IT56e3gqISewqHVlyrqLXwnSflOr79gE5TAX
         uC0+M052/9id9GmgWnAyl6ThBHHU5Qjjs2V/MjFsH41005F6YbpnbVJ7ILqcwDbQ6XRO
         TM2NLu3d7PUEGV+cKNR3Rt2bu7yzVWHRGksrmGJKlyPMTEN+2vriHmyGHIXmOLne5K8n
         sSR0e8yoppNXtsPEJT4vOe0gnxec6QFeRHyqCixHO78Ypkj9gsQOThJ0lxzPCtv1HfTZ
         u4SKIFGvhdlNie4svTYjylFHY9WtjRPIURK9q01BMQlRriT8ENuX+NlX5e88IdAWInVC
         REcg==
X-Gm-Message-State: AGRZ1gLglTwh6w2qX0Vgke9cR4xcx126rxjuWWhJfgjVl9aRf2deUtb6
        JaUpp3zJo324Vptzy4CK370k/JBN
X-Google-Smtp-Source: AJdET5ebR1RkERNIfh4ilAse3fbBoJx+nEj4ETl01EUWfJfk/nJZJ2q0JHs5Sl13cnoA5/5pQR7EmQ==
X-Received: by 2002:a17:906:6181:: with SMTP id q1-v6mr10051307ejk.219.1542415504277;
        Fri, 16 Nov 2018 16:45:04 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40bc:4d00:787e:f271:ff1d:82b])
        by smtp.gmail.com with ESMTPSA id g37sm1762914edb.85.2018.11.16.16.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 16:45:03 -0800 (PST)
Date:   Sat, 17 Nov 2018 01:45:01 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2 2/3] kernel.h: hide __is_constexpr() from sparse
Message-ID: <20181117004500.xipguiszdbs63dle@ltop.local>
References: <20181109093534.15121-1-johannes@sipsolutions.net>
 <20181109093534.15121-2-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109093534.15121-2-johannes@sipsolutions.net>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 10:35:33AM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> __is_constexpr() is a work of art, understandable only to the most
> respected wizards of C. Even sparse doesn't seem to belong to that
> group and warns that there's an "expression using sizeof(void)".
> 
> Just hide the definition from sparse and pretend it's always true.

The development version of sparse doesn't issues a warning for
sizeof(void) soon after the introduction of __is_constexpr()
and sparse's main tree have been updated (very recently).

I strongly believe this patch shouldn't be.

Regards,
-- Luc
