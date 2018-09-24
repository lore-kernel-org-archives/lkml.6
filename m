Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264C7C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D652420C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="c0FXU/L3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D652420C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387625AbeIXXkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:40:52 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:38342 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730027AbeIXXkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:40:51 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2EF7924E10CA;
        Mon, 24 Sep 2018 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537810657; bh=hJlkkK+h5lDIWDFE5ml6b0v6BqQa2UyMcarIF1zz6Pk=;
        h=From:To:CC:Subject:Date:References:From;
        b=c0FXU/L3Wj+TWD7n1oTSir03ZrzEODEq8m+BFj5PhnpRpTQlhwGTdcML0UMSS4FnG
         m+RTIeexFSrdoz6ZP3XP+Alo1zDnZtjkTgHTB2V31r6OsgmRwI8/d9sdTzhLrmsr03
         D86TiuZJZRSSY3Upeoloch5Mt3mK4BmpD47X3vtGuJFmWf0gnOkcr3typt7cKA0Wps
         vxOPgo1iBfkb8ZLrYYWexXuMoosLn0J8562VHHezSluQdvBAGwmQdrxB8fWjzivpqh
         Yp0U7avaXBYShI4Wcd7PFhF49wyjfb1I8HfN46awGmRQhjb2tuGiSXpPqP9pmA/nic
         fLp0r0PPKYRQA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 17C733E40;
        Mon, 24 Sep 2018 10:37:37 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 24 Sep 2018 10:37:36 -0700
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: Re: [REVIEW][PATCH 2/2] signal/arc: Use force_sig_fault where
 appropriate
Thread-Topic: [REVIEW][PATCH 2/2] signal/arc: Use force_sig_fault where
 appropriate
Thread-Index: AQHUVBXdl41WyooyzUuhJzB3fgZnTA==
Date:   Mon, 24 Sep 2018 17:37:36 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B096A98@us01wembx1.internal.synopsys.com>
References: <874lef2bqn.fsf@xmission.com>
 <20180924144910.14902-2-ebiederm@xmission.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 07:49 AM, Eric W. Biederman wrote:=0A=
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>=0A=
=0A=
Acked-by: Vineet Gupta <vgupta@synopsys.com>=0A=
=0A=
Thx,=0A=
-Vineet=0A=
