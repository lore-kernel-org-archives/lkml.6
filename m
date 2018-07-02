Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68411C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE9E25E50
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE9E25E50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeGBOHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:07:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41210 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeGBOHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:07:45 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 136FAECC;
        Mon,  2 Jul 2018 14:07:44 +0000 (UTC)
Date:   Mon, 2 Jul 2018 16:07:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>, jassisinghbrar@gmail.com,
        jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] Tegra Combined UART driver
Message-ID: <20180702140742.GA7977@kroah.com>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702140343.GO13096@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702140343.GO13096@ulmo>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 04:03:43PM +0200, Thierry Reding wrote:
> On Mon, Jul 02, 2018 at 02:40:25PM +0300, Mikko Perttunen wrote:
> > Hi, here's v3. Changes are in individual patches. Acks are still
> > missing from the following patches:
> > 
> > mailbox: Add transmit done by blocking option
> > mailbox: tegra-hsp: Refactor in preparation of mailboxes
> > mailbox: tegra-hsp: Add support for shared mailboxes
> > serial: Add Tegra Combined UART driver
> 
> There don't seem to be any build-time dependencies between the above, so
> technically I guess these could be applied to the respective trees
> separately. The only thing we need to be careful about is to not merge
> the final patch before the others, because it will break serial console
> if the other patches aren't applied.
> 
> Jassi, Greg,
> 
> What I could do to resolve the runtime dependency is pull the mailbox
> patches into a separate branch, create another separate branch for the
> TCU driver that is based on the mailbox branch and then base the DT
> changes on that branch, or possibly send a separate pull request for
> just the DT change late in the merge window or shortly after v4.19-rc1.
> 
> Obviously the latter would be equivalent to you guys merging the patches
> through your trees for v4.19-rc1 and me sending out a late pull request
> for the DT bits.

No need for me to take the serial driver if these types of dependancies
are required, you are free to take that in your tree if you want to.

does that help?

greg k-h
