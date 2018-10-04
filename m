Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C0DC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FBE2082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivGKlnCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FBE2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeJDXaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:30:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43886 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeJDXaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:30:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id 80-v6so3392548pgh.10;
        Thu, 04 Oct 2018 09:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hSVmlMpOF9MR9Zhyi26JOa6/K3JQoTbT4VR4wno1ZhQ=;
        b=ivGKlnCBs71I4VWjkQcd7bx6P82l0lE4TUK8IaoEdK8BBSK4Cgz5p5wPGxfTSYfIX3
         KNTRw4QAyE51abzgoloy9F9BBqg1uAwIUctd67PLSpmsusobqt5eWLAXFrnFd06RwJkQ
         oh4SU9ZFC4cv8Kz8COYQ4FPXYoA8YtOx8nbbM1a1Or6nB5/N/Ci6xiO19xs63rNaJyfb
         qGIeaHazY/Ss0BPt0Ec3Q081sKJ74Orgy+NWZmLIzO6jwOHUjDX0/Fky0Dihv796Br4A
         JosGyN3ahyVe/MM9V6EUWj+tYrWNg+K0i0Qzd2cKT3aJMoCy1P3cNb46fPGY79PTQJlE
         V6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hSVmlMpOF9MR9Zhyi26JOa6/K3JQoTbT4VR4wno1ZhQ=;
        b=pP+Ndz4l3rX+SH3M3N23c+QyK73rw8UlmXScF0/fqwGWdlZztPav4lNLXBrg9LT/cj
         fcYg60XbLnzBBbOqy7ASwP3YfK5bBnQ/SxJFvj6xBfwFWzrMi0K/OBg7iJOXixOJ59dn
         yKNUow/FvCa5zTXU9cUSNkfe6fxPwA5WOJY3KCl2BnRAyt5pi3/KCTOXVlPQ217ItgT/
         saCdO8ISTI53KAr4m4fqSYEE6d1hIc/ofFUhmQqKne5H1TEX4PjNn/W/2ZnkvaXo47Qh
         +FVDu62tZfS3sKGbIRWcYr7Uxstt51zPitbx5zWHW0Y5Lic6UA3qrOgP6s77Blri2Ol4
         pSzA==
X-Gm-Message-State: ABuFfogugq6ccXR0e5Awhg7QCUeXyN/vaBlLhLen3GEQq7NoVRpVFavZ
        lkwGwS9nE/vk0RjdQe5cjgleNBVv
X-Google-Smtp-Source: ACcGV61ICQW3scHG57+jK9BxpI53uR4dKmOHbZ69YSL4xa0mBf1t/wOv7Mdk5kiU/5FZl80HoelLgQ==
X-Received: by 2002:a63:f848:: with SMTP id v8-v6mr6344229pgj.82.1538670977469;
        Thu, 04 Oct 2018 09:36:17 -0700 (PDT)
Received: from ?IPv6:2601:282:800:fd80:ac60:4714:28e3:3fec? ([2601:282:800:fd80:ac60:4714:28e3:3fec])
        by smtp.googlemail.com with ESMTPSA id 72-v6sm9658036pfr.115.2018.10.04.09.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 09:36:16 -0700 (PDT)
Subject: Re: [PATCH net-next] udp: Add tracepoints to monitor skbs going in
 and out of a UDP socket
To:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
References: <153864184110.20296.16498481420320274305.stgit@warthog.procyon.org.uk>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <f4d5ec71-b09a-84fa-599e-d0482cdb77b7@gmail.com>
Date:   Thu, 4 Oct 2018 10:36:15 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153864184110.20296.16498481420320274305.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/18 2:30 AM, David Howells wrote:
> Add three tracepoints to the UDP/UDP6 code to trace three aspects of
> sk_buff handling:
> 
>  (1) UDP packets that are about to be handed off to the IP layer to be
>      transmitted.
> 
>  (2) UDP packets that have just arrived at the socket.

These do not add any real value. You are only dumping the skb address,
and you can get the same effect with a probe on the function and dumping
the value of the register with the skb argument.
