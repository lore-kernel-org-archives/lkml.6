Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EA3C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 09:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B4420892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 09:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544259702;
	bh=RWjRGHWbp/AKC8BsOosgAs038T3Nr9rKjRoG+BTGcZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JPiOgQOsYRqrUXSql1U8AwhrxYZMzolrDIZDERyfDsCXWxInyEFk/kNMabkeYu/mk
	 5Cy+dXrrhfJYul0R8DzJ8VCahRJPn3US/MRb1BTn3xg/E9MFDMMh8QvbgFJe0RPZwH
	 HHr3oMi2QGzQ+tFq7KacD9U++f7Sgb0PQcuhIfNM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B4420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeLHJBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 04:01:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:47314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbeLHJBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 04:01:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D9E52083D;
        Sat,  8 Dec 2018 09:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544259700;
        bh=RWjRGHWbp/AKC8BsOosgAs038T3Nr9rKjRoG+BTGcZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b1hx6HFiDGE5Yz/ypkRvdIpIqdsd4OqGeSLwLIDTsXousxhlCLG7xHa3jU4oKtEzS
         Iua//PCGoyzq92I0/VWHIG3rhMPbHiWD+r+OOaxgaUJHtjKsdgXDXlh86SEIbWJG6Z
         aYYo153+kAxDFiqIifeNs3WrtaqKqY0HGmufdoYs=
Date:   Sat, 8 Dec 2018 10:01:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 4.9 100/101] f2fs: fix to do sanity check with
 cp_pack_start_sum
Message-ID: <20181208090137.GB28887@kroah.com>
References: <20181206143011.174892052@linuxfoundation.org>
 <20181206143018.979787297@linuxfoundation.org>
 <1544206370.2867.118.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1544206370.2867.118.camel@codethink.co.uk>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 06:12:50PM +0000, Ben Hutchings wrote:
> On Thu, 2018-12-06 at 15:39 +0100, Greg Kroah-Hartman wrote:
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Ben Hutchings <ben.hutchings@codethink.co.uk>
> >
> > commit e494c2f995d6181d6e29c4927d68e0f295ecf75b upstream.
> [...]
> 
> I accidentally reset the author for this while backporting it.  The
> correct author is: Chao Yu <yuchao0@huawei.com>

Thanks for catching this, now fixed up.

greg k-h
