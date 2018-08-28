Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B414EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650562086B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650562086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeH1Pqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:46:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35745 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeH1Pqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:46:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so1319501wre.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 04:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aOhOmQ7KozJr/tnlsUFDnnrZC1shDLuFu6ssGLylzuI=;
        b=ggSLNyiSqdwOpzEZ5waY6Unrwnl9ZIXwVOZOLtPDuHA80LAhdEsCKL+DQCtgnPBdsI
         MlE9eqFaAOZnlHQdkU7V5PinRMs8G6o5pW17vyXHkqP+CJpwvzQkZo9PP1HVhYyfRsXZ
         ZsDdV25PXGywT0QVxqbt0PNMmQ/Y4C7smvw/K/YVDTHeYuYDBNAL4OkkCW7I2PWeeXUH
         a4XVaL5uCWsfZ8XUbyCjydoN8myNTAFBHWZsjVQGPYNB2taA0RBq3fmXmsdRiUoRuGNx
         AuKB7YLb99UMXbTJA43W7k3BDeWOYqvbSmC/mJeTFu6zXrGwf7axRopdlqF2VUOvwrZi
         lz8A==
X-Gm-Message-State: APzg51BoL3qh7UMfSfaGRyaSUlu/eSExy15XEdWES3fZ21mXjeIDiOQ/
        N76X4x+u+IDgS0Kw7ilTxUE=
X-Google-Smtp-Source: ANB0VdZyH3pYnbohtchgaqEH7jrBLiKoDzr5LZzwZnm6iZdhcYVPVEpGOkAKkkrnrO/4X72kalQWfA==
X-Received: by 2002:a5d:528f:: with SMTP id c15-v6mr943070wrv.102.1535457286029;
        Tue, 28 Aug 2018 04:54:46 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id 185-v6sm2083509wmy.38.2018.08.28.04.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 04:54:45 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id C8A4F124BC3; Tue, 28 Aug 2018 13:54:44 +0200 (CEST)
Date:   Tue, 28 Aug 2018 13:54:44 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, Pavel.Tatashin@microsoft.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v4 3/4] mm/memory_hotplug: Define nodemask_t as a stack
 variable
Message-ID: <20180828115444.GB13859@techadventures.net>
References: <20180817090017.17610-1-osalvador@techadventures.net>
 <20180817090017.17610-4-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817090017.17610-4-osalvador@techadventures.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 11:00:16AM +0200, Oscar Salvador wrote:
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Pavel, could you please review this?
AFAIK, the change made sense to you.

Andrew was about to take the patchset after the merge window,
but I think that a Reviewed-by would still make sense.

Thanks
-- 
Oscar Salvador
SUSE L3
