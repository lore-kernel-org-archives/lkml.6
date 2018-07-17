Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620C9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6FE20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6FE20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbeGQMQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:16:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54541 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731079AbeGQMQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:16:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so1169060wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ng9DjlKpCQIcUnhZK8smGvCYDUI86x4GbUZwhxUMYI=;
        b=hkSJrdBzc1N9Uv/V3Esk5XNx8+jANSkf7s19Upm+pptnYkOftmfHveF8Fc7twHlqSx
         p22sR5LGgfzG9sIYhxTqpLqrngS3J7L71yOpicGIoX4WvORywyJsPuteBwZtsjo9KECL
         US0aHbGDsOZ0aUVsgYRWTwXRygPGMZn2je0SrE2Iuv54rj5DzsKowPD6bJ0lYtOyyriC
         7AqeAqrIomeyGPsA4mlpFQVCnuhil/judDHlqwSYrZ9sME+3+NHh23l1Q6JpAb76hW3D
         dwcK4d3h0iLHmPBaEc9gDNbC7ger4MuoxKpy7QOQ+EyaFf+ElQVZE/URYNMYMtAMphX+
         Govw==
X-Gm-Message-State: AOUpUlGQgkS4xii54XJxBZO2gc/h3IOH73bxTQQorADWBIoqaSvKi+4x
        kXR4zVu4VnxX0DQ7XdHKrEQ=
X-Google-Smtp-Source: AAOMgpdQn10CbQZJ8ZtRwRyJSnKB1l/XC0VpbwgxJNMNiFYWlBdSoEKq6tNh5PD4m8rPMhzjh3rBEQ==
X-Received: by 2002:a1c:1a02:: with SMTP id a2-v6mr1249487wma.52.1531827858488;
        Tue, 17 Jul 2018 04:44:18 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id b6-v6sm1401762wru.66.2018.07.17.04.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 04:44:17 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 0B983124018; Tue, 17 Jul 2018 13:44:17 +0200 (CEST)
Date:   Tue, 17 Jul 2018 13:44:17 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, dan.j.williams@intel.com, jack@suse.cz,
        jglisse@redhat.com, jrdr.linux@gmail.com, bhe@redhat.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, abdhalee@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH v6 5/5] mm/sparse: delete old sparse_init and enable new
 one
Message-ID: <20180717114417.GA24361@techadventures.net>
References: <20180716174447.14529-1-pasha.tatashin@oracle.com>
 <20180716174447.14529-6-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716174447.14529-6-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 01:44:47PM -0400, Pavel Tatashin wrote:
> Rename new_sparse_init() to sparse_init() which enables it.  Delete old
> sparse_init() and all the code that became obsolete with.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

I tested it also with a powerpc vm.
And as I said, the code becomes much more clean now.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks
-- 
Oscar Salvador
SUSE L3
