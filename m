Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC00AC43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADE32086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vhwFUlVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADE32086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390093AbeKQCc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:32:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbeKQCc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:32:58 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDF6320825;
        Fri, 16 Nov 2018 16:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542385198;
        bh=fiNXAnJ0prtU/3Ve4W2KZh0TOP9dj5xMbRihD+M9muc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vhwFUlVjbC0grCIACuFr9EebLd427VTRICGGj/p0+6xVgGpXTL8LKVNT+5aYkz3Jx
         nxuvBbqFLvy7+X8ZswVwnwDX7VO7rL48iB4wz4Rn7frOg2ZF6oMgUykNPlLScHiut2
         8DriqfHtLEH4/K2BIn9hEOA03Sr+MTMw4KFjcSmU=
Date:   Fri, 16 Nov 2018 11:19:57 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 08/17] tpm: call tpm2_flush_space() on error in
 tpm_try_transmit()
Message-ID: <20181116161957.GG1706@sasha-vm>
References: <20181116123845.15705-1-jarkko.sakkinen@linux.intel.com>
 <20181116123845.15705-9-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181116123845.15705-9-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 02:38:32PM +0200, Jarkko Sakkinen wrote:
>Always call tpm2_flush_space() on failure in tpm_try_transmit() so that
>the volatile memory of the TPM gets cleared. If /dev/tpm0 does not have
>sufficient permissions (usually it has), this could lead to the leakage
>of TPM objects. Through /dev/tpmrm0 this issue does not raise any new
>security concerns.
>
>Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
>Cc: stable@vger.kernel.org
>Fixes: 745b361e989a ("tpm:tpm: infrastructure for TPM spaces")
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Hi Jarkko,

This patch seems to depend on previous patches in this series, but those
were not tagged for stable. Do they also need to be backported? If so,
can you tag them as such?

--
Thanks,
Sasha
