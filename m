Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E92C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41D621871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545141352;
	bh=N3I1obGHH27fjX5xqtadUKrrHTresz2/5rQCJTPSulg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=UMn7/NPa2fQSNN+m2gnlGk64Bk4LhRNMHMn9+gv4WLrJdDexGIfWmplYePHl2Z0Ky
	 yMtnCe+HvsO3+fpMkREmWnINgD/aB+wTuRYqIXhJttcGnwpu+FgXavgvyMs/RS0Ewb
	 PNWxDqN6rgCiYScUyl97/SQV3cLmRKJ6uBvXHuFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeLRNzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:55:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:46700 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726469AbeLRNzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:55:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CEF45AF67;
        Tue, 18 Dec 2018 13:55:48 +0000 (UTC)
Date:   Tue, 18 Dec 2018 14:55:48 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Peter Hutterer <peter.hutterer@who-t.net>
cc:     Benjamin Tissoires <benjamin.tissoires@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: hid: fix wrong data structure reference
 for UHID_OUTPUT
In-Reply-To: <20181213012851.GA25516@jelly>
Message-ID: <nycvar.YFH.7.76.1812181455400.17216@cbobk.fhfr.pm>
References: <20181213012851.GA25516@jelly>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018, Peter Hutterer wrote:

> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> ---
>  Documentation/hid/uhid.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/hid/uhid.txt b/Documentation/hid/uhid.txt
> index c8656dd029a9..958fff945304 100644
> --- a/Documentation/hid/uhid.txt
> +++ b/Documentation/hid/uhid.txt
> @@ -160,7 +160,7 @@ them but you should handle them according to your needs.
>    UHID_OUTPUT:
>    This is sent if the HID device driver wants to send raw data to the I/O
>    device on the interrupt channel. You should read the payload and forward it to
> -  the device. The payload is of type "struct uhid_data_req".
> +  the device. The payload is of type "struct uhid_output_req".
>    This may be received even though you haven't received UHID_OPEN, yet.

Applied, thanks Peter.

-- 
Jiri Kosina
SUSE Labs

