Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-820325-1521531629-2-8427439745407281402
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521531628; b=CWGuoJSyZcFM5d37MQX3U/UC8i1GCK4VokBG1svTSLMjyG0
    AZwTPsfDv5dYQXVUS8njx8CEtFjrXfzZaME0ygp+AmumISkaSWAgSBNf9yQEvqo+
    Vl/p65RDYZ3uUmgDljehB9r4nTNzjWRcUGJiv0/krTAntH7FpEWFuMH0hvVbYZyf
    DrLLHciSJAfca7fqx5GxiaAowEhVsXUVF/N8P/D79LON4knK1AeW1VPmJZ8LHAFn
    PhAbTtHtX5xevMrKz0HAfyLESH41okgGeD+lD+P19oODvIj0cf1o6TKkQWGXfqPy
    HQiGFDg49fWeQTPxxgeJvew9AChIg5upr90VZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521531628; bh=mMMNCKKPzYnAUQ94A2EVff12r0
    yYCoOOXQo3ipfBjgo=; b=KsVe/hgjVucyNNoeT6PA9CJPdUpOAXhmOISlu1vthp
    TzJ05S8+tZT0h75fZvkvWbRMe6h9XLward+77e/kRc/LoCgwlQuZ4Q971Du4XkSm
    2w7Pz6pxLTBmLxejzdFFiQFzt8h8/rbIoQcrA9vnBic2SFEuyrwTocJn6B4SRs3s
    2nCQNMRzgGmL4q3N2vNYiN6dVPK2iItWOMbPzc9YWgvxWWPmNdtBGBnwZPRCrmIp
    Z7qRMm3D0iw/3BJaT29rVe2pnTcNeqZSi++PzWJwP4ayJYToOcW65TujrrikeBXo
    z/Lj2CtNNdO+BGTisNSe/DRidNUFHJ68u75HQ+XCn+aw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeCTHkY (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 03:40:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37898 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbeCTHkY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Mar 2018 03:40:24 -0400
Date: Tue, 20 Mar 2018 08:40:22 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
        shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
        patches@kernelci.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.9 000/241] 4.9.89-stable review
Message-ID: <20180320074022.GA8152@kroah.com>
References: <20180319180751.172155436@linuxfoundation.org>
 <20180320005951.ulw66htokgtdmfav@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320005951.ulw66htokgtdmfav@xps>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 08:59:51AM +0800, Dan Rue wrote:
> On Mon, Mar 19, 2018 at 07:04:25PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.89 release.
> > There are 241 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Mar 21 18:07:03 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > and the diffstat can be found below.
> 
> I needed to revert the following in order to successfully build arm32
> and arm64 with default configs:
> 
> 9b18a27ddaa0 ("ARM: dts: silk: Correct clock of DU1")
> 181e698aaf8c ("ARM: dts: r8a7794: Correct clock of DU1")

Should now be fixed.

> 2bbf316eee1b ("soc/tegra: Fix link errors with PMC disabled")

Now dropped, should have not been included, was fixing something from
4.12.

> 0a576d2dfcc6 ("dmaengine: bcm2835-dma: Use vchan_terminate_vdesc() instead of desc_free")

Dropped, I thought I had deleted it earlier, my fault.

> 67ee5b1dfe12 ("clk: sunxi-ng: a33: Add offset and minimum value for DDR1 PLL N factor")

Now dropped.

> 9294024e21e3 ("ARM: DRA7: hwmod_data: Prevent wait_target_disable error for usb_otg_ss")

Now dropped.

> I'm not sure the best way to report the specific issues with those, or
> why there have been so many arm32/64-related build issues lately. Let me
> know if you want more details.

This way was just fine.  I'll go push out a -rc2 for this tree now, many
thanks.

greg k-h
