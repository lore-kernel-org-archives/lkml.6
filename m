Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D5DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA5C2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="BPqz4EcR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kzPqKAQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA5C2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbeIJWvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:51:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43279 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726603AbeIJWvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:51:51 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DEDF521AB4;
        Mon, 10 Sep 2018 13:56:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 10 Sep 2018 13:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=56m35KN1uK+Npu+IdiJJuoLnt1s33q9ICkYFu0RXKfw=; b=BPqz4EcR
        UQ0oku5nQNtjJMnac01eKz77yvLeNVdl447mRV+hF89XMBkcUwkjSTHvpL9b84Ya
        ER7M8yUla06W51xzrAk01ZdI7Hv+xAFsCv4WQp/alsP+JDHpVjmWw1CMEnuoYKEv
        cRERdQOiGPm4Fc1ypnr5ttOSJeS+gEm/RoKdu1iPiKHgg6yzaVuR1ilhd+RV1fd3
        2DFd4/HmUomw1wQD3T2nDwgM29wfYCZefDAz+ZYGN+b1DaQOKyQAHxMuuJ4SUNv5
        Qf1A1uIrO8epf4gF2j/hrcPVHU4l/sCzIhUseqDfFCjknPpyIX4h5w7xGSLTpwOC
        Ld9Ncq4iEP+Uqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=56m35KN1uK+Npu+IdiJJuoLnt1s33
        q9ICkYFu0RXKfw=; b=kzPqKAQTGG78PwuxXpmBsNdQw9LmfOa4Ysu/UG50x3oy2
        hKVjFZ5lvEuSP5wmjQlyCjZzMYNpzNoaht5EOSZWz4/Mg5hyW+jCo0NFjqxCSGZz
        N+humvqX9wV9CuQU/8oz2fKXMJR4owaLe0Tk7J1Ln82Ix8sGa0oFojSEy/bBoyDO
        eRLBrMuQKnVFb4SIn0tE/sOpRx5OPsGwl1K1tN5tLZUoDTi2znaU+bsOZqRz3e7I
        INrZVIDTXO7tGrfMTUVIzWJElnzLnYBotogbMZ7pSygo9zWUY+7BFKwh8mTbnpqG
        pod5ksnodDDnkYgNO/OS73RDH+oUY+YUxKA/DcddA==
X-ME-Proxy: <xmx:U7CWW3jMYH-jYFS5zeaqLcrDR0-thTwYsYIeM487TXnypVG6qbixVw>
    <xmx:U7CWW0PV0_YxTGvryQVWbekSTcQosMhPSa_EIv70qme_eLGlzyqyLQ>
    <xmx:U7CWW45IakUKvEVvuEnSCJYMg0vJwVNp1CzsJokIyjU_I9fPxmH1Mw>
    <xmx:U7CWWy32HvwpG7YLFBbJHOXAv06jiGk7NUMcruU3jYYQx2RAKRvUQg>
    <xmx:U7CWW5Yqb7_83GAWflHqjw1W6UawZozXnU2zcLbS4uZS8pRYnkKALA>
    <xmx:U7CWWwd0PNJh651zewOQXxK7kUa6MhmAadqk4OYBzM6DlLzxFfMCDA>
X-ME-Sender: <xms:U7CWW2Mj_GkZn0cuRYLIyaQRe63bgwn0e9PT1xJimJN0sxajFyVImg>
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2087410299;
        Mon, 10 Sep 2018 13:56:35 -0400 (EDT)
Date:   Mon, 10 Sep 2018 19:56:33 +0200
From:   Greg KH <greg@kroah.com>
To:     Julien Folly <julien.folly@gmail.com>
Cc:     linux-kernel@vger.kernel.org, manio@skyboo.net
Subject: Re: [PATCH] IAD Register is yet readable trough iad sys file. Fix
 snprintf (%u for unsigned, count for max size).
Message-ID: <20180910175633.GA10276@kroah.com>
References: <54c2ec84-8057-3ee2-0f68-684d6b589e64@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54c2ec84-8057-3ee2-0f68-684d6b589e64@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 07:36:51PM +0200, Julien Folly wrote:
> 
> Signed-off-by: Julien Folly <julien.folly@gmail.com>
> Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
> ---
>  drivers/w1/slaves/w1_ds2438.c | 66 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 52 insertions(+), 14 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
