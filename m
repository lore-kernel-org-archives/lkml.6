Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824C5C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1E32086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544688286;
	bh=yX+ZXazBwpvIuU6ow3Yp0/8GK5D2IZtz/EL+/oIXeC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KgTn5RVwXuYO+bYR1NN/Bmcc7IfTOpuzwpsk43vMmGujFKRhDKWLF9REVd9WiwoJx
	 9dUxF82rwfLyQONmmc8aWYm5Ebw8hhjYtoxlDekVmWBCLrqwg+9L34tVdNHe3Jw7Fj
	 0LkhXoAM1ZtLGDP22XvvSAa/pQ01Htl0PVoS/cII=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1E32086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeLMIEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:04:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbeLMIEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 03:04:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5285320672;
        Thu, 13 Dec 2018 08:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544688283;
        bh=yX+ZXazBwpvIuU6ow3Yp0/8GK5D2IZtz/EL+/oIXeC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v5q5O1tyA8/uhP6rUuo4SemYQnvl2niN4IXNiEUoBq8KRdvGdCruowt6vzdTcZwP0
         ta0ut3U69PdI3h0TxAIQLXUD6tvaYGylwe6PVnIie8f4iWGa71Z0aFjiccxpW66WlN
         QjM/xmUDT3WCeJ2cCzuEjpHrI559g9ldyoMzDYkk=
Date:   Thu, 13 Dec 2018 09:04:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harsh Shandilya <harsh@prjkt.io>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/91] 4.4.167-stable review
Message-ID: <20181213080441.GA1825@kroah.com>
References: <20181211151606.026852373@linuxfoundation.org>
 <72595ECB-5595-4311-B23A-8B0DE6315B1C@prjkt.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72595ECB-5595-4311-B23A-8B0DE6315B1C@prjkt.io>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 12:45:00AM +0530, Harsh Shandilya wrote:
> On 11 December 2018 9:10:19 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >This is the start of the stable review cycle for the 4.4.167 release.
> >There are 91 patches in this series, all will be posted as a response
> >to this one.  If anyone has any issues with these being applied, please
> >let me know.
> >
> >Responses should be made by Thu Dec 13 15:15:44 UTC 2018.
> >Anything received after that time might be too late.
> >
> >The whole patch series can be found in one patch at:
> >	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.167-rc1.gz
> >or in the git tree and branch at:
> >	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >linux-4.4.y
> >and the diffstat can be found below.
> >
> >thanks,
> >
> >greg k-h
> Merged and build tested using GCC 7.3.1, GCC 8.2.1 and Clang 8.0.6 with -Werror, no build or dmesg regressions on the Pixel 2.

great, thanks for testing and letting me know.

greg k-h
