Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91345160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D24020890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmTlS9M6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D24020890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeG3Q61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:58:27 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:39374 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeG3Q61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:58:27 -0400
Received: by mail-yw0-f182.google.com with SMTP id r184-v6so4491478ywg.6;
        Mon, 30 Jul 2018 08:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fqG4GN54zH/d7gXhAUc1ddMWmOp+7U3AnaNCcJ6XUVw=;
        b=BmTlS9M6DxCuPTeABudLx9fRjRXkWjKYLz1FpsLh0jb3yTusYoyydsU8cWkGXsPpGb
         1MR/4w3VdiumJ/uY4+UkF/Oa2JtXXesDHdwWgZokG2ve7MGk7UeMZXtSB0P4/+QhDUZg
         iQOJUzs4twSgmpTeIrDITzL6QgU5c4wZbJJwDbkWIlaIgSGSH3quWG7aeDpBq8T+kA7+
         L/6pZ2LA52OLQsoXeibwQS0D11s1LVNR9k/6BJuYge4tuAeSlKEr1vMuGSBXRv0aKXxX
         h9aMuUrVU4YZNYq+MWHUwLFf6GEN+KZC7skjn2p73rDL3JOnn1sHv/ClmAKvDLu+XMkA
         gHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fqG4GN54zH/d7gXhAUc1ddMWmOp+7U3AnaNCcJ6XUVw=;
        b=qIXUnovA2VEUHcYtODjkBYOJlXeFY1EdB5lfEvIyAy+PJ65hcLXytu9I+n62x4MBsi
         R5sjF5t+OlfIT/KwDk7v9w53orAFAbtpmdOSTVv31DCjwePL/UYb1NJWycqElniE1Q8Y
         s43XrrTV2R0bdKnPD5FkF416E1AuhexBE0L8Ty+F5bDNX9ftozpkfeLPElD4xCHOxlgK
         LFJkxcpIurHwA9odnsnBf6H+cYaG59v6J9mD9FCN1orf/m8wgWWB02dCQf8n3z10reI4
         0EEQoNSvEKvHnwvTv8kK/f/bO4hf0eqNAUqW9q/WnAcbffukNQXIDfTNvB8Niw9bZLdB
         AY1g==
X-Gm-Message-State: AOUpUlFCH14PNjV7nnwgFLwPuLCGnJBhOvi8ShRttRvdtxKomX/HXOX5
        KiVAhL2+kI5LNUEb9DVPKnOv9Nqd
X-Google-Smtp-Source: AAOMgpfyvDXQdrlIHJU59UjUIdzXyGJgbIlaOofc2t99WnctknjTuJ+7QumHiJtR5ySEIjgmnXtV1A==
X-Received: by 2002:a81:6bc6:: with SMTP id g189-v6mr8885289ywc.267.1532964178685;
        Mon, 30 Jul 2018 08:22:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:4bfe])
        by smtp.gmail.com with ESMTPSA id c203-v6sm7221329ywc.26.2018.07.30.08.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 08:22:57 -0700 (PDT)
Date:   Mon, 30 Jul 2018 08:22:56 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     hdegoede@redhat.com, rjw@rjwysocki.net, alan.cox@intel.com,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ata: libahci: devslp fixes
Message-ID: <20180730152256.GF1206094@devbig004.ftw2.facebook.com>
References: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
 <9712316ab62bef25953c523bce02e260a9ea40fe.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9712316ab62bef25953c523bce02e260a9ea40fe.camel@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 08:15:47AM -0700, Srinivas Pandruvada wrote:
> Hi Tejan,
> 
> On Mon, 2018-07-02 at 12:01 -0700, Srinivas Pandruvada wrote:
> > Some minor fixes to be able to correctly set devslp register
> > to optimize power.
> > 
> > Srinivas Pandruvada (2):
> >   ata: libahci: Correct setting of DEVSLP register
> >   ata: libahci: Allow reconfigure of DEVSLP register
> > 
> Are you applying this series?

I was waiting for Hans's reviews.  Hans, what do you think?

Thanks.

-- 
tejun
