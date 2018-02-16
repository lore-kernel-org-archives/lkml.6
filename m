Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518772388; cv=none;
        d=google.com; s=arc-20160816;
        b=eiLTn5RHoiZT2oqTTD3UFN4TMXQwXV6DyiXTjNvV2rT/4Vf7XqQhK9J6ENojgk1AF1
         u5b4H3fQa2nqSnnyuVZvkDFtMCXC24I9KMTwivMPjZS1x4YfyjrTObjvXIbSGkbphUBQ
         BhGTdeJnVWDN+DqPQ37Pn2MSgzt2KhUY9041TDt33aDJEZF//LH5gjtNIKopJYp+Xphi
         9BkVhkCxOTSbBl3yAGXiLhXpwnKhN7xcJYDOmPfU68WLtqftDTjdoN15TrhnnMNNmWnH
         2/5vxjt4rgddvw7k4n0xtd2BGnE42qv2U5U6L8AHE0TVwWoSwhMz+TsAhmlnyrB9thJq
         +fCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=+cgxqvJSCv47lvw0QQcx+yklcSd7brHyV7K9mYsUhJo=;
        b=pKvb3NiFPSJ1sYeoGh0v6iVONGq4/hHsMBo2f5uGHyCCf9G90UwefSHLQsmL9ImLYv
         9X8UvAml79gjr/AHX8yBGxotCp1hxvrRaBT5j+yc1HUYgyDtqttszXn45UWcsCm24Naw
         rc5OuPNndNG5Fmow2zw6mflT+Cd5u15rFV6yRnWe3g/0W5aL6O8bJ1Nw3WSZ9dpL/Exu
         GaGKUQFCGk91BDdYWAwPa2D+axFOE9Hqq0VPN8OcaU+gLiWZuo58MuXF+67wmEknlx5d
         mOHkIEI7Ou82154FMVkuJ3+7DrI9Acr1LEqXKXNry0y4ehNz8zKIoA1+jr7SQX1IS8Ng
         G23Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UMNnuYiW;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UMNnuYiW;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AH8x226ju5LEczCxmuaQ7KOa0ZoQNJIvRpAn406d8nLQ9UU1gDqVzEK8mlc4mD/yb7TUKelAWsoDFw==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 16 Feb 2018 10:13:04 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
	akpm@linux-foundation.org, mgorman@techsingularity.net,
	mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, vbabka@suse.cz,
	bharata@linux.vnet.ibm.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, dan.j.williams@intel.com,
	kirill.shutemov@linux.intel.com, bhe@redhat.com
Subject: Re: [v4 4/6] mm/memory_hotplug: optimize probe routine
Message-ID: <20180216091304.hgp5tn25nleuy4jc@gmail.com>
References: <20180215165920.8570-1-pasha.tatashin@oracle.com>
 <20180215165920.8570-5-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215165920.8570-5-pasha.tatashin@oracle.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592487036268722701?=
X-GMAIL-MSGID: =?utf-8?q?1592548276397874581?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> When memory is hotplugged pages_correctly_reserved() is called to verify
> that the added memory is present, this routine traverses through every
> struct page and verifies that PageReserved() is set. This is a slow
> operation especially if a large amount of memory is added.
> 
> Instead of checking every page, it is enough to simply check that the
> section is present, has mapping (struct page array is allocated), and the
> mapping is online.
> 
> In addition, we should not excpect that probe routine sets flags in struct
> page, as the struct pages have not yet been initialized. The initialization
> should be done in __init_single_page(), the same as during boot.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
