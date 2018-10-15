Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD68C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C9320644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C9320644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJOWLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:11:43 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:52808 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbeJOWLn (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 15 Oct 2018 18:11:43 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Mon, 15 Oct 2018 16:26:11 +0200
Received: from [192.168.1.2] (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Mon, 15 Oct 2018 15:26:02 +0100
Message-ID: <b0b793a6cdfd634e126fbb00554ca68a780a00bd.camel@suse.com>
Subject: Re: [PATCH v2] xen/blkfront: avoid NULL blkfront_info dereference
 on device removal
From:   Vasilis Liaskovitis <vliaskovitis@suse.com>
To:     Roger Pau =?ISO-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, axboe@kernel.dk
Date:   Mon, 15 Oct 2018 16:25:56 +0200
In-Reply-To: <20181015140201.elir7ettk7sz4aix@mac.bytemobile.com>
References: <20181015132508.23293-1-vliaskovitis@suse.com>
         <20181015140201.elir7ettk7sz4aix@mac.bytemobile.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-15 at 16:02 +0200, Roger Pau Monné wrote:
> 
> > This results in a NULL pointer BUG when blkfront_remove and
> > blkif_free
> > try to access the failing device's NULL struct blkfront_info.
> > 
> > 
> I guess this is a candidate for backporting?
> 

yes, I think so. At least for kernels >=4.5, which could face this
issue due to commit c31ecf6c12 (this frees the struct blkinfo in the
failing path of talk_to_blkback).

thanks, 

- Vasilis


