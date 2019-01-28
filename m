Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A721DC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC102147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RtS6o82r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389764AbfA1QYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:24:38 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41594 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389734AbfA1QYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:24:33 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0SGOVHU122265;
        Mon, 28 Jan 2019 10:24:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548692671;
        bh=gQ2Cf4p3QPl3Nk5uJlrhoDkNy2iDoAO5We2h3hb7n88=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=RtS6o82rjALJNf8lTTXTFWQ1acDBLrWhc0t5v2U1sGsCRoI2BzjT/0gHSu+e2NOuP
         XCozlrsU89KVLrNWe+pc7hWmLYgVmF5eyQ43eZ8xr10pnaq+cv8hnp9jKQXe9ZMEOi
         KBqK45vJcGEeCxx5tT5MDn9jAI+9W+ydWFA4OHhU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0SGOGTu108104
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Jan 2019 10:24:31 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 28
 Jan 2019 09:42:42 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 28 Jan 2019 09:42:42 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0SFggXO009672;
        Mon, 28 Jan 2019 09:42:42 -0600
Date:   Mon, 28 Jan 2019 10:42:42 -0500
From:   Denys Dmytriyenko <denys@ti.com>
To:     shuah <shuah@kernel.org>
CC:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Fathi Boudra <fathi.boudra@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] selftests: lib: allow to override CC in the
 top-level Makefile
Message-ID: <20190128154242.GB15002@beryl>
References: <20190116174320.14938-1-daniel.diaz@linaro.org>
 <7d75f420-d624-d53d-4fa1-3827c90fa608@kernel.org>
 <CAEUSe7_eYmMSovO4JAabh+83CtY2L8eeMoCVKKS5P-fs7zVhjg@mail.gmail.com>
 <a68c3fdd-081a-74ea-8d98-30eaf3d70446@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a68c3fdd-081a-74ea-8d98-30eaf3d70446@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 08:01:15AM -0700, shuah wrote:
> Hi Daniel,
> 
> On 1/18/19 10:54 AM, Daniel Díaz wrote:
> >Hello!
> >
> >On Wed, 16 Jan 2019 at 15:56, shuah <shuah@kernel.org> wrote:
> >>
> >>On 1/16/19 10:43 AM, Daniel Díaz wrote:
> >>>From: Fathi Boudra <fathi.boudra@linaro.org>
> >>>
> >>>Relax CC assignment to allow to override CC in the top-level Makefile.
> >>>
> >>>Signed-off-by: Denys Dmytriyenko <denys@ti.com>

^^^ I am the original author of the patch and this is my signed-off line.


> Author signed-off missing on this patch. I am dropping this patch
> from rc5 for now. Please fix it resend the patch. In the future,
> I would like to see that author sends the patch.

-- 
Denys
