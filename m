Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309A4C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43382146D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yq/kXer+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43382146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeIMAiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:38:24 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36313 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbeIMAiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:38:24 -0400
Received: by mail-it0-f67.google.com with SMTP id u13-v6so4685462iti.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 12:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UNI2SYoZLDDKmylnaA20rvKZ5oEcEoJyOeh7Sr+MyKE=;
        b=Yq/kXer+LpM7ruU69bxhxDXjjg2yxOPyQ5ZQbexrVsCB2AHX5mk+PD2i51s6jR/RCg
         h6Rqz1qO4CX97KtdKsiVi4cZFeRXRZKeL9Ux3yvvY3IcH3iwkv8N7OpHdMAyyiyIPXJ/
         8n4m9CEyAwthwzRQwgc6ayyHkWSLhi38GF6NxA7cQ4CuVmljIIVhNz2IME1uuyeh9/En
         2vGQs/WOrJWe0c/l/IGDmlanp2rDIBDYyukKxWncRkZRlr6kaNcjyy5WtFM6b3NBGo/O
         unXX/tOaRIFrv1UG1BhrX+WjWs2p0+lFDLW69W/MQFoATxbVz+2V4+jBqAIRJZUAbbLt
         lzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UNI2SYoZLDDKmylnaA20rvKZ5oEcEoJyOeh7Sr+MyKE=;
        b=f/+NCoI5ty7P72CFH/AJmK3xN5wQIFqxt48gtdUGChvMNBulpDY/SkVRseRY5jOnMk
         5u0MTL4iu7hInWx4HknoXXQbu9RogU8DkGpJB9eOLpFgp4Fwn8aRtK2AHVI3iaVU9aqa
         B49HzR7nS5F1Qbp8YUQ1Rl7ykEO/IGg3M56UVUPsfjSfFnIBHAzLBbNn3Fr7Q/D0ej7F
         1ZRIjM7KgVezWDTc9QNXtoEi5ttL9HjwByiX7Iw0lBT3UZcMAVFFokkEAo+cktPgHA+N
         439wDCsBJymh6Qj4UV0moYHWRv2zhOcHs91sdfHC+6OVnH6UzQC5PNrNlXrgns4utz8C
         AKGA==
X-Gm-Message-State: APzg51D4NF9pGNpM+IlF5Zdb2p9IsZ8yDBXYWgsDMLzaU0DTxX3kadX4
        en7PDu7LMyu7i/h7VsxKHsIE0Q==
X-Google-Smtp-Source: ANB0VdZsYrbcxKqgxq95TQyp9LJ9syMVJIGymvRUBKN+KhL6DFuRf8Ocfrc+93ayBK+6WwukoBfmCg==
X-Received: by 2002:a24:e349:: with SMTP id d70-v6mr3395190ith.75.1536780744398;
        Wed, 12 Sep 2018 12:32:24 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id k62-v6sm1274851itc.21.2018.09.12.12.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 12:32:23 -0700 (PDT)
Date:   Wed, 12 Sep 2018 13:32:21 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Revert "ASoC: Intel: Skylake: Acquire irq after
 RIRB allocation"
Message-ID: <20180912193221.GA194302@google.com>
References: <20180910211718.200802-1-yuzhao@google.com>
 <20180911211246.31914-1-yuzhao@google.com>
 <20180912102020.GB6062@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912102020.GB6062@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 11:20:20AM +0100, Mark Brown wrote:
> On Tue, Sep 11, 2018 at 03:12:46PM -0600, Yu Zhao wrote:
> > This reverts commit 12eeeb4f4733bbc4481d01df35933fc15beb8b19.
> > 
> > The patch doesn't fix accessing memory with null pointer in
> > skl_interrupt().
> 
> Please use normal subject lines and so on even for revert patches -
> they're patches just the same as any other.

Well, they seem pretty normal to me, and have been used by many:

  commit 82ab86e82911107ead6fc7cd73568f75bc266a57
  Author: Mark Brown <broonie@kernel.org>
  Date:   Mon Oct 30 19:40:25 2017 +0000
  
      Revert "ASoC: rt5651: Enable jack detection on JD* pins"
      
      This reverts commit 60d5a1a47b9a8381c08d2263b11ac9c757c87746.
      
      Signed-off-by: Mark Brown <broonie@kernel.org>

Anyway, I'll update them in v3.
