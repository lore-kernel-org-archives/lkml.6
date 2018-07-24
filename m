Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29D4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE4820856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dbg0WyWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE4820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbeGXTbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:31:39 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:40368 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388409AbeGXTbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:31:39 -0400
Received: by mail-ed1-f45.google.com with SMTP id e19-v6so4933501edq.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 11:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e6WEwyJXRAMbcQ8P6YjVno03mxQqGy0THTcSRuE2750=;
        b=Dbg0WyWS6dlZ4Sh/vOU8NAgEoJ/3S7/q1FWD3sgJwGDFQp2rLwDT9nmjLs2ULulrrx
         ET9QYJmA7TIBYBeKuvhYvwe3I/qA7CoXihzhm+a0D8LwNMwRAvPjgZYX1ZWEWBMUQhcX
         Mg7RMaMIDTofLWFtdKfhbane24W7oBPgGDmbsvF/T+pssJpBABXGnoS0Uj4NM6ImwdSF
         ZWuGX+eMd9o/XKRirA16YN5S1aIeGXFJBdeZ2kcbDfz4RAV11Bvq2BBX16I4jQtIRdkH
         y0f47f8GpaLDxxJOQ9oS+94XQXOvyoQam9oXuudGUdZjnjUq3SiAmQ8bjYGDpXW7nE2B
         94RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e6WEwyJXRAMbcQ8P6YjVno03mxQqGy0THTcSRuE2750=;
        b=IskiAyql75SJOMbv+0DECa1WFCn+f+1Tb+khnRns4r0gXC/zJB0ZqIy34jJiMgSBSA
         0uKJBBm+P2M8ovL5dpqy5FbjT62LzyW57DUvI4ALG6UDbPNpj0+cm5VNxm2ewfBaD9RE
         OWz6QV9Wr65dOSIylrQU0UyZ5H5dlXCwIHlxmdmBTRe0ouVA1PQorN1WcC0/pjWo1Iyd
         ZmNy7abAi0VdzG+3wwP9qbKGdCd01p/1chuyv4iwXW5e0LL2YzmVNNiPIK07W0CdaEsw
         EoIst7BnrCeGObvEiPzjeJAgGczpPrAYi5JNxHxM6/C6KweZAi5JkbNE82OczcggJyVB
         bYDQ==
X-Gm-Message-State: AOUpUlEebbGntApP2oyUwGHTqgnl7EZMN127Jy2gU/WWdN9VTknpM7Tw
        pTboYVcU93x04IIvXWXnsA==
X-Google-Smtp-Source: AAOMgpdKbWC5n20bSTUZs0rz68rQCvKf0Cdg07JGc5hWJ1BfbTCmIbnK/yX2hQdnlCrFnP55B/Umtw==
X-Received: by 2002:aa7:c70f:: with SMTP id i15-v6mr20148377edq.231.1532456635159;
        Tue, 24 Jul 2018 11:23:55 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id f11-v6sm14269241ede.76.2018.07.24.11.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 11:23:54 -0700 (PDT)
Date:   Tue, 24 Jul 2018 21:23:52 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, dancol@google.com, vbabka@suse.cz
Subject: Re: + mm-proc-pid-smaps-factor-out-mem-stats-gathering.patch added
 to -mm tree
Message-ID: <20180724182352.GB27053@avx2>
References: <20180723235543.4JfsI%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180723235543.4JfsI%akpm@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 04:55:43PM -0700, akpm@linux-foundation.org wrote:
> 
> The patch titled
>      Subject: mm: /proc/pid/smaps: factor out mem stats gathering
> has been added to the -mm tree.  Its filename is
>      mm-proc-pid-smaps-factor-out-mem-stats-gathering.patch

Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
