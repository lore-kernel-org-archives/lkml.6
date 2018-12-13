Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE4BC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C85620849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544688309;
	bh=2QHGFl9v147M+wVCNuBif1RCnWl1RqelZKcDQ5KtmvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P1wBsJD+PBbEplYoRrGeqpCmbMDdyiW74bvjraweh7OXNIPXejk0WFAlFaBA3AzCp
	 ztX/9q0kOYgjFmrTJoAP8dlHmnHNBKsJYs41LsVhCxPoY/42Kfxmu1d0fREj41bkem
	 T2lBz9g8e0cQn1s84UxWZ0YSonEcVl0szdn5AnOM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C85620849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeLMIFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbeLMIFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 03:05:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1715F20672;
        Thu, 13 Dec 2018 08:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544688307;
        bh=2QHGFl9v147M+wVCNuBif1RCnWl1RqelZKcDQ5KtmvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ios/XfML/aQS1ui8OZjwyZgiZ678j/dyGq8GckzU+E5EVfePGNsZzUKZQWK2P9EHs
         Si+mZKfkJBTyXWNAqCzkjaFPIi/0fpIUt0lAm6twsaY/WF8WAokgR7/zlSmS81fIOp
         drA7ffWUVkChC6p+5+xxOOOe6GWJpF3PhhLabIIA=
Date:   Thu, 13 Dec 2018 09:05:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/118] 4.19.9-stable review
Message-ID: <20181213080505.GB1825@kroah.com>
References: <20181211151644.216668863@linuxfoundation.org>
 <20181212185056.GC21649@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212185056.GC21649@roeck-us.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:50:56AM -0800, Guenter Roeck wrote:
> On Tue, Dec 11, 2018 at 04:40:19PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.9 release.
> > There are 118 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Dec 13 15:16:10 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 337 pass: 337 fail: 0
> 
> Details are available at https://kerneltests.org/builders/.

Wonderful, thanks for testing all of these and letting me know.

greg k-h
