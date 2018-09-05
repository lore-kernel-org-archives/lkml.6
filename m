Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99625C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226282077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="MMFKJVW1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A8TTHrhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226282077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeIEV1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:27:04 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:55511 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726335AbeIEV1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:27:03 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 75E423F3;
        Wed,  5 Sep 2018 12:55:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 05 Sep 2018 12:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=g3Wo1svdxqKojbKIUC+Cblg7FXnA3MWmsDAbvryG6P8=; b=MMFKJVW1
        W/Riod0piHOgIr0ZmkKTu7rVKhEP/CJaxwPwZKjOeg6ZP2TJaY5werKXtgaCK+Z9
        c0JqE2c0Tow4p2d1+Y8srtvtu/SmaSCsFaNlfLuGeF5xip8OVHUIg8TljwBHgOJ0
        mNz7hyrtXPxT5/stzBMbC99+ipze9r6mMjlaETUnm+py2soavkRTxphWLCetTbqZ
        7TS8P5mSwz9veD8hxzMzAkavUq6O4EZJGHNZYcAzg2hhI3+HBS4TyC2lZjAPxU4x
        QarrSfd1DQBNcdFxxXm/H+jNkYoS6Ay7+IC3BoUnqS5+hseqksXrEMqBL2tJnq5O
        z+C1DOFhd7UloA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=g3Wo1svdxqKojbKIUC+Cblg7FXnA3
        MWmsDAbvryG6P8=; b=A8TTHrhvVgceutAfwJ/8U7xsbt7rdT6xnEe+DXyLVnhdb
        Hg+pRKfkpqMBt5nBj2V4unigX74xPr8B6CW/JRCGiIlVt28w0UUweMg1RxoLJcd+
        ZlqtqAesV73eET8CyV4iosCS0LCj4hMqBN+lmDvCDhK4wzdCqRsHWaL2DKdrkkHr
        PEP+I/U+NTCcsmLX3Hb2civ+ceQuKdiDMPgQnX77615KDya5mU4H2cFcJKfFoMtp
        IMiT58TL3ImCpbvO0mWoE0i7UyUEgmk/IvIZq9undGg2D4H8kQNxX8FR26ZPpCfT
        n/4FJhB3v7lD/q9aVgQlw78ZxJHvVbkcDqYokByMg==
X-ME-Proxy: <xmx:mgqQW_IY5OPwNfnGr-sgZ05BPZDbMuMz5qxxweOKcYxYaPIYL4mFqQ>
    <xmx:mgqQW_606m4c8dLy3ogsMw6uQAoMIXtkBK83zf7td1F4cwPr7xN04w>
    <xmx:mgqQWyTER5EpTf9KqxU0VwcYn2UsId7XprPi0-Da7nAyjUDtlA_H6w>
    <xmx:mgqQW7qV9Gozvyn2uI3sdhIs6x1F7jAggsXQZqJNMk0-1vBRazpGVQ>
    <xmx:mgqQW9j29e7xNdT1XCr6s3Aft2Y8gp69x1bZS62vO4huWS7SHqcAaA>
    <xmx:ngqQW6YtKC1o49nLqrgllIMFKzqTH0WUyRw_W3GDQqbKbub9B_4BJQ>
X-ME-Sender: <xms:mgqQWz01phS25gAvdBZ5MX5BY9Rm-PdR-owjdRbytsg7znb-9BJ6iA>
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.messagingengine.com (Postfix) with ESMTPA id D5E6A1029B;
        Wed,  5 Sep 2018 12:55:53 -0400 (EDT)
Date:   Wed, 5 Sep 2018 18:55:52 +0200
From:   Greg KH <greg@kroah.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        keyrings@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-nilfs@vger.kernel.org, linux-nvdimm@lists.01.org,
        "Michael S. Tsirkin" <mst@redhat.com>, codalist@coda.cs.cmu.edu,
        coda@cs.cmu.edu, coreteam@netfilter.org,
        Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Takashi Iwai <tiwai@suse.com>, linux-bcache@vger.kernel.org,
        Coly Li <colyli@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        Jason Wang <jasowang@redhat.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        netfilter-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] UAPI: Check headers by compiling all together as C++
Message-ID: <20180905165552.GB25206@kroah.com>
References: <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 04:54:27PM +0100, David Howells wrote:
> 
> Here's a set of patches that inserts a step into the build process to make
> sure that the UAPI headers can all be built together with C++ (if the
> compiler being used supports C++).  All but the final patch perform fixups,
> including:

Wait, why do we care?  What has recently changed to start to directly
import kernel uapi files into C++ code?

And if userspace wants to do this, can't they do the C namespace trick
themselves when they do the import?  That must be how they are doing it
today, right?

thanks,

greg k-h
