Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627F0C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C64020875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C64020875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeJEONs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:13:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55238 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbeJEONs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:13:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so823248wma.4;
        Fri, 05 Oct 2018 00:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aR/jC4H+BZ2o9lgfz0G0A5l8xgrll1yDCKPstbspgPM=;
        b=SwATTlTXtMc3TRAcFtD3b/tEhV30IdMqcwpDMbqE9fLhRQ6BATg/Sn4HlZJ0e8IOaN
         dfkF7vOATf9iXOisZ0bo0u10cLJeKk1jbGbwcOywh+8vdMrh+8GLlfz8krW76vtchtoQ
         dWpEEDjowFgLn38zycbF3AT9rMpQYxLdx9G2r6XwfEafAWS3vc5Qlgsj6eiLIV1snTSk
         1ZTFmA6ejxygC10I/83Xdocmk65VM4tjnyEgWTxkJOYKPhJ5Zxq53W3BsunbQhxez8HW
         D2BcgpYeZAIxILZQ1zzGBW0H0h8HX5G9pPS7VSXDeNbgxKR1P44TPos0R/dp4tDvQBak
         rWTw==
X-Gm-Message-State: ABuFfoglnbGMuUAoIn2dyI9Nd3Lb/sucHCLF6r7ljAUyA82KYhvpsL7d
        bZlP8I/E/+nvBZqx1xjzCFo=
X-Google-Smtp-Source: ACcGV62rkvQfaVax3+CKM4rI6dVZO/x+jQfOoQhQf86qnRsCE72Jcct7LW309FM0eBE/dW53ziii+Q==
X-Received: by 2002:a1c:e5cf:: with SMTP id c198-v6mr7001829wmh.113.1538723783664;
        Fri, 05 Oct 2018 00:16:23 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id j203-v6sm940598wmd.46.2018.10.05.00.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 00:16:23 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 7C2F7125828; Fri,  5 Oct 2018 09:16:22 +0200 (CEST)
Date:   Fri, 5 Oct 2018 09:16:22 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
        devel@linuxdriverproject.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        John Allen <jallen@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mathieu Malaterre <malat@debian.org>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>
Subject: Re: [PATCH v3 2/6] mm/memory_hotplug: make add_memory() take the
 device_hotplug_lock
Message-ID: <20181005071622.GD27754@techadventures.net>
References: <20180927092554.13567-1-david@redhat.com>
 <20180927092554.13567-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927092554.13567-3-david@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:25:50AM +0200, David Hildenbrand wrote:
> Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
