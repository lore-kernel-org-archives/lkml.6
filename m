Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6618C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723E220848
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723E220848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbeKBJmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 05:42:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58678 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbeKBJmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 05:42:05 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gINQ2-0006MQ-Am; Fri, 02 Nov 2018 00:34:34 +0000
Date:   Fri, 2 Nov 2018 00:34:34 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Nikunj Kela <nkela@cisco.com>,
        David Woodhouse <dwmw2@infradead.org>,
        xe-linux-external@cisco.com, Rod Whitby <rod@whitby.id.au>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make JFFS2 endianness configurable
Message-ID: <20181102003434.GW32577@ZenIV.linux.org.uk>
References: <20181101225603.17806-1-nkela@cisco.com>
 <20181102000236.rqho7txtb7gv543t@zorba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102000236.rqho7txtb7gv543t@zorba>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 05:02:36PM -0700, Daniel Walker wrote:
> 
> 
> 
> On Thu, Nov 01, 2018 at 03:56:03PM -0700, Nikunj Kela wrote:
> > This patch allows the endianness of the JFSS2 filesystem to be
> > specified by config options.
> > 
> > It defaults to native-endian (the previously hard-coded option).
> > 
> > Some architectures benefit from having a single known endianness
> > of JFFS2 filesystem (for data, not executables) independent of the
> > endianness of the processor (ARM processors can be switched to either
> > endianness at run-time).
> > 
> 
> 
> The description is pretty sad .. We have a product which we released that uses
> JFFS2, and that product was release with a kernel in one endianness. Then later
> on we decided to change the endianness and now we're stuck with a JFFS2
> partition that has the wrong endiannes, in a released product. This patch allows
> us to set the endianness to something different from the architecture setting.
> 
> So there a significant use case for the change, at least for Cisco.

FWIW, can't we detect it at mount time, as e.g. UFS does?
