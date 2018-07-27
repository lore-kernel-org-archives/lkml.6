Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB22DC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ACB208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pW86vu2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4ACB208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbeG0OJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:09:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbeG0OJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YgPTPsndh0fyDgPXZnsG4Sn0s5ds7L5LuEHGX13wMAI=; b=pW86vu2qZs+1AfAT5ftOFbcWa
        9AU0INa/Vj0XIISSHshDp3wy2EmBdNYguHle6UZ2iEq7dtBBeEwi7wPdWcAb/U5yqeC8B5WQoWiiC
        9CX4jtjpbihVpy66E4naZZq/8CSkS/Oux1k/CC+viANCI5XuV+BWf3OCANIwGW46vY59jqBXL5EBf
        cCquK1qp1BJzLTMPIacjtkrdH01qtAId4AVrcQSNmZvjuN2FcNBJwicg3MeTgL8PHPFYN4sWhfbRx
        edyB1mDYObb40dGyz1PBT8tzUEm6NlO7aaT0QuyqdkKzK320Jiw5NZ+gIHZto8eF9u4chrR6zPW0m
        FrT/Dkstg==;
Received: from 179.176.120.227.dynamic.adsl.gvt.net.br ([179.176.120.227] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fj29L-0001ha-9u; Fri, 27 Jul 2018 12:47:15 +0000
Date:   Fri, 27 Jul 2018 09:47:08 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     pali.rohar@gmail.com, sre@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
        patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
        clayton@craftyguy.net, martijn@brixit.nl,
        sakari.ailus@linux.intel.com,
        Filip =?UTF-8?B?TWF0aWpldmnEhw==?= <filip.matijevic.pz@gmail.com>,
        mchehab@s-opensource.com, sakari.ailus@iki.fi,
        linux-media@vger.kernel.org, hans.verkuil@cisco.com
Subject: Re: [PATCH, libv4l]: Make libv4l2 usable on devices with complex
 pipeline
Message-ID: <20180727094708.18ef4e4e@coco.lan>
In-Reply-To: <20180708213258.GA18217@amd>
References: <20180708213258.GA18217@amd>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 8 Jul 2018 23:32:58 +0200
Pavel Machek <pavel@ucw.cz> escreveu:

> Add support for opening multiple devices in v4l2_open(), and for
> mapping controls between devices.
> 
> This is necessary for complex devices, such as Nokia N900.

Hi Pavel,

I tried to apply it here, but it seems that there are something
wrong with the patch:

$ quilt push -f --merge
Applying patch patches/lmml_50901_libv4l_make_libv4l2_usable_on_devices_with_complex_pipeline.patch
patching file lib/include/libv4l2.h
patching file lib/libv4l2/libv4l2-priv.h
patching file lib/libv4l2/libv4l2.c
Hunk #6 NOT MERGED at 1830-1857.
misordered hunks! output would be garbled
Hunk #7 FAILED at 1224.
Hunk #8 NOT MERGED at 1858-2057.
1 out of 8 hunks FAILED -- saving rejects to file lib/libv4l2/libv4l2.c.rej
patching file lib/libv4lconvert/control/libv4lcontrol.c
Applied patch patches/lmml_50901_libv4l_make_libv4l2_usable_on_devices_with_complex_pipeline.patch (forced; needs refresh)

I even tried to reset the tree to a patchset earlier than July, 8.
Same issue.

I could manually try to fix it, but that misordered hunks
warning is weird. Makes me wonder if the patch is not mangled.

Could you please re-send it on the top of upstream? Better to use
git send-email, as it won't mangle your patch.

Alternatively, please send me a ssh public key in private, and I'll
give you access to the repository where you can store those patches.

Thanks!
Mauro



Thanks,
Mauro
