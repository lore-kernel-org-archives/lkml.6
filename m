Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B73C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4172075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="l/9/CRTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4172075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poczta.fm
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeJKW7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:59:22 -0400
Received: from smtpo.poczta.interia.pl ([217.74.65.157]:51650 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbeJKW7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:59:22 -0400
X-Interia-R: Interia
X-Interia-R-IP: 188.121.17.172
X-Interia-R-Helo: <x220.localdomain>
Received: from x220.localdomain (unknown [188.121.17.172])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by www.poczta.fm (INTERIA.PL) with ESMTPSA;
        Thu, 11 Oct 2018 17:31:34 +0200 (CEST)
Date:   Thu, 11 Oct 2018 17:31:52 +0200
From:   Slawomir Stepien <sst@poczta.fm>
To:     Gabriel Capella <gabriel@capella.pro>
Cc:     devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: iio: adc: ad7280a: fix 2 checks
Message-ID: <20181011153152.GA1544@x220.localdomain>
References: <20181006162715.GA8476@mantaray>
 <20181006202542.GC5035@x220.localdomain>
 <20181011073203.iesapekyqkma2cqa@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181011073203.iesapekyqkma2cqa@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1539271897;
        bh=GwRS7/UIb6D+3G2EkVPjm8U3+Qy7Gcge7QWA9URiJvg=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:Date:From:To:Cc:
         Subject:Message-ID:References:MIME-Version:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         User-Agent:X-Interia-Antivirus;
        b=l/9/CRTqUCEGddZrAsT3XrDkeEujpNjINokDev7pMny3S5VD8RPpaTBTb7/sPQvQD
         t5GKGfTZC9RHCk9NIui0dqtT1VKzJWq7/rm9bhbVxqITdLW/KdsSolxmc1pupeqm27
         pGXvhCh6FASIc6E2hGyOmtwXbuVSdCAFgrL32qx4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On paź 11, 2018 10:32, Dan Carpenter wrote:
> On Sat, Oct 06, 2018 at 10:25:42PM +0200, Slawomir Stepien wrote:
> > On paź 06, 2018 13:27, Gabriel Capella wrote:
> > > This patch does not change the logic, it only
> > > corrects the checkpatch checks.
> > > 
> > > The patch fixes 2 checks of type:
> > > "CHECK: spaces preferred around that '-'"
> > 
> > I've made the same mistake few days ago. This change is incorrect.
> > Please see: https://lore.kernel.org/patchwork/patch/635994/.
> >
> 
> You could add a comment.  /* do not put spaces around the hyphen.  #checkpatch.pl */
> 
> These are the only places which use this style and a lot of people
> bump into it.

Gabriel go ahead if you want to. If not then I would be happy to prepare this
patch.

-- 
Slawomir Stepien
