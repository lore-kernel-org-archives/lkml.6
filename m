Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171D0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DD321780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DD321780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbeKOT7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:59:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728634AbeKOT7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:59:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47C34A0C02;
        Thu, 15 Nov 2018 09:52:35 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C0BB1057058;
        Thu, 15 Nov 2018 09:52:28 +0000 (UTC)
Date:   Thu, 15 Nov 2018 17:52:25 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        aarcange@redhat.com
Subject: Re: Memory hotplug softlock issue
Message-ID: <20181115095225.GO2653@MiWiFi-R3L-srv>
References: <20181114070909.GB2653@MiWiFi-R3L-srv>
 <5a6c6d6b-ebcd-8bfa-d6e0-4312bfe86586@redhat.com>
 <20181114090134.GG23419@dhcp22.suse.cz>
 <20181114145250.GE2653@MiWiFi-R3L-srv>
 <20181114150029.GY23419@dhcp22.suse.cz>
 <20181115051034.GK2653@MiWiFi-R3L-srv>
 <20181115073052.GA23831@dhcp22.suse.cz>
 <20181115075349.GL2653@MiWiFi-R3L-srv>
 <20181115083055.GD23831@dhcp22.suse.cz>
 <a1d4aa33-5c6d-1a6d-1426-46b2cebbf57e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1d4aa33-5c6d-1a6d-1426-46b2cebbf57e@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 15 Nov 2018 09:52:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 at 10:42am, David Hildenbrand wrote:
> I am wondering why it is always the last memory block of that device
> (and even that node). Coincidence?

I remember one or two times it's the last 6G or 4G which stall there,
the size of memory block is 2G. But most of time it's the last memory
block. And from the debug printing added by Michal's patch, it's the
stress program itself which owns the migrating page and loop forvever
there.
