Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCB6FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893CF206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f87TDr87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893CF206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeINS37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:29:59 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43733 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727013AbeINS37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:29:59 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B028321E09;
        Fri, 14 Sep 2018 09:15:31 -0400 (EDT)
Received: from web2 ([10.202.2.212])
  by compute3.internal (MEProxy); Fri, 14 Sep 2018 09:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=IKHEyN
        pwH70EIFM+RZ2q7XOkfRrWuyjXm7do8oj3lBo=; b=f87TDr87BrlSRoBXBb+MYn
        fWnOkL4/5HjNF+O2nIq4O8QM6goZgetu5D7fyBuBWbQgCIfurEq2xbcX7+9lQhK/
        arIJrFhiZ0N2S7svZHx2DCNgHu6i7Kw5GsH3TPN2eDdjC63/ds5qhuJsnQQ9JXhI
        z4JeOVTjG/qgFCgmnzrH0nb01zLeTc5GmBMuZTRaYefFtLayhkcjr0kHsLtniGFo
        Uw7XOZCfl8q2Hsav45UGmK7TJvi00JAFR8VprKEpZwuzRfqiuzcPyIRpaViTBDii
        cSyTBf/86+A9fW1BbleZxtR0Z70v8TV+MhqCUc/1vD7gevphAtqoHUvpyIbSWFjA
        ==
X-ME-Proxy: <xmx:c7SbW0enLE0wSNeB-C1BesRfZu0RgNQ231XXwtX4PajQZnY5xHDpjQ>
    <xmx:c7SbW8r7SilXqwIqiPhjyY7jpiYLNlFCG84XRFooO0jrQ4czMWF7iw>
    <xmx:c7SbW9Y3078qxCR3-AQsemmKLdee5RYbRE6lajtn8nwU_-tq_vhvDQ>
    <xmx:c7SbWxvYkmEWLYiYlpWh2djyZX1P2SeWWLRHYA4SR0vw0Mq_dx2klA>
    <xmx:c7SbW4yPDtRzmYOTtLG3G3Guvvs5CJ7mddnGp3Pu4dBRNwV4u_8O9A>
    <xmx:c7SbW40L5lDJdrtGlQS83P73YAskx65w5aTO26fezxuwLRr8YOQwPg>
X-ME-Sender: <xms:c7SbW-YF7-KOiz24EWw7_i-1kdHZYALt6kBTo6Qp_nM_qwK7JRNkCg>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id DE605621E9; Fri, 14 Sep 2018 09:15:30 -0400 (EDT)
Message-Id: <1536930930.1003187.1508104496.6465C44D@webmail.messagingengine.com>
From:   Colin Walters <walters@verbum.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Victor Hsieh <victorhsieh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-e556cd15
In-Reply-To: <20180825044852.GB726@sol.localdomain>
Date:   Fri, 14 Sep 2018 09:15:30 -0400
References: <20180824161642.1144-1-ebiggers@kernel.org>
 <20180824161642.1144-2-ebiggers@kernel.org>
 <1535132549.2855027.1485213752.129E3334@webmail.messagingengine.com>
 <20180825044852.GB726@sol.localdomain>
Subject: Re: [RFC PATCH 01/10] fs-verity: add setup code, UAPI, and Kconfig
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018, at 12:48 AM, Eric Biggers wrote:
>
> As Ted pointed out, only truncates are denied on fs-verity files, not other
> metadata changes like chmod().
> 
> Think of it this way: the purpose of fs-verity is *not* to make files immutable.
> It's to hash them.

Sorry for my unfamiliarity with Android internals but - in earlier discussion
I believe it was mentioned that APK (zip files?) that are being targeted here, right?

Now AIUI, Zip files have an internal header that contains e.g. the size and
indexes into the internal files.  So if someone added random data to the end
of a zip file, nothing is going to end up actually reading it.

However, there are file formats that use the size of the file reported by stat();
at least OSTree does this with serializing GVariant.  I'm sure there are others -
I'd imagine at least some things parsing ELF do this?
In such a case, we really want to deny appending to the file as well.

Unless there's some mechanism to deny applications reading not-verified
data?

And "hidden" data after fs-verity protected files would be a nice place
for persistent malware to hide.

Does anyone know of a use case for appending to a fs-verity file?

The slides here:
https://events.linuxfoundation.org/wp-content/uploads/2017/11/fs-verify_Mike-Halcrow_Eric-Biggers.pdf
even say "File becomes read-only!"

If not, then here's a strawman: Require that at FS_IOC_ENABLE_VERITY time
the file does not have any +w bits set (and I guess no ACLs that do so...
that may get ugly).  

I think that would make it easier to later factor out a "_CONTENTS_IMMUTABLE"
flag.

