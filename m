Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA6BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573DC20661
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573DC20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeHUTmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:42:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39587 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeHUTmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 15:42:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id q8-v6so3381920wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 09:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8SOsqEf0nG+yo2apmC+u5cN2gkaePAnJLdHpec20pWk=;
        b=XgXc7c+yq7B8v13hyHJXjEZmzxxNO2khU2ksZgEQlID7waleSz3eEJz06xGtQPMzPk
         gNe1QwaeJyidpNzGO37hPlp1Xd76fBSl2rfFZIEZ+PSUs9iU7L0Xe+st2ftiA0Jv4lLj
         cbDk92ifwYjIp28kr2lByY+iIWCzR0yki1Qtx8t3mkn5jpVlK3AnPjOHkX97gtHSKaIL
         1aG2lSVf1ITyDw+qXE5cpMBedxnGnaRbjZcLkmxhWqpyjXbfApv4SVMds8Hv3/2al/1y
         PUaQTpJO4Atxu4DUDJ/L3bjkA8xlJVsMsWrKVhCTOcLVm1e8AR4sfTYLCbj9lnesqEtg
         mgSQ==
X-Gm-Message-State: APzg51A/uGV7xzcq3kHLVvtkWUFql59jTyZEXOY2vuoDz75Y790xngYQ
        oJSEEyxhdFM4oNFjnCP6fkg=
X-Google-Smtp-Source: ANB0VdYK2PKkizGMfSFzNCOhQdqv6zLkAbIl+Ef3hOKexUHLIbjWy3RzOTKBpS0Ze6PiKkWmrMAC5Q==
X-Received: by 2002:a1c:9d0b:: with SMTP id g11-v6mr54611wme.78.1534868483897;
        Tue, 21 Aug 2018 09:21:23 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id v16-v6sm11411753wrw.12.2018.08.21.09.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 09:21:23 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 7C01A1249D0; Tue, 21 Aug 2018 18:21:22 +0200 (CEST)
Date:   Tue, 21 Aug 2018 18:21:22 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, Pavel.Tatashin@microsoft.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v4 0/4] Refactoring for
 remove_memory_section/unregister_mem_sect_under_nodes
Message-ID: <20180821162122.GA10300@techadventures.net>
References: <20180817090017.17610-1-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817090017.17610-1-osalvador@techadventures.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 11:00:13AM +0200, Oscar Salvador wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> v3 -> v4:
>         - Make nodemask_t a stack variable
>         - Added Reviewed-by from David and Pavel
> 
> v2 -> v3:
>         - NODEMASK_FREE can deal with NULL pointers, so do not
>           make it conditional (by David).
>         - Split up node_online's check patch (David's suggestion)
>         - Added Reviewed-by from Andrew and David
>         - Fix checkpath.pl warnings

Andrew, will you pick up this patchset?
I saw that v3 was removed from the -mm tree because it was about
to be updated with a new version (this one), but I am not sure if
anything wrong happened.

Thanks
-- 
Oscar Salvador
SUSE L3
