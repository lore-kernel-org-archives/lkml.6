Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960BBC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6535D2195D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545505674;
	bh=7nYdQEeQ5skmDRZODiPmsBs/1C33b4Lex2aWM3LXFik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ysC7llt30u25fPUQAy4qzDYCrB8eAWcQif//JkEdDswM8c28V9cc3A2baqQzhDcvo
	 bcMGW3K7YRIWB3t2ZPatLyWOjYTidlcF6W7BOgwLbYHIa406r/xDnbDOpqR5M0UzkR
	 P9+PvhxpuqvGtJ5zKeVvlX9Z0USQ7kXWWKUq2ol8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389723AbeLVTHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 14:07:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:41370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731157AbeLVTHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 14:07:51 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19FA32195D;
        Sat, 22 Dec 2018 19:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545505671;
        bh=7nYdQEeQ5skmDRZODiPmsBs/1C33b4Lex2aWM3LXFik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XcS2ZlH/pNsGXaDhkFO6BYkNR5U7me+YL7qkKdLK37bCsClBtZhpnfnHngFsuLZKa
         jLYtg+D4jLgbcGfRWAnmMz7BBYrGP9dntkEM7I7eywypm4vxdT+W49Ocj4l8HbleEN
         Qh4MGLhwJPFUjfqrDpKT7hGcXogrhnJZFKYF0wGI=
Date:   Sat, 22 Dec 2018 14:07:50 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     "Greensky, James J" <james.j.greensky@intel.com>
Cc:     Jinpu Wang <jinpuwang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v3.14+, only the raid10 part" <stable@vger.kernel.org>
Subject: Re: Fix "perf tools: Synthesize GROUP_DESC feature in pipe mode" in
 the LT 4.14 branch
Message-ID: <20181222190750.GP86645@sasha-vm>
References: <05BD5679F4A9234798A0693ABF94E75ADFF7F3A5@ORSMSX101.amr.corp.intel.com>
 <CAD9gYJKvcn5kzMKhHU2UO=99Vdus_v=5D-fZb6-+Fy=gDokZFA@mail.gmail.com>
 <05BD5679F4A9234798A0693ABF94E75ADFF7FA54@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <05BD5679F4A9234798A0693ABF94E75ADFF7FA54@ORSMSX101.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 10:43:09PM +0000, Greensky, James J wrote:
>This commit does not apply cleanly due to other changes. Is there something I can do to make it easier.
>
>This line:
>	If (data->is_pipe)  {
>Must be changed to:
>	If (file->is_pipe) {

Indeed, I've resolved it the same.

>Let me know if there is a more standard way of communicating cherry-picked changes for inclusion.

Sending a mail to stable@vger.kernel.org is pretty much the standard
way.

--
Thanks,
Sasha
