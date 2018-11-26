Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12DBC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA2920817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA2920817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeK0IIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:08:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:19191 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbeK0IId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:08:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 13:13:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,283,1539673200"; 
   d="scan'208";a="110469390"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.24.8.61])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2018 13:13:08 -0800
Date:   Mon, 26 Nov 2018 13:13:09 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Michael =?iso-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [BUG] Nuvoton NCPT650 TPM 2.0 mode not working
Message-ID: <20181126211309.GA868@linux.intel.com>
References: <3243d0325b3ea5878d3f86b0ee4fec1498f21dc1.camel@mniewoehner.de>
 <660b0934bc16c8d195a2724f8be4ba8dfbe71134.camel@mniewoehner.de>
 <1541972556.3734.90.camel@linux.ibm.com>
 <4f7cc7152f2266d8d0782889db2375d4c1c71987.camel@mniewoehner.de>
 <b89c95a496a1512ee3069b6a69cf915906fe697a.camel@mniewoehner.de>
 <20181118081833.GH5897@linux.intel.com>
 <467833cc47247a55595d72426f46eeac1406eb04.camel@mniewoehner.de>
 <20181119134956.GD8755@linux.intel.com>
 <49ec628f42fa7833f6a75d4a8b15d64789c70bf7.camel@mniewoehner.de>
 <a4b30f21571d620db8d4ce311df5856f38b3d1a7.camel@mniewoehner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4b30f21571d620db8d4ce311df5856f38b3d1a7.camel@mniewoehner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 08:15:38PM +0100, Michael Niewöhner wrote:
> Hi again,
> 
> after some experiments I finally found a solution...
> There seems to be a bug in TPM2.0 firmware version (1.3.1.0) included in Lenovos
> UEFI image but they do not provide an update.
> 
> I have extracted the firmware version 1.3.2.8 from Dell's XPS15 TPM2.0 firmware
> update and used this to replace the firmware in my Lenovo UEFI image.
> After flashing this version via UEFI Setup the TPM2.0 gets detected and now is
> fully working. WTF.

That can be called as true craftmanship :-) Awesome work! Maybe you
should even consider blogging this. Sounds interesting.

> For anyone having the same problem: binwalk, uefi-firmware-parser, uefipatch and
> flashrom are your friends ;-)
> 
> Best regards
> Michael

/Jarkko
