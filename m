Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5011C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 01:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0372145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 01:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUBf3gm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0372145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbeIYHcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 03:32:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38550 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeIYHcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 03:32:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so10015633pfh.5;
        Mon, 24 Sep 2018 18:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M4PwrHUuI2b/M7dL2jAXZ4BB/+ald6SXCbxfEMvGrsc=;
        b=IUBf3gm7q3bUtQ5rWk8zreGhJDaWnV+0NB9wx3fIez+Pc1f76L9vqqgw/WXg5w+3Ti
         eGq0bPnKDuVeiYD1S+/TPXFrBous9+8dlYc73mx5NbU6SLGUo2WNMfJBQwV1lzd6u6De
         c0SnyhYttmQz+aj49TSsR8vrVrBZynTvOt/efm152jrISf/sZZ/hYtQVPH4ZUeKFqNGE
         3YC6vo1El2FgwkZN9/9Qg7JVW0ndRKrkxXAbZ937Ztv/yMAb9Q3gCGaDiSVrg/ZNjj+g
         KHdrJR5VLtxK29h9PeQ3FVWuWj5xpfutAOcjxfJwPGLaynLNoNdFFzevGbfHzXCZM8f+
         L+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M4PwrHUuI2b/M7dL2jAXZ4BB/+ald6SXCbxfEMvGrsc=;
        b=lcxXlnkOc2zsngTPQCk/d/G+FqFH+V4KCeGpHdvsjyrv1qktuEgizO7CZYsQeh7JzP
         E2Ixia9O2P5CUZZ4ZQi59pW+l08tCpQepwCrrprY8ewNONmpWaL14ah09yEr0+WbxBNz
         MzubHqD6jBvz1MR+3jRQdT89GqV/Rp9+tJazixxtir9W0LRiH3OCU8uSYkymXge7VyAQ
         IhHw57+wvRUlvLS7tIL6pIWK8ucc7aFxm6eWFFr0P06SVUJzRytNwBFkRZKy/OXt+o6Z
         ElHuZo7c0b1hwY/Ty2yvA2+ezLcsN/+jMihptkubJFo/dq03CiDTctNIrbuPGKW978Zq
         8UGg==
X-Gm-Message-State: ABuFfog/gBFa30oncl4oyAs4MhEszgxhZjaKaITa5KcoA2S+RJQpckdO
        d+dxi3H/CndWFB9t7IMNt+M=
X-Google-Smtp-Source: ACcGV61cXfBZCxvEJHAXIB1m3DIg/xFLrDvRJVzyWODAo/Z9SPs7BJb8P5NLF8irg1mTB6F7yGbEuA==
X-Received: by 2002:a17:902:744c:: with SMTP id e12-v6mr1143723plt.186.1537838824711;
        Mon, 24 Sep 2018 18:27:04 -0700 (PDT)
Received: from rohan.ozlabs.ibm.com ([122.99.82.10])
        by smtp.googlemail.com with ESMTPSA id 3-v6sm787339pfq.10.2018.09.24.18.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 18:27:03 -0700 (PDT)
Message-ID: <1537838811.10753.2.camel@gmail.com>
Subject: Re: [PATCH RFCv2 3/6] mm/memory_hotplug: fix online/offline_pages
 called w.o. mem_hotplug_lock
From:   Rashmica Gupta <rashmica.g@gmail.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        xen-devel@lists.xenproject.org, devel@linuxdriverproject.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Neuling <mikey@neuling.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Mathieu Malaterre <malat@debian.org>
Date:   Tue, 25 Sep 2018 11:26:51 +1000
In-Reply-To: <5f80ca56-9f34-4e6e-bc83-8f8b3c888163@redhat.com>
References: <20180821104418.12710-1-david@redhat.com>
         <20180821104418.12710-4-david@redhat.com>
         <70372ef5-e332-6c07-f08c-50f8808bde6d@gmail.com>
         <5f80ca56-9f34-4e6e-bc83-8f8b3c888163@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-17 at 09:32 +0200, David Hildenbrand wrote:
> Am 03.09.18 um 02:36 schrieb Rashmica:
> > Hi David,
> > 
> > 
> > On 21/08/18 20:44, David Hildenbrand wrote:
> > 
> > > There seem to be some problems as result of 30467e0b3be ("mm,
> > > hotplug:
> > > fix concurrent memory hot-add deadlock"), which tried to fix a
> > > possible
> > > lock inversion reported and discussed in [1] due to the two locks
> > > 	a) device_lock()
> > > 	b) mem_hotplug_lock
> > > 
> > > While add_memory() first takes b), followed by a) during
> > > bus_probe_device(), onlining of memory from user space first took
> > > b),
> > > followed by a), exposing a possible deadlock.
> > 
> > Do you mean "onlining of memory from user space first took a),
> > followed by b)"? 
> 
> Very right, thanks.
> 
> > 
> > > In [1], and it was decided to not make use of
> > > device_hotplug_lock, but
> > > rather to enforce a locking order.
> > > 
> > > The problems I spotted related to this:
> > > 
> > > 1. Memory block device attributes: While .state first calls
> > >    mem_hotplug_begin() and the calls device_online() - which
> > > takes
> > >    device_lock() - .online does no longer call
> > > mem_hotplug_begin(), so
> > >    effectively calls online_pages() without mem_hotplug_lock.
> > > 
> > > 2. device_online() should be called under device_hotplug_lock,
> > > however
> > >    onlining memory during add_memory() does not take care of
> > > that.
> > > 
> > > In addition, I think there is also something wrong about the
> > > locking in
> > > 
> > > 3. arch/powerpc/platforms/powernv/memtrace.c calls
> > > offline_pages()
> > >    without locks. This was introduced after 30467e0b3be. And
> > > skimming over
> > >    the code, I assume it could need some more care in regards to
> > > locking
> > >    (e.g. device_online() called without device_hotplug_lock - but
> > > I'll
> > >    not touch that for now).
> > 
> > Can you mention that you fixed this in later patches?
> 
> Sure!
> 
> > 
> > 
> > The series looks good to me. Feel free to add my reviewed-by:
> > 
> > Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
> > 
> 
> Thanks, r-b only for this patch or all of the series?

Sorry, I somehow missed this. To all of the series.
> 
