Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBB4ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A81D2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A81D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbeGRLO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:14:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:60002 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728304AbeGRLO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:14:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75B44AD97;
        Wed, 18 Jul 2018 10:37:11 +0000 (UTC)
Date:   Wed, 18 Jul 2018 12:37:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Frank <david_frank95@yahoo.com>
Cc:     Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: mmap with huge page
Message-ID: <20180718103709.GB1431@dhcp22.suse.cz>
References: <115606142.5883850.1531854314452.ref@mail.yahoo.com>
 <115606142.5883850.1531854314452@mail.yahoo.com>
 <3b40325e-a75e-017d-920e-83e090153621@oracle.com>
 <1485529317.61381.1531872070328@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1485529317.61381.1531872070328@mail.yahoo.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-07-18 00:01:10, David Frank wrote:
>  Thanks Mike.  I read the doc, which is not explicit on the non used file taking up huge page count 

What do you consider non user file? The file contains a data somebody
might want to read later. You cannot simply remove it. This is not
different to any other in memory filesystem (e.g. tmpfs, ramfs)
-- 
Michal Hocko
SUSE Labs
