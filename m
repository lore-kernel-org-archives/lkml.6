Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F00AC0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A54921872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="p6mtw2Dr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bay8IKY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392187AbfBMUas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:30:48 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39665 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730402AbfBMUas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:30:48 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4A093244EE;
        Wed, 13 Feb 2019 15:30:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 13 Feb 2019 15:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=T7QSnUai46rJkc55MyA/G3T7prr
        ND/ta0QCFO8x15M0=; b=p6mtw2Dr4Ui82Mol6wL5Axy4sDXBdGzD+bKveYeJXAp
        o/7y2ECPew26IlchXYHCTblzUvK/q0vJFziEQzm5leN3GDRwA9VZIDjnes8mbFZq
        WTm/07xuiPRiOKvBYtHxUYIE/7m6idSMeCYLLBAGz/DIZNu0O8/d2IhKBUD+UlT5
        AKbLAmFpGENBoGyzeaWosBMxwIgz+SfMuf1OCpqYA0Plp9LAa88pesHqkSSU8k6J
        QzlHSSTVpXlOuAaItgeRt8unDl4ktAQNR2PcAFY+qELH4sQ6eJAEmka4g34/xQd+
        HMLKtnFTbXCFCilwBjeSGBvVscKVONE9VRd4zMfNCEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=T7QSnU
        ai46rJkc55MyA/G3T7prrND/ta0QCFO8x15M0=; b=Bay8IKY5xEp/PYnRJclueH
        BU62LnOB8RFF8vRPD6BYQ9T6QmTpV6z9J23CGlr2ZuXm0UhtBW8fhDoSynZKpN+9
        N6Lk19eJqwq+PUB3jL9WiKsEIy75tN1gliy56VpL0/f3Y37tFZqKoYggJICvYb6C
        gmJ8N35nz6VXkK2opIvi01LujnMZBPhiB3rPqLE5YedlMQN1pJ0fMDOQv4yplpQ8
        0WPr0zGbZgO1Knb5dKyb3dCg0s68HVIB/tLSUW243SdqrWDB1jJjwA/t2OVctB4D
        /12Lt6SSTE0EuSNIxEKfD6F9nE2JTCueQmdw/9U3uNavYkYYkeYXo9m4LI06rnzA
        ==
X-ME-Sender: <xms:dH5kXDlxV8kEMOmOc19AOZseHpIVsMQJyfPpR2L5X-mHFbQQIZ5Ung>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtfedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfe
    dtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredtofervdenucfhrhhomhep
    fdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecukf
    hppeduudekrddvuddurdduleelrddutdegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    vgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:dH5kXCrqoifyditB8Oos33jJQPt7wxyTyflyUCKyK29w-BWSD5c2iQ>
    <xmx:dH5kXA-eVMQHage5w_YgDGaDgUZaP7oGfwgkmaElBgRxGe1xm0-0Uw>
    <xmx:dH5kXO2pZ1Oq6AE4stBVg7QDeI_vzYPwxOLkAjFIQyljlZ77WdJ7WA>
    <xmx:dn5kXNcmbVQM8J9ZpoG-drB5VQ8WojIGqXBYoGPvFm99y8BewZ-jSA>
Received: from localhost (ppp118-211-199-104.bras1.syd2.internode.on.net [118.211.199.104])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0E04910319;
        Wed, 13 Feb 2019 15:30:43 -0500 (EST)
Date:   Thu, 14 Feb 2019 07:30:33 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'Tobin C. Harding'" <tobin@kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Tycho Andersen <tycho@tycho.ws>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] leaking_addresses: Expand tilde in output file name
Message-ID: <20190213203033.GB31743@eros.localdomain>
References: <20190207225026.11723-1-tobin@kernel.org>
 <20190207225026.11723-4-tobin@kernel.org>
 <6aed136f16e8451dbcfa97f90c04438f@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aed136f16e8451dbcfa97f90c04438f@AcuMS.aculab.com>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 03:56:47PM +0000, David Laight wrote:
> From: Tobin C. Harding
> > Sent: 07 February 2019 22:50
> > 
> > Currently if user passes an output file to the script via
> > --output-raw we do not handle expansion of tilde.
> > 
> > Use perl function glob() to expand tilde in output file name.
> 
> What happens if glob() returns multiple files?
> I'm guessing that it can...

Thanks for taking a look at this David.  Surely glob() cannot return
multiple values when expanding tilde?  If someone passes a '*' into the
command as an input/output file then they are clearly mad :)


thanks,
Tobin.
