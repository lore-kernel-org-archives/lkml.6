Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2207741-1521444251-2-17743425718369851936
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
    t=1521444251; b=X/RvX0UlAubSUjlkvYDJ5wL6t0KgmsFhwFw/ICbH97T/CWf
    O9wWinD8lA/wImj4eHPjHBfA7ay3yptiqdTzxmh8B/RL3sAtzdCu44NPWPSd95Ss
    AIZqWcKNRaODmEbd7aYlXNAPDlA+DIPOqWDoxbwEttzPJAbfaRnbfZrMJz2ysdWd
    cc9bFxlsd5vjBsimvAZfyeDm6PAN959FC3nYmIxzjXeT/TuK+EUZjq0DBQU/dZy/
    5VTk5lRtk2aOv0EhpoJHF5SD365LvZNt2wtGWlEQJguPzJkCHN5sQSop0dULvcU9
    kEFTXWmiRDxztb/cjjfVkUZp/2uW6utkOHIznqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521444251; bh=pHAQ3Ef/5/q5ZGd0tjsd40EY5V
    rqSvo2DA52KwacXuU=; b=vFSIROImzLqKCcuYWLywlF/za+AyVizok8OYXGKonj
    FHOK/tO3fhUueyMcoJTOA3GH2VWJCvvoMSRBTQzH5ms9+Pod9Db88UsRpKyONO01
    1v8aaQVb3Q0VGX1FIC1WfRW/z+lLA6TocxXd3KaO2YCs/tvo8X59H/wV7ykrXOnA
    ijAl2ORKGp6f3jQnCTc0g3ePymh/HkxG2csVDDW3S71BUMr816jBrAfNHN+3keAx
    tCGp0XEvIg+isH/NIoGx0GHDw//qIAoKW5HlabzLKc93qRSwNtW4fn5FPqWLVkyB
    RXragiXgrMKMWbqEmKD31HujMofanHLasECKh7VhLznw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujggfshhpjeesthdtredttdervdenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeftdejgeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujggfshhpjeesthdtredttdervdenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeftdejgeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932296AbeCSHYI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 03:24:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60770 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932277AbeCSHYI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 03:24:08 -0400
Date: Mon, 19 Mar 2018 08:24:07 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.14 056/109] clk: ti: clkctrl: add support for retrying
 failed init
Message-ID: <20180319072407.GA4530@kroah.com>
References: <20180316152329.844663293@linuxfoundation.org>
 <20180316152333.001660820@linuxfoundation.org>
 <20180319034408.wi6wfosbcckw22j6@xps>
 <67169312-ba94-7a68-56cf-8412d8b42169@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67169312-ba94-7a68-56cf-8412d8b42169@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 08:57:30AM +0200, Tero Kristo wrote:
> On 19/03/18 05:44, Dan Rue wrote:
> > On Fri, Mar 16, 2018 at 04:23:25PM +0100, Greg Kroah-Hartman wrote:
> > > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Tero Kristo <t-kristo@ti.com>
> > > 
> > > 
> > > [ Upstream commit 729e13bf58e643b9accd2a14c55b555958702fb0 ]
> > > 
> > > In case the clkctrl node contains assigned-clock-* entries, registering
> > > the provider can fail with -EPROBE_DEFER. In this case, add the
> > > provider to the retry_init clock list so it will be cleaned up later.
> > > 
> > > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> > > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > This fails to build for me on arm32:
> > 
> > $ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm multi_v7_defconfig
> > $ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm
> 
> This actually needs commit ffb009b24388b896d9ca8b54e39a879302142518 ("clk:
> ti: convert retry_init param to use void data type") as prerequisite,
> otherwise it fails building.

Thanks, I'll just drop this patch from the trees now, as that seems to
make more sense.

Sasha, if you want to pick both of these up for your next round of
patches to submit, that's fine.

thanks,

greg k-h
