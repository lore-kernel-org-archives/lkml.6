Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A0C9DC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54900208B4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyzoEgos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54900208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936030AbeFMO7S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:59:18 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33766 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935703AbeFMO7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:59:13 -0400
Received: by mail-qt0-f195.google.com with SMTP id l10-v6so2651046qtj.0;
        Wed, 13 Jun 2018 07:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vPYQmn38TWAdLMFjIVz1HKFrLck0AwlQe4a+ZoD3ZB0=;
        b=qyzoEgosKxftDllheHmhUZw4z45y/jR3FH7YPMnNhdVlleMSXjqAnawKjyLDvF0gGj
         iNJ3Ti91LDt5IfuJ5E5kYoFPR/opa2JjR6do+9736h+ciy68UZonDGfqHUkSV110s6BR
         WGOhR76Td2T+3YID7SoUiYZV8WZcqdR0CLyv67eBVHgIZ0AaEbsLY5XWJNmA/PvuI7Ql
         L3U+77KLwX/lwDRtSRlq2yMoOy4OvHgAe/DF3V64MbUMAepmgGvgNcfYM0Xb5tdUjETb
         wIirrkMepk28m5Eg978TffXzzUcb2Un/oDUtz0mAuX9d13hkVyMBckR99SafbLQSXhqA
         aSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vPYQmn38TWAdLMFjIVz1HKFrLck0AwlQe4a+ZoD3ZB0=;
        b=hotBTWCrwJiV/dH+FitqKE83BYcsPx63p1+66xi3x3qkWKNe8BAHUCRbjeRs/M71Qw
         uo6XStC/9v4WxbGd9lgkTbXfJ1664jqV6GYQL/9XQzQSmc0HvdhFdb8vHy0cnaGx8Lrc
         9qJaOFUhLux1wi3AKOyZRvpKvBU/kH3dYWfy0czJgnmBJGKp3Nk1/Tkf5RrpyS2OntL8
         UoQkghxooyU1zHY0xYhgNxxIramVd2I55Mi+9OM8DKE6Ok+HX9KiwFZAVMPbOoqibHCC
         h7b1BdRQ/5M7ZnOnevG8seVon/UMfAKYJpct3PH5LAYX9hrc16HQ8cDeDNdN7uANL4Cr
         cj1g==
X-Gm-Message-State: APt69E1XERKm0NnRvT+P7V4fsJQeooZFfOsjms+wgUa0Oi+vp17ogm2+
        pcppRX8kExsxHTm2MV9ISw==
X-Google-Smtp-Source: ADUXVKKdd4fjWgHF17BOhI7W5jbaiSwSKNnHZUhbZ0KNYE3z6d/nLG7qwePOP+CIOBvLnEPvsAnY5w==
X-Received: by 2002:a0c:e50b:: with SMTP id l11-v6mr4749049qvm.21.1528901952305;
        Wed, 13 Jun 2018 07:59:12 -0700 (PDT)
Received: from kmo-pixel (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id w6-v6sm2361002qtj.71.2018.06.13.07.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 07:59:11 -0700 (PDT)
Date:   Wed, 13 Jun 2018 10:59:08 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V6 00/30] block: support multipage bvec
Message-ID: <20180613145908.GB17340@kmo-pixel>
References: <20180609123014.8861-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609123014.8861-1-ming.lei@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 08:29:44PM +0800, Ming Lei wrote:
> Hi,
> 
> This patchset brings multipage bvec into block layer:

Ming, what's going on with the chunk naming? I haven't been paying attention
because it feels like it's turned into bike shedding, but I just saw something
about a 3rd way of iterating over bios? (page/segment/chunk...?)
