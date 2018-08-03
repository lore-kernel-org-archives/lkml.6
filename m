Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC10BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 05:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0E021711
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 05:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0E021711
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeHCHe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 03:34:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40564 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbeHCHe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 03:34:28 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4C71A3EE;
        Fri,  3 Aug 2018 05:39:51 +0000 (UTC)
Date:   Fri, 3 Aug 2018 07:39:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhang Ning <ning.a.zhang@intel.com>
Cc:     kstewart@linuxfoundation.org, pombredanne@nexb.com,
        yamada.masahiro@socionext.com, markus@trippelsdorf.de,
        linux-kernel@vger.kernel.org, Ting <ting.li@intel.com>
Subject: Re: [PATCH] firmware: make sure builtin firmware is page alignment
Message-ID: <20180803053948.GB1852@kroah.com>
References: <20180803014521.21527-1-ning.a.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803014521.21527-1-ning.a.zhang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 09:45:21AM +0800, Zhang Ning wrote:
> when firmware is in filesystem, request_firmware will load it,
> and copy it to vmalloc memory, that is page align memory.
> 
> but when firmware is builtin, it is 8 bytes or 4 bytes alignment.
> 
> make sure builtin firmware is page algnment, that can simplify algorithm
> to handle firmware.

How is it simplified?  I don't see any such change like that here :(

