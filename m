Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E259C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A1727A04
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A1727A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935566AbeF2RsC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:48:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:58229 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750965AbeF2RsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:48:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 10:47:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,286,1526367600"; 
   d="scan'208";a="68413205"
Received: from shivamur-mobl.gar.corp.intel.com (HELO localhost) ([10.249.254.20])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jun 2018 10:47:44 -0700
Date:   Fri, 29 Jun 2018 20:47:43 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: require to compile as part of the kernel
Message-ID: <20180629174743.GC4060@linux.intel.com>
References: <20180629151005.10899-1-jarkko.sakkinen@linux.intel.com>
 <20180629153141.GE379@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629153141.GE379@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 09:31:41AM -0600, Jason Gunthorpe wrote:
> > -#if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
> > -
> > +#if defined(CONFIG_TCG_TPM)
> 
> Huh. This new version is certainly right

Hmm...

If the option is kept as tristate, shouldn't this be actually:

#if defined(CONFIG_TCG_TPM) && !defined(CONFIG_TCG_TPM_MODULE)

?

/Jarkko
