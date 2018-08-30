Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78EAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0CC20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rAzMK4wk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0CC20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbeH3TIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:08:45 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:41224 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728586AbeH3TIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:08:45 -0400
Received: by mail-pf1-f171.google.com with SMTP id h79-v6so4010495pfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 08:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gSKSApp/vNyLyK+jtUM0YmwQsO+lc20AwgLrZZeIC/Y=;
        b=rAzMK4wkaO5CEhFrrh4zaqFoBfPyuZxbGV6YOCm98bR5ilQ5K636/LuoryPq+P5252
         FDwV6OiQitpX+jbNMnhHCNTbEqLTFGBTePfAES7Y1wRjG3EZdKM7it6gVyDZ/8AvQZVk
         Psv8HTLe9o0HTJPw69debeTmbQ9Au0bJ38+QgZ0XlSIYstgmXdrdDsBEMyof8wwFFwpV
         O8CDppvVX4DbQq5GIarcumInzGr0CtJ5CTsmRGSvwW5QG3THrIi+on6LtJBnXlIlGr3W
         I9fct9IQhWXUYB5cAADBAveS3sVnh5DDzTEbalIECtf4zAHQbaZ+O0wND6yDAY5KJHCJ
         Cp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gSKSApp/vNyLyK+jtUM0YmwQsO+lc20AwgLrZZeIC/Y=;
        b=CVf5xqSS4+eIgemhDA/vo6p21luJ1Od9ALnEtStyWNw1rXVDFIfrcayj7Ny6z3zdRK
         bkHfyvektlatv6ldsmBIrEydsclKnsJXdQ5W2FVr4sZziXEWlWAjWY3HspGEATWhEDXj
         Df2BTcATO61C/9vtuR8MNa8IjdHf9uPvwloUOdwKbf8fMXqBRgQ/tubDfB24aG7GRZEl
         CX+CXdaxseL1cqF0LXt/67wXJIrUee1ACjlduMfdYGbzVbpUm63RsAFFgZEqukPDDatX
         YPI46moNEl4RXgE8pwdHjVVanBmbDONbtmMzY0puUaCY9qzW1DICFmKzdk8VCbX199IW
         Zb8Q==
X-Gm-Message-State: APzg51CB/D8EtJlHISOMt1vvgtRH47DiptLCwhAetDFphrZJ3P9n7hVU
        AMAYzFeQ8vOqCBQ9aAjQ6osP3g==
X-Google-Smtp-Source: ANB0VdbNOvGH2TqJ7Ypz/6IrxxpF/tDg9KnzwPdLCZo6n2uZnaN2GZouJn7pHsPnPk07cKmv4WlxmA==
X-Received: by 2002:a63:481:: with SMTP id 123-v6mr10297794pge.129.1535641570041;
        Thu, 30 Aug 2018 08:06:10 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1132::10e8? ([2620:10d:c090:180::1:d72e])
        by smtp.gmail.com with ESMTPSA id l9-v6sm10659107pgg.79.2018.08.30.08.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:06:08 -0700 (PDT)
Subject: Re: writeback throttling deadlock
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Josef Bacik <jbacik@fb.com>
References: <alpine.LRH.2.02.1808301053240.10353@file01.intranet.prod.int.rdu2.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4dbd3e39-f9c1-467a-8937-f55b01a639a2@kernel.dk>
Date:   Thu, 30 Aug 2018 09:06:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1808301053240.10353@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/18 8:58 AM, Mikulas Patocka wrote:
> I report this deadlock in writeback throttling.
> 
> The deadlock happened in guest virtual machine with Debian kernel 4.17.17 
> (4.17.0-3-amd64). The virtual machine had most of its memory swapped out, 
> when I tried to shut it down, I got this deadlock. There was no io in 
> flight.

Not very helpful for your case, but this should be fixed in Linus's
current tree. I've got a few pending fixes still, but they will be
going upstream for 4.19-rc2.

-- 
Jens Axboe

