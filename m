Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AEDC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7D32081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="TFukAtNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7D32081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeLKRF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:05:27 -0500
Received: from sonic302-22.consmr.mail.gq1.yahoo.com ([98.137.68.148]:34746
        "EHLO sonic302-22.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726974AbeLKRF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:05:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1544547926; bh=TYWm3AEjBX05YbZzyA7SpCwNscpZLs3ktyLNyiX0LM4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=TFukAtNPTwJZ9RTyBLm+gugXEzhIPRaFTNDpgDtZ4useP5/vW8Ur9KXsx/iMGfnehB/aldIVsWJNA1+1YPfkWdMVdu6l6gnXPld6P0ldZB+F7hSPe54kVBvGR9gIo1lmXzjuSIwPmrXcMA+kp2VZP+iN42BGgu5SdjhaaAqGBqnVHK/pRSklIfcBH6+RK8IpnQK1OT2VMDPRXIFlIcRIZ4fmSosylW2Axen8xlJFH9uhFu/rQUAPfL1h5o/a1GqFLvAOzSebI3j1fvQMfn2x/bU+qK7yNHzgS25OJiG8o6wVAXcEfUKzZwmdqqxYGEXDimvQSdHXkb26IA/3x1T95A==
X-YMail-OSG: 0A6JHsEVM1kPVYviPBv666Iz8thecQl23bnBXnwjIJItW37SY8rid8NZcvwvT8G
 nw.kPXwA7Xy0TKFbl7typuJbr9RgWKPsbl2dlRKn_wrMTtGoW8MFG8FHN8iTW899pOZoGangUjhP
 zYZ3xhtJzgOTsz.nlDO66lAk45q8OzVdMyIyhGxSX9jUEEw6nkTYCV8L4wTbWi9kW4.Q3boWcN0I
 q2gJqxQTZpP_d5N0jpPnjrj.XELyrmPR40Uq_xvAlYUCDaufFZ2EobJShiSOp1P4YB4DaaOEBLWI
 PvpyfzEUQab37E4bOcY.Ybbl2NjGl8WYrG9dEs1NaG0MFtzDQO95trr1MLrE0tQfFM6IBphYxqfE
 D7733zf6q9Wp.SvOYPIfYfx7GKQ9CEkxnmr4ShhquqJob.L0nzXXaVoAVNFVthtW8uPdIW37X5h_
 KjMqXdeIu0PCmJWI4ggEtsg6J5gCzXJ_PTf_P37pRY3IN6uL6ZCQZaiLSTh2ATZd9cGLazJZBVvw
 ZzfYmYLBzrzG2OBFgc46I9z90kci7DpnWKlpgQI.lL_Td9RKlTfcGh5cn4L5e0QpR2MpQdv.0KGT
 JJ.K3vX3ENmsYWgPi_.t2dOsSn7ygei_cLwiC6Z8ZmkEEc2fJz_eZmWyYgDE2kR95oArzKEoMQad
 QTSh3gpvb4aMO54Tr4siQydsqn6E.LbPBmNJi_zzGiYwvm0MxaGp33j0oa.QzXnI2PwY_07NWnnk
 vZPoJceRI423GbTuvPHNQttHARb_wxR8jS0uXG5AmutNjvHlbsYWUu6.Zbn9Wy0v0lBfn2cAYjAZ
 fS0PbaotEzLKR1MoX2AYpSG.AlokttaMAUnZu03QfBmTdyl5dzzljBEFmCS5rE7_dn1ueo8MHJSc
 w0tTZ4jN6Y4T594FtCqQImgXFJzIsA.qs7tkt5tyVYyspCY5is8dqr_0r2zBg0F3tt.LHg8_5mAS
 _TFTScod1ptSgYWk0wyKSbdi2l1X1SVPNy3umedoaeoUVi0rN12WhMoXjOjlE9jeehdYee9H4Igo
 WbY60CSRWBefn6uIXhrsnthns7Xwa_aNfD_T1zVF8jQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 11 Dec 2018 17:05:26 +0000
Received: from 125.120.80.114 (EHLO [10.1.1.220]) ([125.120.80.114])
          by smtp416.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6f4998f788edb517c64984697f68bd57;
          Tue, 11 Dec 2018 17:05:24 +0000 (UTC)
Subject: Re: [PATCH 4/5] drivers: staging: erofs: Fix parentheses error in
 macro
To:     Joe Perches <joe@perches.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Aaron Strahlberger <aaron.strahlberger@posteo.de>,
        devel@driverdev.osuosl.org,
        Julius Wiedmann <julius.wiedmann@fau.de>,
        linux-kernel@i4.cs.fau.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Dominik Huber <domi250@gmx.de>,
        linux-erofs@lists.ozlabs.org
References: <0ed9f3e7-9081-4a8a-06b0-e5ad14e2c872@huawei.com>
 <20181211105443.21826-1-aaron.strahlberger@posteo.de>
 <20181211105443.21826-5-aaron.strahlberger@posteo.de>
 <dc56553c-a5ea-5265-5820-4bb481b0b948@huawei.com>
 <df69ac6826a2ec20e29d1ded7a8e7ec63c73c2c4.camel@perches.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <9d324f50-e632-c020-04b9-57269ff7bdca@aol.com>
Date:   Wed, 12 Dec 2018 01:05:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <df69ac6826a2ec20e29d1ded7a8e7ec63c73c2c4.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On 2018/12/11 23:48, Joe Perches wrote:
> This macro is used only once and is merely obfuscation
> for that one use.  Please remove the macro and expand
> it in the one place it is used.

I am also considering to replace it in a plain way,
it will be more straight-forward to describe its on-disk format.

Thanks for your suggestion.

Thanks,
Gao Xiang
